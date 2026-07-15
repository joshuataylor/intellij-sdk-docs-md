# Incompatible Changes in IntelliJ Platform and Plugins API 2026.*

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

## 2026.1

### IntelliJ Platform 2026.1

AWT input event handlers no longer run under write-intent lock
: Custom input handlers (`KeyListener`, `MouseAdapter`, etc.) no longer execute under the [write-intent lock](threading-model.html#read-write-lock).
If PSI or other write-intent-protected data needs to be accessed in these handlers, explicitly acquire a read action using [ReadAction.nonBlocking().submit()](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/openapi/application/ReadAction.java) or coroutine-based equivalents such as [readAction {}](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/openapi/application/coroutines.kt).

#### PolySymbols

`com.intellij.polySymbols.PolySymbol.getOrigin()` method removed
: The property was confusing and in many cases was not used. Its functionality is replaced by:
: * `framework` property - provide `com.intellij.polySymbols.html.HtmlFrameworkSymbolsSupport.HtmlFrameworkIdProperty` value through `PolySymbol.Property` mechanism
: * `defaultIcon` property - implement `icon` property and return `true` for `PolySymbol.DocHideIconProperty` through `PolySymbol.Property` mechanism
: * `typeSupport` property - provide `com.intellij.polySymbols.utils.PolySymbolTypeSupport.TypeSupportProperty` value through `PolySymbol.Property` mechanism

`com.intellij.polySymbols.PolySymbolQualifiedKind` class renamed to `com.intellij.polySymbols.PolySymbolKind`
: additionally `name` property was renamed to `kindName` and `qualifiedKind` properties and parameters across the package
were renamed to `kind`

The following classes no longer implement [PsiModificationTracker](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/psi/util/PsiModificationTracker.java) (this requirement was confusing):

* [PolySymbolScope](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolScope.kt)

* [PolySymbolQueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolQueryExecutor.kt)

* [PolySymbolQueryResultsCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolQueryResultsCustomizer.kt)

Implementing `PsiModificationTracker` was replaced by `modificationTracker` property for the following classes:

* [PolyContextRulesProvider](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/polySymbols/src/com/intellij/polySymbols/context/PolyContextRulesProvider.kt)

* [PolySymbolNamesProvider](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolNamesProvider.kt)

* [PolySymbolNameConversionRulesProvider](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolNameConversionRulesProvider.kt)

### Java Plugin 2026.1

The Java plugin has been split into several modules with their own classloaders.
This shouldn't affect plugins that use standard `<depends>com.intellij.java</depends>` dependency.
If a plugin depends on specific Java plugin modules directly, the dependencies should be updated to reference the new module names.

## 2026.2

### Kotlin Plugin 2026.2

#### K1 Plugin Removal

K1 Plugin was completely removed from the distribution.
Any access to its classes or to the classes of the K1 Compiler Frontend would lead to runtime errors.
The migration should be done according to the [migration guide](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.asJava.classes.KtLightClassForSourceDeclaration` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.asJava.classes.KtLightClassImpl` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.asJava.classes.KtUltraLightClass` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.asJava.elements.KtLightMemberImpl` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.asJava.elements.KtLightPsiLiteral` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.actions.generate.KotlinGenerateMemberActionBase` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.base.projectStructure.moduleInfo.ModuleSourceInfo` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.base.utils.fqname.FqNameUtilKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.project.MultiplatformUtilKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.util.JavaResolutionUtils` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.codeInsight.DescriptorToSourceUtilsIde` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.codeInsight.KtFunctionPsiElementCellRenderer` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.codeInsight.ReferenceVariantsHelper` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.codeInsight.postfix.KtPostfixTemplateProviderKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.core.ShortenReferences` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.core.UtilsKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.core.overrideImplement.GenerateMembersHandler` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.core.overrideImplement.GenerateMembersHandler.Companion` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.core.overrideImplement.ImplementMembersHandler` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.core.overrideImplement.OverrideMemberChooserObject` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.gradleJava.compilerPlugin.AbstractCompilerPluginGradleImportHandler` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.imports.ImportsUtils` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.inspections.IntentionBasedInspectionKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.quickfix.KotlinIntentionActionsFactory` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.quickfix.KotlinQuickFixAction` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.quickfix.KotlinSingleIntentionActionFactory` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.quickfix.QuickFixContributor` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.quickfix.QuickFixes` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.quickfix.createFromUsage.CreateFromUsageFixBase` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.refactoring.KotlinRefactoringUtilKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.refactoring.changeSignature.ChangeSignatureUtilsKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.refactoring.changeSignature.KotlinChangeInfo` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.refactoring.changeSignature.KotlinChangeSignatureData` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.refactoring.changeSignature.KotlinMethodDescriptor` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.refactoring.memberInfo.MemberInfoUtilsKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.refactoring.safeDelete.KotlinSafeDeleteProcessor` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.search.usagesSearch.SearchHelpersKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.search.usagesSearch.UtilsKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.util.CallTypeAndReceiver` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.util.IdeDescriptorRenderers` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.util.ImportInsertHelper` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.util.ImportInsertHelper.Companion` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.util.ModifierListModifactorKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.util.TypeUtils` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.j2k.UtilsKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.resolve.lazy.BodyResolveMode` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.util.DescriptorUtilsKt` class removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.asJava.KotlinAsJavaSupport.getLightClass(KtClassOrObject)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.analyze$default(KtElement, BodyResolveMode, int, Object)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.analyze(KtElement, BodyResolveMode)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.getResolutionFacade(KtElement)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.resolveImportReference(KtFile, FqName)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.resolveToCall$default(KtElement, BodyResolveMode, int, Object)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.resolveToDescriptorIfAny$default(KtClassOrObject, BodyResolveMode, int, Object)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.resolveToDescriptorIfAny$default(KtDeclaration, BodyResolveMode, int, Object)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.resolveToDescriptorIfAny$default(KtNamedFunction, BodyResolveMode, int, Object)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.resolveToDescriptorIfAny$default(KtProperty, BodyResolveMode, int, Object)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.caches.resolve.ResolutionUtils.resolveToDescriptorIfAny(KtDeclaration, BodyResolveMode)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.idea.util.CommentSaver.restore$default(CommentSaver, PsiElement, boolean, int, Object)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.js.descriptorUtils.DescriptorUtilsKt.getJetTypeFqName(KotlinType, boolean)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

`org.jetbrains.kotlin.js.descriptorUtils.DescriptorUtilsKt.getNameIfStandardType(KotlinType)` method removed
: [Migrate to K2 (Analysis API)](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

### CLion 2026.2

The C/C++ language engine based on `com.intellij.cidr.lang` (CLion Classic) is no longer bundled with CLion.
CLion Nova, based on the ReSharper C++ engine, is now the default and the only bundled C/C++ engine.
The classic APIs remain available via the [C/C++ Language Support via Classic Engine](https://plugins.jetbrains.com/plugin/32355-c-c--language-support-via-classic-engine) plugin (ID `com.intellij.cidr.lang`).
Plugins depending on these APIs must declare a dependency on the Marketplace plugin using [plugin(&quot;com.intellij.cidr.lang&quot;, &quot;&lt;version&gt;&quot;)](tools-intellij-platform-gradle-plugin-dependencies-extension.html#non-bundled-plugin).
See [C/C++ Language Engine: Nova and Classic](clion.html#language-engine) for setup details and CLion Nova API replacements.

`com.jetbrains.cidr.lang.OCFileType` class removed
: The Classic C/C++ engine is no longer bundled. Depend on the [C/C++ Language Support via Classic Engine](https://plugins.jetbrains.com/plugin/32355-c-c--language-support-via-classic-engine) plugin to keep using it, or migrate to `com.jetbrains.rider.cpp.fileType.CppFileType` (CLion Nova).

`com.jetbrains.cidr.lang.OCLanguage` class removed
: The Classic C/C++ engine is no longer bundled. Depend on the [C/C++ Language Support via Classic Engine](https://plugins.jetbrains.com/plugin/32355-c-c--language-support-via-classic-engine) plugin to keep using it, or migrate to `com.jetbrains.rider.cpp.fileType.CppLanguage` (CLion Nova).

`com.jetbrains.cidr.lang.psi.OCFile` class removed
: Depend on the [C/C++ Language Support via Classic Engine](https://plugins.jetbrains.com/plugin/32355-c-c--language-support-via-classic-engine) plugin to keep using it, or use `com.jetbrains.rider.cpp.fileType.psi.CppFile` (CLion Nova) for file-level access only.

CLion Nova has no frontend PSI, so the remaining `com.jetbrains.cidr.lang` classes — PSI, symbols, types, and resolve/references — have no replacement; depend on the Classic Engine plugin to keep using them.

## 2026.3

### IntelliJ Platform 2026.3

#### Kotlin UI DSL 1.0 Removal

Kotlin UI DSL Version 1 (the `com.intellij.ui.layout` DSL entry points) has been completely removed.
Any access to the removed classes will lead to compilation or runtime errors.
The migration should be done according to the [Kotlin UI DSL Version 2 migration guide](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.BaseBuilder` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.CCFlags` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.Cell` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.CellBuilder` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.CellMarker` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LCFlags` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LayoutBuilder` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LayoutBuilderImpl` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LayoutImplKt` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LayoutKt` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.Row` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.RowBuilder` class removed
: [Migrate to Kotlin UI DSL Version 2](https://plugins.jetbrains.com/docs/intellij/kotlin-ui-dsl.html#migration-to-version-2).

