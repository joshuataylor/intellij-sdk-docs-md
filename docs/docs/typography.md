# Typography

<tldr>
Implementation: [JBFont](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/util/ui/JBFont.java)
</tldr>

## UI font

[Inter](https://github.com/rsms/inter) is used for the IDE user interface by default. The default font size is the same for all supported OS: 13.

Users can change the default font in Settings | Appearance. If the default font size is changed, other font sizes used in the UI are scaled respectively.

Use the built-in text styles from the table below whenever possible.

Note:

Implementation example for font styles: [LabelSizeDemoAction](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/devkit-core/src/internal/ui/LabelSizeDemoAction.kt)

|  Font  | Font size  | Usage Examples  |
-----------------------------------------
|  H1 `JBFont.h1().asBold()`   | Default +5  |         Main page header. Example: Plugin name      |
|  H2 `JBFont.h2().asBold()`   | Default +3  |         Small page header. Example: Headers in a plugin description      |
|  Default `JBFont.regular()`   | Default  |         Main UI font. Examples: Labels, inputs, links, trees, tables, and other controls      |
|  Default semibold  `JBFont.regular().asBold()`    | Default  |         Header in dialogs, popups, notifications, tool windows, Got It tooltips        |
|  Paragraph  |          Default            Line height default +3        |         Multiline description text      |
| Medium `JBFont.medium()`   |Default –1 |         Help text      |
|  Medium semibold `JBFont.medium().asBold()`    |Default –1 |         Group headers in popups      |

If none of the built-in sizes work and a custom one is needed, define it as the default size +/- constant value. Do not hardcode font sizes.

### Examples in UI

Run popup:

![Typography example 1](images/typography_example_1.png)
Plugin page:

![Typography example 2](images/typography_example_2.png)

## Editor font

[JetBrains Mono](https://fonts.google.com/specimen/JetBrains+Mono) font is used by default for the Editor.

|  Name  | Font size  | Usage  |
--------------------------------
|  Default  | Default  | Code in the editor, code snippets, completion popup, and documentation popup  |
|  Small  | Default –1  | Line number in the editor |

Users can change the editor font in Editor | Color scheme | Color Scheme Font. If the default font size is changed, other font sizes used in the editor are scaled respectively.

### Examples in editor

Line numbers in the gutter and code in the editor:

![Typography example 4](images/typography_example_4.png)
Editor font and paragraph UI font in the documentation popup:

![Typography example 5](images/typography_example_5.png)

