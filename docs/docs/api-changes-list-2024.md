# Incompatible Changes in IntelliJ Platform and Plugins API 2024.*

Please see [Verifying Plugin Compatibility](verifying-plugin-compatibility.html) on how to use Plugin Verifier and IDE inspections
to check such problems.

Early Access Program
(EAP) releases of upcoming versions are available [here](https://eap.jetbrains.com).

Note: Non-listed changes

Changes from API marked with `@Deprecated(forRemoval=true)` or any of [ApiStatus](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java)
`@Experimental`, `@ScheduledForRemoval`, or `@Internal` are not listed
here, as incompatible changes are to be expected.

For API annotated with `@ApiStatus.Internal`, see [Internal API Migration](api-internal.html) for more details and replacements.

Note: IDE and Java Versions

Java version must be set depending on the target
[platform version](build-number-ranges.html#platformVersions).

2026.2+
: Java 25

2024.2+
: Java 21

Warning: Gradle Plugin

The Gradle plugin must be chosen depending on the target
[platform version](build-number-ranges.html#platformVersions).

2024.2+
: Requires
[IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html)

2022.3+
: Recommended
[IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html)
: Requires
[Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html)
(Obsolete)
1.10.1+

## 2024.3

### IntelliJ Platform 2024.3

`com.intellij.psi.stubs.StubElement.getChildrenStubs()` method return type changed from `List<StubElement>` to `List<StubElement<?>>`
: Raw-type changed to a properly parameterized type. This is binary compatible change but may cause compilation errors. In most of the cases, it's enough to add `<?>` at the use site to fix the issue.

Unbundled JUnit library
: Add an explicit dependency in the plugin project.

`com.intellij.openapi.actionSystem.impl.MoreActionGroup(boolean, int, DefaultConstructorMarker)` constructor removed
: Use other constructors instead.

`ai.grazie.nlp.stemmer` package removed
: Add an explicit dependency on the NLP platform if needed.

`com.intellij.openapi.externalSystem.model.task.event.ExternalSystemStartEventImpl` class renamed to `com.intellij.openapi.externalSystem.model.task.event.ExternalSystemStartEvent`
: Use new class

`com.intellij.openapi.externalSystem.model.task.event.TaskOperationDescriptorImpl` class renamed to `com.intellij.openapi.externalSystem.model.task.event.TaskOperationDescriptor`
: Use new class

`com.intellij.openapi.externalSystem.model.task.event.DefaultOperationResult` class renamed to `com.intellij.openapi.externalSystem.model.task.event.OperationResult`
: Use new class

`com.intellij.openapi.externalSystem.model.task.event.FailureResultImpl` class renamed to `com.intellij.openapi.externalSystem.model.task.event.FailureResult`
: Use new class

`com.intellij.openapi.externalSystem.model.task.event.SkippedResultImpl` class renamed to `com.intellij.openapi.externalSystem.model.task.event.SkippedResult`
: Use new class

`com.intellij.openapi.externalSystem.model.task.event.SuccessResultImpl` class renamed to `com.intellij.openapi.externalSystem.model.task.event.SuccessResult`
: Use new class

`com.intellij.openapi.externalSystem.model.task.event.ExternalSystemStatusEventImpl` class renamed to `com.intellij.openapi.externalSystem.model.task.event.ExternalSystemStatusEvent`
: Use new class

`com.intellij.openapi.externalSystem.model.task.event.FailureImpl` class renamed to `com.intellij.openapi.externalSystem.model.task.event.Failure`
: Use new class

`com.intellij.openapi.externalSystem.model.task.event.ExternalSystemFinishEventImpl` class renamed to `com.intellij.openapi.externalSystem.model.task.event.ExternalSystemFinishEvent`
: Use new class

Interface `com.intellij.openapi.externalSystem.model.task.event.TaskOperationDescriptor` changed to class
: Recompile the plugin with new class

`com.intellij.openapi.externalSystem.importing.AbstractOpenProjectProvider.linkToExistingProjectAsync(VirtualFile arg0, Project arg1, Continuation arg2)` method marked final
: Override method `com.intellij.openapi.externalSystem.importing.AbstractOpenProjectProvider#linkProject` instead

### JSON Plugin (new) 2024.3

`com.intellij.json.JsonElementTypes` class removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

`com.intellij.json.JsonFileType` class removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

`com.intellij.json.JsonLanguage` class removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

`com.intellij.json.JsonParserDefinition` class removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

`com.intellij.json.JsonTokenType` class removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

`com.intellij.json` package removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

`com.intellij.json.codeinsight` package removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

`com.intellij.json.highlighting` package removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

`com.intellij.json.psi` package removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

`com.jetbrains.jsonSchema` package removed
: Add an [explicit dependency](plugin-dependencies.html) on the newly extracted JSON plugin (`com.intellij.modules.json`) in `plugin.xml`.
If the plugin is built against 2024.3+, also add `com.intellij.modules.json` to the [bundled plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#bundled-plugin) in the Gradle build script.

### Database Plugin 2024.3

`com.intellij.database.datagrid.DataGrid.getFormatterConfig(ModelIndex)` abstract method added
: Only recompilation is needed for classes that implement `DataGrid` and delegate calls to an actual `DataGrid` implementation.

### Package Checker 2024.3

`com.intellij.packageChecker.model.Dependency(Package, Set, DataContext)` constructor removed
: Use other constructors instead.

### HTTP Client Plugin 2024.3

`com.intellij.httpClient.http.request.run.HttpRunRequestInfo` class moved to package `com.intellij.httpClient.http.request.run.info`
: Update code usages.

### JavaScript Plugin 2024.3

`com.intellij.lang.ecmascript6.JSXHarmonyFileType` class renamed to `com.intellij.lang.javascript.JSXFileType`
: Update code usages.

Interface `com.intellij.lang.javascript.JSElementTypes` no longer extends `com.intellij.lang.javascript.JSStubElementTypes`
: Update code usages.

Field `com.intellij.lang.javascript.JavaScriptSupportLoader.ECMA_SCRIPT_L4` moved to `com.intellij.lang.javascript.flex.FlexSupportLoader`
: Update code usages.

### Kotlin Plugin 2024.3

`org.jetbrains.kotlin.idea.quickfix.AddAnnotationFix(KtElement, ClassId, AddAnnotationFix.Kind, FqName, SmartPsiElementPointer, int, DefaultConstructorMarker)` constructor parameter type changed from `FqName` to `List<String>`
: Update code usages.

## 2024.2

### IntelliJ Platform 2024.2

Constructor of `com.intellij.ui.tabs.TabInfo` requires not-null `JComponent` argument.

`com.intellij.execution.lineMarker.ExecutorAction.Companion.wrap(RunContextAction, Int)` method removed
: Use `com.intellij.execution.lineMarker.ExecutorAction.Companion.wrap(AnAction, Executor, Int)` instead.

`org.apache.sanselan.util` package removed
: `org.apache.sanselan.util.IOUtils` compatibility shim is obsolete; instead, please use JRE methods or `org.apache.commons.io.IOUtils`.

`com.intellij.platform.workspace.storage.url.VirtualFileUrlManager.getOrCreateFromUri(String)` method removed
: Use `com.intellij.platform.workspace.storage.url.VirtualFileUrlManager.getOrCreateFromUrl(String)` instead.

`com.intellij.platform.workspace.jps.entities.DependenciesKt.modifyEntity(MutableEntityStorage, LibraryEntity, Function1)` method removed
: Use `com.intellij.platform.workspace.jps.entities.DependenciesKt.modifyLibraryEntity(MutableEntityStorage, LibraryEntity, Function1)` instead.

`ai.grazie.nlp.utils.UtilsKt.tokenizeByWhitespace(String)` method removed
: NLP platform internals.

### UML Plugin 2024.2

`com.intellij.uml.UmlGraphBuilder(Project, Graph2D, Graph2DView, DiagramDataModel<?>, DiagramPresentationModel)` constructor removed
: Use `com.intellij.uml.UmlGraphBuilder(Project, Graph2D, Graph2DView, DiagramDataModel<?>, GraphThreadingType, DiagramPresentationModel)` instead.

`com.intellij.openapi.graph.impl.builder.GraphBuilderImpl.addEdge(Object, Object, Object)` method removed
: Use `com.intellij.openapi.graph.impl.builder.GraphBuilderImpl.addEdge(Object, Object, String, Object, Object[], Function<? super E,? extends Edge>)` instead.

### Python Plugin 2024.2

`com.jetbrains.python.PyElementTypes.STATEMENT_LIST` field type changed from `PyElementType` to `IElementType`
: Update code usages.

### Kotlin Plugin 2024.2

`org.jetbrains.kotlin.analysis.low.level.api.fir.LLFirResolveSessionService.getFirResolveSessionNoCaching(module: KtModule)` method removed
: Internals of Kotlin plugin.

`org.jetbrains.kotlin.analysis.project.structure.ProjectStructureProvider.Companion.getModule(Project, PsiElement, KtModule)` method removed
: Use `org.jetbrains.kotlin.analysis.api.projectStructure.KaModuleProvider.Companion.getModule(Project, PsiElement, KtModule)` instead.

`org.jetbrains.kotlin.codegen.state.TypeMappingUtil.getJVM_SUPPRESS_WILDCARDS_ANNOTATION_FQ_NAME` method removed
: Use `org.jetbrains.kotlin.name.JvmStandardClassIds.getJVM_SUPPRESS_WILDCARDS_ANNOTATION_FQ_NAME` instead.

`org.jetbrains.kotlin.fir.types.ConeTypeUtilsKt.renderReadableWithFqNames(ConeKotlinType)` method removed
: Internals of Kotlin compiler.

`org.jetbrains.kotlin.analysis.project.structure.KtModule` class renamed to `org.jetbrains.kotlin.analysis.api.projectStructure.KaModule`
: Update code usages.

`org.jetbrains.kotlin.fir.expressions.FirAssignmentOperatorStatement` class removed
: Internals of Kotlin compiler.

### Database Plugin 2024.2

`com.intellij.database.datagrid.DataGrid.getCoroutineScope()` abstract method added
: Only recompilation is needed for classes that implement `DataGrid` and delegate calls to an actual `DataGrid` implementation.

`com.intellij.database.datagrid.DataGrid.getModificationTracker()` abstract method added
: Only recompilation is needed for classes that implement `DataGrid` and delegate calls to an actual `DataGrid` implementation.

`com.intellij.database.datagrid.DataGrid.adaptForNewQuery()` abstract method added
: Only recompilation is needed for classes that implement `DataGrid` and delegate calls to an actual `DataGrid` implementation.

### HTTP Client Plugin 2024.2

`com.intellij.httpClient.http.request.HttpRequestPsiConverter.toRequestConfig(HttpRequest)` method visibility changed from `public` to `private`
: This method is an implementation detail.

### Dependency Analysis Plugin 2024.2

`com.jetbrains.dependencyAnalysis` package removed
: The package `com.jetbrains.dependencyAnalysis` has been removed. Please update the code to use the new package `com.jetbrains.dependencyAnalysis.core` instead.

## 2024.1

### IntelliJ Platform 2024.1

`com.intellij.refactoring.RefactoringHelper.prepareOperation(UsageInfo [] usages, List<PsiElement> elements)` abstract method added
: Use instead of `com.intellij.refactoring.RefactoringHelper.prepareOperation(UsageInfo [] usages)` and `com.intellij.refactoring.RefactoringHelper.prepareOperation(UsageInfo [] usages, PsiElement primaryElement)`.

`com.intellij.refactoring.RefactoringHelper.prepareOperation(UsageInfo [] usages)` method removed
: Use `com.intellij.refactoring.RefactoringHelper.prepareOperation(UsageInfo [] usages, List<PsiElement> elements)` instead.

`com.intellij.refactoring.RefactoringHelper.prepareOperation(UsageInfo [] usages, PsiElement primaryElement)` method removed
: Use `com.intellij.refactoring.RefactoringHelper.prepareOperation(UsageInfo [] usages, List<PsiElement> elements)` instead.

`com.jetbrains.commandInterface.commandLine.psi.CommandLineFile` class moved to package `com.intellij.commandInterface.commandLine.psi`
: Update code usages.

`com.jetbrains.commandInterface.commandLine.CommandLineLanguage` class moved to package `com.intellij.commandInterface.commandLine`
: Update code usages.

`com.jetbrains.commandInterface.commandLine.psi.CommandLineArgument` class moved to package `com.intellij.commandInterface.commandLine.psi`
: Update code usages.

`com.jetbrains.commandInterface.commandLine.psi.CommandLineOption` class moved to package `com.intellij.commandInterface.commandLine.psi`
: Update code usages.

`com.intellij.application.options.editor.CodeFoldingConfigurable.applyCodeFoldingSettingsChanges()` method removed
: Use top-level method `CodeFoldingConfigurableKt.applyCodeFoldingSettingsChanges` instead.

`com.intellij.ide.bookmark.providers.LineBookmarkProvider.Companion` class removed
: Use `com.intellij.ide.bookmark.providers.LineBookmarkProvider.Util` instead.

`com.intellij.execution.process.mediator.util` package removed
: The sole extension method `Deferred<T>.blockingGet()` contained in this package is an anti-pattern, and was not supposed to be exposed in the first place. The process mediator and the elevation service are now product modules, and no longer part of the platform.

`com.intellij.vcs.log.VcsLogFileHistoryHandler.getSupportedVcs()` abstract method added
: Must be implemented.

`com.intellij.vcs.log.VcsLogFileHistoryHandler.getHistoryFast(root: VirtualFile, filePath: FilePath, hash: Hash?, filters: VcsLogFilterCollection, commitCount: Int)` abstract method added
: Parameter `filters: VcsLogFilterCollection` was added to provide filtering capabilities to file history. Implement `com.intellij.vcs.log.VcsLogFileHistoryHandler.getSupportedFilters` to specify which filters are supported by this extension (currently, branch filter, revision filter and range filter are available).

`com.intellij.vcs.log.VcsLogFileHistoryHandler.collectHistory(root: VirtualFile, filePath: FilePath, hash: Hash?, filters: VcsLogFilterCollection, consumer)` abstract method added
: Parameter `filters: VcsLogFilterCollection` was added to provide filtering capabilities to file history. Implement `com.intellij.vcs.log.VcsLogFileHistoryHandler.getSupportedFilters` to specify which filters are supported by this extension (currently, branch filter, revision filter and range filter are available).

`org.apache.tools` package removed
: Please provide all necessary libraries in the plugin distribution.

`com.intellij.openapi.projectRoots.impl.ProjectJdkImpl.readExternal(Element, ProjectJdkTable)` method removed
: Use `com.intellij.openapi.projectRoots.impl.ProjectJdkImpl.readExternal(Element, Function<String, SdkTypeId>)` instead.

`com.intellij.openapi.projectRoots.impl.SdkConfigurationUtil.createSdk(Collection<Sdk>, String, SdkType, SdkAdditionalData, String)` method return type changed from `ProjectJdkImpl` to `Sdk`
: Update code usages.

`com.intellij.openapi.projectRoots.impl.SdkConfigurationUtil.createSdk(Collection<Sdk>, VirtualFile, SdkType, SdkAdditionalData, String)` method return type changed from `ProjectJdkImpl` to `Sdk`
: Update code usages.

Class `com.intellij.diff.editor.DiffVirtualFile` now extends `com.intellij.diff.editor.DiffViewerVirtualFile` and inherits its abstract method `com.intellij.diff.editor.DiffViewerVirtualFile.createViewer(Project)`
: Update code usages.

`com.intellij.diff.tools.combined.CombinedDiffVirtualFile.getSourceId()` method removed
: Update code usages.

`com.intellij.diff.tools.combined.CombinedDiffModel` interface removed
: Use `com.intellij.diff.tools.combined.CombinedDiffModel` class instead.

`com.intellij.diff.tools.combined.CombinedDiffVirtualFile.createViewer(Project)` abstract method added
: Must be implemented.

`com.intellij.openapi.util.io.NioPathUtil.isAncestor(Path, Path, boolean)` method removed
: Use `Path.startsWith()` instead.

`com.intellij.util.CachedValueBase.setData(CachedValueBase.Data)` abstract method added
: Must be implemented.

`com.intellij.util.CachedValueBase.getRawData()` abstract method added
: Must be implemented.

Visibility of class `com.intellij.util.CachedValuesFactory` changed from public to internal
: The class is not supposed to be used directly.

`com.intellij.ui.popup.ActionPopupStep.performAction(AnAction, InputEvent)` method parameter type changed from `AnAction` to `ActionItem`
: Use `com.intellij.ui.popup.ActionPopupStep.performActionItem(ActionItem, InputEvent)` instead.

`com.intellij.openapi.actionSystem.AnAction.getTemplateText()` method marked final
: Use `AnAction.getTemplatePresentation().setText()` instead.

`com.intellij.openapi.actionSystem.ActionGroup.isPopup()` method marked final
: Use `ActionGroup.getTemplatePresentation().setPopupGroup(boolean)` instead.

`com.intellij.webcore.packaging.InstalledPackagesPanel.myInstallButton` field removed
: Use `InstalledPackagesPanel.myInstallEnabled` instead.

### UML Plugin 2024.1

`com.intellij.uml.core.actions.ShowDiagramBase.findProviders(AnActionEvent, DiagramProvider, BiFunction)` method removed
: Use `com.intellij.uml.core.actions.ShowDiagramBase.findProviders(DiagramProvider<?>, BiFunction<? super DiagramProvider<?>,? super DataContext,java.lang.Object>, DataContext)` instead.

### Java Plugin 2024.1

`com.intellij.lang.properties.RemovePropertyLocalFix` class removed
: Use `com.intellij.codeInsight.daemon.impl.quickfix.DeleteElementFix` instead.

### Django Plugin 2024.1

Package `com.jetbrains.jinja2` renamed to `com.intellij.jinja`
: Update code usages.

### Restructured Text Plugin 2024.1

`com.jetbrains.rest.RestLanguage` class moved to package `com.intellij.python.reStructuredText`
: Update code usages.

### GitHub Plugin 2024.1

`org.jetbrains.plugins.github.pullrequest.comment.GHPRDiffReviewSupport` class removed
: Migrated to MVVM.

`org.jetbrains.plugins.github.pullrequest.comment.GHPRDiffReviewSupport.Companion` class removed
: Migrated to MVVM.

`org.jetbrains.plugins.github.pullrequest.action.GHPRActionKeys.getPULL_REQUEST_DATA_PROVIDER()` method removed
: Migrated to MVVM, hidden implementation details.

### Kotlin Plugin 2024.1

`org.jetbrains.kotlin.ir.visitors.IrElementVisitor.visitInlinedFunctionBlock(inlinedFunctionBlock: IrInlinedFunctionBlock, data: D)` abstract method added
: Update code usages.

`org.jetbrains.kotlin.ir.visitors.IrElementVisitor.visitReturnableBlock(returnableBlock: IrReturnableBlock, data: D)` abstract method added
: Update code usages.

`org.jetbrains.kotlin.ir.visitors.IrElementVisitorVoid.visitInlinedFunctionBlock(inlinedFunctionBlock: IrInlinedFunctionBlock)` abstract method added
: Update code usages.

`org.jetbrains.kotlin.ir.visitors.IrElementVisitorVoid.visitInlinedFunctionBlock(inlinedFunctionBlock: IrInlinedFunctionBlock, data: Nothing?)` abstract method added
: Update code usages.

`org.jetbrains.kotlin.ir.visitors.IrElementVisitorVoid.visitReturnableBlock(returnableBlock: IrReturnableBlock)` abstract method added
: Update code usages.

`org.jetbrains.kotlin.ir.visitors.IrElementVisitorVoid.visitReturnableBlock(retunrableBlock: IrReturnableBlock, data: Nothing?)` abstract method added
: Update code usages.

`org.jetbrains.kotlin.fir.expressions.FirConstExpression` class renamed `org.jetbrains.kotlin.fir.expressions.FirLiteralExpression`
: Update code usages.

`org.jetbrains.kotlin.ir.declarations.IrDeclarationOrigin.DELEGATE` class removed
: `org.jetbrains.kotlin.ir.declarations.IrDeclarationOrigin.Companion.DELEGATE` should be used instead.

`org.jetbrains.kotlin.ir.declarations.IrDeclarationOrigin.DELEGATED_MEMBER` class removed
: `org.jetbrains.kotlin.ir.declarations.IrDeclarationOrigin.Companion.DELEGATED_MEMBER` should be used instead.

`org.jetbrains.kotlin.config.JvmDefaultMode.DEFAULT` field removed
: Use `org.jetbrains.kotlin.config.JvmDefaultMode.DISABLE`.

Method `org.jetbrains.kotlin.backend.common.lower.LocalDeclarationsLoweringKt.getParentsWithSelf(IrDeclaration)` renamed to `org.jetbrains.kotlin.ir.util.IrUtilsKt.getParentsWithSelf`
: Update code usages.

`org.jetbrains.kotlin.daemon.common.CompileService.Companion.getNO_SESSION()` method removed
: Use `org.jetbrains.kotlin.daemon.common.CompileService.NO_SESSION` const instead.

Class `org.jetbrains.kotlin.ir.declarations.IrDeclarationOriginImpl` made final
: Create a new `IrDeclarationOrigin` by delegation. See https://github.com/JetBrains/kotlin/blob/a3b55cf758f3a7ceb596f65507c2f61ada5266af/compiler/ir/ir.tree/src/org/jetbrains/kotlin/ir/declarations/IrDeclarationOrigin.kt#L20.

`org.jetbrains.kotlin.idea.refactoring.introduce.extractFunction.ExtractKotlinFunctionHandlerKt` class removed
: Use `com.intellij.lang.refactoring.RefactoringSupportProvider.getExtractMethodHandler` instead to invoke Kotlin extract function refactoring

### Maven Plugin 2024.1

`org.jetbrains.idea.maven.indices.MavenIndex.getUpdateTimestamp()` method removed
: Use `org.jetbrains.idea.maven.indices.MavenIndexImpl.getUpdateTimestamp()` instead. `MavenIndex` is an obsolete interface now with `MavenIndexImpl` as the only implementation, consider using `MavenGAVIndex` to get information about available Maven GAV coordinates, or `MavenSearchIndex` to search Maven artifacts by content.

`org.jetbrains.idea.maven.indices.MavenIndex.getFailureMessage()` method removed
: Use `org.jetbrains.idea.maven.indices.MavenIndexImpl.getFailureMessage()` instead. `MavenIndex` is an obsolete interface now with `MavenIndexImpl` as the only implementation, consider using `MavenGAVIndex` to get information about available Maven GAV coordinates, or `MavenSearchIndex` to search Maven artifacts by content.

`org.jetbrains.idea.maven.indices.MavenIndex.getRepositoryPathOrUrl()` method removed
: Use `org.jetbrains.idea.maven.indices.MavenRepositoryIndex.getRepository().getUrl()` instead. Also, `MavenRepositoryInfo.getKind()` could be used to distinguish between local and remote repo.

`org.jetbrains.idea.maven.indices.MavenIndicesManager.scheduleUpdateContent(List<MavenIndex>, boolean)` method removed
: Use `org.jetbrains.idea.maven.indices.searcher.MavenLuceneIndexer.update(List<MavenRepositoryInfo>, Boolean)` to update content for lucene indices. GAV indices do not need to be updated explicitly.

`org.jetbrains.idea.maven.indices.MavenIndicesManager.scheduleUpdateIndicesList(Consumer<MavenIndex>)` method removed
: Use `org.jetbrains.idea.maven.indices.searcher.MavenIndicesManager.scheduleUpdateIndicesList()` to update an indices list for a specific project. To get all search indices for specific project use `MavenSystemIndicesManager.getClassIndexForRepository()`, and get a list of all repositories with `MavenIndexUtils.getAllRepositories(Project)`.

### Database Plugin 2024.1

`com.intellij.database.datagrid.DataGrid.getLocalFilterState()` abstract method added
: Only recompilation is needed for classes that implement `DataGrid` and delegate calls to an actual `DataGrid` implementation.

`com.intellij.database.datagrid.DataGrid.getColumnAttributes()` abstract method added
: Only recompilation is needed for classes that implement `DataGrid` and delegate calls to an actual `DataGrid` implementation.

`com.intellij.sql.psi.SqlTableExpression.getSqlType()` method removed
: Use `getDasType()` instead

### HTTP Client Plugin 2024.1

`com.intellij.httpClient.actions.generation.RequestUrlContextInfo(requestContextData: RequestContextData)` constructor parameter removed
: Use `com.intellij.httpClient.actions.generation.RequestBody` and `com.intellij.httpClient.actions.generation.HttpRequestUrlPathInfo.Companion.create()` to describe a request body that will be coomputed lazily during the corresponding request generation.

### Markdown Plugin 2024.1

`org.intellij.plugins.markdown.ui.split` package removed
: Update code usages.

`org.intellij.plugins.markdown.ui.split.SplitTextEditorProvider` class removed
: Use `com.intellij.openapi.fileEditor.TextEditorWithPreviewProvider` instead.

### Python Plugin 2024.1

`com.jetbrains.extensions.ModuleExt` class moved to package `com.jetbrains.python.extensions`
: Update code usages.

`com.jetbrains.extensions.QualifiedNameExt` class moved to package `com.jetbrains.python.extensions`
: Update code usages.

`com.jetbrains.extensions.python.PyCallExpressionExt` class moved to package `com.jetbrains.python.extensions.python`
: Update code usages.

`com.jetbrains.extensions.python.FileChooserDescriptorExtKt` class moved to package `com.jetbrains.python.extensions`
: Update code usages.

`com.jetbrains.python.module.PythonModuleBuilder` class moved to package `com.intellij.python.community.plugin.java.facet`
: Update code usages.

`com.jetbrains.python.facet` package removed
: Private package is no longer available as an API.

`com.jetbrains.python.debugger.remote` package removed
: Private package is no longer available as an API.

`com.jetbrains.django.util.DjangoUtil` class removed
: Private class is no longer available as an API.

`com.jetbrains.django.testRunner` package removed
: Private package is no longer available as an API.

### JavaScript Plugin 2024.1

`com.intellij.lang.javascript.documentation.JSDocumentationProvider.generateDoc(PsiElement, PsiElement)` method marked final
: Override `com.intellij.lang.javascript.documentation.JSDocumentationProvider.generateDoc(PsiElement, PsiElement, Ref<String>)` instead

### Rd Framework 2024.1

`com.jetbrains.rd.framework.IMarshaller.DefaultImpls.getId(IMarshaller)` method removed
: Due to `RdId` becoming a value class, the `getId` method is removed at runtime, causing unresolved method invocations. Use the method that returns long in Java and recompile the Kotlin code.

`com.jetbrains.rd.framework.RdId.write(AbstractBuffer)` method removed
: Due to `RdId` becoming a value class, the `getId` method is removed at runtime, causing unresolved method invocations. Use `AbstractBuffer.writeLong(long)` method in Java and recompile the Kotlin code.

`org.digma.intellij.plugin.rider.protocol.LensPerObjectId.getRdid()` method removed
: Due to `RdId` becoming a value class, the `getId` method is removed at runtime, causing unresolved method invocations. Use the method that returns `long` in Java and recompile the Kotlin code.

`com.jetbrains.rd.framework.RdId.Companion.read(AbstractBuffer)` method removed
: Due to `RdId` becoming a value class, the `getId` method is removed at runtime, causing unresolved method invocations. Use `AbstractBuffer.readLong()` method in Java and recompile the Kotlin code.

`com.jetbrains.rd.framework.base.RdBindableBaseKt.withId(RdBindableBase, RdId)` method removed
: Due to `RdId` becoming a value class, the `getId` method is removed at runtime, causing unresolved method invocations. Use `withId(RdBindableBase, long)` method in Java and recompile the Kotlin code.

### Properties Plugin 2024.1

Added method parameter `Property` to `com.intellij.lang.properties.PropertiesQuickFixFactory.createRemovePropertyLocalFix()`
: Supply the property that the fix should be applied for.

