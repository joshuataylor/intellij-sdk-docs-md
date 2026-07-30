# Working with Icons

<tldr>
Code: [AllIcons](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/ui/src/com/intellij/icons/AllIcons.java)

UI Guidelines: [Icons list](https://intellij-icons.jetbrains.design), [Icons](icons-style.html)

See also: [User Interface FAQ - Icons](ui-faq.html#icons)
</tldr>

Icons are used widely by IntelliJ Platform plugins.
Plugins need icons mostly for [actions](action-system.html), custom component renderers, [Tool Windows](tool-windows.html), etc.

Tip:

A [Plugin Logo](plugin-icon-file.html), which represents the plugin itself, has different requirements than icons used within plugins.

## Platform vs. Custom Icons

Plugins should reuse existing platform icons whenever possible.

Use the [Icons list](https://intellij-icons.jetbrains.design) to browse existing icons.
Platform icons are located in [AllIcons](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/ui/src/com/intellij/icons/AllIcons.java).
Icons from plugins are located in the corresponding `<PLUGIN_NAME>Icons` class (e.g., [GithubIcons](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/plugins/github/github-core/gen/org/jetbrains/plugins/github/GithubIcons.java)).

If custom icons are required, refer to detailed [design guide](icons-style.html).

## Organizing Icons

Tip:

See [Action Basics](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/action_basics) sample plugin as a reference.

In the case of a Gradle-based project, icons should be placed in the `resources` directory.
If the project is DevKit-based, the recommended approach is to put icons to a dedicated [source root](https://www.jetbrains.com/help/idea/content-roots.html) marked as Resources Root, e.g., `icons` or `resources`.

If the icons are referenced only in `[plugin.xml](plugin-configuration-file.html)` or via [@Presentation](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/ide/presentation/Presentation.java) `icon` attribute, then they can be [referenced by paths](#by-path).
In case the icons are referenced from the code and/or XML many times, it's convenient to organize them in an [icon holder class](#icons-class).

### Icons Class

Note:

Starting with 2021.2, the `*Icons` class is not required to be located in the `icons` package but can use the plugin's package:

`icons.MyIcons` → `com.example.plugin.MyIcons`.

Define a class/interface in a top-level package called `icons` holding icon constants as static fields:

Java:

```JAVA
package icons;

public interface MyIcons {
  Icon Action = IconLoader.getIcon("/icons/action.svg", MyIcons.class);
  Icon ToolWindow = IconLoader.getIcon("/icons/toolWindow.svg", MyIcons.class);
}
```

Kotlin:

When using Kotlin, fields must be annotated with `@JvmField`:

```KOTLIN
package icons

object MyIcons {
  @JvmField
  val Action = IconLoader.getIcon("/icons/action.svg", javaClass)
  @JvmField
  val ToolWindow = IconLoader.getIcon("/icons/toolWindow.svg", javaClass)
}
```

The `getIcon()` method of [IconLoader](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/ui/src/com/intellij/openapi/util/IconLoader.kt) can be used to access the icons.
The path to the icon passed in as argument to `IconLoader.getIcon()` must start with leading `/`.

## Using Icons

Icons defined inside `plugin.xml` with `icon` attribute for [&lt;action&gt;](plugin-configuration-file.html#idea-plugin__actions__action) or [extension point](plugin-extension-points.html),
as well as in [@Presentation](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/ide/presentation/Presentation.java) `icon` attribute, can be referenced in two ways.

### By Path

To reference an icon by path, provide the path relative to the resources directory, e.g., for icons located in `my-plugin/src/main/resources/icons` directory:

```XML
<actions>
  <action icon="/icons/myAction.svg" ... />
</actions>

<extensions defaultExtensionNs="com.intellij">
  <toolWindow icon="/icons/myToolWindow.svg" ... />
</extensions>
```

### By Icons Class

In the case of [icon holder class](#icons-class), reference the icon constants.
Note that if the class is located in the top-level `icons` package, the `icons` package name will be automatically prefixed and must not be specified.
In case of placing the class in a custom package, the full package name must be provided, e.g.:

```XML
<actions>
  <!-- referencing icons from 'MyIcons' class
       in top-level 'icons' package -->
  <action icon="MyIcons.MyAction" ... />
</actions>

<extensions defaultExtensionNs="com.intellij">
  <!-- referencing icons from 'MyIcons' in custom package -->
  <toolWindow icon="com.example.plugin.MyIcons.MyToolWindow" ... />
</extensions>
```

## Icon Files

The IntelliJ Platform supports HiDPI displays and comes with a bundled [dark theme](https://www.jetbrains.com/help/idea/user-interface-themes.html).
Thus, every icon should have a dedicated variant for dark theme and optionally for [HiDPI](#hidpi-version).
If the original icon works well enough in dark theme, a dark variant is not required.

The platform will load the best matching icon variant (if available) depending on the current environment.

### Icon Sizes

Required icon sizes depend on the usage as listed in the following table:

| Usage |Icon Size |
--------------------
| Node, Action, Filetype |16×16 |
| Tool window |13×13 |
| Tool window for [New UI](https://www.jetbrains.com/help/idea/new-ui.html) |20×20 and 16×16 (see [New UI Tool Window Icons](#new-ui-tool-window-icons)) |
| Editor gutter |12×12 |
| Editor gutter for [New UI](https://www.jetbrains.com/help/idea/new-ui.html) |14×14 |

As SVG icons can be scaled arbitrarily, they provide good results in HiDPI environments or when used in combination with
bigger screen fonts (e.g., in [Presentation Mode](https://www.jetbrains.com/help/idea/ide-viewing-modes.html)).

A base size denoting the size (in the user space) of the rendered image in 1x scale should be provided.
The size is set via the `width` and `height` attributes omitting the size units.
If unspecified, it defaults to 16×16 pixels.

A minimal SVG icon file:

```XML
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16">
  <rect width="100%" height="100%" fill="green"/>
</svg>
```

#### HiDPI Version

The icon graphics of such an icon can be expressed in more details via double precision.
If the icon graphics are simple enough so that it renders perfectly in every scale, then the HiDPI version can be omitted.
The HiDPI version should still provide the same base size.

### Filenames

All icon files must be placed in the same directory following this naming pattern:

| Theme/Resolution |Filename |Icon Size |
-----------------------------------------
| Light |`iconName.svg` |W×H |
| Dark |`iconName_dark.svg` |W×H |
| Light + [HiDPI](#hidpi-version) |`iconName@2x.svg` |2×W × 2×H |
| Dark + [HiDPI](#hidpi-version) |`iconName@2x_dark.svg` |2×W × 2×H |

## New UI Icons

Tip:

See [UI Kit](ui-kit.html) for guidelines and overview.

To fully support the [New UI](https://www.jetbrains.com/help/idea/new-ui.html), the plugin must provide additional dedicated icons and mapping information.
This allows supporting both UI variants at the same time, depending on what the user has selected.

Procedure: Setup

Tip:

Sample setup from the Python plugin:

* Icon resources root directory: [icons](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/python/pluginResources/icons)

* Mapping file: [PythonIconMappings.json](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/python/pluginResources/PythonIconMappings.json)

* Extension point registration (`<iconMapper mappingFile="MavenIconMappings.json"/>`): [intellij.python.community.impl.xml](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/python/pluginResources/intellij.python.community.impl.xml)

### Mapping Entries

All New UI icons must be mapped in the `$PluginName$IconMappings.json` mapping file.

For each New UI icon, add a mapping entry inside `expui` block.
Each directory starts a new block containing all its entries (see linked `MavenIconMappings.json` sample from above).

In this example, the icon root directory is named `icons`:

```JSON
{
  "icons": {
    "expui": {
      "dirName": {
        "icon1.svg": "icons/icon1.svg",
        "icon2.svg": "icons/icon2.svg"
      },
      "anotherDir": {
        "anotherIcon.svg": "images/anotherIcon.svg"
      }
    }
  }
}
```

If one new icon replaces several old icons, use a JSON list.
Example from [PlatformIconMappings.json](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/icons/src/PlatformIconMappings.json):

```JSON
"vcs.svg": [
  "toolwindows/toolWindowChanges.svg",
  "vcs/branch.svg"
]
```

### New UI Tool Window Icons

The New UI uses outlined icons for tool windows that have a size of 20×20 pixels and 16×16 pixels in
[Compact Mode](https://www.jetbrains.com/help/idea/new-ui.html#compact-mode).
To provide all necessary variants of a tool window icon use the following filename scheme:

| Theme/Mode |Filename |Icon Size |
-----------------------------------
| Light |`toolWindowIcon@20x20.svg` |20×20 |
| Dark |`toolWindowIcon@20x20_dark.svg` |20×20 |
| Light + Compact Mode |`toolWindowIcon.svg` |16×16 |
| Dark + Compact Mode |`toolWindowIcon_dark.svg` |16×16 |

### New UI Icon Colors

To work as expected, the New UI requires specific colors for icon content.
This is necessary for situations where tool window buttons are active, during which the background is highlighted.
To enhance contrast, the IntelliJ Platform dynamically alters the icon's content color to white.

Hence, for the creation of light and dark mode variants, plugin authors must use the following
prescribed colors within their icons:

| Theme |Color Code |
---------------------
| Light |`#6C707E` ▆ |
| Dark |`#CED0D6` ▆ |

Note:

Various online resources, like the UI Guidelines
[here](tool-window.html) and
[here](icons-style.html#grid-and-size),
will be updated soon and currently don't include information about the New UI.

## Animated Icons

<tldr>
UI Guidelines: [Loader](loader.html)
</tldr>

Animated icons are a way to show that a plugin is now performing some long-time action, e.g., when the plugin is loading some data.

Any animated icon is a set of frames that loop with a delay.

To create a new animated icon, use the
[AnimatedIcon](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/ui/AnimatedIcon.java).
To create an icon where frames follow each other with the same delay, use a constructor that accepts a delay and icons:

```JAVA
AnimatedIcon icon = new AnimatedIcon(
    500,
    AllIcons.Ide.Macro.Recording_1,
    AllIcons.Ide.Macro.Recording_2);
```

To create an icon from frames with different delays, use `AnimatedIcon.Frame`.
Each frame represents an icon, and a delay until the next frame.

Tip:

Set [AnimatedIcon.ANIMATION_IN_RENDERER_ALLOWED](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core/src/com/intellij/ui/AnimatedIcon.java) client property to `true` for list, table,
and tree components to repaint animated icons automatically.
See its Javadoc for details.

### Progress Icon

Use the predefined `AnimatedIcon.Default` loader icon to indicate a long process.
This icon has a larger `AnimatedIcon.Big` version.

Alternatively, use [AsyncProcessIcon](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/util/ui/AsyncProcessIcon.java).

## Icon Tooltips

Register a resource bundle via [com.intellij.iconDescriptionBundle](https://jb.gg/ipe?extensions=com.intellij.iconDescriptionBundle) extension point
to provide tooltips automatically for all [SimpleColoredComponent](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ui/SimpleColoredComponent.java) renderers.

Create `icon.<icon-path>.tooltip` key in the resource bundle, where `<icon-path>` is the icon path with leading slash and `.svg` removed and slashes replaced with dots:

`/nodes/class.svg` → `icon.nodes.class.tooltip`

