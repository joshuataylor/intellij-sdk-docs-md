# Notable Changes in IntelliJ Platform and Plugins API 2023.*

Early Access Program (EAP) releases of upcoming versions are available [here](https://eap.jetbrains.com).

Warning: Gradle Plugin

The Gradle plugin must be chosen depending on the target
[platform version](build-number-ranges.html#platformVersions).

2024.2+
: Requires
[IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html)

2022.3+
: Recommended
[IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html)
: Requires
[Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html)
(Obsolete)
1.10.1+

## 2023.3

### IntelliJ Platform 2023.3

Threading Model changes
: Please see updated [Threading Model](threading-model.html).

External Annotators in Dumb Mode
: [External Annotator](syntax-highlighting-and-error-highlighting.html#external-annotator) can now run in during indexing.

Local inspections performance
: Custom language plugins with many inspections should consider registering a default visitor to improve processing, see [Inspections Performance](code-inspections-and-intentions.html#inspections-performance).

### IntelliJ IDEA 2023.3

Unbundled plugins
: Several plugins (Android, Ant, GlassFish, Plugin DevKit) have been unbundled. The IDE will suggest installation if the project contains related framework dependency. If your plugin depends on them, users will need to install them from the [JetBrains Marketplace](https://plugins.jetbrains.com).

## 2023.2

### IntelliJ Platform 2023.2

Language Server Protocol (LSP) API
: Provide custom language support by using language servers, see [Language Server Protocol (LSP)](language-server-protocol.html).

Check presence of JVM library
: Use [dedicated API](psi-cookbook.html#how-do-i-check-the-presence-of-a-jvm-library) to check presence via class FQN or Maven coordinates.

Inspection description: code snippets highlighting
: Embedded code is shown with [syntax highlighting](code-inspections.html#code-snippets).

Intentions that cannot show meaningful before/after preview
: Intentions not modifying code can specify `<skipBeforeAfter>true</skipBeforeAfter>` in their registration.

JCEF-based SVG viewer
: SVG pictures are now shown using [JCEF](embedded-browser-jcef.html) instead of rendering via the Apache Batik library ([Details](https://youtrack.jetbrains.com/issue/IDEA-230850)).

### IntelliJ IDEA 2023.2

Unbundled plugins
: Several plugins (Play 1, Resin, Struts 2, tcServer) have been unbundled. The IDE will suggest installation if the project contains related framework dependency. If your plugin depends on them, users will need to install them from the [JetBrains Marketplace](https://plugins.jetbrains.com).

## 2023.1

API for quick documentation
: [Documentation](documentation.html) for custom languages is provided through the
[DocumentationTarget](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-impl/src/com/intellij/platform/backend/documentation/DocumentationTarget.kt)
API for versions 2023.1 or later.

### IntelliJ Platform 2023.1

Declarative Inspection Options
: [Code inspections](code-inspections.html) can provide additional options in a [declarative](inspection-options.html#declarative-inspection-options) way which has several benefits over the [UI-based](inspection-options.html#ui-based-inspection-options) approach.

Nested Index Access
: Accessing index data in [nested calls](file-based-indexes.html#nested-index-access) is now possible.
NOTE: Please do not use yet This is known to cause problems under certain conditions, please watch this [issue](https://youtrack.jetbrains.com/issue/IJPL-265/Nested-index-lookups-still-leads-to-deadlocks).

File Type Index Topic
: [FileTypeIndex.IndexChangeListener](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/indexing-api/src/com/intellij/psi/search/FileTypeIndex.java) allows monitoring the addition/removal of files by `FileType`.

Run Annotator During Indexing
: [Annotators](syntax-highlighting-and-error-highlighting.html#annotator) can implement `DumbAware` to run during indexing (e.g., providing additional syntax highlighting).

Obsolete API Status
: Newly introduced `@ApiStatus.Obsolete` marks API that should not be used for new code, see [Obsolete API](verifying-plugin-compatibility.html#obsolete-api).

