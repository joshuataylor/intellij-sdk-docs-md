# Theme Structure

Themes are components within [IntelliJ Platform plugins](plugin-structure.html).
The theme plugins should be stand-alone and not combined with other plugin functionality.

Note: Theme Plugin Sample

To see a full example theme project, see the [Theme Basics](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/theme_basics) in IntelliJ SDK Code Samples.

Themes have several components:

* A required Theme description (JSON) file in the plugin project's `resources` folder.

* A required `themeProvider` declaration in the plugin's `[plugin.xml](plugin-configuration-file.html)` file, located in the plugin project's `META-INF` folder.

* An optional Editor Scheme description (XML) file derived from an exported IDE editor scheme. This file is located in the plugin project's `resources` folder.

* An optional background image file, located in the plugin project's `resources` folder.

* Optional icon image files, located in the plugin project's `resources` folder.

![Theme Components](images/theme_components.png)

## Theme Description File

The most important file in every theme project is the theme description file.
The content of the default file generated with the [Theme wizard](creating-theme-project.html) is a short set of key–value pairs:

```JSON
{
  "name": "theme_basics",
  "author": "",
  "dark": false,
  "editorScheme": "/theme_basics.xml",
  "ui": {
  }
}
```

* `name` key matches the first portion of the Theme description `$THEME_NAME$.theme.json` file name. The value of `name` is displayed in the [Theme](https://www.jetbrains.com/help/idea/settings-appearance.html) Settings dropdown when the theme's plugin is installed in the IDE.

* `author` - specifies the theme author (empty by default).

* `dark` - determines the base theme (Light or Darcula) that is customized.

* `editorScheme` - specifies the editor scheme file that describes fonts and colors used in editors (see [Adding a Custom Editor Scheme](themes-extras.html#adding-a-custom-editor-scheme) for more details).

* `ui` - allows for overriding the base theme (Light or Darcula) properties (see [Custom UI Control Colors](themes-customize.html#custom-ui-control-colors) for more details).

The wizard also creates a `themeProvider` declaration in the [&lt;extensions&gt;](plugin-configuration-file.html#idea-plugin__extensions) section of the plugin's `plugin.xml` file.
This declaration binds the theme description file to a theme provider extension using a generated unique `id`.

```XML
<extensions defaultExtensionNs="com.intellij">
  <themeProvider
      id="eb9b7461-397b-4b98-a422-224fc0a74564"
      path="/theme_basics.theme.json"/>
</extensions>
```

Warning:

Do not modify or re-use an existing value of the generated `id` attribute.

## Theme Customization

The following sections describe the theme customization possibilities in detail:

* [Customizing Icons](themes-customize.html#customizing-icons)

* [Customizing UI Controls](themes-customize.html#customizing-ui-controls)

* [Adding a Custom Editor Scheme](themes-extras.html#adding-a-custom-editor-scheme)

* [Adding a Custom Background Image](themes-extras.html#adding-a-custom-background-image)

