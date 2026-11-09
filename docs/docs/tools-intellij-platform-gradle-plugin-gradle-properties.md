# Gradle Properties

Tip: FAQ

See [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html) and [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html).

The IntelliJ Platform Gradle Plugin exposes a number of Gradle properties to control some of the low-level Gradle plugin behaviors.
To enable or disable a particular feature, add a Project property to the `gradle.properties` file with the following pattern:

```PROPERTIES
org.jetbrains.intellij.platform.<name>=<value>
```

## 

`downloadSources`

Instruct the IDE that sources are needed to be downloaded when working with IntelliJ Platform Gradle Plugin.

Value is passed directly to the [IDEA Gradle Plugin](https://docs.gradle.org/current/userguide/idea_plugin.html) to the `idea.module.downloadSources` property.

See also:

* [IdeaModule.downloadSources](https://docs.gradle.org/current/dsl/org.gradle.plugins.ide.idea.model.IdeaModule.html#org.gradle.plugins.ide.idea.model.IdeaModule:downloadSources)

Default value
: `true`

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.downloadSources=true
```







## 
`intellijPlatformCache`







Specifies the location of the local IntelliJ Platform cache directory for storing files related to the current project, like:


  * XML files generated for the [localPlatformArtifacts](tools-intellij-platform-gradle-plugin-repositories-extension.html#additional-repositories) local Ivy repository

  * self-update lock file used by the [initializeIntelliJPlatformPlugin](tools-intellij-platform-gradle-plugin-tasks.html#initializeIntelliJPlatformPlugin) task


Warning: 

This directory should be excluded from versioning.






Default value
: `[rootProject]/.intellijPlatform/`


Example
: ```PROPERTIES
org.jetbrains.intellij.platform.intellijPlatformCache=/path/to/intellijPlatformCache/
```

## 

`intellijPlatformIdesCache`

Specifies the location of the IntelliJ Platform IDEs cache directory for storing downloaded IDE distributions
and related artifacts.
This cache is used to avoid re-downloading the same IDE versions across different project builds and can be shared between multiple projects.

Note: this directory can be shared across projects and should be excluded from versioning.

See also:

* [Extension: intellijPlatform.caching.ides](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-caching-ides)

Default value
: `[intellijPlatformCache](#intellijPlatformCache)/ides/`

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.intellijPlatformIdesCache=/path/to/ides-cache/
```







## 
`intellijPlatformIdesCacheEnabled`







Indicates whether caching for IntelliJ Platform IDEs is enabled globally.


This property can still be overridden locally with `useCache` in an IntelliJ Platform dependency configuration.


See also:


  * [Extension: intellijPlatform.caching.ides.enabled](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-caching-ides-enabled)



Default value
: `false`


Example
: ```PROPERTIES
org.jetbrains.intellij.platform.intellijPlatformIdesCacheEnabled=true
```

## 

`localPlatformArtifacts`

The [localPlatformArtifacts()](tools-intellij-platform-gradle-plugin-repositories-extension.html#additional-repositories) entry applied to the `repositories {}` block is required to apply to the project dependencies that need extra pre-processing before they can be correctly used by the IntelliJ Platform Gradle Plugin and loaded by Gradle.

Default value
: `[intellijPlatformCache](#intellijPlatformCache)/localPlatformArtifacts/`

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.localPlatformArtifacts=/path/to/localPlatformArtifacts/
```







## 
`noSearchableOptionsWarning`







When the [buildSearchableOptions](tools-intellij-platform-gradle-plugin-tasks.html#buildSearchableOptions) doesn't produce any results, for example, when the plugin doesn't implement any [Settings](settings.html), a warning is shown to suggest disabling it for better performance with [buildSearchableOptions](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-buildSearchableOptions).



Default value
: `true`


Example
: ```PROPERTIES
org.jetbrains.intellij.platform.noSearchableOptionsWarning=false
```

## 

`forceBuildSearchableOptions`

Forces the [buildSearchableOptions](tools-intellij-platform-gradle-plugin-tasks.html#buildSearchableOptions) task to run even when descriptor analysis doesn't find any `Configurable` extension points.
This property overrides both the automatic skip optimization and the [intellijPlatform.buildSearchableOptions](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-buildSearchableOptions) extension property.

Default value
: `false`

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.forceBuildSearchableOptions=true
```







## 
`paidPluginSearchableOptionsWarning`







Due to IDE limitations, it is impossible to run the IDE in headless mode to collect searchable options for a paid plugin.
As paid plugins require providing a valid license and presenting a UI dialog, it is impossible to handle such a case, and the task will fail.
This feature flag displays the given warning when the task is run by a paid plugin.



Default value
: `true`


Example
: ```PROPERTIES
org.jetbrains.intellij.platform.paidPluginSearchableOptionsWarning=false
```

## 

`productsReleasesAndroidStudioUrl`

Specifies the URL from which the list of all Android Studio releases is fetched.
This listing is later parsed by `ProductReleasesValueSource` to provide a list of IDEs matching the filtering criteria for running the IntelliJ Plugin Verifier tool with the [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin) task.

Default value
: `https://jb.gg/android-studio-releases-list.xml`

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.productsReleasesAndroidStudioUrl=https://...
```







## 
`productsReleasesJetBrainsIdesUrl`







Specifies the URL from which the list of all JetBrains IDE releases is fetched.
This listing is later parsed by `ProductReleasesValueSource` to provide a list of IDEs matching the filtering criteria for running the IntelliJ Plugin Verifier tool with the [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin) task.



Default value
: `https://www.jetbrains.com/updates/updates.xml`


Example
: ```PROPERTIES
org.jetbrains.intellij.platform.productsReleasesJetBrainsIdesUrl=https://...
```

## 

`selfUpdateCheck`

Checks whether the currently used IntelliJ Platform Gradle Plugin is outdated and if a new release is available.
The plugin performs an update check on every run asking the GitHub Releases page for the redirection URL
to the latest version with `HEAD` HTTP request: [https://github.com/JetBrains/intellij-platform-gradle-plugin/releases/latest](https://github.com/JetBrains/intellij-platform-gradle-plugin/releases/latest).

If the current version is outdated, the plugin will emit a warning with its current and the latest version.

Feature respects the Gradle [--offline](https://docs.gradle.org/current/userguide/command_line_interface.html#sec:command_line_execution_options) mode.

Tip:

It is strongly suggested to always use the latest available version. Older plugin versions may also not fully support the latest IDE releases.

Default value
: `true`

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.selfUpdateCheck=false
```







## 
`subscriptionKey`







Specifies the path to an IntelliJ IDEA subscription key file used as the default for [intellijPlatform.subscriptionKey](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-subscriptionKey).
The key file is copied to `config/idea.key`, and `com.intellij.modules.ultimate` is removed from `config/disabled_plugins.txt` in each prepared sandbox.
Set [PrepareSandboxTask.subscriptionKey](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox-subscriptionKey) to override this value for a specific sandbox task.


Warning: 

Keep the key file outside version control. The property contains its path, not the subscription key itself.






Default value
: empty (subscription activation is disabled)


Example
: ```TEXT
org.jetbrains.intellij.platform.subscriptionKey=/path/to/idea.key
```

To configure the key-file path globally for all projects, set the corresponding Gradle project property through the `ORG_GRADLE_PROJECT_org.jetbrains.intellij.platform.subscriptionKey` environment variable.

## 

`testIdeBundledPluginsClasspathEnabled`

Controls whether bundled plugins declared in the IntelliJ Platform's `product-info.json` file are added to the classpaths used by the [testIde](tools-intellij-platform-gradle-plugin-tasks.html#testIde) and ordinary Gradle [test](tools-intellij-platform-gradle-plugin-tasks.html#test) tasks.
Set it to `false` to opt out.

Default value
: `true`

Example
: ```TEXT
org.jetbrains.intellij.platform.testIdeBundledPluginsClasspathEnabled=false
```







## 
`testIdeBundledPluginsClasspathExcludes`







Specifies a comma-separated list of bundled plugin IDs or module IDs excluded from the classpaths used by the [testIde](tools-intellij-platform-gradle-plugin-tasks.html#testIde) and ordinary Gradle [test](tools-intellij-platform-gradle-plugin-tasks.html#test) tasks.
This property applies only when [testIdeBundledPluginsClasspathEnabled](#testIdeBundledPluginsClasspathEnabled) is enabled.
Set it to an empty value to include all bundled plugins.



Default value
: `com.intellij.openRewrite,com.intellij.ja,com.intellij.ko,com.intellij.zh,org.jetbrains.plugins.vue`


Example
: ```TEXT
org.jetbrains.intellij.platform.testIdeBundledPluginsClasspathExcludes=
```

## 

`verifyPluginDefaultRecommendedIdes`

Controls whether [intellijPlatform.pluginVerification.ides.recommended()](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-ides) is used automatically when no IntelliJ Plugin Verifier IDEs were configured explicitly.

Default value
: `true`

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.verifyPluginDefaultRecommendedIdes=false
```







## 
`shimServerPort`







Specifies the default Shim server port at which the local webserver is run.
The Shim server is used to proxy requests to the authorized custom plugin repositories registered with [customPluginRepository()](tools-intellij-platform-gradle-plugin-repositories-extension.html#additional-repositories).



Default value
: `7348`


Example
: ```PROPERTIES
org.jetbrains.intellij.platform.shimServerPort=7348
```

## 

`useCacheRedirector`

By default, JetBrains Cache Redirector is used when resolving Maven repositories or any resources used by the IntelliJ Platform Gradle Plugin.
Due to limitations, sometimes it is desired to limit the list of remote endpoints accessed by Gradle.

It is possible to refer to the direct location (whenever it is possible) by switching off JetBrains Cache Redirector globally.

Default value
: `true`

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.useCacheRedirector=false
```







## 
`useDefaultSandboxExclusions`







Controls whether Kotlin standard library and Kotlin Coroutines dependencies provided by the IntelliJ Platform are excluded from sandbox runtime classpaths by default.
The exclusions apply to sandboxes prepared for running the IDE and tests, including the [prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox) and [prepareTestSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareTestSandbox) tasks.
Set this property to `false` to opt out of the default exclusions.



Default value
: `true`


Example
: ```TEXT
org.jetbrains.intellij.platform.useDefaultSandboxExclusions=false
```

## 

`addDefaultIntelliJPlatformDependencies`

Controls whether default IntelliJ Platform dependencies (like `com.intellij` and `intellij.rider`) should be added automatically when creating a dependency on the IntelliJ Platform.

Default value
: `true`

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.addDefaultIntelliJPlatformDependencies=false
```







## 
`productsReleasesCdnBuildsUrl`







Specifies the URL from which the list of JetBrains IDE CDN release builds is fetched. This listing is used for mapping IDE releases to build numbers (for example, to download the corresponding JetBrains Client archive).



Default value
: `https://data.services.jetbrains.com/products?code={type}&fields=code,releases.type,releases.version,releases.build`


Example
: ```PROPERTIES
org.jetbrains.intellij.platform.productsReleasesCdnBuildsUrl=https://...
```

## 

`verifyPluginProjectConfigurationMutedMessages`

Allows muting specific messages reported by the [verifyPluginProjectConfiguration](tools-intellij-platform-gradle-plugin-tasks.html#verifyPluginProjectConfiguration) task. The property accepts a comma-separated list of message patterns. Each pattern is matched against the message text using a case-sensitive substring search.

Default value
: empty (no messages are muted)

Example
: ```PROPERTIES
org.jetbrains.intellij.platform.verifyPluginProjectConfigurationMutedMessages=Kotlin Standard Library,Java Runtime is not JetBrains Runtime
```









