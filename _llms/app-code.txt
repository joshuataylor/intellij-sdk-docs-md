# AppCode Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/objc), [Versions](https://www.jetbrains.com/objc/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/appcode)
</tldr>

Plugin projects targeting [AppCode](https://www.jetbrains.com/objc/) can be developed using IntelliJ IDEA with the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html).

Warning:

With the release of AppCode 2022.3, we're sunsetting the product.
Please see this [blog post](https://blog.jetbrains.com/appcode/2022/12/appcode-2022-3-release-and-end-of-sales-and-support/) for details.

## Configuring Plugin Projects Targeting AppCode

Warning:

When targeting 2020.3, please see this [migration guide](https://blog.jetbrains.com/clion/2020/12/migration-guide-for-plugins-2020-3/).

The Gradle configuration of AppCode plugin projects uses neither Product-Specific nor IntelliJ IDEA Attributes.
Instead, configure AppCode plugin projects to use the [intellij.localPath](tools-gradle-intellij-plugin.html#intellij-extension-localpath) attribute.

Note:

AppCode plugin development requires installing AppCode locally.

The table below summarizes the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) attributes to set in the plugin project's Gradle build script.
Click on an entry in the table's Attribute column to go to the documentation about that attribute.

| `gradle-intellij-plugin` Attribute |Attribute Value |
-------------------------------------------------------
| [intellij.localPath](tools-gradle-intellij-plugin.html#intellij-extension-localpath) |Path to locally installed target version of AppCode. For example, for macOS:  `/Users/$USERNAME$/Library/Application Support/JetBrains/Toolbox/apps/AppCode/ch-0/193.5662.55/AppCode.app/Contents`.   |
| [runIde.ideDir](tools-gradle-intellij-plugin.html#tasks-runide-idedir) |Path to locally installed target version of AppCode. For example, for macOS:  `/Users/$USERNAME$/Library/Application Support/JetBrains/Toolbox/apps/AppCode/ch-0/193.5662.55/AppCode.app/Contents`.   |

The dependency on the AppCode APIs must be declared in the `[plugin.xml](plugin-configuration-file.html)` file.
As described in [Modules Specific to Functionality](plugin-compatibility.html#modules-specific-to-functionality) table, the [&lt;depends&gt;](plugin-configuration-file.html#idea-plugin__depends) tags must declare `com.intellij.modules.appcode` module dependency, or `com.intellij.appcode` plugin dependency for plugins targeting only versions 2020.3+.

## Available AppCode APIs

Note:

See [AppCode Extension Point and Listener List](appcode-extension-point-list.html) for the complete list.

Use the [Exploring APIs as a Consumer](plugin-compatibility.html#exploring-apis-as-a-consumer) process to identify the libraries in AppCode.
Test your plugin with any version of AppCode you wish to support.

