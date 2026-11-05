# Incompatible Changes in IntelliJ Platform and Plugins API 2025.*

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

## 2025.3

### IntelliJ Platform 2025.3

Several modules were extracted from the core plugin to separate modules with their own classloaders.
This shouldn't affect binary compatibility, but an explicit dependency should be added in `build.gradle.kts` using `bundledModule(<moduleName>)` if a plugin uses API from these modules:

* `intellij.platform.collaborationTools.auth.base`

* `intellij.platform.collaborationTools.auth`

* `intellij.platform.scriptDebugger.backend`

* `intellij.platform.scriptDebugger.protocolReaderRuntime`

* `intellij.platform.scriptDebugger.ui`

* `intellij.platform.vcs.dvcs`

* `intellij.platform.vcs.log`

* `intellij.platform.vcs.log.graph`

The annotation `com.intellij.openapi.components.Storage` cannot be used at top-level
: Actually, it has never been correct.
The annotation can be used only in [@State.storages](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/components/State.java).
See [IJPL-207245](https://youtrack.jetbrains.com/issue/IJPL-207245) for details.

The `org.intellij.intelliLang` plugin requires Gradle dependency on bundled module `intellij.platform.langInjection`
: Change `bundledPlugin("org.intellij.intelliLang")` to `bundledModule("intellij.platform.langInjection")` in Gradle build script.

Write-Intent lock acquisition was removed during processing of input events in Swing and AWT
: Consider using explicit calls to `com.intellij.openapi.application.WriteIntentReadAction#run` in your input event listeners. See [IJPL-219144](https://youtrack.jetbrains.com/issue/IJPL-219144) for details.

com.intellij.openapi.application.Application.acquireReadActionLock() method removed
: Consider using higher-order functions like `com.intellij.openapi.application.Application#runReadAction`.

com.intellij.openapi.application.Application.acquireWriteActionLock() method removed
: Consider using higher-order functions like `com.intellij.openapi.application.Application#runWriteAction`.

com.intellij.openapi.application.WriteAction.start() method removed
: Consider using higher-order functions like `com.intellij.openapi.application.Application#runWriteAction`.

com.intellij.openapi.application.WriteIntentReadAction.compute(com.intellij.openapi.util.ThrowableComputable) method removed
: Use `com.intellij.openapi.application.WriteIntentReadAction.computeThrowable`. See [IJPL-221464](https://youtrack.jetbrains.com/issue/IJPL-221464) for details.

com.intellij.openapi.application.WriteIntentReadAction.run(com.intellij.openapi.util.ThrowableRunnable) method removed
: Use `com.intellij.openapi.application.WriteIntentReadAction.runThrowable`. See [IJPL-221464](https://youtrack.jetbrains.com/issue/IJPL-221464) for details.

### Cucumber for Java 2025.3

`org.jetbrains.plugins.cucumber.java.steps.JavaStep1xDefinition` class removed
: Use `org.jetbrains.plugins.cucumber.java.steps.JavaAnnotatedStepDefinition`.

`org.jetbrains.plugins.cucumber.java.steps.JavaStep2xDefinition` class removed
: Use `org.jetbrains.plugins.cucumber.java.steps.JavaAnnotatedStepDefinition`.

`org.jetbrains.plugins.cucumber.java.steps.factory.JavaStepDefinitionFactory` abstract class removed
: Create instances of `org.jetbrains.plugins.cucumber.java.steps.JavaAnnotatedStepDefinition` or `org.jetbrains.plugins.cucumber.java.steps.Java8StepDefinition` directly.

`org.jetbrains.plugins.cucumber.java.steps.factory.JavaStep1xDefinitionFactory` class removed
: Create instances of `org.jetbrains.plugins.cucumber.java.steps.JavaAnnotatedStepDefinition` or `org.jetbrains.plugins.cucumber.java.steps.Java8StepDefinition` directly.

`org.jetbrains.plugins.cucumber.java.steps.factory.JavaStep2xDefinitionFactory` class removed
: Create instances of `org.jetbrains.plugins.cucumber.java.steps.JavaAnnotatedStepDefinition` or `org.jetbrains.plugins.cucumber.java.steps.Java8StepDefinition` directly.

### JSON KMP-compatible parser 2025.3

`com.intellij.json.JsonParserDefinition.createParser(Project)` method removed
: Instantiate `com.intellij.json.JsonParser` directly.

After porting JSON parsers to syntax-api, `com.intellij.json.JsonParserDefinition.createParser(Project)` that creates `com.intellij.lang.PsiParser` became obsolete.
`com.intellij.json.JsonFileElementTypesKt#JSON_FILE` has been refactored to use syntax-api to parse JSON files, but you it is still possible to instantiate the legacy `com.intellij.json.JsonParser`.
The `createParser` method can't be removed from the `com.intellij.lang.ParserDefinition` interface, so to prevent accidental usage of this method, it throws `UnsupportedOperationException` now.
These changes shouldn't affect plugins that implement `ParserDefinition` on their own or that call `JsonParser` directly in any other way.
However, if the plugin uses `com.intellij.psi.tree.IFileElementType(JsonLanguage.INSTANCE)` for non-JSON files, it can cause an exception to be thrown.
To avoid this, instantiate `JsonParser` directly or consider using `com.intellij.platform.syntax.psi.SyntaxGrammarKitFileElementType(JsonLanguage.INSTANCE)` instead.

## 2025.2

### IntelliJ Platform 2025.2

Several modules were extracted from the core plugin to separate modules with their own classloaders.
This shouldn't affect binary compatibility, but an explicit dependency should be added in `build.gradle.kts` using `bundledModule(<moduleName>)` if a plugin uses API from these modules:

* `intellij.platform.tasks`

* `intellij.spellchecker`

* `intellij.relaxng`

`icons.JavaUltimateIcons` class moved to package `com.intellij.java.ultimate.icons`
: Update code usages and make sure your plugin [depends](plugin-dependencies.html) on the Java plugin.

`com.intellij.psi.xml.HtmlFileElementType.getHtmlStubVersion()` method removed
: Use `com.intellij.xml.HtmlLanguageStubVersionUtil.getHtmlStubVersion()` instead.

`com.intellij.openapi.actionSystem.ActionGroup.getChildren(AnActionEvent, ActionManager)` method removed
: Avoid expanding an action group manually

`com.intellij.openapi.actionSystem.DefaultActionGroup.getChildren(AnActionEvent, ActionManager)` method removed
: Avoid expanding an action group manually or use `DefaultActionGroup.getChildren(ActionManager)`

`com.intellij.diff.util.ThreeSide.map(Function)` method parameter type changed from `com.intellij.util.Function` to `kotlin.jvm.functions.Function1`
: Use `kotlin.jvm.functions.Function1` as a parameter.

The `com.intellij.webSymbols` package together with all the classes and extension points has been renamed to `com.intellij.polySymbols`.
: The classes were renamed using pattern `WebSymbol[s]?(.*)` -> `PolySymbol$1`. Some classes have also been moved
to more specific packages.
: From other notable changes:
: 1. `PolySymbol` interface no longer extends `PolySymbolScope`

2. `PolySymbol` interface no longer contains documentation-specific properties (`description`, `docUrl`, `sections` and `defaultValue`),
instead `getDocumentationTarget` method should be overridden and the new `PolySymbolDocumentationTarget.create` method
used to lazily build documentation for the symbol

3. `PolySymbol` no longer has `abstract`, `required` and `virtual` properties. They've been replaced by a more
generic `modifiers` property

4. `PolySymbol` no longer has `properties` property, which returned a map of properties. It's been replaced by
`get` method, which should return value for the requested property.

5. `PolySymbol` no longer has `attributeValue` property, instead `get` method should be overridden to return
the value for `com.intellij.polySymbols.html.PROP_HTML_ATTRIBUTE_VALUE` property

6. The `WebSymbolsQueryConfigurator$getScope` has been removed and replaced with a pattern-based `PolySymbolQueryScopeContributor` API

7. The `PolySymbolDelegate` and `PsiSourcePolySymbolDelegate` are interfaces now

8. All APIs have been refactored to use `PolySymbolQualifiedKind` instead of separate parameters `namespace` and `kind`

9. Builder patterns have been introduced in various classes, like `PolySymbolQueryExecutor`, `PolySymbolQueryParams`, or `PolySymbolDocumentation`
instead of now removed Kotlin methods with default parameters.
: Please note that the module is under active development and further major API changes are to be expected in the upcoming releases.

### Package Checker 2025.2

`com.intellij.packageChecker.api.PackageDeclaration(Package)` method parameter type changed from `org.jetbrains.security.package.Package` to `com.intellij.packageChecker.model.Package`
: Use `com.intellij.packageChecker.model.Package` as a parameter.

`com.intellij.packageChecker.api.PackageDeclaration(Package, PsiElement, TextRange)` method parameter type changed from `org.jetbrains.security.package.Package` to `com.intellij.packageChecker.model.Package`
: Use `com.intellij.packageChecker.model.Package` as a parameter.

`com.intellij.packageChecker.api.PackageDeclaration.getPkg()` method return type changed from `org.jetbrains.security.package.Package` to `com.intellij.packageChecker.model.Package`
: Update code usages.

`com.intellij.packageChecker.PackagesInterner.intern(Package)` method parameter type changed from `org.jetbrains.security.package.Package` to `com.intellij.packageChecker.model.Package`
: Use `com.intellij.packageChecker.model.Package` as a parameter.

`com.intellij.packageChecker.PackagesInterner.intern(Package)` method return type changed from `org.jetbrains.security.package.Package` to `com.intellij.packageChecker.model.Package`
: Update code usages.

### JavaScript and TypeScript Plugin 2025.2

`com.intellij.lang.javascript.JSStubElementTypes.DEFINITION_EXPRESSION` field type changed from `com.intellij.lang.javascript.psi.JSStubElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.javascript.JSStubElementTypes.XML_ATTRIBUTE` field type changed from `com.intellij.psi.stubs.IStubElementType` to `com.intellij.psi.tree.IElementType`
: Recompile code usages.

`com.intellij.lang.javascript.JSStubElementTypes.XML_JS_SCRIPT` field type changed from `com.intellij.psi.tree.IElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.javascript.JSStubElementTypes.ES6_EMBEDDED_CONTENT` field type changed from `com.intellij.psi.tree.IElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.javascript.JSStubElementTypes.VARIABLE` field type changed from `com.intellij.lang.javascript.psi.JSStubElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.javascript.JSStubElementTypes.LITERAL_EXPRESSION` field type changed from `com.intellij.lang.javascript.psi.JSStubElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.javascript.JSStubElementTypes.EMBEDDED_EXPRESSION` field type changed from `com.intellij.psi.tree.IElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.typescript.TypeScriptStubElementTypes.TYPESCRIPT_VARIABLE` field type changed from `com.intellij.lang.javascript.psi.JSStubElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.javascript.JSStubElementTypes.ARRAY_LITERAL_EXPRESSION` field type changed from `com.intellij.lang.javascript.psi.JSStubElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.javascript.JSStubElementTypes.CALL_EXPRESSION` field type changed from `com.intellij.lang.javascript.psi.JSStubElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.ecmascript6.ES6StubElementTypes.FIELD_STATEMENT` field type changed from `com.intellij.lang.javascript.psi.JSStubElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`com.intellij.lang.javascript.JSStubElementTypes.EMBEDDED_CONTENT` field type changed from `com.intellij.psi.tree.IElementType` to `com.intellij.lang.javascript.psi.JSElementType`
: Recompile code usages.

`org.jetbrains.vuejs.lang.expr.VueJSLanguage.Companion` class removed
: Use `org.jetbrains.vuejs.lang.expr.VueJSLanguage` instead.

### Kubernetes Plugin 2025.2

`com.intellij.kubernetes.api.KubernetesApiProvider.getInstance(Project)` method return type changed from `com.intellij.kubernetes.api.KubernetesApiProvider` to `com.intellij.kubernetes.api.KubernetesApiProviderInterface`
: Update code usages.

`com.intellij.kubernetes.api.KubernetesApiProvider.State`class renamed to `com.intellij.kubernetes.api.KubernetesApiProviderInterface.KubeconfigState`
: Update code usages.

## 2025.1

### IntelliJ Platform 2025.1

Code scheduled with `SwingUtilities.invokeLater` and `SwingUtilities.invokeAndWait` does not hold the write-intent lock
: Consider using an explicit wrapping with [ReadAction.compute()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/application/ReadAction.java) or [WriteAction.run(ThrowableRunnable&lt;E&gt;)](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/application/WriteAction.java).
See [Threading Model](threading-model.html).

Coroutines running under `Dispatchers.Main` do not hold the write-intent lock
: To restore the old behavior, consider using `Dispatchers.EDT`.
See [Threading Model](threading-model.html).

`com.intellij.psi.xml.XmlTokenType` class now interface
: Use `XmlTokenType` constants directly.

Class `com.intellij.psi.xml.XmlElementType` no longer extends `com.intellij.psi.xml.XmlTokenType`
: Update code usages.

`filetype.xml.description` property removed from resource bundle `messages.XmlPsiBundle`
: Use property from resource bundle `messages.XmlParserBundle`

`xml.parsing.closing.tag.matches.nothing` property removed from resource bundle `messages.XmlPsiBundle`
: Use property from resource bundle `messages.XmlParserBundle`

`xml.parsing.unclosed.attribute.value` property removed from resource bundle `messages.XmlPsiBundle`
: Use property from resource bundle `messages.XmlParserBundle`

`xml.parsing.unescaped.ampersand.or.nonterminated.character.entity.reference` property removed from resource bundle `messages.XmlPsiBundle`
: Use property from resource bundle `messages.XmlParserBundle`

Kotlin UI DSL Version 1 must not be used from 2025.1
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

### Database Plugin 2025.1

`com.intellij.database.view.models` package removed
: Old table modification dialog was finally removed. Use `com.intellij.database.actions.ddl.ModifyObjectAction.showDialog()` for new dialog invocation.

`com.intellij.database.schemaEditor.model.DeObject` class removed
: Old table modification dialog was finally removed. Use `com.intellij.database.actions.ddl.ModifyObjectAction.showDialog()` for new dialog invocation.

`com.intellij.database.view.editors.DatabaseEditorContext` class removed
: Old table modification dialog was finally removed. Use `com.intellij.database.actions.ddl.ModifyObjectAction.showDialog()` for new dialog invocation.

`com.intellij.database.view.editors.DatabaseTableEditor` class removed
: Old table modification dialog was finally removed. Use `com.intellij.database.actions.ddl.ModifyObjectAction.showDialog()` for new dialog invocation.

`com.intellij.database.view.ui.DbRefactoringDialogHelper` class removed
: Old table modification dialog was finally removed. Use `com.intellij.database.actions.ddl.ModifyObjectAction.showDialog()` for new dialog invocation.

`com.intellij.database.view.ui.DbTableDialog` class removed
: Old table modification dialog was finally removed. Use `com.intellij.database.actions.ddl.ModifyObjectAction.showDialog()` for new dialog invocation.

### External System 2025.1

`com.intellij.openapi.externalSystem.service.internal.ExternalSystemProcessingManager` class now interface
: Recompile code usages.

### JavaScript and TypeScript Plugin 2025.1

`com.intellij.lang.javascript.service.JSAsyncLanguageServiceBase.JSLanguageServiceInfoReporter` class moved to package `com.intellij.lang.javascript.service`
: Update all usages

`com.intellij.lang.javascript.JSElementTypes.toModuleContentType(IElementType type)` method removed
: Use `com.intellij.lang.javascript.JSModuleContentType.toModuleContentType(IElementType type)` method instead

`com.intellij.lang.javascript.BaseJSTokenTypes` class removed
: Use `com.intellij.lang.javascript.JSTokenTypes` class instead

`com.intellij.lang.javascript.highlighting.TypeScriptHighlighter(DialectOptionHolder dialectOptionsHolder, boolean skipKeywordHighlights)` constructor removed
: Use constructor without `skipKeywordHighlights` parameter

`com.intellij.lang.javascript.dialects.ECMA6SyntaxHighlighterFactory.ECMA6SyntaxHighlighter(DialectOptionHolder dialectOptionsHolder, boolean skipKeywordHighlights)` constructor removed
: Use constructor without `skipKeywordHighlights` parameter

`com.intellij.lang.javascript.highlighting.JSHighlighter(DialectOptionHolder dialectOptionsHolder, boolean skipKeywordHighlights)` constructor removed
: Use constructor without `skipKeywordHighlights` parameter

### Kotlin Plugin 2025.1

`org.jetbrains.kotlin.KtFakeSourceElement` class renamed to `org.jetbrains.kotlin.KtFakePsiSourceElement`
: Update code usages.

`org.jetbrains.kotlin.ir.linkage.IrDeserializer.IrLinkerExtension` class removed
: This class was removed from the Kotlin compiler and is no longer available.

`org.jetbrains.kotlin.ir.builders.TranslationPluginContext` class removed
: This class was removed from the Kotlin compiler and is no longer available.

`org.jetbrains.kotlin.analysis.decompiler.stub.file.ClsClassFinder.isKotlinInternalCompiledFile$default(ClsClassFinder, VirtualFile, byte[], int, Object)` method removed
: Recompile code usages.

### Remote Development 2025.1

`com.jetbrains.rd.ide.model.AddToGroupRuleModel` class removed
: Remove all usages.

`com.jetbrains.rd.ide.model.ActionConstraintModel` class removed
: Remove all usages.

### Terminal Plugin 2025.1

`com.jediterm.terminal.model.TextBufferChangesListener.historyCleared()` abstract method added
: Must be implemented.

`com.intellij.terminal.ui.TerminalWidget.connectToSession(TerminalSession session)` abstract method added
: Must be implemented.

`com.intellij.terminal.ui.TerminalWidget.getSession()` abstract method added
: Must be implemented.

`com.intellij.terminal.ui.TerminalWidget.getTerminalSizeInitializedFuture()` abstract method added
: Must be implemented.

