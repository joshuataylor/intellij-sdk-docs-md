# Dynamic Plugins

Installing, updating, and uninstalling plugins without restarting the IDE is available for all plugins following the restrictions listed below.

During plugin development, [Auto-Reload](ide-development-instance.html#enabling-auto-reload) also allows code changes to take effect immediately in the sandbox IDE instance.
To test whether dynamic installation works correctly, verify installing [local build distribution](publishing-plugin.html#building-distribution) succeeds (see [Troubleshooting](#troubleshooting)).

Note that any unloading problems in a production environment will ask the user to restart the IDE.

Note:

If a plugin requires restart (for example, due to using native libraries) specify `require-restart="true"` for [&lt;idea-plugin&gt;](plugin-configuration-file.html#idea-plugin) root tag in `[plugin.xml](plugin-configuration-file.html)`.

Warning:

Third-party paid plugins can't be installed, updated, or uninstalled without restarting the IDE.

## Restrictions

For a plugin to support this, all restrictions listed below must be met.
To verify a plugin locally, invoke `Code | Analyze Code | Run Inspection by Name…` and run Plugin DevKit | Plugin descriptor | Plugin.xml dynamic plugin verification inspection on all plugin descriptor files.

For plugins hosted on the [JetBrains Marketplace](https://plugins.jetbrains.com), the built-in [Plugin Verifier](https://blog.jetbrains.com/platform/2018/07/plugins-repository-now-integrates-with-the-plugin-verification-tool/) will run these checks automatically.
See [Plugin Verifier](verifying-plugin-compatibility.html#plugin-verifier) for more information on how to run it locally or on CI.

### No Use of Components

No Components must be used; existing ones [must be migrated](plugin-components.html) to services, extensions, or listeners.

### Action Group Requires ID

All [&lt;group&gt;](plugin-configuration-file.html#idea-plugin__actions__group) elements must declare a unique `id`.

### Use Only Dynamic Extensions

Whether defined in the platform itself ([IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html)) or coming from other plugins, all used extension points must be marked explicitly as dynamic (see next paragraph).

Some deprecated extension points (for example, `com.intellij.configurationProducer`) are intentionally non-dynamic, and their usage should be migrated to the corresponding replacement.

### Mark Extension Points as Dynamic

If a plugin defines its own custom extension points, they must adhere to specific usage rules and then [be declared](plugin-extension-points.html#dynamic-extension-points) ready for dynamic use explicitly.

### Configurables Depending on Extension Points

Any [Configurable](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/ide-core/src/com/intellij/openapi/options/Configurable.java) which depends on dynamic extension points must implement `Configurable.WithEpDependencies`.

### No Use of Service Overrides

Application, project, and module [services](plugin-services.html) declared with `overrides="true"` aren't allowed.

## Code

Note:

Loading and unloading plugins happens in [EDT](threading-model.html) and under write action.

### 

`CachedValue`

Loading/Unloading a plugin clears all cached values created using [CachedValuesManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/util/CachedValuesManager.java).

### Do Not Store PSI

Do not store references to PSI elements in objects which can survive plugin loading or unloading; use [SmartPsiElementPointer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/SmartPsiElementPointer.java) instead.

### 

Do not Use `FileType`/`Language` as Map Key

Replace with `String` from `Language.getID()`/`FileType.getName()` (use inspection Plugin DevKit | Code | Map key may leak).

### Plugin Load/Unload Events

Register [DynamicPluginListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/ide/plugins/DynamicPluginListener.kt) [application listener](plugin-listeners.html) to receive updates on plugin load/unload events.

This can be used to, for example:

* cancel long-running activities or disallow unloading due to ongoing processes

* clearing data from `UserDataHolder` objects (see `clearInjectorCache()` and `dropFileCaches()` in [InjectedLanguageManagerImpl](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-impl/src/com/intellij/psi/impl/source/tree/injected/InjectedLanguageManagerImpl.java))

* and similar cases

### Resource Cleanup

Use [Services](plugin-services.html) implementing [Disposable](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/openapi/Disposable.java) and perform cleanup in `Disposable.dispose()`.

## Troubleshooting

When a plugin is being uninstalled or updated, the IDE waits synchronously for the plugin unload and asks for restart if the unloading failed.

If it fails:

1. Try a newer version of the IDE (eventually latest available from [Early Access Program](https://eap.jetbrains.com)), in some cases platform bugs might be an issue.
See this [list of known platform issues](https://youtrack.jetbrains.com/issues/IDEA?q=%23dynamic-plugins%20) related to handling dynamic plugins.

2. Try in a fresh and new configuration (for example, clean the [sandbox](ide-development-instance.html#the-development-instance-sandbox-directory) or use a different configuration directory).

### Logging

All events are tracked under the `com.intellij.ide.plugins.DynamicPlugins` category in the IDE log file.
If a plugin fails to reload, the log will contain a cause as to why.

### Diagnosing Leaks

Procedure: Finding leaks preventing unload

When steps 1 and 2 are completed, the log will contain more information about the memory leak.
For example, the following shows a chain of field references that is keeping the class loader in memory:

```
2020-12-26 14:43:24,563 [ 251086]   INFO - lij.ide.plugins.DynamicPlugins - Snapshot analysis result: Root 1:
  ROOT: Global JNI
  sun.awt.X11.XInputMethod.clientComponentWindow
  com.intellij.openapi.wm.impl.IdeFrameImpl.rootPane
  com.intellij.openapi.wm.impl.IdeRootPane.myToolbar
  com.intellij.openapi.actionSystem.impl.ActionToolbarImpl.myVisibleActions
  java.util.ArrayList.elementData
  java.lang.Object[]
  com.example.ActionExample.<class>
  com.example.ActionExample.<loader>
* com.intellij.ide.plugins.cl.PluginClassLoader
```

