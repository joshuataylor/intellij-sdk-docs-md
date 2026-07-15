# Repositories Extension

Tip: FAQ

See [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html) and [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html).

This is an extension class for managing IntelliJ Platform repositories in a Gradle build script.
It's applied to the `RepositoryHandler`.

Available in both `Project` scope and Gradle Settings for `DependencyResolutionManagement`.

It provides methods to add:

* IntelliJ Platform repositories (for releases, snapshots, and nightly builds)

* JetBrains Marketplace repository (for dependencies on non-bundled plugins)

* JetBrains Runtime repository

* Android Studio and IntelliJ Platform binary release repositories (for IntelliJ Plugin Verifier)

* Ivy local repository (for access to local dependencies)

Tip:

In most cases, the [defaultRepositories()](#default-repositories) repository should be enough.

Example:

Setup Maven Central and [defaultRepositories()](#default-repositories) repositories:

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

## Default Repositories

The default repository definition is suitable for most plugins.

| Function |Description |
-------------------------
| `defaultRepositories()` |Applies a set of recommended repositories required for building plugins and running the most common tasks. |

It includes:

* `jetbrainsIdeInstallers()` and `androidStudioInstallers()` – IntelliJ Platform and Android Studio installer releases channels required for development and running the IntelliJ Plugin Verifier

* `releases()` and `snapshots()` – IntelliJ Platform releases channels

* `localPlatformArtifacts()` – required to use plugins bundled with IntelliJ Platform or refer to a local IDE

* `jetbrainsRuntime()` – JetBrains Runtime releases

* `marketplace()` – JetBrains Marketplace plugins repository

* `intellijDependencies()` – required for resolving extra IntelliJ Platform dependencies used for running specific tasks

## Working in Isolated Networks

When Gradle runs in an isolated network, it cannot reach the public repositories used by IntelliJ Platform artifacts, plugins, and additional dependencies.
In such setups, avoid using `defaultRepositories()` and replace it with your internal mirror repositories.
Even with mirrors, keep `localPlatformArtifacts()` in `repositories {}` because it is a local Ivy repository required for bundled plugins, local IDEs, and other local artifacts.

The `defaultRepositories()` helper adds the following remote repositories.
Mirror or proxy these endpoints internally:

Cache redirector endpoints (used by default):

* IntelliJ Platform releases: `https://cache-redirector.jetbrains.com/www.jetbrains.com/intellij-repository/releases`

* IntelliJ Platform snapshots: `https://cache-redirector.jetbrains.com/www.jetbrains.com/intellij-repository/snapshots`

* IntelliJ Platform dependencies: `https://cache-redirector.jetbrains.com/intellij-dependencies`

* JetBrains Marketplace (Maven): `https://cache-redirector.jetbrains.com/plugins.jetbrains.com/maven`

* JetBrains Runtime (Ivy): `https://cache-redirector.jetbrains.com/intellij-jbr`

Direct endpoints (when cache redirector is disabled):

* IntelliJ Platform releases: `https://www.jetbrains.com/intellij-repository/releases`

* IntelliJ Platform snapshots: `https://www.jetbrains.com/intellij-repository/snapshots`

* IntelliJ Platform dependencies: `https://packages.jetbrains.team/maven/p/ij/intellij-dependencies`

* JetBrains Marketplace (Maven): `https://plugins.jetbrains.com/maven`

Installer repositories (Ivy):

* JetBrains IDE installers: `https://download.jetbrains.com`

* Android Studio installers: `https://redirector.gvt1.com/edgedl/android/studio`

## IntelliJ Platform Installers

IntelliJ Platform installers are the final IDE distributions delivered to end-users for installing and running products on their machines.
Those installers can also be used for development and running the IntelliJ Plugin Verifier tool integrated with the [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin) task.

| Function |Description |
-------------------------
| `jetbrainsIdeInstallers()` |Adds a repository for accessing JetBrains IDEs installers. |
| `androidStudioInstallers()` |Adds a repository for accessing Android Studio installers. |

See also:

* [Installers](tools-intellij-platform-gradle-plugin-dependencies-extension.html#target-versions-installers)

* [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html)

* [Verifying Plugin Compatibility](verifying-plugin-compatibility.html)

## IntelliJ Maven Repositories

IntelliJ Platform artifacts can be also delivered as multi-OS archives, however they do not contain [JetBrains Runtime (JBR)](tools-intellij-platform-gradle-plugin-jetbrains-runtime.html) bundled and require adding it explicitly to the project dependencies.

The following IntelliJ Platform repositories contain not only the IntelliJ Platform releases in stable, snapshot, and nightly versions, but also various dependencies, such as:

* Java Compiler required for [Code Instrumentation](tools-intellij-platform-gradle-plugin-dependencies-extension.html#code-instrumentation)

* Test Framework required for [Testing](tools-intellij-platform-gradle-plugin-dependencies-extension.html#testing)

| Function |Description |
-------------------------
| `releases()` |Adds a repository for accessing IntelliJ Platform stable releases. |
| `snapshots()` |Adds a repository for accessing IntelliJ Platform snapshot releases. |
| `nightly()` |Adds a repository for accessing IntelliJ Platform nightly releases, not available publicly. |

See also:

* [Multi-OS Archives](tools-intellij-platform-gradle-plugin-dependencies-extension.html#target-versions-multi-os-archives)

* [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html)

## Plugin Repositories

It is possible to define a dependency on another plugin using [Plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) helpers.
Such plugins are resolved as any other dependencies in Gradle using repositories added to the project configuration.

The common repository hosting plugins is [JetBrains Marketplace](https://plugins.jetbrains.com), which can be added with the `marketplace()` helper.
To refer to its plugins, use the [plugin(id, version)](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) dependency helper.

It is also possible to resolve plugins from regular Maven repositories other than JetBrains Marketplace.
In such a case, refer to them using [plugin(id, version, group)](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins), which will build `group:id:version` plugin coordinates.

The third possibility is to use the [Custom Plugin Repository](custom-plugin-repository.html) with optional authorization credentials provided by defining the URL to the XML listing file, like:

Kotlin:

```KOTLIN
import org.jetbrains.intellij.platform.gradle.CustomPluginRepositoryType

repositories {
  intellijPlatform {
    customPluginRepository("https://example.com/plugins.xml", CustomPluginRepositoryType.SIMPLE) {
      credentials<HttpHeaderCredentials> {
        name = "Authorization"
        value = "Automation amFrdWJfdGVzdDotX...MkV2UkFwekFWTnNwZjA="
      }
      authentication {
        create<HttpHeaderAuthentication>("header")
      }
    }
  }
}
```

Groovy:

```GROOVY
import com.jetbrains.plugin.structure.intellij.repository.CustomPluginRepositoryListingType

repositories {
  intellijPlatform {
    customPluginRepository('https://example.com/plugins.xml', CustomPluginRepositoryListingType.SIMPLE) { repository ->
      repository.credentials(HttpHeaderCredentials) {
        name = 'Authorization'
        value = 'Automation amFrdWJfdGVzdDotX...MkV2UkFwekFWTnNwZjA='
      }
      authentication {
        create<HttpHeaderAuthentication>("header")
      }
    }
  }
}
```

The final plugin archive is eventually resolved using the same credentials used for resolving the listing.

| Function |Description |
-------------------------
| `marketplace()` |Adds a repository for accessing plugins hosted on [JetBrains Marketplace](https://plugins.jetbrains.com). |
| `customPluginRepository(url, type)` |Creates a custom plugin repository from which plugins can be resolved. Supports optional credentials (e.g., HttpHeaderCredentials). See [Custom Plugin Repository](custom-plugin-repository.html). |

Note:

If using macOS and [Configuration Cache](https://docs.gradle.org/current/userguide/configuration_cache.html) is enabled, see [this FAQ entry](tools-intellij-platform-gradle-plugin-faq.html#external-process-unsupported-macos).

## Additional Repositories

| Function |Description |
-------------------------
| `localPlatformArtifacts()` |Certain dependencies, such as the [local IntelliJ Platform instance](tools-intellij-platform-gradle-plugin.html#dependenciesLocalPlatform) and bundled IDE plugins, need extra pre-processing before they can be correctly used by the IntelliJ Platform Gradle Plugin and loaded by Gradle. This pre-processing involves generating XML files that detail these specific artifacts. Once created, these are stored in a unique custom [Ivy](https://ant.apache.org/ivy/) repository directory.   |
| `intellijDependencies()` |Adds a repository for accessing IntelliJ Platform dependencies. |
| `jetbrainsRuntime()` |Adds a repository for accessing [JetBrains Runtime](ide-development-instance.html#using-a-jetbrains-runtime-for-the-development-instance) releases. |

See also:

* [Plugin Dependencies](plugin-dependencies.html)

Tip: localPlatformArtifacts() and defaultRepositories()

Note that unless using recommended default [defaultRepositories()](#default-repositories),
the [localPlatformArtifacts()](#additional-repositories) entry needs to be added to the `repositories {}` block
explicitly to use local dependencies (bundled plugins, local IDE, custom plugin repositories, etc.).

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

