# IDE Infrastructure

## Logging

Note:

If your plugin uses the log4j library directly: it is removed from IntelliJ Platform in 2022.1; please see this [blog post](https://blog.jetbrains.com/platform/2022/02/removing-log4j-from-the-intellij-platform/) for migration instructions.

The IntelliJ Platform uses [Logger](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/src/com/intellij/openapi/diagnostic/Logger.java) abstraction class to shield from underlying logging implementation and configuration.

Plugins should get a dedicated instance:

Java:

```JAVA
import com.intellij.openapi.diagnostic.Logger;

public class MyClass {
  private static final Logger LOG = Logger.getInstance(MyClass.class);

  public void someMethod() {
    LOG.info("someMethod() was called");
  }
}
```

Kotlin:

```KOTLIN
import com.intellij.openapi.diagnostic.logger

private val LOG = logger<MyClass>()

class MyClass {
  fun someMethod() {
    LOG.info("someMethod() was called")
  }
}
```

If logging is used only to report exceptions, use convenience method `thisLogger()` instead of a dedicated instance:

```KOTLIN
try {
  // some code
} catch (e: Throwable) {
  thisLogger().error("some code failed", e)
}
```

By default, all messages with level `INFO` and higher are written to log output file `idea.log`.
To enable `DEBUG`/`TRACE` logging for specific categories, use `Help | Diagnostic Tools | Debug Log Settings`.

To locate the log file, choose the `Help | Show Log in Finder/Explorer` action.
When [internal mode](enabling-internal.html) is enabled, the currently running IDE log file can be opened using `Help | Open Log in Editor`.

To locate it for a specific installation, see this [Knowledge Base article](https://intellij-support.jetbrains.com/hc/en-us/articles/206544519).
See [Development Instance Sandbox Directory](ide-development-instance.html#the-development-instance-sandbox-directory) on how to find it for development instances.

See [Testing FAQ](testing-faq.html) on how to enable `DEBUG`/`TRACE` level logging during tests and get separate logs for failing tests.

To provide additional context for [reporting fatal errors](#error-reporting), use `Logger.error()` methods taking additional `Attachment` (see [CoreAttachmentFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-impl/src/com/intellij/diagnostic/CoreAttachmentFactory.java) and [AttachmentFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/src/com/intellij/openapi/diagnostic/AttachmentFactory.java)).

## Error Reporting

The IDE will show fatal errors caught by itself as well as logging messages with `ERROR` level in the IDE Fatal Errors dialog:

* for IDE platform: in EAP releases or when running in [internal mode](enabling-internal.html)

* for third-party plugins: always

For the latter, reporting is disabled by default — instead, there's an option to disable the plugin causing the exception.

To let plugins report errors, the following solutions are available:

* Use [JetBrains Exception Analyzer (EA)](https://plugins.jetbrains.com/docs/marketplace/exception-analyzer.html) that sends errors to the backend provided by JetBrains (2023.3+).

* Implement custom [ErrorReportSubmitter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/openapi/diagnostic/ErrorReportSubmitter.java) registered in [com.intellij.errorHandler](https://jb.gg/ipe?extensions=com.intellij.errorHandler) extension point .

* For automatic background observability, plugins can also implement experimental [ErrorReportSink](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/openapi/diagnostic/ErrorReportSink.kt) registered in [com.intellij.errorReportSink](https://jb.gg/ipe?extensions=com.intellij.errorReportSink) extension point .

For the complete setup and API details, see [Error Reporting](error-reporting.html).
That page explains when to use `ErrorReportSubmitter` or `ErrorReportSink`,
how to submit reports without freezing the UI, and why freeze-specific attachments matter.

The red exclamation notification icon in the status bar is controlled with the `idea.fatal.error.notification` system property.
The property can be edited in `idea.properties` file opened with `Help | Edit Custom Properties...`:

* `idea.fatal.error.notification=disabled` hides the component

* any other value or the lack of the property enables the component

## Runtime Information

[ApplicationInfo](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/application/ApplicationInfo.java) provides information on the IDE version and vendor.
NOTE: to restrict compatibility, declare [IDEs](plugin-compatibility.html) and [versions](build-number-ranges.html) via `[plugin.xml](plugin-configuration-file.html)`.

To get information about OS and Java VM, use [SystemInfo](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/src/com/intellij/openapi/util/SystemInfo.java).

To access relevant configuration directories, see [PathManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/src/com/intellij/openapi/application/PathManager.java).

To obtain unique installation UUID, use [PermanentInstallationID](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/openapi/application/PermanentInstallationID.java).
For paid plugins, see also [Marketplace docs](https://plugins.jetbrains.com/docs/marketplace/identify-user-of-paid-plugin.html).

## Context Help

To show custom context web-based help for your plugin's functionality (e.g., for [dialogs](dialog-wrapper.html)), provide [WebHelpProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/openapi/help/WebHelpProvider.java) registered in [com.intellij.webHelpProvider](https://jb.gg/ipe?extensions=com.intellij.webHelpProvider) extension point
.

Tip:

To [localize](providing-translations.html) the help page URL, retrieve the current locale and language tag from the [dynamic bundle](providing-translations.html#getting-the-current-locale-programmatically).

## Running Tasks Once

Use [RunOnceUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/ide/util/RunOnceUtil.kt) to run a task exactly once per project/application.

## Application Events

Application lifecycle events can be tracked via the [AppLifecycleListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/ide/AppLifecycleListener.java) [listener](plugin-listeners.html).
See also [Application Startup](plugin-components.html#application-startup) and [Project and Application Close](plugin-components.html#project-and-application-close).

Register the [ApplicationActivationListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/openapi/application/ApplicationActivationListener.java) [listener](plugin-listeners.html) to be notified of "application focused/unfocused" events.

To request restart of the IDE, use [Application.restart()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/application/Application.java)

## Launching Browser

Use [BrowserLauncher](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ide/browsers/BrowserLauncher.kt).

## Open File in System File Manager

Use [RevealFileAction.openFile()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/ide/actions/RevealFileAction.java) or `openDirectory()`.

## Theme Change

Use the [LafManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ide/ui/LafManagerListener.java) topic to receive change notifications (e.g., to refresh UI).

## Power Save Mode

`File | Power Save Mode` can be enabled to limit power-consuming features on laptops.
Use [PowerSaveMode](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/ide/PowerSaveMode.java) service and `PowerSaveMode.Listener` topic to disable such features in your plugin accordingly.

## Plugin Management

Installed plugins can be checked via [PluginManagerCore.isPluginInstalled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-impl/src/com/intellij/ide/plugins/PluginManagerCore.kt).

See also [Plugin Load/Unload Events](dynamic-plugins.html#pluginLoadUnloadEvents).

### Plugin Suggestions

For specific features (e.g., [File Type](registering-file-type.html), [Facet](facet.html), ...), the IDE will suggest installing matching plugins automatically.
See [Plugin Recommendations](https://plugins.jetbrains.com/docs/marketplace/intellij-plugin-recommendations.html) in Marketplace documentation for details.

To suggest other relevant plugins, use [PluginsAdvertiser.installAndEnable()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/openapi/updateSettings/impl/pluginsAdvertisement/PluginsAdvertiser.kt).

### Deprecating a Plugin

To suggest replacing the currently installed deprecated plugin with the new one, implement [PluginReplacement](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ide/plugins/PluginReplacement.java) registered in [com.intellij.pluginReplacement](https://jb.gg/ipe?extensions=com.intellij.pluginReplacement) extension point
.

## Network

Use [HttpConnectionUtils](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/util/net/HttpConnectionUtils.kt)
to use platform network settings (e.g., proxy) (2024.3).
For earlier versions, see [HttpConfigurable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/util/net/HttpConfigurable.java).

