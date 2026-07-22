# Migrating from Gradle IntelliJ Plugin (1.x)

## Plugin Name Change

As the 2.x branch brings significant breaking changes to the plugin, the name was changed from Gradle IntelliJ Plugin to
IntelliJ Platform Gradle Plugin as the old one was confused with the bundled Gradle support plugin in the IDE.

The plugin is published to the Gradle Plugin Portal with a new name as a new entry, and the old one is marked as deprecated.

## Minimum Gradle and Java Versions

The minimum required Gradle version is now 9.0.0 running on Java 17 or later.
See [Requirements](tools-intellij-platform-gradle-plugin.html#requirements).

## Plugin ID Change

Plugin ID has changed from `org.jetbrains.intellij` to `org.jetbrains.intellij.platform`.
To apply it, use:

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform") version "2.18.1"
}
```

## Migration Plugin

Early 2.x releases introduced a dedicated migration plugin to ease the transition from Gradle IntelliJ Plugin 1.x.

When you apply the [Plugin ID Change](#plugin-id-change), Gradle will fail to process the `build.gradle.kts` file as the old [intellij {} Extension](#intellij-extension) doesn't exist anymore.

Note:

The `org.jetbrains.intellij.platform.migration` plugin was removed in IntelliJ Platform Gradle Plugin `2.12.0`.
Use this migration guide as a manual checklist and apply only `org.jetbrains.intellij.platform`.

## 

`intellij {}` Extension

The `intellij {}` extension is no longer available and was replaced with `intellijPlatform {}`.
Note that the available properties differ, see [IntelliJ Platform Extension](tools-intellij-platform-gradle-plugin-extension.html) for details.

### 

`intellij.pluginName`

Use: [intellijPlatform.pluginConfiguration.name](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-name):

```KOTLIN
intellijPlatform {
  pluginConfiguration {
    name = ...
  }
}
```

### 

`intellij.type`, `intellij.version`

Define the IntelliJ Platform dependency in `dependencies{}` block:

```KOTLIN
repositories {
  mavenCentral()
  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    create(type, version)
  }
}
```

See: [Dependencies Extension](tools-intellij-platform-gradle-plugin-dependencies-extension.html)

### 

`intellij.plugins`

The `intellij.plugins` property is no longer available.

Note:

Bundled plugins are now defined separately from plugins of other sources (like JetBrains Marketplace).

Define dependencies on plugins or bundled plugins in `dependencies {}` block instead:

Example:

Setting up dependencies on comma-separated plugins listed in `platformPlugins` and `platformBundledPlugins` properties from `gradle.properties`.

```KOTLIN
repositories {
  mavenCentral()
  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    plugins(providers.gradleProperty("platformPlugins").map { it.split(',') })
    bundledPlugins(providers.gradleProperty("platformBundledPlugins").map { it.split(',') })
  }
}
```

See:

* [Plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins)

* [Dependency on bundled plugin is not resolved after migrating from 1.x](tools-intellij-platform-gradle-plugin-faq.html#migrateToPluginId)

Tip: localPlatformArtifacts() and defaultRepositories()

Note that unless using recommended default [defaultRepositories()](tools-intellij-platform-gradle-plugin-repositories-extension.html#default-repositories),
the [localPlatformArtifacts()](tools-intellij-platform-gradle-plugin-repositories-extension.html#additional-repositories) entry needs to be added to the `repositories {}` block
explicitly to use local dependencies (bundled plugins, local IDE, custom plugin repositories, etc.).

### 

`intellij.localPath`

Define dependencies on local IDE instance in `dependencies {}` block:

```KOTLIN
repositories {
  mavenCentral()
  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    local(localPath)
  }
}
```

See: [Custom Target Platforms](tools-intellij-platform-gradle-plugin-dependencies-extension.html#custom-target-platforms)

Tip: localPlatformArtifacts() and defaultRepositories()

Note that unless using recommended default [defaultRepositories()](tools-intellij-platform-gradle-plugin-repositories-extension.html#default-repositories),
the [localPlatformArtifacts()](tools-intellij-platform-gradle-plugin-repositories-extension.html#additional-repositories) entry needs to be added to the `repositories {}` block
explicitly to use local dependencies (bundled plugins, local IDE, custom plugin repositories, etc.).

### 

`intellij.updateSinceUntilBuild`, `intellij.sameSinceUntilBuild`

The since/until properties in the `plugin.xml` file are now managed by the [intellijPlatform](tools-intellij-platform-gradle-plugin-extension.html) extension.

### 

`intellij.intellijRepository`,`intellij.pluginsRepositories`, `intellij.jreRepository`

### 

`intellij.sandboxDir`

Use the [intellijPlatform.sandboxContainer](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-sandboxContainer).

Use the `repositories {}` block to manage repositories instead.

See: [Repositories Extension](tools-intellij-platform-gradle-plugin-repositories-extension.html)

### 

`intellij.downloadSources`

Downloading sources is managed by the Plugin DevKit plugin in version 2024.1+.

### 

`intellij.ideaDependency`

Access the [ProductInfo](tools-intellij-platform-gradle-plugin-types.html#ProductInfo) object using the [intellijPlatform.productInfo](tools-intellij-platform-gradle-plugin-types.html#ProductInfo) property.

## Tasks

### Running Tests

An [explicit dependency](tools-intellij-platform-gradle-plugin-dependencies-extension.html#testing) on a test framework is now required.

### 

`downloadRobotServerPlugin`

The Robot Server Plugin can now be downloaded using `plugins { robotServerPlugin() }` dependency helper when declaring a custom task.

### 

`runIdeForUiTests`

The `runIdeForUiTests` task is obsolete and should be replaced with an explicit declaration.

The task running IDE with the Robot Server Plugin should be declared now as a custom `runIde` task with plugin loaded:

Kotlin:

```KOTLIN
val runIdeForUiTests by intellijPlatformTesting.runIde.registering {
  task {
    jvmArgumentProviders += CommandLineArgumentProvider {
      listOf(
        "-Drobot-server.port=8082",
        "-Dide.mac.message.dialogs.as.sheets=false",
        "-Djb.privacy.policy.text=<!--999.999-->",
        "-Djb.consents.confirmation.enabled=false",
      )
    }
  }

  plugins {
    robotServerPlugin()
  }
}
```

Groovy:

```GROOVY
intellijPlatformTesting.runIde {
  runIdeForUiTests {
    task {
      jvmArgumentProviders.add({
        [
          '-Drobot-server.port=8082',
          '-Dide.mac.message.dialogs.as.sheets=false',
          '-Djb.privacy.policy.text=<!--999.999-->',
          '-Djb.consents.confirmation.enabled=false',
        ]
      } as CommandLineArgumentProvider)
    }

    plugins {
      robotServerPlugin()
    }
  }
}
```

### 

`runPluginVerifier`

The task for running the IntelliJ Plugin Verifier is now called [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin).

Use [intellijPlatform.pluginVerification](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification) extension to configure it.

### 

`setupDependencies`

To make the IntelliJ SDK dependency available in the IDE, the `setupDependencies` task was provided by Gradle IntelliJ Plugin 1.x.
This task is no longer required, but when switching from 1.x, Gradle may still want to execute it in the afterSync phase.

Warning: Task 'setupDependencies' not found

Due to the presence of the `setupDependencies` task in the Tasks Activation, the IDE may fail with the following exception if the task is not present:

```
Task 'setupDependencies' not found in root project 'projectName'.
```

To fix this problem, remove any references to `setupDependencies` task from your project.

To completely drop this approach, it is mandatory to remove its reference manually in the IDE.

Procedure: Removing 'setupDependencies' Task

Alternatively, edit the `.idea/workspace.xml` file and remove the `setupDependencies` entry.

## Other

### Unresolved 'idea-ext' Plugin

Add an explicit dependency on [the plugin](https://github.com/JetBrains/gradle-idea-ext-plugin) in `build.gradle.kts`:

Kotlin:

```KOTLIN
plugins {
  id("org.jetbrains.gradle.plugin.idea-ext") version "1.1.9"
}
```

Groovy:

```GROOVY
plugins {
  id 'org.jetbrains.gradle.plugin.idea-ext' version '1.1.9'
}
```

