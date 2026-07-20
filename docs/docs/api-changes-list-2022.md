# Incompatible Changes in IntelliJ Platform and Plugins API 2022.*

Please see [Verifying Plugin Compatibility](verifying-plugin-compatibility.html) on how to use Plugin Verifier and IDE inspections
to check such problems.

Early Access Program
(EAP) releases of upcoming versions are available [here](https://eap.jetbrains.com).

Note: Non-listed changes

Changes from API marked with `@Deprecated(forRemoval=true)` or any of [ApiStatus](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java)
`@Experimental`, `@ScheduledForRemoval`, or `@Internal` are not listed
here, as incompatible changes are to be expected.

For API annotated with `@ApiStatus.Internal`/`@IntellijInternalApi`, see [Internal API Migration](api-internal.html) for more details and replacements.

Note: IDE and Java Versions

Java version must be set depending on the target
[platform version](build-number-ranges.html#platformVersions).

2026.2+
: Java 25

2024.2+
: Java 21

2022.3+
: Java 17

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

## 2022.3

### IntelliJ Platform 2022.3

`com.intellij.openapi.externalSystem.dependency.analyzer.DependencyAnalyzerExtension.isApplicable(ProjectSystemId)` abstract method added
: Must be implemented.

`com.intellij.openapi.externalSystem.dependency.analyzer.DependencyAnalyzerExtension.createContributor(Project, Disposable)` method parameter `ProjectSystemId` removed
: Adjust your code.

`com.intellij.openapi.externalSystem.dependency.analyzer.DependencyAnalyzerExtension.createContributor(Project, Disposable)` method return type changed from `DependencyAnalyzerContributor?` to `DependencyAnalyzerContributor`
: Implement `isApplicable()` instead.

`com.intellij.openapi.editor.EditorCopyPasteHelper.getSelectionTransferable(Editor editor, EditorCopyPasteHelper.CopyPasteOptions options)` abstract method added
: Must be implemented instead of and preferred over `com.intellij.openapi.editor.EditorCopyPasteHelper.copySelectionToClipboard(Editor)` which now delegates to the new method.

`com.intellij.codeInsight.template.TemplateContextType.EP_NAME` field removed
: Use `com.intellij.codeInsight.template.impl.TemplateContextTypes` to get `TemplateContextType` extensions.

`com.intellij.ide.actions.searcheverywhere.FoundItemDescriptor(I, int, int)` constructor removed
: Use `FoundItemDescriptor(I, int)` instead.

### Database Plugin 2022.3

`com.intellij.database.dataSource.url.TypesRegistry.ParamEditor` class removed
: Use `com.intellij.database.dataSource.url.TypeDescriptor.ParamEditor` instead.

`com.intellij.database.dataSource.url.TypesRegistry.BaseTypeDescriptor.createFieldImpl(String caption, String configuration, DataInterchange interchange)` abstract method added
: Must be implemented.

`com.intellij.database.psi.DbDataSourceImpl.getDelegate()` method return type changed from `DatabaseSystem` to `RawDataSource`
: Prefer `com.intellij.database.psi.DbDataSource.getDelegateDataSource()`.

`com.intellij.database.psi.DbPsiFacadeImpl.createDataSourceWrapperElement(DasDataSource, DataSourceManager)` method parameter type changed from `DasDataSource` to `RawDataSource`
: Avoid manually wrapping data sources.

`com.intellij.database.vfs.DatabaseElementVirtualFileImpl.setBusy(boolean)` method removed
: That method was an internal method.

`com.intellij.database.util.TreePatternNode.Group(ObjectKind, TreePatternNode[], TreePatternNode)` constructor removed
: Do not manipulate TreePatternNodes. Use `TreePatternUtils` to manipulate `TreePatterns`.

`com.intellij.database.util.TreePatternNode.NegativeNaming(ObjectName[])` constructor removed
: Do not manipulate TreePatternNodes. Use `TreePatternUtils` to manipulate `TreePatterns`.

`com.intellij.database.dataSource.DataSourceConfigurable.getDataSource()` method return type changed from `DasDataSource` to `RawDataSource`
: Stricter generic bound.

### TextMate Plugin 2022.3

`org.jetbrains.plugins.textmate.language.preferences.PreferencesRegistry` class now interface
: Construct and mutate the `org.jetbrains.plugins.textmate.language.preferences.PreferencesRegistryImpl` instead.

`org.jetbrains.plugins.textmate.language.preferences.PreferencesRegistry.fillFromPList(CharSequence, Plist)` method removed
: Use `org.jetbrains.plugins.textmate.language.preferences.PreferencesRegistryImpl.fillFromPList(CharSequence, Plist)` instead.

`org.jetbrains.plugins.textmate.language.preferences.PreferencesRegistry.clear()` method removed
: Use `org.jetbrains.plugins.textmate.language.preferences.PreferencesRegistryImpl.clear()` instead.

`org.jetbrains.plugins.textmate.language.preferences.PreferencesRegistry()` constructor removed
: Instantiate `org.jetbrains.plugins.textmate.language.preferences.PreferencesRegistryImpl` instead.

`org.jetbrains.plugins.textmate.language.preferences.ShellVariablesRegistry` class now interface
: Construct and mutate the `org.jetbrains.plugins.textmate.language.preferences.ShellVariablesRegistryImpl` instead.

`org.jetbrains.plugins.textmate.language.preferences.ShellVariablesRegistry.fillVariablesFromPlist(CharSequence, Plist)` method removed
: Use `org.jetbrains.plugins.textmate.language.preferences.ShellVariablesRegistryImpl.fillVariablesFromPlist(CharSequence, Plist)` instead.

`org.jetbrains.plugins.textmate.language.preferences.ShellVariablesRegistry.clear()` method removed
: Use `org.jetbrains.plugins.textmate.language.preferences.ShellVariablesRegistryImpl.clear()` instead.

`org.jetbrains.plugins.textmate.language.preferences.ShellVariablesRegistry()` constructor removed
: Instantiate `org.jetbrains.plugins.textmate.language.preferences.ShellVariablesRegistryImpl` instead.

`org.jetbrains.plugins.textmate.language.preferences.SnippetsRegistry` class now interface
: Construct and mutate the `org.jetbrains.plugins.textmate.language.preferences.SnippetsRegistryImpl` instead.

`org.jetbrains.plugins.textmate.language.preferences.SnippetsRegistry.register(TextMateSnippet)` method removed
: Use `org.jetbrains.plugins.textmate.language.preferences.SnippetsRegistryImpl.register(TextMateSnippet)` instead.

`org.jetbrains.plugins.textmate.language.preferences.SnippetsRegistry.clear()` method removed
: Use `org.jetbrains.plugins.textmate.language.preferences.SnippetsRegistryImpl.clear()` instead.

`org.jetbrains.plugins.textmate.language.preferences.SnippetsRegistry()` constructor removed
: Instantiate `org.jetbrains.plugins.textmate.language.preferences.SnippetsRegistryImpl()` instead.

### HTTP Client Plugin 2022.3

`com.intellij.httpClient.http.request.HttpRequestVariableSubstitutor` class now interface
: Use `com.intellij.httpClient.http.request.HttpRequestVariableSubstitutorImpl.create(Project, HttpRequestEnvironment)` for constructing instances.

### JavaScript Plugin 2022.3

`com.intellij.lang.javascript.buildTools.webpack.WebPackConfigManager` class moved to package `com.intellij.webpack`
: Use `com.intellij.webpack.WebpackConfigManager` instead.

`com.intellij.lang.javascript.buildTools.webpack.WebPackConfigManager.Companion` class moved to package `com.intellij.webpack`
: Use `com.intellij.webpack.WebpackConfigManager.Companion` instead.

### Microservices Plugin 2022.3

`com.intellij.microservices.url.inlay.UrlPathInlayAction.isAvailable(file: PsiFile, urlPathContext: UrlPathContext)` method parameter type changed from `com.intellij.microservices.url.references.UrlPathContext` to `com.intellij.microservices.url.inlay.UrlPathInlayHint`
: Use `com.intellij.microservices.url.inlay.UrlPathInlayHint.getContext` to obtain corresponding `UrlPathContext` instance.

### Remote Development Gateway Plugin 2022.3

`com.jetbrains.gateway.ssh.SshMultistagePanelContext.getSshConfig()` method removed
: Use `com.jetbrains.gateway.ssh.SshMultistagePanelContext.getConfig()` instead.

`com.jetbrains.gateway.ssh.SshMultistagePanelContext.setSshConfig(SshConfig)` method removed
: Use `com.jetbrains.gateway.ssh.SshMultistagePanelContext.setConfig(SshConfig)` instead.

### YAML Plugin 2022.3

org.jetbrains.yaml.YAMLParserDefinition no longer implements `org.jetbrains.yaml.YAMLElementTypes`.
: Use `org.jetbrains.yaml.YAMLElementTypes` fields directly.

### Terraform Plugin 2022.3

Top level packages of Terraform `org.intellij.plugins.hcl` and `org.intellij.plugins.hil` moved to single `org.intellij.terraform`.

## 2022.2

### IntelliJ Platform 2022.2

`com.intellij.openapi.actionSystem.TypeSafeDataProvider` class removed
: Use `com.intellij.openapi.actionSystem.DataProvider` class instead.

`com.intellij.openapi.actionSystem.DataSink` class removed
: Removed along with `com.intellij.openapi.actionSystem.TypeSafeDataProvider`.

`com.intellij.openapi.vcs.changes.ui.ChangesBrowser` class removed
: Use `com.intellij.openapi.vcs.changes.ui.ChangesBrowserBase` or `com.intellij.openapi.vcs.changes.ui.SimpleChangesBrowser` instead.

`com.intellij.openapi.vcs.changes.ui.ChangesBrowser.MyUseCase` class removed
: Removed along with `com.intellij.openapi.vcs.changes.ui.ChangesBrowser`.

`com.intellij.openapi.vcs.changes.ui.ChangesTreeList` class removed
: Use `com.intellij.openapi.vcs.changes.ui.ChangesTree` or `com.intellij.openapi.vcs.changes.ui.ChangesTreeImpl` instead.

`com.intellij.ide.IdeEventQueue.unsafeNonblockingExecute(Runnable)` method removed
: Method does not make sense anymore, please see [JBR-4328](https://youtrack.jetbrains.com/issue/JBR-4328).

`com.intellij.vcs.log.VcsLogHighlighter.getStyle(int, VcsShortCommitDetails, boolean)` method removed
: Use `com.intellij.vcs.log.VcsLogHighlighter.getStyle(int, VcsShortCommitDetails, int, boolean)` instead.

`com.intellij.AbstractBundle.getResourceBundle(java.lang.String, java.lang.ClassLoader)` method removed
: Use `com.intellij.DynamicBundle.getResourceBundle(java.lang.ClassLoader, java.lang.String)` instead

### Java Plugin 2022.2

`com.intellij.codeInspection.javaDoc.JavaDocLocalInspection` class removed
: Use `com.intellij.codeInspection.javaDoc.JavadocDeclarationInspection.ADDITIONAL_TAGS` field instead of `JavaDocLocalInspection.myAdditionalJavadocTags`.

### Plugin DevKit Plugin 2022.2

`icons.DevkitIcons` class renamed to `org.jetbrains.idea.devkit.DevKitIcons`
: Use `org.jetbrains.idea.devkit.DevKitIcons` instead.

`icons.DevkitIcons.Gutter` class renamed to `org.jetbrains.idea.devkit.DevKitIcons.Gutter`
: Use `org.jetbrains.idea.devkit.DevKitIcons.Gutter` instead.

### Collaboration Tools 2022.2

`com.intellij.collaboration.auth.ui.AccountsListModelBase.notifyCredentialsChanged(A account)` method visibility changed from protected to private
: Method hidden for better encapsulation.

`com.intellij.collaboration.auth.ui.AccountsPanelFactory.INSTANCE` field removed
: Factory is now a factory.

`com.intellij.collaboration.auth.ui.LoadingAccountsDetailsProvider.DetailsLoadingResult` class removed
: Better API introduced in the form of `com.intellij.collaboration.auth.ui.AccountsDetailsLoader`.

`com.intellij.collaboration.auth.ui.LoadingAccountsDetailsProvider` class removed
: Better API introduced in the form of `com.intellij.collaboration.auth.ui.AccountsDetailsLoader`.

`com.intellij.collaboration.ui.codereview.avatar.CachingAvatarIconsProvider` class renamed to `com.intellij.collaboration.ui.codereview.avatar.CachingCircleImageIconsProvider`
: Icon provider implementation changes to async.

### GitHub 2022.2

`org.jetbrains.plugins.github.api.GithubApiRequestExecutorManager.getExecutor(GithubAccount)` method return type changed from `org.jetbrains.plugins.github.api.GithubApiRequestExecutor.WithTokenAuth` to `org.jetbrains.plugins.github.api.GithubApiRequestExecutor`
: Hidden implementation details.

`org.jetbrains.plugins.github.api.GithubApiRequestExecutorManager.getExecutor(GithubAccount, Project)` method return type changed from `org.jetbrains.plugins.github.api.GithubApiRequestExecutor.WithTokenAuth` to `org.jetbrains.plugins.github.api.GithubApiRequestExecutor`
: Hidden implementation details.

`org.jetbrains.plugins.github.api.GithubApiRequestExecutorManager.getExecutor(GithubAccount, JComponent)` method return type changed from `org.jetbrains.plugins.github.api.GithubApiRequestExecutor.WithTokenAuth` to `org.jetbrains.plugins.github.api.GithubApiRequestExecutor`
: Hidden implementation details.

### Grazie Plugin 2022.2

Method `com.intellij.grazie.GrazieBundle.message(key, parameters)` marked static
: To shorten Java callers.

### Docker Plugin 2022.2

`com.intellij.docker.registry.DockerRegistry` class renamed to `com.intellij.docker.registry.DockerRegistryConfiguration`
: Please update usages.

### JavaScript Plugin 2022.2

`com.intellij.lang.javascript.buildTools.webpack.WebPackConfigManager.setConfig(WebPackConfig)` method moved to the superclass
: Should be used only in tests (marked with `@TestOnly`).

`com.intellij.lang.javascript.buildTools.webpack.WebPackConfig` class renamed to `com.intellij.lang.javascript.buildTools.bundler.WebBundlerConfig`
: Use `com.intellij.lang.javascript.buildTools.bundler.WebBundlerConfig` instead.

`com.intellij.lang.javascript.buildTools.webpack.WebPackResolve` class renamed to `com.intellij.lang.javascript.buildTools.bundler.WebBundlerResolve`
: Use `com.intellij.lang.javascript.buildTools.bundler.WebBundlerResolve` instead.

`com.intellij.lang.javascript.buildTools.webpack.WebPackConfigPath` class removed
: A regular String class is used instead.

## 2022.1

### IntelliJ Platform 2022.1

`org.apache.log4j` package removed
: log4j library removed from IntelliJ Platform, please see this [blog post](https://blog.jetbrains.com/platform/2022/02/removing-log4j-from-the-intellij-platform/) for migration instructions.

`org.slf4j` package removed
: log4j library removed from IntelliJ Platform, please see this [blog post](https://blog.jetbrains.com/platform/2022/02/removing-log4j-from-the-intellij-platform/) for migration instructions.

`com.intellij.openapi.diagnostic.Log4jBasedLogger` class removed
: log4j library removed from IntelliJ Platform, please see this [blog post](https://blog.jetbrains.com/platform/2022/02/removing-log4j-from-the-intellij-platform/) for migration instructions.

`com.intellij.platform.DirectoryProjectConfigurator.configureProject(Project, VirtualFile, Ref<Module>, boolean)` marked abstract
: Implement it instead of removed one.

`com.intellij.psi.impl.java.stubs.index.JavaStubIndexKeys.CLASS_FQN` field type changed from `StubIndexKey<Integer, PsiClass>` to `StubIndexKey<CharSequence, PsiClass>`
: `JavaFullClassNameIndex` now takes `CharSequence` instead of its `hashCode` to allow specific optimizations.

`com.intellij.psi.impl.java.stubs.index.JavaFullClassNameIndex.getKey` method return type changed from `StubIndexKey<Integer, PsiClass>` to `StubIndexKey<CharSequence, PsiClass>`
: `JavaFullClassNameIndex` now takes `CharSequence` instead of its `hashCode` to allow specific optimizations.

`com.intellij.psi.impl.java.stubs.index.JavaFullClassNameIndex.get(Integer, Project, GlobalSearchScope)` method parameter type changed from `Integer` to `CharSequence`
: `JavaFullClassNameIndex` now takes `CharSequence` instead of its `hashCode` to allow specific optimizations.

`com.jcraft.jsch` package removed
: [JSch library](https://mvnrepository.com/artifact/com.jcraft/jsch) was removed, bundle it with your plugin instead.

`com.intellij.diagnostic.DialogAppender.addFilter(Filter)` method removed
: `DialogAppender` now implements `java.util.logging.Handler`, use `setFilter` method if you need to apply a filter.

`com.intellij.psi.impl.cache.impl.BaseFilterLexerUtil.ScanContent` class removed
: Todo index is removed from the indexing procedure, use specific `calcIdEntries` or `calcTodoEntries` method instead.

`com.intellij.psi.impl.cache.impl.BaseFilterLexerUtil.scanContent(FileContent, IdAndToDoScannerBasedOnFilterLexer)` method removed
: Todo index is removed from the indexing procedure, use specific `calcIdEntries` or `calcTodoEntries` method instead.

`com.intellij.util.ui.StartupUiUtil.createStyleSheet(String)` method removed
: Method moved to `com.intellij.util.ui.StyleSheetUtil`

### Collaboration Tools 2022.1

`com.intellij.collaboration.auth.ui.AccountsPanelFactory.accountsPanel(Row, AccountManager, PersistentDefaultAccountHolder, AccountsListModel, AccountsDetailsProvider, Disposable, Icon)` method removed
: Support for default accounts required a signature change.

### Markdown Plugin 2022.1

`org.intellij.markdown.parser.constraints.MarkdownConstraints.Companion` class removed
: Some methods from a companion object were moved to `CommonMarkdownConstraints` and to extension functions on `MarkdownConstraints`.

`org.intellij.markdown.parser.constraints.MarkdownConstraints.Companion` field removed
: Some methods from a companion object were moved to `CommonMarkdownConstraints` and to extension functions on `MarkdownConstraints`.

`org.intellij.markdown.parser.constraints.MarkdownConstraints` class now interface
: Use `CommonMarkdownConstraints` for default method implementations instead.

`org.intellij.markdown.parser.markerblocks.providers.AtxHeaderProvider(boolean)` constructor parameter `boolean` removed
: `AtxHeaderProvider` now always requires at least one space between `#` and its content as specified by the CommonMark spec.

`org.intellij.markdown.html.HtmlGenerator.generateHtml()` method removed
: Use `org.intellij.markdown.html.HtmlGenerator.generateHtml(org.intellij.markdown.html.HtmlGenerator.TagRenderer)` instead.

`org.intellij.markdown.parser.markerblocks.MarkerBlockProvider.Companion.passSmallIndent(CharSequence)` method removed
: Use `org.intellij.markdown.parser.markerblocks.MarkerBlockProvider.Companion.passSmallIndent(CharSequence, Integer)` instead.

### Database Tools and SQL Plugin 2022.1

`com.intellij.database.datagrid.DataProducer.processRequest(DataRequest)` method parameter type changed from `DataRequest` to `GridDataRequest`
: `GridDataRequest` is a part of new API for async loading of table data. It's not possible to keep old method with default implementation because `DataProducer` will no longer have dependency on `DataRequest`. Plugins need to be recompiled to maintain bytecode compatibility.

`com.intellij.database.datagrid.DataRequest.RawQueryRequest.afterLastRowAdded(DataRequest.Context, int)` method parameter type changed from `DataRequest.Context` to `GridDataRequest.Context`
: The signature of the method was changed in the interface `com.intellij.database.datagrid.DataConsumer` that is now a part of new API for async loading of table data. Change the parameter type of the overridden method and recompile plugin to maintain bytecode compatibility.

`com.intellij.database.datagrid.DataConsumer.addRows(DataRequest.Context, List<DataConsumer.Row>)` method parameter type changed from `DataRequest.Context` to `GridDataRequest.Context`
: The signature of the method was changed in the interface `com.intellij.database.datagrid.DataConsumer` that is now a part of new API for async loading of table data. Change the parameter type of the overridden method and recompile plugin to maintain bytecode compatibility.

`com.intellij.database.datagrid.DataConsumer.addRows(DataRequest.Context, List<DataConsumer.Row>)` method parameter type changed from `List<DataConsumer.Row>` to `List<? extends GridRow>`
: The signature of the method was changed in the interface `com.intellij.database.datagrid.DataConsumer` that is now a part of new API for async loading of table data. Change the parameter type of the overridden method and recompile plugin to maintain bytecode compatibility.

`com.intellij.database.extractors.ObjectFormatter.getPlainValue(Object, DataConsumer.Column, Dbms)` method removed
: Method was removed because we refactor table editor API. It will not depend on Dbms anymore. Please use `ObjectFormatter.objectToString` instead.

`com.intellij.database.DatabaseDataKeys.DATA_SOURCE_KEY` field removed
: `DatabaseDataKeys` no longer extends `DatabaseDataKeysCore` because `DatabaseDataKeys` was moved to a separate module for table editor. `DATA_SOURCE_KEY` now has to be accessed directly via `DatabaseDataKeysCore`.

`com.intellij.database.extractors.ObjectFormatter` class now interface
: Method was removed because we refactor table editor API. New API will allow to use table editor in other products and fully customize it.

