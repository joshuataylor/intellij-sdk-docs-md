# Notable Changes in IntelliJ Platform and Plugins API 2026.*

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

## 2026.3

### IntelliJ Platform 2026.3

Plugin management with user consent
: The experimental [PluginPermissionService](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-impl/src/com/intellij/ide/plugins/PluginPermissionService.kt) lets a plugin ask the user to allow an operation on other plugins.
The plugin passes a request and an action to `withPermission()`.
The IDE shows the request message in a permission dialog, and runs the action only if the user allows the request.
If the user denies the request, `withPermission()` returns a failure with `PluginPermissionNotGrantedException`.
[PluginManagementPermissions.kt](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/openapi/updateSettings/PluginManagementPermissions.kt) defines these requests:
: * `EnablePluginRequest`, `DisablePluginRequest`, and `InstallPluginRequest` give the action a `PluginManagementAction`, and its `apply()` starts the operation.

* `AccessPluginClassLoadersRequest` gives the action a `ReadPluginDescriptorsAction`, which returns the descriptors of all installed plugins and their class loaders.

Each permission works for one call only, so the plugin must send a new request to repeat the operation.
Call `withPermission()` directly from the plugin code, because the service identifies the requesting plugin by the calling class.
Java code can use `PluginPermissionJavaShim.withPermission()`, which returns a `CompletableFuture`.

```KOTLIN
val result = PluginPermissionService.getInstance().withPermission(
  DisablePluginRequest(pluginId, MyBundle.message("disable.conflicting.plugin.reason"))
) { action ->
  action.apply()
}
```

This API replaces the `PluginManagerCore` methods that enable and disable plugins, which are now internal.
See [Plugin Management 2026.2](api-changes-list-2026.html#plugin-management-20262).

## 2026.2

### IntelliJ Platform 2026.2

Asynchronous `VirtualFile` content saving
: [VirtualFile](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/vfs/VirtualFile.java) content updates via `getOutputStream()` or `setBinaryContent()` can now be postponed – the actual file on disk may be modified with some delay.
See [When are VirtualFile changes persisted on disk and loaded from disk to VFS?](virtual-file.html#when-are-virtualfile-changes-persisted-on-disk-and-loaded-from-disk-to-vfs) for more details.

## 2026.1

### IntelliJ Platform 2026.1

Background-capable VFS listeners
: New APIs allow VFS listener callbacks to run off the Event Dispatch Thread (EDT), reducing UI freezes during heavy file operations.
Bulk listeners can implement the [BulkFileListenerBackgroundable](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/vfs/newvfs/BulkFileListenerBackgroundable.kt) marker interface and subscribe to the [VirtualFileManager.VFS_CHANGES_BG](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/vfs/VirtualFileManager.java) message topic (instead of `VFS_CHANGES`).
Async listeners can be registered via [addAsyncFileListenerBackgroundable()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/vfs/VirtualFileManager.java) or the `com.intellij.vfs.asyncListenerBackgroundable` extension point.
Migrate thread-safe listeners without UI dependencies from `VFS_CHANGES`/[addAsyncFileListener()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/vfs/VirtualFileManager.java).

New LSP API features
: Language Server Protocol support gains Range Formatting (`textDocument/rangeFormatting`), Code Lens (`textDocument/codeLens`), and Optimize Imports (`textDocument/codeAction` with `source.organizeImports`). ``Also includes a major rewrite of LSP highlighting for improved performance. See [Language Server Protocol (LSP)](language-server-protocol.html).

`OSProcessHandler.waitFor()` on EDT or under read lock logs error
: Waiting for an external process via [OSProcessHandler.waitFor()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-util-io/src/com/intellij/execution/process/OSProcessHandler.java) on the Event Dispatch Thread or while holding a read lock is now prohibited for all users and logs a `LOG.error`.
This check has been previously enabled in internal mode since 2019.
Move process waiting off the EDT and outside of read actions, e.g., into a background thread or a coroutine.

Non-cancellable read action APIs deprecated
: [ReadAction.compute()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/ReadAction.java), [ReadAction.run()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/ReadAction.java), and [runReadAction()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/actions.kt) are deprecated because long-running non-cancellable read actions on background threads can block write actions and cause UI freezes.
Migrate to cancellable coroutine-based APIs: [readAction {}](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/coroutines.kt) or [smartReadAction {}](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/coroutines.kt) in Kotlin, or [ReadAction.nonBlocking().submit()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/ReadAction.java) / [.executeSynchronously()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/ReadAction.java) in Java.
As a last resort, [ReadAction.computeBlocking()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/ReadAction.java) and [runReadActionBlocking()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/application/coroutines.kt) are available but should only be used under modal progress.

`AnActionEvent.coroutineScope` added
: [AnActionEvent](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/AnActionEvent.java) now exposes a `coroutineScope` property providing convenient access to a `CoroutineScope` within `actionPerformed`, while maintaining synchronous EDT execution contracts.

### Terminal Plugin 2026.1

`TerminalUtil.hasRunningCommands()` must not be called on EDT
: [TerminalUtil.hasRunningCommands()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/terminal/src/org/jetbrains/plugins/terminal/TerminalUtil.java) now asserts it is not called on the Event Dispatch Thread via `ThreadingAssertions.assertBackgroundThread`, and logs a `LOG.error` if violated.
Calling this method on the EDT can cause UI freezes because it queries external process state.
Move calls to a background thread or a coroutine.

