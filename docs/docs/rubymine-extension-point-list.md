# RubyMine Extension Point and Listener List

<tldr>
Product-Specific Plugin Development: [RubyMine](rubymine.html)

See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

109 Extension Points and 11 Listeners

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
| ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |Project-LevelExtension Point/Topic   |Can have [Project](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/project/Project.java)                             as constructor parameter.                               - Extension Point: declared with `area="IDEA_PROJECT"`                               - Listener: registered in [&lt;projectListeners&gt;](plugin-configuration-file.html#idea-plugin__projectListeners)                                |
| ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |`DumbAware`                             Extension Point   |Implementations marked with [DumbAware](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/project/DumbAware.java)                             will be processed during [dumb                                 mode](indexing-and-psi-stubs.html#dumb-mode).                          |
| ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |Non-DynamicExtension Point   |Installation/update of plugin requires restarting the IDE, see [Dynamic Plugins](dynamic-plugins.html).                          |

## RubyMine

### RubyMine – Listeners

| Topic |Listener |
-------------------
| [RbsLanguageSettingsChangedListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.lang.ruby.rbs.settings.RbsLanguageSettingsChangedListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RbsLanguageSettingsChangedListener` |
| [GemManager#GEMSET_CHANGED_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.gem.GemManager.GemSetListener) |`GemSetListener` |
| [GemManager#MODULE_GEMS_CHANGED_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.gem.GemManager.ModuleGemsListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ModuleGemsListener` |
| [GemRequirementsHolder#GEM_REQUIREMENTS_CHANGED_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.gem.module.GemRequirementsHolder.RequirementsChangedListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RequirementsChangedListener` |
| [RubyWslSettings#SETTINGS_CHANGE_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.gem.ui.RubyWslSettings.SettingsChangeListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`SettingsChangeListener` |
| [InflectorService#INFLECTIONS_CHANGED](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.rails.InflectorService.InflectionChanged) |`InflectionChanged` |
| [MigrationParser#MIGRATIONS_CHANGED_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.rails.database.MigrationParser.MigrationListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`MigrationListener` |
| [RailsPathsChangedListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.rails.facet.configuration.RailsPathsChangedListener) |`RailsPathsChangedListener` |
| [RubyRemoteInterpreterManager#RUBY_REMOTE_SDK_TRANSFER_LISTENER_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.remote.RubyRemoteSdkTransferListener) |`RubyRemoteSdkTransferListener` |
| [RubySdkType#SDK_PATHS_INITIALIZED_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.ruby.sdk.RubySdkType.SdkPathsInitializedListener) |`SdkPathsInitializedListener` |
| [RVMSupportUtil#RVM_GEMSET_ADDED_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.ruby.version.management.rvm.RVMSupportUtil.RVMGemsetListener) |`RVMGemsetListener` |

### intellij.ruby.backend.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.ruby.projectStructure.sourceRootEditHandler](https://jb.gg/ipe?extensions=com.intellij.ruby.projectStructure.sourceRootEditHandler)      |`RubyModuleSourceRootEditProvider` |
| [org.jetbrains.plugins.ruby.associationFactory](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.associationFactory)      |`AssociationFactory` |
| [org.jetbrains.plugins.ruby.autoImportProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.autoImportProvider)      |`RubyAutoImportProvider` |
| [org.jetbrains.plugins.ruby.breadcrumbsCustomizer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.breadcrumbsCustomizer)      |`RubyBreadcrumbsCustomizer` |
| [org.jetbrains.plugins.ruby.callNavigationOffsetProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.callNavigationOffsetProvider)      |`StructureCallNavigationOffsetProvider` |
| [org.jetbrains.plugins.ruby.completionProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.completionProvider)      |`RubyCompletionProvider` |
| [org.jetbrains.plugins.ruby.copyReference.symbolTargetProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.copyReference.symbolTargetProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`SymbolCopyReferenceTargetProvider` |
| [org.jetbrains.plugins.ruby.debug.infoProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.debug.infoProvider)      |`ContextInfoProvider` |
| [org.jetbrains.plugins.ruby.fileLocationProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.fileLocationProvider)      |`FileLocationProvider` |
| [org.jetbrains.plugins.ruby.gem.detector](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.gem.detector)      |`GemDetector` |
| [org.jetbrains.plugins.ruby.gem.module.gemInfrastructure](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.gem.module.gemInfrastructure)      |`GemInfrastructure` |
| [org.jetbrains.plugins.ruby.gemFacetEditorTab](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.gemFacetEditorTab)      |`GemFacetEditorTabFactory` |
| [org.jetbrains.plugins.ruby.gemScannerSuppressor](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.gemScannerSuppressor)      |`GemScannerSuppressor` |
| [org.jetbrains.plugins.ruby.i18n.i18nProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.i18n.i18nProvider)      |`I18nProvider` |
| [org.jetbrains.plugins.ruby.implicitGemProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.implicitGemProvider)      |`ImplicitRequireGemProvider` |
| [org.jetbrains.plugins.ruby.implicitRequireProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.implicitRequireProvider)      |`ImplicitRequireProvider` |
| [org.jetbrains.plugins.ruby.includeExtendReceiverFqnProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.includeExtendReceiverFqnProvider)      |`RubyIncludeExtendReceiverFqnProvider` |
| [org.jetbrains.plugins.ruby.methodMissingProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.methodMissingProvider)      |`MethodMissingProvider` |
| [org.jetbrains.plugins.ruby.model.classSymbolDataProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.classSymbolDataProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RubyClassSymbolDataProvider` |
| [org.jetbrains.plugins.ruby.model.completion.searchScopeModifier](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.completion.searchScopeModifier)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RubyCompletionScopeModifier` |
| [org.jetbrains.plugins.ruby.model.constantSymbolDataProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.constantSymbolDataProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RubyConstantSymbolDataProvider` |
| [org.jetbrains.plugins.ruby.model.containerSymbolDataProcessor](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.containerSymbolDataProcessor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RubyContainerSymbolDataProcessor` |
| [org.jetbrains.plugins.ruby.model.containerSymbolDataProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.containerSymbolDataProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RubyContainerSymbolDataProvider` |
| [org.jetbrains.plugins.ruby.model.documentation.compositeTargetDataProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.documentation.compositeTargetDataProvider)      |`CompositeDocumentationTargetDataProvider` |
| [org.jetbrains.plugins.ruby.model.globalVariableSymbolDataProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.globalVariableSymbolDataProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RubyGlobalVariableSymbolDataProvider` |
| [org.jetbrains.plugins.ruby.model.psi.symbolDeclarationsSearch](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.psi.symbolDeclarationsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [org.jetbrains.plugins.ruby.model.symbol.navigationTargetProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.symbol.navigationTargetProvider)      |`SymbolNavigationTargetProvider` |
| [org.jetbrains.plugins.ruby.model.symbol.presentationProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.symbol.presentationProvider)      |`SymbolPresentationProvider` |
| [org.jetbrains.plugins.ruby.model.topLevelSymbolProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.topLevelSymbolProvider)      |`RubyTopLevelSymbolProvider` |
| [org.jetbrains.plugins.ruby.moduleGemDependencyProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.moduleGemDependencyProvider)      |`ModuleGemDependencyProvider` |
| [org.jetbrains.plugins.ruby.moduleGemProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.moduleGemProvider)      |`ModuleGemProvider` |
| [org.jetbrains.plugins.ruby.overriddenMethodGenerator](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.overriddenMethodGenerator)      |`OverriddenMethodGenerator` |
| [org.jetbrains.plugins.ruby.paramDefProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.paramDefProvider)      |`ParamDefProvider` |
| [org.jetbrains.plugins.ruby.rails.assetsPathsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rails.assetsPathsProvider)      |`SprocketAssetsPathProvider` |
| [org.jetbrains.plugins.ruby.rails.sprocketsDirectiveContextProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rails.sprocketsDirectiveContextProvider)      |`SprocketsDirectiveContextProvider` |
| [org.jetbrains.plugins.ruby.rails.viewFileTemplateProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rails.viewFileTemplateProvider)      |`RailsViewFileTemplateProvider` |
| [org.jetbrains.plugins.ruby.rails.viewFileTypesProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rails.viewFileTypesProvider)      |`RailsViewFileTypesProvider` |
| [org.jetbrains.plugins.ruby.railsFacetEditorTab](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.railsFacetEditorTab)      |`FacetEditorTabFactory` |
| [org.jetbrains.plugins.ruby.railsModelFieldsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.railsModelFieldsProvider)      |`RailsModelFieldsProvider` |
| [org.jetbrains.plugins.ruby.railsNavigateFrom](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.railsNavigateFrom)      |`RailsNavigateFromProvider` |
| [org.jetbrains.plugins.ruby.railsSchemaParser](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.railsSchemaParser)      |`RailsSchemaParser` |
| [org.jetbrains.plugins.ruby.rake.rakeRunCommandLineModifierProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rake.rakeRunCommandLineModifierProvider)      |`RakeRunCommandLineModifierProvider` |
| [org.jetbrains.plugins.ruby.rake.runConfigurationSettingsFactory](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rake.runConfigurationSettingsFactory)      |`RakeRunConfigurationSettingsFactory` |
| [org.jetbrains.plugins.ruby.renameHelper](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.renameHelper)      |`RubyRenameHelper` |
| [org.jetbrains.plugins.ruby.rerunFailedTestsActionProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rerunFailedTestsActionProvider)      |`RubyRerunFailedTestsProvider` |
| [org.jetbrains.plugins.ruby.routesProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.routesProvider)      |`RubyRoutesProvider` |
| [org.jetbrains.plugins.ruby.ruby.associatedDeclarationProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.associatedDeclarationProvider)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |`RubyAssociatedDeclarationProvider` |
| [org.jetbrains.plugins.ruby.ruby.coercibleExpressionTypeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.coercibleExpressionTypeProvider)      |`RubyCoercibleExpressionTypeProvider` |
| [org.jetbrains.plugins.ruby.ruby.expectedArgumentNilabilityProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.expectedArgumentNilabilityProvider)      |`RubyExpectedArgumentNilabilityProvider` |
| [org.jetbrains.plugins.ruby.ruby.expectedArgumentTypeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.expectedArgumentTypeProvider)      |`RubyExpectedArgumentTypeProvider` |
| [org.jetbrains.plugins.ruby.ruby.expectedConstantTypeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.expectedConstantTypeProvider)      |`RubyExpectedConstantTypeProvider` |
| [org.jetbrains.plugins.ruby.ruby.expectedGlobalVariableTypeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.expectedGlobalVariableTypeProvider)      |`RubyExpectedGlobalVariableTypeProvider` |
| [org.jetbrains.plugins.ruby.ruby.expectedMethodSignatureProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.expectedMethodSignatureProvider)      |`RubyExpectedMethodSignatureProvider` |
| [org.jetbrains.plugins.ruby.ruby.expectedParameterTypeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.expectedParameterTypeProvider)      |`RubyExpectedParameterTypeProvider` |
| [org.jetbrains.plugins.ruby.ruby.expectedReturnTypeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.expectedReturnTypeProvider)      |`RubyExpectedReturnTypeProvider` |
| [org.jetbrains.plugins.ruby.ruby.expectedVariableTypeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.expectedVariableTypeProvider)      |`RubyExpectedVariableTypeProvider` |
| [org.jetbrains.plugins.ruby.ruby.findUsagesSecondaryElementsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.findUsagesSecondaryElementsProvider)      |`RubyFindUsagesSecondaryElementsProvider` |
| [org.jetbrains.plugins.ruby.ruby.rename.paramDefSearchRequestProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.rename.paramDefSearchRequestProvider)      |`RubyParamDefRenameUsageSearchRequestProvider` |
| [org.jetbrains.plugins.ruby.ruby.run.configuration.debugger.rubyDebugHelperFactory](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.run.configuration.debugger.rubyDebugHelperFactory)      |`RubyDebugHelperFactory` |
| [org.jetbrains.plugins.ruby.ruby.run.runEnvironmentProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.run.runEnvironmentProvider)      |`RunEnvironmentProvider` |
| [org.jetbrains.plugins.ruby.ruby.typeSignatureProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.typeSignatureProvider)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |`RubyTypeSignatureProvider` |
| [org.jetbrains.plugins.ruby.ruby.usages.paramDefSearchRequestProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.ruby.usages.paramDefSearchRequestProvider)      |`RubyParamDefUsageSearchRequestProvider` |
| [org.jetbrains.plugins.ruby.rubyElementNameAndDescriptionProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyElementNameAndDescriptionProvider)      |`RubyElementNameAndDescriptionProvider` |
| [org.jetbrains.plugins.ruby.rubyFileStructureProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyFileStructureProvider)      |`RubyFileStructureViewProvider` |
| [org.jetbrains.plugins.ruby.rubyInsertHandlerProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyInsertHandlerProvider)      |`RubyInsertHandlerProvider` |
| [org.jetbrains.plugins.ruby.rubyLocalVariablesProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyLocalVariablesProvider)      |`RubyLocalVariablesProvider` |
| [org.jetbrains.plugins.ruby.rubyMethodTypeDocPresentationProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyMethodTypeDocPresentationProvider)      |`RubyMethodTypeDocPresentationProvider` |
| [org.jetbrains.plugins.ruby.rubyParamDefSearchTextProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyParamDefSearchTextProvider)      |`RubyParamDefSearchTextProvider` |
| [org.jetbrains.plugins.ruby.rubyParameterInfoDelegateProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyParameterInfoDelegateProvider)      |`RubyParameterInfoDelegateProvider` |
| [org.jetbrains.plugins.ruby.rubyRenameProcessor](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyRenameProcessor)      |`RenameProcessor` |
| [org.jetbrains.plugins.ruby.rubySdkConfigurator](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubySdkConfigurator)      |`RubySdkConfigurator` |
| [org.jetbrains.plugins.ruby.rubySuperMethodsSearch](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubySuperMethodsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [org.jetbrains.plugins.ruby.rubySupportProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubySupportProvider)      |`RubySupportProvider` |
| [org.jetbrains.plugins.ruby.rubySymbolDeprecationProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubySymbolDeprecationProvider)      |`RubySymbolDeprecationProvider` |
| [org.jetbrains.plugins.ruby.run.console.filter](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.run.console.filter)      |`RubyConsoleFilterProvider` |
| [org.jetbrains.plugins.ruby.runConfigurationExtension](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.runConfigurationExtension)      |`RubyRunConfigurationExtension` |
| [org.jetbrains.plugins.ruby.runnableScriptFilter](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.runnableScriptFilter)      |`RunnableScriptFilter` |
| [org.jetbrains.plugins.ruby.sdkConfigFactory](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.sdkConfigFactory)      |`Factory` |
| [org.jetbrains.plugins.ruby.sdkNameProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.sdkNameProvider)      |`RubySdkNameProvider` |
| [org.jetbrains.plugins.ruby.sdkRefresherFactory](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.sdkRefresherFactory)      |`SdkRefresherFactory` |
| [org.jetbrains.plugins.ruby.structureViewCustomizer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.structureViewCustomizer)      |`RubyStructureViewCustomizer` |
| [org.jetbrains.plugins.ruby.superMethodInfoProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.superMethodInfoProvider)      |`RubySuperMethodInfoProvider` |
| [org.jetbrains.plugins.ruby.symbolMixinsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.symbolMixinsProvider)      |`RubySymbolMixinsProvider` |
| [org.jetbrains.plugins.ruby.symbolProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.symbolProvider)      |`RubySymbolProvider` |
| [org.jetbrains.plugins.ruby.symbolicTypeInferenceProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.symbolicTypeInferenceProvider)      |`SymbolicTypeInferenceProvider` |
| [org.jetbrains.plugins.ruby.testing.rspec.rspecContextNameProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.testing.rspec.rspecContextNameProvider)      |`RSpecContextNameProvider` |
| [org.jetbrains.plugins.ruby.testing.rspec.rspecContextSymbolProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.testing.rspec.rspecContextSymbolProvider)      |`RSpecContextSymbolProvider` |
| [org.jetbrains.plugins.ruby.versionManagerHandler](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.versionManagerHandler)      |`RubyVersionManagerHandler` |

### intellij.ruby.coverage.xml

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.ruby.coverage.deserializer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.coverage.deserializer)      |`RubyCoverageDeserializationProvider` |

### intellij.ruby.impl.xml

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.ruby.formatter.additionalSpacingProcessor](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.formatter.additionalSpacingProcessor)      |`RubyAdditionalSpacingProcessor` |
| [org.jetbrains.plugins.ruby.psiElementFactory](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.psiElementFactory)      |`PsiElementFactory` |
| [org.jetbrains.plugins.ruby.rubyBuilderFactory](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyBuilderFactory)      |`RubyBuilderFactory` |
| [org.jetbrains.plugins.ruby.settings.supportedExternalFormatter](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.settings.supportedExternalFormatter)      |`RubySupportedExternalFormatter` |
| [org.jetbrains.plugins.ruby.templates.elements.provider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.templates.elements.provider)      |`TemplateElementsProvider` |

### intellij.ruby.psi.impl.xml

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.ruby.callTypeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.callTypeProvider)      |`RubyCallTypeProvider` |

### intellij.ruby.psi.xml

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.ruby.attributeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.attributeProvider)      |`AttributeProvider` |
| [org.jetbrains.plugins.ruby.attributeSerializerProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.attributeSerializerProvider)      |`AttributeSerializerProvider` |
| [org.jetbrains.plugins.ruby.callTypeIndexer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.callTypeIndexer)      |`RubyCallTypeIndexer` |
| [org.jetbrains.plugins.ruby.callTypeOperator](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.callTypeOperator)      |`StorageOperator` |
| [org.jetbrains.plugins.ruby.callTypeReferenceContributorsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.callTypeReferenceContributorsProvider)      |`Provider` |
| [org.jetbrains.plugins.ruby.inflectionsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.inflectionsProvider)      |`RubyInflectionsProvider` |
| [org.jetbrains.plugins.ruby.model.psi.ownDeclarationProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.psi.ownDeclarationProvider)      |`PsiOwnSymbolDeclarationProvider` |
| [org.jetbrains.plugins.ruby.model.psi.ownReferenceProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.model.psi.ownReferenceProvider)      |`PsiOwnSymbolReferenceProvider` |
| [org.jetbrains.plugins.ruby.rTypeSubtypeContributor](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rTypeSubtypeContributor)      |`RTypeSubTypeContributor` |
| [org.jetbrains.plugins.ruby.rubyTypeProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.rubyTypeProvider)      |`RubyTypeProvider` |
| [org.jetbrains.plugins.ruby.serializableTypeResolver](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.serializableTypeResolver)      |`RubySerializableTypeResolver` |
| [org.jetbrains.plugins.ruby.templates.integration](https://jb.gg/ipe?extensions=org.jetbrains.plugins.ruby.templates.integration)      |`TemplateIntegration` |

### intellij.ruby.rbs.backend.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.lang.ruby.rbs.containerHierarchyMapper](https://jb.gg/ipe?extensions=com.intellij.lang.ruby.rbs.containerHierarchyMapper)      |`RbsContainerHierarchyMapper` |
| [com.intellij.lang.ruby.rbs.psi.typeSignatureSerializer](https://jb.gg/ipe?extensions=com.intellij.lang.ruby.rbs.psi.typeSignatureSerializer)      |`RbsTypeSignatureSerializer` |

