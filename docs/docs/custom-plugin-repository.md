# Custom Plugin Repository

<tldr>
Product Help: [Repository Settings](https://www.jetbrains.com/help/idea/managing-plugins.html#repos)
</tldr>

Tip: JetBrains IDE Services: IDE Provisioner

[IDE Provisioner](https://www.jetbrains.com/ide-services/ide-provisioner/) comes with a local built-in repository of IntelliJ Platform plugins
that allows choosing specific plugins to be approved within an organization.
It also allows uploading and distributing private plugins inside an organization, as well as any publicly available plugin from the internet.

To use a plugin repository other than the [JetBrains Marketplace](https://plugins.jetbrains.com), perform the following steps:

Procedure: Setting Up Custom Plugin Repository

Tip: Automating Deployment

Gradle plugin [IntelliJ plugin uploader](https://github.com/brian-mcnamara/plugin_uploader) can be used to automate deployment.

To avoid collisions between private plugins and those hosted on JetBrains Marketplace, an organization can [reserve plugin IDs](https://plugins.jetbrains.com/docs/marketplace/reserved-plugin-ids.html).

To provide custom authentication, implement [PluginRepositoryAuthProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/ide/plugins/auth/PluginRepositoryAuthProvider.java)
registered in [com.intellij.pluginRepositoryAuthProvider](https://jb.gg/ipe?extensions=com.intellij.pluginRepositoryAuthProvider) extension point
.

## 

Describing Plugins in `updatePlugins.xml` File

Every custom plugin repository must have at least one `updatePlugins.xml` file to describe every hosted plugin's latest available version.
The description in `updatePlugins.xml` is used by JetBrains IDEs to locate plugins by attributes such as identifier, IDE version, and plugin version.
These attributes are displayed by JetBrains IDEs to help users select or upgrade plugins.
The description also tells the JetBrains IDE where to download the plugin itself.

A custom plugin repository's `updatePlugins.xml` file is constructed and maintained by the repository administrator.
More than one `updatePlugins.xml` file may be required if the custom repository consumers are using more than one version of a JetBrains IDE.
For example, `updatePlugins-182.xml`, `updatePlugins-183.xml` for IntelliJ IDEA 2018.2 and 2018.3, respectively.
Each `updatePlugins-*.xml` file will have a unique URL that is added to the JetBrains IDE [Repository Settings](https://www.jetbrains.com/help/idea/managing-plugins.html#repos).

### 

Format of `updatePlugins.xml` File

The format of an `updatePlugins.xml` file is simply a list of sequential elements that describe each plugin:

```XML
<?xml version="1.0" encoding="UTF-8"?>
<!--
The <plugins> element (required) contains the description of the plugins
available at this repository.
-->
<plugins>
  <!--
  Each <plugin> element (required) describes one plugin in the repository.
  Attributes:
   - "id" (required) - used by JetBrains IDEs to uniquely identify
     a plugin. Must match <id> in the plugin.xml file.
   - "url" (required) - URL to download the plugin JAR/ZIP file.
     Must be HTTPS.
   - "version" (required) - version of this plugin. Must match <version>
     in the plugin.xml file.
  -->
  <plugin
          id="fully.qualified.id.of.this.plugin"
          url="https://mycompany.example.com/my_repo/my_plugin.jar"
          version="major.minor.update">
    <!--
    The <idea-version> element (required) must match the same element
    in the plugin.xml file.
    -->
    <idea-version since-build="181.3" until-build="191.*"/>
  </plugin>
  <plugin
          id="id.of.different.plugin"
          url="https://othercompany.example.com/other_repo/other_plugin.jar"
          version="major.minor">
    <idea-version since-build="181.3" until-build="191.*"/>
  </plugin>
  <!-- And so on for other plugins... -->
</plugins>
```

Notes:

* An `updatePlugins.xml` file must contain at least one `<plugin>` element.

* A plugin `id` may be listed only once in an `updatePlugins.xml` file.

* Multiple plugins with the same `id` but different `idea-version` attributes must be split into separate `updatePlugins-*.xml` files. The requesting IDE's version is passed as `build` parameter and can be used for server-side filtering.

### 

Optional `updatePlugin.xml` Elements

<tldr>
Reference: [Plugin Configuration File](plugin-configuration-file.html)
</tldr>

During plugin installation, the IDE reads the plugin JAR/ZIP file and thereafter displays more information about the plugin.
In some cases, additional information included in `updatePlugins.xml` might help a user select a plugin when [browsing the custom plugin repository](https://www.jetbrains.com/help/idea/managing-plugins.html#repos) before installation.
The decision on what elements should be included in the file depends on the plugins and repository consumers.
It is recommended to avoid adding unnecessary elements as they will have to be synchronized with each plugin's `[plugin.xml](plugin-configuration-file.html)` file.

The additional candidate elements:

|              Element          |             Effects & Requirements          |
-------------------------------------------------------------------------------
|               ```XML <name>   My Plugin Name </name> ```            |             By default, the name of the plugin JAR/ZIP file is displayed before installation.               Using the `<name>` element displays the name of the plugin.               Contents should match the [&lt;name>](plugin-configuration-file.html#idea-plugin__name) element contents in the plugin's `plugin.xml` file to avoid confusion.            |
|               ```XML <description>   My plugin is awesome </description> ```            |             By default, no description for the plugin is displayed before installation.               Using the `<description>` element will cause a description to be displayed before installation.               Contents should match the [&lt;description>](plugin-configuration-file.html#idea-plugin__description) element contents in the plugin's `plugin.xml` file to avoid confusion.               Optionally, an enclosing `<![CDATA[ ]]>` element can be used if the description needs to contain HTML tags.            |
|               ```XML <change-notes>   Added cool feature </change-notes> ```            |             By default, no change notes for the plugin are displayed before installation.               Using the `<change-notes>` element will cause a description of changes to be displayed before installation.               Contents should match the [&lt;change-notes>](plugin-configuration-file.html#idea-plugin__change-notes) element contents in the plugin's `plugin.xml` file to avoid confusion.               Optionally, an enclosing `<![CDATA[ ]]>` element can be used if the change notes need to contain HTML tags.            |
|               ```XML <depends>   dependency.plugin.id </depends> ```            |             Adding a plugin dependency in the `<depends>` element will cause asking a user about enabling the dependency plugin, if it is installed and disabled in the IDE. A plugin can specify multiple `<depends>` elements.               A plugin entry should include only the dependencies on other plugins that are defined by the [&lt;depends>](plugin-configuration-file.html#idea-plugin__depends) elements in the plugin's `plugin.xml` file. The `optional` and `config-file` attributes are ignored and shouldn't be specified.            |

