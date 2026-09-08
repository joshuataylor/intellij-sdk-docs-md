#!/usr/bin/env bash
# Build the IntelliJ SDK docs with the Writerside Docker builder, publish the
# HTML + llms text into this repo, and commit it.
# https://www.jetbrains.com/help/writerside/build-with-docker.html
#
#   ./script/build-docs.sh              # clone/update upstream, build, publish, commit
#   ./script/build-docs.sh /path/to/src # build an existing checkout instead
#
# Options:
#   FORCE=1       build even when upstream has not moved since the last sync
#   NO_COMMIT=1   publish into the repo but leave the changes uncommitted
#   NO_PUBLISH=1  build only; leave output under <src>/build, touch nothing
#
# Requires docker, git, rsync and unzip. Runs anywhere the Docker daemon and the
# sources share a filesystem -- note that `-v` paths resolve on the DAEMON host,
# so pointing DOCKER_HOST/context at a remote machine will silently mount an
# empty directory and the builder fails with: Open solution: "sources", 0 modules.
set -euo pipefail

for tool in docker git rsync unzip; do
  command -v "$tool" >/dev/null || { echo "ERROR: required tool not found: $tool" >&2; exit 1; }
done

BUILDER_TAG="${BUILDER_TAG:-2026.06.8817}"
IMAGE="jetbrains/writerside-builder:${BUILDER_TAG}"

# Module name from writerside.cfg: <module name="intellij-sdk"/>
# Product id is the instance-profile id in ijs.tree (<instance-profile id="ijs">),
# NOT the id="intellij" on <instance> in writerside.cfg -- that one is the web path.
# Using "intellij" fails with: Cannot find product "intellij" in module "intellij-sdk".
INSTANCE="${INSTANCE:-intellij-sdk/ijs}"

UPSTREAM_REMOTE="${UPSTREAM_REMOTE:-https://github.com/JetBrains/intellij-sdk-docs.git}"
UPSTREAM_REF="${UPSTREAM_REF:-main}"

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PUB="$REPO/docs"                 # published output lives under docs/
SHA_FILE="$PUB/.upstream-sha"
NOTES="${NOTES:-$REPO/.upstream-changes.txt}"

# With no argument, manage our own clone under .upstream (gitignored).
SRC="${1:-}"
MANAGED=""
if [[ -z "$SRC" ]]; then
  SRC="${CLONE_DIR:-$REPO/.upstream}"
  MANAGED=1
fi

last_sha="$(cat "$SHA_FILE" 2>/dev/null || true)"

if [[ -n "$MANAGED" ]]; then
  # A full clone is deliberate: Writerside derives each page's "last modified"
  # date from git history, so a --depth 1 clone would stamp every page with the
  # same date. Keep the clone around and fetch into it on later runs.
  if [[ -d "$SRC/.git" ]]; then
    echo "==> Updating $SRC"
    git -C "$SRC" fetch --quiet origin "$UPSTREAM_REF"
    git -C "$SRC" reset --hard --quiet FETCH_HEAD
    git -C "$SRC" clean -fdq
  else
    echo "==> Cloning $UPSTREAM_REMOTE"
    git clone --quiet --branch "$UPSTREAM_REF" "$UPSTREAM_REMOTE" "$SRC"
  fi
fi

[[ -f "$SRC/writerside.cfg" ]] || {
  echo "ERROR: no writerside.cfg in $SRC" >&2; exit 1; }
SRC="$(cd "$SRC" && pwd)"

upstream_sha=""
if [[ -d "$SRC/.git" ]]; then
  upstream_sha="$(git -C "$SRC" rev-parse HEAD)"
  last_short="<none>"
  [[ -n "$last_sha" ]] && last_short="${last_sha:0:9}"
  echo "    upstream: ${upstream_sha:0:9}  (last synced: $last_short)"
fi

# Every build regenerates element ids and the built-on timestamp, so a rebuild
# always produces a diff. Skip unchanged upstream to avoid hourly commit noise.
if [[ -z "${FORCE:-}" && -n "$upstream_sha" && "$upstream_sha" == "$last_sha" ]]; then
  echo "==> Upstream unchanged, nothing to do (FORCE=1 to rebuild anyway)"
  exit 0
fi

# Commit body: what moved upstream since the last sync.
{
  if [[ -z "$upstream_sha" ]]; then
    echo "(sources not a git checkout -- no upstream commit range)"
  elif [[ -z "$last_sha" ]]; then
    echo "No recorded baseline -- latest 20 upstream commits:"
    echo
    git -C "$SRC" log --no-merges --max-count=20 --pretty=format:'- %h %s' "$upstream_sha"
    echo
  elif [[ "$last_sha" == "$upstream_sha" ]]; then
    echo "(no new upstream commits -- forced rebuild)"
  else
    echo "Upstream changes since ${last_sha:0:9}:"
    echo
    git -C "$SRC" log --no-merges --pretty=format:'- %h %s' "${last_sha}..${upstream_sha}"
    echo
  fi
} > "$NOTES"

OUT_DIR="$SRC/build/artifacts"
SITE_DIR="$SRC/build/site"
mkdir -p "$SRC/build"
rm -rf "$SITE_DIR"

# The builder runs as root, so its artifacts are root-owned and a plain rm from
# this user fails with Permission denied. Clear them as root in a throwaway
# container using the image we already have.
if [[ -d "$OUT_DIR" ]]; then
  docker run --rm -v "$SRC/build:/work" --entrypoint /bin/bash "$IMAGE" \
    -c 'rm -rf /work/artifacts'
fi

echo "==> Building $INSTANCE from $SRC"
# OUTPUT_DIR must NOT be its own bind mount: the builder recreates that directory
# and fails on a mount point with "/opt/output: Device or resource busy".
# Writing into a subdirectory of the sources mount avoids this.
docker run --rm \
  -v "$SRC:/opt/sources" \
  -e SOURCE_DIR=/opt/sources \
  -e MODULE_INSTANCE="$INSTANCE" \
  -e OUTPUT_DIR=/opt/sources/build/artifacts \
  -e RUNNER=other \
  "$IMAGE"

# RUNNER=other emits webHelp<ID>2.zip; other runners emit webHelp<ID>2-all.zip.
ID_UPPER="$(echo "${INSTANCE##*/}" | tr '[:lower:]' '[:upper:]')"
SITE_ZIP=""
for candidate in "$OUT_DIR/webHelp${ID_UPPER}2-all.zip" "$OUT_DIR/webHelp${ID_UPPER}2.zip"; do
  [[ -f "$candidate" ]] && { SITE_ZIP="$candidate"; break; }
done
[[ -n "$SITE_ZIP" ]] || {
  echo "ERROR: no webHelp archive in $OUT_DIR" >&2; ls -la "$OUT_DIR" >&2; exit 1; }

# Only the HTML pages, the generated llms text and the metadata are wanted --
# the repo tracks no images, so webHelpImages.zip is deliberately left alone.
echo "==> Unpacking $(basename "$SITE_ZIP")"
unzip -q "$SITE_ZIP" -d "$SITE_DIR"
echo "    site: $(find "$SITE_DIR" -type f | wc -l) files"

# Writerside emits client-side redirect stubs (a tiny page that meta-refreshes
# to the canonical URL) for renamed/re-cased topics. They are useless in this
# static mirror, and one of them (...-CONTRIBUTING.html) differs only in case
# from its target (...-contributing.html), so a clone on a case-insensitive
# filesystem (macOS, Windows) collides and lands dirty. Drop them all before
# publishing -- they are identified by the stub page title.
pruned=0
while IFS= read -r -d '' f; do
  rm -f "$f"; pruned=$((pruned + 1))
done < <(grep -rlZ --include='*.html' 'You will be redirected shortly' "$SITE_DIR" || true)
echo "    pruned $pruned redirect stubs"

if [[ -n "${NO_PUBLISH:-}" ]]; then
  echo "==> NO_PUBLISH set, leaving output in $SITE_DIR"
  exit 0
fi

# A degraded build can still emit a valid zip (e.g. zero topics), and the
# --delete rsyncs below would then wipe docs/ and auto-commit an empty repo.
# Refuse to publish anything implausibly small. MIN_HTML overrides the floor
# (current output is ~476 pages); a legitimate large upstream removal that trips
# this can be forced through with a higher MIN_HTML.
html_count="$(find "$SITE_DIR" -maxdepth 1 -name '*.html' -type f | wc -l)"
llms_count="$(find "$SITE_DIR/_llms" -name '*.txt' -type f 2>/dev/null | wc -l)"
if (( html_count < ${MIN_HTML:-200} || llms_count < 1 )); then
  echo "ERROR: site looks degraded (html=$html_count, llms=$llms_count) -- refusing" \
       "to publish over docs/. Set MIN_HTML=<n> to override." >&2
  exit 1
fi

# ------------------------------------------------------------------- publish
# Repo layout, all under docs/:
#   docs/html/     generated site
#   docs/docs/     per-topic llms text, tracked as .md (builder emits _llms/*.txt)
#   docs/llms.txt  single-file index
#   docs/misc/     metadata (TOC, sitemap, ...)
# --delete so pages removed upstream also disappear here.
echo "==> Publishing into $PUB"
mkdir -p "$PUB/html" "$PUB/docs" "$PUB/misc"

rsync -a --delete --include '*.html' --exclude '*' "$SITE_DIR/" "$PUB/html/"

# Stage renamed copies so rsync --delete can still drop topics that went away
# upstream; renaming in place after the sync would defeat that.
RENAMED="$SITE_DIR/_llms_md"
rm -rf "$RENAMED"; mkdir -p "$RENAMED"
for f in "$SITE_DIR"/_llms/*.txt; do
  cp "$f" "$RENAMED/$(basename "$f" .txt).md"
done
rsync -a --delete "$RENAMED/" "$PUB/docs/"

cp "$SITE_DIR/llms.txt" "$PUB/llms.txt"

# misc/ is a fixed cp list with no rsync --delete, so clear it first -- otherwise
# a file upstream stopped emitting (e.g. a renamed starting-page-*.json) lingers
# forever. It is repopulated immediately below.
rm -f "$PUB"/misc/*
for f in config.json HelpTOC.json Map.jhm sitemap.xml current.help.version \
         api-object-digest.json starting-page-*.json; do
  cp "$SITE_DIR"/$f "$PUB/misc/" 2>/dev/null || true
done

[[ -n "$upstream_sha" ]] && echo "$upstream_sha" > "$SHA_FILE"

echo "    html: $(ls "$PUB/html" | wc -l)"
echo "    docs: $(ls "$PUB/docs" | wc -l)"
echo "    misc: $(ls "$PUB/misc" | wc -l)"

# -------------------------------------------------------------------- commit
# Stage only generated output; the build writes nothing outside docs/, and
# scoping here keeps an unrelated stray change in the checkout out of the
# "Rebuild docs" commit. Scratch files (.upstream-changes.txt, ...) are gitignored.
cd "$REPO"
git add -A -- docs/
if git diff --cached --quiet; then
  echo "==> No changes to commit"
  exit 0
fi

if [[ -n "${NO_COMMIT:-}" ]]; then
  echo "==> NO_COMMIT set, $(git diff --cached --name-only | wc -l) files staged"
  exit 0
fi

{
  echo "Rebuild docs as of $(TZ=UTC date +'%Y-%m-%d %H:%M:%S UTC')"
  echo
  echo "writerside-builder: $BUILDER_TAG"
  [[ -n "$upstream_sha" ]] && echo "upstream: ${upstream_sha:0:9}"
  echo
  cat "$NOTES"
} > "$REPO/.commit-message.txt"

# commit.gpgsign is on for this repo, so an interactive run needs a TTY for the
# passphrase prompt. A non-interactive `ssh host '...'` fails with
# "gpg: signing failed: Inappropriate ioctl for device" -- use `ssh -t`.
git commit -q -F "$REPO/.commit-message.txt"
rm -f "$REPO/.commit-message.txt" "$NOTES"
echo "==> Committed: $(git log --oneline -1)"
