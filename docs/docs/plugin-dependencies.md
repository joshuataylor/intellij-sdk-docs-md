# Plugin Dependencies

A plugin may depend on API and classes from other plugins, either bundled or third-party.

This document describes the syntax for declaring plugin dependencies and optional plugin dependencies.
For more information about dependencies on the IntelliJ Platform modules, see [Plugin Compatibility with IntelliJ Platform Products](plugin-compatibility.html).

Note:

For adding dependencies on 3rd party libraries, use regular [Gradle dependency management](https://docs.gradle.org/current/userguide/core_dependency_management.html).

Procedure: Required Steps

## 1. Locating Plugin ID and Preparing Sandbox

A compatible version must be chosen carefully according to the plugin's [compatibility](build-number-ranges.html).
For non-bundled plugins, it is not possible to specify the minimum/maximum version for the dependent plugin. ([Issue](https://youtrack.jetbrains.com/issue/IDEABKL-7906))

### JetBrains Marketplace

For plugins published on [JetBrains Marketplace](https://plugins.jetbrains.com):

1. Open plugin's detail page

2. Scroll down to the bottom section Additional Information

3. Copy Plugin ID

### Bundled and Other Plugins

All IDs of bundled plugins can be gathered using a dedicated Gradle task.
See Other tab on how to locate the plugin ID for a plugin distribution file.

IntelliJ Platform Gradle Plugin (2.x):

Use [printBundledPlugins](tools-intellij-platform-gradle-plugin-tasks.html#printBundledPlugins) task.

Gradle IntelliJ Plugin (1.x):

Use [listBundledPlugins](tools-gradle-intellij-plugin.html#tasks-listbundledplugins) task.

Other:

Locate the plugin's main JAR file containing the `META-INF/plugin.xml` descriptor with the [&lt;id&gt;](plugin-configuration-file.html#idea-plugin__id) tag
(use [&lt;name&gt;](plugin-configuration-file.html#idea-plugin__name) if `<id>` is not specified).

Bundled plugins are located in `$PRODUCT_ROOT$/plugins/$PLUGIN_NAME$/lib/$PLUGIN_NAME$.jar`.

#### IDs of Bundled Plugins

The following table lists some commonly used bundled plugins and their ID.
See also [Modules Specific to Functionality](plugin-compatibility.html#modules-specific-to-functionality).

| Plugin Name |Plugin ID |Related Documentation |
-------------------------------------------------
| Copyright |`com.intellij.copyright` |  |
| CSS |`com.intellij.css` |[WebStorm Plugin Development](webstorm.html) |
| Database Tools and SQL |`com.intellij.database` |[DataGrip Plugin Development](data-grip.html) |
| Gradle |`com.intellij.gradle` |  |
| Groovy |`org.intellij.groovy` |  |
| IntelliLang |`org.intellij.intelliLang` |[Language Injection](language-injection.html) |
| Java |`com.intellij.java` |[Java Plugin](idea.html#java-plugin) |
| JavaScript and TypeScript |`JavaScript` |[WebStorm Plugin Development](webstorm.html) |
| JSON |`com.intellij.modules.json` |[JSON plugin introduction notes](api-changes-list-2024.html#json-plugin-new-20243) |
| Kotlin |`org.jetbrains.kotlin` |[Kotlin Plugin](idea.html#kotlin-plugin) |
| Markdown |`org.intellij.plugins.markdown` |  |
| Maven |`org.jetbrains.idea.maven` |  |
| Spring |`com.intellij.spring` |[Spring API](spring-api.html) |
| Spring Boot |`com.intellij.spring.boot` |[Spring Boot](spring-api.html#spring-boot) |
| Terminal |`org.jetbrains.plugins.terminal` |[Embedded Terminal](embedded-terminal.html) |
| YAML |`org.jetbrains.plugins.yaml` |  |

### Preparing Sandbox

If the plugin is not bundled with the target IDE, run the (sandbox) [IDE Development Instance](ide-development-instance.html) of your target IDE and install the plugin there.

## 2. Project Setup

Depending on the chosen development workflow (Gradle or DevKit), one of the following steps is necessary.

### IntelliJ Platform Gradle Plugin (2.x)

Define dependencies on plugins using the provided helper functions in the `dependencies {}` block of the `build.gradle.kts` file:

```KOTLIN
dependencies {
  intellijPlatform {
    bundledPlugin("<pluginId>")
    plugin("<nonBundledPluginId>:<version>")
  }
}
```

For bundled plugins, use `bundledPlugin()`. Use `plugin()` for non-bundled plugins (for example, from [JetBrains Marketplace](https://plugins.jetbrains.com)).

See [Plugins](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) for full reference and additional options.

### Gradle IntelliJ Plugin (1.x)

Warning: Obsolescence Notice

Gradle IntelliJ Plugin (1.x) is no longer under active development.

Whenever possible, use [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html) instead.

Note:

See the [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) property for acceptable values.

Add the dependency to the [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) parameter in your build script:

Kotlin:

```KOTLIN
intellij {
  plugins.set(listOf("com.example.another-plugin:1.0"))
}
```

Groovy:

```GROOVY
intellij {
  plugins = ['com.example.another-plugin:1.0']
}
```

Note:

Transitive dependencies required for tests must currently be [specified explicitly](https://github.com/JetBrains/intellij-platform-gradle-plugin/issues/38).

### Plugin DevKit

Note:

Existing DevKit-based projects can be [converted to use Gradle setup](migrating-plugin-devkit-to-gradle.html) where dependency management is fully automated.

Add the JARs of the plugin on which the project depends to the Classpath of the [IntelliJ Platform SDK](setting-up-theme-environment.html#add-intellij-platform-plugin-sdk).

Warning:

Do not add the plugin JARs as a library: this will fail at runtime because the IntelliJ Platform will load two separate copies of the dependency plugin classes.

Procedure: Adding a plugin dependency in a DevKit-based plugin

## 3. Dependency Declaration in plugin.xml

Regardless of whether a plugin project uses [Modules Available in All Products](plugin-compatibility.html#modules-available-in-all-products) or [Modules Specific to Functionality](plugin-compatibility.html#modules-specific-to-functionality), the correct module must be listed as a dependency in `plugin.xml`.
If a project depends on another plugin, the dependency must be declared like a [module](plugin-compatibility.html#modules).
If only general IntelliJ Platform features (APIs) are used, then a default dependency on `com.intellij.modules.platform` must be declared.

To display a list of available IntelliJ Platform modules, invoke the [code completion](https://www.jetbrains.com/help/idea/auto-completing-code.html#4eac28ba) feature for the [&lt;depends&gt;](plugin-configuration-file.html#idea-plugin__depends) element contents while editing the plugin project's `plugin.xml` file.

In the `plugin.xml`, add a `<depends>` tag with the dependency plugin's ID as its content.
Continuing with the example from the [Project Setup](#project-setup) above, the dependency declaration in `plugin.xml` would be:

```XML
<depends>com.example.another-plugin</depends>
```

## Optional Plugin Dependencies

A plugin can also specify an optional plugin dependency.
In this case, the plugin will load even if the plugin it depends on is not installed or enabled, but part of the plugin's functionality will not be available.

Declare additional `optional="true"` and required `config-file` attribute pointing to the [optional plugin descriptor file](plugin-configuration-file.html#additional-plugin-configuration-files):

```XML
<depends
    optional="true"
    config-file="myPluginId-optionalPluginName.xml">dependency.plugin.id</depends>
```

Note:

Additional plugin descriptor files must follow the naming pattern `myPluginId-$NAME$.xml` resulting in unique filenames to prevent problems with classloaders in tests ([Details](https://youtrack.jetbrains.com/issue/IDEA-205964)).

### Sample

The plugin adds additional highlighting for Java and Kotlin files.
The main `plugin.xml` defines a required dependency on the Java plugin (plugin ID `com.intellij.java`) and registers the corresponding `com.intellij.annotator` extension.
Additionally, it specifies an optional dependency on the Kotlin plugin (plugin ID `org.jetbrains.kotlin`):

`plugin.xml`

```XML
<idea-plugin>
   ...
   <depends>com.intellij.java</depends>

   <depends
       optional="true"
       config-file="myPluginId-withKotlin.xml">org.jetbrains.kotlin</depends>

   <extensions defaultExtensionNs="com.intellij">
      <annotator
          language="JAVA"
          implementationClass="com.example.MyJavaAnnotator"/>
   </extensions>
</idea-plugin>
```

The configuration file `myPluginId-withKotlin.xml` is located in the same directory as the main `plugin.xml` file.
In that file, the annotator extension for Kotlin is defined:

`myPluginId-withKotlin.xml`

```XML
<idea-plugin>
   <extensions defaultExtensionNs="com.intellij">
      <annotator
          language="kotlin"
          implementationClass="com.example.MyKotlinAnnotator"/>
   </extensions>
</idea-plugin>
```

