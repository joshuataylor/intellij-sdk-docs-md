# IntelliJ Platform Gradle Plugin (2.x)

<tldr>
Current Release: 2.20.0

GitHub: [Releases &amp; Changelog](https://github.com/JetBrains/intellij-platform-gradle-plugin/releases), [Issue Tracker](https://github.com/JetBrains/intellij-platform-gradle-plugin/issues)

JetBrains Platform Forum: [Gradle Build Scripts](https://platform.jetbrains.com/c/intellij-platform/gradle-build-scripts/6) category
</tldr>

The IntelliJ Platform Gradle Plugin 2.x is a [Gradle](https://docs.gradle.org/current/userguide/userguide.html)
plugin for building, testing, verifying, configuring environments, and publishing plugins for IntelliJ-based IDEs.
It is the successor of [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) which is no longer under active development.

Learn more about it in the [Release Announcement](https://blog.jetbrains.com/platform/2024/07/intellij-platform-gradle-plugin-2-0/).

Tip: FAQ

See [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html) and [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html).

## Requirements

IntelliJ Platform Gradle Plugin 2.x requires the following minimal versions:

* IntelliJ Platform: 2023.3

* Gradle: 9.0.0 See [the Gradle Installation guide](https://gradle.org/install/) on how to upgrade.

* Java Runtime: 17 See Gradle JVM in `Settings | Build, Execution, Deployment | Build Tools | Gradle`.

## Setup

Note:

Note that the plugin has a new ID `org.jetbrains.intellij.platform`.

To apply the IntelliJ Platform Gradle Plugin to a project, add the following entry to the `plugins`
block in the Gradle build file:

Kotlin:

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform") version "2.20.0"
}
```

Groovy:

```GROOVY
plugins {
  id 'org.jetbrains.intellij.platform' version '2.20.0'
}
```

### Using Snapshot Release

To use the latest snapshot version of this plugin, add the following to the Gradle Settings file:

Kotlin:

`settings.gradle.kts`

```KOTLIN
pluginManagement {
  repositories {
    maven("https://central.sonatype.com/repository/maven-snapshots/")
    gradlePluginPortal()
  }
}
```

Groovy:

`settings.gradle`

```GROOVY
pluginManagement {
  repositories {
    maven {
      url 'https://central.sonatype.com/repository/maven-snapshots/'
    }
    gradlePluginPortal()
  }
}
```

Tip:

The current IntelliJ Platform Gradle Plugin Snapshot version is ![Maven Snapshots](https://img.shields.io/maven-metadata/v?metadataUrl=https://central.sonatype.com/repository/maven-snapshots/org/jetbrains/intellij/platform/intellij-platform-gradle-plugin/maven-metadata.xml&label=)

The snapshot release is published with a fixed version, so Gradle can resort to the cached version of the plugin.

To update all dependencies in the dependency cache, use the `--refresh-dependencies` command line option.

### Plugins

The IntelliJ Platform Gradle Plugin consists of [plugins](tools-intellij-platform-gradle-plugin-plugins.html) which can be applied depending on the purpose.
By default, the [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform) plugin (`org.jetbrains.intellij.platform`) should be applied to the main plugin project module.

When working in a [Multi-Module Project Structure](#multi-module-project-structure) it is required to use [Module](tools-intellij-platform-gradle-plugin-plugins.html#module) plugin (`org.jetbrains.intellij.platform.module`) instead of creating tasks and configurations specific to the main module only.

The [Settings](tools-intellij-platform-gradle-plugin-plugins.html#settings) plugin (`org.jetbrains.intellij.platform.settings`) allows for adding plugin development related repositories right in the `settings.gradle.kts` file if project configuration involves [Dependency Resolution Management](#configuration.dependencyResolutionManagement).

### Attaching Sources in the IDE

To attach IntelliJ Platform sources in the IDE, the Download sources setting has to be enabled in IDE versions 2023.2 and later.
This option respects the plugin's [downloadSources](tools-intellij-platform-gradle-plugin-gradle-properties.html#downloadSources) property, which is enabled by default.

2023.3+:

In `Settings | Advanced Settings` enable option Download sources in section `Build Tools. Gradle`.
Then invoke Reload All Gradle Projects action from the Gradle tool window.

2023.2:

In `Settings | Build, Execution, Deployment | Build Tools | Gradle` enable Download sources for dependencies.
Then invoke the Reload All Gradle Projects action from the Gradle tool window.

Earlier versions:

No additional IDE settings are required.

The attaching sources operation in the IDE is handled by the Plugin DevKit plugin, thus it is recommended to always use the latest available IDE version.

If the opened compiled class has no sources available locally, the Plugin DevKit plugin will detect the relevant source coordinates and provide an action to Download IntelliJ Platform sources or Attach $API_NAME$ sources.

## Configuration

Tip: Exploring Configuration Options

Auto-completion, Quick Documentation, and other code insight features are available for many extension functions and properties.

### Setting Up Repositories

All IntelliJ Platform SDK artifacts are available via IntelliJ Maven repositories (see [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html)), which exist in three variants:

* releases

* snapshots

* nightly (only selected artifacts)

Tip:

In most cases, the [defaultRepositories()](tools-intellij-platform-gradle-plugin-repositories-extension.html#default-repositories) repository should be enough.

Example:

Setup Maven Central and [defaultRepositories()](tools-intellij-platform-gradle-plugin-repositories-extension.html#default-repositories) repositories:

Kotlin:

```KOTLIN
repositories {
  mavenCentral()

  intellijPlatform {
    defaultRepositories()
  }
}
```

Groovy:

```GROOVY
repositories {
  mavenCentral()

  intellijPlatform {
    defaultRepositories()
  }
}
```

Example #2:

Build a plugin against a release version of the IntelliJ Platform with dependency on a plugin from the JetBrains Marketplace:

Kotlin:

```KOTLIN
repositories {
  mavenCentral()

  intellijPlatform {
    releases()
    marketplace()
  }
}
```

Groovy:

```GROOVY
repositories {
  mavenCentral()

  intellijPlatform {
    releases()
    marketplace()
  }
}
```

See [Repositories Extension](tools-intellij-platform-gradle-plugin-repositories-extension.html) on how to configure additional repositories.

#### Dependency Resolution Management

To access the IntelliJ Platform Gradle Plugin within the Gradle Settings file to use with `dependencyResolutionManagement`, add:

Kotlin:

`settings.gradle.kts`

```KOTLIN
import org.jetbrains.intellij.platform.gradle.extensions.intellijPlatform

plugins {
  id("org.jetbrains.intellij.platform.settings") version "2.20.0"
}

dependencyResolutionManagement {
  repositoriesMode = RepositoriesMode.FAIL_ON_PROJECT_REPOS

  repositories {
    mavenCentral()

    intellijPlatform {
      defaultRepositories()
    }
  }
}
```

Groovy:

`settings.gradle`

```GROOVY
import org.jetbrains.intellij.platform.gradle.extensions.intellijPlatform

plugins {
  id 'org.jetbrains.intellij.platform.settings' version '2.20.0'
}

dependencyResolutionManagement {
  repositoriesMode = RepositoriesMode.FAIL_ON_PROJECT_REPOS

  repositories {
    mavenCentral()

    intellijPlatform {
      defaultRepositories()
    }
  }
}
```

#### Cache Redirector

Some repositories, by default, point to JetBrains Cache Redirector to provide better resource resolution.
However, it is possible to use the direct repository URL, if available.

To switch off the default usage of JetBrains Cache Redirector, see the [useCacheRedirector](tools-intellij-platform-gradle-plugin-gradle-properties.html#useCacheRedirector) Gradle property.

### Setting Up IntelliJ Platform

Dependencies and [repositories](#configuration.repositories) are handled using explicit entries within `dependencies {}` and `repositories {}` blocks in the Gradle build file.

A minimum configuration for targeting IntelliJ IDEA 2024.3:

Kotlin:

```KOTLIN
repositories {
  mavenCentral()

  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    intellijIdea("2024.3")
  }
}
```

Groovy:

```GROOVY
repositories {
  mavenCentral()

  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    intellijIdea('2024.3.6')
  }
}
```

The `intellijIdea` in the previous sample is one of the extension functions available for adding IntelliJ Platform dependencies to the project.
See [Dependencies Extension](tools-intellij-platform-gradle-plugin-dependencies-extension.html) on how to target other IDEs.

Note:

When declaring a dependency on IntelliJ Platform, the IDE installer is resolved by default.
IDE installers are OS-specific and contain [JetBrains Runtime (JBR)](tools-intellij-platform-gradle-plugin-jetbrains-runtime.html) bundled, but have no EAP releases available.

To resolve EAP releases instead, opt out from installer releases in the dependency helper configuration with `useInstaller = false`.

Important: non-installer archives have no JetBrains Runtime (JBR) provided.

Read more about [Target Versions](tools-intellij-platform-gradle-plugin-dependencies-extension.html#target-versions).

#### Parametrize IntelliJ Platform Dependency

As a fallback, `intellijPlatform` extension can be used to allow dynamic configuration of the target platform, for example, via `gradle.properties`:

```
platformType = IC
platformVersion = 2023.3
```

The above Gradle properties can be referenced in the Gradle build file with:

Kotlin:

```KOTLIN
dependencies {
  intellijPlatform {
    val type = providers.gradleProperty("platformType")
    val version = providers.gradleProperty("platformVersion")

    create(type, version)
  }
}
```

Groovy:

```GROOVY
dependencies {
  intellijPlatform {
    def type = providers.gradleProperty('platformType')
    def version = providers.gradleProperty('platformVersion')

    create(type, version)
  }
}
```

The `intellijPlatform` helper accepts also the [IntelliJPlatformType](tools-intellij-platform-gradle-plugin-types.html#IntelliJPlatformType) type:

Kotlin:

```KOTLIN
import org.jetbrains.intellij.platform.gradle.IntelliJPlatformType

dependencies {
  intellijPlatform {
    val version = providers.gradleProperty("platformVersion")

    create(IntelliJPlatformType.IntellijIdeaUltimate, version)
  }
}
```

Groovy:

```GROOVY
import org.jetbrains.intellij.platform.gradle.IntelliJPlatformType

dependencies {
  intellijPlatform {
    def version = providers.gradleProperty('platformVersion')

    create(IntelliJPlatformType.IntellijIdeaUltimate, version)
  }
}
```

#### Local IntelliJ Platform IDE Instance

It is possible to refer to the locally available IntelliJ-based IDE using the `local` helper function:

Kotlin:

```KOTLIN
repositories {
  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    local("/Users/user/Applications/IntelliJ IDEA Ultimate.app")
  }
}
```

Groovy:

```GROOVY
repositories {
  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    local '/Users/user/Applications/IntelliJ IDEA Ultimate.app'
  }
}
```

Tip: localPlatformArtifacts() and defaultRepositories()

Note that unless using recommended default [defaultRepositories()](tools-intellij-platform-gradle-plugin-repositories-extension.html#default-repositories),
the [localPlatformArtifacts()](tools-intellij-platform-gradle-plugin-repositories-extension.html#additional-repositories) entry needs to be added to the `repositories {}` block
explicitly to use local dependencies (bundled plugins, local IDE, custom plugin repositories, etc.).

### Setting Up Plugin Dependencies

To specify a dependency on a plugin, it is important to distinguish bundled plugins from plugins available in JetBrains Marketplace.

The [Dependencies Extension](tools-intellij-platform-gradle-plugin-dependencies-extension.html) provides a set of helpers to manage [plugin dependencies](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins):

Kotlin:

```KOTLIN
repositories {
  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    intellijIdea("2026.2.3")

    bundledPlugin("com.intellij.java")
    plugin("org.intellij.scala", "2024.1.4")
  }
}
```

Groovy:

```GROOVY
repositories {
  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    intellijIdea '2026.2.3'

    bundledPlugin 'com.intellij.java'
    plugin 'org.intellij.scala', '2024.1.4'
  }
}
```

Tip: localPlatformArtifacts() and defaultRepositories()

Note that unless using recommended default [defaultRepositories()](tools-intellij-platform-gradle-plugin-repositories-extension.html#default-repositories),
the [localPlatformArtifacts()](tools-intellij-platform-gradle-plugin-repositories-extension.html#additional-repositories) entry needs to be added to the `repositories {}` block
explicitly to use local dependencies (bundled plugins, local IDE, custom plugin repositories, etc.).

### Multi-Module Project Structure

When working on a complex plugin, it is often convenient to split the code base into multiple submodules.
To avoid polluting submodules with tasks or configurations specific to the root module only (for example, tasks for signing, publishing, or running the plugin),
a dedicated sub-plugin was introduced.

The root module of the IntelliJ-based plugin project must apply the main [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform) plugin as follows:

Kotlin:

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform") version "2.20.0"
}
```

Groovy:

```GROOVY
plugins {
  id 'org.jetbrains.intellij.platform' version '2.20.0'
}
```

Any other included submodule must use the [Module](tools-intellij-platform-gradle-plugin-plugins.html#module) plugin instead:

Kotlin:

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform.module")
}
```

Groovy:

```GROOVY
plugins {
  id 'org.jetbrains.intellij.platform.module'
}
```

Module projects inherit the root project's target IntelliJ Platform when they do not declare their own `intellijPlatform {}` dependency target.
Project dependencies on module projects added to the root project's `api`, `implementation`, or `runtimeOnly` configurations are automatically packaged as plugin modules under `lib/modules/`.
Use `pluginComposedModule(dependency)` only when a module's classes must be merged into the main plugin JAR instead.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

