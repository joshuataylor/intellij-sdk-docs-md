# Types

Tip: FAQ

See [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html) and [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html).

This page lists various types used to configure [Tasks](tools-intellij-platform-gradle-plugin-tasks.html).

## 

`FailureLevel`

[VerifyPluginTask.FailureLevel](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/VerifyPluginTask.kt)

Enum class describing the failure level of the IntelliJ Plugin Verifier CLI tool run with the [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin) task.

| Name |Description |
---------------------
| `COMPATIBILITY_WARNINGS` |Compatibility warnings detected against the specified IDE version. |
| `COMPATIBILITY_PROBLEMS` |Compatibility problems detected against the specified IDE version. |
| `DEPRECATED_API_USAGES` |Plugin uses API marked as deprecated (`@Deprecated`). |
| `SCHEDULED_FOR_REMOVAL_API_USAGES` |Plugin uses API marked as scheduled for removal (`@ApiStatus.ScheduledForRemoval`). |
| `EXPERIMENTAL_API_USAGES` |Plugin uses API marked as experimental (`@ApiStatus.Experimental`). |
| `INTERNAL_API_USAGES` |Plugin uses API marked as internal (`@ApiStatus.Internal`). |
| `OVERRIDE_ONLY_API_USAGES` |Override-only API is used incorrectly (`@ApiStatus.OverrideOnly`). |
| `NON_EXTENDABLE_API_USAGES` |Non-extendable API is used incorrectly (`@ApiStatus.NonExtendable`). |
| `PLUGIN_STRUCTURE_WARNINGS` |The structure of the plugin is not valid. |
| `MISSING_DEPENDENCIES` |Plugin has some dependencies missing. |
| `INVALID_PLUGIN` |Provided plugin artifact is not valid. |
| `NOT_DYNAMIC` |Plugin probably cannot be enabled or disabled without IDE restart. |
| `ALL` |EnumSet constant containing all possible options. |
| `NONE` |EnumSet constant containing no options. |

See also:

* [Extension: intellijPlatform.pluginVerification.failureLevel](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-failureLevel)

* [Tasks: verifyPlugin.failureLevel](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-failureLevel)

* [Overview of API Status](verifying-plugin-compatibility.html#ide-support)

## 

`IntelliJPlatformType`

[IntelliJPlatformType](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/IntelliJPlatformType.kt)

Describes all IntelliJ Platform types available to be used for plugin development, dependency resolution, and plugin verification.

Each entry is composed of a product code and coordinates used for dependency and binary release resolution.

| Name |Code |Artifact Coordinates |Binary release |
----------------------------------------------------
| `AndroidStudio` |`AI` |- |✓ |
| `Aqua` |`QA` |- |  |
| `CLion` |`CL` |`com.jetbrains.intellij.clion:clion` |✓ |
| `DataGrip` |`DB` |- |✓ |
| `DataSpell` |`DS` |- |✓ |
| `FleetBackend` |`FLIJ` |`com.jetbrains.intellij.fleetBackend:fleetBackend` |  |
| `Gateway` |`GW` |`com.jetbrains.intellij.gateway:gateway` |✓ |
| `GoLand` |`GO` |`com.jetbrains.intellij.goland:goland` |✓ |
| `IntellijIdeaCommunity` |`IC` |`com.jetbrains.intellij.idea:ideaIC` |✓ |
| `IntellijIdeaUltimate` |`IU` |`com.jetbrains.intellij.idea:ideaIU` |✓ |
| `IntellijIdea` |`IU` |`com.jetbrains.intellij.idea:idea` |✓ |
| `JetBrainsClient` |`JBC` |- |✓ |
| `MPS` |`MPS` |- |✓ |
| `PhpStorm` |`PS` |`com.jetbrains.intellij.phpstorm:phpstorm` |✓ |
| `PyCharm` |`PY` |`com.jetbrains.intellij.pycharm:pycharm` |✓ |
| `PyCharmProfessional` |`PY` |`com.jetbrains.intellij.pycharm:pycharmPY` |✓ |
| `PyCharmCommunity` |`PC` |`com.jetbrains.intellij.pycharm:pycharmPC` |✓ |
| `Rider` |`RD` |`com.jetbrains.intellij.rider:riderRD` |✓ |
| `RubyMine` |`RM` |`com.jetbrains.intellij.rubymine:rubymine` |✓ |
| `RustRover` |`RR` |`com.jetbrains.intellij.rustrover:RustRover` |✓ |
| `WebStorm` |`WS` |`com.jetbrains.intellij.webstorm:webstorm` |✓ |
| `Writerside` |`WRS` |`com.jetbrains.intellij.idea:writerside` |  |

Notes:

* `Aqua` (`QA`) and `Writerside` (`WRS`) are deprecated and no longer available as target IntelliJ Platform products.

* `IntellijIdeaCommunity` (`IC`) and `PyCharmCommunity` (`PC`) are available only for versions earlier than 2025.3 (build 253). For 2025.3+ use `IntellijIdea` (`IU`) and `PyCharm` (`PY`).

* `IntellijIdeaUltimate` (`IU`) and `PyCharmProfessional` (`PY`) are legacy types for versions earlier than 2025.3 (build 253). For 2025.3+ use `IntellijIdea` (`IU`) and `PyCharm` (`PY`).

## 

`ProductMode`

[ProductMode](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/ProductMode.kt)

Describes a mode in which a product may be started. This can be configured on the target platform dependency to influence how the IDE is started for development and testing.

| Name |Description |
---------------------
| `MONOLITH` |Indicates that this process performs all necessary tasks to provide smart features itself. This is the default mode for all IDEs. |
| `FRONTEND` |Indicates that this process doesn't perform heavy tasks like code analysis, and takes necessary information from another process. Currently used by JetBrains Client connected to a remote development host or Code With Me session. |
| `BACKEND` |Indicates that this process doesn't perform heavy tasks like code analysis and takes necessary information from another process. Currently used by an IDE running as a remote development host. |

See also:

* [Dependencies Extension: Dependency Configuration Parameters](tools-intellij-platform-gradle-plugin-dependencies-extension.html#dependency-configuration-parameters)

* [Types: SplitModeAware.PluginInstallationTarget](#SplitModeAware-PluginInstallationTarget)

## 

`PluginBean`

[PluginBean](https://github.com/JetBrains/intellij-plugin-verifier/tree/1.409/intellij-plugin-structure/structure-intellij/src/main/java/com/jetbrains/plugin/structure/intellij/beans/PluginBean.java)

Describes the content of the `plugin.xml` file.

See also:

* [Plugin Configuration File](plugin-configuration-file.html)

## 

`ProductInfo`

[ProductInfo](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/models/ProductInfo.kt)

Represents information about the IntelliJ Platform product.

The information is retrieved from the `product-info.json` file in the IntelliJ Platform directory.
See also the corresponding [product-info.schema.json](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/buildData/resources/product-info.schema.json).

| Name |Description |
---------------------
| `name` |The product's name, like "IntelliJ IDEA". |
| `version` |The marketing version of the product, like "2023.2". |
| `versionSuffix` |The suffix of the version, like "EAP". |
| `buildNumber` |The build number of the product, like "232.8660.185". |
| `productCode` |The product code, like "IU". |
| `envVarBaseName` |Base name used for product-specific environment variables. |
| `dataDirectoryName` |The directory name of the product data. |
| `svgIconPath` |The path to the SVG icon of the product. |
| `productVendor` |The vendor of the product. |
| `launch` |The list of OS- and arch-specific launch configurations for the product. |
| `customProperties` |The list of custom properties of the product. |
| `bundledPlugins` |The list of bundled plugins provided with the current release. |
| `fileExtensions` |The list of file extensions associated with the product. |
| `modules` |The list of modules of the product. |
| `layout` |The modules and plugins dependencies mapping. |

### 

`validateSupportedVersion()`

Validates that the resolved IntelliJ Platform is supported by checking against the minimal supported IntelliJ Platform version.

If the provided version is lower, an `IllegalArgumentException` is thrown with an appropriate message.

Throws
: `IllegalArgumentException`

## 

`ProductRelease.Channel`

[ProductRelease.Channel](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/models/ProductRelease.kt)

List of available channels used by [JetBrains IDEs](intellij-platform.html#ides-based-on-the-intellij-platform)
and [Android Studio](android-studio.html) for describing binary releases.

| Name |JetBrains IDEs |Android Studio |
----------------------------------------
| `RELEASE` |✓ |✓ |
| `EAP` |✓ |  |
| `MILESTONE` |  |✓ |
| `BETA` |  |✓ |
| `CANARY` |  |✓ |
| `PATCH` |  |✓ |
| `RC` |  |✓ |
| `PREVIEW` |  |✓ |

See also:

* [Extension: intellijPlatform.pluginVerification.ides](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-ides)

* [Tasks: printProductsReleases](tools-intellij-platform-gradle-plugin-tasks.html#printProductsReleases)

## 

`ProductReleasesFilterParameters`

[ProductReleasesValueSource](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/providers/ProductReleasesFilterParameters.kt)

Interface that provides a clear way to filter binary product releases for IntelliJ Plugin Verifier.

| Name |Description |
---------------------
| `sinceBuild` |Build number from which the binary IDE releases will be matched. |
| `untilBuild` |Build number until which the binary IDE releases will be matched. |
| `types` |A list of [IntelliJPlatformType](#IntelliJPlatformType) types to match. |
| `channels` |A list of [ProductRelease.Channel](#ProductRelease-Channel) types of binary releases to search in. |

See also:

* [Extension: intellijPlatform.pluginVerification.ides](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-ides)

* [Tasks: printProductsReleases](tools-intellij-platform-gradle-plugin-tasks.html#printProductsReleases)

* [Gradle Properties: productsReleasesAndroidStudioUrl](tools-intellij-platform-gradle-plugin-gradle-properties.html#productsReleasesAndroidStudioUrl)

* [Gradle Properties: productsReleasesJetBrainsIdesUrl](tools-intellij-platform-gradle-plugin-gradle-properties.html#productsReleasesJetBrainsIdesUrl)

## 

`RequestedIntelliJPlatform`

[RequestedIntelliJPlatform](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/services/RequestedIntelliJPlatformsService.kt)

Represents a requested IntelliJ Platform build with its type, version, and installation/cache preferences.
Used internally by the Gradle plugin to propagate platform settings across configurations for development, dependency resolution, and plugin verification.

| Name |Description |
---------------------
| `type` |IntelliJ Platform type. See [IntelliJPlatformType](#IntelliJPlatformType). |
| `version` |Version of the IntelliJ Platform to use (for example, "2024.2", "241.15989.150"). |
| `useInstaller` |Whether the installer distribution of the platform should be used. |
| `useCache` |Whether a custom cache directory should be used when resolving the platform. |
| `productMode` |Desired product mode. See [ProductMode](#ProductMode). |

## 

`SplitModeAware.PluginInstallationTarget` (formerly `SplitModeTarget`)

[SplitModeAware.PluginInstallationTarget](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/aware/SplitModeAware.kt)

Describes a part of the product where the developed plugin can be installed when running in splitMode handled by [SplitModeAware](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware).

| Name |Description |
---------------------
| `BACKEND` |Install plugin in the backend IDE. |
| `FRONTEND` |Install plugin in the frontend IDE. |
| `BOTH` |Install plugin in both backend and frontend IDEs. |

## 

`Subsystems`

[VerifyPluginTask.Subsystems](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/VerifyPluginTask.kt)

Specify which subsystems of the IDE should be checked by the IntelliJ Plugin Verifier CLI tool run with the [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin) task.

| Name |Description |
---------------------
| `ALL` |Verify all code. |
| `ANDROID_ONLY` |Verify only code related to Android support. |
| `WITHOUT_ANDROID` |Exclude problems related to Android support. |

See also:

* [Extension: intellijPlatform.pluginVerification.subsystemsToCheck](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-subsystemsToCheck)

* [Tasks: verifyPlugin.subsystemsToCheck](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-subsystemsToCheck)

## 

`TestFrameworkType`

[TestFrameworkType](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/TestFrameworkType.kt)

Allows for adding `test-framework` testing library variants.
See [Dependencies Extension: Testing](tools-intellij-platform-gradle-plugin-dependencies-extension.html#testing).

### Platform Test Frameworks

Generic test frameworks for the IntelliJ Platform.

| Name |Coordinates |
---------------------
| `Platform` |`com.jetbrains.intellij.platform:test-framework`  See "Known Issues" below   |
| `JUnit5` |`com.jetbrains.intellij.platform:test-framework-junit5`  See "Known Issues" below   |
| `Bundled` |Adds `[platformPath]/lib/testFramework.jar` file  See "Using Bundled" below   |
| `Metrics` |`com.jetbrains.intellij.tools:ide-metrics-benchmark`  `com.jetbrains.intellij.tools:ide-metrics-collector`   `com.jetbrains.intellij.tools:ide-util-common` |
| `Starter` |`com.jetbrains.intellij.tools:ide-starter-squashed`   `com.jetbrains.intellij.tools:ide-starter-junit5`   `com.jetbrains.intellij.tools:ide-starter-driver`   `com.jetbrains.intellij.driver:driver-client`   `com.jetbrains.intellij.driver:driver-sdk`   `com.jetbrains.intellij.driver:driver-model` |

Tip: Known Issues

Known issues related to `Platform` and `JUnit5` Test Frameworks:

* [Missing opentest4j dependency in Test Framework](tools-intellij-platform-gradle-plugin-faq.html#missing-opentest4j-dependency-in-test-framework)

* [JUnit5 Test Framework refers to JUnit4](tools-intellij-platform-gradle-plugin-faq.html#junit5-test-framework-refers-to-junit4)

Warning: Using Bundled

The `Bundled` type should not be used unless it is necessary, like in the case of [Rider](rider.html), as its `test-framework` is not published as an artifact.

### Plugin Test Frameworks

Some plugins offer dedicated test frameworks, for example, `Plugin.Java` when using Java/JVM-related functionality.

| Name |Coordinates |Reference |
--------------------------------
| `Plugin.CLion` |`com.jetbrains.intellij.clion:clion-merged-test-framework` |[CLion Plugin Development](clion.html) |
| `Plugin.CSS` |`com.jetbrains.intellij.css:css-test-framework` |[WebStorm Plugin Development](webstorm.html) |
| `Plugin.Debugger` |`com.jetbrains.intellij.platform:debugger-test-framework` |  |
| `Plugin.ExternalSystem` |`com.jetbrains.intellij.platform:external-system-test-framework` |  |
| `Plugin.Go` |`com.jetbrains.intellij.go:go-test-framework` |[GoLand Plugin Development](goland.html) |
| `Plugin.Ruby` |`com.jetbrains.intellij.idea:ruby-test-framework` |[RubyMine Plugin Development](rubymine.html) |
| `Plugin.Java` |`com.jetbrains.intellij.java:java-test-framework` |[IntelliJ IDEA Plugin Development](idea.html) |
| `Plugin.JavaScript` |`com.jetbrains.intellij.javascript:javascript-test-framework` |[WebStorm Plugin Development](webstorm.html) |
| `Plugin.Jupyter` |`com.jetbrains.intellij.jupyter:jupyter-test-framework` |  |
| `Plugin.LSP` |`com.jetbrains.intellij.platform:lsp-test-framework` |  |
| `Plugin.Maven` |`com.jetbrains.intellij.maven:maven-test-framework` |  |
| `Plugin.Notebooks` |`com.jetbrains.intellij.notebooks:notebooks-visualization-test-framework` |  |
| `Plugin.PolySymbols` |`com.jetbrains.intellij.platform:poly-symbols-test-framework` |  |
| `Plugin.Qodana` |`com.jetbrains.intellij.qodana:qodana-test-framework` |  |
| `Plugin.ReSharper` |`com.jetbrains.intellij.resharper:resharper-test-framework` |[Rider Plugin Development](rider.html) |
| `Plugin.UAST` |`com.jetbrains.intellij.platform:uast-test-framework` |  |
| `Plugin.VCS` |`com.jetbrains.intellij.platform:vcs-test-framework` |  |
| `Plugin.XML` |`com.jetbrains.intellij.xml:xml-test-framework` |  |
| `Plugin.WebSymbols` |`com.jetbrains.intellij.platform:web-symbols-test-framework` |  |

## 

`VerificationReportsFormats`

[VerifyPluginTask.VerificationReportsFormats](https://github.com/JetBrains/intellij-platform-gradle-plugin/tree/2.18.1/src/main/kotlin/org/jetbrains/intellij/platform/gradle/tasks/VerifyPluginTask.kt)

Enum class describing the type of the results produced by the IntelliJ Plugin Verifier CLI tool run with the [verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin) task.

| Name |Description |
---------------------
| `PLAIN` |Plain text file. |
| `HTML` |HTML formatted output file. |
| `MARKDOWN` |Markdown file. |
| `ALL` |EnumSet constant containing all possible options. |
| `NONE` |EnumSet constant containing no options. |

See also:

* [Extension: intellijPlatform.pluginVerification.verificationReportsFormats](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginVerification-verificationReportsFormats)

* [Tasks: verifyPlugin.verificationReportsFormats](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-verificationReportsFormats)

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

