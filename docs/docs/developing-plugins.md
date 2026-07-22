# Introduction to Plugin Development

Note: Plugin Alternatives

In some cases, implementing an actual IntelliJ Platform plugin might not be necessary, as [alternative solutions](plugin-alternatives.html) exist.

IntelliJ Platform plugins can be developed by using [IntelliJ IDEA](https://www.jetbrains.com/idea/download/) with the [Plugin DevKit](https://plugins.jetbrains.com/plugin/22851-plugin-devkit) plugin installed.
It is highly recommended to always use the latest available version of the IDE and Plugin DevKit, as the plugin development tooling is constantly improved.

Before starting with the actual development, make sure to understand all requirements to achieve best [Plugin User Experience (UX)](plugin-user-experience.html).

## Gradle Build System

The recommended solution for building IntelliJ Platform plugins is using the [Gradle build system](https://www.gradle.org) with a dedicated Gradle plugin:
[IntelliJ Platform Gradle Plugin](tools-intellij-platform-gradle-plugin.html).

The IntelliJ IDEA provides the necessary plugins to support Gradle-based plugin development: Gradle and Plugin DevKit.
To verify these plugins are installed and enabled, see the [Install plugins](https://www.jetbrains.com/help/idea/managing-plugins.html) help section.

### IntelliJ Platform Gradle Plugin

IntelliJ Platform Gradle Plugin manages the dependencies of a plugin project – both the base IDE and other [plugin dependencies](plugin-dependencies.html).
It provides tasks to run the IDE with the plugin and to package and [publish](publishing-plugin.html#publishing-plugin-with-gradle) it to the [JetBrains Marketplace](https://plugins.jetbrains.com).
It allows verifying that the plugin is not affected by [API changes](api-changes-list.html) and is backward compatible.

### Alternatives to Gradle

The old DevKit project model and workflow are still supported in existing projects and are recommended for [creating theme plugins](developing-themes.html).
See how to [migrate a DevKit plugin to Gradle](migrating-plugin-devkit-to-gradle.html).

A dedicated [SBT plugin](https://github.com/JetBrains/sbt-idea-plugin) is available for plugins implemented in Scala.

## Plugin Development Workflow

* [Creating a Plugin Project](creating-plugin-project.html)

* [Configuring IntelliJ Platform Gradle Plugin](configuring-gradle.html) (optional)

* [Configuring a Plugin for Split Mode](configuring-split-mode.html) (optional)

* [Configuring Kotlin Support](using-kotlin.html) (optional)

* [Plugin Signing](plugin-signing.html)

* [Publishing a Plugin](publishing-plugin.html)

