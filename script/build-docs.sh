#!/usr/bin/env bash
# Build the IntelliJ SDK docs with the Writerside Docker builder, publish the
# result into this repo, and commit it.
# https://www.jetbrains.com/help/writerside/build-with-docker.html
#
# Runs on kit, where both the Docker daemon and the sources live.
#
#   ./script/build-docs.sh [sources-dir]
#
# sources-dir defaults to SRC below. Options:
#   NO_COMMIT=1   publish into the repo but leave the changes uncommitted
#   NO_PUBLISH=1  build only; leave output in <sources>/build, touch nothing
set -euo pipefail

BUILDER_TAG="${BUILDER_TAG:-2026.06.8817}"
IMAGE="jetbrains/writerside-builder:${BUILDER_TAG}"

# Module name from writerside.cfg: <module name="intellij-sdk"/>
# Product id is the instance-profile id in ijs.tree (<instance-profile id="ijs">),
# NOT the id="intellij" on <instance> in writerside.cfg -- that one is the web path.
# Using "intellij" fails with: Cannot find product "intellij" in module "intellij-sdk".
INSTANCE="${INSTANCE:-intellij-sdk/ijs}"

SRC="${1:-/home/josh/dev/plugins/intellij-sdk-docs}"
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

[[ -f "$SRC/writerside.cfg" ]] || {
  echo "ERROR: no writerside.cfg in $SRC" >&2; exit 1; }
SRC="$(cd "$SRC" && pwd)"

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

if [[ -n "${NO_PUBLISH:-}" ]]; then
  echo "==> NO_PUBLISH set, leaving output in $SITE_DIR"
  exit 0
fi

# ------------------------------------------------------------------- publish
# Repo layout: html/ + _llms/ + llms.txt + misc/ (metadata). --delete so pages
# removed upstream also disappear here.
echo "==> Publishing into $REPO"
mkdir -p "$REPO/html" "$REPO/_llms" "$REPO/misc"

rsync -a --delete --include '*.html' --exclude '*' "$SITE_DIR/" "$REPO/html/"
rsync -a --delete "$SITE_DIR/_llms/" "$REPO/_llms/"
cp "$SITE_DIR/llms.txt" "$REPO/llms.txt"

for f in config.json HelpTOC.json Map.jhm sitemap.xml current.help.version \
         api-object-digest.json starting-page-*.json; do
  cp "$SITE_DIR"/$f "$REPO/misc/" 2>/dev/null || true
done

echo "    html:  $(ls "$REPO/html" | wc -l)"
echo "    _llms: $(ls "$REPO/_llms" | wc -l)"
echo "    misc:  $(ls "$REPO/misc" | wc -l)"

# -------------------------------------------------------------------- commit
cd "$REPO"
if [[ -n "$(git status --porcelain)" ]]; then
  if [[ -n "${NO_COMMIT:-}" ]]; then
    echo "==> NO_COMMIT set, leaving $(git status --porcelain | wc -l) changes staged-free"
    exit 0
  fi
  git add -A
  # commit.gpgsign is on for this repo, so the commit needs a TTY for the
  # passphrase prompt. Run this script from a real terminal on kit (or over
  # `ssh -t`); a plain non-interactive `ssh josh '...'` fails with
  # "gpg: signing failed: Inappropriate ioctl for device".
  git commit -q -m "Rebuild docs (writerside-builder ${BUILDER_TAG})"
  echo "==> Committed: $(git log --oneline -1)"
else
  echo "==> No changes to commit"
fi
