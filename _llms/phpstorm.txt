# PhpStorm Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/phpstorm), [Versions](https://www.jetbrains.com/phpstorm/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/phpstorm)
</tldr>

[PhpStorm](https://www.jetbrains.com/phpstorm/) is an IntelliJ Platform-based product.
Plugin projects targeting PhpStorm can be developed using [IntelliJ IDEA](idea.html).

See also:

* [PhpStorm Advanced Metadata](plugin-alternatives.html#phpstorm-advanced-metadata)

* [PHP Open API](php-open-api.html)

* [Example PhpStorm Third-Party Plugins](existing-plugins.html)

## PhpStorm Plugin Setup

### Gradle Build Script

#### IntelliJ Platform Gradle Plugin (2.x)

Define a dependency using [phpstorm()](tools-intellij-platform-gradle-plugin-dependencies-extension.html), see Versions link on top of this page for all available versions.
See [Local IntelliJ Platform IDE Instance](tools-intellij-platform-gradle-plugin.html#dependenciesLocalPlatform) for using a local installation.

A dependency on the bundled `com.jetbrains.php` plugin must be added using the [bundledPlugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) helper.

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
    phpstorm("<versionNumber>")
    bundledPlugin("com.jetbrains.php")
  }
}
```

#### Gradle IntelliJ Plugin (1.x)

Warning: Obsolescence Notice

Gradle IntelliJ Plugin (1.x) is no longer under active development.

Whenever possible, use [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html) instead.

PhpStorm IDE:

The configuration of targeting PhpStorm IDE follows the methods described in [Configuring Plugin Projects Using a Product-Specific Attribute](dev-alternate-products.html#using-a-product-specific-attribute).

The possibility of configuring the `PS` IntelliJ Platform type was introduced in [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) 1.8.0.
Only the versions of PhpStorm 2022.2 and newer are supported.

The table below summarizes the Gradle IntelliJ Plugin attributes to set in the plugin project's Gradle build script.
Click on an entry in the table's Attribute column to go to the documentation about that attribute.

| `gradle-intellij-plugin` Attribute |Attribute Value |
-------------------------------------------------------
| [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) |`PS` for PhpStorm. |
| [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) |Set to the targeted `PS` version (only versions 2022.2+ are supported). |

PHP Plugin:

PhpStorm plugins targeting versions older than 2022.2 are developed using the Ultimate Edition of IntelliJ IDEA.
The IntelliJ IDEA (with the PHP plugin) must be used for developing PhpStorm plugins because the PHP plugin is incompatible with IntelliJ IDEA open source builds.
However, this IntelliJ IDEA Ultimate configuration runs the risk of accidentally using some APIs that are not available in PhpStorm.
The recommended best practice is to use PhpStorm for testing.

Configuration of a Gradle-based PhpStorm plugin project is used as a tutorial in the section [Configuring Plugin Projects using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#using-the-intellij-idea-product-attribute).
Many techniques are discussed, such as choosing a version of IntelliJ IDEA Ultimate given a targeted version of PhpStorm.

The table below summarizes the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) attributes to set in the plugin project's Gradle build script.
Click on an entry in the table's Attribute column to go to the documentation about that attribute.
To see how these attributes appear in the Gradle build script for PhpStorm, see [Configuring Gradle Build Script Using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#configuring-gradle-build-script-using-the-intellij-idea-product-attribute).

| `gradle-intellij-plugin` Attribute |Attribute Value |
-------------------------------------------------------
| [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) |`IU` for IntelliJ IDEA. The required PHP plugin isn't compatible with IntelliJ IDEA open source builds. |
| [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) |Set to the same `IU` BRANCH.BUILD as the PhpStorm target version, e.g. `193.5233.102`. |
| [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) |`com.jetbrains.php:193.5233.102` for the PHP plugin.  See below for PHP plugin version information.   |
| [runIde.ideDir](tools-gradle-intellij-plugin.html#tasks-runide-idedir) |Path to locally installed target version of PhpStorm. For example, on macOS:  `/Users/$USERNAME$/Library/Application Support/JetBrains/Toolbox/apps/PhpStorm/ch-0/193.5233.101/PhpStorm.app/Contents`.   |

The PHP plugin version is explicitly declared because it isn't bundled with IntelliJ IDEA Ultimate Edition.
Select a [version](https://plugins.jetbrains.com/plugin/6610-php/versions) of the PHP plugin compatible with the [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version).

### plugin.xml

The dependency on the PHP plugin APIs (`com.jetbrains.php`) must be declared in the `[plugin.xml](plugin-configuration-file.html)` file, as shown in the tutorial [Configuring plugin.xml](dev-alternate-products.html#configuring-pluginxml) section.

## Getting Help

For plugin implementation support and questions, see the
[Getting Help](getting-help.html#problems-with-code-support-issues) section.

