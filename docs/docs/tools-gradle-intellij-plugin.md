# Gradle IntelliJ Plugin (1.x)

<tldr>
Current Release: 1.17.4

GitHub: [Releases &amp; Changelog](https://github.com/JetBrains/intellij-platform-gradle-plugin/releases), [Issue Tracker](https://github.com/JetBrains/intellij-platform-gradle-plugin/issues)
</tldr>

Warning: Obsolescence Notice

Gradle IntelliJ Plugin (1.x) is no longer under active development.

Whenever possible, use [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html) instead.

The Gradle IntelliJ Plugin is a plugin for the Gradle build system to help configure the environment for building, testing, verifying, and publishing plugins for IntelliJ-based IDEs.

This plugin builds plugins for IntelliJ Platform using specified IntelliJ SDK and bundled or third-party plugins.

The plugin provides functionalities like:

* adding extra IntelliJ-specific dependencies

* patching `processResources` tasks to fill some tags (name, version) in `[plugin.xml](plugin-configuration-file.html)` with appropriate values

* patching compile tasks to instrument code with nullability assertions and form classes made with IntelliJ GUI Designer

* additional build steps that are helpful for developing plugins for the IntelliJ Platform

Tip:

Please see also [Gradle IntelliJ Plugin (1.x) – FAQ](tools-gradle-intellij-plugin-faq.html) and [Gradle IntelliJ Plugin (1.x) – Usage Examples](tools-gradle-intellij-plugin-examples.html).

Before visiting the [Issue Tracker](https://github.com/JetBrains/intellij-platform-gradle-plugin/issues), update both plugin and Gradle to the latest versions.
Please see [CONTRIBUTING](https://github.com/JetBrains/intellij-platform-gradle-plugin/blob/master/CONTRIBUTING.md) on how to submit feedback and contribute to this project.

## Usage

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
[Gradle IntelliJ Plugin (1.x)]()
(Obsolete)
1.10.1+

To enable this plugin in a Gradle-based project, register the plugin in the Gradle build script's `plugins` section:

Kotlin:

```KOTLIN
plugins {
  id("org.jetbrains.intellij") version "1.17.4"
}
```

Groovy:

```GROOVY
plugins {
  id "org.jetbrains.intellij" version "1.17.4"
}
```

When upgrading to `1.x` version, please make sure to follow the [migration guide](https://lp.jetbrains.com/gradle-intellij-plugin) to adjust the existing build script.

Tip: Minimum Gradle Version

This project requires Gradle 7.3 or newer.
However, it is recommended to use the latest Gradle available.
See [Gradle Installation](https://gradle.org/install/) guide.

### IDE Configuration

Some additional settings are required in the IDE after setting up the plugin.

Gradle JVM must be set to Java 11 in `Settings | Build, Execution, Deployment | Build Tools | Gradle`.
When targeting 2022.3+, Java 17 is required instead (see [details](build-number-ranges.html#platformVersions)).

#### Attaching Sources

Tip:

This step is not required when using Gradle IntelliJ Plugin version 1.17.2 or later.

To attach IntelliJ Platform sources in the IDE when enabled via [downloadSources](#intellij-extension-downloadsources) some additional settings are required in IDE versions 2023.2 and later.

2023.3+:

In `Settings | Advanced Settings` enable option Download sources in section `Build Tools. Gradle`.
Then invoke Reload All Gradle Projects action from the Gradle tool window.

2023.2:

In `Settings | Build, Execution, Deployment | Build Tools | Gradle` enable Download sources for dependencies.
Then invoke Reload All Gradle Projects action from the Gradle tool window.

Earlier versions:

No additional IDE settings are required.

### Snapshot Release

The Snapshot release is a pre-release version built nightly from the latest main branch – as it is built every day using the same version number, it's not recommended to use it for production builds.

To switch to the snapshot release, point Gradle to the dedicated snapshot repository by adding an entry to the Gradle settings file.

Note:

The current Gradle IntelliJ Plugin Snapshot version is ![GitHub Snapshot Release](https://img.shields.io/nexus/s/org.jetbrains.intellij/org.jetbrains.intellij.gradle.plugin?server=https://oss.sonatype.org&label=)

To ensure the latest snapshot version is used, invoke Gradle using `--refresh-dependencies` option.

Kotlin:

`build.gradle.kts`

```KOTLIN
plugins {
  id("org.jetbrains.intellij") version "..."
}
```

`settings.gradle.kts`

```KOTLIN
pluginManagement {
  repositories {
    maven("https://oss.sonatype.org/content/repositories/snapshots/")
    gradlePluginPortal()
  }
}
```

Groovy:

`build.gradle`

```GROOVY
plugins {
  id "org.jetbrains.intellij" version "..."
}
```

`settings.gradle`

```GROOVY
pluginManagement {
  repositories {
    maven {
      url 'https://oss.sonatype.org/content/repositories/snapshots/'
    }
    gradlePluginPortal()
  }
}
```

### Configuration Cache

The Gradle build system brings the [Configuration Cache](https://docs.gradle.org/current/userguide/configuration_cache.html) feature that helps improve the build performance by caching the configuration phase.

The Gradle IntelliJ Plugin is fully compatible with this mechanism and can be utilized by manual enabling of the Configuration Cache feature with the `--configuration-cache` flag, like:

```SHELL
gradle buildPlugin --configuration-cache
```

or by enabling it in the `gradle.properties` file:

```PROPERTIES
org.gradle.unsafe.configuration-cache = true
```

See [Using the configuration cache](https://docs.gradle.org/current/userguide/configuration_cache.html#config_cache:usage) in the Gradle documentation for more details.

### Multi-Module Project

Sometimes, it is useful to split the plugin into multiple modules — i.e., to separate the core plugin code from the code related to other third-party plugin dependencies.
The most common way to do this is to use the [Gradle Multi-Project Build](https://docs.gradle.org/current/userguide/multi_project_builds.html) feature.

With this approach, subprojects can declare dependencies on each other, like:

Kotlin:

```KOTLIN
dependencies {
  implementation(project(":shared"))
}
```

Groovy:

```GROOVY
dependencies {
  implementation project(':shared')
}
```

Because the Gradle IntelliJ Plugin introduces the code instrumentation, and the default `implementation` configuration is not compatible with it, specify the `instrumentedJar` configuration explicitly to refer to the instrumented JAR file produced by the plugin instead of the default JAR file:

Kotlin:

```KOTLIN
dependencies {
  implementation(project(":shared", "instrumentedJar"))
}
```

Groovy:

```GROOVY
dependencies {
  implementation project(path: ':shared', configuration: 'instrumentedJar')
}
```

## Configuration

### IntelliJ Extension

After the Gradle IntelliJ Plugin is applied, the `intellij` extension can be used to configure the plugin and common settings of the provided tasks.

It is mandatory to specify at least the [intellij.version](#intellij-extension-version) property.

Example:

Kotlin:

```KOTLIN
intellij {
  version.set("2022.1.1")
  type.set("IU")
  plugins.set(listOf("com.jetbrains.php:221.5787.21"))
}
```

Groovy:

```GROOVY
intellij {
  version = "2022.1.1"
  type = "IU"
  plugins = ["com.jetbrains.php:221.5787.21"]
}
```

#### 

`version`

All available JetBrains IDEs versions can be found in the repositories described on the [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html) page.

The version of the IntelliJ Platform IDE that will be used to build the plugin.
Please see [Plugin Compatibility with IntelliJ Platform Products](plugin-compatibility.html) and [Build Number Ranges](build-number-ranges.html) for more details.

Required
: `true`

Type
: `String`

Acceptable values
: * version number: `2022.1.1` or `IC-2022.1.1`

* build number: `221.5080.210` or `IC-221.5080.210`

* snapshot: `221-EAP-SNAPSHOT` or `LATEST-EAP-SNAPSHOT`

Tip:

The version number format is the most common option for specifying the version of the IntelliJ Platform.
Other formats should be used only when the plugin relies on specific parts of the targeted IDE or early-adopting EAP releases.

#### 

`type`

The type of the IntelliJ-based IDE distribution.
The type may also be specified as a prefix of the value for the [intellij.version](#intellij-extension-version) property instead.

Type
: `String`

Default value
: `IC`

Acceptable values
: * `IU` - [IntelliJ IDEA Ultimate Edition](idea.html)

* `CL` - [CLion](clion.html)

* `PY` - [PyCharm Professional Edition](pycharm.html)

* `PS` - [PhpStorm](phpstorm.html)

* `RD` - [Rider](rider.html)

* `GO` - [GoLand](goland.html)

* `AI` - [Android Studio](android-studio.html)

* `RR` - [Rust Rover](https://www.jetbrains.com/rust/)

* `JPS` - JPS-only

* `GW` - Gateway

To build against IDEs not supported directly by `type`, please see their corresponding page in Product Specific.

#### 

`pluginName`

The plugin name part used in the generated ZIP distribution: `build/distributions/PluginName-1.0.0.zip`, and the name of the plugin directory in the sandbox directory.

Type
: `String`

Default value
: `${project.name}`

#### 

`localPath`

The path to the locally installed IDE distribution that should be used to build the plugin.
Using `intellij.localPath` allows building the plugin using an IDE that is not available in [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html).

Type
: `String`

Default value
: `null`

Samples
: * Windows: `C:\Users\user\AppData\Local\JetBrains\Toolbox\apps\IDEA-U\ch-0\211.7142.45`

* macOS: `/Applications/Android Studio 4.2 Preview.app/Contents` (note `/Contents` suffix)

* Linux: `/home/user/idea-IC-181.4445.78`

Warning:

`intellij.version` and `intellij.localPath` must not be specified at the same time.

#### 

`localSourcesPath`

The path to local archive with IDE sources.
Used for resolving source files of the locally installed IDE distribution when [intellij.localPath](#intellij-extension-localpath) is specified.

Type
: `String`

Default value
: `null`

#### 

`plugins`

The list of bundled IDE plugins and plugins from [JetBrains Marketplace](https://plugins.jetbrains.com) or configured [intellij.pluginsRepositories](#intellij-extension-pluginsrepositories).

Please see [Plugin Dependencies](plugin-dependencies.html) for more details.

Notes:

* For plugins from [JetBrains Marketplace](https://plugins.jetbrains.com), use the `pluginId:version` format, like `org.intellij.plugins.markdown:231.8109.126`. The chosen version must be compatible with the version of the target IDE.

* For bundled plugins, use the plugin ID with the version part omitted, like: `org.intellij.groovy`.

* For subprojects, use project reference `project(':subproject', 'instrumentedJar')`.

* For plugin built locally, pass the path to the `lib/` directory of the extracted plugin archive, like: `file("/path/to/plugin/lib/")` or `file("/projects/plugin-name/build/idea-sandbox/plugins/plugin-name/lib/")`. See [How to add a dependency on a plugin available in the file system?](tools-gradle-intellij-plugin-faq.html#how-to-add-a-dependency-on-a-plugin-available-in-the-file-system).

* To refer to the plugin's classes from the project, also define a dependency in the `[plugin.xml](plugin-configuration-file.html)` file, see [Plugin Dependencies](plugin-dependencies.html).

Type
: `List<Any>`

Default value
: `[]`

Acceptable values
: * `org.plugin.id:version[@channel]` format, `String` type: * `org.intellij.plugins.markdown:8.5.0` * `org.intellij.scala:2017.2.638@nightly`

* `bundledPluginId` format, `String` type: * `org.intellij.groovy`

* `project(...)` format, `Project` type: * `project(":projectName", "instrumentedJar")` * `project(":plugin-subproject", "instrumentedJar")`

* `file(...)` format, `File` type: * `file("/path/to/plugin/lib/")` * `file("/projects/plugin-name/build/idea-sandbox/plugins/plugin-name/lib/")`

#### 

`updateSinceUntilBuild`

Enables patching `[plugin.xml](plugin-configuration-file.html)` with the values of [patchPluginXml.sinceBuild](#tasks-patchpluginxml-sincebuild) and [patchPluginXml.untilBuild](#tasks-patchpluginxml-untilbuild) properties.

Type
: `Boolean`

Default value
: `true`

#### 

`sameSinceUntilBuild`

Enables patching `[plugin.xml](plugin-configuration-file.html)` with the [patchPluginXml.untilBuild](#tasks-patchpluginxml-untilbuild) using value of [patchPluginXml.sinceBuild](#tasks-patchpluginxml-sincebuild) with `*` wildcard, like `sinceBuild.*`, e.g., `221.*`.

Notes:

* Useful for building plugins against EAP builds.

* If [patchPluginXml.untilBuild](#tasks-patchpluginxml-untilbuild) has a value set, then [intellij.sameSinceUntilBuild](#intellij-extension-samesinceuntilbuild) is ignored.

Type
: `Boolean`

Default value
: `false`

#### 

`instrumentCode`

Enables the instrumentation of Java classes with [nullability](https://www.jetbrains.com/help/idea/nullable-and-notnull-annotations.html) assertions and compilation of forms created by [IntelliJ GUI Designer](https://www.jetbrains.com/help/idea/gui-designer-basics.html).

Type
: `Boolean`

Default value
: `true`

#### 

`sandboxDir`

The path of [sandbox directory](ide-development-instance.html#the-development-instance-sandbox-directory) that is used for running IDE with developed plugin.

Type
: `String`

Default value
: `${project.buildDir}/idea-sandbox`

#### 

`intellijRepository`

The IntelliJ-based IDE distributions repository URL.

Type
: `String`

Default value
: `https://cache-redirector.jetbrains.com/www.jetbrains.com/intellij-repository`

#### 

`pluginsRepositories`

Configures repositories for downloading plugin dependencies.
See [Maven Interface](https://plugins.jetbrains.com/docs/marketplace/maven-interface.html) for details on Maven repository format.

Type
: `PluginsRepositoryConfiguration`

Default value
: `pluginsRepositories { marketplace() }`

Acceptable values
: * `marketplace()` - use Maven repository with plugins listed in [JetBrains Marketplace](https://plugins.jetbrains.com)

* `maven(repositoryUrl)` - use custom Maven repository with plugins

* `maven { repositoryUrl }` - use custom Maven repository with plugins and configurable additional parameters (credentials, authentication, etc.)

* `custom(pluginsXmlUrl)` - use [Custom Plugin Repository](custom-plugin-repository.html)

#### 

`jreRepository`

URL of repository for downloading [JetBrains Runtime](ide-development-instance.html#using-a-jetbrains-runtime-for-the-development-instance).

Type
: `String`

Default value
: `null`

#### 

`ideaDependencyCachePath`

Path to the directory where the IDE dependency cache is stored.
If not set, the dependency will be extracted next to the downloaded ZIP archive in [Gradle cache](https://docs.gradle.org/current/userguide/directory_layout.html#dir:gradle_user_home) directory.

Type
: `String`

Default value
: `null`

#### 

`downloadSources`

Enables downloading the IntelliJ Platform sources.
It is enabled by default if the `CI` environment variable is not set – which is present in Continuous Integration environments, like GitHub Actions, TeamCity, and others.

Type
: `Boolean`

Default value
: `!System.getenv().containsKey("CI")`

#### 

`configureDefaultDependencies`

Enables configuration of the default IntelliJ Platform dependencies in the current project.
Otherwise, the `DependenciesUtils.intellij()`, `DependenciesUtils.intellijPlugin()`, and `DependenciesUtils.intellijPlugins()` functions could be used for an explicit configuration.

Type
: `Boolean`

Default value
: `true`

#### 

`extraDependencies`

Configure extra dependency artifacts from the IntelliJ repository.
The dependencies on them could be configured only explicitly using the `DependenciesUtils.intellijExtra()` function in the `dependencies` block.

Type
: `List<String>`

Default value
: `[]`

#### 

`pluginDependencies`

List of dependencies on external plugins.

Type
: `List<PluginDependency>`

Default value
: `[]`

## Tasks

### 

`buildPlugin`

Assembles a plugin and prepares ZIP archive for [deployment](publishing-plugin.html).

`buildPlugin` task extends the [Zip](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.bundling.Zip.html) Gradle task.

Warning: Do Not Repackage Libraries

Do not repackage libraries into the main plugin JAR file.
Otherwise, [Plugin Verifier](verifying-plugin-compatibility.html) will yield false positives for unresolved classes and methods.

#### 

`archiveBaseName`

The base name of the ZIP archive.

This task is preconfigured automatically and takes the output artifacts of [prepareSandbox](#tasks-preparesandbox) and [jarSearchableOptions](#tasks-jarsearchableoptions) tasks as an input.

Type
: `String`

Default value
: `${prepareSandboxTask.pluginName}`

### 

`buildSearchableOptions`

Builds an index of UI components (searchable options) for the plugin.
This task runs a headless IDE instance to collect all the available options provided by the plugin's [Settings](settings.html).

Note, this is a [runIde](#tasks-runide)-based task with predefined arguments and all properties of the [runIde](#tasks-runide) task are also applied to [buildSearchableOptions](#tasks-buildsearchableoptions) tasks.

Tip:

If the plugin doesn't implement custom settings, it is recommended to [disable it](tools-gradle-intellij-plugin-faq.html#how-to-disable-building-searchable-options).
See also [noSearchableOptionsWarning](tools-gradle-intellij-plugin-build-features.html#nosearchableoptionswarning) build feature.

#### 

`outputDir`

Type
: `File`

Default value
: `build/searchableOptions`

### 

`classpathIndexCleanup`

Remove `classpath.index` files that are created by the `PathClassLoader`.
This loader, due to the implementation bug, ignores the `idea.classpath.index.enabled=false` flag and as a workaround, files have to be removed manually.

Task is enabled if [intellij.version](#intellij-extension-version) is set to `2022.1` or higher.

#### 

`classpathIndexFiles`

The list of `classpath.index` files to be removed.

Type
: `ConfigurableFileCollection`

Default value:
: List of `classpath.index` files resolved with `sourceSets` configuration

### 

`downloadRobotServerPlugin`

Download the `robot-server` plugin.
The `robot-server` plugin is required for running the UI tests using the [runIdeForUiTests](#tasks-runideforuitests) task.

#### 

`version`

The version of the Robot Server Plugin to download.

Type
: `String`

Default value
: `LATEST`

#### 

`pluginArchive`

The Robot Server Plugin archive, downloaded by default to the [Gradle cache](https://docs.gradle.org/current/userguide/directory_layout.html#dir:gradle_user_home).

Type
: `File`

Default value
: [Gradle cache](https://docs.gradle.org/current/userguide/directory_layout.html#dir:gradle_user_home)

#### 

`outputDir`

Location of the extracted archive.

Type
: `File`

Default value
: `build/robotServerPlugin`

### 

`downloadZipSignerTask`

Resolves and downloads Marketplace ZIP Signer CLI tool used by the [signPlugin](#tasks-signplugin) task.

#### 

`version`

Version of the ZIP Signer CLI tool to download.

Type
: `String`

Default value
: `LATEST`

#### 

`cliPath`

Path to the ZIP Signer CLI tool.

Type
: `File`

Default value
: [Gradle cache](https://docs.gradle.org/current/userguide/directory_layout.html#dir:gradle_user_home)

#### 

`cli`

The output of the ZIP Signer CLI tool.

Type
: `File`

Default value
: [cliPath](#tasks-downloadzipsignertask-clipath)

### 

`initializeIntelliJPlugin`

Initializes the Gradle IntelliJ Plugin and performs various checks, like if the plugin is up-to-date.

### 

`instrumentCode`

The following attributes tune instrumenting behavior in the `instrumentCode { ... }` block.

#### 

`ideaDependency`

The dependency on IntelliJ IDEA.

Type
: `IdeaDependency`

Default value
: [intellij.ideaDependency](#tasks-setupdependencies-idea)

#### 

`javac2`

Path to the `javac2.jar` file of IntelliJ IDEA.

Type
: `File`

Default value
: `lib/javac2.jar` resolved in [instrumentCode.ideaDependency](#tasks-instrumentcode-ideadependency)

#### 

`compilerVersion`

A version of instrumenting compiler.
It's used in cases when targeting non-IntelliJ IDEA IDEs (e.g., [CLion](clion.html) or [Rider](rider.html)).

Type
: `String`

Default value
: Build number of the IDE dependency

#### 

`classesDirs`

The list of directories with compiled classes.

Type
: `FileCollection`

Default value
: `sourceSets.[].output.classesDirs`

#### 

`formDirs`

The list of directories with GUI Designer form files.

Type
: `FileCollection`

Default value
: `.form` files of the project's source sets.

#### 

`outputDir`

The output directory for instrumented classes.

Type
: `File`

Default value
: [setupInstrumentCode.instrumentedDir](#tasks-setupinstrumentcode-instrumenteddir)

#### 

`compilerClassPathFromMaven`

The classpath for Java instrumentation compiler.

Type
: `FileCollection`

### 

`instrumentedJar`

Create a JAR file with instrumented classes.

### 

`jarSearchableOptions`

Create a JAR file with searchable options to be distributed with the plugin.

#### 

`outputDir`

The output directory where the JAR file will be created.

Type
: `String`

Default value
: `build/searchableOptions`

#### 

`pluginName`

The name of the plugin.

Type
: `String`

Default value
: [intellij.pluginName](#intellij-extension-pluginname)

#### 

`sandboxDir`

The sandbox output directory.

Type
: `String`

Default value
: [prepareSandbox.outputDir](#tasks-preparesandbox)

### 

`listBundledPlugins`

Lists all IDs of plugins bundled within the currently targeted IDE.
This can be used to determine Plugin ID for setting up [Plugin Dependencies](plugin-dependencies.html).

See also [printBundledPlugins](#tasks-printBundledPlugins).

#### 

`ideDir`

The IDE dependency sources path.
Configured automatically with the [setupDependencies.idea](#tasks-setupdependencies-idea) dependency.

Type
: `File`

Default value
: [setupDependencies.idea](#tasks-setupdependencies-idea)

#### 

`outputFile`

Path to the file, where the output list will be stored.

Type
: `File`

Default value
: `File("${project.buildDir}/listBundledPlugins.txt")`

### 

`listProductsReleases`

List all available IntelliJ-based IDE releases with their updates.
The result list is used for testing the plugin with Plugin Verifier using the [runPluginVerifier](#tasks-runpluginverifier) task.

Plugin Verifier requires a list of the IDEs that will be used for verifying the plugin build against.
The availability of the releases may change in time, i.e., due to security issues in one version – which will be later removed and replaced with an updated IDE release.

With the [listProductsReleases](#tasks-listproductsreleases) task, it is possible to list the currently available IDEs matching given conditions, like platform types, since/until release versions.
Such a list is fetched from the remote updates file: `https://www.jetbrains.com/updates/updates.xml`, parsed and filtered considering the specified [listProductsReleases.types](#tasks-listproductsreleases-types), [listProductsReleases.sinceVersion](#tasks-listproductsreleases-sinceversion), [listProductsReleases.untilVersion](#tasks-listproductsreleases-untilversion) (or [listProductsReleases.sinceBuild](#tasks-listproductsreleases-sincebuild), [listProductsReleases.untilBuild](#tasks-listproductsreleases-untilbuild)) properties.

The result list is stored within the [listProductsReleases.outputFile](#tasks-listproductsreleases-outputfile), which is used as a source for the Plugin Verifier if the [runPluginVerifier](#tasks-runpluginverifier) task has no [runPluginVerifier.ideVersions](#tasks-runpluginverifier-ideversions) property specified, the output of the [listProductsReleases](#tasks-listproductsreleases) task is used.

See also [printProductsReleases](#tasks-printproductsreleases).

#### 

`productsReleasesUpdateFiles`

Path to the products releases update files. By default, one is downloaded from `IntelliJPluginConstants.IDEA_PRODUCTS_RELEASES_URL`.

Type
: `FileCollection`

Default value
: [Gradle cache](https://docs.gradle.org/current/userguide/directory_layout.html#dir:gradle_user_home)

#### 

`types`

List of types of IDEs that will be listed in results.

Type
: `List<String>`

Default value
: [intellij.type](#intellij-extension-type)

#### 

`sinceVersion`

Lower boundary of the listed results in product marketing version format, e.g., `2020.2.1`.
It takes precedence over the [listProductsReleases.sinceBuild](#tasks-listproductsreleases-sincebuild) property.

Type
: `String`

Default value
: [intellij.version](#intellij-extension-version)

#### 

`untilVersion`

Upper boundary of the listed results in product marketing version format, e.g., `2020.2.1`.
It takes precedence over the [listProductsReleases.untilBuild](#tasks-listproductsreleases-untilbuild) property.

Type
: `String`

Default value
: `null`

#### 

`sinceBuild`

Lower boundary of the listed results in build number format, like `192`.

Type
: `String`

Default value
: [intellij.version](#intellij-extension-version)

#### 

`untilBuild`

Upper boundary of the listed results in build number format, like `192`.

Type
: `String`

Default value
: `null`

#### 

`releaseChannels`

Release channels that product updates will be filtered with.

Type
: `Channel`

Default value
: `EnumSet.allOf(ListProductsReleasesTask.Channel)`

#### 

`outputFile`

Path to the file, where the output list will be stored.

Type
: `File`

Default value
: `File("${project.buildDir}/listProductsReleases.txt")`

#### 

`androidStudioUpdatePath`

For [Android Studio releases](android-studio-releases-list.html), a separated storage for the updates is used.

Type
: `String`

Default value
: `https://raw.githubusercontent.com/JetBrains/intellij-sdk-docs/main/topics/_generated/android_studio_releases.xml`

### 

`patchPluginXml`

Patches `[plugin.xml](plugin-configuration-file.html)` files with values provided to the task.

Note:

To maintain and generate an up-to-date changelog, try using the [Gradle Changelog Plugin](https://github.com/JetBrains/gradle-changelog-plugin).

#### 

`destinationDir`

The directory where the patched `[plugin.xml](plugin-configuration-file.html)` will be written.

Type
: `String`

Default value
: `${project.buildDir}/patchedPluginXmlFiles`

#### 

`pluginXmlFiles`

The list of `[plugin.xml](plugin-configuration-file.html)` files to patch.

Type
: `List<File>`

Default value
: auto-discovered from the project

#### 

`pluginDescription`

The description of the plugin used in the [&lt;description&gt;](plugin-configuration-file.html#idea-plugin__description) tag.

Type
: `String`

Default value
: `null`

#### 

`sinceBuild`

The lower bound of the [version range](build-number-ranges.html) to be patched used in the `since-build` attribute of the [&lt;idea-version&gt;](plugin-configuration-file.html#idea-plugin__idea-version) tag.

Type
: `String`

Default value
: [intellij.version](#intellij-extension-version) in `Branch.Build.Fix` format

#### 

`untilBuild`

The upper bound of the [version range](build-number-ranges.html) to be patched used in the `until-build` attribute of the [&lt;idea-version&gt;](plugin-configuration-file.html#idea-plugin__idea-version) tag.

Type
: `String`

Default value
: [intellij.version](#intellij-extension-version) in `Branch.Build.*` format

#### 

`version`

The version of the plugin used in the [&lt;version&gt;](plugin-configuration-file.html#idea-plugin__version) tag.

Type
: `String`

Default value
: `${project.version}`

#### 

`changeNotes`

The change notes of the plugin used in the [&lt;change-notes&gt;](plugin-configuration-file.html#idea-plugin__change-notes) tag.

Type
: `String`

Default value
: `null`

#### 

`pluginId`

The ID of the plugin used in the [&lt;id&gt;](plugin-configuration-file.html#idea-plugin__id) tag.

Type
: `String`

Default value
: `null`

### 

`prepareSandbox`

Prepares the sandbox directory with the installed plugin and its dependencies.

#### 

`pluginName`

The name of the plugin.

Type
: `String`

Default value
: [intellij.pluginName](#intellij-extension-pluginname)

#### 

`configDir`

The directory with the plugin configuration.

Type
: `String`

Default value
: `${intellij.pluginName}/config`

#### 

`pluginJar`

The input plugin JAR file used to prepare the sandbox.

Type
: `File`

Default value
: output of the `jar` task

#### 

`librariesToIgnore`

Libraries that will be ignored when preparing the sandbox.
By default, it excludes all libraries that are a part of the [setupDependenciesTask.idea](#tasks-setupdependencies-idea) dependency.

Type
: `List<File>`

Default value
: `org.jetbrains.intellij.tasks.SetupDependenciesTask.idea.get().jarFiles`

#### 

`pluginDependencies`

List of dependencies on external plugins.

Type
: `List<PluginDependency>`

Default value
: `org.jetbrains.intellij.IntelliJPluginExtension.getPluginDependenciesList`

### 

`prepareTestingSandbox`

Prepares the sandbox directory with the installed plugin and its dependencies for testing purposes.

See [prepareSandbox Task](#tasks-preparesandbox).

### 

`prepareUiTestingSandbox`

Prepares the sandbox directory with the installed plugin and its dependencies for UI testing purposes.

See [prepareSandbox Task](#tasks-preparesandbox).

### 

`printProductsReleases`

Print the output produced by the [listProductsReleases](#tasks-listproductsreleases) task.

#### 

`inputFile`

Output file provided by the [listProductsReleases](#tasks-listproductsreleases) task.

### 

`printBundledPlugins`

Print the output produced by the [listBundledPlugins](#tasks-listbundledplugins) task.

#### 

`inputFile`

Output file provided by the [listBundledPlugins](#tasks-listbundledplugins) task.

### 

`publishPlugin`

Publishes plugin to the remote [JetBrains Marketplace](https://plugins.jetbrains.com) repository.

The following attributes are a part of the Publishing DSL `publishPlugin { ... }` in which allows Gradle to upload plugin to [JetBrains Marketplace](https://plugins.jetbrains.com).
Note that the plugin must be [uploaded](publishing-plugin.html#uploading-a-plugin-to-jetbrains-marketplace) to the repository at least once manually (to specify options like the license, repository URL, etc.) before uploads through Gradle can be used.

See the instruction on [how to generate authentication token](https://plugins.jetbrains.com/docs/marketplace/plugin-upload.html).

See the [Publishing Plugin With Gradle](publishing-plugin.html#publishing-plugin-with-gradle) tutorial for step-by-step instructions.

#### 

`token`

Authentication token.

Required

Type
: `String`

Default value
: `null`

#### 

`channels`

List of channel names to upload plugin to.

Type
: `List<String>`

Default value
: `["default"]`

#### 

`hidden`

Mark the release as hidden to prevent public release after approval.
See [Hidden release](https://plugins.jetbrains.com/docs/marketplace/hidden-plugin.html) in JetBrains Marketplace docs.

Type
: `Boolean`

Default value
: `false`

#### 

`host`

URL host of a plugin repository.

Type
: `String`

Default value
: [JetBrains Marketplace](https://plugins.jetbrains.com)

#### 

`distributionFile`

ZIP file of plugin to upload.

Type
: `File`

Default value
: output of the [buildPlugin](#tasks-buildplugin) task

#### 

`ideServices`

Specifies if the IDE Services plugin repository service should be used.
This feature is still in the incubating phase and is not yet available for public use.

Type
: `Boolean`

Default value
: `false`

### 

`runIde`

Run the IDE instance with the developed plugin installed.

`runIde` task extends the [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html) Gradle task – all properties available in the `JavaExec` as well as the following ones can be used to configure the `runIde` task.

#### 

`ideDir`

The IDE dependency sources path.
Configured automatically with the [setupDependencies.idea](#tasks-setupdependencies-idea) dependency.

Type
: `File`

Default value
: [setupDependencies.idea](#tasks-setupdependencies-idea)

#### 

`jbrVersion`

Custom JetBrains Runtime (JBR) version to use for running the IDE.

Type
: `String`

Default value
: `null`

Accepted values
: * `8u112b752.4`

* `8u202b1483.24`

* `11_0_2b159`

Note:

For more information about JBR versions and variants, see [Using a JetBrains Runtime for the Development Instance](ide-development-instance.html#using-a-jetbrains-runtime-for-the-development-instance).

#### 

`jbrVariant`

JetBrains Runtime (JBR) variant to use when running the IDE with the plugin.

Type
: `String`

Default value
: `null`

#### 

`jbrArch`

JetBrains Runtime architecture.
By default, it's resolved based on the current OS and JRE architecture.

Type
: `String`

Default value
: `null`

#### 

`pluginsDir`

Path to the `plugins` directory within the sandbox prepared with the [prepareSandbox](#tasks-preparesandbox) task.
Provided to the `idea.plugins.path` system property.

Type
: `Directory`

Default value
: [prepareSandbox.destinationDir](#tasks-preparesandbox)

#### 

`autoReloadPlugins`

Enables auto-reload of dynamic plugins.
Dynamic plugins will be reloaded automatically when their JARs are modified.
This allows a much faster development cycle by avoiding a full restart of the development instance after code changes.
Enabled by default in 2020.2 and higher.

See [Enabling Auto-Reload](ide-development-instance.html#enabling-auto-reload) for more details.

Type
: `Boolean`

Default value
: `true`

### 

`runIdeForUiTests`

Run the IDE instance with the developed plugin and robot-server installed and ready for UI testing.

See [intellij-ui-test-robot](https://github.com/JetBrains/intellij-ui-test-robot) project.

See [runIde](#tasks-runide) task for more details.

### 

`runIdePerformanceTest`

Run performance tests on the IDE with the developed plugin installed.

The `runIdePerformanceTest` task extends the `RunIdeBase` task, so all configuration attributes of `JavaExec` and [runIde](#tasks-runide) tasks can be used in the `runIdePerformanceTest` as well.
See [runIde](#tasks-runide) task for more details.

Currently, the task is under adaptation; more documentation will be added in the future.

#### 

`testDataDir`

Path to directory with test projects and `.ijperf` files.

Type
: `String`

Default value
: `null`

#### 

`artifactsDir`

Path to the directory where performance test artifacts (IDE logs, snapshots, screenshots, etc.) will be stored.
If the directory doesn't exist, it will be created.

Type
: `String`

Default value
: `null`

#### 

`profilerName`

Name of the profiler which will be used during execution.

Type
: `ProfilerName`

Default value
: `ProfilerName.ASYNC`

Acceptable values
: * `ProfilerName.ASYNC`

* `ProfilerName.YOURKIT`

### 

`runPluginVerifier`

Run the [IntelliJ Plugin Verifier](https://github.com/JetBrains/intellij-plugin-verifier) tool to check the binary compatibility with specified IDE builds (see also [Verifying Plugin Compatibility](verifying-plugin-compatibility.html)).

Plugin Verifier DSL `runPluginVerifier { ... }` allows to define the list of IDEs used for the verification, as well as explicit tool version and any of the available [options](https://github.com/JetBrains/intellij-plugin-verifier#common-options) by proxifying them to the Verifier CLI.

Tip:

For more details, examples or issues reporting, go to the [IntelliJ Plugin Verifier](https://github.com/JetBrains/intellij-plugin-verifier) repository.

Tip:

To run Plugin Verifier in [-offline](https://github.com/JetBrains/intellij-plugin-verifier/pull/58) mode, set the Gradle [offline start parameter](https://docs.gradle.org/current/javadoc/org/gradle/StartParameter.html#setOffline-boolean-).

#### 

`ideVersions`

The IDEs to be checked in [intellij.version](#intellij-extension-version) format, i.e.: `["IC-2019.3.5", "PS-2019.3.2"]`.
Check the available build versions on [IntelliJ Platform Builds list](https://jb.gg/intellij-platform-builds-list).

Type
: `List<String>`

Default value
: output of the [listProductsReleases](#tasks-listproductsreleases) task

#### 

`verifierVersion`

IntelliJ Plugin Verifier version.
Do not change unless absolutely required.

Type
: `String`

Default value
: `LATEST`

#### 

`verifierPath`

Local path to the pre-downloaded IntelliJ Plugin Verifier JAR file.
If set, [runPluginVerifier.verifierVersion](#tasks-runpluginverifier-verifierversion) is ignored.

Type
: `String`

Default value
: path to the JAR file resolved using the [runPluginVerifier.verifierVersion](#tasks-runpluginverifier-verifierversion) property

#### 

`localPaths`

A list of the paths to locally installed IDE distributions that should be used for verification in addition to those specified in [runPluginVerifier.ideVersions](#tasks-runpluginverifier-ideversions).

Type
: `List<File>`

Default value
: `[]`

#### 

`distributionFile`

ZIP file of the plugin to verify.
If empty, the task will be skipped.

Type
: `File`

Default value
: output of the `buildPlugin` task

#### 

`failureLevel`

Defines the verification level at which the task should fail if any reported issue matches.
Can be set as `FailureLevel` or `EnumSet<FailureLevel>`.

Type
: `org.jetbrains.intellij.tasks.RunPluginVerifierTask.FailureLevel`

Default value
: `FailureLevel.COMPATIBILITY_PROBLEMS`

Accepted values
: * `FailureLevel.COMPATIBILITY_WARNINGS` - Compatibility warnings detected against the specified IDE version.

* `FailureLevel.COMPATIBILITY_PROBLEMS` - Compatibility problems detected against the specified IDE version.

* `FailureLevel.DEPRECATED_API_USAGES` - Plugin uses API marked as deprecated (`@Deprecated`).

* `FailureLevel.SCHEDULED_FOR_REMOVAL_API_USAGES` - Plugin uses API marked as scheduled for removal (`@ApiStatus.ScheduledForRemoval`).

* `FailureLevel.EXPERIMENTAL_API_USAGES` - Plugin uses API marked as experimental (`@ApiStatus.Experimental`).

* `FailureLevel.INTERNAL_API_USAGES` - Plugin uses API marked as internal (`@ApiStatus.Internal`).

* `FailureLevel.OVERRIDE_ONLY_API_USAGES` - Override-only API is used incorrectly (`@ApiStatus.OverrideOnly`).

* `FailureLevel.NON_EXTENDABLE_API_USAGES` - Non-extendable API is used incorrectly (`@ApiStatus.NonExtendable`).

* `FailureLevel.PLUGIN_STRUCTURE_WARNINGS` - The structure of the plugin is not valid.

* `FailureLevel.MISSING_DEPENDENCIES` - Plugin has some dependencies missing.

* `FailureLevel.INVALID_PLUGIN` - "Provided plugin artifact is not valid."

* `FailureLevel.NOT_DYNAMIC` - "Plugin cannot be loaded/unloaded without IDE restart."

* `FailureLevel.ALL` - All of the above

* `FailureLevel.NONE` - None of the above

#### 

`verificationReportsDir`

The path to the directory where verification reports will be saved.

Type
: `String`

Default value
: `${project.buildDir}/reports/pluginVerifier`

#### 

`verificationReportsFormats`

The output formats of the verification reports that will be emitted.

Type
: `List<String>`

Default value
: `["plain", "html"]`

Acceptable values
: * `plain` (console output)

* `html` (HTML format)

* `markdown` (Markdown format)

#### 

`downloadDir`

The path to the directory where IDEs used for the verification will be downloaded.
By default, it relies on the `plugin.verifier.home.dir` system property and falls back to the `XDG_CACHE_HOME` environment variable – see [XDG Base Directory](https://wiki.archlinux.org/title/XDG_Base_Directory) for more details.

Type
: `String`

Default value
: `System.getProperty("plugin.verifier.home.dir")/ides`, `System.getenv("XDG_CACHE_HOME")/pluginVerifier/ides`, `System.getProperty("user.home")/.cache/pluginVerifier/ides` or system temporary directory.

#### 

`jbrVersion`

Custom JetBrains Runtime (JBR) version to use for running the verification.

Type
: `String`

Default value
: `null`

Acceptable values
: * `8u112b752.4`

* `8u202b1483.24`

* `11_0_2b159`

Note:

For more information about JBR versions and variants, see [Using a JetBrains Runtime for the Development Instance](ide-development-instance.html#using-a-jetbrains-runtime-for-the-development-instance).

#### 

`jbrVariant`

JetBrains Runtime (JBR) variant to use when running the verification.

Type
: `String`

Default value
: `null`

#### 

`jbrArch`

JetBrains Runtime architecture.
By default, it's resolved based on the current OS and JRE architecture.

Type
: `String`

Default value
: `null`

#### 

`runtimeDir`

The path to the directory containing the JVM runtime. Overrides [runPluginVerifier.jbrVersion](#tasks-runpluginverifier-jbrversion).

Type
: `String`

Default value
: `null`

#### 

`externalPrefixes`

The list of class prefixes from the external libraries.
The Plugin Verifier will not report `No such class` for classes of these packages.

Type
: `List<String>`

Default value
: `[]`

#### 

`ignoredProblems`

A file that contains a list of problems that will be ignored in the verification report.
It must contain lines in form `<plugin_xml_id>:<plugin_version>:<problem_description_regexp_pattern>`.

Type
: `File`

Default value
: `null`

#### 

`teamCityOutputFormat`

A flag that controls the output format - if set to `true`, the [TeamCity Tests Format](https://www.jetbrains.com/help/teamcity/service-messages.html) – the TeamCity compatible output will be returned to stdout.

Type
: `Boolean`

Default value
: `false`

#### 

`subsystemsToCheck`

Specify which subsystems of the IDE should be checked.

Type
: `String`

Default value
: `all`

Acceptable values
: * `all`

* `android-only`

* `without-android`

#### 

`freeArgs`

Arbitrary command line arguments that are passed to the IntelliJ Plugin Verifier as is in addition to the arguments provided by the Plugin Verifier DSL.

Arguments that require a value must be provided in the separate elements of the list.

Type
: `List<String>`

Default value
: `[]`

Acceptable values
: * `["-team-city"]` as a switch

* `["-suppress-internal-api-usages", "jetbrains-plugins"]` as an argument with a value

### 

`setupDependencies`

Setup required dependencies for building and running the project.
This task is automatically added to the [&quot;After Sync&quot; Gradle trigger](https://www.jetbrains.com/help/idea/work-with-gradle-tasks.html#config_triggers_gradle) to make the IntelliJ SDK dependency available for IntelliJ IDEA right after the Gradle synchronization.

Warning:

After removing the Gradle IntelliJ Plugin from the project, the `Task 'setupDependencies' not found in root project` exception may occur.
See [Frequently Asked Questions](tools-gradle-intellij-plugin-faq.html#task-setupdependencies-not-found-in-root-project) for more details.

#### 

`idea`

This task exposes the `setupDependencies.idea` property which contains a reference to the resolved IDE dependency used for building the plugin.

This property can be referred in Gradle configuration to access IDE dependency classpath.

### 

`setupInstrumentCode`

Prepares code instrumentation tasks.

#### 

`instrumentationEnabled`

A flag that controls whether code instrumentation is enabled.

Type
: `Boolean`

Default value
: [intellij.instrumentCode](#intellij-extension-instrumentcode)

#### 

`instrumentedDir`

The path to the directory where instrumented classes will be saved.

Type
: `Directory`

Default value
: `${project.buildDir}/instrumented`

### 

`signPlugin`

Sign the ZIP archive with the provided key using the [marketplace-zip-signer](https://github.com/JetBrains/marketplace-zip-signer) library.

To sign the plugin before publishing to [JetBrains Marketplace](https://plugins.jetbrains.com) with the [signPlugin](#tasks-signplugin) task, it is required to provide a certificate chain and a private key with its password using `signPlugin { ... }` Plugin Signing DSL.

As soon as [signPlugin.privateKey](#tasks-signplugin-privatekey) (or [signPlugin.privateKeyFile](#tasks-signplugin-privatekeyfile)) and [signPlugin.certificateChain](#tasks-signplugin-certificatechain) (or [signPlugin.certificateChainFile](#tasks-signplugin-certificatechainfile)) properties are specified, the task will be executed automatically right before the [publishPlugin](#tasks-publishplugin) task.

For more details, see [Plugin Signing](plugin-signing.html) article.

#### 

`certificateChain`

A string containing X509 certificates.
The first certificate from the chain will be used as a certificate authority (CA).
Refers to `cert` CLI option.

Note:

This property accepts value provided as a plain text or base64-encoded string.

Type
: `String`

Default value
: `null`

#### 

`certificateChainFile`

A file containing X509 certificates.
The first certificate from the chain will be used as a certificate authority (CA).
Refers to `cert-file` CLI option.

Type
: `File`

Default value
: `null`

#### 

`privateKey`

Encoded private key in PEM format.
Refers to `key` CLI option.

Note:

This property accepts value provided as a plain text or base64-encoded string.

Type
: `String`

Default value
: `null`

#### 

`privateKeyFile`

A file with the encoded private key in PEM format.
Refers to `key-file` CLI option.

Type
: `File`

Default value
: `null`

#### 

`password`

Password required to decrypt the private key.
Refers to `key-pass` CLI option.

Type
: `String`

Default value
: `null`

#### 

`cliVersion`

Returns the version of [JetBrains Marketplace ZIP Signer CLI](https://github.com/JetBrains/marketplace-zip-signer) that will be used.

Type
: `String`

Default value
: `LATEST`

#### 

`cliPath`

Path to [JetBrains Marketplace ZIP Signer CLI](https://github.com/JetBrains/marketplace-zip-signer) file.
Takes precedence over [signPlugin.cliVersion](#tasks-signplugin-cliversion).

Type
: `String`

Default value
: `null`

#### 

`keyStore`

KeyStore file path.
Refers to `ks` CLI option.

Type
: `String`

Default value
: `null`

#### 

`keyStorePassword`

KeyStore password.

Type
: `String`

Default value
: `null`

#### 

`keyStoreKeyAlias`

KeyStore key alias.
Refers to `ks-key-alias` CLI option.

Type
: `String`

Default value
: `null`

#### 

`keyStoreType`

KeyStore type.

Type
: `String`

Default value
: `null`

#### 

`keyStoreProviderName`

JCA KeyStore Provider name.
Refers to `ks-provider-name` CLI option.

Type
: `String`

Default value
: `null`

#### 

`inputArchiveFile`

Input, unsigned ZIP archive file.
Refers to `in` CLI option.

Provided by the [buildPlugin](#tasks-buildplugin) task.

#### 

`outputArchiveFile`

Output, signed ZIP archive file.
Refers to `out` CLI option.

Predefined with the name of the ZIP archive file with `-signed` name suffix attached.

Type
: `File`

### 

`verifyPlugin`

Validates completeness and contents of `[plugin.xml](plugin-configuration-file.html)` descriptors as well as plugin archive structure.

#### 

`ignoreFailures`

Specify whether the build should fail when the verifications performed by this task fail.

Type
: `Boolean`

Default value
: `false`

#### 

`ignoreWarnings`

Specify whether the build should fail when the verifications performed by this task emit warnings.

Type
: `Boolean`

Default value
: `true`

#### 

`ignoreUnacceptableWarnings`

Specify whether the build should fail when the verifications performed by this task emit unacceptable warnings.

Type
: `Boolean`

Default value
: `false`

#### 

`pluginDir`

The location of the built plugin file which will be used for verification.

Type
: `File`

Default value
: `${prepareSandboxTask.destinationDir}/${prepareSandboxTask.pluginName}`

### 

`verifyPluginConfiguration`

Validates the plugin project configuration:

* The [patchPluginXml.sinceBuild](#tasks-patchpluginxml-sincebuild) property can't be lower than the major version of the currently used IntelliJ SDK set with the [intellij.version](#intellij-extension-version).

* The `sourceCompatibility` property of the Java configuration can't be lower than the Java version used for assembling the IntelliJ SDK specified by the [intellij.version](#intellij-extension-version).

* The `targetCompatibility` property of the Java configuration can't be higher than the Java version required for running IDE in the version specified by the [intellij.version](#intellij-extension-version) or [patchPluginXml.sinceBuild](#tasks-patchpluginxml-sincebuild) properties.

* The `kotlinJvmTarget` property of the Kotlin configuration (if used) can't be higher than the Java version required for running IDE in the version specified by the [intellij.version](#intellij-extension-version) or [patchPluginXml.sinceBuild](#tasks-patchpluginxml-sincebuild) properties.

* The `kotlinLanguageVersion` property of the Kotlin configuration (if used) can't be lower than the Kotlin bundled with IDE in the version specified by the [intellij.version](#intellij-extension-version) or [patchPluginXml.sinceBuild](#tasks-patchpluginxml-sincebuild) properties.

* The `kotlinApiVersion` property of the Kotlin configuration (if used) can't be higher than the Kotlin bundled with IDE in the version specified by the [intellij.version](#intellij-extension-version) or [patchPluginXml.sinceBuild](#tasks-patchpluginxml-sincebuild) properties.

Tip:

For more details regarding the Java version used in the specific IntelliJ SDK, see [Build Number Ranges](build-number-ranges.html).

* The dependency on the Kotlin Standard Library (stdlib) is automatically added when using the Gradle Kotlin plugin and may conflict with the version provided with the IntelliJ Platform.

Tip:

Read more about controlling this behavior on [Kotlin Standard Library (stdlib)](using-kotlin.html#kotlin-standard-library).

* An old default [runPluginVerifier.downloadDir](#tasks-runpluginverifier-downloaddir) path contains downloaded IDEs, but another default is in use. Links to the [FAQ section](tools-gradle-intellij-plugin-faq.html#the-plugin-verifier-download-directory-is-set-to-but-downloaded-ides-were-also-found-in)

### 

`verifyPluginSignature`

Validates the signature of the plugin archive file using the [marketplace-zip-signer](https://github.com/JetBrains/marketplace-zip-signer) library.

For more details, see [Plugin Signing](plugin-signing.html) article.

#### 

`certificateChain`

Note:

Currently unavailable — please use [verifyPluginSignature.certificateChainFile](#tasks-verifypluginsignature-certificatechainfile) instead.

Type
: `String`

Default value
: `null`

#### 

`certificateChainFile`

A file containing X509 certificates.
The first certificate from the chain will be used as a certificate authority (CA).
Refers to `cert` CLI option.

By default, the certificate chain file is set to the value of the [signPlugin.certificateChainFile](#tasks-signplugin-certificatechainfile) property.
If absent, the [signPlugin.certificateChain](#tasks-signplugin-certificatechain) property is used instead, but due to the CLI tool limitations, a temporary file is created and the certificate chain is written to it.

Type
: `File`

Default value
: [signPlugin.certificateChainFile](#tasks-signplugin-certificatechainfile)

#### 

`inputArchiveFile`

Input, signed ZIP archive file.
Refers to `in` CLI option.

Provided by the [signPlugin](#tasks-signplugin) task.

