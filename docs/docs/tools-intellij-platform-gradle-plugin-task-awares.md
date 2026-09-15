# Task Awares

Tip: FAQ

See [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html) and [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html).

The Task Awares is a set of interfaces that can be applied to custom Gradle tasks and, when registered using the dedicated register method, inject new features or properties with predefined values.

IntelliJ Platform Gradle Plugin supports creating custom tasks which can use `*Aware` interfaces.
Example:

Kotlin:

```KOTLIN
import org.jetbrains.intellij.platform.gradle.tasks.aware.PluginAware

abstract class RetrievePluginNameTask : DefaultTask(), PluginAware

val retrievePluginName by tasks.registering(RetrievePluginNameTask::class) {
    val outputFile = layout.buildDirectory.file("pluginName.txt")

    doLast {
        outputFile.get().asFile.writeText(pluginXml.parse { name }.get())
    }
}
```

Groovy:

```GROOVY
import org.jetbrains.intellij.platform.gradle.tasks.aware.PluginAware

abstract class RetrievePluginNameTask extends DefaultTask implements PluginAware {}

tasks.register('retrievePluginName', RetrievePluginNameTask) {
  def outputFile = layout.buildDirectory.file("pluginName.txt")

  doLast {
    outputFile.get().asFile.writeText(pluginXml.parse { name }.get())
  }
}
```

## 

`AutoReloadAware`

<tldr>
Inherited by: [RunnableIdeAware](#RunnableIdeAware)

Sources: [AutoReloadAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/AutoReloadAware.kt)
</tldr>

Provides the possibility to auto-reload plugin when run in the IDE.

### 

`autoReload`

Enables auto-reload of dynamic plugins.
Dynamic plugin will be reloaded automatically when its content is modified.

This allows a much faster development cycle by avoiding a full restart of the development instance after code changes.

Type
: `Property<Boolean>`

Default value
: [intellijPlatform.autoReload](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-autoReload)

## 

`ComposeHotReloadAware`

<tldr>
Depends on: [initializeIntelliJPlatformPlugin](tools-intellij-platform-gradle-plugin-tasks.html#initializeIntelliJPlatformPlugin)

Inherited by: [runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde), [runIdeBackend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeBackend), [runIdeFrontend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeFrontend)

Sources: [ComposeHotReloadAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/ComposeHotReloadAware.kt)
</tldr>

Provides the path to the Java Agent file for the Compose Hot Reload agent required to enable hot reloading of Compose UIs.

### 

`composeHotReload`

Enables auto-reload of Compose UIs after code changes for the task.

Type
: `Property<Boolean>`

Default value
: `false`

### 

`composeHotReloadAgentConfiguration`

Holds Compose Hot Reload agent JAR dependency configuration.

Type
: `ConfigurableFileCollection`

## 

`CoroutinesJavaAgentAware`

<tldr>
Depends on: [initializeIntelliJPlatformPlugin](tools-intellij-platform-gradle-plugin-tasks.html#initializeIntelliJPlatformPlugin)

Inherited by: [RunnableIdeAware](#RunnableIdeAware), [TestableAware](#TestableAware)

Sources: [CoroutinesJavaAgentAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/CoroutinesJavaAgentAware.kt)
</tldr>

Provides the path to the Java Agent file for the Coroutines library required to enable coroutines debugging.

### 

`coroutinesJavaAgentFile`

The path to the coroutines Java Agent file.

Type
: `RegularFileProperty`

Default value
: Resolved automatically and stored under [intellijPlatform.caching.path](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-caching-path)

## 

`IntelliJPlatformVersionAware`

<tldr>
Inherited by: [RuntimeAware](#RuntimeAware), [SandboxAware](#SandboxAware), [SplitModeAware](#SplitModeAware), [initializeIntelliJPlatformPlugin](tools-intellij-platform-gradle-plugin-tasks.html#initializeIntelliJPlatformPlugin), [patchPluginXml](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml), [printBundledPlugins](tools-intellij-platform-gradle-plugin-tasks.html#printBundledPlugins), [runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde), [runIdeBackend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeBackend), [runIdeFrontend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeFrontend), [testIdePerformance](tools-intellij-platform-gradle-plugin-tasks.html#testIdePerformance), [testIdeUi](tools-intellij-platform-gradle-plugin-tasks.html#testIdeUi), [verifyPluginProjectConfiguration](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginProjectConfiguration)

Sources: [IntelliJPlatformVersionAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/IntelliJPlatformVersionAware.kt)
</tldr>

Provides a task with the possibility of accessing information about the IntelliJ Platform currently used in the project.

The [intelliJPlatformConfiguration](#IntelliJPlatformVersionAware-intelliJPlatformConfiguration) input property receives a dependency added to the `intellijPlatform` configuration, which eventually is resolved and lets to access the IntelliJ Platform details such as [ProductInfo](tools-intellij-platform-gradle-plugin-types.html#ProductInfo) or the path to the IntelliJ Platform directory.

It is required to have a dependency on the IntelliJ Platform added to the project with helpers available in [Dependencies Extension](tools-intellij-platform-gradle-plugin-dependencies-extension.html).

### 

`intelliJPlatformConfiguration`

Holds the `intellijPlatform` configuration with the IntelliJ Platform dependency added.

It should not be directly accessed.

Type
: `ConfigurableFileCollection`

### 

`intelliJPlatformPluginConfiguration`

Holds the `intellijPlatformPlugin` configuration with optional custom IntelliJ Platform plugin dependencies added.
It should not be directly accessed.

Type
: `ConfigurableFileCollection`

### 

`intelliJPlatformTestRuntimeFixClasspathConfiguration`

Holds the `intellijPlatformTestRuntimeFixClasspath` configuration with the custom IntelliJ Platform core dependency required for running tests.
It should not be directly accessed.

Type
: `ConfigurableFileCollection`

### 

`platformPath`

Provides a direct path to the IntelliJ Platform dependency artifact.

Access
: Read-only

Type
: `Path`

### 

`productInfo`

Provides information about the IntelliJ Platform product.

The information is retrieved from the `product-info.json` file in the IntelliJ Platform directory.

Access
: Read-only

Type
: [ProductInfo](tools-intellij-platform-gradle-plugin-types.html#ProductInfo)

### 

`validateIntelliJPlatformVersion()`

Validates that the resolved IntelliJ Platform is supported by checking against the minimal supported IntelliJ Platform version.

Invokes [ProductInfo.validateSupportedVersion()](tools-intellij-platform-gradle-plugin-types.html#ProductInfo-validateSupportedVersion).

Throws
: `IllegalArgumentException`

## 

`JavaCompilerAware`

<tldr>
Inherited by: [instrumentCode](tools-intellij-platform-gradle-plugin-tasks.html#instrumentCode)

Sources: [JavaCompilerAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/JavaCompilerAware.kt)
</tldr>

Provides the dependency on Java Compiler required for the [code instrumentation](tools-intellij-platform-gradle-plugin-tasks.html#instrumentCode) to properly configure Ant tasks provided by the IntelliJ Platform.

### 

`javaCompilerConfiguration`

Holds the `intellijPlatformJavaCompiler` configuration with the Java Compiler dependency added.

Type
: `ConfigurableFileCollection`

## 

`KotlinMetadataAware`

<tldr>
Inherited by: [generateManifest](tools-intellij-platform-gradle-plugin-tasks.html#generateManifest), [verifyPluginProjectConfiguration](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginProjectConfiguration)

Sources: [KotlinMetadataAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/KotlinMetadataAware.kt)
</tldr>

An interface that provides access to Kotlin-specific metadata for a Gradle project.
The task that inherits from this interface is automatically marked as dependent on the `compileKotlin` task.

### 

`kotlinPluginAvailable`

Indicates that the Kotlin Gradle Plugin is loaded and available.

Type
: `Property<Boolean>`

Default value
: `false`

### 

`kotlinxCoroutinesLibraryPresent`

This variable represents whether the Kotlin Coroutines library is added explicitly to the project dependencies.

Type
: `Property<Boolean>`

Default value
: `false`

### 

`kotlinApiVersion`

The `apiVersion` property value of `compileKotlin.kotlinOptions` defined in the build script.

Type
: `Property<String?>`

Default value
: `null`

### 

`kotlinLanguageVersion`

The `languageVersion` property value of `compileKotlin.kotlinOptions` defined in the build script.

Type
: `Property<String?>`

Default value
: `null`

### 

`kotlinVersion`

The version of Kotlin used in the project.

Type
: `Property<String?>`

Default value
: `null`

### 

`kotlinJvmTarget`

The `jvmTarget` property value of `compileKotlin.kotlinOptions` defined in the build script.

Type
: `Property<String?>`

Default value
: `null`

### 

`kotlinStdlibDefaultDependency`

`kotlin.stdlib.default.dependency` property value defined in the `gradle.properties` file.

Type
: `Property<Boolean?>`

Default value
: `null`

## 

`ModuleAware`

<tldr>
Inherited by: [PluginAware](#PluginAware)

Sources: [ModuleAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/ModuleAware.kt)
</tldr>

Provides information about whether the current task is executed in an IntelliJ Platform plugin module context.

### 

`module`

Indicates if the current project represents an IntelliJ Platform plugin module.

Type
: `Property<Boolean>`

Default value
: `PluginManager.isModule`

Notes:

* The IntelliJ Platform Gradle Plugin wires this property automatically for tasks implementing ModuleAware during task preconfiguration.

* You typically do not set this value yourself; consume it in your task to branch logic.

## 

`PluginAware`

<tldr>
Depends on: [patchPluginXml](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml)

Inherited by: [TestableAware](#TestableAware), [RunnableIdeAware](#RunnableIdeAware), [jarSearchableOptions](tools-intellij-platform-gradle-plugin-tasks.html#jarSearchableOptions), [verifyPluginProjectConfiguration](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginProjectConfiguration)

Sources: [PluginAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/PluginAware.kt)
</tldr>

Provides information about the currently built plugin.

It resolves and parses the final `plugin.xml` descriptor file, making its details easily accessible.

### 

`pluginXml`

Holds the path to the patched `plugin.xml` file.

Type
: `RegularPropertyFile`

Default value
: [patchPluginXml.outputFile](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-outputFile)

### 

`parse {}`

The `parse` method provides a possibility for parsing the `pluginXml` file and direct access to the [PluginBean](tools-intellij-platform-gradle-plugin-types.html#PluginBean) object.

Should be used along with the [pluginXml](#PluginAware-pluginXml) property like:

Kotlin:

```KOTLIN
abstract class RetrievePluginNameTask : DefaultTask(), PluginAware

val retrievePluginName by tasks.registering(RetrievePluginNameTask::class) {
    doLast {
        val name = pluginXml.parse { name }.get()
        println("Plugin Name: $name")
    }
}
```

Groovy:

```GROOVY
abstract class RetrievePluginNameTask extends DefaultTask implements PluginAware {}

tasks.register('retrievePluginName', RetrievePluginNameTask) {
    doLast {
        def name = pluginXml.parse { name }.get()
        println("Plugin Name: $name")
    }
}
```

## 

`PluginInstallationTargetAware`

<tldr>
Inherited by: [prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox), [prepareTestSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestSandbox), [prepareTestIdePerformanceSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestIdePerformanceSandbox), [runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde), [runIdeBackend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeBackend), [runIdeFrontend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeFrontend)

Sources: [PluginInstallationTargetAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/PluginInstallationTargetAware.kt)
</tldr>

Provides the property that selects where the developed plugin is installed when running in Split Mode.

### 

`pluginInstallationTarget`

Specifies in which part of the product the developed plugin should be installed.

Type
: [Property&lt;PluginInstallationTarget&gt;](tools-intellij-platform-gradle-plugin-types.html#SplitModeAware-PluginInstallationTarget)

Default value
: `BACKEND`

## 

`PluginVerifierAware`

<tldr>
Inherited by: [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin)

Sources: [PluginVerifierAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/PluginVerifierAware.kt)
</tldr>

Provides the path to the IntelliJ Plugin Verifier executable.

It is required to have a dependency on the IntelliJ Plugin Verifier added to the project with [intellijPlatform.pluginVerifier()](tools-intellij-platform-gradle-plugin-dependencies-extension.html) dependencies extension.

### 

`pluginVerifierExecutable`

Path to the IntelliJ Plugin Verifier executable.

Type
: `RegularFileProperty`

## 

`ProblemsAware`

<tldr>
Inherited by: [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin), [verifyPluginProjectConfiguration](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginProjectConfiguration)

Sources: [ProblemsAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/ProblemsAware.kt)
</tldr>

Provides access to Gradle's Problems API for structured issue reporting.

### 

`problems`

Provides the injected Gradle Problems API instance used by the task.

Type
: `Problems`

## 

`RunnableIdeAware`

<tldr>
Depends on: [AutoReloadAware](#AutoReloadAware), [CoroutinesJavaAgentAware](#CoroutinesJavaAgentAware), [PluginAware](#PluginAware), [RuntimeAware](#RuntimeAware), [SandboxAware](#SandboxAware)

Inherited by: [buildSearchableOptions](tools-intellij-platform-gradle-plugin-tasks.html#buildSearchableOptions), [runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde), [runIdeBackend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeBackend), [runIdeFrontend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeFrontend), [testIdePerformance](tools-intellij-platform-gradle-plugin-tasks.html#testIdePerformance), [testIdeUi](tools-intellij-platform-gradle-plugin-tasks.html#testIdeUi)

Sources: [RunnableIdeAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/RunnableIdeAware.kt)
</tldr>

The interface which uses a set of various interfaces required for running a guest IDE.
Inherits from:

* [CoroutinesJavaAgentAware](#CoroutinesJavaAgentAware)

* [PluginAware](#PluginAware)

* [RuntimeAware](#RuntimeAware)

* [SandboxAware](#SandboxAware)

* `JavaForkOptions`

## 

`RuntimeAware`

<tldr>
Inherited by: [RunnableIdeAware](#RunnableIdeAware), [TestableAware](#TestableAware), [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin), [verifyPluginProjectConfiguration](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginProjectConfiguration)

Sources: [RuntimeAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/RuntimeAware.kt)
</tldr>

Provides access to the Java Runtime (i.e., JetBrains Runtime) resolved with `JavaRuntimePathResolver`.

### 

`jetbrainsRuntimeConfiguration`

Holds the `intellijPlatformJetbrainsRuntime` configuration with the JetBrains Runtime dependency added.
It should not be directly accessed.

Type
: `ConfigurableFileCollection`

### 

`runtimeDirectory`

Java Runtime parent directory.

Type
: `DirectoryProperty`

### 

`runtimeArchitecture`

An architecture of the Java Runtime currently used for running Gradle.

Type
: `Property<String>`

### 

`runtimeMetadata`

Metadata object of the Java Runtime currently used for running Gradle.

Type
: `MapProperty<String, String>`

### 

`runtimeLauncher`

A custom `JavaLauncher` instance configured with the resolved [runtimeDirectory](#RuntimeAware-runtimeDirectory).

Type
: `Property<JavaLauncher>`

## 

`SandboxStructure`

<tldr>
Inherited by: [SandboxAware](#SandboxAware), [SplitModeAware](#SplitModeAware)

Sources: [SandboxStructure](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/SandboxStructure.kt)
</tldr>

Defines common sandbox directories and flags used by tasks interacting with IDE sandboxes.

### 

`sandboxDirectory`

The directory containing content read and produced by the running IDE. The directory name depends on the platform type and version currently used for running a task.

Type
: `DirectoryProperty`

### 

`sandboxConfigDirectory`

A configuration directory located within the [sandboxDirectory](#SandboxStructure-sandboxDirectory).

Type
: `DirectoryProperty`

### 

`sandboxPluginsDirectory`

A plugins directory located within the [sandboxDirectory](#SandboxStructure-sandboxDirectory).

Type
: `DirectoryProperty`

### 

`sandboxSystemDirectory`

A system directory located within the [sandboxDirectory](#SandboxStructure-sandboxDirectory).

Type
: `DirectoryProperty`

### 

`sandboxLogDirectory`

A log directory located within the [sandboxDirectory](#SandboxStructure-sandboxDirectory).

Type
: `DirectoryProperty`

### 

`testSandbox`

Defines if the current sandbox is related to testing.

Type
: `Property<Boolean>`

## 

`SandboxAware`

<tldr>
Depends on: [prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox)

Inherited by: [RunnableIdeAware](#RunnableIdeAware), [TestableAware](#TestableAware)

Sources: [SandboxAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/SandboxAware.kt)
</tldr>

Provides quick access to the sandbox container and specific directories located within it.

The path to the sandbox container is obtained using the [intellijPlatform.sandboxContainer](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-sandboxContainer) extension property and the type and version of the IntelliJ Platform applied to the project.

### 

`sandboxSuffix`

Represents the suffix used i.e., for test-related tasks.

Type
: `Property<String>`

### 

`sandboxDirectory`

The directory containing content read and produced by the running IDE.

The directory name depends on the platform type and version currently used for running a task.

Type
: `DirectoryProperty`

### 

`sandboxConfigDirectory`

A configuration directory located within the [sandboxDirectory](#SandboxAware-sandboxDirectory).

Type
: `DirectoryProperty`

### 

`sandboxPluginsDirectory`

A plugins directory located within the [sandboxDirectory](#SandboxAware-sandboxDirectory).

Type
: `DirectoryProperty`

### 

`sandboxSystemDirectory`

A system directory located within the [sandboxDirectory](#SandboxAware-sandboxDirectory).

Type
: `DirectoryProperty`

### 

`sandboxLogDirectory`

A log directory located within the [sandboxDirectory](#SandboxAware-sandboxDirectory).

Type
: `DirectoryProperty`

### 

`applySandboxFrom(TaskProvider)`

The helper method used for applying sandbox configuration from the sandbox producer (such as [prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox) or [prepareTestSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestSandbox) tasks) to sandbox consumers.

### 

`applyFrontendSandboxFrom(TaskProvider)`

The helper method used for applying frontend sandbox directories from a [prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox) producer to a sandbox consumer.
This is used by split-mode frontend consumers such as [runIdeFrontend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeFrontend).

## 

`SigningAware`

<tldr>
Inherited by: [signPlugin](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin), [verifyPluginSignature](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginSignature)

Sources: [SigningAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/SigningAware.kt)
</tldr>

Provides the path to the Marketplace ZIP Signer executable.

### 

`zipSignerExecutable`

Path to the Marketplace ZIP Signer executable.

Type
: `RegularFileProperty`

## 

`SplitModeAware`

<tldr>
Inherited by: [prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox), [prepareTestSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestSandbox), [prepareTestIdePerformanceSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestIdePerformanceSandbox), [runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde), [runIdeBackend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeBackend), [runIdeFrontend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeFrontend)

Sources: [SplitModeAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/SplitModeAware.kt)
</tldr>

When you develop a plugin, you may want to check how it works in [split mode](split-mode-and-remote-development.html), when one machine is running the backend part and another is running a frontend part (JetBrains Client) which connects to the backend.

This property allows running the IDE with backend and frontend parts running in separate processes.
Use `pluginInstallationTarget` to specify whether the developed plugin is installed in the frontend, backend, or both parts.

[Split Mode](split-mode-and-remote-development.html) requires the IntelliJ Platform in the version `241.14473` or later.

### 

`splitMode`

Enables Split Mode when running the IDE.

Type
: `Property<Boolean>`

Default value
: [intellijPlatform.splitMode](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-splitMode)

### 

`pluginInstallationTarget` (formerly `splitModeTarget`)

Split-mode tasks that also implement [PluginInstallationTargetAware](#PluginInstallationTargetAware) use this property to specify in which part of the product the developed plugin should be installed.
The default comes from [intellijPlatform.pluginInstallationTarget](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginInstallationTarget) and is backend-only unless configured otherwise.

Type
: [Property&lt;PluginInstallationTarget&gt;](tools-intellij-platform-gradle-plugin-types.html#SplitModeAware-PluginInstallationTarget)

Default value
: [intellijPlatform.pluginInstallationTarget](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginInstallationTarget)

### 

`sandboxConfigFrontendDirectory`

A frontend configuration directory located within the sandbox.

Type
: `DirectoryProperty`

### 

`sandboxPluginsFrontendDirectory`

A frontend plugins directory located within the sandbox.

Type
: `DirectoryProperty`

### 

`sandboxSystemFrontendDirectory`

A frontend system directory located within the sandbox.

Type
: `DirectoryProperty`

### 

`sandboxLogFrontendDirectory`

A frontend log directory located within the sandbox.

Type
: `DirectoryProperty`

### 

`splitModeFrontendProperties`

Path to a properties file used to configure the frontend process when the IDE is started in Split Mode.

Type
: `Provider<RegularFile>`

### 

`splitModeFrontendJoinLinkFile`

Path to a file storing the current split-mode frontend join link.
It is written by [runIdeBackend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeBackend) and consumed by [runIdeFrontend](tools-intellij-platform-gradle-plugin-tasks.html#runIdeFrontend) when both are launched separately.

Type
: `Provider<RegularFile>`

Default value
: `[sandboxDirectory]/split-mode-frontend.join.link`

### 

`effectivePluginInstallationTarget`

Resolves the effective plugin installation target.
The [pluginInstallationTarget](#PluginInstallationTargetAware-pluginInstallationTarget) property takes precedence over the deprecated `splitModeTarget` alias when available.
If neither property is configured explicitly, the effective target is `BACKEND`.

Type
: `Provider<PluginInstallationTarget>`

### 

`validateSplitModeSupport()`

Validates that the resolved IntelliJ Platform supports Split Mode.

Throws
: `IllegalArgumentException`

## 

`TestableAware`

<tldr>
Inherited by: [prepareTest](tools-intellij-platform-gradle-plugin-tasks.html#prepareTest), [testIde](tools-intellij-platform-gradle-plugin-tasks.html#testIde), [testIdeUi](tools-intellij-platform-gradle-plugin-tasks.html#testIdeUi), [testIdePerformance](tools-intellij-platform-gradle-plugin-tasks.html#testIdePerformance)

Sources: [TestableAware](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.19.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/TestableAware.kt)
</tldr>

Interface used to describe tasks used for running tests, such as [testIdeUi](tools-intellij-platform-gradle-plugin-tasks.html#testIdeUi), [testIdePerformance](tools-intellij-platform-gradle-plugin-tasks.html#testIdePerformance), or [prepareTest](tools-intellij-platform-gradle-plugin-tasks.html#prepareTest) used for configuring `test` and keeping it immutable.

### 

`intellijPlatformClasspathConfiguration`

Holds the `intellijPlatformClasspath` configuration.

Type
: `ConfigurableFileCollection`

### 

`intellijPlatformTestClasspathConfiguration`

Holds the `intellijPlatformTestClasspath` configuration.

Type
: `ConfigurableFileCollection`

### 

`intellijPlatformTestRuntimeClasspathConfiguration`

Holds the `intellijPlatformTestRuntimeClasspath` configuration.

Type
: `ConfigurableFileCollection`

### 

`pluginDirectory`

Specifies the directory where the plugin artifacts are placed for testing.

Type
: `DirectoryProperty`

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

