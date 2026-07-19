# CLion Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/clion), [Versions](https://www.jetbrains.com/clion/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/clion)
</tldr>

[CLion](https://www.jetbrains.com/clion/) is an IntelliJ Platform-based product.
Plugin projects for CLion can be developed using [IntelliJ IDEA](idea.html).

Tip:

CLion is free for non-commercial use

Warning:

Since CLion 2025.3, CLion Nova — the C/C++ language engine based on the ReSharper C++ engine — is enabled by default.
Since CLion 2026.2, the previous Classic engine is no longer bundled with the IDE distribution.
If your plugin uses the classic C/C++ language APIs (`OCFileType`, `OCLanguage`, `OCFile`, and other `com.jetbrains.cidr.lang` classes), see [C/C++ Language Engine: Nova and Classic](#language-engine) for the required changes.

## CLion Plugin Setup

### Gradle Build Script

IntelliJ Platform Gradle Plugin (2.x):

Define a dependency using [clion()](tools-intellij-platform-gradle-plugin-dependencies-extension.html), see Versions link on top of this page for all available versions.
See [Local IntelliJ Platform IDE Instance](tools-intellij-platform-gradle-plugin.html#dependenciesLocalPlatform) for using a local installation.

A dependency on the bundled `com.intellij.clion` plugin must be added using the [bundledPlugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) helper.

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
    clion("<versionNumber>")
    bundledPlugin("com.intellij.clion")
  }
}
```

Gradle IntelliJ Plugin (1.x):

Warning:

When targeting 2020.3, see this [migration guide](https://blog.jetbrains.com/clion/2020/12/migration-guide-for-plugins-2020-3/).

The configuration of CLion plugin projects follows the methods described in [Configuring Plugin Projects using a Product-Specific Attribute](dev-alternate-products.html#using-a-product-specific-attribute), and [Configuring the plugin.xml File](dev-alternate-products.html#configuring-pluginxml).

The table below summarizes the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) attributes to set in the plugin project's Gradle build script.
Click on an entry in the table's Attribute column to go to the documentation about that attribute.

| `gradle-intellij-plugin` Attribute |Attribute Value |
-------------------------------------------------------
| [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) |`CL` for the product CLion. |
| [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) |Set to the targeted CLion version, e.g. `2019.3.1`. |
| [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) |No specific declaration is needed. |
| [intellij.downloadSources](tools-gradle-intellij-plugin.html#intellij-extension-downloadsources) |`false` is required because no public source code is available. |
| [runIde.ideDir](tools-gradle-intellij-plugin.html#tasks-runide-idedir) |Not needed; the Development Instance will automatically match `intellij.type`. |

### plugin.xml

The dependency on the CLion APIs must be declared in the `[plugin.xml](plugin-configuration-file.html)` file.
As described in [Modules Specific to Functionality](plugin-compatibility.html#modules-specific-to-functionality) table, the [&lt;depends&gt;](plugin-configuration-file.html#idea-plugin__depends) tags must declare `com.intellij.modules.clion` module dependency,
or `com.intellij.clion` plugin dependency when targeting only versions 2020.3+.

## C/C++ Language Engine: Nova and Classic

CLion provides two C/C++ language engines:

* Nova – the current engine based on the ReSharper C++ engine. It is enabled by default since CLion 2025.3 and is the only engine bundled with the IDE since CLion 2026.2.

* Classic – the original in-IDE engine, backed by the `com.intellij.cidr.lang` plugin and the `com.jetbrains.cidr.lang` APIs. Since CLion 2026.2, it is no longer bundled and is distributed only as a separate JetBrains Marketplace plugin.

Warning:

The Classic C/C++ engine is deprecated. Nova is the default engine, and the two are mutually exclusive, so a Classic-based plugin works only for users who switch back to Classic.
Target the Nova APIs for new plugins and migrate existing ones — otherwise their users remain stuck on Classic.

### Using the Classic C/C++ Language APIs

The classic C/C++ language support — including `OCFileType`, `OCLanguage`, `OCFile`, and the rest of the `com.jetbrains.cidr.lang` package — is available in the [C/C++ Language Support via Classic Engine](https://plugins.jetbrains.com/plugin/32355-c-c--language-support-via-classic-engine) plugin (ID `com.intellij.cidr.lang`).

As this plugin is no longer bundled, declare a dependency on its Marketplace version using the [plugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#non-bundled-plugin) function:

```KOTLIN

dependencies {
  intellijPlatform {
    clion("<versionNumber>")
    bundledPlugin("com.intellij.clion")

    // C/C++ Language Support via Classic Engine (unbundled since 2026.2)
    plugin("com.intellij.cidr.lang", "<pluginVersion>")
  }
}
```

Tip:

The [compatiblePlugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#compatible-plugins) helper can be used instead to resolve a version compatible with the targeted CLion automatically.

The `com.intellij.modules.cidr.lang` module dependency in the `[plugin.xml](plugin-configuration-file.html)` file stays unchanged:

```XML
<depends>com.intellij.modules.cidr.lang</depends>
```

### Migrating to Nova

Nova represents C/C++ files with different classes located in the `com.jetbrains.rider.cpp.fileType` package:

| Classic (`com.jetbrains.cidr.lang`) |Nova (`com.jetbrains.rider.cpp.fileType`) |
----------------------------------------------------------------------------------
| `OCFileType` |`CppFileType` |
| `OCLanguage` |`CppLanguage` |
| `psi.OCFile` |`psi.CppFile` |

Nova performs C/C++ code analysis in a separate backend process and does not expose a frontend PSI model.
Apart from the file type and language above (and basic traversal via `com.jetbrains.rider.cpp.fileType.psi.CppElement`), there is no replacement for the Classic frontend APIs, including:

* PSI elements — `com.jetbrains.cidr.lang.psi.OCFile`, `com.jetbrains.cidr.lang.psi.OCIncludeDirective`, `com.jetbrains.cidr.lang.psi.OCPragma`, and the rest of the `com.jetbrains.cidr.lang.psi` package

* symbols — the `com.jetbrains.cidr.lang.symbols` package

* types — `com.jetbrains.cidr.lang.types.OCType`

* resolve and references — the `com.jetbrains.cidr.lang.resolve` package

Note:

Plugins relying on these APIs cannot be fully ported to Nova.
Keep depending on the [C/C++ Language Support via Classic Engine](https://plugins.jetbrains.com/plugin/32355-c-c--language-support-via-classic-engine) plugin if these APIs are required.

If your plugin cannot be migrated to CLion Nova yet, follow and vote for [CPP-36085](https://youtrack.jetbrains.com/issue/CPP-36085) to track improvements to Classic-to-Nova plugin migration.

## Available CLion APIs

Note:

See [CLion Extension Point and Listener List](clion-extension-point-list.html) for the complete list.

Use the [Exploring APIs as a Consumer](plugin-compatibility.html#exploring-apis-as-a-consumer) process to identify the JAR files under the External Library `Gradle:com.jetbrains:clion:<version>`.
Test your plugin with versions of CLion you intend to support.

## Open Source Plugins for CLion

When learning new APIs, it is helpful to have some representative projects for reference:

* [C/C++ Coverage](https://github.com/zero9178/C-Cpp-Coverage-for-CLion)

* [C/C++ Single File Execution](https://github.com/corochann/SingleFileExecutionPlugin)

## Getting Help

For plugin implementation support and questions, see the
[Getting Help](getting-help.html#problems-with-code-support-issues) section.

