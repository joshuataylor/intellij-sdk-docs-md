# Configuring a Plugin for Split Mode

Split Mode configuration in the Gradle build script allows for running development sandbox IDEs in mode emulating the [remote development](split-mode-and-remote-development.html) scenario, with both frontend and backend processes running locally.
To make a plugin work natively in split mode, see [plugin modularization](modular-plugins.html).

## Basic Configuration

Warning:

Split Mode requires [IntelliJ Platform Gradle Plugin 2.x](tools-intellij-platform-gradle-plugin.html).

Enable Split Mode in the `intellijPlatform {}` extension:

```KOTLIN
intellijPlatform {
  splitMode = true
  pluginInstallationTarget = SplitModeAware.PluginInstallationTarget.BOTH
}
```

The two relevant properties are:

* [splitMode](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-splitMode) – starts separate frontend and backend processes

* [pluginInstallationTarget](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginInstallationTarget) – selects where the plugin is installed

## Choosing the Installation Target

Choose `pluginInstallationTarget` according to the code being exercised:

* `BACKEND` for backend-only functionality

* `FRONTEND` for frontend-only functionality

* `BOTH` for typical modular plugins that contain frontend, backend, and shared modules

For split plugin development, `BOTH` is the most common choice.

Note:

`pluginInstallationTarget` only controls where the plugin is placed in locally run development sandboxes.
It doesn't describe end-user installation or synchronization behavior in split mode.
See [Plugin Management](plugin-management-in-split-mode.html).

## Custom Run and Test Tasks

Custom split-mode tasks can be declared with `intellijPlatformTesting`:

```KOTLIN
val runIdeSplitMode by intellijPlatformTesting.runIde.registering {
  splitMode = true
  pluginInstallationTarget = SplitModeAware.PluginInstallationTarget.BOTH
}

val testIdeUiSplitMode by intellijPlatformTesting.testIdeUi.registering {
  splitMode = true
  pluginInstallationTarget = SplitModeAware.PluginInstallationTarget.BOTH
}
```

These tasks get dedicated sandboxes and can be used like other development or test tasks.
See [IntelliJ Platform Testing Extension](tools-intellij-platform-gradle-plugin-testing-extension.html) for more details.

## Configuring Debug and Trace Logs

Starting with IntelliJ Platform Gradle Plugin 2.15.0, Split Mode provides dedicated `runIdeBackend` and `runIdeFrontend` tasks, so additional log categories can be enabled separately for each process.

```KOTLIN
tasks {
  // Set up the additional debug/trace log categories if needed.
  runIdeBackend {
    systemProperty("idea.log.debug.categories", "com.example.plugin.backend")
  }
  runIdeFrontend {
    systemProperty("idea.log.trace.categories", "com.example.plugin.frontend")
  }
}
```

Set `idea.log.debug.categories` or `idea.log.trace.categories` to the package or logger category names that should be enabled in the corresponding IDE process.
Use a comma-separated list to enable multiple categories.
If needed, either property can be applied to either task.

## Typical Next Step

After the Gradle configuration is in place, the next step is deciding how the plugin code should be distributed between frontend, backend, and shared modules.
See [Implementing a Feature for Split Mode](split-mode-feature-development.html).

## Required Gradle Plugin and Library Versions

The following tables list recommended versions of Gradle plugins and libraries for split mode development, tailored for compatibility with the specified IntelliJ Platform versions.

### Gradle Plugins

| IntelliJ Platform |`rpc` |`org.jetbrains.kotlin.plugin.serialization` |
| 2026.1 |2.3.20-RC2-0.1 |2.3.20 |
| 2025.3 |2.1.20-0.1 |2.1.20 |

### Libraries

| IntelliJ Platform |`kotlinx-serialization-core-jvm` |`kotlinx-serialization-json-jvm` |
| 2026.1 |1.9.0 |1.9.0 |
| 2025.3 |1.7.3 |1.7.3 |

