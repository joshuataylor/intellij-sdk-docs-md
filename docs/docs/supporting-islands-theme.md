# Supporting Islands Theme

Follow these guidelines to convert an existing custom theme to an Islands theme.

## Defining the Parent Theme

Create Islands custom themes based on the default Islands themes.
To do that, define the parent theme at the beginning of the `*.theme.json` file.
An example for a dark custom theme:

```JSON
{
  "name": "Islands Custom Dark",
    "dark": true,
    "author": "Author Name",
    "editorScheme": "Islands Custom Dark",
    "parentTheme": "Islands Dark",
    "ui": {
    }
}
```

For a light theme, inherit from 'Islands Light'.

Here is the Dark Purple theme without and with inheritance from 'Islands Dark':

![Dark Purple theme without inheritance](images/islands_dark_purple_01.png)![Dark Purple theme with inheritance](images/islands_dark_purple_02.png)

## Hiding Sidebar Borders

In the Islands theme, there are no borders for the sidebars around the main window: the main toolbar, tool window stripes, and the status bar.

To hide the borders, set the following keys to a 100% transparent value:

```JSON
"StatusBar.borderColor": "#XXXXXX00",
"ToolWindow.Stripe.borderColor": "#XXXXXX00",
"MainToolbar.borderColor": "#XXXXXX00"
```

`00` at the end of a hex value sets a 100% transparent color.

The Dark Purple theme with transparent borders for sidebars:

![Dark Purple theme with transparent borders](images/islands_dark_purple_03.png)

## Main Background Colors

The main colors to change for the Islands theme are backgrounds of tool windows and the main window.

![A schematic look of the main window with keys for main background colors](images/islands_main_background_colors.png)
| Key |Recommendation |
-----------------------
| `ToolWindow.background`              `ToolWindow.Header.background`              `ToolWindow.Header.inactiveBackground`          |Use the same color as in the editor background, or a slightly lighter/darker color. |
| `MainWindow.background` |Dark theme: use a lighter color than the editor and tool windows background.               Light theme: use a darker color than the editor and tool windows background.               The recommended minimum contrast ratio of tool windows/editor to main window backgrounds is 1.20:1.          |

The Dark Purple theme with tool window and main window backgrounds set:

![Dark Purple theme with correct main background colors](images/islands_dark_purple_04.png)

## Islands Border Color

By design, island areas do not have a noticeable border color.
Set `Island.borderColor` to the same color as in `ToolWindow.background`.

The Dark Purple theme without visible borders for island areas:

![Dark Purple theme with correct islands border color](images/islands_dark_purple_05.png)

## Selected Tab Colors

The Islands theme has a new design for the selected tab:

![Comparison of new and old selected tab UI](images/islands_tabs.png)
Use the following keys to define selected tab colors.
The keys are applied to all tabs, not only the editor tabs.

| Property |State: Key |Description |
-------------------------------------
| Border |Selected:              `EditorTabs.underlinedBorderColor`               Selected inactive:              `EditorTabs.inactiveUnderlinedTabBorderColor`          |An existing color key. Previously, it was used for the bright tab underline. Leave the color value as is, or adjust if it appears too bright. |
| Background |Selected:              `EditorTabs.underlinedTabBackground`               Selected inactive:              `EditorTabs.inactiveUnderlinedTabBackground`          |A new color key for the background under the tab label. Provide a color that has enough contrast with the label. |

The background of the editor tab bar is defined with the `EditorTabs.background` key and should have the same color as the editor.

The Dark Purple theme with editor tabs background and tab colors defined:

![Dark Purple theme with correct selected tab color](images/islands_dark_purple_06.png)

## All Islands Keys

Below are all keys for the island areas.
If `parentTheme` is set to Islands Dark or Light, the default values are inherited.
The only exception is `Island.borderColor` which should be set manually.

| Key |Default value |Description |
-----------------------------------
| `Islands` |1 |Defines the theme as the Islands theme. |
| `Island.arc`              `Island.arc.compact`          |20              16          |Border radius of the islands. The value is 2x, the actual radius in the UI is 10 px. |
| `Island.borderWidth`              `Island.borderWidth.compact`          |5              4          |The distance between islands. The actual distance appearing in the UI is 1 px less. |
| `Island.borderColor` |Theme color |Supply the chosen value. It is recommended to use the same color as for `ToolWindows.background`. |
| `Island.inactiveAlpha` |0.44 |When the main IDE window is not in focus, to show the inactive state, all content "beneath" the islands is covered with an overlay with this transparency value. |

