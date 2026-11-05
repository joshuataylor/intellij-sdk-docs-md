# Tasks

Tip: FAQ

See [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html) and [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html).

The IntelliJ Platform Gradle Plugin introduces a set of tasks to handle activities of the plugin development for IntelliJ-based IDEs, such as building, verifying, testing, and publishing the plugin archive.

Tasks related to the IntelliJ Platform Gradle Plugin are selectively applied to your project based on specific conditions or criteria defined within the plugin's context.
This means that the plugin intelligently determines which tasks are relevant and necessary based on the current state or configuration of your project.
This contextual application of tasks ensures that the plugin operates efficiently, performing only those actions that are appropriate for the given project environment at any time.

Tasks have dependencies on each other, they inherit from [Task Awares](tools-intellij-platform-gradle-plugin-task-awares.html) interfaces, respect configuration and build cache,
and can be configured independently.
However, most cases will be covered by the [IntelliJ Platform Extension](tools-intellij-platform-gradle-plugin-extension.html).

The plugin organizes the tasks it registers into dedicated Gradle groups, visible in the Gradle tool window and in the `gradle tasks` output:

* intellij platform – building and running tasks, such as [buildPlugin](#buildPlugin), [runIde](#runIde), [signPlugin](#signPlugin), and [publishPlugin](#publishPlugin).

* intellij platform verification – verification tasks, such as [verifyPlugin](#verifyPlugin), [verifyPluginProjectConfiguration](#verifyPluginProjectConfiguration), [verifyPluginStructure](#verifyPluginStructure), and [verifyPluginSignature](#verifyPluginSignature).

* intellij platform info – informational tasks that print resolved data, such as [printBundledPlugins](#printBundledPlugins), [printBundledModules](#printBundledModules), and [printProductsReleases](#printProductsReleases).

Intermediate and internal tasks, such as [prepareSandbox](#prepareSandbox) or [instrumentCode](#instrumentCode), are not assigned to any group and appear under Gradle's other tasks.

## 

`buildPlugin`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [jarSearchableOptions](#jarSearchableOptions), [prepareSandbox](#prepareSandbox)

Extends: [Zip](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.bundling.Zip.html)

Sources: [BuildPluginTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/BuildPluginTask.kt)
</tldr>

Builds the plugin and prepares the ZIP archive for testing and deployment.

It takes the output of the [prepareSandbox](#prepareSandbox) task containing the built project with all its modules and dependencies, and the output of [jarSearchableOptions](#jarSearchableOptions) task.

The produced archive is stored in `[buildDirectory]/distributions/[archiveFile](#buildPlugin-archiveFile)`,
where the name and location of [archiveFile](#buildPlugin-archiveFile) can be controlled with properties provided with the
[Zip](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.bundling.Zip.html) base task.
By default, the `archiveBaseName` is set to the plugin name specified in the `plugin.xml` file, after it gets patched with the [patchPluginXml](#patchPluginXml) task.

Warning: Do Not Repackage Libraries

Do not repackage libraries into the main plugin JAR file.
Otherwise, [Plugin Verifier](verifying-plugin-compatibility.html) will yield false positives for unresolved classes and methods.

### 

`archiveFile`

Specifies the archive file representing the output file produced by the task.

Type
: `RegularFileProperty`

## 

`buildPluginVariants`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: The six [buildPluginVariants_&lt;os&gt;_&lt;arch&gt;](#buildPluginVariants-variant-tasks) tasks when native variants are enabled

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html)

Sources: [BuildPluginVariantsTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/BuildPluginVariantsTask.kt)
</tldr>

Builds the fixed matrix of Linux, macOS, and Windows plugin distributions for `x86_64` and `arm64` architectures.
The task runs its variant tasks only when [intellijPlatform.nativeVariants.enabled](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-nativeVariants-enabled) is `true`.
It does not change the base archive produced by [buildPlugin](#buildPlugin).

Each variant archive is written to `[buildDirectory]/distributions` with the `-<os>-<arch>` classifier, for example, `myPlugin-1.0.0-linux-arm64.zip`.
Its plugin descriptor version receives the same suffix and declares the corresponding `com.intellij.modules.os.<os>` and `com.intellij.modules.arch.<arch>` dependencies.
Files configured for that target in [intellijPlatform.nativeVariants](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-nativeVariants) are copied into the plugin distribution.
The prepared variant JAR and target-specific files take precedence over duplicate paths from the base sandbox.

### 

`buildPluginVariants_<os>_<arch>`

The following [BuildPluginTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/BuildPluginTask.kt) instances produce the individual archives:

| Target |Task |Archive classifier |
------------------------------------
| Linux x86_64 |`buildPluginVariants_linux_x86_64` |`linux-x86_64` |
| Linux arm64 |`buildPluginVariants_linux_arm64` |`linux-arm64` |
| macOS x86_64 |`buildPluginVariants_mac_x86_64` |`mac-x86_64` |
| macOS arm64 |`buildPluginVariants_mac_arm64` |`mac-arm64` |
| Windows x86_64 |`buildPluginVariants_windows_x86_64` |`windows-x86_64` |
| Windows arm64 |`buildPluginVariants_windows_arm64` |`windows-arm64` |

All six tasks are registered, even when no native files are configured for a target, and are skipped while native variants are disabled.

### 

`archiveFiles`

The variant ZIP archives produced by the six target tasks.

Type
: `ConfigurableFileCollection`

## 

`buildSearchableOptions`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [prepareSandbox](#prepareSandbox)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html), [RunnableIdeAware](tools-intellij-platform-gradle-plugin-task-awares.html#RunnableIdeAware)

Sources: [BuildSearchableOptionsTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/BuildSearchableOptionsTask.kt)
</tldr>

Builds the index of UI components (searchable options) for the plugin.
This task runs a headless IDE instance to collect all the available options provided by the plugin's [Settings](settings.html).

The task is skipped automatically when the main plugin descriptor and plugin module descriptors don't declare `Configurable` extension points.
Use the [forceBuildSearchableOptions](tools-intellij-platform-gradle-plugin-gradle-properties.html#forceBuildSearchableOptions) Gradle property to force execution even when descriptor analysis would skip it.
The task can also be controlled with the [intellijPlatform.buildSearchableOptions](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-buildSearchableOptions) flag.

In the case of running the task for the plugin that has [intellijPlatform.pluginConfiguration.productDescriptor](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-productDescriptor) defined, a warning will be logged regarding potential issues with running headless IDE for paid plugins.
It is possible to mute this warning with the [paidPluginSearchableOptionsWarning](tools-intellij-platform-gradle-plugin-gradle-properties.html#paidPluginSearchableOptionsWarning) Gradle property.

### 

`outputDirectory`

Specifies the directory where searchable options will be generated.

Type
: `DirectoryProperty`

Default value
: `[buildDirectory]/tmp/buildSearchableOptions`

### 

`showPaidPluginWarning`

Emits a warning when the task is executed by a paid plugin.
Can be disabled with the [paidPluginSearchableOptionsWarning](tools-intellij-platform-gradle-plugin-gradle-properties.html#paidPluginSearchableOptionsWarning) Gradle property.

Type
: `Property<Boolean>`

Default value
: [paidPluginSearchableOptionsWarning](tools-intellij-platform-gradle-plugin-gradle-properties.html#paidPluginSearchableOptionsWarning) && `productDescriptor` is defined

## 

`cleanSandbox`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Extends: [Delete](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.Delete.html)

Sources: [CleanSandboxTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/CleanSandboxTask.kt)
</tldr>

Cleans the sandbox directory created by [prepareSandbox](#prepareSandbox) for the current project.

## 

`composedJar`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Depends on: [jar](https://docs.gradle.org/current/dsl/org.gradle.jvm.tasks.Jar.html), [instrumentedJar](#instrumentedJar)

Extends: [Jar](https://docs.gradle.org/current/dsl/org.gradle.jvm.tasks.Jar.html)

Sources: [ComposedJarTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/ComposedJarTask.kt)
</tldr>

Composes a final JAR by combining the output of base `jar` or [instrumentedJar](#instrumentedJar) tasks,
depending on if code instrumentation is enabled with [intellijPlatform.instrumentCode](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-instrumentCode).

The final JAR is also combined with plugin modules marked using the [pluginComposedModule](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) dependencies helper.

### 

`archiveFile`

Specifies the archive file representing the output file produced by the task.

Type
: `RegularFileProperty`

## 

`generateManifest`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [KotlinMetadataAware](tools-intellij-platform-gradle-plugin-task-awares.html#KotlinMetadataAware)

Sources: [GenerateManifestTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/GenerateManifestTask.kt)
</tldr>

Generates the `MANIFEST.MF` file with all relevant information about the project configuration.

To apply the produced manifest file, `JarCompanion.applyPluginManifest` method should be called on a task extending [Jar](https://docs.gradle.org/current/dsl/org.gradle.jvm.tasks.Jar.html).

This file is bundled into the output JAR files produced by [composedJar](#composedJar), [instrumentedJar](#instrumentedJar), and [Jar](https://docs.gradle.org/current/dsl/org.gradle.jvm.tasks.Jar.html) tasks.

### 

`pluginVersion`

The IntelliJ Platform Gradle Plugin version.

Type
: `Property<String>`

### 

`gradleVersion`

The version of currently used Gradle.

Type
: `Property<String>`

### 

`platformType`

The product code of the current IntelliJ Platform, for example, `IC` or `IU`.

Type
: `Property<String>`

### 

`platformVersion`

The marketing version of the current IntelliJ Platform, for example, `2025.3`.

Type
: `Property<String>`

### 

`platformBuild`

The build number of the current IntelliJ Platform, for example, `253.12345.67`.

Type
: `Property<String>`

### 

`version`

Plugin version.

Type
: `Property<String>`

### 

`generatedManifest`

Location of the generated `MANIFEST.MF` file.

Type
: `RegularFileProperty`

## 

`generateLexer`

<tldr>
Available in: [GrammarKit](tools-intellij-platform-gradle-plugin-plugins.html#grammarkit)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html)

Sources: [GenerateLexerTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/GenerateLexerTask.kt)
</tldr>

Generates a lexer from a `.flex` definition file using JFlex.

### 

`sourceFile`

The source Flex file used to generate the lexer.

Type
: `RegularFileProperty`

### 

`targetRootOutputDir`

The root output directory for the generated lexer.
The lexer file is created under a subdirectory matching [packageName](#generateLexer-packageName), unless `packageName` is empty.
When the legacy [targetOutputDir](#generateLexer-targetOutputDir-deprecated) is not used and [pathToClass](#generateLexer-pathToClass) is not set, the task exclusively owns this directory, declares the entire directory as its output, and can be passed directly to `sourceSets.main.java.srcDir(tasks.generateLexer)` so Gradle infers the task dependency.
Set `pathToClass` when this directory is shared with other generators.

Type
: `DirectoryProperty`

Default value
: `[buildDirectory]/generated/sources/grammarkit-lexer/java/main`

### 

`pathToClass`

The generated lexer class location relative to [targetRootOutputDir](#generateLexer-targetRootOutputDir), or relative to the legacy [targetOutputDir](#generateLexer-targetOutputDir-deprecated) when that property is used.
Setting this property switches the task to shared-root mode: only this file is declared as an output and removed during cleanup, leaving other files under the root untouched.

The value must include the generated filename and any package directories, for example, `com/example/MyLexer.java`.

Type
: `Property<String>`

Required
: no

### 

`packageName`

The Java package where the lexer file is generated.
By default, the task tries to detect the package declaration from [sourceFile](#generateLexer-sourceFile).
Set this property to an empty string (`""`) to generate the lexer in the root output directory.

Type
: `Property<String>`

Default value
: Detected from [sourceFile](#generateLexer-sourceFile), or empty string when no package declaration is found

### 

`targetOutputDir`

The legacy output directory for the generated lexer.
When this property is set, it takes precedence over [targetRootOutputDir](#generateLexer-targetRootOutputDir), the Java file is created directly below this directory, and [packageName](#generateLexer-packageName) is ignored.

Stale files in this directory are not deleted unless [purgeOldFiles](#generateLexer-purgeOldFiles) is explicitly set to `true`.

Type
: `DirectoryProperty`

### 

`skeleton`

Optional path to the skeleton file passed with the `--skel` option.

Type
: `RegularFileProperty`

Default value
: The default JFlex `idea-flex.skeleton`

### 

`purgeOldFiles`

Purges previously generated lexer output before generating the lexer.
When cleanup is enabled and [pathToClass](#generateLexer-pathToClass) is not set, the task removes the entire active output directory: [targetOutputDir](#generateLexer-targetOutputDir-deprecated) when present, otherwise [targetRootOutputDir](#generateLexer-targetRootOutputDir).
When `pathToClass` is set, only that generated file in the active output directory is removed so the root can be shared safely.
When the deprecated [targetOutputDir](#generateLexer-targetOutputDir-deprecated) is used, old files are not purged unless this property is explicitly set to `true`.
Set this property to `false` to disable cleanup.

Type
: `Property<Boolean>`

### 

`targetFile(...)`

Legacy helper methods returning the expected lexer file below [targetOutputDir](#generateLexer-targetOutputDir-deprecated).
Use [pathToClass](#generateLexer-pathToClass) instead.
With [targetRootOutputDir](#generateLexer-targetRootOutputDir), include the package directories in `pathToClass`.
With the legacy [targetOutputDir](#generateLexer-targetOutputDir-deprecated), `pathToClass` is relative to that directory and [packageName](#generateLexer-packageName) is ignored.

## 

`generateParser`

<tldr>
Available in: [GrammarKit](tools-intellij-platform-gradle-plugin-plugins.html#grammarkit)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html)

Sources: [GenerateParserTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/GenerateParserTask.kt)
</tldr>

Generates parser and PSI files from a `.bnf` definition file using GrammarKit.

### 

`sourceFile`

The source BNF file used to generate the parser.

Type
: `RegularFileProperty`

### 

`targetRootOutputDir`

The root output directory for generated parser and PSI files.
When [pathToParser](#generateParser-pathToParser) and [pathToPsiRoot](#generateParser-pathToPsiRoot) are not set, the task exclusively owns this directory, declares the entire directory as its output, and can be passed directly to `sourceSets.main.java.srcDir(tasks.generateParser)` so Gradle infers the task dependency.
Set both path properties when this directory is shared with other generators.

Type
: `DirectoryProperty`

Default value
: `[buildDirectory]/generated/sources/grammarkit-parser/java/main`

### 

`pathToParser`

The generated parser class location relative to [targetRootOutputDir](#generateParser-targetRootOutputDir).
Setting this property with [pathToPsiRoot](#generateParser-pathToPsiRoot) switches the task to shared-root mode, in which only the configured parser file and PSI directory are declared as outputs and removed during cleanup.
If this property is set, [pathToPsiRoot](#generateParser-pathToPsiRoot) must also be set.

Type
: `Property<String>`

### 

`pathToPsiRoot`

The generated PSI root location relative to [targetRootOutputDir](#generateParser-targetRootOutputDir).
Setting this property with [pathToParser](#generateParser-pathToParser) switches the task to shared-root mode, in which only the configured parser file and PSI directory are declared as outputs and removed during cleanup.
If this property is set, [pathToParser](#generateParser-pathToParser) must also be set.

Type
: `Property<String>`

### 

`parserFile()`

Returns the parser file below [targetRootOutputDir](#generateParser-targetRootOutputDir) computed from [pathToParser](#generateParser-pathToParser).

### 

`psiDir()`

Returns the PSI directory below [targetRootOutputDir](#generateParser-targetRootOutputDir) computed from [pathToPsiRoot](#generateParser-pathToPsiRoot).

### 

`purgeOldFiles`

Purges previously generated parser and PSI files before generation.
With no explicit paths, the task owns and removes the entire [targetRootOutputDir](#generateParser-targetRootOutputDir).
When both [pathToParser](#generateParser-pathToParser) and [pathToPsiRoot](#generateParser-pathToPsiRoot) are set, only the configured parser file and PSI directory are removed so the root can be shared safely.
Set this property to `false` to disable cleanup.

Type
: `Property<Boolean>`

## 

`generateSplitModeRunConfigurations`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html)

Sources: [GenerateSplitModeRunConfigurationsTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/GenerateSplitModeRunConfigurationsTask.kt)
</tldr>

Generates shared IntelliJ IDEA run configurations for split-mode frontend and backend runs, plus a compound run configuration that starts both.
The generated Gradle run configurations invoke [runIdeBackend](#runIdeBackend) and [runIdeFrontend](#runIdeFrontend) with `--purge-old-log-directories`.

This utility task is intentionally ungrouped, so it can be invoked directly without adding another entry to the standard Gradle task listing.

### 

`projectPath`

The Gradle project path used to qualify generated task paths.

Type
: `Property<String>`

Default value
: Current project path

### 

`backendConfigurationFile`

The generated backend run configuration file.

Type
: `RegularFileProperty`

Default value
: `[projectDirectory]/.run/runIdeBackend.run.xml`

### 

`frontendConfigurationFile`

The generated frontend run configuration file.

Type
: `RegularFileProperty`

Default value
: `[projectDirectory]/.run/runIdeFrontend.run.xml`

### 

`compoundConfigurationFile`

The generated compound run configuration file.

Type
: `RegularFileProperty`

Default value
: `[projectDirectory]/.run/runIdeSplitMode.run.xml`

## 

`initializeIntelliJPlatformPlugin`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module), [Base](tools-intellij-platform-gradle-plugin-plugins.html#base), [GrammarKit](tools-intellij-platform-gradle-plugin-plugins.html#grammarkit)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware), [ModuleAware](tools-intellij-platform-gradle-plugin-task-awares.html#ModuleAware)

Sources: [InitializeIntelliJPlatformPluginTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/InitializeIntelliJPlatformPluginTask.kt)
</tldr>

Executes before every other task introduced by IntelliJ Platform Gradle Plugin to prepare it to run.
It is responsible for:

* checking if the project uses IntelliJ Platform Gradle Plugin in the latest available version

The self-update check can be disabled via [selfUpdateCheck](tools-intellij-platform-gradle-plugin-gradle-properties.html#selfUpdateCheck) Gradle property.

### 

`offline`

Determines if the operation is running in offline mode and depends on Gradle start parameters.

Type
: `Property<Boolean>`

Default value
: `StartParameter.isOffline`

See also:

* [StartParameter](https://docs.gradle.org/current/javadoc/org/gradle/StartParameter.html)

* [Command Line Execution Options](https://docs.gradle.org/current/userguide/command_line_interface.html#sec:command_line_execution_options)

### 

`selfUpdateCheck`

Represents the property for checking if self-update checks are enabled.

Type
: `Property<Boolean>`

Default value
: [selfUpdateCheck](tools-intellij-platform-gradle-plugin-gradle-properties.html#selfUpdateCheck)

### 

`selfUpdateLock`

Represents a lock file used to limit the plugin version checks in time.
If the file is missing and other conditions are met, the version check is performed.

Type
: `RegularFileProperty`

### 

`pluginVersion`

Represents the current version of the plugin.

Type
: `Property<String>`

### 

`latestPluginVersion`

Represents the latest version of the plugin.

Type
: `Property<String>`

### 

`module`

Defines that the current project has only the [Module](tools-intellij-platform-gradle-plugin-plugins.html#module) applied but no [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform).

Type
: `Property<Boolean>`

## 

`instrumentCode`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Depends on: [jar](https://docs.gradle.org/current/dsl/org.gradle.jvm.tasks.Jar.html)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [JavaCompilerAware](tools-intellij-platform-gradle-plugin-task-awares.html#JavaCompilerAware)

Sources: [InstrumentCodeTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/InstrumentCodeTask.kt)
</tldr>

Executes the code instrumentation using the Ant tasks provided by the used IntelliJ Platform dependency.
The code instrumentation scans the compiled Java and Kotlin classes for JetBrains Annotations usages to replace them with their relevant functionalities.

The task is controlled with the [intellijPlatform.instrumentCode](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-instrumentCode) extension property, enabled by default.
To properly run the instrumentation, a Java Compiler dependency must be available. This is applied by default by the plugin; the former `instrumentationTools()` helper was removed and calling it is no longer necessary. You can still add and configure the dependency manually via [javaCompiler()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#code-instrumentation) if needed.
This dependency is resolved via the [intellijDependencies()](tools-intellij-platform-gradle-plugin-repositories-extension.html#additional-repositories) repository, which can be added separately or using the [defaultRepositories()](tools-intellij-platform-gradle-plugin-repositories-extension.html#default-repositories) helper.

See also:

* [instrumentedJar](#instrumentedJar)

### 

`sourceSetCompileClasspath`

Specifies the compile classpath of the project's source set.

Type
: `ConfigurableFileCollection`

### 

`classesDirs`

Specifies the list of directories with compiled classes.

Type
: `ConfigurableFileCollection`

Default value
: `classesDirs` of the project's source sets.

### 

`formsDirs`

Specifies the list of directories with GUI Designer form files.

Type
: `ConfigurableFileCollection`

Default value:
: `.form` files of the project's source sets.

### 

`sourceDirs`

Specifies the location of the source code.

Type
: `ConfigurableFileCollection`

### 

`instrumentationLogs`

Enables `INFO` logging when running Ant tasks.

Type
: `Property<Boolean>`

Default value:
: `false`

### 

`outputDirectory`

Specifies the output directory for instrumented classes.

Type
: `DirectoryProperty`

## 

`instrumentedJar`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Depends on: `jar`, [instrumentCode](#instrumentCode)

Extends: [Jar](https://docs.gradle.org/current/dsl/org.gradle.jvm.tasks.Jar.html)
</tldr>

Creates a copy of the current module's `jar` task output with instrumented classes added.

## 

`jarSearchableOptions`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [buildSearchableOptions](#buildSearchableOptions), [prepareSandbox](#prepareSandbox)

Extends: [Jar](https://docs.gradle.org/current/dsl/org.gradle.jvm.tasks.Jar.html)

Sources: [JarSearchableOptionsTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/JarSearchableOptionsTask.kt)
</tldr>

Creates a JAR file with searchable options to be distributed with the plugin.

### 

`destinationDirectory`

Specifies the directory where the JAR file will be created.

Type
: `DirectoryProperty`

Default value
: `[buildDirectory]/libs`

### 

`noSearchableOptionsWarning`

Specifies if a warning is emitted when no searchable options are found.
Can be disabled with [noSearchableOptionsWarning](tools-intellij-platform-gradle-plugin-gradle-properties.html#noSearchableOptionsWarning) Gradle property.

Type
: `Property<Boolean>`

Default value
: [noSearchableOptionsWarning](tools-intellij-platform-gradle-plugin-gradle-properties.html#noSearchableOptionsWarning)

## 

`patchPluginXml`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware)

Sources: [PatchPluginXmlTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PatchPluginXmlTask.kt)
</tldr>

Patches `plugin.xml` file with values provided with the [intelliJPlatform.pluginConfiguration](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration) extension.

### 

`inputFile`

Specifies the input `plugin.xml` file, which by default is picked from the main resource location.

Type
: `RegularFileProperty`

Default value
: `src/main/resources/META-INF/plugin.xml`

### 

`outputFile`

Specifies the patched output `plugin.xml` file, which by default is written to a temporary task-specific directory within the `build` directory.

Type
: `RegularFileProperty`

Default value
: `[buildDirectory]/tmp/patchPluginXml/plugin.xml`

### 

`pluginId`

Specifies a unique plugin identifier, which should be a fully qualified name similar to Java packages and must not collide with the ID of existing plugins.
The ID is a technical value used to identify the plugin in the IDE and [JetBrains Marketplace](https://plugins.jetbrains.com/).
The provided value will be assigned to the [&lt;id&gt;](plugin-configuration-file.html#idea-plugin__id) element.

Please use characters, numbers, and `.`/`-`/`_` symbols only and keep it reasonably short.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.id](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-id)

### 

`pluginName`

Specifies the user-visible plugin name.
It should use Title Case.
The provided value will be assigned to the [&lt;name&gt;](plugin-configuration-file.html#idea-plugin__name) element.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.name](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-name)

### 

`pluginVersion`

Specifies the plugin version displayed in the Plugins settings dialog and on the [JetBrains Marketplace](https://plugins.jetbrains.com) plugin page.
Plugins uploaded to [JetBrains Marketplace](https://plugins.jetbrains.com) must follow [semantic versioning](https://plugins.jetbrains.com/docs/marketplace/semver.htm).
The provided value will be assigned to the [&lt;version&gt;](plugin-configuration-file.html#idea-plugin__version) element.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.version](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-version)

### 

`pluginDescription`

Specifies the plugin description displayed in the Plugins settings dialog and on the [JetBrains Marketplace](https://plugins.jetbrains.com) plugin page.
Simple HTML elements, like text formatting, paragraphs, lists, etc., are allowed.
The description content is automatically wrapped in `<![CDATA[... ]]>`.
The provided value will be assigned to the [&lt;description&gt;](plugin-configuration-file.html#idea-plugin__description) element.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.description](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-description)

### 

`changeNotes`

A short summary of new features, bugfixes, and changes provided in this plugin version.
Change notes are displayed on the [JetBrains Marketplace](https://plugins.jetbrains.com) plugin page and in the Plugins settings dialog.
Simple HTML elements, like text formatting, paragraphs, lists, etc., are allowed.

The change notes content is automatically wrapped in `<![CDATA[... ]]>`.
The provided value will be assigned to the [&lt;change-notes&gt;](plugin-configuration-file.html#idea-plugin__change-notes) element.

To maintain and generate an up-to-date changelog, try using [Gradle Changelog Plugin](https://github.com/JetBrains/gradle-changelog-plugin).

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.changeNotes](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-changeNotes)

### 

`productDescriptorCode`

The plugin product code used in the JetBrains Sales System.
The code must be agreed with JetBrains in advance and follow [the requirements](https://plugins.jetbrains.com/docs/marketplace/add-required-parameters.html).
The provided value will be assigned to the [&lt;product-descriptor code=&quot;&quot;&gt;](plugin-configuration-file.html#idea-plugin__product-descriptor) element attribute.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.productDescriptor.code](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-productDescriptor-code)

### 

`productDescriptorReleaseDate`

Date of the major version release in the `YYYYMMDD` format.
The provided value will be assigned to the [&lt;product-descriptor release-date=&quot;&quot;&gt;](plugin-configuration-file.html#idea-plugin__product-descriptor) element attribute.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.productDescriptor.releaseDate](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-productDescriptor-releaseDate)

### 

`productDescriptorReleaseVersion`

Specifies the major version of the plugin in a special number format used for paid plugins on [JetBrains Marketplace](https://plugins.jetbrains.com/docs/marketplace/add-required-parameters.html).
The provided value will be assigned to the [&lt;product-descriptor release-version=&quot;&quot;&gt;](plugin-configuration-file.html#idea-plugin__product-descriptor) element attribute.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.productDescriptor.releaseVersion](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-productDescriptor-releaseVersion)

### 

`productDescriptorOptional`

Specifies the boolean value determining whether the plugin is a [Freemium](https://plugins.jetbrains.com/docs/marketplace/freemium.html) plugin.
The provided value will be assigned to the [&lt;product-descriptor optional=&quot;&quot;&gt;](plugin-configuration-file.html#idea-plugin__product-descriptor) element attribute.

Type
: `Property<Boolean>`

Default value
: [intellijPlatform.pluginConfiguration.productDescriptor.optional](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-productDescriptor-optional)

### 

`productDescriptorEap`

Specifies the boolean value determining whether the plugin is an EAP release.
The provided value will be assigned to the [&lt;product-descriptor eap=&quot;&quot;&gt;](plugin-configuration-file.html#idea-plugin__product-descriptor) element attribute.

Type
: `Property<Boolean>`

Default value
: [intellijPlatform.pluginConfiguration.productDescriptor.eap](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-productDescriptor-eap)

### 

`sinceBuild`

Specifies the lowest IDE version compatible with the plugin.
The provided value will be assigned to the [&lt;idea-version since-build=&quot;...&quot;/&gt;](plugin-configuration-file.html#idea-plugin__idea-version) element attribute.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.ideaVersion.sinceBuild](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-ideaVersion-sinceBuild)

### 

`untilBuild`

The highest IDE version compatible with the plugin.
The `until-build` attribute can be unset by setting `provider { null }` as a value.
However, if `until-build` is undefined, compatibility with all the IDEs since the version specified by the `since-build` is assumed, which can cause incompatibility errors in future builds.

The provided value will be assigned to the [&lt;idea-version until-build=&quot;...&quot;/&gt;](plugin-configuration-file.html#idea-plugin__idea-version) element attribute.

The `until-build` attribute can be unset by setting `provider { null }` as a value.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.ideaVersion.untilBuild](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-ideaVersion-untilBuild)

### 

`vendorName`

Specifies the vendor name or organization ID (if created) in the Plugins settings dialog and on the [JetBrains Marketplace](https://plugins.jetbrains.com) plugin page.
The provided value will be assigned to the [&lt;vendor&gt;](plugin-configuration-file.html#idea-plugin__vendor) element.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.vendor.name](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-vendor-name)

### 

`vendorEmail`

Specifies the vendor's email address.
The provided value will be assigned to the [&lt;vendor email=&quot;&quot;&gt;](plugin-configuration-file.html#idea-plugin__vendor) element attribute.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.vendor.email](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-vendor-email)

### 

`vendorUrl`

Specifies the link to the vendor's homepage.
The provided value will be assigned to the [&lt;vendor url=&quot;&quot;&gt;](plugin-configuration-file.html#idea-plugin__vendor) element attribute.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.vendor.url](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-vendor-url)

## 

`prepareJarSearchableOptions`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [buildSearchableOptions](#buildSearchableOptions), [prepareSandbox](#prepareSandbox)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [PluginAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginAware)

Sources: [PrepareJarSearchableOptionsTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PrepareJarSearchableOptionsTask.kt)
</tldr>

Collects the content produced with `buildSearchableOptions` for the `jarSearchableOptions`.
The task filters searchable option files using the main plugin descriptor when it exists and any searchable option descriptors found in plugin module projects.
This also supports composed multi-module builds where the root project doesn't define its own `plugin.xml`.

### 

`inputDirectory`

Specifies the directory where the prepared searchable options are read from.

Type
: `DirectoryProperty`

Default value
: [buildSearchableOptions.outputDirectory](#buildSearchableOptions-outputDirectory)

### 

`outputDirectory`

Specifies the directory where the filtered content is placed.

Type
: `DirectoryProperty`

Default value
: `[buildDirectory]/tmp/prepareJarSearchableOptions`

### 

`libContainer`

Specifies the `lib` directory within the current sandbox.

Type
: `DirectoryProperty`

Default value
: `[prepareSandbox.pluginDirectory]/lib`

### 

`searchableOptionsDescriptors`

Plugin descriptor files used to match generated searchable options to plugin IDs and module names.
The default value includes descriptors from the main source set and from module projects attached through plugin module dependencies.

Type
: `ConfigurableFileCollection`

## 

`preparePluginVariant_<os>_<arch>`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [composedJar](#composedJar)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html)

Sources: [PreparePluginVariantTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PreparePluginVariantTask.kt)
</tldr>

The six `preparePluginVariant_<os>_<arch>` tasks create the plugin JARs consumed by the corresponding [buildPluginVariants_&lt;os&gt;_&lt;arch&gt;](#buildPluginVariants-variant-tasks) tasks.
They are registered for the same Linux, macOS, and Windows `x86_64`/`arm64` matrix and run only when [intellijPlatform.nativeVariants.enabled](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-nativeVariants-enabled) is `true`.

Before creating a variant JAR, each task validates the effective [patchPluginXml.sinceBuild](#patchPluginXml-sinceBuild) value.
The value must resolve to `261` (IntelliJ Platform 2026.1) or later because the injected operating-system and architecture module dependencies are unavailable in earlier platform versions.

Each task copies the shared [composedJar](#composedJar), appends `-<os>-<arch>` to the version in `META-INF/plugin.xml`, and adds the matching operating-system and architecture module dependencies.
The resulting JAR is stored under `[buildDirectory]/intermediates/pluginVariants/[os]-[arch]`.

### 

`inputJar`

The shared composed plugin JAR used as the source of the variant.

Type
: `RegularFileProperty`

Default value
: [composedJar.archiveFile](#composedJar-archiveFile)

### 

`pluginVersion`

The plugin version written to the variant's `META-INF/plugin.xml` file.

Type
: `Property<String>`

Default value
: [intellijPlatform.pluginConfiguration.version](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-version) with the `-<os>-<arch>` suffix

### 

`operatingSystem`

The target operating-system identifier used for the `com.intellij.modules.os.<os>` dependency.
The version written to the descriptor is controlled independently by [pluginVersion](#preparePluginVariant-pluginVersion).

Type
: `Property<String>`

Default value
: `linux`, `mac`, or `windows`, configured from the fixed variant for each task registered by the plugin

### 

`architecture`

The target architecture identifier used for the `com.intellij.modules.arch.<arch>` dependency.
The version written to the descriptor is controlled independently by [pluginVersion](#preparePluginVariant-pluginVersion).

Type
: `Property<String>`

Default value
: `x86_64` or `arm64`, configured from the fixed variant for each task registered by the plugin

### 

`outputDirectory`

The directory containing the prepared variant JAR.

Type
: `DirectoryProperty`

Default value
: `[buildDirectory]/intermediates/pluginVariants/[os]-[arch]`

## 

`prepareSandbox`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Depends on: `jar`, [instrumentedJar](#instrumentedJar)

Extends: [Sync](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.Sync.html), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware), [SplitModeAware](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware), [PluginInstallationTargetAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginInstallationTargetAware)

Sources: [PrepareSandboxTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PrepareSandboxTask.kt)
</tldr>

Prepares a sandbox environment with the plugin and its dependencies installed.
The sandbox directory is required by tasks that run IDE and tests in isolation from other instances, like when multiple IntelliJ Platforms are used for testing with [runIde](#runIde), [prepareTest](#prepareTest), [testIdeUi](#testIdeUi), or [testIdePerformance](#testIdePerformance) tasks.
The sandbox directory is created within the container configurable with [intellijPlatform.sandboxContainer](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-sandboxContainer).

Tasks based on the [PrepareSandboxTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PrepareSandboxTask.kt) are sandbox producers and can be associated with sandbox consumers.
To define the consumer task, make it extend from [SandboxAware](tools-intellij-platform-gradle-plugin-task-awares.html#SandboxAware) and apply the `consumer.applySandboxFrom(producer)` function.

When native variants are enabled, native-aware sandbox producers use the variant matching the current operating system and architecture.
For those sandboxes, the matching [preparePluginVariant_&lt;os&gt;_&lt;arch&gt;](#preparePluginVariant) output replaces the base plugin JAR, and files configured for that target in [intellijPlatform.nativeVariants](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-nativeVariants) are overlaid onto the sandbox plugin directory.
The base `prepareSandbox` task remains platform-independent and supplies the base [buildPlugin](#buildPlugin) archive; custom testing sandboxes other than `intellijPlatformTesting.runIde` also remain platform-independent.

### Native-Aware Sandbox Tasks

The plugin enables the current host variant for these sandbox producers:

| Sandbox task |Consumer |
--------------------------
| `prepareSandbox_runIde` |[runIde](#runIde) |
| `prepareSandbox_runIdeBackend` |[runIdeBackend](#runIdeBackend) and the split-mode aggregate task |
| `prepareSandbox_runIdeFrontend` |[runIdeFrontend](#runIdeFrontend) and the split-mode aggregate task |
| [prepareTestSandbox](#prepareTestSandbox) |Ordinary Gradle [test](#test) |
| [prepareTestIdePerformanceSandbox](#prepareTestIdePerformanceSandbox) |Standard [testIdePerformance](#testIdePerformance) |
| `prepareSandbox_<customRunIdeTask>` |Entries registered with `intellijPlatformTesting.runIde` |

### 

`sandboxSuffix`

Represents the suffix used i.e., for test-related or custom tasks.

The default suffix is composed of the task name (`prepare[X]Sandbox[_Y]`) to the `-[X][Y]` format.

Type
: `Property<String>`

Default value
: Derived from the task name, for example `""`, `-test`, or `-testIdePerformance`

### 

`defaultDestinationDirectory`

Specifies the default sandbox destination directory where plugin files will be copied.

Type
: `DirectoryProperty`

Default value
: [SandboxAware.sandboxPluginsDirectory](tools-intellij-platform-gradle-plugin-task-awares.html#SandboxAware-sandboxPluginsDirectory), or [SplitModeAware.sandboxPluginsFrontendDirectory](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware-sandboxPluginsFrontendDirectory) when [pluginInstallationTarget](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware-pluginInstallationTarget) is `FRONTEND`

### 

`pluginName`

Specifies the name of the plugin directory in the sandbox.

Type
: `Property<String>`

Default value
: [intellijPlatform.projectName](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-projectName)

### 

`pluginDirectory`

Specifies the directory where the plugin artifacts are to be placed.

Type
: `DirectoryProperty`

Default value
: [defaultDestinationDirectory](#prepareSandbox-defaultDestinationDirectory)/[projectName](#prepareSandbox-pluginName)

### 

`disabledPlugins`

An internal field to hold a list of plugins to be disabled within the current sandbox.
This property is controlled with the `disablePlugin()` and `disablePlugins()` methods of [plugins {}](tools-intellij-platform-gradle-plugin-testing-extension.html#plugins).

Type
: `SetProperty<String>`

### 

`subscriptionKey`

Specifies the IntelliJ IDEA subscription key file used in this sandbox.
The key file is copied to `config/idea.key`, and `com.intellij.modules.ultimate` is removed from `config/disabled_plugins.txt`.

Type
: `RegularFileProperty`

Default value
: [intellijPlatform.subscriptionKey](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-subscriptionKey)

### 

`pluginJar`

Specifies the output archive copied into the sandbox as the main plugin artifact.

Type
: `RegularFileProperty`

Default value
: [composedJar.archiveFile](#composedJar-archiveFile)

### 

`pluginsClasspath`

Specifies a list of dependencies on external plugins resolved from the `intellijPlatformPluginsExtracted` configuration added with [Dependencies Extension](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins)

Type
: `ConfigurableFileCollection`

### 

`runtimeClasspath`

Dependencies copied into the sandbox plugin's `lib` directory.
Regular sandboxes use `intellijPlatformSandboxRuntimeClasspath`, while test sandboxes use `intellijPlatformTestSandboxRuntimeClasspath`.
These dedicated configurations allow [sandbox-only dependency exclusions](tools-intellij-platform-gradle-plugin-dependencies-extension.html#sandbox-runtime-classpaths) without changing the project's compile or test classpaths.

Type
: `ConfigurableFileCollection`

## 

`prepareTest`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Depends on: [prepareTestSandbox](#prepareTestSandbox)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [TestableAware](tools-intellij-platform-gradle-plugin-task-awares.html#TestableAware)

Sources: [PrepareTestTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PrepareTestTask.kt)
</tldr>

Prepares an immutable [test](#test) task and provides all necessary dependencies and configurations for a proper testing configuration.

## 

`prepareTestSandbox`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Depends on: `jar`, [instrumentedJar](#instrumentedJar)

Extends: [Sync](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.Sync.html), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware), [SplitModeAware](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware), [PluginInstallationTargetAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginInstallationTargetAware)

Sources: [PrepareSandboxTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PrepareSandboxTask.kt)
</tldr>

The [prepareSandbox](#prepareSandbox) task instance configured to work with the [test](#test) task.

## 

`prepareTestIdePerformanceSandbox`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Depends on: `jar`, [instrumentedJar](#instrumentedJar)

Extends: [Sync](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.Sync.html), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware), [SplitModeAware](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware), [PluginInstallationTargetAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginInstallationTargetAware)

Sources: [PrepareSandboxTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PrepareSandboxTask.kt)
</tldr>

The [prepareSandbox](#prepareSandbox) task instance configured to work with the [testIdePerformance](#testIdePerformance) task.

## 

`printBundledModules`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module), [Base](tools-intellij-platform-gradle-plugin-plugins.html#base), [GrammarKit](tools-intellij-platform-gradle-plugin-plugins.html#grammarkit)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware)

Sources: [PrintBundledModulesTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PrintBundledModulesTask.kt)
</tldr>

Prints the list of bundled modules available within the currently targeted IntelliJ Platform.
The task uses the same cached IDE layout index as bundled module dependency resolution, so module IDs and aliases are resolved consistently.

### 

`ideLayoutIndexService`

Shared service used to resolve the cached IDE layout index for the currently targeted IDE.

Type
: `Property<IdeLayoutIndexService>`

### 

`ideLayoutIndexCacheDirectory`

On-disk cache location for layout-index snapshots derived from extracted IDE distributions.

Type
: `DirectoryProperty`

## 

`printBundledPlugins`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module), [Base](tools-intellij-platform-gradle-plugin-plugins.html#base), [GrammarKit](tools-intellij-platform-gradle-plugin-plugins.html#grammarkit)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware)

Sources: [PrintBundledPluginsTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PrintBundledPluginsTask.kt)
</tldr>

Prints the list of bundled plugins available within the currently targeted IntelliJ Platform.
The task uses the same cached IDE layout index as bundled plugin dependency resolution.

### 

`ideLayoutIndexService`

Shared service used to resolve the cached IDE layout index for the currently targeted IDE.

Type
: `Property<IdeLayoutIndexService>`

### 

`ideLayoutIndexCacheDirectory`

On-disk cache location for layout-index snapshots derived from extracted IDE distributions.

Type
: `DirectoryProperty`

## 

`printProductsReleases`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module), [Base](tools-intellij-platform-gradle-plugin-plugins.html#base), [GrammarKit](tools-intellij-platform-gradle-plugin-plugins.html#grammarkit)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [ProductReleasesValueSource.FilterParameters](tools-intellij-platform-gradle-plugin-types.html#ProductReleasesFilterParameters)

Sources: [PrintProductsReleasesTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PrintProductsReleasesTask.kt)
</tldr>

Prints the list of binary product releases that, by default, match the currently selected IntelliJ Platform along with
[intellijPlatform.pluginConfiguration.ideaVersion.sinceBuild](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-ideaVersion-sinceBuild)
and [intellijPlatform.pluginConfiguration.ideaVersion.untilBuild](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-ideaVersion-untilBuild) properties.

The filter used for retrieving the release list can be customized by using properties provided with
[ProductReleasesValueSource.FilterParameters](tools-intellij-platform-gradle-plugin-types.html#ProductReleasesFilterParameters).

### 

`productsReleases`

Property that holds the list of product releases to print and which can be used to retrieve the result list.

Type
: `ListProperty<String>`

Default value
: The output of `ProductReleasesValueSource` using default configuration

See also:

* [Types: ProductReleasesValueSource.FilterParameters](tools-intellij-platform-gradle-plugin-types.html#ProductReleasesFilterParameters)

## 

`publishPlugin`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [buildPluginVariants](#buildPluginVariants) when native variants are enabled; otherwise [buildPlugin](#buildPlugin) and [signPlugin](#signPlugin)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html)

Sources: [PublishPluginTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/PublishPluginTask.kt)
</tldr>

Publishes one or more plugin archives to the remote plugins repository, such as [JetBrains Marketplace](https://plugins.jetbrains.com).
When [intellijPlatform.nativeVariants.enabled](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-nativeVariants-enabled) is `true`, all six archives produced by [buildPluginVariants](#buildPluginVariants) are uploaded.

See also:

* [Uploading a Plugin to JetBrains Marketplace](publishing-plugin.html#uploading-a-plugin-to-jetbrains-marketplace)

* [Publishing Plugin With Gradle](publishing-plugin.html#publishing-plugin-with-gradle)

* [Plugin upload API](https://plugins.jetbrains.com/docs/marketplace/plugin-upload.html)

### 

`archiveFiles`

Specifies the ZIP archive files to publish to the remote repository.
With native variants enabled, the collection contains all [buildPluginVariants.archiveFiles](#buildPluginVariants-archiveFiles).
Otherwise, it contains [signPlugin.signedArchiveFile](#signPlugin-signedArchiveFile) when the signing task produces an archive or [buildPlugin.archiveFile](#buildPlugin-archiveFile).

Type
: `ConfigurableFileCollection`

Default value
: [buildPluginVariants.archiveFiles](#buildPluginVariants-archiveFiles) when native variants are enabled; otherwise [signPlugin.signedArchiveFile](#signPlugin-signedArchiveFile) or [buildPlugin.archiveFile](#buildPlugin-archiveFile)

See also:

* [Extension: intellijPlatform.signing](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing)

* [Extension: intellijPlatform.nativeVariants](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-nativeVariants)

### 

`host`

Specifies the URL host of a plugin repository.

Type
: `Property<String>`

Default value
: [intellijPlatform.publishing.host](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-publishing-host)

### 

`token`

Specifies the authorization token.

Type
: `Property<String>`

Required
: yes

Default value
: [intellijPlatform.publishing.token](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-publishing-token)

### 

`channels`

Specifies a list of [JetBrains Marketplace](https://plugins.jetbrains.com) channel names used as destination for the plugin upload.

Type
: `ListProperty<String>`

Default value
: [intellijPlatform.publishing.channels](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-publishing-channels)

### 

`hidden`

Publishes the plugin update and marks it as [hidden](https://plugins.jetbrains.com/docs/marketplace/hidden-plugin.html) to prevent public visibility after approval.

Type
: `Property<Boolean>`

Default value
: [intellijPlatform.publishing.hidden](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-publishing-hidden)

### 

`ideServices`

Specifies if the IDE Services plugin repository service should be used.

Type
: `Property<Boolean>`

Default value
: [intellijPlatform.publishing.ideServices](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-publishing-ideServices)

## 

`runIde`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [patchPluginXml](#patchPluginXml), [prepareSandbox_runIde](#prepareSandbox-runIde)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html), [RunnableIdeAware](tools-intellij-platform-gradle-plugin-task-awares.html#RunnableIdeAware), [SplitModeAware](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware), [PluginInstallationTargetAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginInstallationTargetAware), [ComposeHotReloadAware](tools-intellij-platform-gradle-plugin-task-awares.html#ComposeHotReloadAware), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware)

Sources: [RunIdeTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/RunIdeTask.kt)
</tldr>

Runs the IDE instance using the currently selected IntelliJ Platform with the built plugin loaded.
It directly extends the [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html) Gradle task, which allows for an extensive configuration (system properties, memory management, etc.).

This task runs against the IntelliJ Platform and plugins specified in project dependencies.
To register a customized task, use [intellijPlatformTesting.runIde](tools-intellij-platform-gradle-plugin-testing-extension.html).

When [splitMode](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware-splitMode) is enabled, the task starts the IDE in Split Mode.
To run the backend and frontend as separate Gradle tasks, use [runIdeBackend](#runIdeBackend) and [runIdeFrontend](#runIdeFrontend), or generate IDE run configurations with [generateSplitModeRunConfigurations](#generateSplitModeRunConfigurations).

On launch, the task logs the path to the sandbox log file (`idea.log` in the sandbox log directory) at the lifecycle level, prefixed with `IDE logs:`.
In Split Mode, the backend and frontend processes report their paths separately, prefixed with `IDE logs (backend):` and `IDE logs (frontend):`.

### 

`executionMode`

Selects the launch profile used by the task.

Type
: `Property<RunIdeTask.ExecutionMode>`

Default value
: `STANDARD`

Values
: `STANDARD`, `SPLIT_MODE_BACKEND`, `SPLIT_MODE_FRONTEND`

### 

`splitModeServerPort`

The backend server port used by split-mode backend and frontend tasks.

Type
: `Property<Int>`

Default value
: `5990`

### 

`splitModeFrontendJoinLink`

An advanced override for the join link passed to the frontend process when [runIdeFrontend](#runIdeFrontend) is launched directly.
Usually, setting [splitModeServerPort](#runIde-splitModeServerPort) and starting [runIdeBackend](#runIdeBackend) first is sufficient.

Type
: `Property<String>`

### 

`purgeOldLogDirectories`

Removes stale sandbox log directories before launching the IDE.
This is useful for split-mode run configurations where frontend and backend logs are attached to the IDE run configuration.

Type
: `Property<Boolean>`

Default value
: `false`

Command-line option
: `--purge-old-log-directories`

## 

`runIdeBackend`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [patchPluginXml](#patchPluginXml), [prepareSandbox_runIdeBackend](#prepareSandbox-runIde)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html), [RunnableIdeAware](tools-intellij-platform-gradle-plugin-task-awares.html#RunnableIdeAware), [SplitModeAware](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware), [PluginInstallationTargetAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginInstallationTargetAware), [ComposeHotReloadAware](tools-intellij-platform-gradle-plugin-task-awares.html#ComposeHotReloadAware), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware)

Sources: [RunIdeTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/RunIdeTask.kt)
</tldr>

Runs the IDE backend process in Split Mode.
The task writes the frontend join link to [splitModeFrontendJoinLinkFile](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware-splitModeFrontendJoinLinkFile), which is then consumed by [runIdeFrontend](#runIdeFrontend).

Passing arguments directly with `args` is not supported for split-mode backend tasks.
Use `argumentProviders` instead.

## 

`runIdeFrontend`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [patchPluginXml](#patchPluginXml), [prepareSandbox_runIdeFrontend](#prepareSandbox-runIde)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html), [RunnableIdeAware](tools-intellij-platform-gradle-plugin-task-awares.html#RunnableIdeAware), [SplitModeAware](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware), [PluginInstallationTargetAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginInstallationTargetAware), [ComposeHotReloadAware](tools-intellij-platform-gradle-plugin-task-awares.html#ComposeHotReloadAware), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware)

Sources: [RunIdeTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/RunIdeTask.kt)
</tldr>

Runs the JetBrains Client frontend process in Split Mode.
The task waits for the join link written by [runIdeBackend](#runIdeBackend), or uses [splitModeFrontendJoinLink](#runIde-splitModeFrontendJoinLink) when it is configured explicitly.

Passing arguments directly with `args` is not supported for split-mode frontend tasks.
Use `argumentProviders` instead.

## 

`runIdeForUiTests`

Runs the IDE instance using the currently selected IntelliJ Platform with the built plugin and Robot Server plugin loaded.

This task is not available by default and needs to be registered manually by applying the following code:

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
          "-Drobot-server.port=8082",
          "-Dide.mac.message.dialogs.as.sheets=false",
          "-Djb.privacy.policy.text=<!--999.999-->",
          "-Djb.consents.confirmation.enabled=false",
        ]
      } as CommandLineArgumentProvider)
    }
    plugins {
      robotServerPlugin()
    }
  }
}
```

## 

`signPlugin`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [buildPlugin](#buildPlugin)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html), [SigningAware](tools-intellij-platform-gradle-plugin-task-awares.html#SigningAware)

Sources: [SignPluginTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/SignPluginTask.kt)
</tldr>

Signs the plugin distribution ZIP archive with the provided key using the [Marketplace ZIP Signer](https://github.com/JetBrains/marketplace-zip-signer) library.
To sign the plugin before publishing to [JetBrains Marketplace](https://plugins.jetbrains.com) with the [signPlugin](#signPlugin) task,
it is required to provide a certificate chain and a private key with its password using the
[intellijPlatform.signing](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing) extension.

For the standard archive produced by [buildPlugin](#buildPlugin), as soon as [privateKey](#signPlugin-privateKey) (or [privateKeyFile](#signPlugin-privateKeyFile)) and [certificateChain](#signPlugin-certificateChain)
(or [certificateChainFile](#signPlugin-certificateChainFile)) are specified,
this task is executed automatically before [publishPlugin](#publishPlugin).

For more details, see [Plugin Signing](plugin-signing.html).

### 

`archiveFile`

Specifies the unsigned ZIP archive input file.
Corresponds to the `in` CLI option.

Type
: `RegularFileProperty`

Default value
: [buildPlugin.archiveFile](#buildPlugin-archiveFile)

### 

`signedArchiveFile`

Specifies the signed ZIP archive output file.
Corresponds to the `out` CLI option.

Predefined with the name of the ZIP archive file with `-signed` name suffix attached.
The output file is placed next to the input [archiveFile](#signPlugin-archiveFile).

Type
: `RegularFileProperty`

Default value
: [signPlugin.archiveFile](#signPlugin-archiveFile) with `-signed` suffix applied to the name

### 

`keyStore`

Specifies the KeyStore file path.
Corresponds to the `ks` CLI option.

Type
: `Property<String>`

Default value
: [intellijPlatform.signing.keyStore](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-keyStore)

### 

`keyStorePassword`

Specifies the KeyStore password.
Corresponds to the `ks-pass` CLI option.

Type
: `Property<String>`

Default value
: [intellijPlatform.signing.keyStorePassword](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-keyStorePassword)

### 

`keyStoreKeyAlias`

Specifies the KeyStore key alias.
Corresponds to the `ks-key-alias` CLI option.

Type
: `Property<String>`

Default value
: [intellijPlatform.signing.keyStoreKeyAlias](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-keyStoreKeyAlias)

### 

`keyStoreType`

Specifies the KeyStore type.
Corresponds to the `ks-type` CLI option.

Type
: `Property<String>`

Default value
: [intellijPlatform.signing.keyStoreType](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-keyStoreType)

### 

`keyStoreProviderName`

Specifies the JCA KeyStore Provider name.
Corresponds to the `ks-provider-name` CLI option.

Type
: `Property<String>`

Default value
: [intellijPlatform.signing.keyStoreProviderName](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-keyStoreProviderName)

### 

`privateKey`

Specifies the encoded private key in the PEM format.
Corresponds to the `key` CLI option.

Takes precedence over the [privateKeyFile](#signPlugin-privateKeyFile) property.

Type
: `Property<String>`

Default value
: [intellijPlatform.signing.privateKey](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-privateKey)

### 

`privateKeyFile`

Specifies a file with an encoded private key in the PEM format.
Corresponds to the `key-file` CLI option.

Type
: `RegularFileProperty`

Default value
: [intellijPlatform.signing.privateKeyFile](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-privateKeyFile)

### 

`password`

Specifies the password required to decrypt the private key.
Corresponds to the `key-pass` CLI option.

Type
: `Property<String>`

Default value
: [intellijPlatform.signing.password](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-password)

### 

`certificateChain`

Specifies a string containing X509 certificates.
The first certificate in the chain will be used as a certificate authority (CA).
This parameter corresponds to the `cert` CLI option.

Takes precedence over the [certificateChainFile](#signPlugin-certificateChainFile) property.

Type
: `Property<String>`

Default value
: [intellijPlatform.signing.certificateChain](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-certificateChain)

### 

`certificateChainFile`

Specifies the path to the file containing X509 certificates.
The first certificate in the chain will be used as a certificate authority (CA).
Corresponds to the `cert-file` CLI option.

Type
: `RegularFileProperty`

Default value
: [intellijPlatform.signing.certificateChainFile](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-signing-certificateChainFile)

## 

`test`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Depends on: [prepareTest](#prepareTest)

Extends: [Test](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.testing.Test.html)

Sources: [TestCompanion](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/companion/TestCompanion.kt)
</tldr>

The base Gradle `test` task is preconfigured using the [TestCompanion](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/companion/TestCompanion.kt) class to run tests with IntelliJ Platform, sandbox, and all system properties set.

The task itself isn't mutated and a dedicated [prepareTest](#prepareTest) task is involved to request for required IntelliJ Platform and sandbox configuration.

Bundled plugins declared in the target IDE's `product-info.json` are added to the test classpath by default.
Set [testIdeBundledPluginsClasspathEnabled](tools-intellij-platform-gradle-plugin-gradle-properties.html#testIdeBundledPluginsClasspathEnabled) to `false` to opt out and use [testIdeBundledPluginsClasspathExcludes](tools-intellij-platform-gradle-plugin-gradle-properties.html#testIdeBundledPluginsClasspathExcludes) to control exclusions.
These properties configure both this task and custom [testIde](#testIde) tasks.

## 

`testIde`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Extends: [Test](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.testing.Test.html), [TestableAware](tools-intellij-platform-gradle-plugin-task-awares.html#TestableAware), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware)

Sources: [TestIdeTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/TestIdeTask.kt)
</tldr>

Runs tests using a custom IntelliJ Platform with the developed plugin installed.
It directly extends the [Test](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.testing.Test.html) Gradle task, which allows for an extensive configuration (system properties, memory management, etc.).

The [TestIdeTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/TestIdeTask.kt) is a class used only for handling custom `testIde` tasks.

To register an additional customized test task, use [intellijPlatformTesting.testIde](tools-intellij-platform-gradle-plugin-testing-extension.html).

Bundled plugins declared in `product-info.json` are added to its classpath by default, controlled with [testIdeBundledPluginsClasspathEnabled](tools-intellij-platform-gradle-plugin-gradle-properties.html#testIdeBundledPluginsClasspathEnabled) and filtered with [testIdeBundledPluginsClasspathExcludes](tools-intellij-platform-gradle-plugin-gradle-properties.html#testIdeBundledPluginsClasspathExcludes).

## 

`testIdePerformance`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [prepareTestIdePerformanceSandbox](#prepareTestIdePerformanceSandbox)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html), [RunnableIdeAware](tools-intellij-platform-gradle-plugin-task-awares.html#RunnableIdeAware), [TestableAware](tools-intellij-platform-gradle-plugin-task-awares.html#TestableAware), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware)

Sources: [TestIdePerformanceTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/TestIdePerformanceTask.kt)
</tldr>

Runs performance tests on the IDE with the developed plugin installed.

This task runs against the IntelliJ Platform and plugins specified in project dependencies.
To register an additional customized task, use [intellijPlatformTesting.testIdePerformance](tools-intellij-platform-gradle-plugin-testing-extension.html).

### 

`testDataDirectory`

Path to the directory with test projects and `.ijperf` files.

Type
: `DirectoryProperty`

### 

`artifactsDirectory`

Path to the directory where performance test artifacts, such as IDE logs, snapshots, and screenshots, are stored.

Type
: `DirectoryProperty`

### 

`profilerName`

Name of the profiler used during execution.

Type
: `Property<ProfilerName>`

Default value
: `ProfilerName.ASYNC`

## 

`testIdeUi`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Extends: [Test](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.testing.Test.html), [TestableAware](tools-intellij-platform-gradle-plugin-task-awares.html#TestableAware)

Sources: [TestIdeUiTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/TestIdeUiTask.kt)
</tldr>

Runs the IDE instance with the developed plugin and Starter framework for UI testing.

### 

`archiveFile`

Specifies the archive file representing the input file to be tested.

Type
: `RegularFileProperty`

Default value
: [buildPlugin.archiveFile](#buildPlugin-archiveFile)

## 

`verifyPlugin`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [buildPlugin](#buildPlugin)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html), [RuntimeAware](tools-intellij-platform-gradle-plugin-task-awares.html#RuntimeAware), [PluginVerifierAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginVerifierAware), [ProblemsAware](tools-intellij-platform-gradle-plugin-task-awares.html#ProblemsAware)

Sources: [VerifyPluginTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/VerifyPluginTask.kt)
</tldr>

Runs the [IntelliJ Plugin Verifier](verifying-plugin-compatibility.html) CLI tool to check the binary compatibility with specified IDE builds.

Due to caching, the latest Plugin Verifier release version (1.411) might not be picked up by Gradle immediately.
In such cases, [refresh dependencies](https://docs.gradle.org/current/userguide/dependency_caching.html#sec:refreshing-dependencies)
manually.

The task derives its pass/fail verdict from the Plugin Verifier report files rather than the console output, so the outcome no longer depends on [teamCityOutputFormat](#verifyPlugin-teamCityOutputFormat).
If the Plugin Verifier finishes without writing a verdict for any of the target IDEs, the task fails instead of reporting a false-positive success.

See also:

* [Extension: intellijPlatform.pluginVerification](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification)

* [Types: FailureLevel](tools-intellij-platform-gradle-plugin-types.html#FailureLevel)

* [Types: Subsystems](tools-intellij-platform-gradle-plugin-types.html#Subsystems)

* [Types: VerificationReportsFormats](tools-intellij-platform-gradle-plugin-types.html#VerificationReportsFormats)

* [Verifying Plugin Compatibility](verifying-plugin-compatibility.html)

* [IntelliJ Plugin Verifier](https://github.com/JetBrains/intellij-plugin-verifier)

### 

`ides`

Specifies IntelliJ Platform IDEs used by the IntelliJ Plugin Verifier CLI tool for binary plugin verification.
The list of IDEs is managed through the [intellijPlatform.pluginVerification.ides](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-ides) extension.

Type
: `ConfigurableFileCollection`

### 

`archiveFile`

Specifies the input ZIP archive file of the plugin to verify.
If this parameter is empty, the task will be skipped.

Type
: `RegularFileProperty`

Default value
: [buildPlugin.archiveFile](#buildPlugin-archiveFile)

### 

`externalPrefixes`

Specifies a list of class prefixes from external libraries.
The Plugin Verifier will not report `No such class` errors for classes in these packages.

Type
: `ListProperty<String>`

Default value
: [intellijPlatform.pluginVerification.externalPrefixes](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-externalPrefixes)

### 

`failureLevel`

Specifies the verification level at which the task fails if any reported issue matches.

Type
: [ListProperty&lt;FailureLevel&gt;](tools-intellij-platform-gradle-plugin-types.html#FailureLevel)

Default value
: [intellijPlatform.pluginVerification.failureLevel](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-failureLevel)

### 

`freeArgs`

Represents a list of free arguments that are passed directly to the IntelliJ Plugin Verifier CLI tool.
These arguments are used in conjunction with those provided by dedicated options.

See [How to mute specific problems in pluginVerification?](tools-intellij-platform-gradle-plugin-faq.html#mutePluginVerifierProblems) for sample usage.

Type
: `ListProperty<String>`

Default value
: [intellijPlatform.pluginVerification.freeArgs](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-freeArgs)

### 

`ignoredProblemsFile`

Specifies a file that contains a list of problems that will be ignored in a report.

Type
: `RegularFileProperty`

Default value
: [intellijPlatform.pluginVerification.ignoredProblemsFile](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-ignoredProblemsFile)

### 

`offline`

Indicates whether the operation is executed in offline mode.
This depends on the start parameters specified in Gradle.

Type
: `Property<Boolean>`

Default value
: `StartParameter.isOffline`

See also:

* [StartParameter](https://docs.gradle.org/current/javadoc/org/gradle/StartParameter.html)

* [Command Line Execution Options](https://docs.gradle.org/current/userguide/command_line_interface.html#sec:command_line_execution_options)

### 

`subsystemsToCheck`

Specifies which subsystems of the IDE should be checked.

Type
: [Subsystems](tools-intellij-platform-gradle-plugin-types.html#Subsystems)

Default value
: [intellijPlatform.pluginVerification.subsystemsToCheck](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-subsystemsToCheck)

### 

`teamCityOutputFormat`

Specifies whether to use the TeamCity-compatible output format.
If set to `true`, outputs in a format compatible with [TeamCity](https://www.jetbrains.com/teamcity/), directing the output to stdout.

The [NOT_DYNAMIC](tools-intellij-platform-gradle-plugin-types.html#FailureLevel) failure level can't be combined with `teamCityOutputFormat = true` (also when selected via [FailureLevel.ALL](tools-intellij-platform-gradle-plugin-types.html#FailureLevel)), as the dynamic-plugin eligibility status is neither persisted in the report files nor emitted as a TeamCity service message.
The [verifyPlugin](#verifyPlugin) task fails fast with a configuration error if both are set.

Type
: `Property<Boolean>`

Default value
: [intellijPlatform.pluginVerification.teamCityOutputFormat](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-teamCityOutputFormat)

### 

`verificationReportsDirectory`

Specifies the path to the directory where verification reports will be saved.

Type
: `DirectoryProperty`

Default value
: [intellijPlatform.pluginVerification.verificationReportsDirectory](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-verificationReportsDirectory)

### 

`verificationReportsFormats`

Specifies the output formats of the verification reports.

Type
: [ListProperty&lt;VerificationReportsFormats&gt;](tools-intellij-platform-gradle-plugin-types.html#VerificationReportsFormats)

Default value
: [intellijPlatform.pluginVerification.verificationReportsFormats](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-verificationReportsFormats)

### 

`listIdes`

Lists the IDEs that would be used for verification without running the verification itself.

Type
: `Property<Boolean>`

Default value
: `false`

### 

`problemsReportFile`

Default path of the Problems API HTML report file produced for verification failures.

Type
: `RegularFileProperty`

Default value
: `[buildDirectory]/reports/problems/problems-report.html`

### 

`useBundledRuntime`

Determines whether the IntelliJ Plugin Verifier resolves plugin classes against the JetBrains Runtime (JBR) bundled with each verified IDE, instead of a single runtime shared across all verified IDEs.

When enabled (default), the `-runtime-dir` option is not passed to the Plugin Verifier, so it resolves classes against the JBR bundled within each target IDE.
The resolved runtime (the JetBrains Runtime associated with the IntelliJ Platform used to build the plugin) is still exposed through the `JAVA_HOME` environment variable and used only as a fallback for IDEs that don't ship a bundled JBR.

When disabled, that resolved runtime is forced for all verified IDEs via the `-runtime-dir` option — the behavior from before this option was introduced.

Type
: `Property<Boolean>`

Default value
: [intellijPlatform.pluginVerification.useBundledRuntime](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-useBundledRuntime)

## 

`verifyPluginProjectConfiguration`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform), [Module](tools-intellij-platform-gradle-plugin-plugins.html#module)

Depends on: [patchPluginXml](#patchPluginXml)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware), [KotlinMetadataAware](tools-intellij-platform-gradle-plugin-task-awares.html#KotlinMetadataAware), [RuntimeAware](tools-intellij-platform-gradle-plugin-task-awares.html#RuntimeAware), [PluginAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginAware), [ModuleAware](tools-intellij-platform-gradle-plugin-task-awares.html#ModuleAware), [ProblemsAware](tools-intellij-platform-gradle-plugin-task-awares.html#ProblemsAware)

Sources: [VerifyPluginProjectConfigurationTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/VerifyPluginProjectConfigurationTask.kt)
</tldr>

Validates the plugin project configuration:

* The [patchPluginXml.sinceBuild](#patchPluginXml-sinceBuild) property can't be lower than the target IntelliJ Platform major version.

* The `until-build` property should be removed for IntelliJ Platform `2024.3+` (`243+`).

* The Java/Kotlin `sourceCompatibility` and `targetCompatibility` properties should be aligned with the Java versions required by [patchPluginXml.sinceBuild](#patchPluginXml-sinceBuild) and the currently used IntelliJ Platform.

* The Kotlin API version should be aligned with the version required by [patchPluginXml.sinceBuild](#patchPluginXml-sinceBuild) and the currently used IntelliJ Platform.

* The used IntelliJ Platform version should be `2023.3` (`233`) or higher.

* The dependency on the [Kotlin Standard Library (stdlib)](using-kotlin.html#kotlin-standard-library) should be excluded.

* The Kotlin Coroutines library should not be added explicitly to the project as it is already provided with the IntelliJ Platform.

* The IntelliJ Platform cache directory should be excluded from the version control system. Add the `.intellijPlatform` entry to the `.gitignore` file.

* The currently selected Java Runtime is not JetBrains Runtime (JBR).

For more details regarding the Java version used in the specific IntelliJ SDK, see [Build Number Ranges](build-number-ranges.html).

See also:

* [Build Number Ranges](build-number-ranges.html)

* [Kotlin Standard Library (stdlib)](using-kotlin.html#kotlin-standard-library)

* [Incremental compilation](using-kotlin.html#incremental-compilation)

### 

`rootDirectory`

Specifies the root project path.

Type
: `Property<File>`

Default value
: `[rootProject]`

### 

`intellijPlatformCache`

Specifies the IntelliJ Platform cache directory.

Type
: `DirectoryProperty`

Default value
: [intellijPlatform.caching.path](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-caching-path)

### 

`gitignoreFile`

Specifies the `.gitignore` file located in the `[rootDirectory]`, tracked for content changes.

Type
: `RegularFileProperty`

Default value
: `[rootProject]/.gitignore`

### 

`sourceCompatibility`

Specifies the `JavaCompile.sourceCompatibility` property value defined in the build script.

Type
: `Property<String>`

Default value
: `JavaCompile.sourceCompatibility`

### 

`targetCompatibility`

Specifies the `JavaCompile.targetCompatibility` property value defined in the build script.

Type
: `Property<String>`

Default value
: `JavaCompile.targetCompatibility`

### 

`mutedMessages`

List of message patterns to mute during verification.
Each pattern is matched against the message text using a case-sensitive `contains` check.

Type
: `ListProperty<String>`

Default value
: [verifyPluginProjectConfigurationMutedMessages](tools-intellij-platform-gradle-plugin-gradle-properties.html#verifyPluginProjectConfigurationMutedMessages)

### 

`kotlinPluginAvailable`

Indicates that the Kotlin Gradle Plugin is loaded and available.

Type
: `Property<Boolean>`

Default value
: Kotlin Gradle Plugin presence

### 

`kotlinApiVersion`

Specifies the `apiVersion` property value of `compileKotlin.kotlinOptions` defined in the build script.

Type
: `Property<String?>`

Default value
: `compileKotlin.kotlinOptions.apiVersion`

### 

`kotlinLanguageVersion`

Specifies the `languageVersion` property value of `compileKotlin.kotlinOptions` defined in the build script.

Type
: `Property<String?>`

Default value
: `compileKotlin.kotlinOptions.languageVersion`

### 

`kotlinVersion`

Specifies the version of Kotlin used in the project.

Type
: `Property<String?>`

Default value
: `kotlin.coreLibrariesVersion`

### 

`kotlinJvmTarget`

Specifies the `jvmTarget` property value of `compileKotlin.kotlinOptions` defined in the build script.

Type
: `Property<String?>`

Default value
: `compileKotlin.kotlinOptions.jvmTarget`

### 

`kotlinStdlibDefaultDependency`

Specifies the value of the `kotlin.stdlib.default.dependency` property as defined in the `gradle.properties` file.

Type
: `Property<Boolean>`

Default value
: `kotlin.stdlib.default.dependency` Gradle property

### 

`kotlinxCoroutinesLibraryPresent`

Indicates whether the Kotlin Coroutines library is explicitly added to the project dependencies.

Type
: `Property<Boolean>`

Default value
: The `org.jetbrains.kotlinx:kotlinx-coroutines` dependency presence

## 

`verifyPluginSignature`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Extends: [JavaExec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html), [SigningAware](tools-intellij-platform-gradle-plugin-task-awares.html#SigningAware)

Sources: [VerifyPluginSignatureTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/VerifyPluginSignatureTask.kt)
</tldr>

Validates the signature of the plugin archive file using the [Marketplace ZIP Signer](https://github.com/JetBrains/marketplace-zip-signer) library.

See also:

* [Plugin Signing](plugin-signing.html)

* [Marketplace ZIP Signer](https://github.com/JetBrains/marketplace-zip-signer)

### 

`inputArchiveFile`

Specifies the input, unsigned ZIP archive file.
This parameter corresponds to the `in` CLI option.

Type
: `RegularFileProperty`

Default value
: [signPlugin.signedArchiveFile](#signPlugin-signedArchiveFile)

### 

`certificateChain`

Specifies a string containing X509 certificates.
The first certificate in the chain will be used as a certificate authority (CA).
This parameter corresponds to the `cert` CLI option.

Takes precedence over the [certificateChainFile](#verifyPluginSignature-certificateChainFile) property.

Type
: `Property<String>`

### 

`certificateChainFile`

Specifies the path to the file containing X509 certificates.
The first certificate in the chain will be used as a certificate authority (CA).
This parameter corresponds to the `cert-file` CLI option.

Type
: `RegularFileProperty`

Default value
: [signPlugin.certificateChainFile](#signPlugin-certificateChainFile) or [signPlugin.certificateChain](#signPlugin-certificateChain) written to a temporary file

## 

`verifyPluginStructure`

<tldr>
Available in: [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform)

Depends on: [prepareSandbox](#prepareSandbox)

Extends: [DefaultTask](https://docs.gradle.org/current/dsl/org.gradle.api.DefaultTask.html), [SandboxAware](tools-intellij-platform-gradle-plugin-task-awares.html#SandboxAware)

Sources: [VerifyPluginStructureTask](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.20.0/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/VerifyPluginStructureTask.kt)
</tldr>

Validates completeness and contents of `plugin.xml` descriptors as well as plugin archive structure.

See also:

* [Plugin Configuration File](plugin-configuration-file.html)

### 

`ignoreFailures`

Specifies whether the build should fail when the verifications performed by this task fail.

Type
: `Property<Boolean>`

Default value
: `false`

### 

`ignoreUnacceptableWarnings`

Specifies whether the build should fail when the verifications performed by this task emit unacceptable warnings.

Type
: `Property<Boolean>`

Default value
: `false`

### 

`ignoreWarnings`

Specifies whether the build should fail when the verifications performed by this task emit warnings.

Type
: `Property<Boolean>`

Default value
: `true`

### 

`pluginDirectory`

Specifies the location of the built plugin file used for verification.

Type
: `DirectoryProperty`

Default value
: `[prepareSandbox.defaultDestinationDirectory](#prepareSandbox-defaultDestinationDirectory)/[intellijPlatform.pluginConfiguration.name](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-name)`

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

