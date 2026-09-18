# WebStorm Extension Point and Listener List

<tldr>
Product-Specific Plugin Development: [WebStorm](webstorm.html)

See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform and [Open Source Plugins Extension Point and Listener List](oss-plugins-extension-point-list.html) for additional plugins.

99 Extension Points and 5 Listeners

## Legend

Tip:

See also [Explore the IntelliJ Platform API](explore-api.html) for more information and strategies.

### Listeners

Topic
searches for usages inside existing implementations of open-source IntelliJ Platform plugins via [IntelliJ Platform Explorer](https://jb.gg/ipe).

Listener
links corresponding listener to implement.

See [Listeners](plugin-listeners.html) on how to register listeners.

### Extension Points

Extension Point
searches for usages inside existing implementations of open-source IntelliJ Platform plugins via [IntelliJ Platform Explorer](https://jb.gg/ipe).

Implementation
is the related Extension Point class.

See [Extensions](plugin-extensions.html) on how to declare extensions in your plugin.

### Tags

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

## WebStorm

### WebStorm – Listeners

| Topic |Listener |
-------------------
| [JestConsoleProperties#COVERAGE_CONFIG_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.javascript.jest.JestCoverageConfigListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`JestCoverageConfigListener` |
| [PackageJsonFileManager#CHANGES_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.javascript.nodejs.packageJson.PackageJsonFileManager.PackageJsonChangesListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`PackageJsonChangesListener` |
| [VitestConsoleProperties#COVERAGE_CONFIG_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.javascript.testing.vitest.VitestCoverageConfigListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`VitestCoverageConfigListener` |
| [JSLibraryManager#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.lang.javascript.library.JSLibraryManager.JSLibraryManagerChangeListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`JSLibraryManagerChangeListener` |
| [JSRemoteModulesRegistry#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.lang.javascript.modules.remote.JSRemoteModulesChangeListener) |`JSRemoteModulesChangeListener` |

### intellij.css.analysis.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.css.cssInspectionFilter](https://jb.gg/ipe?extensions=com.intellij.css.cssInspectionFilter)      |`CssInspectionFilter` |
| [com.intellij.css.unknownHtmlTagQuickFixesProvider](https://jb.gg/ipe?extensions=com.intellij.css.unknownHtmlTagQuickFixesProvider)      |`UnknownHtmlTagQuickFixesProvider` |

### intellij.css.backend.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.css.cssIntentionFilter](https://jb.gg/ipe?extensions=com.intellij.css.cssIntentionFilter)      |`CssIntentionFilter` |
| [com.intellij.css.cssRelatedStylesheetsProvider](https://jb.gg/ipe?extensions=com.intellij.css.cssRelatedStylesheetsProvider)      |`CssRelatedStylesheetsProvider` |

### intellij.css.common.psi.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.css.additionalScopeProvider](https://jb.gg/ipe?extensions=com.intellij.css.additionalScopeProvider)      |`CssAdditionalScopeProvider` |
| [com.intellij.css.classOrIdUsagesProvider](https://jb.gg/ipe?extensions=com.intellij.css.classOrIdUsagesProvider)      |`CssClassOrIdUsagesProvider` |
| [com.intellij.css.cssFileReferenceProvider](https://jb.gg/ipe?extensions=com.intellij.css.cssFileReferenceProvider)      |`CssFileReferenceProvider` |
| [com.intellij.css.elementDescriptorProvider](https://jb.gg/ipe?extensions=com.intellij.css.elementDescriptorProvider)      |`CssElementDescriptorProvider` |
| [com.intellij.css.embeddedCssProvider](https://jb.gg/ipe?extensions=com.intellij.css.embeddedCssProvider)      |`EmbeddedCssProvider` |
| [com.intellij.css.inclusionContext](https://jb.gg/ipe?extensions=com.intellij.css.inclusionContext)      |`CssInclusionContext` |
| [com.intellij.css.structureViewChildrenProvider](https://jb.gg/ipe?extensions=com.intellij.css.structureViewChildrenProvider)      |`CssStructureViewElementsProvider` |
| [com.intellij.css.supportedFileTypesProvider](https://jb.gg/ipe?extensions=com.intellij.css.supportedFileTypesProvider)      |`CssSupportedFileTypesProvider` |

### intellij.css.common.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.css.dialect](https://jb.gg/ipe?extensions=com.intellij.css.dialect)      |`CssDialect` |

### intellij.css.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.css.blockManipulator](https://jb.gg/ipe?extensions=com.intellij.css.blockManipulator)      |`CssBlockManipulator` |
| [com.intellij.css.descriptorHandler](https://jb.gg/ipe?extensions=com.intellij.css.descriptorHandler)      |`CssDescriptorHandler` |
| [com.intellij.css.selectorMatcher](https://jb.gg/ipe?extensions=com.intellij.css.selectorMatcher)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`CssMatcher` |
| [com.intellij.css.styleSheetResolver](https://jb.gg/ipe?extensions=com.intellij.css.styleSheetResolver)      |`CssStylesheetResolver` |

### intellij.javascript.backend.diagrams.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.javascript.module.provider](https://jb.gg/ipe?extensions=com.intellij.javascript.module.provider)      |`JSModuleConnectionProvider` |

### intellij.javascript.backend.spellchecker.xml

| Extension Point |Implementation |
-----------------------------------
| [JavaScript.spellcheckerProvider](https://jb.gg/ipe?extensions=JavaScript.spellcheckerProvider)      |`JSSpellcheckerProvider` |

### intellij.javascript.backend.xml

| Extension Point |Implementation |
-----------------------------------
| [JavaScript.FlowJSAnnotatorCheckerProvider](https://jb.gg/ipe?extensions=JavaScript.FlowJSAnnotatorCheckerProvider)      |`FlowJSAnnotatorCheckerProvider` |
| [JavaScript.TypeScriptAnnotatorCheckerProvider](https://jb.gg/ipe?extensions=JavaScript.TypeScriptAnnotatorCheckerProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`TypeScriptAnnotatorCheckerProvider` |
| [JavaScript.completionHelper](https://jb.gg/ipe?extensions=JavaScript.completionHelper)      |`JSCompletionHelper` |
| [JavaScript.completionPlaceFilter](https://jb.gg/ipe?extensions=JavaScript.completionPlaceFilter)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`JSCompletionPlaceFilterProvider` |
| [JavaScript.componentUsageProvider](https://jb.gg/ipe?extensions=JavaScript.componentUsageProvider)      |`JSComponentUsageProvider` |
| [JavaScript.handlersFactory](https://jb.gg/ipe?extensions=JavaScript.handlersFactory)      |`JSHandlersFactory` |
| [JavaScript.highlightingHandlersFactory](https://jb.gg/ipe?extensions=JavaScript.highlightingHandlersFactory)      |`JSHighlightingHandlersFactory` |
| [JavaScript.importCandidatesFactory](https://jb.gg/ipe?extensions=JavaScript.importCandidatesFactory)      |`CandidatesFactory` |
| [JavaScript.importCandidatesFilterFactory](https://jb.gg/ipe?extensions=JavaScript.importCandidatesFilterFactory)      |`FilterFactory` |
| [JavaScript.intentionAndInspectionFilter](https://jb.gg/ipe?extensions=JavaScript.intentionAndInspectionFilter)      |`IntentionAndInspectionFilter` |
| [JavaScript.languageServiceProvider](https://jb.gg/ipe?extensions=JavaScript.languageServiceProvider)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`JSLanguageServiceProvider` |
| [JavaScript.languageServiceQuickFixProvider](https://jb.gg/ipe?extensions=JavaScript.languageServiceQuickFixProvider)      |`JSLanguageServiceQuickFixProvider` |
| [JavaScript.nodeModulesIndexableFileNamesProvider](https://jb.gg/ipe?extensions=JavaScript.nodeModulesIndexableFileNamesProvider)      |`NodeModulesIndexableFileNamesProvider` |
| [JavaScript.nodeRunConfigurationExtension](https://jb.gg/ipe?extensions=JavaScript.nodeRunConfigurationExtension)      |`AbstractNodeRunConfigurationExtension` |
| [JavaScript.predefinedLibraryProvider](https://jb.gg/ipe?extensions=JavaScript.predefinedLibraryProvider)      |`JSPredefinedLibraryProvider` |
| [JavaScript.runConfigurationBuilder](https://jb.gg/ipe?extensions=JavaScript.runConfigurationBuilder)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`JSRunConfigurationBuilder` |
| [JavaScript.runtimeProvider](https://jb.gg/ipe?extensions=JavaScript.runtimeProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`JSRuntimeProvider` |
| [JavaScript.scanningFileListenerContributor](https://jb.gg/ipe?extensions=JavaScript.scanningFileListenerContributor)      |`ScanningFileListenerContributor` |
| [JavaScript.smartCompletionContributor](https://jb.gg/ipe?extensions=JavaScript.smartCompletionContributor)      |`JSSmartCompletionContributor` |
| [JavaScript.testFrameworkDetector](https://jb.gg/ipe?extensions=JavaScript.testFrameworkDetector)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`n/a` |
| [JavaScript.testWatchProvider](https://jb.gg/ipe?extensions=JavaScript.testWatchProvider)      |`JsTestWatchProvider` |
| [JavaScript.tsConfigCustomizer](https://jb.gg/ipe?extensions=JavaScript.tsConfigCustomizer)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`TypeScriptConfigCustomizer` |
| [JavaScript.tsImportResolver](https://jb.gg/ipe?extensions=JavaScript.tsImportResolver)      |`TypeScriptImportsResolverProvider` |
| [JavaScript.tsServiceExtension](https://jb.gg/ipe?extensions=JavaScript.tsServiceExtension)      |`TypeScriptServiceExtension` |
| [JavaScript.webBundlerDefinition](https://jb.gg/ipe?extensions=JavaScript.webBundlerDefinition)      |`WebBundlerDefinition` |
| [NodeJS.runConfigurationLocationFilter](https://jb.gg/ipe?extensions=NodeJS.runConfigurationLocationFilter)      |`NodeRunConfigurationLocationFilter` |
| [com.intellij.JavaScript.linter.descriptor](https://jb.gg/ipe?extensions=com.intellij.JavaScript.linter.descriptor)      |`JSLinterDescriptor` |
| [com.intellij.javascript.cssClassNameProvider](https://jb.gg/ipe?extensions=com.intellij.javascript.cssClassNameProvider)      |`CssClassNameProvider` |
| [com.intellij.javascript.cssDocGenerator](https://jb.gg/ipe?extensions=com.intellij.javascript.cssDocGenerator)      |`CssDocGenerator` |
| [com.intellij.javascript.cssFileExtensionProvider](https://jb.gg/ipe?extensions=com.intellij.javascript.cssFileExtensionProvider)      |`CssFileExtensionProvider` |
| [com.intellij.javascript.cssIntegrationHelper](https://jb.gg/ipe?extensions=com.intellij.javascript.cssIntegrationHelper)      |`JsCssIntegrationHelper` |
| [com.intellij.javascript.extract.interface.extension](https://jb.gg/ipe?extensions=com.intellij.javascript.extract.interface.extension)      |`JSCustomExtractInterfaceHandler` |
| [com.intellij.javascript.introduce.variable.extension](https://jb.gg/ipe?extensions=com.intellij.javascript.introduce.variable.extension)      |`JSCustomIntroduceVariableHandler` |
| [com.intellij.javascript.json.schema.provider](https://jb.gg/ipe?extensions=com.intellij.javascript.json.schema.provider)      |`JsonSchemaInJavaScriptProvider` |
| [com.intellij.javascript.library.externalDefinitionsContributor](https://jb.gg/ipe?extensions=com.intellij.javascript.library.externalDefinitionsContributor)      |`TypeScriptExternalDefinitionsContributor` |
| [com.intellij.javascript.names.suggester](https://jb.gg/ipe?extensions=com.intellij.javascript.names.suggester)      |`JSNamesSuggester` |
| [com.intellij.javascript.nodeCoreSourcesFetcher](https://jb.gg/ipe?extensions=com.intellij.javascript.nodeCoreSourcesFetcher)      |`NodeCoreSourcesFetcher` |
| [com.intellij.javascript.rename.extension](https://jb.gg/ipe?extensions=com.intellij.javascript.rename.extension)      |`JSRenameExtension` |
| [com.intellij.jsbtFileManagerProvider](https://jb.gg/ipe?extensions=com.intellij.jsbtFileManagerProvider)      |`JsbtFileManagerProvider` |
| [com.intellij.jsbtService](https://jb.gg/ipe?extensions=com.intellij.jsbtService)      |`JsbtApplicationService` |
| [com.intellij.typescript.kolar.transpiler](https://jb.gg/ipe?extensions=com.intellij.typescript.kolar.transpiler)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`KolarTranspiler` |

### intellij.javascript.codeinsight.xml

| Extension Point |Implementation |
-----------------------------------
| [JavaScript.analysisHandlersFactory](https://jb.gg/ipe?extensions=JavaScript.analysisHandlersFactory)      |`JSAnalysisHandlersFactory` |
| [JavaScript.jsxCopyPasteActionsProvider](https://jb.gg/ipe?extensions=JavaScript.jsxCopyPasteActionsProvider)      |`JSXCopyPasteActionsProvider` |

### intellij.javascript.common.xml

| Extension Point |Implementation |
-----------------------------------
| [JavaScript.commonHandlersFactory](https://jb.gg/ipe?extensions=JavaScript.commonHandlersFactory)      |`JSCommonHandlersFactory` |

### intellij.javascript.ideaUltimate.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.javascript.webFileReferenceFileTypeProvider](https://jb.gg/ipe?extensions=com.intellij.javascript.webFileReferenceFileTypeProvider)      |`IdeaWebFileReferenceFileTypeProvider` |

### intellij.javascript.psi.impl.xml

| Extension Point |Implementation |
-----------------------------------
| [JavaScript.JSImplicitElementsIndexFileTypeProvider](https://jb.gg/ipe?extensions=JavaScript.JSImplicitElementsIndexFileTypeProvider)      |`JSImplicitElementsIndexFileTypeProvider` |
| [JavaScript.classInheritorsProvider](https://jb.gg/ipe?extensions=JavaScript.classInheritorsProvider)      |`JSClassInheritorsProvider` |
| [JavaScript.dialectSpecificHandlersFactory](https://jb.gg/ipe?extensions=JavaScript.dialectSpecificHandlersFactory)      |`JSDialectSpecificHandlersFactory` |
| [JavaScript.directFileReferenceResolverProvider](https://jb.gg/ipe?extensions=JavaScript.directFileReferenceResolverProvider)      |`JSDirectFileReferenceResolverProvider` |
| [JavaScript.elementIndexingDataCalculator](https://jb.gg/ipe?extensions=JavaScript.elementIndexingDataCalculator)      |`JSElementIndexingDataCalculator` |
| [JavaScript.elementScopeProvider](https://jb.gg/ipe?extensions=JavaScript.elementScopeProvider)      |`JSElementResolveScopeProvider` |
| [JavaScript.frameworkIndexingHandler](https://jb.gg/ipe?extensions=JavaScript.frameworkIndexingHandler)      |`FrameworkIndexingHandler` |
| [JavaScript.frameworkSpecificHandler](https://jb.gg/ipe?extensions=JavaScript.frameworkSpecificHandler)      |`JSFrameworkSpecificHandler` |
| [JavaScript.iconProvider](https://jb.gg/ipe?extensions=JavaScript.iconProvider)      |`JSIconProvider` |
| [JavaScript.importModulePathStrategy](https://jb.gg/ipe?extensions=JavaScript.importModulePathStrategy)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`JSImportModulePathStrategy` |
| [JavaScript.indexedFileTypeProvider](https://jb.gg/ipe?extensions=JavaScript.indexedFileTypeProvider)      |`IndexedFileTypeProvider` |
| [JavaScript.inheritedLanguagesConfigurableProvider](https://jb.gg/ipe?extensions=JavaScript.inheritedLanguagesConfigurableProvider)      |`JSInheritedLanguagesConfigurableProvider` |
| [JavaScript.itemPresentation](https://jb.gg/ipe?extensions=JavaScript.itemPresentation)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`JSItemPresentationProvider` |
| [JavaScript.jsDocCustomTagsHandler](https://jb.gg/ipe?extensions=JavaScript.jsDocCustomTagsHandler)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`JSDocCustomTagsHandler` |
| [JavaScript.jsxImplementation](https://jb.gg/ipe?extensions=JavaScript.jsxImplementation)      |`JSXImplementation` |
| [JavaScript.lang.templates](https://jb.gg/ipe?extensions=JavaScript.lang.templates)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[Configurable](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/ide-core/src/com/intellij/openapi/options/Configurable.java) |
| [JavaScript.libraryVersionChecker](https://jb.gg/ipe?extensions=JavaScript.libraryVersionChecker)      |`JSLibraryVersionChecker` |
| [JavaScript.minifiedFileIndexingProvider](https://jb.gg/ipe?extensions=JavaScript.minifiedFileIndexingProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`JSMinifiedFileIndexingProvider` |
| [JavaScript.moduleExportsProvider](https://jb.gg/ipe?extensions=JavaScript.moduleExportsProvider)      |`JSModuleExportsProvider` |
| [JavaScript.moduleReferenceContributor](https://jb.gg/ipe?extensions=JavaScript.moduleReferenceContributor)      |`JSModuleReferenceContributor` |
| [JavaScript.resolveHelper](https://jb.gg/ipe?extensions=JavaScript.resolveHelper)      |`JSResolveHelper` |
| [JavaScript.servicePoweredTypeEngineEvaluator](https://jb.gg/ipe?extensions=JavaScript.servicePoweredTypeEngineEvaluator)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`JSServicePoweredTypeEngineEvaluator` |
| [JavaScript.typeScriptCompilerTypeFilter](https://jb.gg/ipe?extensions=JavaScript.typeScriptCompilerTypeFilter)      |`TypeScriptCompilerTypeFilter` |
| [JavaScript.unresolvedReferenceErrorUpdater](https://jb.gg/ipe?extensions=JavaScript.unresolvedReferenceErrorUpdater)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`JSUnresolvedReferenceErrorUpdater` |
| [JavaScript.webBundlerCssReferenceContributor](https://jb.gg/ipe?extensions=JavaScript.webBundlerCssReferenceContributor)      |`JSModuleReferenceContributor` |
| [JavaScript.xmlBackedClassProvider](https://jb.gg/ipe?extensions=JavaScript.xmlBackedClassProvider)      |`XmlBackedJSClassProvider` |
| [com.intellij.javascript.cssClassesProcessor](https://jb.gg/ipe?extensions=com.intellij.javascript.cssClassesProcessor)      |`CssClassesProcessor` |
| [com.intellij.javascript.cssModuleNameProvider](https://jb.gg/ipe?extensions=com.intellij.javascript.cssModuleNameProvider)      |`CssModuleNameProvider` |
| [com.intellij.javascript.cssResolveSupport](https://jb.gg/ipe?extensions=com.intellij.javascript.cssResolveSupport)      |`CssResolveSupport` |
| [com.intellij.javascript.cssStylesheetDetector](https://jb.gg/ipe?extensions=com.intellij.javascript.cssStylesheetDetector)      |`CssStylesheetDetector` |
| [com.intellij.javascript.libReferenceSupport](https://jb.gg/ipe?extensions=com.intellij.javascript.libReferenceSupport)      |`JSLibReferenceSupport` |

### intellij.javascript.structureView.xml

| Extension Point |Implementation |
-----------------------------------
| [JavaScript.frameworkSpecificStructureViewExtension](https://jb.gg/ipe?extensions=JavaScript.frameworkSpecificStructureViewExtension)      |`JSFrameworkSpecificStructureExtension` |

### intellij.javascript.ultimate.xml

| Extension Point |Implementation |
-----------------------------------
| [JavaScript.jestPackageProvider](https://jb.gg/ipe?extensions=JavaScript.jestPackageProvider)      |`JestPackageProvider` |

### intellij.sass.backend.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.sass.extension](https://jb.gg/ipe?extensions=com.intellij.sass.extension)      |`SassExtension` |

### org.jetbrains.plugins.node-remote-interpreter

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.node-remote-interpreter.nodeRemoteTargetRunSetupFactory](https://jb.gg/ipe?extensions=org.jetbrains.plugins.node-remote-interpreter.nodeRemoteTargetRunSetupFactory)      |`NodeRemoteTargetRunSetupFactory` |

