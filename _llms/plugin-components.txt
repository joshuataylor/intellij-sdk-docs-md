# Components (Deprecated)

Warning: Deprecation Notice

When writing new plugins, creating Components must be avoided.
Any existing Components should be migrated to services, extensions, or listeners (see below).

Plugin Components are a legacy feature supported for compatibility with plugins created for older versions of the IntelliJ Platform.
Plugins using Components don't support [dynamic loading](dynamic-plugins.html) (the ability to install, update, and uninstall plugins without restarting the IDE).

Plugin Components are defined in the `<application-components>`, `<project-components>`, and `<module-components>` sections in a [Plugin Configuration File](plugin-configuration-file.html).

## Migration

To migrate existing code from Components to modern APIs, see the following guidelines.

### Manage State

To manage some state or logic that is only necessary when the user performs a specific operation, use a [Service](plugin-services.html).

### Persisting State

To store the state of your plugin at the application or project level, use a [Service](plugin-services.html) and implement the `PersistentStateComponent` interface.
See [Persisting State of Components](persisting-state-of-components.html) for details.

### Subscribing to Events

To subscribe to events, use a [listener](plugin-listeners.html) or create an [extension](plugin-extensions.html) for a dedicated extension point
(for example, [com.intellij.editorFactoryListener](https://jb.gg/ipe?extensions=com.intellij.editorFactoryListener)
) if one exists for the event to subscribe to.

### Application Startup

Warning:

Executing code on application startup should be avoided whenever possible because it slows down startup.

Plugin code should only be executed when projects are opened (see [Project Open](#project-open)) or when the user invokes an action of a plugin.
If this can't be avoided, add a [listener](plugin-listeners.html) subscribing to the [AppLifecycleListener](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/ide-core/src/com/intellij/ide/AppLifecycleListener.java) topic.
See also [Running Tasks Once](ide-infrastructure.html#running-tasks-once).

### Project Open

2023.1 and later:

Using [Kotlin coroutines](kotlin-coroutines.html), implement [ProjectActivity](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/openapi/startup/StartupActivity.kt) and register in [com.intellij.postStartupActivity](https://jb.gg/ipe?extensions=com.intellij.postStartupActivity) extension point
.
Examples:

* [PowerSaveModeNotifier](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/ide/actions/PowerSaveModeNotifier.kt)

* [TipOfTheDayStartupActivity](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/tips-of-the-day/src/com/intellij/ide/TipOfTheDayStartupActivity.kt)

Implementation in [Kotlin](using-kotlin.html) is required because Java doesn't support suspending functions.

Pre-2023.1:

To execute code when a project is being opened, use one of these two [extensions](plugin-extensions.html):

`com.intellij.postStartupActivity`
: [StartupActivity](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/openapi/startup/StartupActivity.kt) for immediate execution on [EDT](threading-model.html).
Implement `DumbAware` to indicate activity can run in a background thread (in parallel with other such tasks).

`com.intellij.backgroundPostStartupActivity`
: [StartupActivity.Background](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/openapi/startup/StartupActivity.kt) for execution with a 5-second delay in a background thread.

Any long-running or CPU-intensive tasks should be made visible to users by using `ProgressManager.run(Task.Backgroundable)` (see [Background Processes](background-processes.html)).
Access to indexes must be wrapped with [DumbService](indexing-and-psi-stubs.html#dumb-mode), see also [Threading Model](threading-model.html).

See also [Running Tasks Once](ide-infrastructure.html#running-tasks-once).

### Project and Application Close

To execute code on project closing or application shutdown, implement the [Disposable](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/util/src/com/intellij/openapi/Disposable.java) interface in a [Service](plugin-services.html) and place the code in the `dispose()` method.
Alternatively, use `Disposer.register()` passing a `Project` or `Application` service instance as the `parent` argument (see [Choosing a Disposable Parent](disposers.html#choosing-a-disposable-parent)).

