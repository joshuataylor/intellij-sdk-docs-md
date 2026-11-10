# WebStorm Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/webstorm), [Versions](https://www.jetbrains.com/webstorm/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/webstorm)
</tldr>

[WebStorm](https://www.jetbrains.com/webstorm/) is an IntelliJ Platform-based product.
Plugin projects for WebStorm can be developed using [IntelliJ IDEA](idea.html).

Tip:

WebStorm is free for non-commercial use

Note:

Follow [Building a Plugin for WebStorm – Tutorial for JavaScript Developers](learning-resources.html#articles) blog post series to get started
and [How To Build a Plugin for JetBrains IDEs (Analog.js Example)](learning-resources.html#webinars) webinar.

## WebStorm Plugin Setup

### Gradle Build Script

IntelliJ Platform Gradle Plugin (2.x):

Define a dependency using [webstorm()](tools-intellij-platform-gradle-plugin-dependencies-extension.html), see Versions link on top of this page for all available versions.
See [Local IntelliJ Platform IDE Instance](tools-intellij-platform-gradle-plugin.html#dependenciesLocalPlatform) for using a local installation.

A dependency on the bundled `JavaScript` plugin must be added using the [bundledPlugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) helper.

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
    webstorm("<versionNumber>")
    bundledPlugin("JavaScript")
  }
}
```

Gradle IntelliJ Plugin (1.x):

The configuration of WebStorm plugin projects follows the methods described in [Configuring Plugin Projects using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#using-the-intellij-idea-product-attribute) and [Configuring the plugin.xml File](dev-alternate-products.html#configuring-pluginxml) for PhpStorm.

The table below summarizes the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) attributes to set in the plugin project's Gradle build script.
Click on an entry in the table's Attribute column to go to the documentation about that attribute.
To see how these attributes appear in a similar Gradle build script for PhpStorm, see [Configuring Gradle Build Script Using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#configuring-gradle-build-script-using-the-intellij-idea-product-attribute).

| `gradle-intellij-plugin` Attribute |Attribute Value |
-------------------------------------------------------
| [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) |`IU` for [IntelliJ IDEA Plugin Development](idea.html). |
| [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) |`192.7142.36` Set to the same BRANCH.BUILD as the WebStorm target version. |
| [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) |Dependency on the `JavaScript` plugin. |
| [runIde.ideDir](tools-gradle-intellij-plugin.html#tasks-runide-idedir) |Path to locally installed target version of WebStorm. For example, for macOS:  `/Users/$USERNAME$/Library/Application Support/JetBrains/Toolbox/apps/WebStorm/ch-0/192.7142.35/WebStorm.app/Contents`.   |

### plugin.xml

The dependency on the WebStorm APIs must be declared in the `[plugin.xml](plugin-configuration-file.html)` file.
As described in the [Modules Specific to Functionality](plugin-compatibility.html#modules-specific-to-functionality) table, the [&lt;depends&gt;](plugin-configuration-file.html#idea-plugin__depends) tags must declare `JavaScript`.

Note that for WebStorm, the `plugin.xml` file must also declare a dependency on `com.intellij.modules.platform` because `JavaScript` is not recognized as a module.
Otherwise, the plugin is assumed to be a [legacy plugin](plugin-compatibility.html#declaring-plugin-dependencies) and will not load in WebStorm.

## Available WebStorm APIs

Note:

See [WebStorm Extension Point and Listener List](webstorm-extension-point-list.html) for the complete list.

See [Exploring APIs as a Consumer](plugin-compatibility.html#exploring-apis-as-a-consumer).
Test the plugin with every supported version of WebStorm.

### JavaScript Test Framework

To use existing test base classes, add `TestFrameworkType.Plugin.JavaScript` test-framework available from [Plugin Test Frameworks](tools-intellij-platform-gradle-plugin-types.html#TestFrameworkType-Plugin).

Alternatively, specify `com.jetbrains.intellij.javascript:javascript-test-framework:$VERSION$` as `testImplementation` dependency explicitly (see [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html#gradle-example-for-an-individual-module-from-the-intellij-platform)).

## Open Source Plugins for WebStorm

When learning new plugin development, it is helpful to have some representative projects for reference:

* [Vue.js](https://github.com/JetBrains/intellij-plugins/tree/idea/263.7307.200/vuejs)

* [JS Toolbox](https://github.com/andresdominguez/jsToolbox)

* [deep-js-completion](https://github.com/klesun/deep-js-completion)

* [Run Configuration for TypeScript](https://github.com/bluelovers/idea-run-typescript)

## Getting Help

For plugin implementation support and questions, see the
[Getting Help](getting-help.html#problems-with-code-support-issues) section.

