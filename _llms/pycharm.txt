# PyCharm Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/pycharm), [Versions](https://www.jetbrains.com/pycharm/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/pycharm_ce)
</tldr>

[PyCharm](https://www.jetbrains.com/pycharm/) is an IntelliJ Platform-based product.
Plugin projects for PyCharm can be developed using [IntelliJ IDEA](idea.html).

## PyCharm Plugin Setup

### Gradle Build Script

IntelliJ Platform Gradle Plugin (2.x):

Define a dependency using [pycharm()](tools-intellij-platform-gradle-plugin-dependencies-extension.html), see Versions link on top of this page for all available versions.
See [Local IntelliJ Platform IDE Instance](tools-intellij-platform-gradle-plugin.html#dependenciesLocalPlatform) for using a local installation.

A dependency on the matching bundled `PythonCore`/`Pythonid` plugin (see [Python Plugins](#python-plugins) below) must be added using the [bundledPlugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) helper.

Minimum `build.gradle.kts` setup:

```KOTLIN
repositories {
  mavenCentral()
  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    pycharm("<versionNumber>")
    bundledPlugin("PythonCore")
  }
}
```

Gradle IntelliJ Plugin (1.x):

The configuration of PyCharm plugin projects follows the methods described in [Configuring Plugin Projects using a Product-Specific Attribute](dev-alternate-products.html#using-a-product-specific-attribute), and [Configuring the plugin.xml File](dev-alternate-products.html#configuring-pluginxml).
The table below summarizes the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) attributes to set in the Gradle build script.
Click on an entry in the table's Attribute column to go to the documentation about that attribute.

| `gradle-intellij-plugin` Attribute |Attribute Value |
-------------------------------------------------------
| [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) |`PC` for PyCharm Community Edition `PY` for PyCharm Professional Edition |
| [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) |Set to the targeted `PC` or `PY` version. |
| [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) |See [Python Plugins](#python-plugins). |
| [intellij.downloadSources](tools-gradle-intellij-plugin.html#intellij-extension-downloadsources) |`false` is required because no public source code is available. |
| [runIde.ideDir](tools-gradle-intellij-plugin.html#tasks-runide-idedir) |Not needed; the Development Instance will automatically match `intellij.type`. |

### plugin.xml

The dependency on the PyCharm APIs must be declared in the `[plugin.xml](plugin-configuration-file.html)` file.
As described in [Configuring the plugin.xml File](dev-alternate-products.html#configuring-pluginxml), the [&lt;depends&gt;](plugin-configuration-file.html#idea-plugin__depends) tag must declare `com.intellij.modules.python`.

### Python Plugins

| Plugin |Plugin ID |API |
--------------------------
| [Python Community Edition](https://plugins.jetbrains.com/plugin/7322-python-community-edition) |`PythonCore` |PyCharm Community Edition (`PC`) |
| [Python](https://plugins.jetbrains.com/plugin/631-python) |`Pythonid` |PyCharm(`PY`) |

#### Python Plugins 2024.2

When using functionality from `Pythonid`, a dependency on both `PythonCore` and `Pythonid` is now required.

## Available PyCharm APIs

See [IntelliJ Platform Plugins Extension Point and Listener List](intellij-community-plugins-extension-point-list.html) for PyCharm.

## Additional Articles and Resources

* [Webinar Recording: &quot;Live Development of a PyCharm Plugin&quot; with Joachim Ansorg](https://blog.jetbrains.com/pycharm/2019/01/webinar-recording-live-development-of-a-pycharm-plugin-with-joachim-ansorg/)

## Open Source Plugins for PyCharm

When learning new development configurations, it is helpful to have some representative projects for reference:

* [Flake8 Support](https://github.com/jansorg/pycharm-flake8) Adds support for flake8's `# noqa` comments in PyCharm.

## Getting Help

For plugin implementation support and questions, see the
[Getting Help](getting-help.html#problems-with-code-support-issues) section.

