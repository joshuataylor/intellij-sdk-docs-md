# Incompatible Changes in IntelliJ Platform and Plugins API 2026.*

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

## 2026.3

### IntelliJ Platform 2026.3

Several modules were extracted from the core plugin to separate modules with their own classloaders.
This shouldn't affect binary compatibility, but an explicit dependency should be added in `build.gradle.kts` using `bundledModule(<moduleName>)` if a plugin uses API from these modules:

* `intellij.platform.debugger`

* `intellij.platform.externalSystem`

* `intellij.platform.remoteServers`

* `intellij.platform.webide.impl`

Several modules were moved from the core plugin to separate bundled plugins.
This shouldn't affect binary compatibility, but an explicit dependency should be added in `build.gradle.kts` using `bundledPlugin(<pluginId>)` if a plugin uses API from these modules:

* `com.intellij.platform.vcs` (Version Control): `intellij.platform.vcs`, `intellij.platform.vcs.impl`, `intellij.platform.vcs.log`, `intellij.platform.vcs.log.impl`, `intellij.platform.vcs.log.graph`, `intellij.platform.vcs.dvcs`, `intellij.platform.vcs.dvcs.impl`. A dependency on the `com.intellij.modules.vcs` plugin alias is sufficient, see [Modules Available in All Products](plugin-compatibility.html#modules-available-in-all-products).

* `com.intellij.xml` (XML and HTML): `intellij.xml.parser`, `intellij.xml.syntax`, `intellij.xml.psi`, `intellij.xml.psi.impl`, `intellij.xml.dom`, `intellij.xml.dom.impl`, `intellij.xml.analysis`, `intellij.xml.analysis.impl`, `intellij.xml.impl`, `intellij.xml.ui.common`, `intellij.xml.structureView`, `intellij.xml.structureView.impl`, `intellij.xml.emmet`, `intellij.xml.emmet.frontend`, `intellij.relaxng`. A dependency on the `com.intellij.modules.xml` plugin alias is sufficient, see [Modules Available in All Products](plugin-compatibility.html#modules-available-in-all-products).

* `com.intellij.platform.tasks` (Tasks and Contexts): `intellij.platform.tasks`, `intellij.platform.tasks.impl`. Not to be confused with the `com.intellij.tasks` (Issue Trackers) plugin.

* `com.intellij.problemsView` (Problems View): `intellij.platform.problemsView.shared`, which was renamed to `intellij.platform.problemView.shared`.

`com.intellij.openapi.projectRoots.Sdk` interface now extends `com.intellij.openapi.util.UserDataHolderEx` and inherits its abstract method `putUserDataIfAbsent(@NotNull Key<T> key, @NotNull T value)`
: Do not implement `Sdk`: it is a non-extendable interface.

`com.intellij.openapi.projectRoots.Sdk` interface now extends `com.intellij.openapi.util.UserDataHolderEx` and inherits its abstract method `replace(@NotNull Key<T> key, @Nullable T oldValue, @Nullable T newValue)`
: Do not implement `Sdk`: it is a non-extendable interface.

`com.intellij.openapi.actionSystem.LangDataKeys.RUN_PROFILE` field type changed from `DataKey<RunProfile>` to `DataKey<?>`
: Use `com.intellij.openapi.actionSystem.ExecutionDataKeys.RUN_PROFILE` or add an explicit cast.

`com.intellij.openapi.actionSystem.LangDataKeys.CONSOLE_VIEW` field type changed from `DataKey<ConsoleView>` to `DataKey<?>`
: Use `com.intellij.openapi.actionSystem.ExecutionDataKeys.CONSOLE_VIEW` or add an explicit cast.

`com.intellij.openapi.actionSystem.LangDataKeys.EXECUTION_ENVIRONMENT` field type changed from `DataKey<ExecutionEnvironment>` to `DataKey<?>`
: Use `com.intellij.openapi.actionSystem.ExecutionDataKeys.EXECUTION_ENVIRONMENT` or add an explicit cast.

`com.intellij.openapi.actionSystem.LangDataKeys.RUN_CONTENT_DESCRIPTOR` field type changed from `DataKey<RunContentDescriptor>` to `DataKey<?>`
: Use `com.intellij.openapi.actionSystem.ExecutionDataKeys.RUN_CONTENT_DESCRIPTOR` or add an explicit cast.

`com.intellij.ide.ApplicationLoadListener` class removed
: The interface and its `com.intellij.ApplicationLoadListener` extension point were internal API and are not available to plugins anymore, even if a plugin used them before.
Plugins may not run code at early application startup.
Use [ProjectActivity](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/startup/StartupActivity.kt) instead, see [Project Open](plugin-components.html#project-open).

#### JNA Library 2026.3

The [JNA](https://github.com/java-native-access/jna) library is no longer loaded by the core classloader.
It stays bundled as the content module `intellij.libraries.jna`, but a plugin does not see it implicitly anymore.
A plugin that uses `com.sun.jna.*` classes or `com.intellij.jna.JnaLoader` must declare an explicit dependency.
Without it, the plugin fails at runtime with `NoClassDefFoundError`.

Add the module dependency to `plugin.xml`:

```XML
<dependencies>
  <module name="intellij.libraries.jna"/>
</dependencies>
```

and to `build.gradle.kts`: `bundledModule("intellij.libraries.jna")`.
A plugin that ships its own JNA jars is not affected.

Consider this a chance to stop using JNA.
Plugins for 2026.2 and later target Java 25, where the [Foreign Function and Memory API](https://docs.oracle.com/en/java/javase/25/core/foreign-function-and-memory-api.html) (`java.lang.foreign`) is final.
The IDE runs with `--enable-native-access=ALL-UNNAMED`, so plugin code can call native functions through FFM without a warning.
The platform itself migrated its native bindings from JNA to FFM in 2026.3.

`com.intellij.jna.JnaLoader` moved from `intellij.platform.util` to the `intellij.libraries.jna` module, so it also needs the dependency described above.
`JnaLoader.load(Logger)` is deprecated and scheduled for removal; call `JnaLoader.isLoaded()` instead.

#### OkHttp Library Unbundling

The [OkHttp](https://square.github.io/okhttp/) library is no longer bundled with the IDE.
The content module `intellij.libraries.okhttp` and its `okhttp3` classes are gone from every product.
A plugin that used the bundled library fails at runtime with `NoClassDefFoundError`.

Bundle `com.squareup.okhttp3:okhttp` in the plugin, or switch to `java.net.http.HttpClient`.
`com.intellij.util.net.PlatformHttpClient` returns a JDK client that follows the IDE proxy, certificate and user agent settings.
The platform itself migrated all its OkHttp usages to the JDK client in 2026.3.
The Okio library (`intellij.libraries.squareup.okio.jvm`) stays bundled.

`okhttp3` package removed
: Bundle `com.squareup.okhttp3:okhttp` in the plugin, or use `java.net.http.HttpClient` through `com.intellij.util.net.PlatformHttpClient`.

#### Kotlin UI DSL 1.0 Removal

Kotlin UI DSL Version 1 (the `com.intellij.ui.layout` DSL entry points) has been completely removed.
Any access to the removed classes will lead to compilation or runtime errors.
The migration should be done according to the [Kotlin UI DSL Version 2 migration guide](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.BaseBuilder` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.CCFlags` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.Cell` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.CellBuilder` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.CellMarker` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LCFlags` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LayoutBuilder` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LayoutBuilderImpl` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LayoutImplKt` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.LayoutKt` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.Row` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

`com.intellij.ui.layout.RowBuilder` class removed
: [Migrate to Kotlin UI DSL Version 2](kotlin-ui-dsl.html#migration-to-version-2).

### Java Plugin 2026.3

`com.intellij.openapi.module.StdModuleTypes` class removed
: Use `com.intellij.openapi.module.JavaModuleType.getModuleType()` instead. Avoid a check of the module type if possible. See `com.intellij.openapi.module.ModuleType` for details.

## 2026.2

### IntelliJ Platform 2026.2

Several modules were extracted from the core plugin to separate modules with their own classloaders.
This shouldn't affect binary compatibility, but an explicit dependency should be added in `build.gradle.kts` using `bundledModule(<moduleName>)` if a plugin uses API from these modules:

* `intellij.xml.emmet`

* `intellij.xml.structureView`

Several modules were moved from the core plugin to separate bundled plugins.
This shouldn't affect binary compatibility, but an explicit dependency should be added in `build.gradle.kts` using `bundledPlugin(<pluginId>)` if a plugin uses API from these modules:

* `com.intellij.bookmarks` (Bookmarks Manager): `intellij.platform.bookmarks`

* `com.intellij.platform.serviceView` (Services View): `intellij.platform.execution.dashboard`

* `com.intellij.modules.jcef` (Web Browser (JCEF)): `intellij.platform.ui.jcef`

* `com.intellij.navbar` (Navbar): `intellij.platform.navbar`

* `com.intellij.platform.ssh` (SSH): `intellij.platform.ssh.core`, `intellij.platform.ssh`, `intellij.platform.ssh.ui`, `intellij.platform.ssh.attach`

* `com.intellij.structuralSearch` (Structural Search): `intellij.platform.structuralSearch`

* `com.intellij.structureView` (Structure View): `intellij.platform.structureView`

* `com.intellij.platform.testRunner` (Test Runner): `intellij.platform.testRunner`, `intellij.platform.smRunner`

* `com.intellij.todo` (TODO Comments): `intellij.platform.todo`

In 2026.2, these plugins were shipped with IDs following the `intellij.<name>.plugin` scheme (for example, `intellij.bookmarks.plugin`).
Starting from 2026.3, the plugins use the IDs listed above, and the old IDs are kept as plugin aliases for backward compatibility.

#### JCEF 2026.2

A plugin that uses the [embedded browser (JCEF)](embedded-browser-jcef.html) API must now declare an explicit dependency on the bundled Web Browser (JCEF) plugin.
See [Plugin Dependency](embedded-browser-jcef.html#plugin-dependency) for the required `plugin.xml` and `build.gradle.kts` changes and the compatibility notes for older IDE versions.

#### Error Reporting 2026.2

[MessagePool](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-impl/src/com/intellij/diagnostic/MessagePool.kt) and [MessagePoolListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-impl/src/com/intellij/diagnostic/MessagePoolListener.java) are now internal API and are not available to plugins.
Plugins must not observe all IDE exceptions and diagnostics.

To observe plugin's own exceptions and freezes, use [error report sink](error-reporting.html#automatic-reporting-with-errorreportsink).

#### Plugin Management 2026.2

`PluginManagerCore.enablePlugin()`, `PluginManagerCore.disablePlugin()`, and `PluginManagerCore.getPlugins()` are now internal API and are not available to plugins.
Plugins must not manage other plugins.

A plugin that only needs information about other plugins, such as IDs, versions, vendors, license, modules, or dependencies, should use [PluginDetailsService](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-impl/src/com/intellij/ide/plugins/PluginDetails.kt).

#### PolySymbols 2026.2

`com.intellij.polySymbols.search.PsiSourcedPolySymbol` class renamed to `com.intellij.polySymbols.search.PsiLinkedPolySymbol`
: Use [PsiLinkedPolySymbol](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/src/com/intellij/polySymbols/search/PsiLinkedPolySymbol.kt) instead.
Additionally, the `source` property was renamed to `linkedElement`.

`com.intellij.polySymbols.utils.PsiSourcedPolySymbolDelegate` class renamed to `com.intellij.polySymbols.utils.PsiLinkedPolySymbolDelegate`
: Use [PsiLinkedPolySymbolDelegate](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/src/com/intellij/polySymbols/utils/PsiLinkedPolySymbolDelegate.kt) instead.

`com.intellij.polySymbols.refactoring.PsiSourcedPolySymbolRefactoringHelper` class renamed to `com.intellij.polySymbols.refactoring.PsiLinkedPolySymbolRefactoringHelper`
: Use [PsiLinkedPolySymbolRefactoringHelper](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/backend/src/com/intellij/polySymbols/refactoring/PsiLinkedPolySymbolRefactoringHelper.kt) instead.

`com.intellij.polySymbols.refactoring.PsiSourcedPolySymbolRenameHandler` class renamed to `com.intellij.polySymbols.refactoring.PsiLinkedPolySymbolRenameHandler`
: Use [PsiLinkedPolySymbolRenameHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/backend/src/com/intellij/polySymbols/refactoring/PsiLinkedPolySymbolRenameHandler.kt) instead.

`com.intellij.polySymbols.search.PsiSourcedPolySymbolProvider` class renamed to `com.intellij.polySymbols.search.PsiLinkedPolySymbolProvider`
: Use [PsiLinkedPolySymbolProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/backend/src/com/intellij/polySymbols/search/PsiLinkedPolySymbolProvider.kt) instead.

`com.intellij.polySymbols.search.PsiSourcedPolySymbolReference` class renamed to `com.intellij.polySymbols.search.PsiLinkedPolySymbolReference`
: Use [PsiLinkedPolySymbolReference](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/backend/src/com/intellij/polySymbols/search/PsiLinkedPolySymbolReference.kt) instead.

`com.intellij.polySymbols.search.PsiSourcedPolySymbolReferenceSearcher` class renamed to `com.intellij.polySymbols.search.PsiLinkedPolySymbolReferenceSearcher`
: Use [PsiLinkedPolySymbolReferenceSearcher](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/backend/src/com/intellij/polySymbols/search/PsiLinkedPolySymbolReferenceSearcher.kt) instead.

`com.intellij.polySymbols.search.PsiSourcedPolySymbolRequestResultProcessor` class renamed to `com.intellij.polySymbols.search.PsiLinkedPolySymbolRequestResultProcessor`
: Use [PsiLinkedPolySymbolRequestResultProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/backend/src/com/intellij/polySymbols/search/PsiLinkedPolySymbolRequestResultProcessor.kt) instead.

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

## 2026.1

### IntelliJ Platform 2026.1

AWT input event handlers no longer run under write-intent lock
: Custom input handlers (`KeyListener`, `MouseAdapter`, etc.) no longer execute under the [write-intent lock](threading-model.html#read-write-lock).
If PSI or other write-intent-protected data needs to be accessed in these handlers, explicitly acquire a read action using [ReadAction.nonBlocking().submit()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/application/ReadAction.java) or coroutine-based equivalents such as [readAction {}](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/application/coroutines.kt).

#### Language Server Protocol (LSP) 2026.1.4

In 2026.1.4, key LSP classes were [renamed](language-server-protocol.html#lsp-api-refactoring).
`LspServerManager` was renamed to `LspClientManager` and the service is registered only under the new interface.
Plugins retrieving `LspServerManager` via `project.service<LspServerManager>()` or similar methods will get null.
Use `LspClientManager.getInstance(project)` instead, or `LspServerManager.getInstance(project)` to support versions before 2026.4.1.

#### PolySymbols 2026.1

`com.intellij.polySymbols.PolySymbol.getOrigin()` method removed
: The property was confusing and in many cases was not used. Its functionality is replaced by:
: * `framework` property - provide `com.intellij.polySymbols.html.HtmlFrameworkSymbolsSupport.HtmlFrameworkIdProperty` value through `PolySymbol.Property` mechanism
: * `defaultIcon` property - implement `icon` property and return `true` for `PolySymbol.DocHideIconProperty` through `PolySymbol.Property` mechanism
: * `typeSupport` property - provide `com.intellij.polySymbols.utils.PolySymbolTypeSupport.TypeSupportProperty` value through `PolySymbol.Property` mechanism

`com.intellij.polySymbols.PolySymbolQualifiedKind` class renamed to `com.intellij.polySymbols.PolySymbolKind`
: additionally `name` property was renamed to `kindName` and `qualifiedKind` properties and parameters across the package
were renamed to `kind`

The following classes no longer implement [PsiModificationTracker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/util/PsiModificationTracker.java) (this requirement was confusing):

* [PolySymbolScope](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolScope.kt)

* [PolySymbolQueryExecutor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolQueryExecutor.kt)

* [PolySymbolQueryResultsCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolQueryResultsCustomizer.kt)

Implementing `PsiModificationTracker` was replaced by `modificationTracker` property for the following classes:

* [PolyContextRulesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/src/com/intellij/polySymbols/context/PolyContextRulesProvider.kt)

* [PolySymbolNamesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolNamesProvider.kt)

* [PolySymbolNameConversionRulesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/polySymbols/src/com/intellij/polySymbols/query/PolySymbolNameConversionRulesProvider.kt)

### Java Plugin 2026.1

The Java plugin has been split into several modules with their own classloaders.
This shouldn't affect plugins that use standard `<depends>com.intellij.java</depends>` dependency.
If a plugin depends on specific Java plugin modules directly, the dependencies should be updated to reference the new module names.

