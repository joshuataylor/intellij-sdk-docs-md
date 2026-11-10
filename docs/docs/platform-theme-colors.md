# Platform Theme Colors

There are two default color themes: IntelliJ Light and Darcula.

![01 default themes](images/01_default_themes.png)

Use the colors consistently within the default themes. To do so, follow these guidelines:

* [Icons](icons.html)

* UI components

* Editor scheme TBD

* Chart TBD

## UI components

Colors for UI components are specified with color keys.
A color key is a name of a color property in a particular component, e.g. `ComboBox.background`, or a generic color property for several components, e.g. `Component.borderColor`.

![02 keys naming](images/02_keys_naming.png)
Color keys of a combo box

Each key has two default color values: one for IntelliJ Light and another for Darcula. Example: `ComboBox.background` is #FFFFFF in IntelliJ Light and #3C3F41 in Darcula.

Keys allow creating [custom color themes](themes-getting-started.html). A custom theme is one of the default themes plus a set of color keys with new values in a JSON file. Example: the High contrast theme is a custom theme based on Darcula. New color values are stored in the [HighContrast.theme.json](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-resources/src/themes/HighContrast.theme.json) JSON file.

See custom themes in the [JetBrains Marketplace](https://plugins.jetbrains.com/search?tags=Theme) repository.

See the meanings of the parts in a color key in the [key naming scheme](themes-metadata.html#key-naming-scheme).

See a complete list of keys with their descriptions in the JSON files: [IntelliJPlatform.themeMetadata.json](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-resources/src/themes/metadata/IntelliJPlatform.themeMetadata.json), [JDK.themeMetadata.json](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-resources/src/themes/metadata/JDK.themeMetadata.json).

See the color values for the currently selected theme in the LaF Defaults dialog:

Tip:

To store color values between theme switching, use a scratch `*.theme.json` file.
This might be useful for testing colors before implementing them.
See guidelines for the [Theme JSON Structure](themes-customize.html#defining-named-colors).

* The dialog is available in the [internal mode](enabling-internal.html). See `Tools | Internal Actions | UI` in the main menu or find it with Help | Find Action.

* Some color keys are not shown in the dialog by default because they are loaded at runtime with a corresponding UI component. Open the UI with this component to see such keys in the dialog.

* Edit a color in the dialog to preview it in the IDE. The edited color is stored until the theme is switched.

![03 la f defaults](images/03_LaF_Defaults.png)
Note:

For IntelliJ designers:

* Provide color keys in design specifications to be sure that the correct keys are used.

* When a new key is implemented, check that [IntelliJPlatform.themeMetadata.json](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-resources/src/themes/metadata/IntelliJPlatform.themeMetadata.json) has the new key with the `since` parameter and description, and the old keys are deprecated.

If a color is needed:

1. Choose a color value for all default themes:

* Try reusing any of the existing colors first. Use the LaF Defaults dialog to see the existing colors.

* If none of them fit, choose two new color values that are consistent with IntelliJ Light and Darcula palettes in hue and contrast.

1. Choose a color key if a component does not have it:

* Use an existing color key if it fits semantically. Otherwise, a UI component might get an unexpected color in a custom color theme.

* Create a new key if none of the existing ones fit semantically. Follow the naming scheme.

Example

Incorrect: A new component with a light-blue background reuses `Focus.borderColor`, which has a light-blue color in the default themes. A theme author decides they need a bright focus border and changes the color value for `Focus.borderColor`. As a result, the new component has a bright background with the text unreadable over it.

Correct: A new component with a light-blue background has its own color key `ComponentName.background`.

Implementation
Use `JBColor.namedColor` to set a color key and fallback color values:

Kotlin:

```KOTLIN
val SELECTED_BACKGROUND_COLOR: Color =
    JBColor.namedColor(
        "CompletionPopup.selectionBackground",
        JBColor(0xc5dffc, 0x113a5c)
    )
```

Java:

```JAVA
private static final Color SELECTED_BACKGROUND_COLOR =
    JBColor.namedColor(
        "CompletionPopup.selectionBackground",
        new JBColor(0xc5dffc, 0x113a5c)
    );
```

