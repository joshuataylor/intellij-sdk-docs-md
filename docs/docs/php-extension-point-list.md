# PHP Extension Point and Listener List

<tldr>
Product-Specific Plugin Development: [PhpStorm](phpstorm.html)

See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

68 Extension Points and 11 Listeners

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
| ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |Project-LevelExtension Point/Topic   |Can have [Project](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/project/Project.java)                             as constructor parameter.                               - Extension Point: declared with `area="IDEA_PROJECT"`                               - Listener: registered in [&lt;projectListeners&gt;](plugin-configuration-file.html#idea-plugin__projectListeners)                                |
| ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |`DumbAware`                             Extension Point   |Implementations marked with [DumbAware](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/project/DumbAware.java)                             will be processed during [dumb                                 mode](indexing-and-psi-stubs.html#dumb-mode).                          |
| ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |Non-DynamicExtension Point   |Installation/update of plugin requires restarting the IDE, see [Dynamic Plugins](dynamic-plugins.html).                          |

## PhpStorm

### PhpStorm – Listeners

| Topic |Listener |
-------------------
| [ComposerInstalledPackagesService#PACKAGE_MANAGER_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.composer.actions.update.ComposerInstalledPackagesService.ComposerUpdateListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ComposerUpdateListener` |
| [RepositoriesComposerConfig#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.composer.json.cache.ComposerRepositoriesChangedListener) |`ComposerRepositoriesChangedListener` |
| [StateChangedListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.config.PhpProjectSharedConfiguration.StateChangedListener) |`StateChangedListener` |
| [StateChangedListener#LANGUAGE_LEVEL_CHANGED_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.config.PhpProjectSharedConfiguration.StateChangedListener) |`StateChangedListener` |
| [PhpProjectWorkspaceConfiguration#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.config.PhpProjectWorkspaceConfigurationListener) |`PhpProjectWorkspaceConfigurationListener` |
| [DefaultStubsPathListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.config.PhpRuntimeConfiguration.DefaultStubsPathListener) |`DefaultStubsPathListener` |
| [PhpInterpreterConflictResolveListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.config.interpreters.PhpInterpretersManagerImpl.PhpInterpreterConflictResolveListener) |`PhpInterpreterConflictResolveListener` |
| [StateChangedListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.debug.listener.PhpDebugExternalConnectionsAccepter.StateChangedListener) |`StateChangedListener` |
| [RectorChangesListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.rector.RectorChangesListener) |`RectorChangesListener` |
| [PhpRemoteInterpreterChangedListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.php.remote.interpreter.ui.PhpRemoteInterpreterConfigurationForm.PhpRemoteInterpreterChangedListener) |`PhpRemoteInterpreterChangedListener` |
| [CustomExpectationNotifier.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.pestphp.pest.features.customExpectations.CustomExpectationNotifier)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`CustomExpectationNotifier` |

### com.intellij.phing

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.phing.propertyFilesManager](https://jb.gg/ipe?extensions=com.intellij.phing.propertyFilesManager)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`PropertyFilesManager` |

### com.intellij.php.psalm

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.php.tools.quality.Psalm.PsalmConfigurationProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.tools.quality.Psalm.PsalmConfigurationProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`PsalmConfigurationProvider` |

### com.intellij.php.tools.quality.phpstan

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.php.tools.quality.PhpStan.PhpStanConfigurationProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.tools.quality.PhpStan.PhpStanConfigurationProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`PhpStanConfigurationProvider` |

### com.jetbrains.php

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.php.debug.template.configurable](https://jb.gg/ipe?extensions=com.intellij.php.debug.template.configurable)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`PhpTemplateDebugConfigurable` |
| [com.intellij.php.debug.templateLanguage](https://jb.gg/ipe?extensions=com.intellij.php.debug.templateLanguage)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpTemplateLanguagePathMapper` |
| [com.intellij.php.typeProvider2](https://jb.gg/ipe?extensions=com.intellij.php.typeProvider2)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |`PhpTypeProvider2` |
| [com.intellij.phpDeadCode](https://jb.gg/ipe?extensions=com.intellij.phpDeadCode)      |[EntryPoint](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/codeInspection/reference/EntryPoint.java) |
| [com.intellij.phpRunConfigurationExtension](https://jb.gg/ipe?extensions=com.intellij.phpRunConfigurationExtension)      |`PhpRunConfigurationExtension` |
| [com.jetbrains.php.arrayShapesProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.arrayShapesProvider)      |`PhpArrayShapesProvider` |
| [com.jetbrains.php.baseLexerProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.baseLexerProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpBaseLexerProvider` |
| [com.jetbrains.php.classAliasProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.classAliasProvider)      |`PhpClassAliasProvider` |
| [com.jetbrains.php.composer.execProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.composer.execProvider)      |`ComposerExecutionProvider` |
| [com.jetbrains.php.composerConfigClient](https://jb.gg/ipe?extensions=com.jetbrains.php.composerConfigClient)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`ComposerConfigClient` |
| [com.jetbrains.php.config.customFormatFunctionsProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.config.customFormatFunctionsProvider)      |`PhpCustomFormatFunctionsProvider` |
| [com.jetbrains.php.config.interpreterFormProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.config.interpreterFormProvider)      |`PhpInterpreterFormProvider` |
| [com.jetbrains.php.config.interpreters.PhpInterpretersStateListener](https://jb.gg/ipe?extensions=com.jetbrains.php.config.interpreters.PhpInterpretersStateListener)      |`PhpInterpretersStateListener` |
| [com.jetbrains.php.coreMethodProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.coreMethodProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpCoreHandler` |
| [com.jetbrains.php.customFunctionIndex](https://jb.gg/ipe?extensions=com.jetbrains.php.customFunctionIndex)      |`PhpCustomFunctionIndex` |
| [com.jetbrains.php.customFunctionPredicate](https://jb.gg/ipe?extensions=com.jetbrains.php.customFunctionPredicate)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpCustomFunctionPredicateIndex` |
| [com.jetbrains.php.customTemplatesNamesProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.customTemplatesNamesProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`PhpCustomTemplatesNamesProvider` |
| [com.jetbrains.php.debug.mapping.localPathFixer](https://jb.gg/ipe?extensions=com.jetbrains.php.debug.mapping.localPathFixer)      |`PhpLocalPathFixer` |
| [com.jetbrains.php.deploymentIntegration](https://jb.gg/ipe?extensions=com.jetbrains.php.deploymentIntegration)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpDeploymentIntegration` |
| [com.jetbrains.php.deprecationFixesProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.deprecationFixesProvider)      |`PhpDeprecationQuickFixesProvider` |
| [com.jetbrains.php.deprecationProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.deprecationProvider)      |`PhpDeprecationProvider` |
| [com.jetbrains.php.dfaStateFromAssertionProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.dfaStateFromAssertionProvider)      |`PhpDfaStateFromAssertionProvider` |
| [com.jetbrains.php.docPrefixProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.docPrefixProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpDocPrefixProvider` |
| [com.jetbrains.php.docTagValuesStubProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.docTagValuesStubProvider)      |`PhpCustomDocTagValuesStubProvider` |
| [com.jetbrains.php.expressionClassNamesProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.expressionClassNamesProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpExpressionClassNamesProvider` |
| [com.jetbrains.php.externalUsagesSearcher](https://jb.gg/ipe?extensions=com.jetbrains.php.externalUsagesSearcher)      |`PhpExternalUsagesSearcher` |
| [com.jetbrains.php.frameworkProjectConfigurableProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.frameworkProjectConfigurableProvider)      |`PhpFrameworkConfigurableProvider` |
| [com.jetbrains.php.frameworkUsageProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.frameworkUsageProvider)      |`PhpFrameworkUsageProvider` |
| [com.jetbrains.php.includedPathsContributor](https://jb.gg/ipe?extensions=com.jetbrains.php.includedPathsContributor)      |`PhpIncludedPathsContributor` |
| [com.jetbrains.php.injectableLanguageProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.injectableLanguageProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpInjectableLanguageProvider` |
| [com.jetbrains.php.injectionExternalFragmentSubstProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.injectionExternalFragmentSubstProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`PhpInjectionExternalFragmentSubstProvider` |
| [com.jetbrains.php.keyTypeProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.keyTypeProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpKeyTypeProvider` |
| [com.jetbrains.php.libraryRoot](https://jb.gg/ipe?extensions=com.jetbrains.php.libraryRoot)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpLibraryRootProvider` |
| [com.jetbrains.php.magicMethodProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.magicMethodProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpMagicHandler` |
| [com.jetbrains.php.metaSignatureResolver](https://jb.gg/ipe?extensions=com.jetbrains.php.metaSignatureResolver)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpMetaSignatureResolver` |
| [com.jetbrains.php.metaTableProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.metaTableProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpMetaTableProvider` |
| [com.jetbrains.php.noReturnProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.noReturnProvider)      |`PhpNoReturnProvider` |
| [com.jetbrains.php.openSettingsProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.openSettingsProvider)      |`Settings` |
| [com.jetbrains.php.phpunit.phpUnitSettingsLoader](https://jb.gg/ipe?extensions=com.jetbrains.php.phpunit.phpUnitSettingsLoader)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpUnitSettingsLoader` |
| [com.jetbrains.php.predefinedVariableProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.predefinedVariableProvider)      |`PhpPredefinedVariableProvider` |
| [com.jetbrains.php.referenceResolver2](https://jb.gg/ipe?extensions=com.jetbrains.php.referenceResolver2)      |`PhpMultipleDeclarationFilter` |
| [com.jetbrains.php.referenceScopeExtension](https://jb.gg/ipe?extensions=com.jetbrains.php.referenceScopeExtension)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`PhpReferenceScopeExtension` |
| [com.jetbrains.php.relatedToPhpFilesContributor](https://jb.gg/ipe?extensions=com.jetbrains.php.relatedToPhpFilesContributor)      |`RelatedToPhpFilesContributor` |
| [com.jetbrains.php.remote.remoteInterpreterManager](https://jb.gg/ipe?extensions=com.jetbrains.php.remote.remoteInterpreterManager)      |`PhpRemoteInterpreterManager` |
| [com.jetbrains.php.templateLanguageHighlightingExtension](https://jb.gg/ipe?extensions=com.jetbrains.php.templateLanguageHighlightingExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`TemplateLanguageBackgroundColorProvider` |
| [com.jetbrains.php.testFramework.phpTestOldConfigHolder](https://jb.gg/ipe?extensions=com.jetbrains.php.testFramework.phpTestOldConfigHolder)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpTestFrameworkOldConfigHolder` |
| [com.jetbrains.php.testFrameworkType](https://jb.gg/ipe?extensions=com.jetbrains.php.testFrameworkType)      |`PhpTestFrameworkType` |
| [com.jetbrains.php.tools.quality.laravelPint.laravelPintConfigurationProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.tools.quality.laravelPint.laravelPintConfigurationProvider)      |`LaravelPintConfigurationProvider` |
| [com.jetbrains.php.tools.quality.messDetector.messDetectorConfigurationProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.tools.quality.messDetector.messDetectorConfigurationProvider)      |`MessDetectorConfigurationProvider` |
| [com.jetbrains.php.tools.quality.phpCSFixer.phpCSFixerConfigurationProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.tools.quality.phpCSFixer.phpCSFixerConfigurationProvider)      |`PhpCSFixerConfigurationProvider` |
| [com.jetbrains.php.tools.quality.phpcs.phpCSConfigurationProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.tools.quality.phpcs.phpCSConfigurationProvider)      |`PhpCSConfigurationProvider` |
| [com.jetbrains.php.tools.quality.type](https://jb.gg/ipe?extensions=com.jetbrains.php.tools.quality.type)      |`QualityToolType` |
| [com.jetbrains.php.typeInferenceExclusion](https://jb.gg/ipe?extensions=com.jetbrains.php.typeInferenceExclusion)      |`PhpTypeInferenceExclusion` |
| [com.jetbrains.php.typeProvider3](https://jb.gg/ipe?extensions=com.jetbrains.php.typeProvider3)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |`PhpTypeProvider3` |
| [com.jetbrains.php.typeProvider4](https://jb.gg/ipe?extensions=com.jetbrains.php.typeProvider4)      |`PhpTypeProvider4` |

### com.jetbrains.php.behat

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.php.behat.gherkinAttributePrefixProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.behat.gherkinAttributePrefixProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`GherkinAttributePrefixProvider` |
| [com.jetbrains.php.behat.gherkinContextProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.behat.gherkinContextProvider)      |`ContextInterfaceProvider` |

### com.jetbrains.php.blade

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.php.blade.bladeDirectiveContributor](https://jb.gg/ipe?extensions=com.jetbrains.php.blade.bladeDirectiveContributor)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`BladeDirectiveContributor` |

### com.jetbrains.php.framework

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.php.framework.descriptionProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.framework.descriptionProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`FrameworkDescriptionProvider` |

### intellij.php.frontback.impl.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.php.docTagParserExtension](https://jb.gg/ipe?extensions=com.intellij.php.docTagParserExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpDocTagParser` |

### org.jetbrains.plugins.phpstorm-remote-interpreter

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.php.remote.interpreter.ui.customConfigProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.remote.interpreter.ui.customConfigProvider)      |`PhpProjectConfigComponentProvider` |
| [com.jetbrains.php.remote.phpHelperScriptProvider](https://jb.gg/ipe?extensions=com.jetbrains.php.remote.phpHelperScriptProvider)      |`PhpHelperScriptProvider` |
| [com.jetbrains.php.remote.remoteProcessCoverageManager](https://jb.gg/ipe?extensions=com.jetbrains.php.remote.remoteProcessCoverageManager)      |`PhpRemoteProcessCoverageManager` |
| [com.jetbrains.php.remote.remoteProcessManager](https://jb.gg/ipe?extensions=com.jetbrains.php.remote.remoteProcessManager)      |`PhpRemoteProcessManager` |

### phpstorm-customization.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.webcore.phpFrameworkExclusionProvider](https://jb.gg/ipe?extensions=com.intellij.webcore.phpFrameworkExclusionProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`PhpFrameworkExclusionProvider` |

