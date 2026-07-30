# Frontend, Backend, and Shared APIs

This page lists APIs that commonly indicate where plugin code should live in a split architecture:

* [Frontend APIs](#frontend-apis)

* [Backend APIs](#backend-apis)

* [Shared APIs](#shared-apis)

The lists are intentionally conservative.
Treat them as placement defaults rather than an exhaustive type system.
If a feature needs a different placement, review the specific API behavior and validate the result in [Split Mode](split-mode-and-remote-development.html).

Inspection `Plugin DevKit | Code | Inappropriate Frontend/Backend API usage in module` highlights inappropriate API usage.

See also [Modular Plugins](modular-plugins.html) and [Split Mode Feature Development Guideline](split-mode-feature-development.html).

## Frontend APIs

The following APIs usually belong in the frontend module:

* [com.intellij.openapi.wm.ToolWindowFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/openapi/wm/ToolWindowFactory.kt)

* [com.intellij.openapi.wm.ToolWindow](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/openapi/wm/ToolWindow.java)

* [com.intellij.openapi.editor.toolbar.floating.FloatingToolbarProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/openapi/editor/toolbar/floating/FloatingToolbarProvider.kt)

* [com.intellij.openapi.ui.DialogWrapper](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/openapi/ui/WindowWrapperBuilder.java)

* [com.intellij.openapi.fileEditor.FileEditorProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/openapi/fileEditor/FileEditorProvider.java)

* [com.intellij.openapi.ui.popup.JBPopupFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/openapi/ui/popup/JBPopupFactory.java)

* [com.intellij.codeInsight.editorActions.TypedHandlerDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/editorActions/TypedHandlerDelegate.java)

* [com.intellij.codeInsight.editorActions.enter.EnterHandlerDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/codeInsight/editorActions/enter/EnterHandlerDelegate.java)

* [com.intellij.codeInsight.editorActions.enter.EnterHandlerDelegateAdapter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/codeInsight/editorActions/enter/EnterHandlerDelegateAdapter.java)

* [com.intellij.codeInsight.highlighting.BraceMatcher](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/codeInsight/highlighting/BraceMatcher.java)

* [com.intellij.openapi.fileEditor.FileEditorManager.getFocusedEditor()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/openapi/fileEditor/FileEditorManager.java)

* [com.intellij.execution.services.ServiceViewContributor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/execution/services/ServiceViewContributor.java)

* [com.intellij.ui.tree.AsyncTreeModel](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/ui/tree/AsyncTreeModel.java)

* [com.intellij.ui.jcef.JBCefClient](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ui.jcef/jcef/JBCefClient.java)

* [com.intellij.notification.NotificationGroup](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/notification/NotificationGroupManager.java)

* [com.intellij.openapi.wm.StatusBarWidgetFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/openapi/wm/StatusBarWidgetFactory.java)

* [com.intellij.openapi.options.Configurable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/openapi/options/Configurable.java)

* [com.intellij.codeInsight.editorActions.CopyPastePostProcessor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/editorActions/CopyPastePostProcessor.java)

* [com.intellij.openapi.editor.actionSystem.EditorActionHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/openapi/editor/actionSystem/EditorActionHandler.java)

* [com.intellij.openapi.editor.event.CaretListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/openapi/editor/event/CaretListener.java)

* [com.intellij.openapi.editor.event.EditorMouseMotionListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/openapi/editor/event/EditorMouseMotionListener.java)

* [com.intellij.openapi.editor.event.EditorMouseListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/openapi/editor/event/EditorMouseListener.java)

* [com.intellij.openapi.editor.event.SelectionListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/openapi/editor/event/SelectionListener.java)

* [com.intellij.openapi.editor.event.VisibleAreaListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/openapi/editor/event/VisibleAreaListener.java)

* [com.intellij.openapi.editor.ex.FoldingListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/openapi/editor/ex/FoldingListener.java)

* [com.intellij.openapi.ui.popup.JBPopupListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/openapi/ui/popup/JBPopupListener.java)

* [com.intellij.openapi.actionSystem.CommonDataKeys.EDITOR](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/CommonDataKeys.java)

* [com.intellij.openapi.actionSystem.PlatformDataKeys.TOOL_WINDOW](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/openapi/actionSystem/PlatformDataKeys.java)

* [com.intellij.openapi.actionSystem.PlatformCoreDataKeys.SELECTED_ITEM](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/openapi/actionSystem/PlatformCoreDataKeys.java)

* [com.intellij.openapi.actionSystem.PlatformCoreDataKeys.SELECTED_ITEMS](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/openapi/actionSystem/PlatformCoreDataKeys.java)

* [com.intellij.openapi.actionSystem.PlatformCoreDataKeys.CONTEXT_COMPONENT](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/openapi/actionSystem/PlatformCoreDataKeys.java)

## Backend APIs

The following APIs usually belong in the backend module:

* [com.intellij.openapi.vfs.VirtualFileManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/vfs/VirtualFileManager.java)

* [com.intellij.openapi.vfs.VfsUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/openapi/vfs/VfsUtil.java)

* [com.intellij.psi.stubs.StubIndex](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/stubs/StubIndexKey.java)

* [com.intellij.util.indexing.IndexExtension](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/src/com/intellij/util/indexing/IndexExtension.java)

* [com.intellij.execution.configurations.ConfigurationType](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/execution/src/com/intellij/execution/configurations/ConfigurationType.java)

* [com.intellij.psi.search.searches.ReferencesSearch](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/indexing-api/src/com/intellij/psi/search/searches/ReferencesSearch.java)

* [com.intellij.model.search.SearchService](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/indexing-api/src/com/intellij/model/search/SearchService.kt)

* [com.intellij.util.Query](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/util/Query.kt)

* [com.intellij.ide.FileIconProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/ide/FileIconProvider.java)

* [com.intellij.codeInsight.hints.InlayHintsProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/hints/InlayParameterHintsProvider.java)

* [com.intellij.codeInsight.hints.declarative.InlayHintsProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/hints/declarative/InlayHintsProvider.kt)

* [com.intellij.codeInsight.daemon.LineMarkerProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/daemon/LineMarkerProvider.java)

* [com.intellij.codeInspection.LocalInspectionTool](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/codeInspection/CleanupLocalInspectionTool.java)

* [com.intellij.psi.PsiReferenceContributor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/PsiReferenceContributor.java)

* [com.intellij.codeInsight.completion.CompletionContributor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/codeInsight/completion/CompletionItemContributor.java)

* [com.jetbrains.jsonSchema.extension.JsonSchemaProviderFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/json/backend/src/com/jetbrains/jsonSchema/extension/JsonSchemaProviderFactory.java)

* [com.intellij.execution.actions.RunConfigurationProducer](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/execution/actions/CompatibleRunConfigurationProducer.java)

* [com.intellij.ide.structureView.StructureViewBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/ide/structureView/StructureViewBuilderProvider.java)

* [com.intellij.openapi.vfs.AsyncFileListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/vfs/AsyncFileListener.java)

* [com.intellij.openapi.vfs.VirtualFileListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/vfs/VirtualFileListener.java)

* [com.intellij.platform.backend.workspace.WorkspaceModelChangeListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/backend/workspace/src/WorkspaceModelTopics.kt)

* [com.intellij.openapi.project.ProjectManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/project/ProjectManagerListener.java)

* [com.intellij.execution.process.ProcessHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/src/com/intellij/execution/process/ProcessHandler.java)

* [com.intellij.openapi.actionSystem.CommonDataKeys.SYMBOLS](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/CommonDataKeys.java)

* [com.intellij.openapi.actionSystem.PlatformCoreDataKeys.MODULE](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/openapi/actionSystem/PlatformCoreDataKeys.java)

* [com.intellij.openapi.actionSystem.LangDataKeys.MODULE_CONTEXT](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-core/src/com/intellij/openapi/actionSystem/LangDataKeys.java)

* [com.intellij.openapi.actionSystem.LangDataKeys.MODIFIABLE_MODULE_MODEL](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-core/src/com/intellij/openapi/actionSystem/LangDataKeys.java)

## Shared APIs

The following APIs can be used in both frontend and backend modules.

This list currently includes two categories of APIs:

* language support–related extensions

* project/application lifecycle listeners

Language support should be implemented in the shared module so that PSI can be used on both sides.
The frontend benefits from language support extensions because they enable a fast local editing experience and make it possible to build features on top of them.
For example, a typing handler naturally belongs in the frontend, and it requires PSI for the file type it supports.
The backend also benefits from language support because backend-specific extensions depend on it as well.
For example, an inspection that naturally belongs in the backend requires PSI to traverse the file.

The other category consists of application and project lifecycle listeners.
Since their implementations may produce arbitrary side effects, it is up to the plugin developer to decide whether those effects should run in the backend or the frontend.
For example, if a plugin needs to install and run an external tool after a project is loaded, it should be registered in the backend.
If it needs to display a survey UI with a feedback form after a user changes a registry key, it should run in the frontend.

* [com.intellij.lang.ParserDefinition](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/lang/ParserDefinition.java)

* [com.intellij.openapi.util.registry.RegistryValueListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/src/com/intellij/openapi/util/registry/RegistryValueListener.java)

* [com.intellij.openapi.application.ApplicationListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/application/ApplicationListener.java)

* [com.intellij.openapi.project.ProjectCloseListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/project/ProjectCloseListener.kt)

* [com.intellij.openapi.project.ProjectManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/project/ProjectManagerListener.java)

* [com.intellij.openapi.project.VetoableProjectManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/project/VetoableProjectManagerListener.java)

* [com.intellij.ide.plugins.DynamicPluginListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/ide/plugins/DynamicPluginListener.kt)

* [com.intellij.openapi.fileEditor.FileEditorManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/openapi/fileEditor/FileEditorManagerListener.java)

* [com.intellij.openapi.editor.event.DocumentListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/editor/event/DocumentListener.java)

Shared code should stay lightweight.
If shared logic starts depending on frontend-only or backend-only APIs, it usually belongs in a dedicated content module instead.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

