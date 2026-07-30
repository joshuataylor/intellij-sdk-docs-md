# Plugins

Tip: FAQ

See [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html) and [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html).

The IntelliJ Platform Gradle Plugin consists of sub-plugins which should be applied depending on the project structure.

Subplugins architecture allows applying a subset of features, for example, to provide the IntelliJ Platform dependency to a project submodule without creating unnecessary tasks.

The following diagram describes dependencies between plugins provided with the IntelliJ Platform Gradle Plugin.

```MERMAID
flowchart TB

    subgraph SETTINGS_LEVEL ["<div style='margin: 5px auto; font-size: 0.8rem'>settings.gradle.kts</div>"]
        Settings("<b>Settings</b>")
    end

    subgraph PROJECT_LEVEL ["<div style='margin: 5px auto; font-size: 0.8rem'>build.gradle.kts</div>"]
        Platform("<b>Platform</b>")
        Module("<b>Module</b>")
        GrammarKit("<b>GrammarKit</b>")
        Base
    end

    Module --> Base
    Platform --> Module & Base
    GrammarKit --> Base

    click Platform "#platform"
    click Module "#module"
    click Settings "#settings"
    click GrammarKit "#grammarkit"
    click Base "#base"

    style Platform stroke-width: 3px
    style Module stroke-width: 3px
    style Settings stroke-width: 3px
    style SETTINGS_LEVEL fill:transparent,stroke:#666,stroke-dasharray: 10 10
    style PROJECT_LEVEL fill:transparent,stroke:#666,stroke-dasharray: 10 10
```

The legacy `org.jetbrains.intellij.platform.migration` plugin was removed in `2.12.0`.
The migration guide remains available as historical reference.

## Platform

Plugin ID: `org.jetbrains.intellij.platform`

This is a top-level plugin that applies all the tooling for plugin development for IntelliJ-based IDEs.
It should be used only with the root module (for submodules, see [Module](#module)).

Kotlin:

`build.gradle.kts`

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform") version "2.18.1"
}
```

Groovy:

`build.gradle`

```GROOVY
plugins {
  id 'org.jetbrains.intellij.platform' version '2.18.1'
}
```

### Available tasks

[buildPlugin](tools-intellij-platform-gradle-plugin-tasks.html#buildPlugin),
[buildSearchableOptions](tools-intellij-platform-gradle-plugin-tasks.html#buildSearchableOptions),
[cleanSandbox](tools-intellij-platform-gradle-plugin-tasks.html#cleanSandbox),
[composedJar](tools-intellij-platform-gradle-plugin-tasks.html#composedJar),
[generateManifest](tools-intellij-platform-gradle-plugin-tasks.html#generateManifest),
[generateSplitModeRunConfigurations](tools-intellij-platform-gradle-plugin-tasks.html#generateSplitModeRunConfigurations),
[initializeIntelliJPlatformPlugin](tools-intellij-platform-gradle-plugin-tasks.html#initializeIntelliJPlatformPlugin),
[instrumentCode](tools-intellij-platform-gradle-plugin-tasks.html#instrumentCode),
[instrumentedJar](tools-intellij-platform-gradle-plugin-tasks.html#instrumentedJar),
[jarSearchableOptions](tools-intellij-platform-gradle-plugin-tasks.html#jarSearchableOptions),
[patchPluginXml](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml),
[prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox),
[prepareTest](tools-intellij-platform-gradle-plugin-tasks.html#prepareTest),
[prepareTestIdePerformanceSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestIdePerformanceSandbox),
[prepareTestSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestSandbox),
[printBundledModules](tools-intellij-platform-gradle-plugin-tasks.html#printBundledModules),
[printBundledPlugins](tools-intellij-platform-gradle-plugin-tasks.html#printBundledPlugins),
[printProductsReleases](tools-intellij-platform-gradle-plugin-tasks.html#printProductsReleases),
[publishPlugin](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin),
[runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde),
[runIdeBackend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeBackend),
[runIdeFrontend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeFrontend),
[setupDependencies](tools-intellij-platform-gradle-plugin-tasks.html#setupDependencies),
[signPlugin](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin),
[test](tools-intellij-platform-gradle-plugin-tasks.html#test),
[testIdePerformance](tools-intellij-platform-gradle-plugin-tasks.html#testIdePerformance),
[testIde](tools-intellij-platform-gradle-plugin-tasks.html#testIde),
[testIdeUi](tools-intellij-platform-gradle-plugin-tasks.html#testIdeUi),
[verifyPluginProjectConfiguration](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginProjectConfiguration),
[verifyPluginSignature](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginSignature),
[verifyPluginStructure](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginStructure),
[verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin)

## Module

Plugin ID: `org.jetbrains.intellij.platform.module`

This plugin applies a smaller set of functionalities for compiling and testing submodules when working in a multi-module architecture.

Compared to the main plugin, it omits publishing, signing, searchable-options generation, and plugin verification tasks.

Kotlin:

`settings.gradle.kts`

```KOTLIN
rootProject.name = "..."

include(":submodule")
```

`submodule/build.gradle.kts`

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform.module")
}

repositories {
  mavenCentral()

  intellijPlatform {
    defaultRepositories()
  }
}
```

`build.gradle.kts`

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform") version "2.18.1"
}

repositories {
  mavenCentral()

  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  implementation(project(":submodule"))

  intellijPlatform {
    intellijIdea("2026.2.0.1")
  }
}
```

Groovy:

`settings.gradle`

```GROOVY
rootProject.name = '...'

include ':submodule'
```

`submodule/build.gradle`

```GROOVY
plugins {
  id 'org.jetbrains.intellij.platform.module'
}

repositories {
  mavenCentral()

  intellijPlatform {
    defaultRepositories()
  }
}
```

`build.gradle`

```GROOVY
plugins {
  id 'org.jetbrains.intellij.platform' version '2.18.1'
}

repositories {
  mavenCentral()

  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  implementation project(':submodule')

  intellijPlatform {
    intellijIdea '2026.2.0.1'
  }
}
```

Module projects inherit the root project's IntelliJ Platform dependency when the module doesn't configure its own target platform.
Project dependencies on IntelliJ Platform module projects added to the root project's `api`, `implementation`, or `runtimeOnly` configuration are packaged automatically into the `lib/modules/` directory in the final plugin distribution.

To merge submodule content into the main plugin JAR file, use `pluginComposedModule(project(":submodule"))` instead.

### Available tasks

[cleanSandbox](tools-intellij-platform-gradle-plugin-tasks.html#cleanSandbox),
[composedJar](tools-intellij-platform-gradle-plugin-tasks.html#composedJar),
[generateManifest](tools-intellij-platform-gradle-plugin-tasks.html#generateManifest),
[initializeIntelliJPlatformPlugin](tools-intellij-platform-gradle-plugin-tasks.html#initializeIntelliJPlatformPlugin),
[instrumentCode](tools-intellij-platform-gradle-plugin-tasks.html#instrumentCode),
[instrumentedJar](tools-intellij-platform-gradle-plugin-tasks.html#instrumentedJar),
[prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox),
[prepareTest](tools-intellij-platform-gradle-plugin-tasks.html#prepareTest),
[prepareTestIdePerformanceSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestIdePerformanceSandbox),
[prepareTestSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestSandbox),
[printBundledModules](tools-intellij-platform-gradle-plugin-tasks.html#printBundledModules),
[printBundledPlugins](tools-intellij-platform-gradle-plugin-tasks.html#printBundledPlugins),
[printProductsReleases](tools-intellij-platform-gradle-plugin-tasks.html#printProductsReleases),
[setupDependencies](tools-intellij-platform-gradle-plugin-tasks.html#setupDependencies),
[test](tools-intellij-platform-gradle-plugin-tasks.html#test),
[testIde](tools-intellij-platform-gradle-plugin-tasks.html#testIde),
[testIdeUi](tools-intellij-platform-gradle-plugin-tasks.html#testIdeUi),
[verifyPluginProjectConfiguration](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginProjectConfiguration)

## Settings

Plugin ID: `org.jetbrains.intellij.platform.settings`

If you define project repositories within the `settings.gradle.kts` using the `dependencyResolutionManagement`, make sure to include the Settings plugin in `settings.gradle.kts`.

This approach allows for omitting the `repositories {}` definition in the `build.gradle.kts` files. See [Dependency Resolution Management](tools-intellij-platform-gradle-plugin.html#configuration.dependencyResolutionManagement) for more details.

Kotlin:

`settings.gradle.kts`

```KOTLIN
import org.jetbrains.intellij.platform.gradle.extensions.intellijPlatform

plugins {
  id("org.jetbrains.intellij.platform.settings") version "2.18.1"
}

rootProject.name = "..."

dependencyResolutionManagement {
  repositoriesMode = RepositoriesMode.FAIL_ON_PROJECT_REPOS

  repositories {
    mavenCentral()

    intellijPlatform {
      defaultRepositories()
    }
  }
}

include(":submodule")
```

`build.gradle.kts`

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform")
}

dependencies {
  implementation(project(":submodule"))

  intellijPlatform {
    intellijIdea("2026.2.0.1")
  }
}
```

Tip:

Note that `build.gradle.kts` doesn't define the IntelliJ Platform Gradle Plugin version anymore as it was earlier declared in the `settings.gradle.kts` file.
Specifying the version in two places may result in the following Gradle exception:

`The request for this plugin could not be satisfied because the plugin is already on the classpath with an unknown version, so compatibility cannot be checked.`

`submodule/build.gradle.kts`

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform.module")
}
```

Groovy:

`settings.gradle`

```GROOVY
import org.jetbrains.intellij.platform.gradle.extensions.intellijPlatform

plugins {
  id 'org.jetbrains.intellij.platform.settings' version '2.18.1'
}

rootProject.name = '...'

dependencyResolutionManagement {
  repositoriesMode = RepositoriesMode.FAIL_ON_PROJECT_REPOS

  repositories {
    mavenCentral()

    intellijPlatform {
      defaultRepositories()
    }
  }
}

include ':submodule'
```

`build.gradle`

```GROOVY
plugins {
  id 'org.jetbrains.intellij.platform'
}

dependencies {
  implementation project(':submodule')

  intellijPlatform {
    intellijIdea '2026.2.0.1'
  }
}
```

Tip:

Note that `build.gradle` doesn't define the IntelliJ Platform Gradle Plugin version anymore as it was earlier declared in the `settings.gradle` file.
Specifying the version in two places may result in the following Gradle exception:

`The request for this plugin could not be satisfied because the plugin is already on the classpath with an unknown version, so compatibility cannot be checked.`

`submodule/build.gradle`

```GROOVY
plugins {
  id 'org.jetbrains.intellij.platform.module'
}
```

## GrammarKit

Plugin ID: `org.jetbrains.intellij.platform.grammarkit`

This plugin applies the [Base](#base) plugin and adds task support for generating lexers with JFlex and parsers with GrammarKit.

Kotlin:

`build.gradle.kts`

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform.grammarkit") version "2.18.1"
}
```

Groovy:

`build.gradle`

```GROOVY
plugins {
  id 'org.jetbrains.intellij.platform.grammarkit' version '2.18.1'
}
```

### Available tasks

[generateLexer](tools-intellij-platform-gradle-plugin-tasks.html#generateLexer),
[generateParser](tools-intellij-platform-gradle-plugin-tasks.html#generateParser),
[initializeIntelliJPlatformPlugin](tools-intellij-platform-gradle-plugin-tasks.html#initializeIntelliJPlatformPlugin),
[printBundledModules](tools-intellij-platform-gradle-plugin-tasks.html#printBundledModules),
[printBundledPlugins](tools-intellij-platform-gradle-plugin-tasks.html#printBundledPlugins),
[printProductsReleases](tools-intellij-platform-gradle-plugin-tasks.html#printProductsReleases),
[setupDependencies](tools-intellij-platform-gradle-plugin-tasks.html#setupDependencies)

## Base

Plugin ID: `org.jetbrains.intellij.platform.base`

Prepares all the custom configurations, transformers, and base tasks needed to manage the IntelliJ Platform dependency, JetBrains Runtime, CLI tools, and others.

It also introduces the [IntelliJ Platform Extension](tools-intellij-platform-gradle-plugin-extension.html) to the `build.gradle.kts` file along with [Dependencies Extension](tools-intellij-platform-gradle-plugin-dependencies-extension.html) and [Repositories Extension](tools-intellij-platform-gradle-plugin-repositories-extension.html) to help preconfigure project dependencies:

Kotlin:

```KOTLIN
repositories {
  ...

  // Repositories Extension
  intellijPlatform { ... }
}

dependencies {
  ...

  // Dependencies Extension
  intellijPlatform { ... }
}

// IntelliJ Platform Extension
intellijPlatform { ... }
```

Groovy:

```GROOVY
repositories {
  ...

  // Repositories Extension
  intellijPlatform { ... }
}

dependencies {
  ...

  // Dependencies Extension
  intellijPlatform { ... }
}

// IntelliJ Platform Extension
intellijPlatform { ... }
```

The plugin also introduces a task listener which allows for creating custom tasks decorated with [Task Awares](tools-intellij-platform-gradle-plugin-task-awares.html).
See [Recipes](tools-intellij-platform-gradle-plugin-recipes.html) for more details.

### Available tasks

[initializeIntelliJPlatformPlugin](tools-intellij-platform-gradle-plugin-tasks.html#initializeIntelliJPlatformPlugin),
[printBundledModules](tools-intellij-platform-gradle-plugin-tasks.html#printBundledModules),
[printBundledPlugins](tools-intellij-platform-gradle-plugin-tasks.html#printBundledPlugins),
[printProductsReleases](tools-intellij-platform-gradle-plugin-tasks.html#printProductsReleases),
[setupDependencies](tools-intellij-platform-gradle-plugin-tasks.html#setupDependencies),

