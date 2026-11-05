# IntelliJ Platform Plugins Extension Point and Listener List

<tldr>
See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

IntelliJ Platform version: 2026.3.

708 Extension Points and 86 Listeners

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

## IntelliJ OSS Plugins

### IntelliJ OSS Plugins – Listeners

| Topic |Listener |
-------------------
| [CoverageLoadingListener#COVERAGE_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.coverage.CoverageLoadingListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CoverageLoadingListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/coverage-common/src/com/intellij/coverage/CoverageLoaderListener.kt) |
| [ExecutionEventsBus#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.execution.multilaunch.execution.messaging.ExecutionNotifier) |[ExecutionNotifier](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/execution-multilaunch/core/src/com/intellij/execution/multilaunch/execution/messaging/ExecutionNotifier.kt) |
| [ToolCallListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.mcpserver.ToolCallListener) |[ToolCallListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/ToolCallListener.kt) |
| [ChangeListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.mermaid.settings.MermaidSettingsConfigurable.ChangeListener) |[ChangeListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mermaid/src/com/intellij/mermaid/settings/MermaidSettingsConfigurable.kt) |

### ByteCodeViewer

[ByteCodeViewer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ByteCodeViewer/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [ByteCodeViewer.classFileFinder](https://jb.gg/ipe?extensions=ByteCodeViewer.classFileFinder)      |[BytecodeViewerClassFileFinder](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ByteCodeViewer/src/com/intellij/byteCodeViewer/BytecodeViewerClassFileFinder.kt) |
| [ByteCodeViewer.classSearcher](https://jb.gg/ipe?extensions=ByteCodeViewer.classSearcher)      |[ClassSearcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ByteCodeViewer/src/com/intellij/byteCodeViewer/ClassSearcher.kt) |

### com.intellij.completion.ml.ranking

[com.intellij.completion.ml.ranking](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/completion-ml-ranking/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.completion.ml.additionalContextFeatures](https://jb.gg/ipe?extensions=com.intellij.completion.ml.additionalContextFeatures)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[AdditionalContextFeatureProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/completion-ml-ranking/src/com/intellij/completion/ml/sorting/AdditionalContextFeatureProvider.java) |
| [com.intellij.completion.ml.elementIdProvider](https://jb.gg/ipe?extensions=com.intellij.completion.ml.elementIdProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[LookupElementIdProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/completion-ml-ranking/src/com/intellij/completion/ml/util/LookupElementIdProvider.kt) |
| [com.intellij.completion.ml.experimentFetcher](https://jb.gg/ipe?extensions=com.intellij.completion.ml.experimentFetcher)      |[MLRankingExperimentFetcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/completion-ml-ranking/src/com/intellij/completion/ml/experiments/MLRankingExperimentFetcher.kt) |
| [com.intellij.completion.ml.featuresOverride](https://jb.gg/ipe?extensions=com.intellij.completion.ml.featuresOverride)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[RankingFeaturesOverrides](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/completion-ml-ranking/src/com/intellij/completion/ml/features/RankingFeaturesOverrides.kt) |
| [com.intellij.completion.ml.localModelProvider](https://jb.gg/ipe?extensions=com.intellij.completion.ml.localModelProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[LocalZipModelProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/completion-ml-ranking/src/com/intellij/completion/ml/ranker/local/LocalZipModelProvider.kt) |
| [com.intellij.completion.ml.lookupFeatures](https://jb.gg/ipe?extensions=com.intellij.completion.ml.lookupFeatures)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[LookupFeatureProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/completion-ml-ranking/src/com/intellij/completion/ml/sorting/LookupFeatureProvider.java) |
| [com.intellij.completion.ml.ranking.features.policy](https://jb.gg/ipe?extensions=com.intellij.completion.ml.ranking.features.policy)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[CompletionFeaturesPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/completion-ml-ranking/src/com/intellij/completion/ml/features/CompletionFeaturesPolicy.kt) |
| [com.intellij.completion.ml.ranking.policy](https://jb.gg/ipe?extensions=com.intellij.completion.ml.ranking.policy)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[CompletionMLPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/completion-ml-ranking/src/com/intellij/completion/ml/CompletionMLPolicy.kt) |

### com.intellij.copyright

[com.intellij.copyright](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/copyright/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.copyright.updater](https://jb.gg/ipe?extensions=com.intellij.copyright.updater)      |[UpdateCopyrightsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/copyright/src/com/maddyhome/idea/copyright/psi/UpdateCopyrightsProvider.java) |
| [com.intellij.copyright.variablesProvider](https://jb.gg/ipe?extensions=com.intellij.copyright.variablesProvider)      |[CopyrightVariablesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/copyright/src/com/maddyhome/idea/copyright/pattern/CopyrightVariablesProvider.java) |

### com.intellij.java-i18n

[com.intellij.java-i18n](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/java-i18n/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.java-i18n.i18nizeHandlerProvider](https://jb.gg/ipe?extensions=com.intellij.java-i18n.i18nizeHandlerProvider)      |[I18nizeHandlerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/java-i18n/src/com/intellij/codeInspection/i18n/I18nizeHandlerProvider.java) |
| [com.intellij.java-i18n.resourceBundleManager](https://jb.gg/ipe?extensions=com.intellij.java-i18n.resourceBundleManager)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ResourceBundleManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/java-i18n/src/com/intellij/lang/properties/psi/ResourceBundleManager.java) |

### com.intellij.mermaid

[com.intellij.mermaid](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mermaid/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.mermaid.syntaxValidator](https://jb.gg/ipe?extensions=com.intellij.mermaid.syntaxValidator)      |[MermaidSyntaxValidator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mermaid/src/com/intellij/mermaid/lang/validation/MermaidSyntaxValidator.kt) |

### com.intellij.searcheverywhere.ml

[com.intellij.searcheverywhere.ml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/search-everywhere-ml/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.searchEverywhereMl.textEmbeddingProvider](https://jb.gg/ipe?extensions=com.intellij.searchEverywhereMl.textEmbeddingProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TextEmbeddingProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/search-everywhere-ml/src/com/intellij/searchEverywhereMl/TextEmbeddingProvider.kt) |

### com.intellij.stats.completion

[com.intellij.stats.completion](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/stats-collector/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.stats.completion.policy](https://jb.gg/ipe?extensions=com.intellij.stats.completion.policy)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[CompletionStatsPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/stats-collector/src/com/intellij/stats/completion/CompletionStatsPolicy.kt) |

### com.intellij.tasks

[com.intellij.tasks](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/tasks/tasks-core/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.tasks.commitPlaceholderProvider](https://jb.gg/ipe?extensions=com.intellij.tasks.commitPlaceholderProvider)      |[CommitPlaceholderProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/tasks-platform-api/src/com/intellij/tasks/CommitPlaceholderProvider.java) |
| [com.intellij.tasks.dialogPanelProvider](https://jb.gg/ipe?extensions=com.intellij.tasks.dialogPanelProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[TaskDialogPanelProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/tasks/tasks-api/src/com/intellij/tasks/ui/TaskDialogPanelProvider.java) |

### com.intellij.turboComplete

[com.intellij.turboComplete](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/turboComplete/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.turboComplete.analysis.pipelineListener](https://jb.gg/ipe?extensions=com.intellij.turboComplete.analysis.pipelineListener)      |[PipelineListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/turboComplete/src/com/intellij/turboComplete/analysis/PipelineListener.kt) |
| [com.intellij.turboComplete.features.kind.provider](https://jb.gg/ipe?extensions=com.intellij.turboComplete.features.kind.provider)      |[KindFeatureProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/turboComplete/src/com/intellij/turboComplete/features/kind/KindFeatureProvider.kt) |
| [com.intellij.turboComplete.kindCollector](https://jb.gg/ipe?extensions=com.intellij.turboComplete.kindCollector)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[KindCollector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/ml-impl/src/com/intellij/platform/ml/impl/turboComplete/KindCollector.kt) |
| [com.intellij.turboComplete.suggestionGeneratorExecutorProvider](https://jb.gg/ipe?extensions=com.intellij.turboComplete.suggestionGeneratorExecutorProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[SuggestionGeneratorExecutorProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/ml-impl/src/com/intellij/platform/ml/impl/turboComplete/SuggestionGeneratorExecutorProvider.kt) |

### com.intellij.uiDesigner

[com.intellij.uiDesigner](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ui-designer/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.paletteItemProvider](https://jb.gg/ipe?extensions=com.intellij.paletteItemProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[PaletteItemProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ui-designer/src/com/intellij/ide/palette/PaletteItemProvider.java) |
| [com.intellij.uiDesigner.formInspectionTool](https://jb.gg/ipe?extensions=com.intellij.uiDesigner.formInspectionTool)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[FormInspectionTool](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ui-designer/src/com/intellij/uiDesigner/inspections/FormInspectionTool.java) |

### com.jetbrains.filePrediction

[com.jetbrains.filePrediction](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/filePrediction/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.filePrediction.candidateProvider](https://jb.gg/ipe?extensions=com.intellij.filePrediction.candidateProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[FilePredictionCandidateProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/filePrediction/src/com/intellij/filePrediction/candidates/FilePredictionCandidateProvider.kt) |
| [com.intellij.filePrediction.featureProvider](https://jb.gg/ipe?extensions=com.intellij.filePrediction.featureProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[FilePredictionFeatureProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/filePrediction/src/com/intellij/filePrediction/features/FilePredictionFeatureProvider.kt) |
| [com.intellij.filePrediction.ml.model](https://jb.gg/ipe?extensions=com.intellij.filePrediction.ml.model)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[FilePredictionModelProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/filePrediction/src/com/intellij/filePrediction/predictor/model/FilePredictionModelProvider.kt) |
| [com.intellij.filePrediction.referencesProvider](https://jb.gg/ipe?extensions=com.intellij.filePrediction.referencesProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[FileExternalReferencesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/filePrediction/src/com/intellij/filePrediction/references/FilePredictionReferencesHelper.kt) |

### com.jetbrains.performancePlugin

[com.jetbrains.performancePlugin](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/performanceTesting/core/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.performancePlugin.commandProvider](https://jb.gg/ipe?extensions=com.jetbrains.performancePlugin.commandProvider)      |[CommandProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/performanceTesting/core/src/com/jetbrains/performancePlugin/CommandProvider.java) |
| [com.jetbrains.performancePlugin.playbackRunnerProvider](https://jb.gg/ipe?extensions=com.jetbrains.performancePlugin.playbackRunnerProvider)      |[PerformancePlaybackRunner](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/performanceTesting/core/src/com/jetbrains/performancePlugin/PerformancePlaybackRunner.kt) |
| [com.jetbrains.performancePlugin.profiler](https://jb.gg/ipe?extensions=com.jetbrains.performancePlugin.profiler)      |[Profiler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/performanceTesting/core/src/com/jetbrains/performancePlugin/profilers/Profiler.kt) |
| [com.jetbrains.performancePlugin.runCallbackHandler](https://jb.gg/ipe?extensions=com.jetbrains.performancePlugin.runCallbackHandler)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[RunCallbackHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/performanceTesting/core/src/com/jetbrains/performancePlugin/RunCallbackHandler.java) |
| [com.jetbrains.performancePlugin.snapshotOpener](https://jb.gg/ipe?extensions=com.jetbrains.performancePlugin.snapshotOpener)      |[SnapshotOpener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/performanceTesting/core/src/com/jetbrains/performancePlugin/profilers/SnapshotOpener.java) |

### Coverage

[Coverage](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/coverage/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.javaCoverageEngineExtension](https://jb.gg/ipe?extensions=com.intellij.javaCoverageEngineExtension)      |[JavaCoverageEngineExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/coverage/src/com/intellij/coverage/JavaCoverageEngineExtension.java) |

### DesignerCorePlugin.xml

[DesignerCorePlugin.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ui-designer-core/resources/META-INF/DesignerCorePlugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [Designer.customizations](https://jb.gg/ipe?extensions=Designer.customizations)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DesignerCustomizations](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ui-designer-core/src/com/intellij/designer/DesignerCustomizations.java) |

### intellij.compose.ide.plugin.resources.xml

[intellij.compose.ide.plugin.resources.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/compose/intellij.compose.ide.plugin.resources/resources/intellij.compose.ide.plugin.resources.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.compose.ide.plugin.resources.dataProvider](https://jb.gg/ipe?extensions=com.intellij.compose.ide.plugin.resources.dataProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ComposeResourcesDataProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/compose/intellij.compose.ide.plugin.resources/src/com/intellij/compose/ide/plugin/resources/ComposeResourcesDataProvider.kt) |
| [com.intellij.compose.ide.plugin.resources.drawablePreviewRenderer](https://jb.gg/ipe?extensions=com.intellij.compose.ide.plugin.resources.drawablePreviewRenderer)      |[BaseVectorDrawablePreviewRenderer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/compose/intellij.compose.ide.plugin.resources/src/com/intellij/compose/ide/plugin/resources/vectorDrawable/preview/BaseVectorDrawablePreviewRenderer.kt) |
| [com.intellij.compose.ide.plugin.resources.settingsContributor](https://jb.gg/ipe?extensions=com.intellij.compose.ide.plugin.resources.settingsContributor)      |[ComposeResourcesSettingsContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/compose/intellij.compose.ide.plugin.resources/src/com/intellij/compose/ide/plugin/resources/settings/ComposeResourcesSettingsContributor.kt) |
| [com.intellij.compose.ide.plugin.resources.vectorIconPicker](https://jb.gg/ipe?extensions=com.intellij.compose.ide.plugin.resources.vectorIconPicker)      |[BaseVectorIconPicker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/compose/intellij.compose.ide.plugin.resources/src/com/intellij/compose/ide/plugin/resources/actions/vectorAsset/BaseVectorIconPicker.kt) |

### intellij.compose.ide.plugin.shared.xml

[intellij.compose.ide.plugin.shared.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/compose/intellij.compose.ide.plugin.shared/resources/intellij.compose.ide.plugin.shared.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.compose.ide.plugin.shared.composeModuleConfiguration](https://jb.gg/ipe?extensions=com.intellij.compose.ide.plugin.shared.composeModuleConfiguration)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ComposeModuleConfigurationExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/compose/intellij.compose.ide.plugin.shared/src/com/intellij/compose/ide/plugin/shared/inspections/ComposeModuleConfigurationExtension.kt) |

### intellij.debugger.streams.core.xml

[intellij.debugger.streams.core.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/stream-debugger/core/resources/intellij.debugger.streams.core.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.platform.debugger.streams.librarySupport](https://jb.gg/ipe?extensions=org.jetbrains.platform.debugger.streams.librarySupport)      |[LibrarySupportProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/stream-debugger/core/src/com/intellij/debugger/streams/core/lib/LibrarySupportProvider.kt) |

### intellij.dev.codeInsight.xml

[intellij.dev.codeInsight.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/dev/intellij.dev.codeInsight/resources/intellij.dev.codeInsight.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.dev.lang.goodCodeRedVisitor](https://jb.gg/ipe?extensions=com.intellij.dev.lang.goodCodeRedVisitor)      |[GoodCodeRedVisitor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/dev/intellij.dev.codeInsight/src/internal/GoodCodeRedVisitor.java) |

### intellij.dev.psiViewer.xml

[intellij.dev.psiViewer.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/dev/intellij.dev.psiViewer/resources/intellij.dev.psiViewer.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.dev.psiViewer.apiMethodsProvider](https://jb.gg/ipe?extensions=com.intellij.dev.psiViewer.apiMethodsProvider)      |[Provider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/dev/intellij.dev.psiViewer/src/properties/tree/nodes/apiMethods/PsiViewerApiMethod.kt) |
| [com.intellij.dev.psiViewer.extension](https://jb.gg/ipe?extensions=com.intellij.dev.psiViewer.extension)      |[PsiViewerExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/dev/intellij.dev.psiViewer/src/PsiViewerExtension.java) |
| [com.intellij.dev.psiViewer.propertyNodeAppender](https://jb.gg/ipe?extensions=com.intellij.dev.psiViewer.propertyNodeAppender)      |[PsiViewerPropertyNodeAppender](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/dev/intellij.dev.psiViewer/src/properties/tree/PsiViewerPropertyNodeHolder.kt) |
| [com.intellij.dev.psiViewer.propertyNodeFactory](https://jb.gg/ipe?extensions=com.intellij.dev.psiViewer.propertyNodeFactory)      |[Factory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/dev/intellij.dev.psiViewer/src/properties/tree/PsiViewerPropertyNode.kt) |
| [com.intellij.dev.psiViewer.psiViewerActionEnabler](https://jb.gg/ipe?extensions=com.intellij.dev.psiViewer.psiViewerActionEnabler)      |[PsiViewerActionEnabler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/dev/intellij.dev.psiViewer/src/PsiViewerActionEnabler.kt) |

### intellij.devkit.core.xml

[intellij.devkit.core.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/resources/intellij.devkit.core.xml)

| Extension Point |Implementation |
-----------------------------------
| [DevKit.lang.LockReqPsiOps](https://jb.gg/ipe?extensions=DevKit.lang.LockReqPsiOps)      |[LockReqPsiOps](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/threadingModelHelper/LockReqPsiOps.kt) |
| [DevKit.lang.addServiceAnnotationProvider](https://jb.gg/ipe?extensions=DevKit.lang.addServiceAnnotationProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[AddServiceAnnotationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/quickfix/ConvertToLightServiceFix.kt) |
| [DevKit.lang.appServiceAsStaticFinalFieldOrPropertyFixProvider](https://jb.gg/ipe?extensions=DevKit.lang.appServiceAsStaticFinalFieldOrPropertyFixProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[AppServiceAsStaticFinalFieldOrPropertyFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/quickfix/AppServiceAsStaticFinalFieldOrPropertyFixProvider.kt) |
| [DevKit.lang.appServiceAsStaticFinalFieldOrPropertyVisitorProvider](https://jb.gg/ipe?extensions=DevKit.lang.appServiceAsStaticFinalFieldOrPropertyVisitorProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[AppServiceAsStaticFinalFieldOrPropertyVisitorProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/ApplicationServiceAsStaticFinalFieldOrPropertyInspection.kt) |
| [DevKit.lang.cancellationCheckInLoopsFixProvider](https://jb.gg/ipe?extensions=DevKit.lang.cancellationCheckInLoopsFixProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[CancellationCheckInLoopsFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/quickfix/CancellationCheckInLoopsFixProvider.kt) |
| [DevKit.lang.cancellationCheckProvider](https://jb.gg/ipe?extensions=DevKit.lang.cancellationCheckProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[CancellationCheckProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/CancellationCheckProvider.kt) |
| [DevKit.lang.cancellationExceptionHandlingChecker](https://jb.gg/ipe?extensions=DevKit.lang.cancellationExceptionHandlingChecker)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[CancellationExceptionHandlingChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/IncorrectCancellationExceptionHandlingInspection.kt) |
| [DevKit.lang.extensionClassShouldBeFinalErrorMessageProvider](https://jb.gg/ipe?extensions=DevKit.lang.extensionClassShouldBeFinalErrorMessageProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ErrorMessageProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/ExtensionClassShouldBeFinalErrorMessageProvider.kt) |
| [DevKit.lang.extensionClassShouldNotBePublicProvider](https://jb.gg/ipe?extensions=DevKit.lang.extensionClassShouldNotBePublicProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ExtensionClassShouldNotBePublicProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/ExtensionClassShouldNotBePublicProvider.kt) |
| [DevKit.lang.lightServiceMustBeFinalErrorMessageProvider](https://jb.gg/ipe?extensions=DevKit.lang.lightServiceMustBeFinalErrorMessageProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ErrorMessageProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/ExtensionClassShouldBeFinalErrorMessageProvider.kt) |
| [DevKit.lang.methodNameProvider](https://jb.gg/ipe?extensions=DevKit.lang.methodNameProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MethodNameProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/MethodNameProvider.kt) |
| [DevKit.lang.optimizedEelFunctionCallNameProvider](https://jb.gg/ipe?extensions=DevKit.lang.optimizedEelFunctionCallNameProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[OptimizedEelFunctionCallNameProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/eel/OptimizedEelFunctionCallNameProvider.kt) |
| [DevKit.lang.serviceLevelExtractor](https://jb.gg/ipe?extensions=DevKit.lang.serviceLevelExtractor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ServiceLevelExtractor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/ServiceLevelExtractor.kt) |
| [DevKit.lang.staticInitializationInExtensionsVisitorProvider](https://jb.gg/ipe?extensions=DevKit.lang.staticInitializationInExtensionsVisitorProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[StaticInitializationInExtensionsVisitorProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/StaticInitializationInExtensionsInspection.kt) |
| [DevKit.lang.uElementAsPsiCheckProvider](https://jb.gg/ipe?extensions=DevKit.lang.uElementAsPsiCheckProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[UElementAsPsiCheckProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/UElementAsPsiCheckProvider.kt) |
| [DevKit.lang.useHtmlChunkToolTipFixProvider](https://jb.gg/ipe?extensions=DevKit.lang.useHtmlChunkToolTipFixProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[UseHtmlChunkToolTipFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/quickfix/UseHtmlChunkToolTipFixProvider.kt) |
| [DevKit.lang.visitorProviderForRBCInspection](https://jb.gg/ipe?extensions=DevKit.lang.visitorProviderForRBCInspection)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[VisitorProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/inspections/CallingMethodShouldBeRequiresBlockingContextInspection.kt) |

### intellij.execution.multilaunch.core.xml

[intellij.execution.multilaunch.core.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/execution-multilaunch/core/resources/intellij.execution.multilaunch.core.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.multilaunch.condition.template](https://jb.gg/ipe?extensions=com.intellij.multilaunch.condition.template)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[ConditionTemplate](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/execution-multilaunch/core/src/com/intellij/execution/multilaunch/execution/conditions/ConditionTemplate.kt) |
| [com.intellij.multilaunch.task.definition](https://jb.gg/ipe?extensions=com.intellij.multilaunch.task.definition)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[TaskExecutableTemplate](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/execution-multilaunch/core/src/com/intellij/execution/multilaunch/execution/executables/TaskExecutableTemplate.kt) |

### intellij.ide.startup.importSettings.xml

[intellij.ide.startup.importSettings.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-startup/importSettings/resources/intellij.ide.startup.importSettings.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.startupWizardPages](https://jb.gg/ipe?extensions=com.intellij.startupWizardPages)      |[StartupWizardService](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-startup/importSettings/src/com/intellij/ide/startup/importSettings/data/StartupWizardService.kt) |
| [com.intellij.transferSettings.externalProjectImportChecker](https://jb.gg/ipe?extensions=com.intellij.transferSettings.externalProjectImportChecker)      |[ExternalProjectImportChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-startup/importSettings/src/com/intellij/ide/startup/importSettings/transfer/ExternalProjectImportChecker.kt) |
| [com.intellij.transferSettings.thirdPartyProductSettingItem](https://jb.gg/ipe?extensions=com.intellij.transferSettings.thirdPartyProductSettingItem)      |[ThirdPartyProductSettingItemProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-startup/importSettings/src/com/intellij/ide/startup/importSettings/transfer/ThirdPartyProductSettingItemProvider.kt) |
| [com.intellij.transferSettings.thirdPartyProductSettingsTransfer](https://jb.gg/ipe?extensions=com.intellij.transferSettings.thirdPartyProductSettingsTransfer)      |[ThirdPartyProductSettingsTransfer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-startup/importSettings/src/com/intellij/ide/startup/importSettings/transfer/ThirdPartyProductSettingsTransfer.kt) |
| [com.intellij.transferSettings.vscode.pluginMapping](https://jb.gg/ipe?extensions=com.intellij.transferSettings.vscode.pluginMapping)      |[VSCodePluginMapping](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-startup/importSettings/src/com/intellij/ide/startup/importSettings/transfer/backend/providers/vscode/mappings/PluginMappings.kt) |

### intellij.mcpserver.skills.xml

[intellij.mcpserver.skills.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/mcpserver.skills/resources/intellij.mcpserver.skills.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.mcpServer.bundledSkillsProvider](https://jb.gg/ipe?extensions=com.intellij.mcpServer.bundledSkillsProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[BundledSkillsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/mcpserver.skills/src/com/intellij/mcpserver/skills/BundledSkillsProvider.kt) |

### intellij.mcpserver.toolsets.xml

[intellij.mcpserver.toolsets.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/mcpserver.toolsets/resources/intellij.mcpserver.toolsets.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.mcpServer.navigationItemMapper](https://jb.gg/ipe?extensions=com.intellij.mcpServer.navigationItemMapper)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[McpNavigationItemMapper](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/mcpserver.toolsets/src/general/McpNavigationItemMapper.kt) |

### intellij.mcpserver.xml

[intellij.mcpserver.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/resources/intellij.mcpserver.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.mcpServer.elicitationProvider](https://jb.gg/ipe?extensions=com.intellij.mcpServer.elicitationProvider)      |[McpElicitationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/elicitation/McpElicitationProvider.kt) |
| [com.intellij.mcpServer.freshInstallPolicy](https://jb.gg/ipe?extensions=com.intellij.mcpServer.freshInstallPolicy)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[McpServerFreshInstallPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/McpServerFreshInstallPolicy.kt) |
| [com.intellij.mcpServer.mcpCallOwnerTelemetryProvider](https://jb.gg/ipe?extensions=com.intellij.mcpServer.mcpCallOwnerTelemetryProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[McpCallOwnerTelemetryProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/McpCallOwnerTelemetryProvider.kt) |
| [com.intellij.mcpServer.mcpManagedSessionSupport](https://jb.gg/ipe?extensions=com.intellij.mcpServer.mcpManagedSessionSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[McpManagedSessionSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/McpManagedSessionSupport.kt) |
| [com.intellij.mcpServer.mcpProjectPathCustomizer](https://jb.gg/ipe?extensions=com.intellij.mcpServer.mcpProjectPathCustomizer)      |[McpProjectPathCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/McpProjectPathCustomizer.kt) |
| [com.intellij.mcpServer.mcpToolFilterProvider](https://jb.gg/ipe?extensions=com.intellij.mcpServer.mcpToolFilterProvider)      |[McpToolFilterProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/McpToolFilterProvider.kt) |
| [com.intellij.mcpServer.mcpToolsProvider](https://jb.gg/ipe?extensions=com.intellij.mcpServer.mcpToolsProvider)      |[McpToolsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/McpToolsProvider.kt) |
| [com.intellij.mcpServer.mcpToolset](https://jb.gg/ipe?extensions=com.intellij.mcpServer.mcpToolset)      |[McpToolset](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/McpToolset.kt) |
| [com.intellij.mcpServer.projectDependenciesProvider](https://jb.gg/ipe?extensions=com.intellij.mcpServer.projectDependenciesProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[McpProjectDependenciesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/McpProjectDependenciesProvider.kt) |
| [com.intellij.mcpServer.statusBarWidgetProvider](https://jb.gg/ipe?extensions=com.intellij.mcpServer.statusBarWidgetProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[McpServerStatusBarWidgetProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/mcp-server/src/com/intellij/mcpserver/widget/McpServerStatusBarWidgetProvider.kt) |

### intellij.minimap.core.xml

[intellij.minimap.core.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/minimap/core/resources/intellij.minimap.core.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.minimapFileSupportPolicy](https://jb.gg/ipe?extensions=com.intellij.minimapFileSupportPolicy)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MinimapFileSupportPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/minimap/core/src/com/intellij/ide/minimap/model/MinimapFileSupportPolicy.kt) |
| [com.intellij.minimapInteractionPolicy](https://jb.gg/ipe?extensions=com.intellij.minimapInteractionPolicy)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MinimapInteractionPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/minimap/core/src/com/intellij/ide/minimap/interaction/MinimapInteractionPolicy.kt) |
| [com.intellij.minimapLayerFactory](https://jb.gg/ipe?extensions=com.intellij.minimapLayerFactory)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MinimapLayerFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/minimap/core/src/com/intellij/ide/minimap/layers/MinimapLayerFactory.kt) |
| [com.intellij.minimapLayerVisibilityPolicy](https://jb.gg/ipe?extensions=com.intellij.minimapLayerVisibilityPolicy)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MinimapLayerVisibilityPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/minimap/core/src/com/intellij/ide/minimap/layers/MinimapLayerVisibilityPolicy.kt) |
| [com.intellij.minimapLayoutPolicy](https://jb.gg/ipe?extensions=com.intellij.minimapLayoutPolicy)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MinimapLayoutPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/minimap/core/src/com/intellij/ide/minimap/layout/MinimapLayoutPolicy.kt) |
| [com.intellij.minimapTokenRenderPolicy](https://jb.gg/ipe?extensions=com.intellij.minimapTokenRenderPolicy)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MinimapTokenRenderPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/minimap/core/src/com/intellij/ide/minimap/render/MinimapTokenRenderPolicy.kt) |

### intellij.performanceTesting.remoteDriver.xml

[intellij.performanceTesting.remoteDriver.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/performanceTesting/remote-driver/resources/intellij.performanceTesting.remoteDriver.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.performancePlugin.remotedriver.textExtractorExtension](https://jb.gg/ipe?extensions=com.jetbrains.performancePlugin.remotedriver.textExtractorExtension)      |[TextExtractorExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/performanceTesting/remote-driver/src/com/jetbrains/performancePlugin/remotedriver/dataextractor/TextExtractorExtension.kt) |
| [com.jetbrains.performancePlugin.remotedriver.xpathDataModelExtension](https://jb.gg/ipe?extensions=com.jetbrains.performancePlugin.remotedriver.xpathDataModelExtension)      |[XpathDataModelExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/performanceTesting/remote-driver/src/com/jetbrains/performancePlugin/remotedriver/xpath/XpathDataModelExtension.kt) |

### intellij.platform.coverage.xml

[intellij.platform.coverage.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/coverage-common/resources/intellij.platform.coverage.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.coverageEngine](https://jb.gg/ipe?extensions=com.intellij.coverageEngine)      |[CoverageEngine](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/coverage-common/src/com/intellij/coverage/CoverageEngine.java) |
| [com.intellij.coverageModifiedFilesFilterFactory](https://jb.gg/ipe?extensions=com.intellij.coverageModifiedFilesFilterFactory)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ModifiedFilesFilterFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/coverage-common/src/com/intellij/coverage/filters/ModifiedFilesFilterFactory.kt) |
| [com.intellij.coverageOptions](https://jb.gg/ipe?extensions=com.intellij.coverageOptions)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CoverageOptions](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/coverage-common/src/com/intellij/coverage/CoverageOptions.java) |
| [com.intellij.coverageRunner](https://jb.gg/ipe?extensions=com.intellij.coverageRunner)      |[CoverageRunner](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/coverage-common/src/com/intellij/coverage/CoverageRunner.java) |

### intellij.platform.langInjection.xml

[intellij.platform.langInjection.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/IntelliLang/resources/intellij.platform.langInjection.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.intellij.intelliLang.fallbackInjectorSuppressor](https://jb.gg/ipe?extensions=org.intellij.intelliLang.fallbackInjectorSuppressor)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[FallbackInjectorSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/IntelliLang/src/org/intellij/plugins/intelliLang/inject/FallbackInjectorSuppressor.kt) |
| [org.intellij.intelliLang.injectionConfig](https://jb.gg/ipe?extensions=org.intellij.intelliLang.injectionConfig)      |`n/a` |
| [org.intellij.intelliLang.languageSupport](https://jb.gg/ipe?extensions=org.intellij.intelliLang.languageSupport)      |[LanguageInjectionSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/IntelliLang/src/org/intellij/plugins/intelliLang/inject/LanguageInjectionSupport.java) |

### intellij.properties.backend.xml

[intellij.properties.backend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties/resources/intellij.properties.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.properties.alphaUnsortedInspectionSuppressor](https://jb.gg/ipe?extensions=com.intellij.properties.alphaUnsortedInspectionSuppressor)      |[AlphaUnsortedPropertiesFileInspectionSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties/properties-psi-impl/src/com/intellij/lang/properties/codeInspection/unsorted/AlphaUnsortedPropertiesFileInspectionSuppressor.java) |
| [com.intellij.properties.duplicatePropertyKeyAnnotationSuppressor](https://jb.gg/ipe?extensions=com.intellij.properties.duplicatePropertyKeyAnnotationSuppressor)      |[DuplicatePropertyKeyAnnotationSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties/properties-psi-impl/src/com/intellij/lang/properties/DuplicatePropertyKeyAnnotationSuppressor.java) |
| [com.intellij.properties.extendedUseScopeProvider](https://jb.gg/ipe?extensions=com.intellij.properties.extendedUseScopeProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[ExtendedUseScopeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties/properties-psi-impl/src/com/intellij/lang/properties/codeInspection/unused/ExtendedUseScopeProvider.java) |
| [com.intellij.properties.implicitPropertyUsageProvider](https://jb.gg/ipe?extensions=com.intellij.properties.implicitPropertyUsageProvider)      |[ImplicitPropertyUsageProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties/properties-psi-impl/src/com/intellij/lang/properties/codeInspection/unused/ImplicitPropertyUsageProvider.java) |
| [com.intellij.properties.spellcheckerMnemonicsTokenizer](https://jb.gg/ipe?extensions=com.intellij.properties.spellcheckerMnemonicsTokenizer)      |[MnemonicsTokenizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties/src/com/intellij/lang/properties/spellchecker/MnemonicsTokenizer.java) |

### intellij.repository.search.completion.xml

[intellij.repository.search.completion.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/repository-search/completion/resources/intellij.repository.search.completion.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.idea.reposearch.contributor](https://jb.gg/ipe?extensions=org.jetbrains.idea.reposearch.contributor)      |[DependencyCompletionContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/repository-search/completion/src/api/DependencyCompletionService.kt) |

### intellij.searchEverywhereMl.ranking.core.xml

[intellij.searchEverywhereMl.ranking.core.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/search-everywhere-ml/ranking/core/resources/intellij.searchEverywhereMl.ranking.core.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.searcheverywhere.ml.rankingModelLoader](https://jb.gg/ipe?extensions=com.intellij.searcheverywhere.ml.rankingModelLoader)      |[SearchEverywhereMLRankingModelLoader](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/search-everywhere-ml/ranking/core/src/com/intellij/searchEverywhereMl/ranking/core/model/SearchEverywhereMLRankingModelLoader.kt) |
| [com.intellij.searcheverywhere.ml.searchEverywhereElementFeaturesProvider](https://jb.gg/ipe?extensions=com.intellij.searcheverywhere.ml.searchEverywhereElementFeaturesProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[SearchEverywhereElementFeaturesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/search-everywhere-ml/ranking/core/src/com/intellij/searchEverywhereMl/ranking/core/features/SearchEverywhereElementFeaturesProvider.kt) |

### intellij.searchEverywhereMl.ranking.ext.xml

[intellij.searchEverywhereMl.ranking.ext.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/search-everywhere-ml/ranking/ext/resources/intellij.searchEverywhereMl.ranking.ext.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.searchEverywhereMl.searchEverywhereElementKeyProvider](https://jb.gg/ipe?extensions=com.intellij.searchEverywhereMl.searchEverywhereElementKeyProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[SearchEverywhereElementKeyProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/search-everywhere-ml/ranking/ext/src/com/intellij/searchEverywhereMl/ranking/ext/SearchEverywhereElementKeyProvider.kt) |

### intellij.sh.core.xml

[intellij.sh.core.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/sh/core/resources/intellij.sh.core.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.runMarkerContributionAdditionalCondition](https://jb.gg/ipe?extensions=com.intellij.runMarkerContributionAdditionalCondition)      |[ShRunnerAdditionalCondition](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/sh/core/src/com/intellij/sh/run/ShRunnerAdditionalCondition.java) |
| [com.intellij.shellOccurrencesHighlightingSuppressor](https://jb.gg/ipe?extensions=com.intellij.shellOccurrencesHighlightingSuppressor)      |[ShOccurrencesHighlightingSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/sh/core/src/com/intellij/sh/highlighting/ShOccurrencesHighlightingSuppressor.kt) |

### intellij.textmate.xml

[intellij.textmate.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/textmate/resources/intellij.textmate.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.textmate.bundleProvider](https://jb.gg/ipe?extensions=com.intellij.textmate.bundleProvider)      |[TextMateBundleProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/textmate/src/org/jetbrains/plugins/textmate/api/TextMateBundleProvider.kt) |

### intellij.tips.xml

[intellij.tips.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/tips-of-the-day/resources/intellij.tips.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.tipAndTrickPromotionFactory](https://jb.gg/ipe?extensions=com.intellij.tipAndTrickPromotionFactory)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TipAndTrickPromotionFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/tips-of-the-day/src/com/intellij/ide/util/TipAndTrickPromotionFactory.kt) |

### intellij.toml.json.xml

[intellij.toml.json.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/toml/json/src/main/resources/intellij.toml.json.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.toml.ide.json.tomlJsonSchemaCompletionFileFilter](https://jb.gg/ipe?extensions=org.toml.ide.json.tomlJsonSchemaCompletionFileFilter)      |[TomlJsonSchemaCompletionFileFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/toml/json/src/main/kotlin/org/toml/ide/json/TomlJsonSchemaCompletionFileFilter.kt) |

### intellij.yaml.backend.xml

[intellij.yaml.backend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/yaml/backend/resources/intellij.yaml.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.yaml.customStructureViewFactory](https://jb.gg/ipe?extensions=com.intellij.yaml.customStructureViewFactory)      |[YAMLCustomStructureViewFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/yaml/backend/src/structureView/YAMLCustomStructureViewFactory.java) |
| [com.intellij.yaml.tagRecogniser](https://jb.gg/ipe?extensions=com.intellij.yaml.tagRecogniser)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[YamlTagRecogniser](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/yaml/src/psi/YamlTagRecogniser.kt) |

### JUnit

[JUnit](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/junit/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.junitListener](https://jb.gg/ipe?extensions=com.intellij.junitListener)      |[IDEAJUnitListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-runtime/src/com/intellij/rt/execution/junit/IDEAJUnitListener.java) |
| [com.intellij.testDiscoveryProducer](https://jb.gg/ipe?extensions=com.intellij.testDiscoveryProducer)      |[TestDiscoveryProducer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/impl/src/com/intellij/execution/testDiscovery/TestDiscoveryProducer.java) |

### org.intellij.groovy

[org.intellij.groovy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.newProjectWizard.groovy.buildSystem](https://jb.gg/ipe?extensions=com.intellij.newProjectWizard.groovy.buildSystem)      |[BuildSystemGroovyNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/src/org/jetbrains/plugins/groovy/config/wizard/BuildSystemGroovyNewProjectWizard.kt) |
| [org.intellij.groovy.applicabilityProvider](https://jb.gg/ipe?extensions=org.intellij.groovy.applicabilityProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GroovyApplicabilityProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/extensions/GroovyApplicabilityProvider.java) |
| [org.intellij.groovy.astTransformationSupport](https://jb.gg/ipe?extensions=org.intellij.groovy.astTransformationSupport)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[AstTransformationSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/transformations/AstTransformationSupport.java) |
| [org.intellij.groovy.callTypeCalculator](https://jb.gg/ipe?extensions=org.intellij.groovy.callTypeCalculator)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GrCallTypeCalculator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/typing/GrCallTypeCalculator.kt) |
| [org.intellij.groovy.classDescriptor](https://jb.gg/ipe?extensions=org.intellij.groovy.classDescriptor)      |`n/a` |
| [org.intellij.groovy.closureCompleter](https://jb.gg/ipe?extensions=org.intellij.groovy.closureCompleter)      |[ClosureCompleter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/src/org/jetbrains/plugins/groovy/lang/completion/ClosureCompleter.java) |
| [org.intellij.groovy.closureMissingMethodContributor](https://jb.gg/ipe?extensions=org.intellij.groovy.closureMissingMethodContributor)      |[ClosureMissingMethodContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/resolve/ClosureMissingMethodContributor.java) |
| [org.intellij.groovy.completionCustomizer](https://jb.gg/ipe?extensions=org.intellij.groovy.completionCustomizer)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GroovyCompletionCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/src/org/jetbrains/plugins/groovy/lang/completion/api/GroovyCompletionCustomizer.kt) |
| [org.intellij.groovy.configSlurperSupport](https://jb.gg/ipe?extensions=org.intellij.groovy.configSlurperSupport)      |[ConfigSlurperSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/configSlurper/ConfigSlurperSupport.java) |
| [org.intellij.groovy.convertToJava.customMethodInvocator](https://jb.gg/ipe?extensions=org.intellij.groovy.convertToJava.customMethodInvocator)      |[CustomMethodInvocator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/src/org/jetbrains/plugins/groovy/refactoring/convertToJava/invocators/CustomMethodInvocator.java) |
| [org.intellij.groovy.customAnnotationChecker](https://jb.gg/ipe?extensions=org.intellij.groovy.customAnnotationChecker)      |[CustomAnnotationChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/annotator/checkers/CustomAnnotationChecker.java) |
| [org.intellij.groovy.delegatesToProvider](https://jb.gg/ipe?extensions=org.intellij.groovy.delegatesToProvider)      |[GrDelegatesToProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/resolve/delegatesTo/GrDelegatesToProvider.java) |
| [org.intellij.groovy.elementFilter](https://jb.gg/ipe?extensions=org.intellij.groovy.elementFilter)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GroovyElementFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/GroovyElementFilter.kt) |
| [org.intellij.groovy.expectedPackageNameProvider](https://jb.gg/ipe?extensions=org.intellij.groovy.expectedPackageNameProvider)      |[ExpectedPackageNameProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/resolve/ExpectedPackageNameProvider.kt) |
| [org.intellij.groovy.expectedTypesContributor](https://jb.gg/ipe?extensions=org.intellij.groovy.expectedTypesContributor)      |[GroovyExpectedTypesContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/psi/expectedTypes/GroovyExpectedTypesContributor.java) |
| [org.intellij.groovy.gdslScriptProvider](https://jb.gg/ipe?extensions=org.intellij.groovy.gdslScriptProvider)      |[GdslScriptProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/dsl/GdslScriptProvider.java) |
| [org.intellij.groovy.gdslTopLevelProvider](https://jb.gg/ipe?extensions=org.intellij.groovy.gdslTopLevelProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[GdslMembersProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/dsl/dsltop/GdslMembersProvider.java) |
| [org.intellij.groovy.groovyFrameworkConfigNotification](https://jb.gg/ipe?extensions=org.intellij.groovy.groovyFrameworkConfigNotification)      |[GroovyFrameworkConfigNotification](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/annotator/GroovyFrameworkConfigNotification.java) |
| [org.intellij.groovy.groovySourceFolderDetector](https://jb.gg/ipe?extensions=org.intellij.groovy.groovySourceFolderDetector)      |[GroovySourceFolderDetector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/src/org/jetbrains/plugins/groovy/actions/GroovySourceFolderDetector.java) |
| [org.intellij.groovy.importContributor](https://jb.gg/ipe?extensions=org.intellij.groovy.importContributor)      |[GrImportContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/resolve/imports/GrImportContributor.java) |
| [org.intellij.groovy.inlayHintFilter](https://jb.gg/ipe?extensions=org.intellij.groovy.inlayHintFilter)      |[GroovyInlayHintFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/src/org/jetbrains/plugins/groovy/editor/GroovyInlayHintFilter.java) |
| [org.intellij.groovy.inlineASTTransformationSupport](https://jb.gg/ipe?extensions=org.intellij.groovy.inlineASTTransformationSupport)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GroovyInlineASTTransformationSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/transformations/inline/GroovyInlineASTTransformationSupport.kt) |
| [org.intellij.groovy.inspectionDisabler](https://jb.gg/ipe?extensions=org.intellij.groovy.inspectionDisabler)      |[FileTypeInspectionDisabler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/codeInspection/FileTypeInspectionDisabler.kt) |
| [org.intellij.groovy.mapContentProvider](https://jb.gg/ipe?extensions=org.intellij.groovy.mapContentProvider)      |[GroovyMapContentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/extensions/GroovyMapContentProvider.java) |
| [org.intellij.groovy.membersContributor](https://jb.gg/ipe?extensions=org.intellij.groovy.membersContributor)      |[NonCodeMembersContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/resolve/NonCodeMembersContributor.java) |
| [org.intellij.groovy.methodComparator](https://jb.gg/ipe?extensions=org.intellij.groovy.methodComparator)      |[GrMethodComparator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/resolve/GrMethodComparator.java) |
| [org.intellij.groovy.methodDescriptor](https://jb.gg/ipe?extensions=org.intellij.groovy.methodDescriptor)      |`n/a` |
| [org.intellij.groovy.methodMayBeStaticInspectionFilter](https://jb.gg/ipe?extensions=org.intellij.groovy.methodMayBeStaticInspectionFilter)      |[GrMethodMayBeStaticInspectionFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/codeInspection/declaration/GrMethodMayBeStaticInspectionFilter.java) |
| [org.intellij.groovy.namedArgumentProvider](https://jb.gg/ipe?extensions=org.intellij.groovy.namedArgumentProvider)      |[GroovyNamedArgumentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/extensions/GroovyNamedArgumentProvider.java) |
| [org.intellij.groovy.overloadResolver](https://jb.gg/ipe?extensions=org.intellij.groovy.overloadResolver)      |[GroovyOverloadResolver](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/resolve/api/GroovyOverloadResolver.java) |
| [org.intellij.groovy.positionManagerDelegate](https://jb.gg/ipe?extensions=org.intellij.groovy.positionManagerDelegate)      |[ScriptPositionManagerHelper](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/src/org/jetbrains/plugins/groovy/extensions/debugger/ScriptPositionManagerHelper.java) |
| [org.intellij.groovy.psiEnhancerCategory](https://jb.gg/ipe?extensions=org.intellij.groovy.psiEnhancerCategory)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[PsiEnhancerCategory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/dsl/psi/PsiEnhancerCategory.java) |
| [org.intellij.groovy.referenceTypeEnhancer](https://jb.gg/ipe?extensions=org.intellij.groovy.referenceTypeEnhancer)      |[GrReferenceTypeEnhancer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/psi/typeEnhancers/GrReferenceTypeEnhancer.java) |
| [org.intellij.groovy.renameHelper](https://jb.gg/ipe?extensions=org.intellij.groovy.renameHelper)      |[GrRenameHelper](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/src/org/jetbrains/plugins/groovy/refactoring/rename/GrRenameHelper.java) |
| [org.intellij.groovy.scriptTypeDetector](https://jb.gg/ipe?extensions=org.intellij.groovy.scriptTypeDetector)      |[GroovyScriptTypeDetector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/extensions/GroovyScriptTypeDetector.java) |
| [org.intellij.groovy.signatureHintProcessor](https://jb.gg/ipe?extensions=org.intellij.groovy.signatureHintProcessor)      |[SignatureHintProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/psi/typeEnhancers/SignatureHintProcessor.java) |
| [org.intellij.groovy.typeAugmenter](https://jb.gg/ipe?extensions=org.intellij.groovy.typeAugmenter)      |[TypeAugmenter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/psi/dataFlow/types/TypeAugmenter.kt) |
| [org.intellij.groovy.typeCalculator](https://jb.gg/ipe?extensions=org.intellij.groovy.typeCalculator)      |[GrTypeCalculator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/typing/GrTypeCalculator.java) |
| [org.intellij.groovy.typeConverter](https://jb.gg/ipe?extensions=org.intellij.groovy.typeConverter)      |[GrTypeConverter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/psi/typeEnhancers/GrTypeConverter.java) |
| [org.intellij.groovy.unresolvedHighlightFileFilter](https://jb.gg/ipe?extensions=org.intellij.groovy.unresolvedHighlightFileFilter)      |[GroovyUnresolvedHighlightFileFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/extensions/GroovyUnresolvedHighlightFileFilter.java) |
| [org.intellij.groovy.unresolvedHighlightFilter](https://jb.gg/ipe?extensions=org.intellij.groovy.unresolvedHighlightFilter)      |[GroovyUnresolvedHighlightFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/extensions/GroovyUnresolvedHighlightFilter.java) |
| [org.intellij.groovy.variableEnhancer](https://jb.gg/ipe?extensions=org.intellij.groovy.variableEnhancer)      |[GrVariableEnhancer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/groovy-psi/src/org/jetbrains/plugins/groovy/lang/psi/typeEnhancers/GrVariableEnhancer.java) |

### org.jetbrains.idea.eclipse

[org.jetbrains.idea.eclipse](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/eclipse/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.idea.eclipse.natureImporter](https://jb.gg/ipe?extensions=org.jetbrains.idea.eclipse.natureImporter)      |[EclipseNatureImporter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/eclipse/src/org/jetbrains/idea/eclipse/importWizard/EclipseNatureImporter.java) |

### ru.adelf.idea.dotenv

[ru.adelf.idea.dotenv](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/env-files-support/src/main/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [ru.adelf.idea.dotenv.environmentVariablesProvider](https://jb.gg/ipe?extensions=ru.adelf.idea.dotenv.environmentVariablesProvider)      |[EnvironmentVariablesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/env-files-support/src/main/java/ru/adelf/idea/dotenv/api/EnvironmentVariablesProvider.java) |
| [ru.adelf.idea.dotenv.environmentVariablesUsagesProvider](https://jb.gg/ipe?extensions=ru.adelf.idea.dotenv.environmentVariablesUsagesProvider)      |[EnvironmentVariablesUsagesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/env-files-support/src/main/java/ru/adelf/idea/dotenv/api/EnvironmentVariablesUsagesProvider.java) |

### TestNG-J

[TestNG-J](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/testng/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.theoryinpractice.testng.listener](https://jb.gg/ipe?extensions=com.theoryinpractice.testng.listener)      |[IDEATestNGListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/testng_rt/src/com/intellij/rt/testng/IDEATestNGListener.java) |

### XPathView

[XPathView](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/xpath/xpath-lang/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [XPathView.xpath.contextProviderExtension](https://jb.gg/ipe?extensions=XPathView.xpath.contextProviderExtension)      |[ContextProviderExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/xpath/xpath-lang/src/org/intellij/lang/xpath/context/ContextProviderExtension.java) |
| [XPathView.xpath.functionProvider](https://jb.gg/ipe?extensions=XPathView.xpath.functionProvider)      |[XPathFunctionProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/xpath/xpath-lang/src/org/intellij/lang/xpath/context/functions/XPathFunctionProvider.java) |
| [XPathView.xsltRunnerExtension](https://jb.gg/ipe?extensions=XPathView.xsltRunnerExtension)      |[XsltRunnerExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/xpath/xpath-lang/src/org/intellij/lang/xpath/xslt/run/XsltRunnerExtension.java) |

## Ant Plugin

### Ant Plugin – Listeners

| Topic |Listener |
-------------------
| [AntExecutionListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.lang.ant.config.execution.AntExecutionListener) |[AntExecutionListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ant/src/com/intellij/lang/ant/config/execution/AntExecutionListener.java) |

### AntSupport

[AntSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ant/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [AntSupport.AntMessageCustomizer](https://jb.gg/ipe?extensions=AntSupport.AntMessageCustomizer)      |[AntMessageCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ant/src/com/intellij/lang/ant/config/execution/AntMessageCustomizer.java) |

## EditorConfig Plugin

### EditorConfig Plugin – Listeners

| Topic |Listener |
-------------------
| [EditorConfigSettings#EDITOR_CONFIG_ENABLED_TOPIC](https://jb.gg/ipe/listeners?topics=org.editorconfig.settings.EditorConfigListener) |[EditorConfigListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/editorconfig/backend/src/settings/EditorConfigListener.java) |

### intellij.editorconfig.backend.xml

[intellij.editorconfig.backend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/editorconfig/backend/resources/intellij.editorconfig.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [editorconfig.exportProvider](https://jb.gg/ipe?extensions=editorconfig.exportProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[EditorConfigExportProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/editorconfig/backend/src/settings/EditorConfigExportProvider.java) |
| [editorconfig.optionDescriptorProvider](https://jb.gg/ipe?extensions=editorconfig.optionDescriptorProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[EditorConfigOptionDescriptorProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/editorconfig/backend/src/language/extensions/EditorConfigOptionDescriptorProvider.kt) |

## Gradle Plugin

### Gradle Plugin – Listeners

| Topic |Listener |
-------------------
| [GradleSyncListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.gradle.service.syncAction.GradleSyncListener)  ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GradleSyncListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/syncAction/GradleSyncListener.kt) |
| [GradleSettingsListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.gradle.settings.GradleSettingsListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GradleSettingsListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/settings/src/settings/GradleSettingsListener.java) |
| [GradleUiListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.gradle.ui.GradleUiListener) |[GradleUiListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/ui/GradleUiListener.java) |

### intellij.gradle.codeInsight.backend.xml

[intellij.gradle.codeInsight.backend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/codeInsight/backend/resources/intellij.gradle.codeInsight.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.gradle.dslInspectionProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.dslInspectionProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GradleDslInspectionProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/codeInsight/backend/src/inspections/GradleDslInspectionProvider.kt) |

### intellij.gradle.java.groovy.xml

[intellij.gradle.java.groovy.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/groovy/resources/intellij.gradle.java.groovy.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.gradle.pluginDescriptions](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.pluginDescriptions)      |[GradlePluginDescriptionsExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/codeInsight/GradlePluginDescriptionsExtension.java) |
| [org.jetbrains.plugins.gradle.resolve.contributor](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.resolve.contributor)      |[GradleMethodContextContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/groovy/src/service/resolve/GradleMethodContextContributor.java) |

### intellij.gradle.java.xml

[intellij.gradle.java.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/resources/intellij.gradle.java.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.gradle.buildTasksProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.buildTasksProvider)      |[GradleBuildTasksProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/execution/build/GradleBuildTasksProvider.java) |
| [org.jetbrains.plugins.gradle.externallyHandledExtensions](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.externallyHandledExtensions)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GradleVersionCatalogHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/service/resolve/GradleVersionCatalogHandler.kt) |
| [org.jetbrains.plugins.gradle.frameworkSupport](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.frameworkSupport)      |[GradleFrameworkSupportProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/frameworkSupport/GradleFrameworkSupportProvider.java) |
| [org.jetbrains.plugins.gradle.initScriptGenerator](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.initScriptGenerator)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GradleInitScriptGenerator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/execution/build/GradleInitScriptGenerator.kt) |
| [org.jetbrains.plugins.gradle.kotlinDslFrameworkSupport](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.kotlinDslFrameworkSupport)      |[KotlinDslGradleFrameworkSupportProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/frameworkSupport/KotlinDslGradleFrameworkSupportProvider.java) |
| [org.jetbrains.plugins.gradle.testLocator](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.testLocator)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[GradleTestLocatorExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/execution/test/runner/GradleTestLocatorExtension.java) |
| [org.jetbrains.plugins.gradle.testTasksProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.testTasksProvider)      |[GradleTestTasksProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/execution/test/runner/GradleTestTasksProvider.java) |
| [org.jetbrains.plugins.gradle.versionCatalogEntrySearcher](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.versionCatalogEntrySearcher)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GradleVersionCatalogEntrySearcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/service/resolve/GradleVersionCatalogEntrySearcher.kt) |
| [org.jetbrains.plugins.gradle.versionCatalogPsiResolver](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.versionCatalogPsiResolver)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GradleVersionCatalogPsiResolver](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/java/src/service/resolve/GradleVersionCatalogPsiResolver.kt) |

### intellij.gradle.xml

[intellij.gradle.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/plugin-resources/intellij.gradle.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.gradle.autoReloadSettingsCollector](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.autoReloadSettingsCollector)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GradleAutoReloadSettingsCollector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/project/GradleAutoReloadSettingsCollector.kt) |
| [org.jetbrains.plugins.gradle.executionChecker](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.executionChecker)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GradleExecutionChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/execution/GradleExecutionChecker.kt) |
| [org.jetbrains.plugins.gradle.executionEnvironmentProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.executionEnvironmentProvider)      |[GradleExecutionEnvironmentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/execution/build/GradleExecutionEnvironmentProvider.java) |
| [org.jetbrains.plugins.gradle.executionHelperExtension](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.executionHelperExtension)      |[GradleExecutionHelperExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/project/GradleExecutionHelperExtension.kt) |
| [org.jetbrains.plugins.gradle.gradleJvmResolver](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.gradleJvmResolver)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GradleJvmResolver](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/resolvers/GradleJvmResolver.kt) |
| [org.jetbrains.plugins.gradle.importCustomizer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.importCustomizer)      |[GradleImportCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/project/GradleImportCustomizer.java) |
| [org.jetbrains.plugins.gradle.issueChecker](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.issueChecker)      |[GradleIssueChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/issue/GradleIssueChecker.kt) |
| [org.jetbrains.plugins.gradle.orderEnumerationHandlerFactory](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.orderEnumerationHandlerFactory)      |[FactoryImpl](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/execution/GradleOrderEnumeratorHandler.java) |
| [org.jetbrains.plugins.gradle.previewCustomizer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.previewCustomizer)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GradlePreviewCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/project/GradlePreviewCustomizer.kt) |
| [org.jetbrains.plugins.gradle.projectResolve](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.projectResolve)      |[GradleProjectResolverExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/project/GradleProjectResolverExtension.java) |
| [org.jetbrains.plugins.gradle.settingsControlProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.settingsControlProvider)      |[GradleSettingsControlProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/settings/GradleSettingsControlProvider.java) |
| [org.jetbrains.plugins.gradle.syncContributor](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.syncContributor)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GradleSyncContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/syncAction/GradleSyncContributor.kt) |
| [org.jetbrains.plugins.gradle.syncExtension](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.syncExtension)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GradleSyncExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/syncAction/GradleSyncExtension.kt) |
| [org.jetbrains.plugins.gradle.targetEnvironmentAware](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.targetEnvironmentAware)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GradleTargetEnvironmentAware](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/execution/target/GradleTargetEnvironmentAware.java) |
| [org.jetbrains.plugins.gradle.taskManager](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.taskManager)      |[GradleTaskManagerExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/service/task/GradleTaskManagerExtension.java) |
| [org.jetbrains.plugins.gradle.wrapperVersionQuickFixProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.gradle.wrapperVersionQuickFixProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GradleWrapperVersionQuickFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gradle/src/org/jetbrains/plugins/gradle/issue/quickfix/GradleWrapperVersionQuickFixProvider.kt) |

## Grazie Plugin

### Grazie Plugin – Listeners

| Topic |Listener |
-------------------
| [GrazieStateLifecycleKt#CONFIG_STATE_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.grazie.ide.msg.GrazieStateLifecycle) |[GrazieStateLifecycle](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/grazie/src/main/kotlin/com/intellij/grazie/ide/msg/GrazieStateLifecycle.kt) |

### tanvd.grazi

[tanvd.grazi](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/grazie/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.grazie.cloudConnector](https://jb.gg/ipe?extensions=com.intellij.grazie.cloudConnector)      |[GrazieCloudConnector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/grazie/src/main/kotlin/com/intellij/grazie/cloud/GrazieCloudConnector.kt) |
| [com.intellij.grazie.disableChecking](https://jb.gg/ipe?extensions=com.intellij.grazie.disableChecking)      |`n/a` |
| [com.intellij.grazie.grammar.strategy](https://jb.gg/ipe?extensions=com.intellij.grazie.grammar.strategy)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |[GrammarCheckingStrategy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/grazie/src/main/kotlin/com/intellij/grazie/grammar/strategy/GrammarCheckingStrategy.kt) |
| [com.intellij.grazie.problemFilter](https://jb.gg/ipe?extensions=com.intellij.grazie.problemFilter)      |[ProblemFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/grazie/src/main/kotlin/com/intellij/grazie/text/ProblemFilter.java) |
| [com.intellij.grazie.textChecker](https://jb.gg/ipe?extensions=com.intellij.grazie.textChecker)      |[TextChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/grazie/src/main/kotlin/com/intellij/grazie/text/TextChecker.java) |
| [com.intellij.grazie.textContentModificationTrackerProvider](https://jb.gg/ipe?extensions=com.intellij.grazie.textContentModificationTrackerProvider)      |[TextContentModificationTrackerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/grazie/src/main/kotlin/com/intellij/grazie/text/TextContentModificationTrackerProvider.kt) |
| [com.intellij.grazie.textExtractor](https://jb.gg/ipe?extensions=com.intellij.grazie.textExtractor)      |[TextExtractor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/grazie/src/main/kotlin/com/intellij/grazie/text/TextExtractor.java) |

## IDE Features Trainer Plugin

### IDE Features Trainer Plugin – Listeners

| Topic |Listener |
-------------------
| [FeatureSuggestersManagerListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=training.featuresSuggester.FeatureSuggestersManagerListener) |[FeatureSuggestersManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-features-trainer/src/training/featuresSuggester/FeatureSuggestersManagerListener.kt) |

### training

[training](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-features-trainer/res/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [training.ifs.suggester](https://jb.gg/ipe?extensions=training.ifs.suggester)      |[FeatureSuggester](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-features-trainer/src/training/featuresSuggester/suggesters/FeatureSuggester.kt) |
| [training.ifs.suggesterSupport](https://jb.gg/ipe?extensions=training.ifs.suggesterSupport)      |[SuggesterSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-features-trainer/src/training/featuresSuggester/SuggesterSupport.kt) |
| [training.ift.language.extension](https://jb.gg/ipe?extensions=training.ift.language.extension)      |[LangSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-features-trainer/src/training/lang/LangSupport.kt) |
| [training.ift.learning.commonCourse](https://jb.gg/ipe?extensions=training.ift.learning.commonCourse)      |[LearningCourse](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-features-trainer/src/training/learn/course/LearningCourse.kt) |
| [training.ift.learning.course](https://jb.gg/ipe?extensions=training.ift.learning.course)      |[LearningCourseBase](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-features-trainer/src/training/learn/course/LearningCourseBase.kt) |
| [training.ift.newUsersOnboardingExperimentAccessor](https://jb.gg/ipe?extensions=training.ift.newUsersOnboardingExperimentAccessor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[NewUsersOnboardingExperimentAccessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/ide-features-trainer/src/training/learn/NewUsersOnboardingExperimentAccessor.kt) |

## Java Plugin

### Java Plugin – Listeners

| Topic |Listener |
-------------------
| [BuildManagerListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.compiler.server.BuildManagerListener) |[BuildManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/server/BuildManagerListener.java) |
| [CustomBuilderMessageHandler#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.compiler.server.CustomBuilderMessageHandler)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CustomBuilderMessageHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/server/CustomBuilderMessageHandler.java) |
| [PortableCachesLoadListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.compiler.server.PortableCachesLoadListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[PortableCachesLoadListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/server/PortableCachesLoadListener.java) |
| [DebuggerActionListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.debugger.engine.DebuggerActionListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[DebuggerActionListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/DebuggerActionListener.kt) |
| [DebuggerManagerListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.debugger.impl.DebuggerManagerListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[DebuggerManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/impl/DebuggerManagerListener.java) |
| [StarterModuleProcessListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.ide.starters.StarterModuleProcessListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[StarterModuleProcessListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/ide/starters/StarterModuleProcessListener.kt) |
| [CompilerTopics#COMPILATION_STATUS](https://jb.gg/ipe/listeners?topics=com.intellij.openapi.compiler.CompilationStatusListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CompilationStatusListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/openapi/compiler/CompilationStatusListener.java) |
| [ExcludedEntriesListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.openapi.compiler.options.ExcludedEntriesListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ExcludedEntriesListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/openapi/compiler/options/ExcludedEntriesListener.java) |
| [LanguageLevelProjectExtension#LANGUAGE_LEVEL_CHANGED_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.openapi.roots.LanguageLevelProjectExtension.LanguageLevelChangeListener) |[LanguageLevelChangeListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-frontback-psi-api/src/com/intellij/openapi/roots/LanguageLevelProjectExtension.java) |
| [VirtualFileJavaLanguageLevelListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.openapi.roots.impl.VirtualFileJavaLanguageLevelListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[VirtualFileJavaLanguageLevelListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/openapi/roots/impl/VirtualFileJavaLanguageLevelListener.kt) |
| [ConfigurationErrors#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.openapi.roots.ui.configuration.ConfigurationErrors) |[ConfigurationErrors](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/openapi/roots/ui/configuration/ConfigurationErrors.java) |
| [ArtifactManager#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.packaging.artifacts.ArtifactListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ArtifactListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/packaging/artifacts/ArtifactListener.java) |

### InspectionGadgets.xml

[InspectionGadgets.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-backend/resources/META-INF/InspectionGadgets.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.implicit.resource.closer](https://jb.gg/ipe?extensions=com.intellij.implicit.resource.closer)      |[ImplicitResourceCloser](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/codeInspection/resources/ImplicitResourceCloser.java) |
| [com.intellij.naming.convention.class](https://jb.gg/ipe?extensions=com.intellij.naming.convention.class)      |[NamingConvention](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/codeInspection/naming/NamingConvention.java) |
| [com.intellij.naming.convention.field](https://jb.gg/ipe?extensions=com.intellij.naming.convention.field)      |[NamingConvention](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/codeInspection/naming/NamingConvention.java) |
| [com.intellij.naming.convention.method](https://jb.gg/ipe?extensions=com.intellij.naming.convention.method)      |[NamingConvention](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/codeInspection/naming/NamingConvention.java) |

### intellij.java.analysis.impl.xml

[intellij.java.analysis.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/resources/intellij.java.analysis.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.allowedApiFilter](https://jb.gg/ipe?extensions=com.intellij.allowedApiFilter)      |[AllowedApiFilterExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/psi/impl/AllowedApiFilterExtension.java) |
| [com.intellij.canBeFinal](https://jb.gg/ipe?extensions=com.intellij.canBeFinal)      |[CanBeFinalHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/codeInspection/canBeFinal/CanBeFinalHandler.java) |
| [com.intellij.codeInsight.implicitSubclassProvider](https://jb.gg/ipe?extensions=com.intellij.codeInsight.implicitSubclassProvider)      |[ImplicitSubclassProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/codeInspection/inheritance/ImplicitSubclassProvider.kt) |
| [com.intellij.deadCode](https://jb.gg/ipe?extensions=com.intellij.deadCode)      |[EntryPoint](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInspection/reference/EntryPoint.java) |
| [com.intellij.injectedLanguageJavaReferenceSupplier](https://jb.gg/ipe?extensions=com.intellij.injectedLanguageJavaReferenceSupplier)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`n/a` |
| [com.intellij.java.errorFixProvider](https://jb.gg/ipe?extensions=com.intellij.java.errorFixProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[JavaErrorFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/codeInsight/daemon/impl/analysis/JavaErrorFixProvider.java) |
| [com.intellij.javaLanguageLevelPusherCustomizer](https://jb.gg/ipe?extensions=com.intellij.javaLanguageLevelPusherCustomizer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaLanguageLevelPusherCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/openapi/roots/impl/JavaLanguageLevelPusherCustomizer.java) |
| [com.intellij.lang.jvm.bytecodeAnalysisSuppressor](https://jb.gg/ipe?extensions=com.intellij.lang.jvm.bytecodeAnalysisSuppressor)      |[BytecodeAnalysisSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/codeInspection/bytecodeAnalysis/BytecodeAnalysisSuppressor.java) |
| [com.intellij.lang.jvm.ignoreVariableCanBeFinalSupport](https://jb.gg/ipe?extensions=com.intellij.lang.jvm.ignoreVariableCanBeFinalSupport)      |[IgnoreVariableCanBeFinalSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/codeInspection/localCanBeFinal/IgnoreVariableCanBeFinalSupport.java) |
| [com.intellij.propertyAccessorDetector](https://jb.gg/ipe?extensions=com.intellij.propertyAccessorDetector)      |[PropertyAccessorDetector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-impl/src/com/intellij/psi/util/PropertyAccessorDetector.java) |
| [com.intellij.visibility](https://jb.gg/ipe?extensions=com.intellij.visibility)      |[VisibilityExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-impl/src/com/intellij/codeInspection/visibility/VisibilityExtension.java) |

### intellij.java.analysis.xml

[intellij.java.analysis.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-api/resources/intellij.java.analysis.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.codeInsight.changeVariableTypeQuickFixProvider](https://jb.gg/ipe?extensions=com.intellij.codeInsight.changeVariableTypeQuickFixProvider)      |[ChangeVariableTypeQuickFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-api/src/com/intellij/codeInsight/quickfix/ChangeVariableTypeQuickFixProvider.java) |
| [com.intellij.lang.jvm.actions.jvmElementActionsFactory](https://jb.gg/ipe?extensions=com.intellij.lang.jvm.actions.jvmElementActionsFactory)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[JvmElementActionsFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-api/src/com/intellij/lang/jvm/actions/JvmElementActionsFactory.kt) |
| [com.intellij.unusedDeclarationFixProvider](https://jb.gg/ipe?extensions=com.intellij.unusedDeclarationFixProvider)      |[UnusedDeclarationFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-analysis-api/src/com/intellij/codeInspection/reference/UnusedDeclarationFixProvider.java) |

### intellij.java.compiler.impl.xml

[intellij.java.compiler.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/resources/intellij.java.compiler.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.buildProcess.parametersProvider](https://jb.gg/ipe?extensions=com.intellij.buildProcess.parametersProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[BuildProcessParametersProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/server/BuildProcessParametersProvider.java) |
| [com.intellij.compileServer.plugin](https://jb.gg/ipe?extensions=com.intellij.compileServer.plugin)      |`n/a` |
| [com.intellij.compiler.buildIssueContributor](https://jb.gg/ipe?extensions=com.intellij.compiler.buildIssueContributor)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[BuildIssueContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/progress/BuildIssueContributor.java) |
| [com.intellij.compiler.buildTargetScopeProvider](https://jb.gg/ipe?extensions=com.intellij.compiler.buildTargetScopeProvider)      |[BuildTargetScopeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/impl/BuildTargetScopeProvider.java) |
| [com.intellij.compiler.isUpToDateCheckConsumer](https://jb.gg/ipe?extensions=com.intellij.compiler.isUpToDateCheckConsumer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[IsUpToDateCheckConsumer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/backwardRefs/IsUpToDateCheckConsumer.java) |
| [com.intellij.compiler.optionsManager](https://jb.gg/ipe?extensions=com.intellij.compiler.optionsManager)      |[CompilerOptionsFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/options/CompilerOptionsFilter.java) |
| [com.intellij.compiler.task](https://jb.gg/ipe?extensions=com.intellij.compiler.task)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CompileTask](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/openapi/compiler/CompileTask.java) |
| [com.intellij.compiler.updateResourcesBuildContributor](https://jb.gg/ipe?extensions=com.intellij.compiler.updateResourcesBuildContributor)      |[UpdateResourcesBuildContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/impl/UpdateResourcesBuildContributor.java) |
| [com.intellij.java.compiler](https://jb.gg/ipe?extensions=com.intellij.java.compiler)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[BackendCompiler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/impl/javaCompiler/BackendCompiler.java) |
| [com.intellij.languageCompilerRefAdapter](https://jb.gg/ipe?extensions=com.intellij.languageCompilerRefAdapter)      |[LanguageCompilerRefAdapter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/backwardRefs/LanguageCompilerRefAdapter.java) |
| [com.intellij.languageCompilerRefAdapter.directInheritorProvider](https://jb.gg/ipe?extensions=com.intellij.languageCompilerRefAdapter.directInheritorProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[DirectInheritorProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/impl/src/com/intellij/compiler/backwardRefs/DirectInheritorProvider.kt) |

### intellij.java.compiler.xml

[intellij.java.compiler.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/resources/intellij.java.compiler.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.compilableFileTypesProvider](https://jb.gg/ipe?extensions=com.intellij.compilableFileTypesProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CompilableFileTypesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/openapi/compiler/CompilableFileTypesProvider.java) |
| [com.intellij.compiler](https://jb.gg/ipe?extensions=com.intellij.compiler)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[Compiler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/openapi/compiler/Compiler.java) |
| [com.intellij.compiler.inspectionValidator](https://jb.gg/ipe?extensions=com.intellij.compiler.inspectionValidator)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[InspectionValidator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/openapi/compiler/util/InspectionValidator.java) |
| [com.intellij.compilerFactory](https://jb.gg/ipe?extensions=com.intellij.compilerFactory)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) ![Removal](https://img.shields.io/badge/-Removal-red?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CompilerFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/openapi/compiler/CompilerFactory.java) |
| [com.intellij.packaging.artifactPropertiesProvider](https://jb.gg/ipe?extensions=com.intellij.packaging.artifactPropertiesProvider)      |[ArtifactPropertiesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/packaging/artifacts/ArtifactPropertiesProvider.java) |
| [com.intellij.packaging.artifactType](https://jb.gg/ipe?extensions=com.intellij.packaging.artifactType)      |[ArtifactType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/packaging/artifacts/ArtifactType.java) |
| [com.intellij.packaging.elementType](https://jb.gg/ipe?extensions=com.intellij.packaging.elementType)      |[PackagingElementType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/packaging/elements/PackagingElementType.java) |
| [com.intellij.packaging.sourceItemFilter](https://jb.gg/ipe?extensions=com.intellij.packaging.sourceItemFilter)      |[PackagingSourceItemFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/packaging/ui/PackagingSourceItemFilter.java) |
| [com.intellij.packaging.sourceItemProvider](https://jb.gg/ipe?extensions=com.intellij.packaging.sourceItemProvider)      |[PackagingSourceItemsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/compiler/openapi/src/com/intellij/packaging/ui/PackagingSourceItemsProvider.java) |

### intellij.java.debugger.content.xml

[intellij.java.debugger.content.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/resources/intellij.java.debugger.content.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.debugger.codeFragmentFactory](https://jb.gg/ipe?extensions=com.intellij.debugger.codeFragmentFactory)      |[CodeFragmentFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/engine/evaluation/CodeFragmentFactory.java) |
| [com.intellij.debugger.javaDebugAware](https://jb.gg/ipe?extensions=com.intellij.debugger.javaDebugAware)      |[JavaDebugAware](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/engine/JavaDebugAware.java) |
| [com.intellij.debugger.nodeNameAdjuster](https://jb.gg/ipe?extensions=com.intellij.debugger.nodeNameAdjuster)      |[NodeDescriptorNameAdjuster](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/ui/tree/NodeDescriptorNameAdjuster.java) |
| [com.intellij.debugger.positionManagerFactory](https://jb.gg/ipe?extensions=com.intellij.debugger.positionManagerFactory)      |[PositionManagerFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/PositionManagerFactory.java) |
| [com.intellij.debugger.simplePropertyGetterProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.simplePropertyGetterProvider)      |[SimplePropertyGetterProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/engine/SimplePropertyGetterProvider.java) |
| [com.intellij.debugger.sourceFileResolver](https://jb.gg/ipe?extensions=com.intellij.debugger.sourceFileResolver)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[DebuggerSourceFileResolver](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/source/DebuggerSourceFileResolver.kt) |
| [com.intellij.debugger.sourcePositionHighlighter](https://jb.gg/ipe?extensions=com.intellij.debugger.sourcePositionHighlighter)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[SourcePositionHighlighter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/engine/SourcePositionHighlighter.java) |
| [com.intellij.debugger.syntheticProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.syntheticProvider)      |[SyntheticTypeComponentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/engine/SyntheticTypeComponentProvider.java) |

### intellij.java.execution.impl.xml

[intellij.java.execution.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/impl/resources/intellij.java.execution.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.execution.testDiscoveryVcsHelper](https://jb.gg/ipe?extensions=com.intellij.execution.testDiscoveryVcsHelper)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TestDiscoveryVcsHelper](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/impl/src/com/intellij/execution/testDiscovery/TestDiscoveryVcsHelper.kt) |
| [com.intellij.jreProvider](https://jb.gg/ipe?extensions=com.intellij.jreProvider)      |[JreProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/impl/src/com/intellij/execution/ui/JreProvider.java) |
| [com.intellij.runConfigurationExtension](https://jb.gg/ipe?extensions=com.intellij.runConfigurationExtension)      |[RunConfigurationExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/impl/src/com/intellij/execution/RunConfigurationExtension.java) |
| [com.intellij.threadDumpProvider](https://jb.gg/ipe?extensions=com.intellij.threadDumpProvider)      |[ThreadDumpProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/impl/src/com/intellij/execution/impl/ThreadDumpProvider.java) |

### intellij.java.execution.xml

[intellij.java.execution.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/openapi/resources/intellij.java.execution.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.exceptionFilter](https://jb.gg/ipe?extensions=com.intellij.exceptionFilter)      |[ExceptionFilterFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/openapi/src/com/intellij/execution/filters/ExceptionFilterFactory.java) |
| [com.intellij.execution.applicationRunLineMarkerHider](https://jb.gg/ipe?extensions=com.intellij.execution.applicationRunLineMarkerHider)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[ApplicationRunLineMarkerHider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/openapi/src/com/intellij/execution/ApplicationRunLineMarkerHider.java) |
| [com.intellij.java.consoleDecorator](https://jb.gg/ipe?extensions=com.intellij.java.consoleDecorator)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[JavaConsoleDecorator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/openapi/src/com/intellij/execution/application/JavaConsoleDecorator.java) |
| [com.intellij.java.programPatcher](https://jb.gg/ipe?extensions=com.intellij.java.programPatcher)      |[JavaProgramPatcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/openapi/src/com/intellij/execution/runners/JavaProgramPatcher.java) |
| [com.intellij.junitPatcher](https://jb.gg/ipe?extensions=com.intellij.junitPatcher)      |[JUnitPatcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/openapi/src/com/intellij/execution/JUnitPatcher.java) |
| [com.intellij.junitRecognizer](https://jb.gg/ipe?extensions=com.intellij.junitRecognizer)      |[JUnitRecognizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/openapi/src/com/intellij/execution/JUnitRecognizer.java) |
| [com.intellij.jvm.exceptionFilter](https://jb.gg/ipe?extensions=com.intellij.jvm.exceptionFilter)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[JvmExceptionOccurrenceFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/execution/openapi/src/com/intellij/execution/filters/JvmExceptionOccurrenceFilter.java) |

### intellij.java.frontback.impl.xml

[intellij.java.frontback.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-frontback-impl/resource/intellij.java.frontback.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.java.definitions](https://jb.gg/ipe?extensions=com.intellij.java.definitions)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[AbstractBasicJavaDefinitionService](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-frontback-impl/src/com/intellij/codeInsight/definition/AbstractBasicJavaDefinitionService.java) |
| [com.intellij.threadDumpItemFactory](https://jb.gg/ipe?extensions=com.intellij.threadDumpItemFactory)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ThreadDumpItemFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-frontback-impl/src/com/intellij/unscramble/ThreadDumpItemFactory.kt) |

### intellij.java.frontback.psi.impl.xml

[intellij.java.frontback.psi.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-frontback-psi-impl/resources/intellij.java.frontback.psi.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.psi.classFileDecompiler](https://jb.gg/ipe?extensions=com.intellij.psi.classFileDecompiler)      |[Decompiler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-frontback-psi-api/src/com/intellij/psi/compiled/ClassFileDecompilers.java) |

### intellij.java.impl.analyzer.xml

[intellij.java.impl.analyzer.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/resources/intellij.java.impl.analyzer.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.documentationDelegateProvider](https://jb.gg/ipe?extensions=com.intellij.documentationDelegateProvider)      |[DocumentationDelegateProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/javadoc/DocumentationDelegateProvider.java) |
| [com.intellij.getterSetterProvider](https://jb.gg/ipe?extensions=com.intellij.getterSetterProvider)      |[GetterSetterPrototypeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/generation/GetterSetterPrototypeProvider.java) |
| [com.intellij.gotoByName.defaultProvider.ignoreLanguage](https://jb.gg/ipe?extensions=com.intellij.gotoByName.defaultProvider.ignoreLanguage)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`n/a` |
| [com.intellij.java.effectively.final.fixer](https://jb.gg/ipe?extensions=com.intellij.java.effectively.final.fixer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[EffectivelyFinalFixer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/daemon/impl/quickfix/makefinal/EffectivelyFinalFixer.java) |
| [com.intellij.java.externalAnnotation](https://jb.gg/ipe?extensions=com.intellij.java.externalAnnotation)      |[AnnotationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/externalAnnotation/AnnotationProvider.java) |
| [com.intellij.java.inspection.bulkMethodInfo](https://jb.gg/ipe?extensions=com.intellij.java.inspection.bulkMethodInfo)      |[BulkMethodInfoProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInspection/bulkOperation/BulkMethodInfoProvider.java) |
| [com.intellij.java.templateCodeInsightSupport](https://jb.gg/ipe?extensions=com.intellij.java.templateCodeInsightSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaTemplateCodeInsightSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/java/impl/template/JavaTemplateCodeInsightSupport.kt) |
| [com.intellij.java.templateFormattingSupport](https://jb.gg/ipe?extensions=com.intellij.java.templateFormattingSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaTemplateFormattingSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/java/impl/template/JavaTemplateFormattingSupport.kt) |
| [com.intellij.java.templateImportSupport](https://jb.gg/ipe?extensions=com.intellij.java.templateImportSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaTemplateImportSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/java/impl/template/JavaTemplateImportSupport.kt) |
| [com.intellij.java.templatePresentationSupport](https://jb.gg/ipe?extensions=com.intellij.java.templatePresentationSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaTemplatePresentationSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/java/impl/template/JavaTemplatePresentationSupport.kt) |
| [com.intellij.jvm.logging](https://jb.gg/ipe?extensions=com.intellij.jvm.logging)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JvmLogger](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/lang/logging/JvmLogger.kt) |
| [com.intellij.lang.jvm.annotationPackageSupport](https://jb.gg/ipe?extensions=com.intellij.lang.jvm.annotationPackageSupport)      |[AnnotationPackageSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/annoPackages/AnnotationPackageSupport.java) |
| [com.intellij.overrideImplementsAnnotationsHandler](https://jb.gg/ipe?extensions=com.intellij.overrideImplementsAnnotationsHandler)      |[OverrideImplementsAnnotationsHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/generation/OverrideImplementsAnnotationsHandler.java) |
| [com.intellij.variableTypeCalculator](https://jb.gg/ipe?extensions=com.intellij.variableTypeCalculator)      |[VariableTypeCalculator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/template/macro/VariableTypeCalculator.java) |

### intellij.java.impl.inspections.xml

[intellij.java.impl.inspections.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-inspections/resources/intellij.java.impl.inspections.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.lang.jvm.ignoreAnnotationParamSupport](https://jb.gg/ipe?extensions=com.intellij.lang.jvm.ignoreAnnotationParamSupport)      |[IgnoreAnnotationParamSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-inspections/src/com/intellij/codeInspection/DefaultAnnotationParamInspection.java) |

### intellij.java.impl.refactorings.xml

[intellij.java.impl.refactorings.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/resources/intellij.java.impl.refactorings.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.conversion.rule](https://jb.gg/ipe?extensions=com.intellij.conversion.rule)      |[TypeConversionRule](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/typeMigration/rules/TypeConversionRule.java) |
| [com.intellij.java.templateRefactoringSupport](https://jb.gg/ipe?extensions=com.intellij.java.templateRefactoringSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaTemplateRefactoringSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/java/impl/refactorings/template/JavaTemplateRefactoringSupport.kt) |
| [com.intellij.predefinedMigrationMapProvider](https://jb.gg/ipe?extensions=com.intellij.predefinedMigrationMapProvider)      |[PredefinedMigrationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/migration/PredefinedMigrationProvider.java) |
| [com.intellij.refactoring.introduceParameterMethodUsagesProcessor](https://jb.gg/ipe?extensions=com.intellij.refactoring.introduceParameterMethodUsagesProcessor)      |[IntroduceParameterMethodUsagesProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/introduceParameter/IntroduceParameterMethodUsagesProcessor.java) |
| [com.intellij.refactoring.moveAllClassesInFileHandler](https://jb.gg/ipe?extensions=com.intellij.refactoring.moveAllClassesInFileHandler)      |[MoveAllClassesInFileHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/move/moveClassesOrPackages/MoveAllClassesInFileHandler.java) |
| [com.intellij.refactoring.moveClassHandler](https://jb.gg/ipe?extensions=com.intellij.refactoring.moveClassHandler)      |[MoveClassHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/move/moveClassesOrPackages/MoveClassHandler.java) |
| [com.intellij.refactoring.moveClassToInnerHandler](https://jb.gg/ipe?extensions=com.intellij.refactoring.moveClassToInnerHandler)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MoveClassToInnerHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/move/moveClassesOrPackages/MoveClassToInnerHandler.java) |
| [com.intellij.refactoring.moveInnerClassUsagesHandler](https://jb.gg/ipe?extensions=com.intellij.refactoring.moveInnerClassUsagesHandler)      |[MoveInnerClassUsagesHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/move/moveInner/MoveInnerClassUsagesHandler.java) |
| [com.intellij.refactoring.moveInnerHandler](https://jb.gg/ipe?extensions=com.intellij.refactoring.moveInnerHandler)      |[MoveInnerHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/move/moveInner/MoveInnerHandler.java) |
| [com.intellij.refactoring.moveMemberHandler](https://jb.gg/ipe?extensions=com.intellij.refactoring.moveMemberHandler)      |[MoveMemberHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/move/moveMembers/MoveMemberHandler.java) |
| [com.intellij.refactoring.overrideMethodProcessor](https://jb.gg/ipe?extensions=com.intellij.refactoring.overrideMethodProcessor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[OverrideMethodsProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/OverrideMethodsProcessor.java) |
| [com.intellij.safeDelete.importSearcher](https://jb.gg/ipe?extensions=com.intellij.safeDelete.importSearcher)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ImportSearcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl-refactorings/src/com/intellij/refactoring/safeDelete/ImportSearcher.java) |

### intellij.java.impl.xml

[intellij.java.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/resources/intellij.java.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.codeInsight.createFieldFromUsageHelper](https://jb.gg/ipe?extensions=com.intellij.codeInsight.createFieldFromUsageHelper)      |[CreateFieldFromUsageHelper](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/daemon/impl/quickfix/CreateFieldFromUsageHelper.java) |
| [com.intellij.codeInsight.externalLibraryResolver](https://jb.gg/ipe?extensions=com.intellij.codeInsight.externalLibraryResolver)      |[ExternalLibraryResolver](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/daemon/quickFix/ExternalLibraryResolver.java) |
| [com.intellij.constructorBodyGenerator](https://jb.gg/ipe?extensions=com.intellij.constructorBodyGenerator)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ConstructorBodyGenerator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/generation/ConstructorBodyGenerator.java) |
| [com.intellij.documentationDelegateProvider](https://jb.gg/ipe?extensions=com.intellij.documentationDelegateProvider)      |[DocumentationDelegateProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/javadoc/DocumentationDelegateProvider.java) |
| [com.intellij.externalAnnotationsArtifactsResolver](https://jb.gg/ipe?extensions=com.intellij.externalAnnotationsArtifactsResolver)      |[ExternalAnnotationsArtifactsResolver](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/ExternalAnnotationsArtifactsResolver.java) |
| [com.intellij.generateAccessorProvider](https://jb.gg/ipe?extensions=com.intellij.generateAccessorProvider)      ![Obsolete](https://img.shields.io/badge/-Obsolete-grey?style=flat-square) |[NotNullFunction](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/NotNullFunction.java) |
| [com.intellij.generation.toStringClassFilter](https://jb.gg/ipe?extensions=com.intellij.generation.toStringClassFilter)      |[GenerateToStringClassFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/org/jetbrains/generate/tostring/GenerateToStringClassFilter.java) |
| [com.intellij.getterSetterProvider](https://jb.gg/ipe?extensions=com.intellij.getterSetterProvider)      |[GetterSetterPrototypeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/generation/GetterSetterPrototypeProvider.java) |
| [com.intellij.gotoByName.defaultProvider.ignoreLanguage](https://jb.gg/ipe?extensions=com.intellij.gotoByName.defaultProvider.ignoreLanguage)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`n/a` |
| [com.intellij.java.changeSignature.converter](https://jb.gg/ipe?extensions=com.intellij.java.changeSignature.converter)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[JavaChangeInfoConverter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/refactoring/changeSignature/JavaChangeInfoConverter.java) |
| [com.intellij.java.effectively.final.fixer](https://jb.gg/ipe?extensions=com.intellij.java.effectively.final.fixer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[EffectivelyFinalFixer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/daemon/impl/quickfix/makefinal/EffectivelyFinalFixer.java) |
| [com.intellij.java.externalAnnotation](https://jb.gg/ipe?extensions=com.intellij.java.externalAnnotation)      |[AnnotationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/externalAnnotation/AnnotationProvider.java) |
| [com.intellij.java.externalAnnotation.locationProvider](https://jb.gg/ipe?extensions=com.intellij.java.externalAnnotation.locationProvider)      |[AnnotationsLocationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/externalAnnotation/location/AnnotationsLocationProvider.java) |
| [com.intellij.java.inspection.bulkMethodInfo](https://jb.gg/ipe?extensions=com.intellij.java.inspection.bulkMethodInfo)      |[BulkMethodInfoProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInspection/bulkOperation/BulkMethodInfoProvider.java) |
| [com.intellij.java.refactoring.chainCallExtractor](https://jb.gg/ipe?extensions=com.intellij.java.refactoring.chainCallExtractor)      |[ChainCallExtractor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/refactoring/chainCall/ChainCallExtractor.java) |
| [com.intellij.java.templateCodeInsightSupport](https://jb.gg/ipe?extensions=com.intellij.java.templateCodeInsightSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaTemplateCodeInsightSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/java/impl/template/JavaTemplateCodeInsightSupport.kt) |
| [com.intellij.java.templateFormattingSupport](https://jb.gg/ipe?extensions=com.intellij.java.templateFormattingSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaTemplateFormattingSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/java/impl/template/JavaTemplateFormattingSupport.kt) |
| [com.intellij.java.templateImportSupport](https://jb.gg/ipe?extensions=com.intellij.java.templateImportSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaTemplateImportSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/java/impl/template/JavaTemplateImportSupport.kt) |
| [com.intellij.java.templatePresentationSupport](https://jb.gg/ipe?extensions=com.intellij.java.templatePresentationSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaTemplatePresentationSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/java/impl/template/JavaTemplatePresentationSupport.kt) |
| [com.intellij.javaDocNotNecessary](https://jb.gg/ipe?extensions=com.intellij.javaDocNotNecessary)      |[Condition](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/openapi/util/Condition.java) |
| [com.intellij.jvm.logging](https://jb.gg/ipe?extensions=com.intellij.jvm.logging)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JvmLogger](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/lang/logging/JvmLogger.kt) |
| [com.intellij.lang.jvm.annotationPackageSupport](https://jb.gg/ipe?extensions=com.intellij.lang.jvm.annotationPackageSupport)      |[AnnotationPackageSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/annoPackages/AnnotationPackageSupport.java) |
| [com.intellij.lang.jvm.annotations.marker.suppressor](https://jb.gg/ipe?extensions=com.intellij.lang.jvm.annotations.marker.suppressor)      |[NonCodeAnnotationsMarkerSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/NonCodeAnnotationsMarkerSuppressor.java) |
| [com.intellij.library.dependencyScopeSuggester](https://jb.gg/ipe?extensions=com.intellij.library.dependencyScopeSuggester)      |[LibraryDependencyScopeSuggester](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/openapi/roots/LibraryDependencyScopeSuggester.java) |
| [com.intellij.openapi.projectRoots.externalJavaConfigurationMissingAction](https://jb.gg/ipe?extensions=com.intellij.openapi.projectRoots.externalJavaConfigurationMissingAction)      |[ExternalJavaConfigurationMissingAction](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/openapi/projectRoots/impl/ExternalJavaConfigurationMissingAction.kt) |
| [com.intellij.openapi.projectRoots.externalJavaConfigurationProvider](https://jb.gg/ipe?extensions=com.intellij.openapi.projectRoots.externalJavaConfigurationProvider)      |[ExternalJavaConfigurationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/openapi/projectRoots/impl/ExternalJavaConfigurationProvider.kt) |
| [com.intellij.overrideImplementsAnnotationsHandler](https://jb.gg/ipe?extensions=com.intellij.overrideImplementsAnnotationsHandler)      |[OverrideImplementsAnnotationsHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/generation/OverrideImplementsAnnotationsHandler.java) |
| [com.intellij.projectModelModifier](https://jb.gg/ipe?extensions=com.intellij.projectModelModifier)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[JavaProjectModelModifier](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/openapi/roots/JavaProjectModelModifier.java) |
| [com.intellij.testGenerator](https://jb.gg/ipe?extensions=com.intellij.testGenerator)      |[TestGenerator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/testIntegration/createTest/TestGenerator.java) |
| [com.intellij.variableTypeCalculator](https://jb.gg/ipe?extensions=com.intellij.variableTypeCalculator)      |[VariableTypeCalculator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/codeInsight/template/macro/VariableTypeCalculator.java) |

### intellij.java.psi.impl.xml

[intellij.java.psi.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-impl/resources/intellij.java.psi.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.annotationSupport](https://jb.gg/ipe?extensions=com.intellij.annotationSupport)      |[PsiAnnotationSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/PsiAnnotationSupport.java) |
| [com.intellij.classTypePointerFactory](https://jb.gg/ipe?extensions=com.intellij.classTypePointerFactory)      |[ClassTypePointerFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/ClassTypePointerFactory.java) |
| [com.intellij.codeStyle.ReferenceAdjuster](https://jb.gg/ipe?extensions=com.intellij.codeStyle.ReferenceAdjuster)      |[ReferenceAdjuster](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/codeStyle/ReferenceAdjuster.java) |
| [com.intellij.constantExpressionEvaluator](https://jb.gg/ipe?extensions=com.intellij.constantExpressionEvaluator)      |[ConstantExpressionEvaluator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-impl/src/com/intellij/psi/impl/ConstantExpressionEvaluator.java) |
| [com.intellij.custom.exception.handler](https://jb.gg/ipe?extensions=com.intellij.custom.exception.handler)      |[CustomExceptionHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-impl/src/com/intellij/codeInsight/CustomExceptionHandler.java) |
| [com.intellij.customJavadocTagProvider](https://jb.gg/ipe?extensions=com.intellij.customJavadocTagProvider)      |[CustomJavadocTagProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/javadoc/CustomJavadocTagProvider.java) |
| [com.intellij.deepestSuperMethodsSearch](https://jb.gg/ipe?extensions=com.intellij.deepestSuperMethodsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.expressionConverter](https://jb.gg/ipe?extensions=com.intellij.expressionConverter)      |[ExpressionConverter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-impl/src/com/intellij/psi/impl/ExpressionConverter.java) |
| [com.intellij.generation.topLevelFactory](https://jb.gg/ipe?extensions=com.intellij.generation.topLevelFactory)      |[JVMElementFactoryProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/JVMElementFactoryProvider.java) |
| [com.intellij.importFilter](https://jb.gg/ipe?extensions=com.intellij.importFilter)      |[ImportFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/codeInsight/ImportFilter.java) |
| [com.intellij.java.elementFinder](https://jb.gg/ipe?extensions=com.intellij.java.elementFinder)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[PsiElementFinder](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/PsiElementFinder.java) |
| [com.intellij.java.expressionTypeNullabilityPatcher](https://jb.gg/ipe?extensions=com.intellij.java.expressionTypeNullabilityPatcher)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[JavaExpressionTypeNullabilityPatcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/codeInsight/JavaExpressionTypeNullabilityPatcher.java) |
| [com.intellij.java.languageFeatureProvider](https://jb.gg/ipe?extensions=com.intellij.java.languageFeatureProvider)      |[LanguageFeatureProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/pom/java/LanguageFeatureProvider.java) |
| [com.intellij.javaCompilerConfigurationProxy](https://jb.gg/ipe?extensions=com.intellij.javaCompilerConfigurationProxy)      |[JavaCompilerConfigurationProxy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/JavaCompilerConfigurationProxy.java) |
| [com.intellij.javaMainMethodProvider](https://jb.gg/ipe?extensions=com.intellij.javaMainMethodProvider)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[JavaMainMethodProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/codeInsight/runner/JavaMainMethodProvider.java) |
| [com.intellij.javaModuleSystem](https://jb.gg/ipe?extensions=com.intellij.javaModuleSystem)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |[JavaModuleSystem](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/JavaModuleSystem.java) |
| [com.intellij.javadocTagInfo](https://jb.gg/ipe?extensions=com.intellij.javadocTagInfo)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[JavadocTagInfo](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/javadoc/JavadocTagInfo.java) |
| [com.intellij.jvm.declarationSearcher](https://jb.gg/ipe?extensions=com.intellij.jvm.declarationSearcher)      |[JvmDeclarationSearcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/lang/jvm/source/JvmDeclarationSearcher.java) |
| [com.intellij.jvm.elementProvider](https://jb.gg/ipe?extensions=com.intellij.jvm.elementProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[JvmElementProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/lang/jvm/facade/JvmElementProvider.java) |
| [com.intellij.lang.dumb.mode.supported](https://jb.gg/ipe?extensions=com.intellij.lang.dumb.mode.supported)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[JvmLanguageDumbAware](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/lang/jvm/JvmLanguageDumbAware.java) |
| [com.intellij.lang.inferredAnnotationProvider](https://jb.gg/ipe?extensions=com.intellij.lang.inferredAnnotationProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[InferredAnnotationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/codeInsight/InferredAnnotationProvider.java) |
| [com.intellij.lang.jvm.multiReleaseSupport](https://jb.gg/ipe?extensions=com.intellij.lang.jvm.multiReleaseSupport)      |[JavaMultiReleaseModuleSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-impl/src/com/intellij/psi/util/JavaMultiReleaseModuleSupport.java) |
| [com.intellij.lang.psiAugmentProvider](https://jb.gg/ipe?extensions=com.intellij.lang.psiAugmentProvider)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[PsiAugmentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/augment/PsiAugmentProvider.java) |
| [com.intellij.packageDirectoryProvider](https://jb.gg/ipe?extensions=com.intellij.packageDirectoryProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[PackageDirectoryProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-api/src/com/intellij/psi/PackageDirectoryProvider.java) |
| [com.intellij.psi.clsCustomNavigationPolicy](https://jb.gg/ipe?extensions=com.intellij.psi.clsCustomNavigationPolicy)      |[ClsCustomNavigationPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-psi-impl/src/com/intellij/psi/impl/compiled/ClsCustomNavigationPolicy.java) |
| [com.intellij.superMethodsSearch](https://jb.gg/ipe?extensions=com.intellij.superMethodsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |

### intellij.java.remoteServers.impl.xml

[intellij.java.remoteServers.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/remote-servers/impl/resources/intellij.java.remoteServers.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.remoteServer.moduleBuilderContribution](https://jb.gg/ipe?extensions=com.intellij.remoteServer.moduleBuilderContribution)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[CloudModuleBuilderContributionFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/remote-servers/impl/src/com/intellij/remoteServer/impl/module/CloudModuleBuilderContributionFactory.java) |

### intellij.java.syntax.xml

[intellij.java.syntax.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-syntax/resources/intellij.java.syntax.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.java.syntax.languageLevelProvider](https://jb.gg/ipe?extensions=com.intellij.java.syntax.languageLevelProvider)      |[JavaLanguageLevelProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-syntax/src/com/intellij/java/syntax/element/JavaLanguageLevelProvider.kt) |

### intellij.java.ui.xml

[intellij.java.ui.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/resources/intellij.java.ui.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.configuration.ModuleStructureExtension](https://jb.gg/ipe?extensions=com.intellij.configuration.ModuleStructureExtension)      |[ModuleStructureExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/openapi/roots/ui/configuration/projectRoot/ModuleStructureExtension.java) |
| [com.intellij.disableCompilationDependenciesResolutionTask](https://jb.gg/ipe?extensions=com.intellij.disableCompilationDependenciesResolutionTask)      ![Obsolete](https://img.shields.io/badge/-Obsolete-grey?style=flat-square) |[DisableCompilationDependenciesResolutionTask](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/jarRepository/CompilationDependenciesResolutionTask.kt) |
| [com.intellij.framework.type](https://jb.gg/ipe?extensions=com.intellij.framework.type)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[FrameworkTypeEx](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/framework/FrameworkTypeEx.java) |
| [com.intellij.frameworkSupportCommunicator](https://jb.gg/ipe?extensions=com.intellij.frameworkSupportCommunicator)      |[FrameworkSupportCommunicator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/ide/util/newProjectWizard/impl/FrameworkSupportCommunicator.java) |
| [com.intellij.jarRepositoryAuthenticationDataProvider](https://jb.gg/ipe?extensions=com.intellij.jarRepositoryAuthenticationDataProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[JarRepositoryAuthenticationDataProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/jarRepository/JarRepositoryAuthenticationDataProvider.kt) |
| [com.intellij.library.javaSourceRootDetector](https://jb.gg/ipe?extensions=com.intellij.library.javaSourceRootDetector)      |[RootDetector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/openapi/roots/libraries/ui/RootDetector.java) |
| [com.intellij.librarySourcesMismatchSuppressor](https://jb.gg/ipe?extensions=com.intellij.librarySourcesMismatchSuppressor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[LibrarySourcesMismatchSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/codeInsight/daemon/impl/LibrarySourcesMismatchSuppressor.kt) |
| [com.intellij.newProjectWizard.java.buildSystem](https://jb.gg/ipe?extensions=com.intellij.newProjectWizard.java.buildSystem)      |[BuildSystemJavaNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/ide/projectWizard/generators/BuildSystemJavaNewProjectWizard.kt) |
| [com.intellij.projectImportBuilder](https://jb.gg/ipe?extensions=com.intellij.projectImportBuilder)      |[ProjectImportBuilder](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/projectImport/ProjectImportBuilder.java) |
| [com.intellij.projectImportProvider](https://jb.gg/ipe?extensions=com.intellij.projectImportProvider)      |[ProjectImportProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/projectImport/ProjectImportProvider.java) |
| [com.intellij.projectStructureConfigurableFilter](https://jb.gg/ipe?extensions=com.intellij.projectStructureConfigurableFilter)      |[ProjectStructureConfigurableFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/openapi/roots/ui/configuration/ProjectStructureConfigurableFilter.java) |
| [com.intellij.projectStructureDetector](https://jb.gg/ipe?extensions=com.intellij.projectStructureDetector)      |[ProjectStructureDetector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/ide/util/projectWizard/importSources/ProjectStructureDetector.java) |
| [com.intellij.projectStructureValidator](https://jb.gg/ipe?extensions=com.intellij.projectStructureValidator)      |[ProjectStructureValidator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/openapi/roots/ui/configuration/projectRoot/daemon/ProjectStructureValidator.java) |
| [com.intellij.projectWizard.projectCategory](https://jb.gg/ipe?extensions=com.intellij.projectWizard.projectCategory)      |[ProjectCategory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/ide/projectWizard/ProjectCategory.java) |
| [com.intellij.sdkEditorAdditionalOptionsProvider](https://jb.gg/ipe?extensions=com.intellij.sdkEditorAdditionalOptionsProvider)      |[SdkEditorAdditionalOptionsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/openapi/SdkEditorAdditionalOptionsProvider.java) |
| [com.intellij.starter.moduleImporter](https://jb.gg/ipe?extensions=com.intellij.starter.moduleImporter)      |[StarterModuleImporter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/idea-ui/src/com/intellij/ide/starters/StarterModuleImporter.kt) |

### intellij.java.xml

[intellij.java.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/resources/intellij.java.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.attachSourcesProvider](https://jb.gg/ipe?extensions=com.intellij.attachSourcesProvider)      |[AttachSourcesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/codeInsight/AttachSourcesProvider.java) |
| [com.intellij.attachSourcesProviderFilter](https://jb.gg/ipe?extensions=com.intellij.attachSourcesProviderFilter)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[AttachSourcesProviderFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/codeInsight/AttachSourcesProviderFilter.kt) |
| [com.intellij.debuggerClassFilterProvider](https://jb.gg/ipe?extensions=com.intellij.debuggerClassFilterProvider)      |[DebuggerClassFilterProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/ui/classFilter/DebuggerClassFilterProvider.java) |
| [com.intellij.encapsulateFields.Helper](https://jb.gg/ipe?extensions=com.intellij.encapsulateFields.Helper)      |[EncapsulateFieldHelper](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/refactoring/encapsulateFields/EncapsulateFieldHelper.java) |
| [com.intellij.hierarchy.elementProvider](https://jb.gg/ipe?extensions=com.intellij.hierarchy.elementProvider)      |[CallHierarchyElementProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/ide/hierarchy/call/CallHierarchyElementProvider.java) |
| [com.intellij.hierarchy.referenceProcessor](https://jb.gg/ipe?extensions=com.intellij.hierarchy.referenceProcessor)      |[CallReferenceProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/ide/hierarchy/call/CallReferenceProcessor.java) |
| [com.intellij.javaExpressionSurrounder](https://jb.gg/ipe?extensions=com.intellij.javaExpressionSurrounder)      |[JavaExpressionSurrounder](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/codeInsight/generation/surroundWith/JavaExpressionSurrounder.java) |
| [com.intellij.methodImplementor](https://jb.gg/ipe?extensions=com.intellij.methodImplementor)      |[MethodImplementor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/codeInsight/MethodImplementor.java) |
| [com.intellij.refactoring.pullUpHelperFactory](https://jb.gg/ipe?extensions=com.intellij.refactoring.pullUpHelperFactory)      |[PullUpHelperFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/refactoring/memberPullUp/PullUpHelperFactory.java) |
| [com.intellij.refactoring.safeDelete.JavaSafeDeleteDelegate](https://jb.gg/ipe?extensions=com.intellij.refactoring.safeDelete.JavaSafeDeleteDelegate)      |[JavaSafeDeleteDelegate](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/refactoring/safeDelete/JavaSafeDeleteDelegate.java) |
| [com.intellij.repositoryLibrary](https://jb.gg/ipe?extensions=com.intellij.repositoryLibrary)      |`n/a` |
| [com.intellij.unscrambleSupport](https://jb.gg/ipe?extensions=com.intellij.unscrambleSupport)      |[UnscrambleSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/openapi/src/com/intellij/unscramble/UnscrambleSupport.java) |

### intellij.jvm.analysis.impl.xml

[intellij.jvm.analysis.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/jvm/jvm-analysis-impl/resources/intellij.jvm.analysis.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.canBeEmpty](https://jb.gg/ipe?extensions=com.intellij.canBeEmpty)      |[Condition](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/openapi/util/Condition.java) |
| [com.intellij.codeInspection.sourceToSinkProvider](https://jb.gg/ipe?extensions=com.intellij.codeInspection.sourceToSinkProvider)      |[SourceToSinkProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/jvm/jvm-analysis-impl/src/com/intellij/codeInspection/sourceToSink/SourceToSinkLangugeProvider.kt) |

### intellij.jvm.analysis.xml

[intellij.jvm.analysis.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/jvm/jvm-analysis-api/resources/intellij.jvm.analysis.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.codeInsight.blockingMethodChecker](https://jb.gg/ipe?extensions=com.intellij.codeInsight.blockingMethodChecker)      |[BlockingMethodChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/jvm/jvm-analysis-api/src/com/intellij/codeInspection/blockingCallsDetection/BlockingMethodChecker.java) |
| [com.intellij.codeInsight.nonBlockingContextChecker](https://jb.gg/ipe?extensions=com.intellij.codeInsight.nonBlockingContextChecker)      |[NonBlockingContextChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/jvm/jvm-analysis-api/src/com/intellij/codeInspection/blockingCallsDetection/NonBlockingContextChecker.java) |
| [com.intellij.codeInsight.unstableApiUsageFilter](https://jb.gg/ipe?extensions=com.intellij.codeInsight.unstableApiUsageFilter)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[UnstableApiUsageFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/jvm/jvm-analysis-api/src/com/intellij/codeInspection/UnstableApiUsageFilter.kt) |

### java-debugger.xml

[java-debugger.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/resources/META-INF/java-debugger.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.debugger.additionalContextProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.additionalContextProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[AdditionalContextProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/engine/evaluation/EvaluationContextWrapper.kt) |
| [com.intellij.debugger.agentParametersModifier](https://jb.gg/ipe?extensions=com.intellij.debugger.agentParametersModifier)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[DebuggerAgentParametersModifier](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/DebuggerAgentParametersModifier.kt) |
| [com.intellij.debugger.agentProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.agentProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[DebuggerAgentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/DebuggerAgentProvider.kt) |
| [com.intellij.debugger.asyncStackTraceProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.asyncStackTraceProvider)      |[AsyncStackTraceProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/AsyncStackTraceProvider.java) |
| [com.intellij.debugger.breakpointThreadDumpCapture](https://jb.gg/ipe?extensions=com.intellij.debugger.breakpointThreadDumpCapture)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[BreakpointThreadDumpCapture](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/ui/breakpoints/BreakpointThreadDumpCapture.kt) |
| [com.intellij.debugger.compoundRendererProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.compoundRendererProvider)      |[CompoundRendererProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/ui/tree/render/CompoundRendererProvider.java) |
| [com.intellij.debugger.creationStackTraceProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.creationStackTraceProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[CreationStackTraceProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/CreationStackTraceProvider.kt) |
| [com.intellij.debugger.dfaAssistProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.dfaAssistProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[DfaAssistProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/dfaassist/DfaAssistProvider.kt) |
| [com.intellij.debugger.dumpItemsProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.dumpItemsProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ThreadDumpItemsProviderFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/impl/ThreadDumpItemsProviderFactory.kt) |
| [com.intellij.debugger.evaluationExpressionConverter](https://jb.gg/ipe?extensions=com.intellij.debugger.evaluationExpressionConverter)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[DebuggerEvaluationExpressionConverter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/evaluation/DebuggerEvaluationExpressionConverter.kt) |
| [com.intellij.debugger.extraDebugNodesProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.extraDebugNodesProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[ExtraDebugNodesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/ui/tree/ExtraDebugNodesProvider.kt) |
| [com.intellij.debugger.extraSteppingFilter](https://jb.gg/ipe?extensions=com.intellij.debugger.extraSteppingFilter)      |[ExtraSteppingFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/ExtraSteppingFilter.java) |
| [com.intellij.debugger.fieldVisibilityProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.fieldVisibilityProvider)      |[FieldVisibilityProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/openapi/src/com/intellij/debugger/engine/FieldVisibilityProvider.kt) |
| [com.intellij.debugger.frameExtraVarsProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.frameExtraVarsProvider)      |[FrameExtraVariablesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/FrameExtraVariablesProvider.java) |
| [com.intellij.debugger.hotSwapSourceChangeCompatibilityCheckerProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.hotSwapSourceChangeCompatibilityCheckerProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[HotSwapSourceChangeCompatibilityCheckerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/impl/hotswap/HotSwapSourceChangeCompatibilityCheckerProvider.kt) |
| [com.intellij.debugger.hotSwapSourceFileFilterProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.hotSwapSourceFileFilterProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[HotSwapSourceFileFilterProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/impl/hotswap/HotSwapSourceFileFilterProvider.kt) |
| [com.intellij.debugger.javaBreakpointHandlerFactory](https://jb.gg/ipe?extensions=com.intellij.debugger.javaBreakpointHandlerFactory)      |[JavaBreakpointHandlerFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/JavaBreakpointHandlerFactory.java) |
| [com.intellij.debugger.jdiHelperClassLoader](https://jb.gg/ipe?extensions=com.intellij.debugger.jdiHelperClassLoader)      |[JdiHelperClassLoader](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/impl/JdiHelperClassLoader.kt) |
| [com.intellij.debugger.jvmHotSwapListener](https://jb.gg/ipe?extensions=com.intellij.debugger.jvmHotSwapListener)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JvmHotSwapListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/impl/hotswap/JvmHotSwapListener.kt) |
| [com.intellij.debugger.jvmSmartStepIntoHandler](https://jb.gg/ipe?extensions=com.intellij.debugger.jvmSmartStepIntoHandler)      |[JvmSmartStepIntoHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/actions/JvmSmartStepIntoHandler.java) |
| [com.intellij.debugger.jvmSteppingCommandProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.jvmSteppingCommandProvider)      |[JvmSteppingCommandProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/impl/JvmSteppingCommandProvider.java) |
| [com.intellij.debugger.nodeRenderer](https://jb.gg/ipe?extensions=com.intellij.debugger.nodeRenderer)      |[NodeRenderer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/ui/tree/render/NodeRenderer.java) |
| [com.intellij.debugger.sourcePositionProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.sourcePositionProvider)      |[SourcePositionProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/SourcePositionProvider.kt) |
| [com.intellij.debugger.specialLineBreakpointCaseProvider](https://jb.gg/ipe?extensions=com.intellij.debugger.specialLineBreakpointCaseProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JvmSpecialLineBreakpointCaseProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/ui/breakpoints/SpecialLineBreakpointCase.kt) |
| [com.intellij.debugger.steppingListener](https://jb.gg/ipe?extensions=com.intellij.debugger.steppingListener)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[SteppingListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/engine/SteppingListener.kt) |
| [com.intellij.debuggerEditorTextProvider](https://jb.gg/ipe?extensions=com.intellij.debuggerEditorTextProvider)      |[EditorTextProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/debugger/impl/src/com/intellij/debugger/impl/EditorTextProvider.java) |

### JavaActions.xml

[JavaActions.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-backend/resources/META-INF/JavaActions.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.java.class.action.suppressor](https://jb.gg/ipe?extensions=com.intellij.java.class.action.suppressor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JavaClassActionSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/ide/actions/JavaClassActionSuppressor.java) |

### JavaCodeServerHighlighting.xml

[JavaCodeServerHighlighting.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/codeserver/highlighting/resources/META-INF/JavaCodeServerHighlighting.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.lang.java.javaErrorFilter](https://jb.gg/ipe?extensions=com.intellij.lang.java.javaErrorFilter)      |[JavaErrorFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/codeserver/highlighting/src/com/intellij/java/codeserver/highlighting/JavaErrorFilter.java) |

### JavaIndexingApi.xml

[JavaIndexingApi.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-indexing-api/resources/META-INF/JavaIndexingApi.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.allClassesSearch](https://jb.gg/ipe?extensions=com.intellij.allClassesSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.allOverridingMethodsSearch](https://jb.gg/ipe?extensions=com.intellij.allOverridingMethodsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.annotatedElementsSearch](https://jb.gg/ipe?extensions=com.intellij.annotatedElementsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.classInheritorsSearch](https://jb.gg/ipe?extensions=com.intellij.classInheritorsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.classesWithAnnotatedMembersSearch](https://jb.gg/ipe?extensions=com.intellij.classesWithAnnotatedMembersSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.directClassInheritorsSearch](https://jb.gg/ipe?extensions=com.intellij.directClassInheritorsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.implicitClassSearch](https://jb.gg/ipe?extensions=com.intellij.implicitClassSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.java.staticMethodNamesCache](https://jb.gg/ipe?extensions=com.intellij.java.staticMethodNamesCache)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[JavaStaticMethodNameCache](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-indexing-api/src/com/intellij/psi/search/JavaStaticMethodNameCache.java) |
| [com.intellij.javaModuleSearch](https://jb.gg/ipe?extensions=com.intellij.javaModuleSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.overridingMethodsSearch](https://jb.gg/ipe?extensions=com.intellij.overridingMethodsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |

### JavaIndexingPlugin.xml

[JavaIndexingPlugin.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-indexing-impl/resources/META-INF/JavaIndexingPlugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.annotatedPackagesSearch](https://jb.gg/ipe?extensions=com.intellij.annotatedPackagesSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.customPropertyScopeProvider](https://jb.gg/ipe?extensions=com.intellij.customPropertyScopeProvider)      |[CustomPropertyScopeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-indexing-impl/src/com/intellij/psi/impl/search/CustomPropertyScopeProvider.java) |
| [com.intellij.functionalExpressionSearch](https://jb.gg/ipe?extensions=com.intellij.functionalExpressionSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.implicitToStringSearch](https://jb.gg/ipe?extensions=com.intellij.implicitToStringSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [com.intellij.java.shortNamesCache](https://jb.gg/ipe?extensions=com.intellij.java.shortNamesCache)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[PsiShortNamesCache](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-indexing-api/src/com/intellij/psi/search/PsiShortNamesCache.java) |
| [com.intellij.methodReferencesSearch](https://jb.gg/ipe?extensions=com.intellij.methodReferencesSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |

### JavaPlugin.xml

[JavaPlugin.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-backend/resources/META-INF/JavaPlugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.OrderRootTypeUI](https://jb.gg/ipe?extensions=com.intellij.OrderRootTypeUI)      |[OrderRootTypeUIFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-api/src/com/intellij/openapi/roots/ui/OrderRootTypeUIFactory.java) |

### ManifestSupport.xml

[ManifestSupport.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/manifest/resources/META-INF/ManifestSupport.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.manifest.parser.provider](https://jb.gg/ipe?extensions=com.intellij.manifest.parser.provider)      |[HeaderParserProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/manifest/src/org/jetbrains/lang/manifest/header/HeaderParserProvider.java) |

### UsageData.xml

[UsageData.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/resources/META-INF/UsageData.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.internal.statistic.libraryUsageImportProcessor](https://jb.gg/ipe?extensions=com.intellij.internal.statistic.libraryUsageImportProcessor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[LibraryUsageImportProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/internal/statistic/libraryUsage/LibraryUsageImportProcessor.kt) |

## JSON Plugin

### JSON Plugin – Listeners

| Topic |Listener |
-------------------
| [RemoteSchemaDownloadListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.jsonSchema.remote.http.RemoteSchemaDownloadListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[RemoteSchemaDownloadListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/remote/http/JsonSchemaRemoteContentService.kt) |
| [JsonSchemaVfsListener#JSON_DEPS_CHANGED](https://jb.gg/ipe/listeners?topics=java.lang.Runnable) |`Runnable` |
| [JsonSchemaVfsListener#JSON_SCHEMA_CHANGED](https://jb.gg/ipe/listeners?topics=java.lang.Runnable) |`Runnable` |

### intellij.json.backend.xml

[intellij.json.backend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/resources/intellij.json.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [JavaScript.JsonSchema.ContentAwareSchemaFileProvider](https://jb.gg/ipe?extensions=JavaScript.JsonSchema.ContentAwareSchemaFileProvider)      |[ContentAwareJsonSchemaFileProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/ContentAwareJsonSchemaFileProvider.java) |
| [JavaScript.JsonSchema.ProviderFactory](https://jb.gg/ipe?extensions=JavaScript.JsonSchema.ProviderFactory)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[JsonSchemaProviderFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/JsonSchemaProviderFactory.java) |
| [com.intellij.json.catalog.exclusion](https://jb.gg/ipe?extensions=com.intellij.json.catalog.exclusion)      |[JsonSchemaCatalogExclusion](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/remote/JsonSchemaCatalogExclusion.java) |
| [com.intellij.json.customStructureViewFactory](https://jb.gg/ipe?extensions=com.intellij.json.customStructureViewFactory)      |[JsonCustomStructureViewFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/intellij/json/structureView/JsonCustomStructureViewFactory.java) |
| [com.intellij.json.jsonLikePsiWalkerFactory](https://jb.gg/ipe?extensions=com.intellij.json.jsonLikePsiWalkerFactory)      |[JsonLikePsiWalkerFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/JsonLikePsiWalkerFactory.java) |
| [com.intellij.json.jsonSchemaCompletionCustomizer](https://jb.gg/ipe?extensions=com.intellij.json.jsonSchemaCompletionCustomizer)      |[JsonSchemaCompletionCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/JsonSchemaCompletionCustomizer.java) |
| [com.intellij.json.jsonSchemaEnabler](https://jb.gg/ipe?extensions=com.intellij.json.jsonSchemaEnabler)      |[JsonSchemaEnabler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/JsonSchemaEnabler.java) |
| [com.intellij.json.jsonSchemaGotoDeclarationSuppressor](https://jb.gg/ipe?extensions=com.intellij.json.jsonSchemaGotoDeclarationSuppressor)      |[JsonSchemaGotoDeclarationSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/JsonSchemaGotoDeclarationSuppressor.java) |
| [com.intellij.json.jsonSchemaNestedCompletionsTreeProvider](https://jb.gg/ipe?extensions=com.intellij.json.jsonSchemaNestedCompletionsTreeProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[JsonSchemaNestedCompletionsTreeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/JsonSchemaNestedCompletionsTreeProvider.kt) |
| [com.intellij.json.jsonSchemaQuickFixSuppressor](https://jb.gg/ipe?extensions=com.intellij.json.jsonSchemaQuickFixSuppressor)      |[JsonSchemaQuickFixSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/JsonSchemaQuickFixSuppressor.kt) |
| [com.intellij.json.jsonStandardComplianceProvider](https://jb.gg/ipe?extensions=com.intellij.json.jsonStandardComplianceProvider)      |[JsonStandardComplianceProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/intellij/json/codeinsight/JsonStandardComplianceProvider.java) |
| [com.intellij.json.jsonWidgetSuppressor](https://jb.gg/ipe?extensions=com.intellij.json.jsonWidgetSuppressor)      |[JsonWidgetSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/JsonWidgetSuppressor.java) |
| [com.intellij.json.shorthandValueHandler](https://jb.gg/ipe?extensions=com.intellij.json.shorthandValueHandler)      |[JsonSchemaShorthandValueHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/jetbrains/jsonSchema/extension/JsonSchemaShorthandValueHandler.kt) |

### intellij.json.xml

[intellij.json.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/resources/intellij.json.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.json.jsonLiteralChecker](https://jb.gg/ipe?extensions=com.intellij.json.jsonLiteralChecker)      |[JsonLiteralChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/src/com/intellij/json/codeinsight/JsonLiteralChecker.java) |
| [com.intellij.json.lazyParsingVetoer](https://jb.gg/ipe?extensions=com.intellij.json.lazyParsingVetoer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[JsonLazyParsingVetoer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/syntax/src/com/intellij/json/syntax/JsonLazyParsing.kt) |

## Kotlin Plugin

### Kotlin Plugin – Listeners

| Topic |Listener |
-------------------
| [KotlinCompilerPluginsScriptConfigurationListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.kotlin.idea.compiler.configuration.KotlinCompilerPluginsScriptConfigurationListener)  ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[KotlinCompilerPluginsScriptConfigurationListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/compiler-configuration/src/org/jetbrains/kotlin/idea/compiler/configuration/KotlinCompilerPluginsScriptConfigurationListener.kt) |
| [KotlinCompilerSettingsListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.kotlin.idea.compiler.configuration.KotlinCompilerSettingsListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[KotlinCompilerSettingsListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/compiler-configuration/src/org/jetbrains/kotlin/idea/compiler/configuration/BaseKotlinCompilerSettings.kt) |
| [ReloadScriptConfigurationService#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.kotlin.idea.core.script.ReloadScriptConfigurationService.Listener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[Listener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/scripting/scripting/src/org/jetbrains/kotlin/idea/core/script/reloadScript.kt) |
| [K2MoveDeclarationsRefactoringListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.kotlin.idea.k2.refactoring.move.processor.K2MoveDeclarationsRefactoringListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[K2MoveDeclarationsRefactoringListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/refactorings/kotlin.refactorings.k2/src/org/jetbrains/kotlin/idea/k2/refactoring/move/processor/K2MoveDeclarationsRefactoringListener.kt) |
| [KotlinBundledUsageDetector#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.kotlin.idea.macros.KotlinBundledUsageDetectorListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[KotlinBundledUsageDetectorListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/project-structure/src/org/jetbrains/kotlin/idea/macros/KotlinBundledUsageDetectorListener.kt) |
| [KotlinRefactoringListener.Companion#EVENT_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.kotlin.idea.refactoring.KotlinRefactoringListener) |[KotlinRefactoringListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/refactorings/kotlin.refactorings.common/src/org/jetbrains/kotlin/idea/refactoring/KotlinRefactoringListener.kt) |
| [KotlinCorruptedIndexListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.kotlin.idea.stubindex.resolve.KotlinCorruptedIndexListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[KotlinCorruptedIndexListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/analysis/src/org/jetbrains/kotlin/idea/stubindex/resolve/KotlinCorruptedIndexListener.kt) |

### intellij.kotlin.base.analysis.xml

[intellij.kotlin.base.analysis.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/analysis/resources/intellij.kotlin.base.analysis.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.kotlinInjectedFilesAnalysisProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.kotlinInjectedFilesAnalysisProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[KotlinIdeInjectedFilesAnalysisPromoter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/analysis/src/org/jetbrains/kotlin/idea/base/analysis/KotlinIdeInjectedFilesAnalysisPromoter.kt) |

### intellij.kotlin.base.codeInsight.minimal.xml

[intellij.kotlin.base.codeInsight.minimal.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/code-insight/minimal/resource/intellij.kotlin.base.codeInsight.minimal.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.smartEnterProcessorFixer](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.smartEnterProcessorFixer)      |[Fixer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/lang/SmartEnterProcessorWithFixers.java) |

### intellij.kotlin.base.codeInsight.xml

[intellij.kotlin.base.codeInsight.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/code-insight/resources/intellij.kotlin.base.codeInsight.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.classImportFilter](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.classImportFilter)      |[ClassImportFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/code-insight/src/org/jetbrains/kotlin/idea/util/ClassImportFilter.kt) |
| [org.jetbrains.kotlin.idePlatformKindTooling](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idePlatformKindTooling)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[IdePlatformKindTooling](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/code-insight/src/org/jetbrains/kotlin/idea/base/codeInsight/tooling/IdePlatformKindTooling.kt) |

### intellij.kotlin.base.compilerConfiguration.ui.xml

[intellij.kotlin.base.compilerConfiguration.ui.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/compiler-configuration-ui/resources/intellij.kotlin.base.compilerConfiguration.ui.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.facetValidatorCreator](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.facetValidatorCreator)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[KotlinFacetValidatorCreator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/compiler-configuration-ui/src/org/jetbrains/kotlin/idea/base/compilerPreferences/facet/KotlinFacetValidatorCreator.kt) |

### intellij.kotlin.base.facet.xml

[intellij.kotlin.base.facet.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/facet/resources/intellij.kotlin.base.facet.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.buildSystemTypeDetector](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.buildSystemTypeDetector)      |[BuildSystemTypeDetector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/facet/src/org/jetbrains/kotlin/idea/configuration/BuildSystemType.kt) |
| [org.jetbrains.kotlin.facetConfigurationExtension](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.facetConfigurationExtension)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[KotlinFacetConfigurationExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/facet/src/org/jetbrains/kotlin/idea/facet/KotlinFacetConfigurationExtension.kt) |
| [org.jetbrains.kotlin.idea.base.platforms.targetPlatformDetector](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.base.platforms.targetPlatformDetector)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[TargetPlatformDetector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/facet/src/org/jetbrains/kotlin/idea/base/facet/platform/TargetPlatformDetector.kt) |
| [org.jetbrains.kotlin.versionInfoProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.versionInfoProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[KotlinVersionInfoProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/facet/src/org/jetbrains/kotlin/idea/facet/KotlinVersionInfoProvider.kt) |

### intellij.kotlin.base.jps.xml

[intellij.kotlin.base.jps.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/jps/resources/intellij.kotlin.base.jps.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.idePlatformKind](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idePlatformKind)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`IdePlatformKind` |

### intellij.kotlin.base.plugin.xml

[intellij.kotlin.base.plugin.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/plugin/resources/intellij.kotlin.base.plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.supportsKotlinPluginMode](https://jb.gg/ipe?extensions=com.intellij.supportsKotlinPluginMode)      ![Removal](https://img.shields.io/badge/-Removal-red?style=flat-square) |`n/a` |
| [org.jetbrains.kotlin.failedToDownloadJpsMavenArtifactSuggestedSolutionsContributor](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.failedToDownloadJpsMavenArtifactSuggestedSolutionsContributor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[FailedToDownloadJpsMavenArtifactSuggestedSolutionsContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/plugin/src/org/jetbrains/kotlin/idea/compiler/configuration/FailedToDownloadJpsMavenArtifactSuggestedSolutionsContributor.kt) |
| [org.jetbrains.kotlin.kotlinCompilerVersionProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.kotlinCompilerVersionProvider)      |[KotlinCompilerVersionProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/plugin/src/org/jetbrains/kotlin/idea/base/plugin/KotlinCompilerVersionProvider.kt) |

### intellij.kotlin.base.projectStructure.xml

[intellij.kotlin.base.projectStructure.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/project-structure/resources/intellij.kotlin.base.projectStructure.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.binaryExtension](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.binaryExtension)      |[KotlinBinaryExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/project-structure/src/org/jetbrains/kotlin/idea/base/projectStructure/KotlinBinaryExtension.kt) |
| [org.jetbrains.kotlin.idea.base.externalSystem.kotlinBuildSystemFacade](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.base.externalSystem.kotlinBuildSystemFacade)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[KotlinBuildSystemFacade](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/project-structure/src/org/jetbrains/kotlin/idea/base/externalSystem/KotlinBuildSystemFacade.kt) |
| [org.jetbrains.kotlin.newFileHook](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.newFileHook)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[NewKotlinFileHook](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/project-structure/src/org/jetbrains/kotlin/idea/base/projectStructure/NewKotlinFileHook.kt) |
| [org.jetbrains.kotlin.resolveScopeEnlarger](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.resolveScopeEnlarger)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[KotlinResolveScopeEnlarger](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/project-structure/src/org/jetbrains/kotlin/idea/base/projectStructure/KotlinResolveScopeEnlarger.kt) |

### intellij.kotlin.base.psi.xml

[intellij.kotlin.base.psi.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/psi/resources/intellij.kotlin.base.psi.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.implementationDetailClassNameCheckerProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.implementationDetailClassNameCheckerProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ImplementationDetailClassNameCheckerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/psi/src/org/jetbrains/kotlin/idea/base/psi/extensions/ImplementationDetailClassNameCheckerProvider.kt) |

### intellij.kotlin.base.scripting.xml

[intellij.kotlin.base.scripting.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/scripting/scripting/resources/intellij.kotlin.base.scripting.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.kotlinScriptFilter](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.kotlinScriptFilter)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[KotlinScriptProcessingFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/scripting/scripting/src/org/jetbrains/kotlin/idea/core/script/configurations/KotlinScriptProcessingFilter.kt) |
| [org.jetbrains.kotlin.scriptAfterRunCallbackProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.scriptAfterRunCallbackProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ScriptAfterRunCallbackProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/scripting/scripting/src/org/jetbrains/kotlin/idea/core/script/ScriptAfterRunCallbackProvider.kt) |
| [org.jetbrains.kotlin.scriptDefinitionsProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.scriptDefinitionsProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ScriptDefinitionsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/scripting/src/kotlin/script/experimental/intellij/scriptDefinitionProvider.kt) |
| [org.jetbrains.kotlin.scriptDiagnosticFixProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.scriptDiagnosticFixProvider)      |[ScriptDiagnosticFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/scripting/scripting/src/org/jetbrains/kotlin/idea/core/script/ScriptDiagnosticFixProvider.kt) |
| [org.jetbrains.kotlin.scriptEntityProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.scriptEntityProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[KotlinScriptEntityProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/scripting/scripting/src/org/jetbrains/kotlin/idea/core/script/modules/KotlinScriptEntityProvider.kt) |
| [org.jetbrains.kotlin.scripting.definitions.scriptDefinitionProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.scripting.definitions.scriptDefinitionProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`ScriptDefinitionProvider` |

### intellij.kotlin.codeInsight.api.xml

[intellij.kotlin.codeInsight.api.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/api/resources/intellij.kotlin.codeInsight.api.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.kotlin.autoImportCallableWeigher](https://jb.gg/ipe?extensions=com.intellij.kotlin.autoImportCallableWeigher)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[KotlinAutoImportCallableWeigher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/api/src/org/jetbrains/kotlin/idea/codeinsight/api/classic/quickfixes/KotlinAutoImportCallableWeigher.kt) |
| [org.jetbrains.kotlin.codeinsight.quickfix.registrar](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.codeinsight.quickfix.registrar)      |[KotlinQuickFixRegistrar](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/api/src/org/jetbrains/kotlin/idea/codeinsight/api/applicators/fixes/KotlinQuickFixService.kt) |
| [org.jetbrains.kotlin.equalsHashCodeGeneratorExtension](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.equalsHashCodeGeneratorExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[KotlinEqualsHashCodeGeneratorExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/api/src/org/jetbrains/kotlin/idea/codeinsight/api/applicable/extensions/KotlinEqualsHashCodeGeneratorExtension.kt) |
| [org.jetbrains.kotlin.forwardDeclarationPolicyProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.forwardDeclarationPolicyProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ForwardDeclarationPolicyProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/api/src/org/jetbrains/kotlin/idea/codeinsight/api/applicable/extensions/ForwardDeclarationPolicyProvider.kt) |
| [org.jetbrains.kotlin.kaDanglingFileResolutionModeProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.kaDanglingFileResolutionModeProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[KaDanglingFileResolutionModeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/api/src/org/jetbrains/kotlin/idea/codeinsight/api/applicable/extensions/KaDanglingFileResolutionModeProvider.kt) |

### intellij.kotlin.codeInsight.utils.xml

[intellij.kotlin.codeInsight.utils.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/utils/resources/intellij.kotlin.codeInsight.utils.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.supportAvailability](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.supportAvailability)      |[KotlinSupportAvailability](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/utils/src/org/jetbrains/kotlin/idea/codeinsight/utils/KotlinSupportAvailability.kt) |

### intellij.kotlin.codeInsight.xml

[intellij.kotlin.codeInsight.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/kotlin.code-insight.k2/resources/intellij.kotlin.codeInsight.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.structureViewExtension](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.structureViewExtension)      |[KotlinStructureViewExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/code-insight/kotlin.code-insight.k2/src/org/jetbrains/kotlin/idea/k2/codeinsight/structureView/KotlinStructureViewExtension.kt) |

### intellij.kotlin.compilerPlugins.parcelize.xml

[intellij.kotlin.compilerPlugins.parcelize.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/compiler-plugins/parcelize/k2/resources/intellij.kotlin.compilerPlugins.parcelize.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.idea.compilerPlugin.parcelize.availabilityProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.compilerPlugin.parcelize.availabilityProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ParcelizeAvailabilityProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/compiler-plugins/parcelize/k2/src/org/jetbrains/kotlin/idea/compilerPlugin/parcelize/ParcelizeAvailability.kt) |

### intellij.kotlin.compilerPlugins.support.bundled.xml

[intellij.kotlin.compilerPlugins.support.bundled.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/bundled-compiler-plugins-support/resources/intellij.kotlin.compilerPlugins.support.bundled.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.bundledFirCompilerPluginProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.bundledFirCompilerPluginProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[KotlinBundledFirCompilerPluginProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/bundled-compiler-plugins-support/src/org/jetbrains/kotlin/idea/fir/extensions/KotlinBundledFirCompilerPluginProvider.kt) |
| [org.jetbrains.kotlin.firCompilerPluginConfigurationProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.firCompilerPluginConfigurationProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[KotlinFirCompilerPluginConfigurationForIdeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/bundled-compiler-plugins-support/src/org/jetbrains/kotlin/idea/fir/extensions/KotlinFirCompilerPluginConfigurationForIdeProvider.kt) |

### intellij.kotlin.compilerReferenceIndex.xml

[intellij.kotlin.compilerReferenceIndex.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/compiler-reference-index/resources/intellij.kotlin.compilerReferenceIndex.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.kotlinCompilerReferenceIndexStorageProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.kotlinCompilerReferenceIndexStorageProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[KotlinCompilerReferenceIndexStorageProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/compiler-reference-index/src/org/jetbrains/kotlin/idea/search/refIndex/KotlinCompilerReferenceIndexStorageProvider.kt) |

### intellij.kotlin.gradle.codeInsight.common.xml

[intellij.kotlin.gradle.codeInsight.common.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/code-insight-common/resources/intellij.kotlin.gradle.codeInsight.common.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.idea.gradleBuildScriptSupport](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.gradleBuildScriptSupport)      |[GradleBuildScriptSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/code-insight-common/src/org/jetbrains/kotlin/idea/gradleCodeInsightCommon/GradleBuildScriptSupport.kt) |

### intellij.kotlin.gradle.gradle.xml

[intellij.kotlin.gradle.gradle.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle/resources/intellij.kotlin.gradle.gradle.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.gradleModelFacade](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.gradleModelFacade)      |[KotlinGradleModelFacade](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle/src/org/jetbrains/kotlin/idea/gradle/inspections/KotlinGradleModelFacade.java) |
| [org.jetbrains.kotlin.idea.extrasSerialization](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.extrasSerialization)      |[KotlinExtrasSerializationService](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle/src/org/jetbrains/kotlin/idea/gradle/configuration/serialize/KotlinExtrasSerializationService.kt) |
| [org.jetbrains.kotlin.kpm.createRoots](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.kpm.createRoots)      |[ContentRootsCreator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle/src/org/jetbrains/kotlin/idea/gradle/configuration/kpm/ContentRootsCreator.kt) |
| [org.jetbrains.kotlin.kpm.moduleInitialize](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.kpm.moduleInitialize)      |[ModuleDataInitializer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle/src/org/jetbrains/kotlin/idea/gradle/configuration/kpm/ModuleDataInitializer.kt) |

### intellij.kotlin.gradle.tooling.xml

[intellij.kotlin.gradle.tooling.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle-tooling/resources/intellij.kotlin.gradle.tooling.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.idea.gradleTooling.serialization.IdeaKotlinSerializationContext](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.gradleTooling.serialization.IdeaKotlinSerializationContext)      |`IdeaKotlinSerializationContext` |

### intellij.kotlin.highlighting.minimal.xml

[intellij.kotlin.highlighting.minimal.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/highlighting/highlighting-minimal/resource/intellij.kotlin.highlighting.minimal.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.beforeResolveHighlightingVisitor](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.beforeResolveHighlightingVisitor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[BeforeResolveHighlightingExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/highlighting/highlighting-minimal/src/org/jetbrains/kotlin/idea/base/highlighting/BeforeResolveHighlightingExtension.kt) |

### intellij.kotlin.highlighting.xml

[intellij.kotlin.highlighting.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/highlighting/highlighting-k2/resources/intellij.kotlin.highlighting.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.callHighlighterExtension](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.callHighlighterExtension)      |[KotlinCallHighlighterExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/highlighting/highlighting-k2/src/org/jetbrains/kotlin/idea/highlighting/KotlinCallHighlighterExtension.kt) |

### intellij.kotlin.j2k.xml

[intellij.kotlin.j2k.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/j2k/k2/resources/intellij.kotlin.j2k.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.j2kNullabilityInferenceExtension](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.j2kNullabilityInferenceExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[J2KNullabilityInferenceExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/j2k/k2/src/org/jetbrains/kotlin/j2k/J2KNullabilityInferenceExtension.kt) |
| [org.jetbrains.kotlin.j2kPostprocessorExtension](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.j2kPostprocessorExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[J2kPostprocessorExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/j2k/k2/src/org/jetbrains/kotlin/j2k/preAndPostprocessorExtension.kt) |
| [org.jetbrains.kotlin.j2kPreprocessorExtension](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.j2kPreprocessorExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[J2kPreprocessorExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/j2k/k2/src/org/jetbrains/kotlin/j2k/preAndPostprocessorExtension.kt) |

### intellij.kotlin.jvm.debugger.core.xml

[intellij.kotlin.jvm.debugger.core.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/jvm-debugger/core/resources/intellij.kotlin.jvm.debugger.core.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.debugger.dexBytecodeInspector](https://jb.gg/ipe?extensions=com.intellij.debugger.dexBytecodeInspector)      |[DexBytecodeInspector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/jvm-debugger/core/src/org/jetbrains/kotlin/idea/debugger/core/DexBytecodeInspector.kt) |
| [com.intellij.debugger.kotlinStackFrameValueContributor](https://jb.gg/ipe?extensions=com.intellij.debugger.kotlinStackFrameValueContributor)      |[KotlinStackFrameValueContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/jvm-debugger/core/src/org/jetbrains/kotlin/idea/debugger/core/stackFrame/KotlinStackFrameValueContributor.kt) |
| [org.jetbrains.kotlin.idea.debugger.base.util.classNameCalculator](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.debugger.base.util.classNameCalculator)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |[ClassNameCalculator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/jvm-debugger/base/util/src/org/jetbrains/kotlin/idea/debugger/base/util/ClassNameCalculator.kt) |
| [org.jetbrains.kotlin.idea.debugger.core.classNameContributor](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.debugger.core.classNameContributor)      |[ClassNameContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/jvm-debugger/core/src/org/jetbrains/kotlin/idea/debugger/core/ClassNameProvider.kt) |

### intellij.kotlin.maven.xml

[intellij.kotlin.maven.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/maven/resources/intellij.kotlin.maven.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.mavenProjectImportHandler](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.mavenProjectImportHandler)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[MavenProjectImportHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/maven/src/org/jetbrains/kotlin/idea/maven/KotlinMavenImporter.kt) |

### intellij.kotlin.navigation.xml

[intellij.kotlin.navigation.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/navigation/resouces/intellij.kotlin.navigation.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.clsCustomNavigationPolicy](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.clsCustomNavigationPolicy)      |[KotlinClsCustomNavigationPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/navigation/src/org/jetbrains/kotlin/idea/navigation/KotlinClsCustomNavigationPolicy.kt) |

### intellij.kotlin.plugin.updater.xml

[intellij.kotlin.plugin.updater.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/plugin-updater/resources/intellij.kotlin.plugin.updater.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.pluginUpdateVerifier](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.pluginUpdateVerifier)      |[PluginUpdateVerifier](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/plugin-updater/src/org/jetbrains/kotlin/idea/update/PluginUpdateVerifier.kt) |

### intellij.kotlin.preferences.xml

[intellij.kotlin.preferences.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/preferences/resources/intellij.kotlin.preferences.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.experimentalFeature](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.experimentalFeature)      |[ExperimentalFeature](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/preferences/src/org/jetbrains/kotlin/idea/configuration/ExperimentalFeatures.kt) |

### intellij.kotlin.projectConfiguration.xml

[intellij.kotlin.projectConfiguration.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-configuration/resources/intellij.kotlin.projectConfiguration.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.buildSystemDependencyManager](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.buildSystemDependencyManager)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[KotlinBuildSystemDependencyManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-configuration/src/org/jetbrains/kotlin/idea/configuration/KotlinBuildSystemDependencyManager.kt) |
| [org.jetbrains.kotlin.compilerPluginConfigurator](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.compilerPluginConfigurator)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[KotlinCompilerPluginProjectConfigurator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-configuration/src/org/jetbrains/kotlin/idea/configuration/KotlinCompilerPluginProjectConfigurator.kt) |
| [org.jetbrains.kotlin.configuratorChangesViewer](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.configuratorChangesViewer)      |[KotlinConfiguratorChangesViewer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-configuration/src/org/jetbrains/kotlin/idea/configuration/KotlinConfiguratorChangesViewer.kt) |
| [org.jetbrains.kotlin.libraryVersionProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.libraryVersionProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[KotlinLibraryVersionProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-configuration/src/org/jetbrains/kotlin/idea/configuration/KotlinLibraryVersionProvider.kt) |
| [org.jetbrains.kotlin.projectConfigurator](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.projectConfigurator)      |[KotlinProjectConfigurator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-configuration/src/org/jetbrains/kotlin/idea/configuration/KotlinProjectConfigurator.kt) |
| [org.jetbrains.kotlin.projectPostConfigurator](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.projectPostConfigurator)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[KotlinProjectPostConfigurator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-configuration/src/org/jetbrains/kotlin/idea/configuration/KotlinProjectPostConfigurator.kt) |

### intellij.kotlin.projectStructure.xml

[intellij.kotlin.projectStructure.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/fir/project-structure/resources/intellij.kotlin.projectStructure.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.k2KaModuleFactory](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.k2KaModuleFactory)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[FirKaModuleFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/fir/project-structure/src/org/jetbrains/kotlin/idea/base/fir/projectStructure/FirKaModuleFactory.kt) |
| [org.jetbrains.kotlin.k2NotUnderContentRootModuleFactory](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.k2NotUnderContentRootModuleFactory)      |[KaNotUnderContentRootModuleFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/base/fir/project-structure/src/org/jetbrains/kotlin/idea/base/fir/projectStructure/KaNotUnderContentRootModuleFactory.kt) |

### intellij.kotlin.projectWizard.core.xml

[intellij.kotlin.projectWizard.core.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-wizard/core/resources/intellij.kotlin.projectWizard.core.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.idea.androidSdkProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.androidSdkProvider)      |[AndroidSdkProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-wizard/core/src/org/jetbrains/kotlin/tools/projectWizard/plugins/AndroidSdkProvider.kt) |
| [org.jetbrains.kotlin.idea.projectTemplatesProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.projectTemplatesProvider)      |[ProjectTemplatesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-wizard/core/src/org/jetbrains/kotlin/tools/projectWizard/plugins/projectTemplates/ProjectTemplatesProvider.kt) |

### intellij.kotlin.projectWizard.idea.xml

[intellij.kotlin.projectWizard.idea.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-wizard/idea/resources/intellij.kotlin.projectWizard.idea.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.newProjectWizard.kotlin.buildSystem](https://jb.gg/ipe?extensions=com.intellij.newProjectWizard.kotlin.buildSystem)      |[BuildSystemKotlinNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-wizard/idea/src/org/jetbrains/kotlin/tools/projectWizard/BuildSystemKotlinNewProjectWizard.kt) |
| [org.jetbrains.kotlin.idea.ideaWizardService](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.ideaWizardService)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[IdeaWizardService](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/project-wizard/idea/src/org/jetbrains/kotlin/tools/projectWizard/wizard/service/IdeaWizardService.kt) |

### intellij.kotlin.refactorings.base.xml

[intellij.kotlin.refactorings.base.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/refactorings/kotlin.refactorings.common/resources/intellij.kotlin.refactorings.base.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.foreignUsagesRenameProcessor](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.foreignUsagesRenameProcessor)      |[ForeignUsagesRenameProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/refactorings/kotlin.refactorings.common/src/org/jetbrains/kotlin/idea/refactoring/rename/ForeignUsagesRenameProcessor.kt) |
| [org.jetbrains.kotlin.postInsertDeclarationCallback](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.postInsertDeclarationCallback)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PostInsertDeclarationCallback](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/refactorings/kotlin.refactorings.common/src/org/jetbrains/kotlin/idea/refactoring/introduce/extractionEngine/PostInsertDeclarationCallback.kt) |
| [org.jetbrains.kotlin.renameHandler](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.renameHandler)      |[RenameHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/refactoring/src/com/intellij/refactoring/rename/RenameHandler.java) |
| [org.jetbrains.kotlin.simpleNameReferenceExtension](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.simpleNameReferenceExtension)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[SimpleNameReferenceExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/references/src/org/jetbrains/kotlin/plugin/references/SimpleNameReferenceExtension.kt) |

### intellij.kotlin.refactorings.xml

[intellij.kotlin.refactorings.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/refactorings/kotlin.refactorings.k2/resources/intellij.kotlin.refactorings.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.changeSignatureConflictFilter](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.changeSignatureConflictFilter)      |[KotlinChangeSignatureConflictFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/refactorings/kotlin.refactorings.k2/src/org/jetbrains/kotlin/idea/k2/refactoring/changeSignature/KotlinChangeSignatureConflictFilter.kt) |
| [org.jetbrains.kotlin.extractFunctionDescriptorModifier](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.extractFunctionDescriptorModifier)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ExtractFunctionDescriptorModifier](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/refactorings/kotlin.refactorings.k2/src/org/jetbrains/kotlin/idea/k2/refactoring/extractFunction/ExtractFunctionDescriptorModifier.kt) |

### intellij.kotlin.runConfigurations.jvm.xml

[intellij.kotlin.runConfigurations.jvm.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/run-configurations/jvm/resources/intellij.kotlin.runConfigurations.jvm.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.idea.testFrameworkProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.testFrameworkProvider)      |[KotlinTestFrameworkProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/run-configurations/jvm/src/org/jetbrains/kotlin/idea/extensions/KotlinTestFrameworkProvider.kt) |

### intellij.kotlin.searching.xml

[intellij.kotlin.searching.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/kotlin.searching/resources/intellij.kotlin.searching.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.directKotlinClassInheritorsSearch](https://jb.gg/ipe?extensions=com.intellij.directKotlinClassInheritorsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |

### kotlin.fir.frontend-independent.xml

[kotlin.fir.frontend-independent.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/frontend-independent/resources-en/kotlin.fir.frontend-independent.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.idea.codeInsight.lineMarkers.kotlinRunLineMarkerHider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.codeInsight.lineMarkers.kotlinRunLineMarkerHider)      ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[KotlinRunLineMarkerHider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/frontend-independent/src/org/jetbrains/kotlin/idea/codeInsight/KotlinRunLineMarkerHider.kt) |
| [org.jetbrains.kotlin.idea.codeInsight.unambiguousImports](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.codeInsight.unambiguousImports)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[KotlinAutoImportsFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/frontend-independent/src/org/jetbrains/kotlin/idea/codeInsight/KotlinAutoImportsFilter.kt) |

### kotlin.gradle.gradle-java.xml

[kotlin.gradle.gradle-java.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle-java/resources/kotlin.gradle.gradle-java.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.gradleProjectImportHandler](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.gradleProjectImportHandler)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GradleProjectImportHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle-java/src/org/jetbrains/kotlin/idea/gradleJava/configuration/KotlinGradleSourceSetDataService.kt) |
| [org.jetbrains.kotlin.idea.gradleJava.kotlinMultiplatformProducersProvider](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.idea.gradleJava.kotlinMultiplatformProducersProvider)      |[KotlinMultiplatformCommonProducersProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle-java/src/org/jetbrains/kotlin/idea/gradleJava/extensions/KotlinMultiplatformCommonProducersProvider.kt) |
| [org.jetbrains.kotlin.mppProjectResolve](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.mppProjectResolve)      |[KotlinMppGradleProjectResolverExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/gradle/gradle-java/src/org/jetbrains/kotlin/idea/gradleJava/configuration/mpp/KotlinMppGradleProjectResolverExtension.kt) |

### kotlin.scripting.xml

[kotlin.scripting.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/scripting/resources/kotlin.scripting.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.ideScriptConfigurationControlFacade](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.ideScriptConfigurationControlFacade)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[IdeScriptConfigurationControlFacade](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/kotlin/scripting/src/kotlin/script/experimental/intellij/scriptConfigurationTools.kt) |

## Markdown Plugin

### Markdown Plugin – Listeners

| Topic |Listener |
-------------------
| [MarkdownTableAlignmentSettingsListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.intellij.plugins.markdown.editor.tables.ui.alignment.MarkdownTableAlignmentSettingsListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MarkdownTableAlignmentSettingsListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/editor/tables/ui/alignment/MarkdownTableAlignmentSettingsListener.kt) |
| [ChangeListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.intellij.plugins.markdown.settings.MarkdownExtensionsSettings.ChangeListener)  ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[ChangeListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/settings/MarkdownExtensionsSettings.kt) |
| [ChangeListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.intellij.plugins.markdown.settings.MarkdownPreviewSettings.ChangeListener) |[ChangeListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/settings/MarkdownPreviewSettings.kt) |
| [ChangeListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.intellij.plugins.markdown.settings.MarkdownSettings.ChangeListener) |[ChangeListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/settings/MarkdownSettings.kt) |

### intellij.markdown.fenceInjection.xml

[intellij.markdown.fenceInjection.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/fenceInjection/src/main/resources/intellij.markdown.fenceInjection.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.intellij.plugins.markdown.fenceInjection.fenceSurroundingsProvider](https://jb.gg/ipe?extensions=org.intellij.plugins.markdown.fenceInjection.fenceSurroundingsProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[FenceSurroundingsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/fenceInjection/src/main/java/org/intellij/plugins/markdown/fenceInjection/FenceSurroundingsProvider.kt) |

### intellij.markdown.xml

[intellij.markdown.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/resources/intellij.markdown.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.intellij.markdown.frontMatterFoldingPolicy](https://jb.gg/ipe?extensions=org.intellij.markdown.frontMatterFoldingPolicy)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MarkdownFrontMatterFoldingPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/folding/MarkdownFrontMatterFoldingPolicy.kt) |
| [org.intellij.markdown.markdownRunner](https://jb.gg/ipe?extensions=org.intellij.markdown.markdownRunner)      |[MarkdownRunner](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/extensions/jcef/commandRunner/MarkdownRunner.kt) |

### org.intellij.plugins.markdown

[org.intellij.plugins.markdown](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.intellij.markdown.actionPromoterExtension](https://jb.gg/ipe?extensions=org.intellij.markdown.actionPromoterExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MarkdownActionPromoterExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/ui/actions/MarkdownActionPromoterExtension.kt) |
| [org.intellij.markdown.additionalFenceLanguageSuggester](https://jb.gg/ipe?extensions=org.intellij.markdown.additionalFenceLanguageSuggester)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[AdditionalFenceLanguageSuggester](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/injection/aliases/AdditionalFenceLanguageSuggester.kt) |
| [org.intellij.markdown.browserPreviewExtensionProvider](https://jb.gg/ipe?extensions=org.intellij.markdown.browserPreviewExtensionProvider)      |[Provider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/extensions/MarkdownBrowserPreviewExtension.kt) |
| [org.intellij.markdown.codeSpanRunnableSearcher](https://jb.gg/ipe?extensions=org.intellij.markdown.codeSpanRunnableSearcher)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MarkdownCodeSpanConfigurationContextSearcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/extensions/MarkdownCodeSpanConfigurationContextSearcher.kt) |
| [org.intellij.markdown.fenceGeneratingProvider](https://jb.gg/ipe?extensions=org.intellij.markdown.fenceGeneratingProvider)      ![Obsolete](https://img.shields.io/badge/-Obsolete-grey?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[CodeFenceGeneratingProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/extensions/CodeFenceGeneratingProvider.kt) |
| [org.intellij.markdown.fenceLanguageProvider](https://jb.gg/ipe?extensions=org.intellij.markdown.fenceLanguageProvider)      |[CodeFenceLanguageProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/injection/CodeFenceLanguageProvider.java) |
| [org.intellij.markdown.flavourProvider](https://jb.gg/ipe?extensions=org.intellij.markdown.flavourProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MarkdownFlavourProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/lang/parser/MarkdownFlavourProvider.kt) |
| [org.intellij.markdown.html.panel.provider](https://jb.gg/ipe?extensions=org.intellij.markdown.html.panel.provider)      |[MarkdownHtmlPanelProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/ui/preview/MarkdownHtmlPanelProvider.java) |
| [org.intellij.markdown.markdownCompatibilityChecker](https://jb.gg/ipe?extensions=org.intellij.markdown.markdownCompatibilityChecker)      |[MarkdownCompatibilityChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/lang/MarkdownCompatibilityChecker.kt) |
| [org.intellij.markdown.markdownElementFactory](https://jb.gg/ipe?extensions=org.intellij.markdown.markdownElementFactory)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MarkdownPsiElementProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/lang/psi/MarkdownPsiElementProvider.kt) |
| [org.intellij.markdown.markdownExportProvider](https://jb.gg/ipe?extensions=org.intellij.markdown.markdownExportProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MarkdownExportProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/fileActions/export/MarkdownExportProvider.kt) |
| [org.intellij.markdown.previewStylesProvider](https://jb.gg/ipe?extensions=org.intellij.markdown.previewStylesProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MarkdownPreviewStylesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/markdown/core/src/org/intellij/plugins/markdown/ui/preview/MarkdownPreviewStylesProvider.kt) |

## Maven Plugin

### Maven Plugin – Listeners

| Topic |Listener |
-------------------
| [MavenSystemIndicesManager#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.maven.indices.IndexChangeProgressListener) |[IndexChangeProgressListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/indices/MavenSystemIndicesManager.kt) |
| [MavenIndicesManager#INDEXER_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.maven.indices.MavenIndicesManager.MavenIndexerListener) |[MavenIndexerListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/indices/MavenIndicesManager.kt) |
| [MavenSearchIndex#INDEX_IS_BROKEN](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.maven.indices.MavenSearchIndex.IndexListener) |[IndexListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/indices/MavenSearchIndex.java) |
| [MavenImportListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.maven.project.MavenImportListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[MavenImportListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/project/MavenImportListener.java) |
| [Listener#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.maven.project.MavenProjectsTree.Listener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[Listener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/project/MavenProjectsTree.kt) |
| [MavenSyncListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.maven.project.MavenSyncListener) |[MavenSyncListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/project/MavenSyncListener.kt) |
| [MavenServerConnector#DOWNLOAD_LISTENER_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.maven.server.MavenServerDownloadListener) |[MavenServerDownloadListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven-server-api/src/main/java/org/jetbrains/idea/maven/server/MavenServerDownloadListener.java) |

### intellij.maven.groovy.xml

[intellij.maven.groovy.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/groovy/resources/intellij.maven.groovy.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.idea.maven.importing.groovy.foldersConfiguratorContributor](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.importing.groovy.foldersConfiguratorContributor)      |[PluginContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/groovy/src/GroovyPluginConfigurator.kt) |

### intellij.maven.xml

[intellij.maven.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/resources/intellij.maven.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.idea.maven.additional.importing.settings](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.additional.importing.settings)      |[AdditionalMavenImportingSettings](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/project/AdditionalMavenImportingSettings.java) |
| [org.jetbrains.idea.maven.archetypesProvider](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.archetypesProvider)      |[MavenArchetypesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/indices/MavenArchetypesProvider.java) |
| [org.jetbrains.idea.maven.artifactBuilder](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.artifactBuilder)      |[MavenArtifactBuilder](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/execution/build/MavenArtifactBuilder.java) |
| [org.jetbrains.idea.maven.compiler](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.compiler)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MavenCompilerExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/importing/MavenCompilerExtension.kt) |
| [org.jetbrains.idea.maven.dependencySearchContributor](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.dependencySearchContributor)      |[MavenDependencySearchContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/completion/MavenDependencySearchContributor.kt) |
| [org.jetbrains.idea.maven.executionEnvironmentProvider](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.executionEnvironmentProvider)      |[MavenExecutionEnvironmentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/execution/build/MavenExecutionEnvironmentProvider.java) |
| [org.jetbrains.idea.maven.importer](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.importer)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |[MavenImporter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/importing/MavenImporter.java) |
| [org.jetbrains.idea.maven.importing.afterImportConfigurator](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.importing.afterImportConfigurator)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MavenAfterImportConfigurator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/importing/MavenConfigurators.kt) |
| [org.jetbrains.idea.maven.importing.workspaceConfigurator](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.importing.workspaceConfigurator)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MavenWorkspaceConfigurator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/importing/MavenConfigurators.kt) |
| [org.jetbrains.idea.maven.log.import.parser](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.log.import.parser)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MavenImportLoggedEventParser](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/externalSystemIntegration/output/importproject/MavenImportLoggedEventParser.java) |
| [org.jetbrains.idea.maven.log.parser](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.log.parser)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MavenLoggedEventParser](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/externalSystemIntegration/output/MavenLoggedEventParser.java) |
| [org.jetbrains.idea.maven.log.spy.parser](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.log.spy.parser)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MavenSpyLoggedEventParser](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/externalSystemIntegration/output/MavenSpyLoggedEventParser.java) |
| [org.jetbrains.idea.maven.manifestImporter](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.manifestImporter)      |[ManifestImporter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/importing/ManifestImporter.java) |
| [org.jetbrains.idea.maven.mavenAdditionalHighlighter](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.mavenAdditionalHighlighter)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[MavenAdditionalHightligher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/dom/MavenAdditionalHightligher.kt) |
| [org.jetbrains.idea.maven.mavenRemoteConnectionCreator](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.mavenRemoteConnectionCreator)      |[MavenRemoteConnectionCreator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/execution/MavenRemoteConnectionCreator.kt) |
| [org.jetbrains.idea.maven.mavenServerSupportFactory](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.mavenServerSupportFactory)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MavenRemoteProcessSupportFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/server/MavenRemoteProcessSupportFactory.java) |
| [org.jetbrains.idea.maven.pluginDescriptor](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.pluginDescriptor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`n/a` |
| [org.jetbrains.idea.maven.projectResolutionContributor](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.projectResolutionContributor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MavenProjectResolutionContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/project/MavenProjectResolver.kt) |
| [org.jetbrains.idea.maven.remotePathTransformerFactory](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.remotePathTransformerFactory)      |[RemotePathTransformerFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/server/RemotePathTransformerFactory.java) |
| [org.jetbrains.idea.maven.repositoryProvider](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.repositoryProvider)      |[MavenRepositoryProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/indices/MavenRepositoryProvider.java) |
| [org.jetbrains.idea.maven.runner.executionConfigurator](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.runner.executionConfigurator)      |[MavenExecutionConfiguratorProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/execution/run/MavenExecutionConfigurator.kt) |
| [org.jetbrains.idea.maven.targetConfigurationExtension](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.targetConfigurationExtension)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[TargetConfigurationMavenExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/execution/target/TargetConfigurationMavenExtension.java) |
| [org.jetbrains.idea.maven.versionAwareMavenSupport](https://jb.gg/ipe?extensions=org.jetbrains.idea.maven.versionAwareMavenSupport)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MavenVersionAwareSupportExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/MavenVersionAwareSupportExtension.kt) |

## Python Plugin

### Python Plugin – Listeners

| Topic |Listener |
-------------------
| [PyLspModuleClientsKt#PY_LSP_SERVE_KEYS_CHANGED](https://jb.gg/ipe/listeners?topics=com.intellij.python.lsp.core.PyLspServeKeysListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[PyLspServeKeysListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-lsp-core/src/com/intellij/python/lsp/core/PyLspModuleClients.kt) |
| [PyLspListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.python.lsp.core.listener.PyLspListener) |[PyLspListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-lsp-core/src/com/intellij/python/lsp/core/listener/PyLspListener.kt) |
| [ModelRebuiltNotifierKt#MODEL_REBUILD](https://jb.gg/ipe/listeners?topics=com.intellij.python.pyproject.model.api.ModelRebuiltListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ModelRebuiltListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pyproject/src/com/intellij/python/pyproject/model/api/ModelRebuiltListener.kt) |
| [PyDebuggerBackendSwitchedListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.python.debugger.PyDebuggerBackendSwitchedListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyDebuggerBackendSwitchedListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/debugger/PyDebuggerBackendSwitchedListener.kt) |
| [PyFrameListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.python.debugger.PyFrameListener) |[PyFrameListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/pydevSrc/src/com/jetbrains/python/debugger/PyFrameListener.kt) |
| [PyPackageManager#PACKAGE_MANAGER_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.python.packaging.PyPackageManager.Listener) |[Listener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/openapi/src/com/jetbrains/python/packaging/PyPackageManager.java) |
| [PythonPackageManager#PACKAGE_MANAGEMENT_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.python.packaging.common.PythonPackageManagementListener)  ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[PythonPackageManagementListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/packaging/common/util.kt) |
| [VirtualFilePyLanguageLevelListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.python.psi.impl.VirtualFilePyLanguageLevelListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[VirtualFilePyLanguageLevelListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/psi/impl/VirtualFilePyLanguageLevelListener.kt) |
| [PySdkListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.python.sdk.PySdkListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PySdkListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/jetbrains/python/sdk/PySdkListener.kt) |

### intellij.pycharm.community.ide.impl.xml

[intellij.pycharm.community.ide.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/ide/impl/resources/intellij.pycharm.community.ide.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [Pythonid.miscFileType](https://jb.gg/ipe?extensions=Pythonid.miscFileType)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[MiscFileType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/ide/impl/src/com/intellij/pycharm/community/ide/impl/miscProject/MiscFileType.kt) |

### intellij.python.community.common.xml

[intellij.python.community.common.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/common/resources/intellij.python.community.common.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.python.community.common.toolToIconMapper](https://jb.gg/ipe?extensions=com.intellij.python.community.common.toolToIconMapper)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ToolIdToIconMapper](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/common/src/tools/spi/ToolIdToIconMapper.kt) |

### intellij.python.community.execService.xml

[intellij.python.community.execService.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-exec-service/resources/intellij.python.community.execService.xml)

| Extension Point |Implementation |
-----------------------------------
| [Pythonid.execService.targetEnvironmentRequestHandler](https://jb.gg/ipe?extensions=Pythonid.execService.targetEnvironmentRequestHandler)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TargetEnvironmentRequestHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-exec-service/src/com/intellij/python/community/execService/impl/TargetEnvironmentRequestHandler.kt) |

### intellij.python.community.helpersLocator.xml

[intellij.python.community.helpersLocator.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/impl.helperLocator/resources/intellij.python.community.helpersLocator.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.python.pythonHelpersLocator](https://jb.gg/ipe?extensions=com.jetbrains.python.pythonHelpersLocator)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PythonHelpersLocator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/impl.helperLocator/src/com/intellij/python/community/helpersLocator/PythonHelpersLocator.kt) |

### intellij.python.community.impl.xml

[intellij.python.community.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/pluginResources/intellij.python.community.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [Pythonid.breakpointHandler](https://jb.gg/ipe?extensions=Pythonid.breakpointHandler)      |[PyBreakpointHandlerFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/debugger/PyBreakpointHandlerFactory.java) |
| [Pythonid.connectionCredentialsToTargetConfigurationConverter](https://jb.gg/ipe?extensions=Pythonid.connectionCredentialsToTargetConfigurationConverter)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ConnectionCredentialsToTargetConfigurationConverter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/run/target/ConnectionCredentialsToTargetConfigurationConverter.kt) |
| [Pythonid.consoleOptionsProvider](https://jb.gg/ipe?extensions=Pythonid.consoleOptionsProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyConsoleOptionsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/console/PyConsoleOptionsProvider.java) |
| [Pythonid.customProcessHandlerProvider](https://jb.gg/ipe?extensions=Pythonid.customProcessHandlerProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyCustomProcessHandlerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/run/PyCustomProcessHandlerProvider.kt) |
| [Pythonid.dataViewPanelFactory](https://jb.gg/ipe?extensions=Pythonid.dataViewPanelFactory)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyDataViewPanelFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/debugger/containerview/PyDataViewPanelFactory.java) |
| [Pythonid.debugSessionFactory](https://jb.gg/ipe?extensions=Pythonid.debugSessionFactory)      |[PyDebugSessionFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/debugger/PyDebugSessionFactory.java) |
| [Pythonid.embeddedBrowserProvider](https://jb.gg/ipe?extensions=Pythonid.embeddedBrowserProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyEmbeddedBrowserProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/ui/PyEmbeddedBrowserProvider.kt) |
| [Pythonid.interpreterTargetEnvironmentFactory](https://jb.gg/ipe?extensions=Pythonid.interpreterTargetEnvironmentFactory)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PythonInterpreterTargetEnvironmentFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/jetbrains/python/run/PythonInterpreterTargetEnvironmentFactory.kt) |
| [Pythonid.magicLiteral](https://jb.gg/ipe?extensions=Pythonid.magicLiteral)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyMagicLiteralExtensionPoint](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/magicLiteral/PyMagicLiteralExtensionPoint.java) |
| [Pythonid.packageInstalledIconProvider](https://jb.gg/ipe?extensions=Pythonid.packageInstalledIconProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyPackageInstalledIconProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/packaging/toolwindow/packages/tree/renderers/PyPackageInstalledIconProvider.kt) |
| [Pythonid.packageManagerProvider](https://jb.gg/ipe?extensions=Pythonid.packageManagerProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyPackageManagerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/packaging/PyCustomPackageManagers.kt) |
| [Pythonid.pep8ProblemSuppressor](https://jb.gg/ipe?extensions=Pythonid.pep8ProblemSuppressor)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[Pep8ProblemSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/validation/Pep8ProblemSuppressor.java) |
| [Pythonid.pyCustomSdkUiProvider](https://jb.gg/ipe?extensions=Pythonid.pyCustomSdkUiProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyCustomSdkUiProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/sdk/PyCustomSdkUiProvider.java) |
| [Pythonid.pyLaunchPreparer](https://jb.gg/ipe?extensions=Pythonid.pyLaunchPreparer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyLaunchPreparer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/run/PyLaunchPreparer.kt) |
| [Pythonid.pyPregeneratedSkeletonsProvider](https://jb.gg/ipe?extensions=Pythonid.pyPregeneratedSkeletonsProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyPregeneratedSkeletonsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/sdk/skeletons/PyPregeneratedSkeletonsProvider.java) |
| [Pythonid.pyRootTypeProvider](https://jb.gg/ipe?extensions=Pythonid.pyRootTypeProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyRootTypeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/module/PyRootTypeProvider.java) |
| [Pythonid.pyRunToolProvider](https://jb.gg/ipe?extensions=Pythonid.pyRunToolProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyRunToolProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/run/features/PyRunToolProvider.kt) |
| [Pythonid.pyTestConfigurationSelector](https://jb.gg/ipe?extensions=Pythonid.pyTestConfigurationSelector)      |[PyTestConfigurationSelector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/testing/PyTestConfigurationSelector.kt) |
| [Pythonid.pyTestFixtureExtension](https://jb.gg/ipe?extensions=Pythonid.pyTestFixtureExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyTestFixtureExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/testing/pyTestFixtures/PyTestFixtureExtension.kt) |
| [Pythonid.pythonCommandLineEnvironmentProvider](https://jb.gg/ipe?extensions=Pythonid.pythonCommandLineEnvironmentProvider)      |[PythonCommandLineEnvironmentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/run/PythonCommandLineEnvironmentProvider.java) |
| [Pythonid.pythonCommandLineTargetEnvironmentProvider](https://jb.gg/ipe?extensions=Pythonid.pythonCommandLineTargetEnvironmentProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PythonCommandLineTargetEnvironmentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/run/target/PythonCommandLineTargetEnvironmentProvider.kt) |
| [Pythonid.pythonDebugBackendRunner](https://jb.gg/ipe?extensions=Pythonid.pythonDebugBackendRunner)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyDebugBackendRunner](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/debugger/PyDebugBackendRunner.kt) |
| [Pythonid.pythonPackageManagerProvider](https://jb.gg/ipe?extensions=Pythonid.pythonPackageManagerProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PythonPackageManagerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/packaging/management/PythonPackageManagerService.kt) |
| [Pythonid.pythonSdkReadOnlyProvider](https://jb.gg/ipe?extensions=Pythonid.pythonSdkReadOnlyProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PythonSdkReadOnlyProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/sdk/readOnly/PythonSdkReadOnlyProvider.kt) |
| [Pythonid.remoteInterpreterManager](https://jb.gg/ipe?extensions=Pythonid.remoteInterpreterManager)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PythonRemoteInterpreterManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/remote/PythonRemoteInterpreterManager.java) |
| [Pythonid.runConfigurationEditorExtension](https://jb.gg/ipe?extensions=Pythonid.runConfigurationEditorExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyRunConfigurationEditorExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/run/PyRunConfigurationEditorExtension.java) |
| [Pythonid.runConfigurationExtension](https://jb.gg/ipe?extensions=Pythonid.runConfigurationExtension)      |[PythonRunConfigurationExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/run/PythonRunConfigurationExtension.java) |
| [Pythonid.runnableScriptFilter](https://jb.gg/ipe?extensions=Pythonid.runnableScriptFilter)      |[RunnableScriptFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/run/RunnableScriptFilter.java) |
| [Pythonid.unresolvedReferenceQuickFixProvider](https://jb.gg/ipe?extensions=Pythonid.unresolvedReferenceQuickFixProvider)      |[PyUnresolvedReferenceQuickFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/inspections/PyUnresolvedReferenceQuickFixProvider.java) |
| [com.jetbrains.python.configuration.pyIntegratedToolsTestPanelCustomizer](https://jb.gg/ipe?extensions=com.jetbrains.python.configuration.pyIntegratedToolsTestPanelCustomizer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyIntegratedToolsTestPanelCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/configuration/PyIntegratedToolsTestPanelCustomizer.kt) |
| [com.jetbrains.python.console.customizer](https://jb.gg/ipe?extensions=com.jetbrains.python.console.customizer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyConsoleCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/console/PyConsoleCustomizer.kt) |
| [com.jetbrains.python.console.executeCustomizer](https://jb.gg/ipe?extensions=com.jetbrains.python.console.executeCustomizer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyExecuteConsoleCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/console/PyExecuteConsoleCustomizer.kt) |
| [com.jetbrains.python.console.pyConsoleOutputCustomizer](https://jb.gg/ipe?extensions=com.jetbrains.python.console.pyConsoleOutputCustomizer)      |[PyConsoleOutputCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/console/PyConsoleOutputCustomizer.kt) |
| [com.jetbrains.python.console.runnerFactory](https://jb.gg/ipe?extensions=com.jetbrains.python.console.runnerFactory)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |[PythonConsoleRunnerFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/console/PythonConsoleRunnerFactory.java) |
| [com.jetbrains.python.debugger.backendSwitchHandler](https://jb.gg/ipe?extensions=com.jetbrains.python.debugger.backendSwitchHandler)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyDebuggerBackendSwitchHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/debugger/PyDebuggerBackendSwitchHandler.kt) |
| [com.jetbrains.python.debugger.numericContainerPopupCustomizer](https://jb.gg/ipe?extensions=com.jetbrains.python.debugger.numericContainerPopupCustomizer)      |[PyNumericContainerPopupCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/pydevSrc/src/com/jetbrains/python/debugger/pydev/tables/PyNumericContainerPopupCustomizer.kt) |
| [com.jetbrains.python.debugger.pyDebugAsyncioCustomizer](https://jb.gg/ipe?extensions=com.jetbrains.python.debugger.pyDebugAsyncioCustomizer)      |[PyDebugAsyncioCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/debugger/PyDebugAsyncioCustomizer.kt) |
| [com.jetbrains.python.inspections.dependencies.dependenciesInspectionProvider](https://jb.gg/ipe?extensions=com.jetbrains.python.inspections.dependencies.dependenciesInspectionProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[DependenciesPsiProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/inspections/dependencies/DependenciesPsiProvider.kt) |
| [com.jetbrains.python.testing.pyTestLineMarkerContributorCustomizer](https://jb.gg/ipe?extensions=com.jetbrains.python.testing.pyTestLineMarkerContributorCustomizer)      |[PyTestLineMarkerContributorCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/src/com/jetbrains/python/testing/PyTestLineMarkerContributor.kt) |

### intellij.python.community.services.systemPython.xml

[intellij.python.community.services.systemPython.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/services/system-python/resources/intellij.python.community.services.systemPython.xml)

| Extension Point |Implementation |
-----------------------------------
| [Pythonid.systemPythonProvider](https://jb.gg/ipe?extensions=Pythonid.systemPythonProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[SystemPythonProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/services/system-python/src/com/intellij/python/community/services/systemPython/spi.kt) |

### intellij.python.lsp.core.xml

[intellij.python.lsp.core.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-lsp-core/resources/intellij.python.lsp.core.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.python.lsp.notebookLanguageResolver](https://jb.gg/ipe?extensions=com.intellij.python.lsp.notebookLanguageResolver)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[NotebookLanguageResolver](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-lsp-core/src/com/intellij/python/lsp/core/NotebookLanguageResolver.kt) |
| [com.intellij.python.lsp.typeEngineConfigurable](https://jb.gg/ipe?extensions=com.intellij.python.lsp.typeEngineConfigurable)      |[PyTypeEngineProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-lsp-core/src/com/intellij/python/lsp/core/typeEngine/PyTypeEngineProvider.kt) |

### intellij.python.parser.xml

[intellij.python.parser.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-parser/resources/intellij.python.parser.xml)

| Extension Point |Implementation |
-----------------------------------
| [Pythonid.dialectsTokenSetContributor](https://jb.gg/ipe?extensions=Pythonid.dialectsTokenSetContributor)      |[PythonDialectsTokenSetContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-parser/src/com/jetbrains/python/PythonDialectsTokenSetContributor.java) |

### intellij.python.processOutput.common.xml

[intellij.python.processOutput.common.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-process-output/common/resources/intellij.python.processOutput.common.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.python.processOutput.common.processOutputIconMapping](https://jb.gg/ipe?extensions=com.intellij.python.processOutput.common.processOutputIconMapping)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ProcessOutputIconMapping](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-process-output/common/src/ProcessOutputIconMapping.kt) |

### intellij.python.psi.impl.xml

[intellij.python.psi.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/resources/intellij.python.psi.impl.xml)

| Extension Point |Implementation |
-----------------------------------
| [Pythonid.customClassStubType](https://jb.gg/ipe?extensions=Pythonid.customClassStubType)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyCustomClassStubType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/psi/impl/stubs/PyCustomClassStubType.java) |
| [Pythonid.customDecoratorStubType](https://jb.gg/ipe?extensions=Pythonid.customDecoratorStubType)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyCustomDecoratorStubType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/psi/impl/stubs/PyCustomDecoratorStubType.kt) |
| [Pythonid.customTargetExpressionStubType](https://jb.gg/ipe?extensions=Pythonid.customTargetExpressionStubType)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[CustomTargetExpressionStubType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/psi/impl/stubs/CustomTargetExpressionStubType.java) |
| [Pythonid.dictLiteralPromotionExtension](https://jb.gg/ipe?extensions=Pythonid.dictLiteralPromotionExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyDictLiteralPromotionExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/psi/types/PyDictLiteralPromotionExtension.kt) |
| [Pythonid.documentationLinkProvider](https://jb.gg/ipe?extensions=Pythonid.documentationLinkProvider)      |[PythonDocumentationLinkProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/documentation/PythonDocumentationLinkProvider.java) |
| [Pythonid.implicitAsyncContext](https://jb.gg/ipe?extensions=Pythonid.implicitAsyncContext)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyImplicitAsyncContextProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/validation/PyImplicitAsyncContextProvider.kt) |
| [Pythonid.importCandidateProvider](https://jb.gg/ipe?extensions=Pythonid.importCandidateProvider)      |[PyImportCandidateProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/codeInsight/imports/PyImportCandidateProvider.java) |
| [Pythonid.knownDecoratorProvider](https://jb.gg/ipe?extensions=Pythonid.knownDecoratorProvider)      |[PyKnownDecoratorProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/psi/PyKnownDecoratorProvider.java) |
| [Pythonid.pyDataclassParametersProvider](https://jb.gg/ipe?extensions=Pythonid.pyDataclassParametersProvider)      |[PyDataclassParametersProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/codeInsight/PyDataclassParametersProvider.kt) |
| [Pythonid.pyEnumMemberDeclarationProvider](https://jb.gg/ipe?extensions=Pythonid.pyEnumMemberDeclarationProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyEnumMemberDeclarationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/types/PyEnumMemberDeclarationProvider.kt) |
| [Pythonid.pyReferenceCustomTargetChecker](https://jb.gg/ipe?extensions=Pythonid.pyReferenceCustomTargetChecker)      |[PyReferenceCustomTargetChecker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/psi/impl/references/PyReferenceCustomTargetChecker.kt) |
| [Pythonid.pyiStubSuppressor](https://jb.gg/ipe?extensions=Pythonid.pyiStubSuppressor)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[PyiStubSuppressor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/pyi/PyiStubSuppressor.java) |
| [Pythonid.typeCheckerExtension](https://jb.gg/ipe?extensions=Pythonid.typeCheckerExtension)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[PyTypeCheckerExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/psi/types/PyTypeCheckerExtension.java) |
| [Pythonid.typeHintProvider](https://jb.gg/ipe?extensions=Pythonid.typeHintProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyTypeHintProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/codeInsight/typing/PyTypeHintProvider.kt) |
| [Pythonid.visitorFilter](https://jb.gg/ipe?extensions=Pythonid.visitorFilter)      |[PythonVisitorFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-impl/src/com/jetbrains/python/psi/PythonVisitorFilter.java) |

### intellij.python.psi.xml

[intellij.python.psi.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/resources/intellij.python.psi.xml)

| Extension Point |Implementation |
-----------------------------------
| [Pythonid.canonicalPathProvider](https://jb.gg/ipe?extensions=Pythonid.canonicalPathProvider)      |[PyCanonicalPathProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/resolve/PyCanonicalPathProvider.java) |
| [Pythonid.customPackageIdentifier](https://jb.gg/ipe?extensions=Pythonid.customPackageIdentifier)      |[PyCustomPackageIdentifier](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/PyCustomPackageIdentifier.java) |
| [Pythonid.importResolver](https://jb.gg/ipe?extensions=Pythonid.importResolver)      |[PyImportResolver](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/impl/PyImportResolver.java) |
| [Pythonid.inspectionExtension](https://jb.gg/ipe?extensions=Pythonid.inspectionExtension)      |[PyInspectionExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/inspections/PyInspectionExtension.java) |
| [Pythonid.keywordArgumentProvider](https://jb.gg/ipe?extensions=Pythonid.keywordArgumentProvider)      |[PyKeywordArgumentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/impl/PyKeywordArgumentProvider.java) |
| [Pythonid.pyClassInheritorsSearch](https://jb.gg/ipe?extensions=Pythonid.pyClassInheritorsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [Pythonid.pyClassMembersProvider](https://jb.gg/ipe?extensions=Pythonid.pyClassMembersProvider)      |[PyClassMembersProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/types/PyClassMembersProvider.java) |
| [Pythonid.pyModuleMembersProvider](https://jb.gg/ipe?extensions=Pythonid.pyModuleMembersProvider)      |[PyModuleMembersProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/types/PyModuleMembersProvider.java) |
| [Pythonid.pyOverridingMethodsSearch](https://jb.gg/ipe?extensions=Pythonid.pyOverridingMethodsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [Pythonid.pyReferenceResolveProvider](https://jb.gg/ipe?extensions=Pythonid.pyReferenceResolveProvider)      |[PyReferenceResolveProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/resolve/PyReferenceResolveProvider.java) |
| [Pythonid.pySuperMethodsSearch](https://jb.gg/ipe?extensions=Pythonid.pySuperMethodsSearch)      |[QueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/QueryExecutor.java) |
| [Pythonid.pythonDocumentationQuickInfoProvider](https://jb.gg/ipe?extensions=Pythonid.pythonDocumentationQuickInfoProvider)      |[PythonDocumentationQuickInfoProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/documentation/PythonDocumentationQuickInfoProvider.java) |
| [Pythonid.resolveResultRater](https://jb.gg/ipe?extensions=Pythonid.resolveResultRater)      |[PyResolveResultRater](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/impl/PyResolveResultRater.java) |
| [Pythonid.statementEffectQuickFixProvider](https://jb.gg/ipe?extensions=Pythonid.statementEffectQuickFixProvider)      |[PyStatementEffectQuickFixProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/inspections/PyStatementEffectQuickFixProvider.java) |
| [Pythonid.thirdPartySdkDetector](https://jb.gg/ipe?extensions=Pythonid.thirdPartySdkDetector)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[PyThirdPartySdkDetector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/resolve/PyThirdPartySdkDetector.java) |
| [Pythonid.typeEvalTypeEngineProvider](https://jb.gg/ipe?extensions=Pythonid.typeEvalTypeEngineProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyTypeEngineProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/types/engine/PyTypeEngineProvider.kt) |
| [Pythonid.typeProvider](https://jb.gg/ipe?extensions=Pythonid.typeProvider)      |[PyTypeProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-psi-api/src/com/jetbrains/python/psi/impl/PyTypeProvider.java) |

### intellij.python.pydev.xml

[intellij.python.pydev.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/pydevSrc/resources/intellij.python.pydev.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.jetbrains.python.debugger.additionalHyperlinkProvider](https://jb.gg/ipe?extensions=com.jetbrains.python.debugger.additionalHyperlinkProvider)      |[PyDebugValueAdditionalHyperlinkProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/pydevSrc/src/com/jetbrains/python/debugger/PyDebugValueAdditionalHyperlinkProvider.kt) |

### intellij.python.pyproject.xml

[intellij.python.pyproject.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pyproject/resources/intellij.python.pyproject.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.python.pyproject.model.pyprojectmanager](https://jb.gg/ipe?extensions=com.intellij.python.pyproject.model.pyprojectmanager)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyProjectManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pyproject/src/com/intellij/python/pyproject/model/spi/PyProjectManager.kt) |

### intellij.python.pytools.backend.xml

[intellij.python.pytools.backend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pytools/backend/resources/intellij.python.pytools.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.python.pytools.genericPyToolManagerProvider](https://jb.gg/ipe?extensions=com.intellij.python.pytools.genericPyToolManagerProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GenericPyToolManagerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pytools/backend/src/GenericPyToolManagerProvider.kt) |
| [com.intellij.python.pytools.pyTool](https://jb.gg/ipe?extensions=com.intellij.python.pytools.pyTool)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyTool](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pytools/backend/src/PyTool.kt) |

### intellij.python.pytools.common.xml

[intellij.python.pytools.common.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pytools/common/resources/intellij.python.pytools.common.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.python.pytools.configurationSerializerProvider](https://jb.gg/ipe?extensions=com.intellij.python.pytools.configurationSerializerProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyToolConfigurationSerializerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pytools/common/src/PyToolConfigurationSerializer.kt) |

### intellij.python.pytools.frontend.xml

[intellij.python.pytools.frontend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pytools/frontend/resources/intellij.python.pytools.frontend.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.python.pytools.pyToolFrontend](https://jb.gg/ipe?extensions=com.intellij.python.pytools.pyToolFrontend)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyToolFrontend](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-pytools/frontend/src/PyToolFrontend.kt) |

### intellij.python.requirements.common.xml

[intellij.python.requirements.common.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-requirements/common/resources/intellij.python.requirements.common.xml)

| Extension Point |Implementation |
-----------------------------------
| [Pythonid.pyDependenciesFileProvider](https://jb.gg/ipe?extensions=Pythonid.pyDependenciesFileProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyDependenciesFileProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-requirements/common/src/com/jetbrains/python/requirements/PyDependenciesFileProvider.kt) |

### intellij.python.sdk.backend.xml

[intellij.python.sdk.backend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/resources/intellij.python.sdk.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [Pythonid.evoEnvironmentProvider](https://jb.gg/ipe?extensions=Pythonid.evoEnvironmentProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyEvoEnvironmentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/intellij/python/sdk/backend/evolution/PyEvoEnvironmentProvider.kt) |
| [Pythonid.interpreterPresentationProvider](https://jb.gg/ipe?extensions=Pythonid.interpreterPresentationProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PythonInterpreterPresentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/intellij/python/sdk/backend/PythonInterpreterPresentationProvider.kt) |
| [Pythonid.projectSdkConfigurationExtension](https://jb.gg/ipe?extensions=Pythonid.projectSdkConfigurationExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PyProjectSdkConfigurationExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/jetbrains/python/sdk/configuration/PyProjectSdkConfigurationExtension.kt) |
| [Pythonid.pySdkProvider](https://jb.gg/ipe?extensions=Pythonid.pySdkProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PySdkProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/jetbrains/python/sdk/PySdkProvider.kt) |
| [Pythonid.pythonEnvironmentProvider](https://jb.gg/ipe?extensions=Pythonid.pythonEnvironmentProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[PythonEnvironmentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/intellij/python/sdk/backend/PythonEnvironmentProvider.kt) |
| [Pythonid.pythonFlavorProvider](https://jb.gg/ipe?extensions=Pythonid.pythonFlavorProvider)      |[PythonFlavorProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/jetbrains/python/sdk/flavors/PythonFlavorProvider.java) |
| [Pythonid.pythonSdkFlavor](https://jb.gg/ipe?extensions=Pythonid.pythonSdkFlavor)      |[PythonSdkFlavor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/jetbrains/python/sdk/flavors/PythonSdkFlavor.java) |
| [Pythonid.targetSupportsFilter](https://jb.gg/ipe?extensions=Pythonid.targetSupportsFilter)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TargetSupportsFilterExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-sdk/backend/src/com/jetbrains/python/sdk/filter/TargetSupportsFilterExtension.kt) |

### intellij.python.typeEngine.frontend.xml

[intellij.python.typeEngine.frontend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-type-engine/frontend/resources/intellij.python.typeEngine.frontend.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.python.typeEngine.frontend](https://jb.gg/ipe?extensions=com.intellij.python.typeEngine.frontend)      |[PyTypeEngineFrontend](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/python/python-type-engine/frontend/src/com/intellij/python/typeEngine/frontend/PyTypeEngineFrontend.kt) |

## Terminal Plugin

### Terminal Plugin – Listeners

| Topic |Listener |
-------------------
| [TerminalTypingLatencyListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.terminal.frontend.fus.TerminalTypingLatencyListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalTypingLatencyListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/frontend/src/com/intellij/terminal/frontend/fus/TerminalTypingLatencyListener.kt) |
| [TerminalTabsManagerListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.terminal.frontend.toolwindow.TerminalTabsManagerListener)  ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[TerminalTabsManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/frontend/src/com/intellij/terminal/frontend/toolwindow/TerminalToolWindowTabsManager.kt) |
| [RunCommandUsingIdeUtil#TERMINAL_COMMAND_HANDLER_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.terminal.RunCommandUsingIdeUtil.TerminalCommandHandlerListener) |[TerminalCommandHandlerListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/RunCommandUsingIdeUtil.kt) |
| [BlockTerminalInitializationListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.terminal.block.BlockTerminalInitializationListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[BlockTerminalInitializationListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/block/BlockTerminalInitializationListener.kt) |
| [CommandHistoryListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.terminal.block.history.CommandHistoryListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CommandHistoryListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/block/history/CommandHistoryListener.kt) |
| [CommandSearchListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.terminal.block.history.CommandSearchListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CommandSearchListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/block/history/CommandSearchListener.kt) |

### intellij.terminal.frontend.xml

[intellij.terminal.frontend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/frontend/resources/intellij.terminal.frontend.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.terminal.activityTracker](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.activityTracker)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalActivityTracker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/frontend/src/com/intellij/terminal/frontend/session/TerminalActivityTracker.kt) |
| [org.jetbrains.plugins.terminal.allowedActionsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.allowedActionsProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[TerminalAllowedActionsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/frontend/src/com/intellij/terminal/frontend/view/TerminalAllowedActionsProvider.kt) |
| [org.jetbrains.plugins.terminal.escapeHandler](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.escapeHandler)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[TerminalEscapeHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/frontend/src/com/intellij/terminal/frontend/action/TerminalEscapeAction.kt) |
| [org.jetbrains.plugins.terminal.portForwardingManager](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.portForwardingManager)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalPortForwardingManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/frontend/src/com/intellij/terminal/frontend/view/portForwarding/TerminalPortForwardingManager.kt) |
| [org.jetbrains.plugins.terminal.terminalSettingsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.terminalSettingsProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[TerminalSettingsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/frontend/src/com/intellij/terminal/frontend/settings/TerminalSettingsProvider.kt) |

### terminal.xml

[terminal.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/resources/META-INF/terminal.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.terminal.shellCommandHandler](https://jb.gg/ipe?extensions=com.intellij.terminal.shellCommandHandler)      |[TerminalShellCommandHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/execution-impl/src/com/intellij/terminal/TerminalShellCommandHandler.kt) |
| [org.jetbrains.plugins.terminal.commandHistoryProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.commandHistoryProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalCommandHistoryProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/block/history/TerminalCommandHistoryProvider.kt) |
| [org.jetbrains.plugins.terminal.commandSpecsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.commandSpecsProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[ShellCommandSpecsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/block/completion/spec/ShellCommandSpecsProvider.kt) |
| [org.jetbrains.plugins.terminal.customTerminalRunnerProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.customTerminalRunnerProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[CustomTerminalRunnerProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/classic/CustomTerminalRunnerProvider.kt) |
| [org.jetbrains.plugins.terminal.exp.commandBlockHighlighterProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.exp.commandBlockHighlighterProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalCommandBlockHighlighterProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/block/output/highlighting/TerminalCommandBlockHighlighterProvider.kt) |
| [org.jetbrains.plugins.terminal.localTerminalCustomizer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.localTerminalCustomizer)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |[LocalTerminalCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/LocalTerminalCustomizer.java) |
| [org.jetbrains.plugins.terminal.openPredefinedTerminalProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.openPredefinedTerminalProvider)      |[OpenPredefinedTerminalActionProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/ui/OpenPredefinedTerminalActionProvider.kt) |
| [org.jetbrains.plugins.terminal.promptCustomEnterHandler](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.promptCustomEnterHandler)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalPromptCustomEnterHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/block/prompt/TerminalPromptCustomEnterHandler.kt) |
| [org.jetbrains.plugins.terminal.shellExecOptionsCustomizer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.shellExecOptionsCustomizer)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[ShellExecOptionsCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/startup/ShellExecOptionsCustomizer.kt) |
| [org.jetbrains.plugins.terminal.shellExecOptionsCustomizerDisabler](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.shellExecOptionsCustomizerDisabler)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[ShellExecOptionsCustomizerDisabler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/startup/ShellExecOptionsCustomizerDisabler.kt) |
| [org.jetbrains.plugins.terminal.shellSupport](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.shellSupport)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[TerminalShellSupport](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/exp/completion/TerminalShellSupport.kt) |
| [org.jetbrains.plugins.terminal.shellsDetector](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.shellsDetector)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalShellsDetector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/shellDetection/TerminalShellsDetector.kt) |
| [org.jetbrains.plugins.terminal.terminalAgentProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.terminalAgentProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalAgentProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/agent/TerminalAgent.kt) |
| [org.jetbrains.plugins.terminal.terminalCloudCompletionSettingsProvider](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.terminalCloudCompletionSettingsProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalCloudCompletionSettingsProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/TerminalCloudCompletionSettingsProvider.kt) |
| [org.jetbrains.plugins.terminal.toolWindowInitializer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.toolWindowInitializer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TerminalToolWindowInitializer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/TerminalToolWindowInitializer.kt) |
| [org.jetbrains.plugins.terminal.workingDirectoryCustomizer](https://jb.gg/ipe?extensions=org.jetbrains.plugins.terminal.workingDirectoryCustomizer)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[TerminalWorkingDirectoryCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/terminal/src/org/jetbrains/plugins/terminal/startup/TerminalWorkingDirectoryCustomizer.kt) |

## VCS Plugins

### VCS Plugins – Listeners

| Topic |Listener |
-------------------
| [SvnVcs#ROOTS_RELOADED](https://jb.gg/ipe/listeners?topics=com.intellij.util.Consumer)  ![Obsolete](https://img.shields.io/badge/-Obsolete-grey?style=flat-square) |[Consumer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/Consumer.java) |
| [GitBranchIncomingOutgoingManager#GIT_INCOMING_OUTGOING_CHANGED](https://jb.gg/ipe/listeners?topics=git4idea.branch.GitBranchIncomingOutgoingManager.GitIncomingOutgoingListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GitIncomingOutgoingListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/branch/GitBranchIncomingOutgoingManager.java) |
| [GitAuthenticationListener#GIT_AUTHENTICATION_SUCCESS](https://jb.gg/ipe/listeners?topics=git4idea.commands.GitAuthenticationListener) |[GitAuthenticationListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/commands/GitAuthenticationListener.java) |
| [GitMergeCommitMessageChangedListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.commit.GitMergeCommitMessageChangedListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GitMergeCommitMessageChangedListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/commit/GitMergeCommitMessagePolicy.kt) |
| [GitExecutableManager#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.config.GitExecutableListener) |[GitExecutableListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/config/GitExecutableListener.java) |
| [GitVcsSettingsListener#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.config.GitVcsSettings.GitVcsSettingsListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GitVcsSettingsListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/shared/src/git4idea/config/GitVcsSettings.java) |
| [GitFetchInProgressListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.fetch.GitFetchInProgressListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GitFetchInProgressListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/fetch/GitFetchInProgressListener.kt) |
| [GitPushListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.push.GitPushListener) |[GitPushListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/push/GitPushListener.kt) |
| [GitRepositoryFrontendSynchronizer#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.remoteApi.GitRepositoryFrontendSynchronizer)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GitRepositoryFrontendSynchronizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/remoteApi/GitRepositoryFrontendSynchronizer.kt) |
| [GitCommitTemplateListener#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.repo.GitCommitTemplateListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GitCommitTemplateListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/repo/GitCommitTemplateTracker.kt) |
| [GitConfigListener#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.repo.GitConfigListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GitConfigListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/repo/GitConfigListener.kt) |
| [GitRepository#GIT_REPO_CHANGE](https://jb.gg/ipe/listeners?topics=git4idea.repo.GitRepositoryChangeListener) |[GitRepositoryChangeListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/repo/GitRepositoryChangeListener.java) |
| [GitRepository#GIT_REPO_STATE_CHANGE](https://jb.gg/ipe/listeners?topics=git4idea.repo.GitRepositoryStateChangeListener) |[GitRepositoryStateChangeListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/repo/GitRepositoryStateChangeListener.kt) |
| [GitRepositoryUpdateListener#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.repo.GitRepositoryUpdateListener) |[GitRepositoryUpdateListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/repo/GitRepositoryUpdateListener.kt) |
| [GitRepositoryTagsHolder.Companion#TAGS_UPDATED](https://jb.gg/ipe/listeners?topics=git4idea.repo.GitTagsHolderListener) |[GitTagsHolderListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/repo/GitRepositoryTagsHolder.kt) |
| [GitStashSettingsListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.stash.ui.GitStashSettingsListener) |[GitStashSettingsListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/stash/ui/GitStashContentProvider.kt) |
| [GitRefreshListener#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.status.GitRefreshListener) |[GitRefreshListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/status/GitRefreshListener.java) |
| [GitStagingAreaHolder#TOPIC](https://jb.gg/ipe/listeners?topics=git4idea.status.GitStagingAreaHolder.StagingAreaListener) |[StagingAreaListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/status/GitStagingAreaHolder.java) |
| [GitCurrentBranchPresenter.Companion#PRESENTATION_UPDATED](https://jb.gg/ipe/listeners?topics=git4idea.ui.branch.GitCurrentBranchPresenter.PresentationUpdatedListener)  ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[PresentationUpdatedListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/ui/branch/GitCurrentBranchPresenter.kt) |
| [SvnVcs#WC_CONVERTED](https://jb.gg/ipe/listeners?topics=java.lang.Runnable)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`Runnable` |
| [RootsAndBranches#REFRESH_REQUEST](https://jb.gg/ipe/listeners?topics=java.lang.Runnable)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`Runnable` |
| [Merger#COMMITTED_CHANGES_MERGED_STATE](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.svn.integrate.Merger.CommittedChangesMergedStateChanged)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[CommittedChangesMergedStateChanged](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/svn4idea/src/org/jetbrains/idea/svn/integrate/Merger.java) |
| [SvnMergeInfoCache#SVN_MERGE_INFO_CACHE](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.svn.mergeinfo.SvnMergeInfoCache.SvnMergeInfoCacheListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[SvnMergeInfoCacheListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/svn4idea/src/org/jetbrains/idea/svn/mergeinfo/SvnMergeInfoCache.java) |
| [GHPRDataOperationsListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.plugins.github.pullrequest.data.provider.GHPRDataOperationsListener) |[GHPRDataOperationsListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/github/github-core/src/org/jetbrains/plugins/github/pullrequest/data/provider/GHPRDataOperationsListener.kt) |
| [HgVcs#REMOTE_TOPIC](https://jb.gg/ipe/listeners?topics=org.zmlx.hg4idea.HgUpdater)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[HgUpdater](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/hg4idea/src/org/zmlx/hg4idea/HgUpdater.java) |
| [HgVcs#STATUS_TOPIC](https://jb.gg/ipe/listeners?topics=org.zmlx.hg4idea.HgUpdater)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[HgUpdater](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/hg4idea/src/org/zmlx/hg4idea/HgUpdater.java) |
| [HgVcs#INCOMING_OUTGOING_CHECK_TOPIC](https://jb.gg/ipe/listeners?topics=org.zmlx.hg4idea.status.ui.HgWidgetUpdater)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[HgWidgetUpdater](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/hg4idea/src/org/zmlx/hg4idea/status/ui/HgWidgetUpdater.java) |

### intellij.vcs.git.backend.xml

[intellij.vcs.git.backend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/resources/intellij.vcs.git.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [Git4Idea.GitCheckinExplicitMovementProvider](https://jb.gg/ipe?extensions=Git4Idea.GitCheckinExplicitMovementProvider)      |[GitCheckinExplicitMovementProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/checkin/GitCheckinExplicitMovementProvider.java) |
| [Git4Idea.GitHttpAuthDataProvider](https://jb.gg/ipe?extensions=Git4Idea.GitHttpAuthDataProvider)      |[GitHttpAuthDataProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/remote/GitHttpAuthDataProvider.java) |
| [Git4Idea.gitAnnotationPerformanceListener](https://jb.gg/ipe?extensions=Git4Idea.gitAnnotationPerformanceListener)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GitAnnotationPerformanceListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/annotate/GitAnnotationPerformanceListener.kt) |
| [Git4Idea.gitBranchReviewPresenter](https://jb.gg/ipe?extensions=Git4Idea.gitBranchReviewPresenter)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[GitBranchReviewPresenter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/ui/branch/GitBranchReviewPresenter.kt) |
| [Git4Idea.gitCurrentBranchPresenter](https://jb.gg/ipe?extensions=Git4Idea.gitCurrentBranchPresenter)      |[GitCurrentBranchPresenter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/ui/branch/GitCurrentBranchPresenter.kt) |
| [Git4Idea.gitFetchHandler](https://jb.gg/ipe?extensions=Git4Idea.gitFetchHandler)      |[GitFetchHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/fetch/GitFetchHandler.kt) |
| [Git4Idea.gitPostUpdateHandler](https://jb.gg/ipe?extensions=Git4Idea.gitPostUpdateHandler)      |[GitPostUpdateHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/update/GitPostUpdateHandler.kt) |
| [Git4Idea.gitProtectedBranchProvider](https://jb.gg/ipe?extensions=Git4Idea.gitProtectedBranchProvider)      |[GitProtectedBranchProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/config/GitProtectedBranchProvider.kt) |
| [Git4Idea.gitPushNotificationCustomizer](https://jb.gg/ipe?extensions=Git4Idea.gitPushNotificationCustomizer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GitPushNotificationCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/push/GitPushNotificationCustomizer.kt) |
| [Git4Idea.gitRawAnnotationProvider](https://jb.gg/ipe?extensions=Git4Idea.gitRawAnnotationProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[GitRawAnnotationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/annotate/GitAnnotationProvider.java) |
| [Git4Idea.gitRepositoryHostingService](https://jb.gg/ipe?extensions=Git4Idea.gitRepositoryHostingService)      |[GitRepositoryHostingService](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/remote/GitRepositoryHostingService.java) |
| [Git4Idea.gitWorktreeOpenPathProvider](https://jb.gg/ipe?extensions=Git4Idea.gitWorktreeOpenPathProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GitWorktreeOpenPathProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/workingTrees/GitWorktreeOpenPathProvider.kt) |
| [Git4Idea.instantGitTokenProvider](https://jb.gg/ipe?extensions=Git4Idea.instantGitTokenProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[InstantGitTokenProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/instant/InstantGitTokenProvider.kt) |
| [Git4Idea.worktreeAdditionalConfigCopier](https://jb.gg/ipe?extensions=Git4Idea.worktreeAdditionalConfigCopier)      |[GitWorktreeAdditionalConfigCopier](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/workingTrees/GitWorktreeAdditionalConfigCopier.kt) |
| [Git4Idea.worktreeSettingsPanelProvider](https://jb.gg/ipe?extensions=Git4Idea.worktreeSettingsPanelProvider)      |[GitWorktreeSettingsPanelProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/git4idea/backend/src/workingTrees/dialog/GitWorktreeSettingsPanelProvider.kt) |

### intellij.vcs.github.xml

[intellij.vcs.github.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/github/github-core/resources/intellij.vcs.github.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.github.ghShareProjectCompatibilityExtension](https://jb.gg/ipe?extensions=com.intellij.github.ghShareProjectCompatibilityExtension)      ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) ![Removal](https://img.shields.io/badge/-Removal-red?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GHShareProjectCompatibilityExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/github/github-core/src/org/jetbrains/plugins/github/GHShareProjectUtil.kt) |
| [com.intellij.vcs.github.gistContentsCollector](https://jb.gg/ipe?extensions=com.intellij.vcs.github.gistContentsCollector)      |[GithubGistContentsCollector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/github/github-core/src/org/jetbrains/plugins/github/GithubGistContentsCollector.kt) |
| [intellij.vcs.github.aiReviewExtension](https://jb.gg/ipe?extensions=intellij.vcs.github.aiReviewExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GHPRAIReviewExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/github/github-core/src/org/jetbrains/plugins/github/ai/GHPRAIReviewExtension.kt) |
| [intellij.vcs.github.aiSummaryExtension](https://jb.gg/ipe?extensions=intellij.vcs.github.aiSummaryExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GHPRAISummaryExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/github/github-core/src/org/jetbrains/plugins/github/ai/GHPRAISummaryViewModel.kt) |
| [intellij.vcs.github.titleAndDescriptionGenerator](https://jb.gg/ipe?extensions=intellij.vcs.github.titleAndDescriptionGenerator)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GHPRTitleAndDescriptionGeneratorExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/github/github-core/src/org/jetbrains/plugins/github/pullrequest/ui/toolwindow/create/GHPRCreateTitleAndDescriptionGenerationViewModel.kt) |

### intellij.vcs.gitlab.backend.xml

[intellij.vcs.gitlab.backend.xml](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gitlab/gitlab-core/resources/intellij.vcs.gitlab.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [intellij.vcs.gitlab.titleGenerator](https://jb.gg/ipe?extensions=intellij.vcs.gitlab.titleGenerator)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GitLabTitleAndDescriptionGeneratorExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/gitlab/gitlab-core/src/org/jetbrains/plugins/gitlab/mergerequest/ui/create/model/GitLabMergeRequestCreateTitleGenerationViewModel.kt) |

### Subversion

[Subversion](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/svn4idea/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.vcs.svn.mergerCommitMessage](https://jb.gg/ipe?extensions=com.intellij.vcs.svn.mergerCommitMessage)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[MergerCommitMessage](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/svn4idea/src/org/jetbrains/idea/svn/integrate/MergerCommitMessage.kt) |

