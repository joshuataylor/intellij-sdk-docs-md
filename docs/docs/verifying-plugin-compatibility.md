# Verifying Plugin Compatibility

See [Incompatible Changes in IntelliJ Platform and Plugins API](api-changes-list.html) for known breaking changes.

For API annotated with [@ApiStatus.Internal](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java), see [Internal API Migration](api-internal.html) for more details and replacements.

See also [Targeting Multiple IDE Versions](build-number-ranges.html#multipleIDEVersions).

## Plugin Verifier

<tldr>
Current Release: 1.410

GitHub: [Releases &amp; Changelog](https://github.com/JetBrains/intellij-plugin-verifier/releases), [Issue Tracker](https://youtrack.jetbrains.com/issues/MP?q=%23%7BPlugin%20Verifier%7D%20)

JetBrains Platform Forum: [Plugin Verifier](https://platform.jetbrains.com/c/intellij-platform/plugin-verifier/7) category
</tldr>

Plugin Verifier checks the binary compatibility between IntelliJ-based IDE builds and IntelliJ Platform plugins.

### Using with Gradle

Integration in [Gradle build](creating-plugin-project.html) is available out-of-the box via a dedicated Gradle task.

IntelliJ Platform Gradle Plugin (2.x):

Use [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin) task.

Gradle IntelliJ Plugin (1.x):

Use [runPluginVerifier](tools-gradle-intellij-plugin.html#tasks-runpluginverifier) task.

Integration with Continuous Integration (CI) environments is as simple as running the corresponding Gradle task as another quality check step.
See the IntelliJ Platform Plugin Template [GitHub workflow configuration file](https://github.com/JetBrains/intellij-platform-plugin-template/blob/main/.github/workflows/build.yml) as a reference.

#### Navigation in the IDE

Reported places are highlighted and linked to the plugin's source code in the Gradle tool window output.

### JetBrains Marketplace

Compatibility with newer IDEs can easily be verified for plugins hosted on the [JetBrains Marketplace](https://plugins.jetbrains.com) using the built-in [Plugin Verifier](https://blog.jetbrains.com/platform/2018/07/plugins-repository-now-integrates-with-the-plugin-verification-tool/).

### Other Usages

If a plugin is hosted on GitHub and the project is not using Gradle, consider using third-party GitHub Actions [IntelliJ Platform Plugin Verifier](https://github.com/marketplace/actions/intellij-platform-plugin-verifier) or [IntelliJ Plugin Verifier](https://github.com/marketplace/actions/intellij-plugin-verifier).

In all other cases, [intellij-plugin-verifier](https://github.com/JetBrains/intellij-plugin-verifier) can be used standalone as well.

## IDE Support

The status of an API is marked using various annotations defined in [ApiStatus](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java), please see their doc for more details.
Use highlighting available via dedicated [IDE inspections](https://www.jetbrains.com/help/idea/code-inspection.html) as noted below to prevent problems as early as possible.

### Unstable API

* `@ApiStatus.Experimental` is considered unstable and may break or be removed.

* `@ApiStatus.Internal` must not be used by plugins, see [Internal API Migration](api-internal.html) for more details and replacements.

* `@ApiStatus.ScheduledForRemoval` denotes an API that will be removed in a future version.

Inspection: JVM languages | Unstable API Usage and JVM languages | Unstable type is used in signature

### Obsolete API

API annotated with `@ApiStatus.Obsolete` has been replaced with a better alternative and must not be used for new code.

Inspection: Plugin DevKit | Code | Usages of ApiStatus.@Obsolete

### Non-Extendable API

API annotated with `@ApiStatus.NonExtendable` must not be extended, implemented, or overridden.

Inspection: JVM languages | Class, interface, or method should not be extended

### Override-Only API

API annotated with `@ApiStatus.OverrideOnly` must not be called directly by the client.

Inspection: JVM languages | Method can only be overridden

### plugin.xml

Usage of [Extension Points](plugin-extensions.html) which are deprecated or annotated with `@ApiStatus.Experimental` or `@ApiStatus.Internal` is also highlighted in `[plugin.xml](plugin-configuration-file.html)` files.

Inspection: Plugin DevKit | Plugin descriptor | Plugin.xml validity

### API Compatibility

A plugin might specify a [compatibility range](build-number-ranges.html) including releases where some API is not available.
Under the hood, it uses an artifact containing generated data via `@ApiStatus.AvailableSince`, which is automatically attached to the project.

Inspection: Plugin DevKit | Code | Usage of IntelliJ API not available in older IDEs

Tip:

If values are not specified directly in [plugin.xml](plugin-configuration-file.html) (e.g., when providing values via `patchPluginXml` Gradle task (Reference: [2.x](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml), [1.x](tools-gradle-intellij-plugin.html#tasks-patchpluginxml))), they must be set explicitly in the inspection's settings.

