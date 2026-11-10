# DataGrip Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/datagrip), [Versions](https://www.jetbrains.com/datagrip/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/dbe)
</tldr>

[DataGrip](https://www.jetbrains.com/datagrip/) is an IntelliJ Platform-based product.
Plugin projects targeting DataGrip can be developed using [IntelliJ IDEA](idea.html).

## DataGrip Plugin Setup

### Gradle Build Script

IntelliJ Platform Gradle Plugin (2.x):

Define a dependency using [datagrip()](tools-intellij-platform-gradle-plugin-dependencies-extension.html), see Versions link on top of this page for all available versions.
See [Local IntelliJ Platform IDE Instance](tools-intellij-platform-gradle-plugin.html#dependenciesLocalPlatform) for using a local installation.

A dependency on the bundled `com.intellij.database` plugin must be added using the [bundledPlugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) helper.

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
    datagrip("<versionNumber>")
    bundledPlugin("com.intellij.database")
  }
}
```

Gradle IntelliJ Plugin (1.x):

The configuration of DataGrip plugin projects follows the methods described in [Configuring Plugin Projects using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#using-the-intellij-idea-product-attribute), and [Configuring the plugin.xml File](dev-alternate-products.html#configuring-pluginxml).

The table below summarizes the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) attributes to set in the plugin project's Gradle build script.
Click on an entry in the table's Attribute column to go to the documentation about that attribute.
To see how these attributes appear in a similar Gradle build script for PhpStorm, see [Configuring Gradle Build Script Using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#configuring-gradle-build-script-using-the-intellij-idea-product-attribute).

| `gradle-intellij-plugin` Attribute |Attribute Value |
-------------------------------------------------------
| [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) |`IU` for IntelliJ IDEA Ultimate.  `IC` is incompatible with the required `DatabaseTools` plugin.   |
| [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) |`2019.3` Set to the same version as the DataGrip target version, as set by `runIde.ideDir`. |
| [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) |`DatabaseTools` Dependency on the bundled `DatabaseTools` plugin. |
| [runIde.ideDir](tools-gradle-intellij-plugin.html#tasks-runide-idedir) |Path to locally installed target version of DataGrip. For example, for macOS:  `/Users/$USERNAME$/Library/Application Support/JetBrains/Toolbox/apps/datagrip/ch-0/193.5233.139/DataGrip.app/Contents`.   |

### plugin.xml

The dependency on the DataGrip APIs must be declared in the `[plugin.xml](plugin-configuration-file.html)` file.
As described in [Modules Specific to Functionality](plugin-compatibility.html#modules-specific-to-functionality) table, the [&lt;depends&gt;](plugin-configuration-file.html#idea-plugin__depends) tags must declare `com.intellij.database`.

Note that DataGrip plugins must also declare a dependency on `com.intellij.modules.platform` because `com.intellij.database` is not recognized as a module.
Consequently, without the `com.intellij.modules.platform` declaration the plugin is assumed to be a [legacy plugin](plugin-compatibility.html#declaring-plugin-dependencies) and will not load in DataGrip.

## Available DataGrip APIs

Note:

See [DataGrip Extension Point and Listener List](data-grip-extension-point-list.html) for the complete list.

Use the [Exploring APIs as a Consumer](plugin-compatibility.html#exploring-apis-as-a-consumer) process to identify the libraries in `DatabaseTools`.
Test the plugin with every supported version of DataGrip.

## Getting Help

For plugin implementation support and questions, see the
[Getting Help](getting-help.html#problems-with-code-support-issues) section.

