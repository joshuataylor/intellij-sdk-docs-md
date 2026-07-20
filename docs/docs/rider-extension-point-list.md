# Rider Extension Point and Listener List

<tldr>
Product-Specific Plugin Development: [Rider](rider.html)

See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

168 Extension Points and 10 Listeners

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

## Rider

### Rider – Listeners

| Topic |Listener |
-------------------
| [RiderStyleCopConfigurable#STYLE_COP_CONFIGURABLE_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.application.options.editor.EditorOptionsListener) |[EditorOptionsListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-impl/src/com/intellij/application/options/editor/EditorOptionsListener.java) |
| [AzuriteSessionListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.rider.azureFunctions.azurite.services.AzuriteSessionListener) |`AzuriteSessionListener` |
| [SSHCredentialsInClipboardNotifier.Companion#SSH_CREDENTIALS_IN_CLIPBOARD_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.rider.debugger.attach.remoting.SSHCredentialsInClipboardNotifier) |`SSHCredentialsInClipboardNotifier` |
| [DotnetDebuggerSymbolsLoadedListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.rider.debugger.modulesView.actions.DotnetDebuggerSymbolsLoadedListener) |`DotnetDebuggerSymbolsLoadedListener` |
| [FrontendTypedHandlerManager#BEFORE_TYPING_SENT](https://jb.gg/ipe/listeners?topics=com.jetbrains.rider.editorActions.IFrontendTypingListener) |`IFrontendTypingListener` |
| [Tracker.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.rider.ideaInterop.vfs.VfsWarmQueue.Tracker) |`Tracker` |
| [AutoAttachDebuggerListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.rider.run.AutoAttachDebuggerListener) |`AutoAttachDebuggerListener` |
| [PublishConfigurationValidationListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.rider.run.configurations.publishing.PublishConfigurationValidationListener) |`PublishConfigurationValidationListener` |
| [MSBuildEvaluationListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.rider.run.environment.MSBuildEvaluationListener) |`MSBuildEvaluationListener` |
| [RiderGlobalBackendProgressListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.rider.services.RiderGlobalProgressHost.RiderGlobalBackendProgressListener) |`RiderGlobalBackendProgressListener` |

### com.intellij.rider.frontend.customization

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rdclient.rider.completion.helper](https://jb.gg/ipe?extensions=com.intellij.rdclient.rider.completion.helper)      |`CompletionHelper` |

### com.jetbrains.rider-cpp

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.rider-cpp.run.configurations.cpp](https://jb.gg/ipe?extensions=com.jetbrains.rider-cpp.run.configurations.cpp)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`CppConfigurationParametersExtension` |
| [com.jetbrains.rider-cpp.run.configurations.cpp.launch.profile](https://jb.gg/ipe?extensions=com.jetbrains.rider-cpp.run.configurations.cpp.launch.profile)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`CppProjectLaunchProfile` |
| [com.jetbrains.rider-cpp.run.configurations.cpp.platformInfoProvider](https://jb.gg/ipe?extensions=com.jetbrains.rider-cpp.run.configurations.cpp.platformInfoProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`CppPlatformInfoProvider` |
| [com.jetbrains.rider-cpp.run.configurations.cpp.platformPluginPromotion](https://jb.gg/ipe?extensions=com.jetbrains.rider-cpp.run.configurations.cpp.platformPluginPromotion)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`CppPlatformPluginPromotion` |
| [rider.cpp.debugProcessExtension](https://jb.gg/ipe?extensions=rider.cpp.debugProcessExtension)      |`RiderCppDebugProcessExtension` |

### com.jetbrains.rider.razor

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.blazorDialectSubstitutor](https://jb.gg/ipe?extensions=com.intellij.rider.blazorDialectSubstitutor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`BlazorHtmlDialectSubstitutor` |
| [com.intellij.rider.webTypingAssistClassifier](https://jb.gg/ipe?extensions=com.intellij.rider.webTypingAssistClassifier)      |`WebTypingAssistClassifier` |

### intellij.rider.cpp.core.projectModel.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.cpp.core.projectModel.radProjectFallbackConfigDisabler](https://jb.gg/ipe?extensions=com.intellij.rider.cpp.core.projectModel.radProjectFallbackConfigDisabler)      |`RadProjectFallbackConfigDisabler` |

### intellij.rider.cpp.core.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.cpp.file.system.items.support](https://jb.gg/ipe?extensions=com.intellij.rider.cpp.file.system.items.support)      |`CppFileSystemItemsSupport` |

### intellij.rider.cwm.core.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.client.typedHandler](https://jb.gg/ipe?extensions=com.intellij.rider.client.typedHandler)      |`RiderClientLookupTypedHandler` |

### intellij.rider.debugger.shared.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.debugger.filters.provider](https://jb.gg/ipe?extensions=com.intellij.rider.debugger.filters.provider)      |`RiderDebuggerFiltersProvider` |
| [com.intellij.rider.debugger.link.provider](https://jb.gg/ipe?extensions=com.intellij.rider.debugger.link.provider)      |`RiderDebuggerLinkProvider` |

### intellij.rider.dotnet.exception.reporter.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.credentials.provider](https://jb.gg/ipe?extensions=com.intellij.rider.credentials.provider)      |`ICredentialsProvider` |
| [com.intellij.rider.exception.reporter.additional.info](https://jb.gg/ipe?extensions=com.intellij.rider.exception.reporter.additional.info)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RiderExceptionReporterAdditionalInfo` |

### intellij.rider.plugins.appender.database.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.database.connectionStringRetriever](https://jb.gg/ipe?extensions=com.intellij.rider.database.connectionStringRetriever)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`DatabaseConnectionUrlRetriever` |
| [com.intellij.rider.database.connectionStringToJdbcUrlMapper](https://jb.gg/ipe?extensions=com.intellij.rider.database.connectionStringToJdbcUrlMapper)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ConnectionStringToJdbcUrlConverter` |
| [com.intellij.rider.database.connectionStringsFactory](https://jb.gg/ipe?extensions=com.intellij.rider.database.connectionStringsFactory)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ConnectionStringsFactory` |
| [com.intellij.rider.database.connectionStringsFinder](https://jb.gg/ipe?extensions=com.intellij.rider.database.connectionStringsFinder)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ConnectionStringsFinder` |
| [com.intellij.rider.database.dotnetDataProvider](https://jb.gg/ipe?extensions=com.intellij.rider.database.dotnetDataProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`DotnetDataProvider` |
| [com.intellij.rider.database.jdbcUrlToConnectionStringConverter](https://jb.gg/ipe?extensions=com.intellij.rider.database.jdbcUrlToConnectionStringConverter)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`JdbcUrlToConnectionStringConverter` |

### intellij.rider.plugins.appender.docker.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.dockerDebugProvider](https://jb.gg/ipe?extensions=com.intellij.rider.dockerDebugProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RiderDockerDebugProvider` |
| [com.intellij.rider.dockerDeploymentTransformer](https://jb.gg/ipe?extensions=com.intellij.rider.dockerDeploymentTransformer)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RiderDockerDeploymentTransformer` |

### intellij.rider.plugins.appender.javascript.xml

| Extension Point |Implementation |
-----------------------------------
| [JavaScript.packageJson.configuration.handler](https://jb.gg/ipe?extensions=JavaScript.packageJson.configuration.handler)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RiderPackageJsonConfiguratorHandler` |

### intellij.rider.plugins.cpp.debugger.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.cpp.debuggerSettings](https://jb.gg/ipe?extensions=com.intellij.rider.cpp.debuggerSettings)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`CppDebuggerSettings` |

### intellij.rider.plugins.debuggerGrid.core.backend.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.plugins.debuggerGrid.core.backend.collectionAccessorProvider](https://jb.gg/ipe?extensions=com.intellij.rider.plugins.debuggerGrid.core.backend.collectionAccessorProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`RiderCollectionAccessorProvider` |

### intellij.rider.plugins.dotTrace.dotMemory.core.xml

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.dotTrace.dotMemory.runtime.detector](https://jb.gg/ipe?extensions=com.jetbrains.dotTrace.dotMemory.runtime.detector)      |`DotTraceRuntimeDetector` |

### intellij.rider.rdclient.dotnet.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.backend.actions.support](https://jb.gg/ipe?extensions=com.intellij.backend.actions.support)      |`RiderActionSupportPolicy` |
| [com.intellij.backend.auto.import.support](https://jb.gg/ipe?extensions=com.intellij.backend.auto.import.support)      |`RiderAutoImportSupportPolicy` |
| [com.intellij.backend.autoPopup.support](https://jb.gg/ipe?extensions=com.intellij.backend.autoPopup.support)      |`RiderAutoPopupSupportPolicy` |
| [com.intellij.backend.markup.adapterFactory](https://jb.gg/ipe?extensions=com.intellij.backend.markup.adapterFactory)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`FrontendMarkupAdapterFactory` |
| [com.intellij.backend.typedHandler](https://jb.gg/ipe?extensions=com.intellij.backend.typedHandler)      |`FrontendTypedHandler` |
| [com.intellij.completion.completionSessionStrategy](https://jb.gg/ipe?extensions=com.intellij.completion.completionSessionStrategy)      |`CompletionSessionStrategy` |
| [com.intellij.editor.action.execution.policy](https://jb.gg/ipe?extensions=com.intellij.editor.action.execution.policy)      |`RiderEditorActionPolicy` |
| [com.intellij.frontend.completion.helper](https://jb.gg/ipe?extensions=com.intellij.frontend.completion.helper)      |`ICompletionHelper` |
| [com.intellij.lang.altEnter](https://jb.gg/ipe?extensions=com.intellij.lang.altEnter)      |`BulbMenuModelFactory` |
| [com.intellij.lang.altEnter.popupModelDelegate](https://jb.gg/ipe?extensions=com.intellij.lang.altEnter.popupModelDelegate)      |`PopupModelDelegate` |
| [com.intellij.navbar.members.support](https://jb.gg/ipe?extensions=com.intellij.navbar.members.support)      |`RiderNavBarMembersSupport` |
| [com.intellij.projectModelViewUpdater](https://jb.gg/ipe?extensions=com.intellij.projectModelViewUpdater)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ProjectModelViewUpdater` |
| [com.intellij.rdclient.actionsDataContextProvider](https://jb.gg/ipe?extensions=com.intellij.rdclient.actionsDataContextProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`FrontendActionsDataContextProvider` |
| [com.intellij.rdclient.preemptiveCompletionSuppressor](https://jb.gg/ipe?extensions=com.intellij.rdclient.preemptiveCompletionSuppressor)      |`PreemptiveCompletionSuppressor` |
| [com.intellij.rdclient.typingPolicy](https://jb.gg/ipe?extensions=com.intellij.rdclient.typingPolicy)      |`CustomTypingSessionPolicy` |
| [com.intellij.rider.action.fallback.strategy](https://jb.gg/ipe?extensions=com.intellij.rider.action.fallback.strategy)      |`RiderAsyncBackendDelegatingActionFallbackStrategy` |
| [com.intellij.rider.additionalQuickDocProvider](https://jb.gg/ipe?extensions=com.intellij.rider.additionalQuickDocProvider)      |`AdditionalQuickDocProvider` |
| [com.intellij.rider.altEnter.layouter](https://jb.gg/ipe?extensions=com.intellij.rider.altEnter.layouter)      |`RiderAltEnterLayouter` |
| [com.intellij.rider.backendCompletionAppliedHandler](https://jb.gg/ipe?extensions=com.intellij.rider.backendCompletionAppliedHandler)      |`IRiderBackendCompletionAppliedHandler` |
| [com.intellij.rider.backendCrashAnalyser](https://jb.gg/ipe?extensions=com.intellij.rider.backendCrashAnalyser)      |`BackendCrashAnalyzer` |
| [com.intellij.rider.backendLogXmlPathProvider](https://jb.gg/ipe?extensions=com.intellij.rider.backendLogXmlPathProvider)      |`RiderCustomBackendLogXmlPathProvider` |
| [com.intellij.rider.codeStyleContentConverter](https://jb.gg/ipe?extensions=com.intellij.rider.codeStyleContentConverter)      |`RiderCodeStyleContentPageConverter` |
| [com.intellij.rider.customNonSolutionRootsPredicate](https://jb.gg/ipe?extensions=com.intellij.rider.customNonSolutionRootsPredicate)      |`CustomNonSolutionRootsPredicate` |
| [com.intellij.rider.documentBehaviour](https://jb.gg/ipe?extensions=com.intellij.rider.documentBehaviour)      |`RiderDocumentBehaviour` |
| [com.intellij.rider.editors.customBackendLanguageSupport](https://jb.gg/ipe?extensions=com.intellij.rider.editors.customBackendLanguageSupport)      |`RiderCustomBackendLanguageSupport` |
| [com.intellij.rider.extraSettingsSync](https://jb.gg/ipe?extensions=com.intellij.rider.extraSettingsSync)      |`ExtraSettingsSync` |
| [com.intellij.rider.fileBreadcrumbExtensions](https://jb.gg/ipe?extensions=com.intellij.rider.fileBreadcrumbExtensions)      |`CustomFileBreadcrumbExtensions` |
| [com.intellij.rider.grave.filter](https://jb.gg/ipe?extensions=com.intellij.rider.grave.filter)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`RiderHighlightingGraveFilter` |
| [com.intellij.rider.ideaInspectionBackendSuppressionSupport](https://jb.gg/ipe?extensions=com.intellij.rider.ideaInspectionBackendSuppressionSupport)      |`IdeaInspectionBackendSuppressionSupport` |
| [com.intellij.rider.namingPageProvider](https://jb.gg/ipe?extensions=com.intellij.rider.namingPageProvider)      |`NamingPageProvider` |
| [com.intellij.rider.projectModelIconProvider](https://jb.gg/ipe?extensions=com.intellij.rider.projectModelIconProvider)      |`ProjectModelIconProvider` |
| [com.intellij.rider.protocol.hostEnvProvider](https://jb.gg/ipe?extensions=com.intellij.rider.protocol.hostEnvProvider)      |`RiderBackendEnvProvider` |
| [com.intellij.rider.riderApplicationPreloadListener](https://jb.gg/ipe?extensions=com.intellij.rider.riderApplicationPreloadListener)      |`RiderApplicationPreloadListener` |
| [com.intellij.rider.riderRemoteEnvironmentDeploymentProvider](https://jb.gg/ipe?extensions=com.intellij.rider.riderRemoteEnvironmentDeploymentProvider)      |`RiderRemoteEnvironmentDeploymentProvider` |
| [com.intellij.rider.settings.synchronizer.listener](https://jb.gg/ipe?extensions=com.intellij.rider.settings.synchronizer.listener)      |`SettingSynchronizerListener` |
| [com.intellij.rider.settings.test.maintenance.listener](https://jb.gg/ipe?extensions=com.intellij.rider.settings.test.maintenance.listener)      |`RiderSettingsTestMaintenanceControllerListener` |
| [com.intellij.rider.smartTabsBackendSynchronizer](https://jb.gg/ipe?extensions=com.intellij.rider.smartTabsBackendSynchronizer)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderSmartTabsBackendSynchronizer` |
| [com.intellij.rider.startupListener](https://jb.gg/ipe?extensions=com.intellij.rider.startupListener)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RiderInitialStartupListener` |
| [com.intellij.rider.workspaceCountableProjectsPolicy](https://jb.gg/ipe?extensions=com.intellij.rider.workspaceCountableProjectsPolicy)      |`CountableProjectsPolicy` |
| [com.intellij.selfProfilingPaths.customizer](https://jb.gg/ipe?extensions=com.intellij.selfProfilingPaths.customizer)      |`DotnetSelfProfilerPathsCustomizer` |
| [com.intellij.solutionLoadNotification](https://jb.gg/ipe?extensions=com.intellij.solutionLoadNotification)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`SolutionLoadNotification` |
| [com.intellij.typing.policy](https://jb.gg/ipe?extensions=com.intellij.typing.policy)      |`RiderTypingPolicy` |

### intellij.rider.rdclient.languages.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.rdclient.breakingWorkflowChangeInterceptor](https://jb.gg/ipe?extensions=com.intellij.rider.rdclient.breakingWorkflowChangeInterceptor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RiderBreakingWorkflowChangeInterceptor` |

### intellij.rider.ssh.remoteMac.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.multiplatform.remoteConfiguratorStep](https://jb.gg/ipe?extensions=com.intellij.rider.multiplatform.remoteConfiguratorStep)      |`ConfiguratorStep` |

### RiderDebugger.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.dotNetHotReloadFileTypeProvider](https://jb.gg/ipe?extensions=com.intellij.dotNetHotReloadFileTypeProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`DotNetHotReloadFileTypeProvider` |
| [com.intellij.rider.debugger.evaluation.advice](https://jb.gg/ipe?extensions=com.intellij.rider.debugger.evaluation.advice)      |`DebugEvalAdviceProvider` |
| [com.intellij.rider.debugger.remote.additionalFilesProvider](https://jb.gg/ipe?extensions=com.intellij.rider.debugger.remote.additionalFilesProvider)      |`AdditionalRemoteDebuggerFilesProvider` |
| [com.intellij.rider.debugger.remoteAttachSupport](https://jb.gg/ipe?extensions=com.intellij.rider.debugger.remoteAttachSupport)      |`RiderRemoteAttachSupport` |

### RiderExtensionPoints.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.fileSystemExplorerCustomization](https://jb.gg/ipe?extensions=com.intellij.fileSystemExplorerCustomization)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`FileSystemExplorerCustomization` |
| [com.intellij.moveProviderExtension](https://jb.gg/ipe?extensions=com.intellij.moveProviderExtension)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`MoveProviderExtension` |
| [com.intellij.nestingRulesLanguageExtensions](https://jb.gg/ipe?extensions=com.intellij.nestingRulesLanguageExtensions)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderNestingRulesLanguageExtensions` |
| [com.intellij.nugetCredentialProvider](https://jb.gg/ipe?extensions=com.intellij.nugetCredentialProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`NuGetCredentialProvider` |
| [com.intellij.openDirectoryExtensions](https://jb.gg/ipe?extensions=com.intellij.openDirectoryExtensions)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`OpenDirectoryExtensions` |
| [com.intellij.projectModelViewExtensions](https://jb.gg/ipe?extensions=com.intellij.projectModelViewExtensions)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ProjectModelViewExtensions` |
| [com.intellij.projectTemplateCustomizer](https://jb.gg/ipe?extensions=com.intellij.projectTemplateCustomizer)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`ProjectTemplateCustomizer` |
| [com.intellij.projectTemplateDialogProvider](https://jb.gg/ipe?extensions=com.intellij.projectTemplateDialogProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`ProjectTemplateDialogProvider` |
| [com.intellij.projectTemplateProviderNew](https://jb.gg/ipe?extensions=com.intellij.projectTemplateProviderNew)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`ProjectTemplateProvider` |
| [com.intellij.rider.ProjectTypesProvider](https://jb.gg/ipe?extensions=com.intellij.rider.ProjectTypesProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderProjectTypesProvider` |
| [com.intellij.rider.SolutionFileTypesProvider](https://jb.gg/ipe?extensions=com.intellij.rider.SolutionFileTypesProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`SolutionFileTypesProvider` |
| [com.intellij.rider.action.technical.support.info.provider](https://jb.gg/ipe?extensions=com.intellij.rider.action.technical.support.info.provider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderTechnicalSupportInfoProvider` |
| [com.intellij.rider.breakpoint.customPanelProvider](https://jb.gg/ipe?extensions=com.intellij.rider.breakpoint.customPanelProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`IDotNetLineBreakpointCustomPanelsProvider` |
| [com.intellij.rider.breakpoint.customPopupActionsProvider](https://jb.gg/ipe?extensions=com.intellij.rider.breakpoint.customPopupActionsProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`IDotNetLineBreakpointPopupActionsProvider` |
| [com.intellij.rider.build.riderBuildErrorExplainService](https://jb.gg/ipe?extensions=com.intellij.rider.build.riderBuildErrorExplainService)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RiderBuildErrorExplainService` |
| [com.intellij.rider.buildButtonModeProvider](https://jb.gg/ipe?extensions=com.intellij.rider.buildButtonModeProvider)      |`BuildButtonModeProvider` |
| [com.intellij.rider.codeLens.vcsDeclarationRangesProvider](https://jb.gg/ipe?extensions=com.intellij.rider.codeLens.vcsDeclarationRangesProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`VcsDeclarationRangesProvider` |
| [com.intellij.rider.completion.csharpIdentifierPartHelper](https://jb.gg/ipe?extensions=com.intellij.rider.completion.csharpIdentifierPartHelper)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`CSharpIdentifierPartHelper` |
| [com.intellij.rider.completion.preselectionStrategy](https://jb.gg/ipe?extensions=com.intellij.rider.completion.preselectionStrategy)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderFrontendLanguagesPreselectionStrategy` |
| [com.intellij.rider.configurationExecutorExtension](https://jb.gg/ipe?extensions=com.intellij.rider.configurationExecutorExtension)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RiderConfigurationExecutorExtension` |
| [com.intellij.rider.configurationLaunchSettingsExtension](https://jb.gg/ipe?extensions=com.intellij.rider.configurationLaunchSettingsExtension)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RiderConfigurationLaunchSettingsExtension` |
| [com.intellij.rider.consoleFilter](https://jb.gg/ipe?extensions=com.intellij.rider.consoleFilter)      |`RiderConsoleFilterExtension` |
| [com.intellij.rider.contributedLanguageElementNameCrawler](https://jb.gg/ipe?extensions=com.intellij.rider.contributedLanguageElementNameCrawler)      |`RiderContributedLanguageElementNameCrawler` |
| [com.intellij.rider.debug.breakpoint.handler.factory](https://jb.gg/ipe?extensions=com.intellij.rider.debug.breakpoint.handler.factory)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`IDotNetSupportedBreakpointHandlerFactory` |
| [com.intellij.rider.debugger.editAndContinue.dotNetEncInfoAutodetect](https://jb.gg/ipe?extensions=com.intellij.rider.debugger.editAndContinue.dotNetEncInfoAutodetect)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`DotNetEncInfoAutodetect` |
| [com.intellij.rider.debugger.value.presenter](https://jb.gg/ipe?extensions=com.intellij.rider.debugger.value.presenter)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderDebuggerValuePresenter` |
| [com.intellij.rider.debuggerSupportPolicy](https://jb.gg/ipe?extensions=com.intellij.rider.debuggerSupportPolicy)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderDebuggerSupportPolicy` |
| [com.intellij.rider.editSourceSuppressor](https://jb.gg/ipe?extensions=com.intellij.rider.editSourceSuppressor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderEditSourceSuppressor` |
| [com.intellij.rider.extendedCodeStructure](https://jb.gg/ipe?extensions=com.intellij.rider.extendedCodeStructure)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderExtendedFileStructure` |
| [com.intellij.rider.externalDirectoryProvider](https://jb.gg/ipe?extensions=com.intellij.rider.externalDirectoryProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ExternalDirectoryProvider` |
| [com.intellij.rider.fileTemplating.postCreateAction](https://jb.gg/ipe?extensions=com.intellij.rider.fileTemplating.postCreateAction)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RiderNewFileFromTemplateExtension` |
| [com.intellij.rider.filesIndexingRuleProvider](https://jb.gg/ipe?extensions=com.intellij.rider.filesIndexingRuleProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderFilesIndexingRuleProvider` |
| [com.intellij.rider.findPopupProjectScopeProvider](https://jb.gg/ipe?extensions=com.intellij.rider.findPopupProjectScopeProvider)      |`FindPopupProjectScopeProvider` |
| [com.intellij.rider.gameEngineAssetIndexProvider](https://jb.gg/ipe?extensions=com.intellij.rider.gameEngineAssetIndexProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`IGameEngineAssetIndexProvider` |
| [com.intellij.rider.gameEngineSceneProvider](https://jb.gg/ipe?extensions=com.intellij.rider.gameEngineSceneProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`IGameEngineSceneProvider` |
| [com.intellij.rider.gameEngineScreenshotProvider](https://jb.gg/ipe?extensions=com.intellij.rider.gameEngineScreenshotProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`IGameEngineScreenshotProvider` |
| [com.intellij.rider.gameEngineViewportCameraProvider](https://jb.gg/ipe?extensions=com.intellij.rider.gameEngineViewportCameraProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`IGameEngineViewportCameraProvider` |
| [com.intellij.rider.godotDetector](https://jb.gg/ipe?extensions=com.intellij.rider.godotDetector)      |`GodotDetector` |
| [com.intellij.rider.gotoCustomizer](https://jb.gg/ipe?extensions=com.intellij.rider.gotoCustomizer)      |`GotoCustomizer` |
| [com.intellij.rider.guidPresenter](https://jb.gg/ipe?extensions=com.intellij.rider.guidPresenter)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`GuidGeneratorPresenter` |
| [com.intellij.rider.newFileListener](https://jb.gg/ipe?extensions=com.intellij.rider.newFileListener)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RiderNewFileListener` |
| [com.intellij.rider.newRunConfigurationTreeGroupingProvider](https://jb.gg/ipe?extensions=com.intellij.rider.newRunConfigurationTreeGroupingProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderNewRunConfigurationTreeGroupingProvider` |
| [com.intellij.rider.patchCommandLine](https://jb.gg/ipe?extensions=com.intellij.rider.patchCommandLine)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`PatchCommandLineExtension` |
| [com.intellij.rider.pencils.filters.provider](https://jb.gg/ipe?extensions=com.intellij.rider.pencils.filters.provider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`PencilsFiltersProvider` |
| [com.intellij.rider.pencils.inspectionToolGroup](https://jb.gg/ipe?extensions=com.intellij.rider.pencils.inspectionToolGroup)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`n/a` |
| [com.intellij.rider.pencils.pencilsFilterGroup](https://jb.gg/ipe?extensions=com.intellij.rider.pencils.pencilsFilterGroup)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`n/a` |
| [com.intellij.rider.problemsView.actionsHandler](https://jb.gg/ipe?extensions=com.intellij.rider.problemsView.actionsHandler)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderProblemsViewActionsHandler` |
| [com.intellij.rider.problemsView.problemTypeContributor](https://jb.gg/ipe?extensions=com.intellij.rider.problemsView.problemTypeContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderProblemsViewTypeUiProvider` |
| [com.intellij.rider.problemsView.problems.notifier](https://jb.gg/ipe?extensions=com.intellij.rider.problemsView.problems.notifier)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`ProblemsViewNotifier` |
| [com.intellij.rider.problemsView.problems.processor](https://jb.gg/ipe?extensions=com.intellij.rider.problemsView.problems.processor)      |`RiderProblemsDiffProcessor` |
| [com.intellij.rider.problemsView.safeCode.inspectionProblemContributor](https://jb.gg/ipe?extensions=com.intellij.rider.problemsView.safeCode.inspectionProblemContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderSafeCodeInspectionProblemContributor` |
| [com.intellij.rider.publish.publishSettingsProvider](https://jb.gg/ipe?extensions=com.intellij.rider.publish.publishSettingsProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`IPublishRuntimeCoreSettingsProvider` |
| [com.intellij.rider.publishConfigurationProvider](https://jb.gg/ipe?extensions=com.intellij.rider.publishConfigurationProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderContextPublishProvider` |
| [com.intellij.rider.reader.mode.matcher](https://jb.gg/ipe?extensions=com.intellij.rider.reader.mode.matcher)      |`RiderCustomReaderModeMatcher` |
| [com.intellij.rider.refactoringPageProvider](https://jb.gg/ipe?extensions=com.intellij.rider.refactoringPageProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RefactoringPageProvider` |
| [com.intellij.rider.resolveContextWidgetProvider](https://jb.gg/ipe?extensions=com.intellij.rider.resolveContextWidgetProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderResolveContextWidgetProvider` |
| [com.intellij.rider.run.configurations.dotNetExe](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.dotNetExe)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`DotNetExeConfigurationExtension` |
| [com.intellij.rider.run.configurations.externalRunConfigurationGenerator](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.externalRunConfigurationGenerator)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ExternalRunConfigurationGeneratorExtension` |
| [com.intellij.rider.run.configurations.host](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.host)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RunConfigurationHostExtensions` |
| [com.intellij.rider.run.configurations.host.executor](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.host.executor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RunConfigurationHostExecutorExtensions` |
| [com.intellij.rider.run.configurations.launchSettings](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.launchSettings)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`LaunchSettingsConfigurationExtension` |
| [com.intellij.rider.run.configurations.launchSettings.command](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.launchSettings.command)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`LaunchSettingsCommandExtension` |
| [com.intellij.rider.run.configurations.launchSettings.generator](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.launchSettings.generator)      |`LaunchSettingsConfigGeneratorExtension` |
| [com.intellij.rider.run.configurations.multiPlatform.mac.extension](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.multiPlatform.mac.extension)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`MacRunConfigurationExtension` |
| [com.intellij.rider.run.configurations.project](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.project)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`DotNetProjectConfigurationExtension` |
| [com.intellij.rider.run.configurations.riderCoreDumpConfigurationProvider](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.riderCoreDumpConfigurationProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderCoreDumpConfigurationProvider` |
| [com.intellij.rider.run.configurations.uwp](https://jb.gg/ipe?extensions=com.intellij.rider.run.configurations.uwp)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`UwpConfigurationExtension` |
| [com.intellij.rider.runToPopupShowPolicy](https://jb.gg/ipe?extensions=com.intellij.rider.runToPopupShowPolicy)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RiderRunToPopupShowPolicy` |
| [com.intellij.rider.runWidgetSuspenderExtension](https://jb.gg/ipe?extensions=com.intellij.rider.runWidgetSuspenderExtension)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RunWidgetSuspenderExtension` |
| [com.intellij.rider.runtime.dotNetRuntimeAutodetect](https://jb.gg/ipe?extensions=com.intellij.rider.runtime.dotNetRuntimeAutodetect)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`DotNetRuntimeAutodetect` |
| [com.intellij.rider.solutionConfigurationPresenter](https://jb.gg/ipe?extensions=com.intellij.rider.solutionConfigurationPresenter)      |`SolutionConfigurationPresenter` |
| [com.intellij.rider.solutionConfigurationToolbarCustomizer](https://jb.gg/ipe?extensions=com.intellij.rider.solutionConfigurationToolbarCustomizer)      |`SolutionConfigurationToolbarCustomizer` |
| [com.intellij.rider.ui.toolwindow.contentProvider](https://jb.gg/ipe?extensions=com.intellij.rider.ui.toolwindow.contentProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`RiderToolWindowContentProviderExtension` |
| [com.intellij.rider.unitTesting.actionsProvider](https://jb.gg/ipe?extensions=com.intellij.rider.unitTesting.actionsProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RiderUnitTestActionsProvider` |
| [com.intellij.rider.unitTesting.sessionHandler](https://jb.gg/ipe?extensions=com.intellij.rider.unitTesting.sessionHandler)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`IRiderUnitTestDebuggerSessionsHandler` |
| [com.intellij.rider.unityDetector](https://jb.gg/ipe?extensions=com.intellij.rider.unityDetector)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`UnityDetector` |
| [com.intellij.rider.vfsToProjectModelEventsCustomizer](https://jb.gg/ipe?extensions=com.intellij.rider.vfsToProjectModelEventsCustomizer)      |`VfsToProjectModelEventsCustomizer` |
| [com.intellij.rider.web.extensions.companionDebugStarter](https://jb.gg/ipe?extensions=com.intellij.rider.web.extensions.companionDebugStarter)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`DotNetCompanionDebugStarter` |
| [com.intellij.rider.web.extensions.webBrowserDebugSupport](https://jb.gg/ipe?extensions=com.intellij.rider.web.extensions.webBrowserDebugSupport)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`WebBrowserDebugSupport` |
| [com.intellij.rider.writingAccessProvider](https://jb.gg/ipe?extensions=com.intellij.rider.writingAccessProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`RiderDebugWritingAccessProvider` |
| [com.intellij.rider.xaml.preview.editor](https://jb.gg/ipe?extensions=com.intellij.rider.xaml.preview.editor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`XamlPreviewEditorExtension` |
| [com.intellij.solutionExplorerCustomization](https://jb.gg/ipe?extensions=com.intellij.solutionExplorerCustomization)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`SolutionExplorerCustomization` |
| [com.intellij.solutionExplorerRootProvider](https://jb.gg/ipe?extensions=com.intellij.solutionExplorerRootProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`SolutionExplorerRootProvider` |
| [com.intellij.solutionManagerExtensions](https://jb.gg/ipe?extensions=com.intellij.solutionManagerExtensions)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`SolutionManagerExtensions` |
| [com.intellij.solutionViewPsiNodeNavigator](https://jb.gg/ipe?extensions=com.intellij.solutionViewPsiNodeNavigator)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`SolutionViewPsiNodeNavigator` |
| [com.jetbrains.rider.projectFileIndexAugmentor](https://jb.gg/ipe?extensions=com.jetbrains.rider.projectFileIndexAugmentor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ProjectFileIndexAugmentor` |

### RiderMultiPlatform.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.android.ndk.provider](https://jb.gg/ipe?extensions=com.intellij.rider.android.ndk.provider)      |`AndroidNdkPathProvider` |
| [com.intellij.rider.runConfigurationHandler](https://jb.gg/ipe?extensions=com.intellij.rider.runConfigurationHandler)      |`RunConfigurationHandlerBase` |

### RiderNuGet.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.nuget.actions.riderNuGetQuickListActionContributor](https://jb.gg/ipe?extensions=com.intellij.rider.nuget.actions.riderNuGetQuickListActionContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`RiderNuGetQuickListActionContributor` |

### RiderReformatAndCleanup.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.code.cleanup.support](https://jb.gg/ipe?extensions=com.intellij.code.cleanup.support)      |`RiderCodeCleanupSupportPolicy` |
| [com.intellij.rider.ProfileActionPrinter](https://jb.gg/ipe?extensions=com.intellij.rider.ProfileActionPrinter)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`ProfileActionPrinter` |
| [com.intellij.rider.cleanupAction](https://jb.gg/ipe?extensions=com.intellij.rider.cleanupAction)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`CleanupAction` |

### RiderSettingsSync.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.rider.settings.machineDependentBackendSetting](https://jb.gg/ipe?extensions=com.intellij.rider.settings.machineDependentBackendSetting)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`n/a` |

