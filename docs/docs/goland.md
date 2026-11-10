# GoLand Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/go), [Versions](https://www.jetbrains.com/go/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/go)
</tldr>

[GoLand](https://www.jetbrains.com/go/) is an IntelliJ Platform-based product.
Plugin projects for GoLand can be developed using [IntelliJ IDEA](idea.html).

## GoLand Plugin Setup

### Gradle Build Script

#### IntelliJ Platform Gradle Plugin (2.x)

Define a dependency using [goland()](tools-intellij-platform-gradle-plugin-dependencies-extension.html), see Versions link on top of this page for all available versions.
See [Local IntelliJ Platform IDE Instance](tools-intellij-platform-gradle-plugin.html#dependenciesLocalPlatform) for using a local installation.

A dependency on the bundled `org.jetbrains.plugins.go` plugin must be added using the [bundledPlugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) helper.

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
    goland("<versionNumber>")
    bundledPlugin("org.jetbrains.plugins.go")
  }
}
```

#### Gradle IntelliJ Plugin (1.x)

Warning: Obsolescence Notice

Gradle IntelliJ Plugin (1.x) is no longer under active development.

Whenever possible, use [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html) instead.

GoLand IDE:

The configuration of targeting GoLand IDE follows the methods described in [Configuring Plugin Projects Using a Product-Specific Attribute](dev-alternate-products.html#using-a-product-specific-attribute).

Starting with 2020.2, it's possible to configure `GO` for `intellij.type` in the Gradle build script.
To use Go language APIs, specifying the `GO` platform type is not enough - it is required to add a dependency to the `org.jetbrains.plugins.go` plugin.

Kotlin:

```KOTLIN
intellij {
  version.set("2020.3")
  type.set("GO")

  // required if Go language API is needed:
  plugins.set(listOf("org.jetbrains.plugins.go"))
}
```

Groovy:

```GROOVY
intellij {
  version = '2020.3'
  type = 'GO'

  // required if Go language API is needed:
  plugins = ['org.jetbrains.plugins.go']
}
```

Using Plugin:

The configuration of GoLand plugin projects follows the methods described in [Configuring Plugin Projects using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#using-the-intellij-idea-product-attribute), and [Configuring the plugin.xml File](dev-alternate-products.html#configuring-pluginxml).

The table below summarizes the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) attributes to set in the plugin project's Gradle build script.
Click on an entry in the table's Attribute column to go to the documentation about that attribute.
To see how these attributes appear in a similar Gradle build script for PhpStorm, see [Configuring Gradle Build Script Using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#configuring-gradle-build-script-using-the-intellij-idea-product-attribute).

The Go plugin version is explicitly declared because it isn't bundled with IntelliJ IDEA Ultimate Edition.
Select a [version](https://plugins.jetbrains.com/plugin/9568-go/versions) of the Go plugin compatible with the IntelliJ Idea Ultimate version.

| Gradle IntelliJ Plugin Attribute |Attribute Value |
-----------------------------------------------------
| [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) |`IU` for IntelliJ IDEA Ultimate. |
| [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) |Set to the same `IU` BRANCH.BUILD as the GoLand target version, e.g. `193.5233.102`. |
| [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) |`org.jetbrains.plugins.go:193.5233.102.83` for the Go plugin.  See below for Go plugin version information.   |
| [runIde.ideDir](tools-gradle-intellij-plugin.html#tasks-runide-idedir) |Path to locally installed target version of GoLand. For example, on macOS:  `/Users/$USERNAME$/Library/Application Support/JetBrains/Toolbox/apps/Goland/ch-0/193.5233.112/GoLand.app/Contents`.   |

### plugin.xml

Depending on plugin's requirements, the following [&lt;depends&gt;](plugin-configuration-file.html#idea-plugin__depends) entries are needed in the `plugin.xml` file:

* `com.intellij.modules.platform` - Always required. See [Configuring the plugin.xml File](dev-alternate-products.html#configuring-pluginxml) for details.

* `org.jetbrains.plugins.go` - Required if the Go plugin APIs are used in the plugin.

* `com.intellij.modules.goland` (2020.2+) or `com.intellij.modules.go` (pre-2020.2) - Required if the plugin targets GoLand IDE only. The plugin will not be loaded in other IDEs, even if the Go plugin is present.

### Targeting IDEs Other Than GoLand

Depending on `com.intellij.modules.goland` allows a plugin to be installed in the GoLand IDE only.
However, the Go plugin can be installed in [IntelliJ IDEA Ultimate](https://www.jetbrains.com/idea/) and potentially other IDEs.
To make the plugin compatible with GoLand and other IDEs supporting the Go language consider depending on:

* `org.jetbrains.plugins.go` - The plugin will be loaded only when the Go plugin is actually installed in the running IDE.

* `com.intellij.modules.go-capable` - The plugin will be loaded in IDEs that are capable of installing the Go plugin. Note that the Go plugin doesn't have to be actually installed when this module is present.

## Available GoLand APIs

Note:

See [GoLand Extension Point and Listener List](goland-extension-point-list.html) for the complete list.

Use the [Exploring APIs as a Consumer](plugin-compatibility.html#exploring-apis-as-a-consumer) process to identify the library `intellij-go-$version$.jar`, where `$version$` corresponds to the version of the Go plugin.
Test the plugin with every supported version of GoLand.

## GoLand Test Framework

Please see [this issue](https://github.com/JetBrains/intellij-platform-gradle-plugin/issues/477#issuecomment-845022914) for required additional dependency setup.

## Open Source Plugins for GoLand

When learning new APIs, it is helpful to have some representative projects for reference:

* [Go Method Generator](https://github.com/pkondratev/Intellij-go-method-generator)

* [Go Builder Generator](https://github.com/OddCN/go-builder-generator-idea-plugin)

## Getting Help

For plugin implementation support and questions, see the
[Getting Help](getting-help.html#problems-with-code-support-issues) section.

