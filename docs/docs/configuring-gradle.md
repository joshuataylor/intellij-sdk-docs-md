# Configuring IntelliJ Platform Gradle Plugin

This section presents a short overview of the most important Gradle plugin configuration elements to achieve commonly desired functionality.

For more advanced options and topics, see:

* [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html) reference

* [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html)

* [Recipes](tools-intellij-platform-gradle-plugin-recipes.html)

* [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html)

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

## Keep Up To Date

IntelliJ Platform Gradle Plugin (2.x) and [Gradle](https://gradle.org/install/) build system are constantly developed, and every new release
brings important bug fixes, new features, and improvements that make the development more efficient.

It is strongly recommended to keep updating both Gradle and IntelliJ Platform Gradle Plugin to the latest versions.
Newer IDE releases might not be supported fully in older releases of the IntelliJ Platform Gradle Plugin.

Note:

The current IntelliJ Platform Gradle Plugin (2.x) version is 2.18.1

## Setup

See [Configuration](tools-intellij-platform-gradle-plugin.html#configuration) for the necessary declaration of repositories.

## Target Platform and Dependencies

Tip:

Which versions should your plugin support? We've collected some insights based on download statistics in [Statistics: Product Versions in Use](https://plugins.jetbrains.com/docs/marketplace/product-versions-in-use-statistics.html).

If a matching version of the specified IntelliJ Platform is not present on the local machine, the Gradle plugin will download it.
IntelliJ IDEA then indexes the build and any associated source code and [JetBrains Java Runtime](tools-intellij-platform-gradle-plugin-jetbrains-runtime.html).

To build a plugin for more than one target platform version, see [Targeting Multiple IDE Versions](build-number-ranges.html#multipleIDEVersions) for important notes.

### IntelliJ Platform Configuration

The target IDE platform is set in the `dependencies {}` block,
see [Setting Up IntelliJ Platform](tools-intellij-platform-gradle-plugin.html#setting-up-intellij-platform) for a minimal sample.

[Target Platforms](tools-intellij-platform-gradle-plugin-dependencies-extension.html#target-platforms) lists all available extension functions for known target IDE platforms.

### Plugin Dependencies

IntelliJ Platform plugin projects may depend on either bundled or third-party plugins defined in the `dependencies {}` block,
see [Plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) for details.

The runtime dependency must be added in the [Plugin Configuration](plugin-configuration-file.html) (`plugin.xml`) file as described in
[Plugin Dependencies](plugin-dependencies.html#dependency-declaration-in-pluginxml).

## Run IDE Task

By default, the [runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde) task will use the same version of the IntelliJ Platform
for the IDE Development instance as was used for building the plugin.

## Verifying Plugin

The following tasks allow running integrity and compatibility tests:

* [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin) - runs the [Plugin Verifier](verifying-plugin-compatibility.html#plugin-verifier) tool to check the binary compatibility with the specified IDE builds

* [verifyPluginStructure](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginStructure) — validates completeness and contents of [plugin.xml descriptors](plugin-configuration-file.html) as well as the plugin's archive structure

* [verifyPluginProjectConfiguration](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginProjectConfiguration) — validates the plugin project configuration

## Publishing Plugin

Review the [Publishing a Plugin](publishing-plugin.html) page before using the [publishPlugin](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin) task.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

