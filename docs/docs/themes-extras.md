# Themes - Editor Schemes and Background Images

Themes can also provide custom color and font settings, as well as custom images for display in the IDE application window.

Note: Theme Plugin Sample

To see a full example theme project, see the [Theme Basics](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/theme_basics) in IntelliJ SDK Code Samples.

## Adding a Custom Editor Scheme

Users of IntelliJ Platform-based IDEs, such as IntelliJ IDEA, can set preferences to configure the colors and fonts used in the Editor.
These custom color and font settings are called Editor Color Schemes.

### Creating a Custom Editor Scheme Using Settings

Custom editor color schemes can be specified and exported using the IDE `Settings` dialog.
Note that editor [Colors and Fonts](https://www.jetbrains.com/help/idea/configuring-colors-and-fonts.html), and [Colors for Version Control File Status](https://www.jetbrains.com/help/idea/file-status-highlights.html) are customized in different sections of `Settings`.

Use the following procedure to customize an editor color scheme for a theme:

* Create the desired custom editor color scheme using the IDE preferences.

* Export the custom editor color scheme to the desired file name. In this example, the file is exported to `Lightning.icls`.

* Once exported, change the file extension from `*.icls` to `*.xml`. In this example, the result is `Lightning.xml`.

* See [Customizing Editor Scroll Bar Colors](#customizing-editor-scroll-bar-colors) to change the colors of editor scroll bars.

### Incorporating the Editor Color Scheme in the Custom Theme

The next step is to add the color scheme to the theme plugin project:

* Replace the default generated custom editor color scheme XML file (in this example, `theme_basics.xml`) in the project's `resources` folder with the exported custom editor color scheme. In this case, the action is to replace `theme_basics.xml` with `Lightning.xml`.

* In the theme file (in this example `theme_basics.theme.json`), replace the name of the generated editor scheme file (`theme_basics.xml`) with the new (`Lightning.xml`) file name. The `key` is always "editorScheme". The `value` is the name of the editor color scheme file.

The example below adds an editor scheme named "Lightning" to the Theme Basics custom theme:

```JSON
{
  "name": "Theme Basics",
  "dark": false,
  "author": "IntelliJ Platform SDK",
  "editorScheme": "/Lightning.xml",
  "ui": {
  }
}
```

### Editor Color Scheme XML Files

When an editor color scheme is exported as a file, the color options appear as `name`-`value` attributes of `option` elements.
The `name` is the aspect of the editor to be changed, and the `value` is the new color in six-digit RGB or eight-digit RGBA hexadecimal notation.
For example, the snippet below sets the color of the line numbers displayed in the editor:

```XML
<colors>
  <option name="LINE_NUMBERS_COLOR" value="999999"/>
</colors>
```

For additional examples of `name` and `value` attributes, review the editor color scheme XML file for the [High Contrast editor scheme](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-resources/src/themes/highContrastScheme.xml).

### Customizing Version Control File Status Colors

As [described above](#creating-a-custom-editor-scheme-using-settings), colors corresponding to the VCS status of files can be customized and exported via the [Settings](https://www.jetbrains.com/help/idea/file-status-highlights.html).
No other procedure is necessary to customize these colors.
In the exported color scheme file, the `name` is the VCS file status, and the `value` is the new color corresponding to that status.
For example, customized VCS colors for a subset of file statuses will appear in the editor scheme file as:

```XML
<colors>
  <option name="FILESTATUS_ADDED" value="62cc47"/>
  <option name="FILESTATUS_COPIED" value="62cc47"/>
  <option name="FILESTATUS_DELETED" value="ed864a"/>
</colors>

```

For additional examples of `FILESTATUS` color `name` attributes, see the editor color scheme XML file for the [High Contrast editor scheme](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-resources/src/themes/highContrastScheme.xml).

### Customizing Editor Scroll Bar Colors

Editor scroll bar colors should be coordinated with and switch together with an editor color scheme.
Please note that custom theme (`*.theme.json`) files also contain `ScrollBar.*` name attributes, but these are for scroll bars outside the context of the editor.

Note:

The Editor Scroll Bar colors are the only editor scheme settings that cannot be customized and exported through IDE preferences.

Customizing the editor scroll bar colors requires manually changing an editor color scheme XML file.
At this time there isn't code completion functionality for changing custom color editor scheme XML files, so the `name` attributes are described below.

#### Editor Scroll Bar Attribute Name Format

The typical format of a scroll bar `name` attribute is `ScrollBar.usage`, where `usage` describes where the color is to be applied.
In some cases `usage` itself can be compound such as `ScrollBar.Mac.Transparent.thumbColor`.
In these compound cases, the last portion of the compound `usage` still describes where the color is to be applied.

Note that the following example snippet uses an eight-digit hexadecimal color `value` to give `ScrollBar.Mac.thumbColor` transparency:

```XML
<color>
  <option name="ScrollBar.Mac.trackColor" value="000000"/>
  <option name="ScrollBar.Mac.thumbColor" value="FFFFFFBE"/>
</color>
```

#### Editor Scroll Bar Attribute Names

A list of scroll bar `name` attributes is in the [High Contrast editor scheme](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-resources/src/themes/highContrastScheme.xml) file.
These name attributes cannot be accessed from anywhere in the IDE UI at this time, so they must be manually added to an editor color scheme XML file.

The following list explains the `usage` format of the `name` attribute, i.e., where a custom scroll bar color is applied:

* `*.trackColor` - The scroll bar thumb moves across this area. At this time the vertical scrollbar track color and transparency cannot be customized.

* `*.thumbColor` - The movable rectangle that corresponds to the visible content's size.

* `*.thumbBorderColor` - The thumb border.

* `*.hoverTrackColor` - Same `usage` as above but for hover. At this time the vertical scrollbar hover track color and transparency cannot be customized.

* `*.hoverThumbColor` - Same `usage` as above but for hover.

* `*.hoverThumbBorderColor` - Same `usage` as above but for hover.

The `name` attribute patterns are enumerated below.

Platform Independent Name Attributes

The horizontal scroll bar background color is set by `ScrollBar.background`.
This background color is visible only if the horizontal scroll bar's `*.trackColor` has transparency.

At this time, the vertical scrollbar background color cannot be customized.

Windows/Linux Name Attributes

The `name` attributes for Windows and Linux scroll bars have the pattern `ScrollBar.Transparent.*`, where the wildcard portion corresponds to the `usage` definitions above.

macOS Name Attributes

The `name` attribute pattern for the vertical scroll bar is `ScrollBar.Mac.*`.

The `name` attribute pattern for the horizontal scroll bar depends on the macOS preferences Show scroll bars setting:

* `ScrollBar.Mac.*` when the Always setting is selected.

* `ScrollBar.Mac.Transparent.*` when the When scrolling setting is selected.

The wildcard portion of these patterns corresponds to the `usage` definitions above.

## Adding a Custom Background Image

The IDE supports setting an image as a background in the application window.
Users can do this manually in [Settings](https://www.jetbrains.com/help/idea/setting-background-image.html).

Themes support specifying a background image as a key-value pair in the `"background": {}` (for editor and tools) and `"emptyFrameBackground": {}` (for empty frame) sections of a Theme description file:

* The `image` key uses the file name of the image as the value. The background image is placed in the theme plugin project's `resources` folder.

* The `transparency` key uses a `value` of 1–100. A `value` of 100 is opaque.

* The `fill` key uses a value of `scale`, meaning to expand the image to fill the space as the window gets resized.

* The `anchor` key uses a value of `center`, meaning to locate the center of the image in the center of the window.

The following example adds an image of the Austrian countryside to the Theme Basics Theme description file:

```JSON
{
  "name": "Theme Basics",
  "dark": false,
  "author": "IntelliJ Platform SDK",
  "ui": {
  },
  "background": {
    "image": "/austria.png",
    "transparency": 10,
    "fill": "scale",
    "anchor": "center"
  },
  "emptyFrameBackground": {
    "image": "/austria.png",
    "transparency": 20,
    "fill": "scale",
    "anchor": "center"
  }
}
```

