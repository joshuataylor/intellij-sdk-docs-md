# Notable Changes in IntelliJ Platform and Plugins API 2025.*

Early Access Program (EAP) releases of upcoming versions are available [here](https://eap.jetbrains.com).

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

Threading Model changes
: Several write actions now run on background threads instead of EDT:
: * VFS refresh

* document commit (PSI reparsing)

* document saving on frame deactivation
: API changes and additions:
: * [Dispatchers.UI](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/coroutines.kt) — new coroutine dispatcher for the UI thread that does not acquire write-intent lock; use it for pure UI operations that do not need the read/write lock protection (as opposed to `Dispatchers.EDT`, which acquires write-intent lock for legacy model access).

* [backgroundWriteAction()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/coroutines.kt) and [readAndBackgroundWriteAction()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/coroutines.kt) — stabilized suspending functions for executing write actions on a background thread.

* Editor model data (document, caret, selection, folding) no longer requires a read lock when accessed on EDT.

* Tests relying on spinning the AWT event queue to wait for write actions may hang; use [PlatformTestUtil.dispatchAllInvocationEventsInIdeEventQueue()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/testFramework/src/com/intellij/testFramework/PlatformTestUtil.java) which is adapted to await background write actions.

`IdeProductMode`: Detecting Frontend/Backend/Monolith Mode
: [IdeProductMode](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-api/src/com/intellij/platform/ide/productMode/IdeProductMode.kt) (experimental) allows plugins to determine the current application mode at runtime:
: * `IdeProductMode.isBackend` — the IDE runs as a remote development backend host

* `IdeProductMode.isFrontend` — the IDE runs as a frontend (JetBrains Client) connected to a remote host

* `IdeProductMode.isMonolith` — the IDE runs as a standard local (monolith) instance
: Use this API to implement mode-specific behavior, e.g., to skip UI-related functionality when running as a backend.

LSP API updates
: New LSP capabilities are supported, all enabled by default and controllable via `LspServerDescriptor.lspCustomization`:
: * Server Initiated Progress (`$/progress`)

* Highlight Usages In File (`textDocument/documentHighlight`)

* Go To Symbol (`workspace/symbol`)

* File Structure, Breadcrumbs, and Sticky Lines (`textDocument/documentSymbol`)

* Parameter Info (`textDocument/signatureHelp`)
: See [Supported Features](language-server-protocol.html#supported-features) for the full list.

The Islands UI theme is now default
: The Islands theme is now the default UI theme.
Custom themes must be updated to support it.
See [Supporting Islands Theme](supporting-islands-theme.html) for migration steps including setting the parent theme, adapting background colors, border colors, and selected tab colors.

Search Everywhere: New API compatible with Remote Development
: The Search Everywhere architecture has been redesigned to support remote development by separating data/logic from UI presentation, enabling results to be serialized and transmitted across process boundaries.
New API components:
: * [SeItemsProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/searchEverywhere/shared/src/SeItemsProvider.kt) replaces `SearchEverywhereContributor` as the main interface for providing search results. It can run on both backend and frontend and returns items with serializable presentation data.

* [SeItemsProviderFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/searchEverywhere/shared/src/SeItemsProviderFactory.kt) is the new extension point for registering result sources.

* [SeTab](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/searchEverywhere/frontend/src/SeTab.kt) and [SeTabFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/searchEverywhere/frontend/src/SeTabFactory.kt) represent frontend-only tab abstractions for the Search Everywhere dialog.

* [SeLegacyItemPresentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/searchEverywhere/shared/src/SeLegacyItemPresentationProvider.kt) provides a temporary adapter for migrating existing `SearchEverywhereContributor` implementations.
: Existing plugins continue working in local (monolith) environments via adapters. The new API is enabled by default in remote development. Migration is recommended now; the old API will be deprecated in 2026.2.
See also [blog post](https://blog.jetbrains.com/platform/2025/12/major-architectural-update-introducing-the-new-search-everywhere-api-built-for-remote-development/) for details.

## 2025.2

### IntelliJ Platform 2025.2

LSP and Template Languages APIs are available to free tier users
: [Language Server Protocol (LSP)](language-server-protocol.html) and Template Languages APIs no longer require a paid subscription in IntelliJ IDEA.
While the LSP implementation is not part of the Community Edition, it will still remain enabled in IntelliJ IDEA even without an active paid subscription. Although closed-source, the LSP implementation will remain fully available for third-party plugins free of charge.
See [LSP Plugin Setup](language-server-protocol.html#lsp-plugin-setup) for the updated setup.

Threading Model changes
: Several APIs are stabilized and one is deprecated:
: * [runBlockingCancellable()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt), [currentThreadCoroutineScope()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt), and [coroutineToIndicator()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt) are promoted to stable.

* [blockingContext()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt) is now a no-op and deprecated ([IJPL-445](https://youtrack.jetbrains.com/issue/IJPL-445)). The platform manages thread contexts automatically; remove all usages.

* Threads blocked on read/write lock acquisition now react to cancellation and throw `CancellationException` instead of proceeding.

## 2025.1

### IntelliJ Platform 2025.1

Threading Model changes
: `SwingUtilities.invokeLater()` and `SwingUtilities.invokeAndWait()` no longer automatically wrap their callbacks in the Write-Intent lock ([IJPL-149317](https://youtrack.jetbrains.com/issue/IJPL-149317)). Code accessing the PSI/VFS model inside these callbacks must now use an explicit read or write action. Pure UI-only operations require no changes.
Similarly, coroutines launched on `Dispatchers.Main` no longer acquire the Write-Intent lock ([IJPL-178581](https://youtrack.jetbrains.com/issue/IJPL-178581)). Use [Dispatchers.EDT](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/coroutines.kt) to preserve the previous behavior, or move model access to `Dispatchers.Default` with an explicit `readAction`/`writeAction`.
[edtWriteAction()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/coroutines.kt) is introduced as a stable, explicitly named alternative to `writeAction()` for write actions that must run on EDT.

[ContainerUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/util/src/com/intellij/util/containers/ContainerUtil.java) using unmodifiable collections
: Methods marked with [@Unmodifiable](https://github.com/JetBrains/java-annotations/tree/24.0.0/java8/src/main/java/org/jetbrains/annotations/Unmodifiable.java) now really return unmodifiable collections (only in [internal](enabling-internal.html)/test mode for now).

