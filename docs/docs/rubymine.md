# RubyMine Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/ruby), [Versions](https://www.jetbrains.com/ruby/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/ruby)
</tldr>

[RubyMine](https://www.jetbrains.com/ruby/) is an IntelliJ Platform-based product.
Plugin projects for RubyMine can be developed using [IntelliJ IDEA](idea.html).

## RubyMine Plugin Setup

### Gradle Build Script

IntelliJ Platform Gradle Plugin (2.x):

Define a dependency using [rubymine()](tools-intellij-platform-gradle-plugin-dependencies-extension.html), see Versions link on top of this page for all available versions.
See [Local IntelliJ Platform IDE Instance](tools-intellij-platform-gradle-plugin.html#dependenciesLocalPlatform) for using a local installation.

A dependency on the bundled `org.jetbrains.plugins.ruby` plugin must be added using the [bundledPlugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) helper.

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
    rubymine("<versionNumber>")
    bundledPlugin("org.jetbrains.plugins.ruby")
  }
}
```

Gradle IntelliJ Plugin (1.x):

The configuration of RubyMine plugin projects follows the methods described in [Using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#using-the-intellij-idea-product-attribute) and [Configuring the plugin.xml File](dev-alternate-products.html#configuring-pluginxml).

The table below summarizes the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) attributes to set in the Gradle build script for a RubyMine plugin project.
Click on an entry in the table's Attribute column to go to the documentation about that attribute.
To see how these attributes appear in a similar Gradle build script for PhpStorm, see [Configuring Gradle Build Script Using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#configuring-gradle-build-script-using-the-intellij-idea-product-attribute).

| `gradle-intellij-plugin` Attribute |Attribute Value |
-------------------------------------------------------
| [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) |`IU` for IntelliJ IDEA Ultimate. |
| [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) |Set to the same `IU` BRANCH.BUILD as the RubyMine target version, e.g. `192.7142.36`. |
| [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) |`org.jetbrains.plugins.ruby:2019.2.20191029` for the Ruby plugin.  See below for Ruby plugin version information.   |
| [runIde.ideDir](tools-gradle-intellij-plugin.html#tasks-runide-idedir) |Path to locally installed target version of RubyMine. For example, on macOS:  `/Users/$USERNAME$/Library/Application Support/JetBrains/Toolbox/apps/RubyMine/ch-0/192.7142.37/RubyMine.app/Contents`.   |

The required `org.jetbrains.plugins.ruby` plugin isn't compatible with IntelliJ IDEA open source builds but is compatible with IntelliJ IDEA (`IU`).
Product compatibility is determined from the Ruby plugin [version page](https://plugins.jetbrains.com/plugin/1293-ruby/versions).
The Ruby plugin isn't bundled with `IU`, so the Ruby plugin version must be explicitly declared to support the target RubyMine (and `IU`) BRANCH.BUILD version.
The correct Ruby plugin version is also determined from the Ruby plugin version page.

### plugin.xml

The dependency on the Ruby plugin APIs must be declared in the `[plugin.xml](plugin-configuration-file.html)` file.
As described in the [Modules Specific to Functionality](plugin-compatibility.html#modules-specific-to-functionality) table, the [&lt;depends&gt;](plugin-configuration-file.html#idea-plugin__depends) tags must contain `com.intellij.modules.ruby`.

## Available RubyMine APIs

Note:

See [RubyMine Extension Point and Listener List](rubymine-extension-point-list.html) for the complete list.

Use the [Exploring APIs as a Consumer](plugin-compatibility.html#exploring-apis-as-a-consumer) process to identify the library `ruby.jar`.
Test your plugin with any version of RubyMine you intend to support.

### RubyMine Test Framework

To use existing test base classes, add `TestFrameworkType.Plugin.Ruby` test-framework available from [Plugin Test Frameworks](tools-intellij-platform-gradle-plugin-types.html#TestFrameworkType-Plugin).

Alternatively, specify `com.jetbrains.intellij.idea:ruby-test-framework:$VERSION$` as `testImplementation` dependency explicitly (see [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html#gradle-example-for-an-individual-module-from-the-intellij-platform)).

## Open Source Plugins for RubyMine

When learning new APIs, it is helpful to have some representative projects for reference:

* [Ruby-Doc-Adder](https://github.com/aristotll/RubyDocAdder)

* [Ruby Dynamic Code Insight](https://github.com/JetBrains/ruby-type-inference)

* [Railways](https://github.com/basgren/railways)

## Getting Help

For plugin implementation support and questions, see the
[Getting Help](getting-help.html#problems-with-code-support-issues) section.

