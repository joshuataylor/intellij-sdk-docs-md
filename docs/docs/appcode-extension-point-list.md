# AppCode Extension Point and Listener List

<tldr>
Product-Specific Plugin Development: [AppCode](app-code.html)

See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

Warning:

With the release of AppCode 2022.3, we're sunsetting the product.
Please see this [blog post](https://blog.jetbrains.com/appcode/2022/12/appcode-2022-3-release-and-end-of-sales-and-support/) for details.

## AppCode Extension Point and Listener List

<tldr>
Product-Specific Plugin Development: [AppCode](app-code.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

Warning:

With the release of AppCode 2022.3, we're sunsetting the product.
Please see this [blog post](https://blog.jetbrains.com/appcode/2022/12/appcode-2022-3-release-and-end-of-sales-and-support/) for details.

34 Extension Points and 6 Listeners for AppCode 2022.3

### Legend

Tip:

See also [Explore the IntelliJ Platform API](explore-api.html) for more information and strategies.

#### Listeners

Topic
searches for usages inside existing implementations of open-source IntelliJ Platform plugins via [IntelliJ Platform Explorer](https://jb.gg/ipe).

Listener
links corresponding listener to implement.

See [Listeners](plugin-listeners.html) on how to register listeners.

#### Extension Points

Extension Point
searches for usages inside existing implementations of open-source IntelliJ Platform plugins via [IntelliJ Platform Explorer](https://jb.gg/ipe).

Implementation
is the related Extension Point class.

See [Extensions](plugin-extensions.html) on how to declare extensions in your plugin.

#### Tags

See [Verifying Plugin Compatibility](verifying-plugin-compatibility.html) for overview of API status.

| Tag |Description |Details |
-----------------------------
| ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |Deprecated API |See code documentation for replacement. |
| ![Removal](https://img.shields.io/badge/-Removal-red?style=flat-square) |Scheduled for Removal API |Annotated with [@ApiStatus.ScheduledForRemoval](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             See code documentation for replacement.   |
| ![Obsolete](https://img.shields.io/badge/-Obsolete-grey?style=flat-square)                          |Obsolete API |Annotated with [@ApiStatus.Obsolete](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             Do not use in new code, see code documentation for replacement.   |
| ![Experimental API](https://img.shields.io/badge/-Experimental-violet?style=flat-square)                               |Experimental API |Annotated with [@ApiStatus.Experimental](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             API might be altered or removed without prior notice.   |
| ![Internal API](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |Internal API |Annotated with [@ApiStatus.Internal](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             Must not be used by third party plugins, see [Internal API Migration](api-internal.html).   |
| ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |Project-LevelExtension Point/Topic   |Can have [Project](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/project/Project.java)                             as constructor parameter.                               - Extension Point: declared with `area="IDEA_PROJECT"`                               - Listener: registered in [&lt;projectListeners&gt;](plugin-configuration-file.html#idea-plugin__projectListeners)                                |
| ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |`DumbAware`                             Extension Point   |Implementations marked with [DumbAware](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/project/DumbAware.java)                             will be processed during [dumb                                 mode](indexing-and-psi-stubs.html#dumb-mode).                          |
| ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |Non-DynamicExtension Point   |Installation/update of plugin requires restarting the IDE, see [Dynamic Plugins](dynamic-plugins.html).                          |

## AppCode

### AppCode – Listeners

| Topic |Listener |
-------------------
| [CocoaPodsUtils#GEM_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.cidr.cocoapods.CocoaPodsUtils.GemListener) |`GemListener` |
| [CocoaPodsUtils#PODS_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.cidr.cocoapods.CocoaPodsUtils.PodsListener) |`PodsListener` |
| [AMDeviceManager#DEVICE_LISTENER_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.cidr.execution.deviceSupport.AMDeviceListener) |`AMDeviceListener` |
| [XcodeProjectTestListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.cidr.xcode.model.XcodeProjectTestListener) |`XcodeProjectTestListener` |
| [XcodeIsBrokenListener.Companion#XCODE_IS_BROKEN_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.cidr.xcode.refresh.XcodeIsBrokenListener) |`XcodeIsBrokenListener` |
| [SwiftPackageManagerSettingsListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.swift.swiftpm.SwiftPackageManagerSettingsListener) |`SwiftPackageManagerSettingsListener` |

### AppCodeCorePlugin.xml

| Extension Point |Implementation |
-----------------------------------
| [appcode.additionalRootsProvider](https://jb.gg/ipe?extensions=appcode.additionalRootsProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`XcodeMetaDataAdditionalRootsProvider` |
| [appcode.attachDebuggerProvider](https://jb.gg/ipe?extensions=appcode.attachDebuggerProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`AppCodeAttachDebuggerExtension` |
| [appcode.projectNameUpdateVeto](https://jb.gg/ipe?extensions=appcode.projectNameUpdateVeto) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`XcodeProjectNameUpdateVeto` |
| [appcode.projectRootNodeDelegateProvider](https://jb.gg/ipe?extensions=appcode.projectRootNodeDelegateProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`AppCodeProjectRootNodeDelegateProvider` |
| [appcode.rootsInfoPostProcessor](https://jb.gg/ipe?extensions=appcode.rootsInfoPostProcessor) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`XcodeRootsInfoPostProcessor` |
| [appcode.runConfigurationExtension](https://jb.gg/ipe?extensions=appcode.runConfigurationExtension) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`AppCodeRunConfigurationExtension` |
| [appcode.xcodeExternalBuildProvider](https://jb.gg/ipe?extensions=appcode.xcodeExternalBuildProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`XcodeExternalBuildProvider` |
| [appcode.xcodeTemplatePathsProvider](https://jb.gg/ipe?extensions=appcode.xcodeTemplatePathsProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`XcodeTemplatePathsProvider` |
| [appcode.xcodeTemplatesProvider](https://jb.gg/ipe?extensions=appcode.xcodeTemplatesProvider) |`XcodeTemplatesProvider` |

### CocoaCommonPlugin.xml

| Extension Point |Implementation |
-----------------------------------
| [appcode.breakpointHandlersProvider](https://jb.gg/ipe?extensions=appcode.breakpointHandlersProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`IPhoneBreakpointHandlersProvider` |
| [appcode.lldbInitializerProvider](https://jb.gg/ipe?extensions=appcode.lldbInitializerProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`LLDBInitializerProvider` |
| [cidr.cocoa.xcodeProjectFileProvider](https://jb.gg/ipe?extensions=cidr.cocoa.xcodeProjectFileProvider) |`XcodeProjectFileProvider` |

### CocoaPlugin.xml

| Extension Point |Implementation |
-----------------------------------
| [cidr.cocoa.documentation.search.candidates.helper](https://jb.gg/ipe?extensions=cidr.cocoa.documentation.search.candidates.helper) |`XcodeDocumentationCandidateBasedSearchHelper` |
| [cidr.cocoa.documentation.search.usr.provider](https://jb.gg/ipe?extensions=cidr.cocoa.documentation.search.usr.provider) |`XcodeDocumentationUsrProvider` |

### SwiftLanguageInternalPlugin.xml

| Extension Point |Implementation |
-----------------------------------
| [cidr.lang.swiftTypeInheritorsSearch](https://jb.gg/ipe?extensions=cidr.lang.swiftTypeInheritorsSearch) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [swift.lang.libraryModuleImportRestriction](https://jb.gg/ipe?extensions=swift.lang.libraryModuleImportRestriction) |`SwiftLibraryModuleImportRestriction` |
| [swift.sdkInfo.extractor](https://jb.gg/ipe?extensions=swift.sdkInfo.extractor) |`OCResolveConfigurationSdkInfoExtractor` |
| [swift.sourcekit.blacklistedModulesProvider](https://jb.gg/ipe?extensions=swift.sourcekit.blacklistedModulesProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`SourceKitBlacklistedModulesProvider` |
| [swift.sourcekit.dependenciesLoader](https://jb.gg/ipe?extensions=swift.sourcekit.dependenciesLoader) |`SourceKitPlatformBinaryDependenciesLoader` |

### SwiftPlugin.xml

| Extension Point |Implementation |
-----------------------------------
| [cidr.lang.swiftCustomIncludePathProvider](https://jb.gg/ipe?extensions=cidr.lang.swiftCustomIncludePathProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`SwiftCustomIncludePathProvider` |
| [cidr.lang.swiftSourceModuleProvider](https://jb.gg/ipe?extensions=cidr.lang.swiftSourceModuleProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`SwiftSourceModuleProvider` |
| [swift.kotlinNative](https://jb.gg/ipe?extensions=swift.kotlinNative) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`KotlinNativeExtensionPoint` |
| [swift.lang.sourceKit.compileArgumentsCollector](https://jb.gg/ipe?extensions=swift.lang.sourceKit.compileArgumentsCollector) |`SwiftSourceKitCompileArgumentsCollector` |
| [swift.lang.sourceKit.dataGenerator](https://jb.gg/ipe?extensions=swift.lang.sourceKit.dataGenerator) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`SourceKitDataGenerator` |
| [swift.lang.sourceKit.declarationLocationValidator](https://jb.gg/ipe?extensions=swift.lang.sourceKit.declarationLocationValidator) |`SourceKitDeclarationLocationValidator` |
| [swift.lang.sourceKitFixExtension](https://jb.gg/ipe?extensions=swift.lang.sourceKitFixExtension) |`SwiftSourceKitFixExtension` |
| [swift.lang.swiftSupportProvider](https://jb.gg/ipe?extensions=swift.lang.swiftSupportProvider) |`SwiftSupportProvider` |

### SwiftPMCommon.xml

| Extension Point |Implementation |
-----------------------------------
| [swift.packageManager.appleSdk.filter](https://jb.gg/ipe?extensions=swift.packageManager.appleSdk.filter) |`SwiftPackageLoadedAppleSdkFilter` |
| [swift.packageManager.environmentConfigurator](https://jb.gg/ipe?extensions=swift.packageManager.environmentConfigurator) |`SwiftPackageManagerEnvironmentConfigurator` |
| [swift.packageManager.launcher](https://jb.gg/ipe?extensions=swift.packageManager.launcher) |`SwiftPackageManagerConfigurationLauncher` |
| [swift.packageManager.modulemapsCollector](https://jb.gg/ipe?extensions=swift.packageManager.modulemapsCollector) |`SwiftPackageModuleMapsCollector` |
| [swift.packageManager.systemModuleResolver](https://jb.gg/ipe?extensions=swift.packageManager.systemModuleResolver) |`SwiftPackageManagerSystemModuleResolver` |

### SwiftTestsExtension.xml

| Extension Point |Implementation |
-----------------------------------
| [test.cidr.OCCodeInsightDelegate](https://jb.gg/ipe?extensions=test.cidr.OCCodeInsightDelegate) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`OCCodeInsightDelegate` |

### XcodeModelCorePlugin.xml

| Extension Point |Implementation |
-----------------------------------
| [xcode.pbxReferenceBuildSettingsProvider](https://jb.gg/ipe?extensions=xcode.pbxReferenceBuildSettingsProvider) ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`PBXReferenceBuildSettingProvider` |

