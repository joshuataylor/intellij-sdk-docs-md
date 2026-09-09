# IntelliJ Platform Testing Extension

Tip: FAQ

See [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html) and [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html).

The IntelliJ Platform Gradle Plugin introduces a top-level `intellijPlatformTesting` extension.
It provides a possibility for registering custom tasks for running the IDE, unit tests, UI tests, or performance tests.

For each of the custom tasks, a dedicated sandbox is created to isolate them from other tasks or the build flow as they may rely on a different IntelliJ Platform version, plugins, or other configuration.

## IntelliJ Platform Testing

After the IntelliJ Platform Gradle Plugin is [applied](tools-intellij-platform-gradle-plugin.html#setup), the `intellijPlatformTesting` extension can be used for registering new tasks to fulfil specific requirements of the project.

The extension exposes four `NamedDomainObjectContainers` which allow for creating new objects of given types.
Registering of a custom task which allows for adjusting the IntelliJ Platform type and version can be done by using one of the below containers, depending on the task purpose.

Example:

Kotlin:

```KOTLIN
intellijPlatformTesting {
  runIde
  testIde
  testIdeUi
  testIdePerformance
}
```

Groovy:

```GROOVY
intellijPlatformTesting {
  runIde
  testIde
  testIdeUi
  testIdePerformance
}
```

By default, created tasks depend on the IntelliJ Platform defined with [Dependencies Extension](tools-intellij-platform-gradle-plugin-dependencies-extension.html).
However, it is possible to adjust it to any requirements with passing custom values directly to the created object, `task`, or `sandboxTask` task instances.

Each registered entry extends the IntelliJ Platform dependency configuration model, so properties like `type`, `version`, `productMode`, `useInstaller`, `useCache`, and `localPath` can be configured directly on the created object.
The `version` accepts `"latest"` (or `Constraints.LATEST_VERSION`) to resolve the [newest available installer release](tools-intellij-platform-gradle-plugin-dependencies-extension.html#target-versions-latest) for the configured `type`.

In projects using the [Module](tools-intellij-platform-gradle-plugin-plugins.html#module) plugin, this extension can register custom `testIde` tasks only.
Register custom `runIde`, `testIdeUi`, and `testIdePerformance` tasks in the root project using the [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform) plugin.

Example:

Kotlin:

```KOTLIN
val runPhpStorm by intellijPlatformTesting.runIde.registering {
  type = IntelliJPlatformType.PhpStorm
  version = ...
  useInstaller = ...
  localPath = ...

  sandboxDirectory = ...

  splitMode = ...
  pluginInstallationTarget = ...

  task {
    ...
  }

  prepareSandboxTask {
    ...
  }

  plugins {
    ...
  }
}
```

Groovy:

```GROOVY
intellijPlatformTesting.runIde {
  runPhpStorm {
    type = IntelliJPlatformType.PhpStorm
    version = ...
    useInstaller = ...
    localPath = ...

    sandboxDirectory = ...

    splitMode = ...
    pluginInstallationTarget = ...

    task {
      ...
    }

    prepareSandboxTask {
      ...
    }

    plugins {
      ...
    }
  }
}
```

### 

`task {}`

Depending on the type of registered object, a different `task` class is available for configuration:

| Type |Task class |
--------------------
| `runIde` |[RunIdeTask](tools-intellij-platform-gradle-plugin-tasks.html#runIde) |
| `testIde` |[TestIdeTask](tools-intellij-platform-gradle-plugin-tasks.html#testIde) |
| `testIdeUi` |[TestIdeUiTask](tools-intellij-platform-gradle-plugin-tasks.html#testIdeUi) |
| `testIdePerformance` |[TestIdePerformanceTask](tools-intellij-platform-gradle-plugin-tasks.html#testIdePerformance) |

### 

`prepareSandboxTask {}`

The `prepareSandboxTask` refers to a dedicated [PrepareSandboxTask](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox) task instance, connected only with a newly created task.
The name of this task is based on the name of created task, like `prepareSandbox_[TASK_NAME]`.

### 

`testFramework(...)`

Adds a dependency on a `test-framework` library variant for the created testing entry.
The version can be provided as a string or as a `Provider<String>`.
When omitted, the closest version matching the configured IntelliJ Platform build is used.

See also:

* [Types: TestFrameworkType](tools-intellij-platform-gradle-plugin-types.html#TestFrameworkType)

* [Dependencies Extension: Testing](tools-intellij-platform-gradle-plugin-dependencies-extension.html#testing)

### 

`testFrameworks(...)`

Adds dependencies on multiple `test-framework` library variants for the created testing entry.
It accepts either vararg `TestFrameworkType` arguments or a `List<TestFrameworkType>`.
The closest version matching the configured IntelliJ Platform build is selected for every variant.

Kotlin:

```KOTLIN
import org.jetbrains.intellij.platform.gradle.TestFrameworkType

val platformTests by intellijPlatformTesting.testIde.registering {
  testFrameworks(
    TestFrameworkType.Platform,
    TestFrameworkType.Plugin.Java,
  )
  testFrameworks(
    listOf(
      TestFrameworkType.JUnit5,
      TestFrameworkType.Plugin.Maven,
    )
  )
}
```

Groovy:

```GROOVY
import org.jetbrains.intellij.platform.gradle.TestFrameworkType

intellijPlatformTesting.testIde {
  platformTests {
    testFrameworks(
      TestFrameworkType.Platform.INSTANCE,
      TestFrameworkType.Plugin.Java.INSTANCE
    )
    testFrameworks([
      TestFrameworkType.JUnit5.INSTANCE,
      TestFrameworkType.Plugin.Maven.INSTANCE
    ])
  }
}
```

The plural overloads do not accept an explicit version.
To pin a specific version, call `testFramework(type, version)` separately.

See also:

* [Types: TestFrameworkType](tools-intellij-platform-gradle-plugin-types.html#TestFrameworkType)

* [Dependencies Extension: Testing](tools-intellij-platform-gradle-plugin-dependencies-extension.html#testing)

### 

`plugins {}`

An extension to provide custom plugins to be added when running the task runtime, or disabling bundled ones.

It provides several methods for adding remote and local plugins, or for disabling already loaded or bundled plugin.

Example:

Kotlin:

```KOTLIN
val runIdeWithPlugins by intellijPlatformTesting.runIde.registering {
  // ...
  plugins {
    plugin("pluginId", "1.0.0")
    disablePlugin("pluginId")
  }
}
```

Groovy:

```GROOVY
intellijPlatformTesting.runIde {
  runIdeWithPlugins {
    // ...
    plugins {
      plugin("pluginId", "1.0.0")
      disablePlugin("pluginId")
    }
  }
}
```

| Function |Description |
-------------------------
| `plugin(id, version, channel)` |Adds a dependency on a plugin for a custom IntelliJ Platform. |
| `plugin(notation)` |Adds a dependency on a plugin for a custom IntelliJ Platform using a string notation:`pluginId:version` or `pluginId:version@channel`   |
| `plugins(notations)` |Adds dependencies on plugins for a custom IntelliJ Platform using a string notation:`pluginId:version` or `pluginId:version@channel`   |
| `compatiblePlugin(id)` |Adds a dependency on a plugin in a version compatible with the custom IntelliJ Platform. |
| `compatiblePlugins(ids)` |Adds dependencies on plugins in versions compatible with the custom IntelliJ Platform. |
| `bundledPlugin(id)` |Adds a dependency on a bundled IntelliJ Platform plugin from the custom target IDE. |
| `bundledPlugins(ids)` |Adds dependencies on bundled IntelliJ Platform plugins from the custom target IDE. |
| `bundledModule(id)` |Adds a dependency on a bundled IntelliJ Platform module or module alias from the custom target IDE. |
| `bundledModules(ids)` |Adds dependencies on bundled IntelliJ Platform modules or module aliases from the custom target IDE. |
| `disablePlugin(id)` |Disables the specific plugin with its ID. |
| `disablePlugins(ids)` |Disables specific plugins with the list of their IDs. |
| `localPlugin(path)` |Adds a dependency on a local IntelliJ Platform plugin. Accepts path or a dependency on another module. |
| `robotServerPlugin(version)` |Adds a dependency on a Robot Server Plugin. |

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

