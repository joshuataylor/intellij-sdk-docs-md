# Creating a Theme Project

This documentation page describes a DevKit-based theme project generated with the [New Project Wizard](https://www.jetbrains.com/help/idea/new-project-wizard.html).

## Creating a Theme with New Project Wizard

Tip:

Before creating a theme project, make sure that [development environment is set up](setting-up-theme-environment.html).

Procedure: Create Theme Plugin

### Components of a Wizard-Generated Gradle IntelliJ Platform Theme

For the example `my_theme` created with the steps describes above, the IDE Plugin generator creates the following directory content:

```PLANTUML
@startuml

skinparam TitleFontName JetBrains Sans
skinparam TitleFontStyle plain
skinparam TitleFontSize 16
skinparam DefaultTextAlignment left

title
  my_theme
  |_ resources
    |_ META-INF
      |_ plugin.xml // (Plugin Configuration File) //
      |_ pluginIcon.svg // (Plugin Logo) //
      |_ ...
    |_ theme
      |_ my_theme.theme.json // (Theme description file) //
  |_ my_theme.iml // (IntelliJ IDEA Module configuration file) //
end title
@enduml
```

`META-INF` directory with:

* `[plugin.xml](plugin-configuration-file.html)` configuration file containing preconfigured theme provider

* `pluginIcon.svg` file that is a [plugin logo](plugin-icon-file.html) Replace it with a custom logo representing the Theme.

* `my_theme.theme.json` - a minimal [theme description file](themes-customize.html#theme-description-file-syntax)

* `my_theme.iml` - [IntelliJ IDEA Module](https://www.jetbrains.com/help/idea/creating-and-managing-modules.html) configuration file

See [Theme Structure](theme-structure.html) for more details.

## Additional Plugin Themes

Theme plugin project [created with the new project wizard](#create-theme) contains a single theme description file by default.
In case a plugin needs to provide multiple themes (e.g., dark and light variants), it is possible to add them with the dedicated action.

Additional plugin themes can be added using the DevKit Theme Wizard, which is a part of the Plugin DevKit plugin.
The wizard can be used for both DevKit-based and Gradle-based plugins.

Procedure: Add Theme

## Bundling Color Schemes

Use [com.intellij.bundledColorScheme](https://jb.gg/ipe?extensions=com.intellij.bundledColorScheme) extension point
specifying the `path` to the color scheme XML file (without `.xml` suffix).
Specify attribute `id` for this extension in `plugin.xml` matching its `name` attribute value from the color scheme XML.

