# Drop-Down List

<tldr>
Implementation: [ComboBox](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/ComboBox.java)
</tldr>

A drop-down list is a control that displays a list of choices on click and allows selecting one option.

![Example of a Theme drop-down with options: Light (selected in light), Dark (selected in dark), Light with Light Header, High Contrast, Darcula, and an option to get more themes](images/dropdown.png)

## When to use

### Single option

Use when a single option should be selected.

![Interface language drop-down with options: English (selected), German, Dutch, Chinese (Simplified), and an option to get more languages](images/dropdown_when_to_1.png)
When multiple selections are possible, use [checkboxes](checkbox.html).

### Options are objects or states

The possible choices are objects or states.

![Output level drop-down with options: Debug, Info (selected), Warn, Error, and Warning](images/dropdown_when_to_2.png)
When options are actions, use a menu or a [split button](split-button.html).

### More than four options

The number of options is more than four.

![Regions drop-down with options: Africa, Americas, Asia except China Mainland, Europe (selected), Middle East, Oceania](images/dropdown_when_to_3.png)
When there are four options or fewer, use [radio buttons](radio-button.html).

### Space is limited

The screen space is limited, so there is not enough room for [radio buttons](radio-button.html).

![Settings | Appearence dialog that has a complex layout with multiple drop-downs: Theme, Zoom, and Custom font](images/dropdown_when_to_4.png)

### Default value is the most used

The default value is recommended for most users. A drop-down is a good way to hide unpopular alternatives.

In the example below a drop-down is used because Subpixels is the most popular choice. Using [radio-buttons](radio-button.html)  puts all options on the same level of importance or popularity.

![Antialiasing drop-down with options: Subpixels (selected), Greyscale, Not antialiasing](images/dropdown_when_to_5.png)

### Combined controls

If a control combines various UI elements as one setting, use a drop-down even if there are four options or fewer:

![Combined control with a checkbox 'Automatically check updated for' and a drop-down with 'Early access program' selected, following by a button 'Check now'](images/dropdown_when_to_6.png)

## When not to use

### Four or less options

If there are four options or fewer, use [radio buttons](radio-button.html).

|        Correct       !['Open project in' radio group with options: 'New window', 'Current window', and 'Ask'](images/dropdown_when_not_to_3_correct.png)      |       Incorrect       !['Open project in' drop-down with options: 'New window' (selected), 'Current window', and 'Ask'](images/dropdown_when_not_to_3_incorrect.png)      |

### Multiple selection

If multiple selection is possible, use [checkboxes](checkbox.html).

|        Correct       !['UI Options' checkbox group with options: 'Smooth scrolling' (checked), 'Display icons in menu items' (checked), and 'Enable mnemonics in menu'](images/dropdown_when_not_to_1_correct.png)      |       Incorrect       !['UI Options' drop-down with options: 'Smooth scrolling' (checked), 'Display icons in menu items' (checked), and 'Enable mnemonics in menu'](images/dropdown_when_not_to_1_incorrect.png)      |

For a [single selection](#single-option) use a drop-down.

### List of actions

If there is a list of actions, use a menu or a [split button](split-button.html).

|        Correct       ![Split-button 'Commit' and options: 'Commit and Push', 'Commit and Push Silently' (focused), and 'Create Patch'](images/dropdown_when_not_to_2_correct.png)      |       Incorrect       ![Drop-down 'Commit' with options: 'Commit' (focused), 'Commit and Push', 'Commit and Push Silently', and 'Create Patch'](images/dropdown_when_not_to_2_incorrect.png)      |

For a list of [objects or states](#options-are-objects-or-states), use a drop-down.

### Adding values

If users may need to enter a value not currently in the list, use a [combo box](combo-box.html).

|        Correct       ![A combo box for selecting font size and entering a custom value is open, displaying options ranging from 20 to 72. The current selection is 20](images/dropdown_when_not_to_4_correct.png)      |       Incorrect       ![A dropdown menu for selecting font size is open, displaying options ranging from 20 to 72. The current selection is 20](images/dropdown_when_not_to_4_incorrect.png)      |

### On a toolbar

If a drop-down appears on a toolbar, use [toolbar drop-down](toolbar-drop-down.html) instead.

|        Correct       ![Run/debug widget in the main toolbar with multiple icon buttons, and a toolbar drop-down with selected 'StandAlone' option](images/dropdown_when_not_to_5_correct.png)      |       Incorrect       ![Run/debug widget in the main toolbar with multiple icon buttons, and a drop-down with selected 'StandAlone' option](images/dropdown_when_not_to_5_incorrect.png)      |

## How to use

### Label

Follow the rules for the [input field](input-field.html#label).

![Drop-down menu labeled 'Placement' with the selected option set to 'Left'.](images/dropdown_how_to_1.png)

### Default value

Select the most likely or the safest value by default. In the example below the safest value is Ask, the behavior will not be unexpected to users:

![Drop-down menu labeled 'Insert imports on paste' with options 'All', 'Ask', and 'None'. The selected option set to 'Ask'.](images/dropdown_how_to_2.png)
Do not use an empty value as the default value. If no values are added to a drop-down yet, replace it with a button to add values.

|        Correct       ![Secondary button 'Add Settings Repository' which opens a dialog](images/dropdown_how_to_3_correct.png)      |       Incorrect       ![Drop-down 'Repository' with no selected option](images/dropdown_how_to_3_incorrect.png)      |

### Menu items

#### Capitalization

Use [sentence-style capitalization](capitalization.html#sentence) for each menu item.

|        Correct       ![Drop-down menu labeled 'Default browser' with options 'System default', 'First listed', and 'Custom path'. The selected option set to 'System default'](images/dropdown_how_to_4_correct.png)      |       Incorrect       ![Drop-down menu labeled 'Default browser' with options 'System Default', 'First Listed', and 'Custom Path'. The selected option set to 'System Default'](images/dropdown_how_to_4_incorrect.png)      |

#### No repeated words in items

Avoid repeating words in drop-down list items. Move repeating words to the label or after the drop-down.

|        Correct       ![Drop-down menu labeled 'Refresh every \[selection\] minutes' with options '10', '15', and '30'. The selected option set to '10'](images/dropdown_how_to_5_correct.png)      |       Incorrect       ![Drop-down menu labeled 'Refresh every' with options '10 minutes', '15 minutes', and '30 minutes'. The selected option set to '10 minutes'](images/dropdown_how_to_5_incorrect.png)      |

#### Sorting items

Sort items in one of the following orders:

|        ![Drop-down menu labeled 'Placement' with options 'Left', 'Top', 'Right', and 'Bottom'. The selected option set to 'Top'](images/dropdown_how_to_6_1.png)      |       Logical order, for example, in a spatial relationship.        |
|        ![Drop-down menu labeled 'Global SQL dialect' with options '<None>', '<Generic SQL>', 'ClickHouse', 'DB2', 'Derby', 'Exasol', and other options available when scrolling. The selected option set to '<None>'](images/dropdown_how_to_6_2.png)      |       Alphabetical or numeric order if the options are equivalent to make it easier to find items.        |
|        ![Drop-down menu labeled 'Global encoding' with multiple options grouped in two groups and divided: popular options and the rest](images/dropdown_how_to_6_3.png)      |       Place the most common options first. If there are more than 10 options, separate the most popular options with a line.         Sort the remaining items in alphabetical or numeric order.        |

#### Grouping

Group related items using separators. Add group headers if possible.

|              With dividers             ![Drop-down menu labeled 'Version' with options ranging from 1.5 to 1.9, and a meta-option 'Same as language version'](images/dropdown_how_to_7_1.png)          |             With a divider and group headers             ![Drop-down menu labeled 'Scheme' with two groups of options that have group titles and divided by a divider'](images/dropdown_how_to_7_2.png)          |

#### Actions related to a drop-down

If there are actions related to the drop-down, put them under the gear icon on the right:

![Drop-down menu 'Color Scheme' followed by a Settings icon-button related to the drop-down](images/dropdown_how_to_8.png)

#### Meta-options

Note:
Meta-option is a special choice that controls how selections behave rather than being a specific value.

Enclose meta-options in pointy brackets and place them at the beginning of the list when they're important or popular options. In other cases, place them at the end of the list.

![Drop-down menu labeled 'Run tests with' with options 'Platform test runner', 'Gradle test runner', and ''. The selected option set to ''](images/dropdown_how_to_9.png)
Do not assign special meanings to numeric or string values, use meta-options instead. It can be unclear that either 0 or an empty string are used to disable an option.

|              Correct             ![Drop-down menu labeled 'Version' with options ranging from 1.5 to 1.9, and a meta-option 'Same as language version'](images/dropdown_how_to_10_correct.png)          |             Incorrect             ![Drop-down menu labeled 'Version' with options ranging from 1.5 to 1.9, and an option '0'](images/dropdown_how_to_10_incorrect.png)          |

#### 'None' in simple layouts

Replace the <None> option with a checkbox if it doesn't make the layout more complex.

|              Correct             ![Checkbox 'Show close button at' followed by two radio buttons 'Right' and 'Left'](images/dropdown_how_to_11_correct.png)          |             Incorrect             ![Drop-down 'Close button position' with options 'Left', 'Right', '<None>'. The selected options is '<None>'](images/dropdown_how_to_11_incorrect.png)          |

#### Use icons and font formatting

|        ![Drop-down 'Run on' with multiple options that have icons related to their meanings](images/dropdown_how_to_12_1.png)      |       Add icons to the values if they're well-known.        |
|        ![Drop-down 'Font' with multiple options that are showed in different fonts](images/dropdown_how_to_12_2.png)      |       Use font formatting for a list of fonts. It will help users make a choice.        |

#### Default and changed values

|        ![Drop-down 'Editor color scheme' with multiple options. Option 'Light (Theme default)' has 'Light' in blue color and 'Theme default' in grey color](images/dropdown_how_to_13_2.png)      |           * Use a blue font for values changed from the default.    * Use a secondary text to mark an option as default.        |

#### Submenus are not supported

Submenus are not supported for the drop-down list. Use a tree view instead

![Drop-down 'Keymap' with multiple options in a tree view showing dependencies in options](images/dropdown_how_to_14.png)

## Built-in behaviour

### Opening the menu

A drop-down menu opens on clicking the drop-down button anywhere or pressing the `Down` key when the drop-down is
focused.

The menu opens down by default. If there is not enough space, the menu opens up.

### Selected value

When the menu opens, the default option (displayed when the menu is closed) is selected.

### Moving the selection

Selection in the menu is moved by pressing `Up` and `Down` keys when an item is hovered. Selection is moved as well when hovering the cursor over an item but it doesn't update the value.

### Closing the menu

The menu remains opened until the user selects an item, clicks outside the menu, presses the `Esc` key, or switches to another app.

### Single-click activation

A dropdown should work with a single mouse click:

1. Clicking to open a drop-down.

2. Hover over an item to select it.

3. Release the mouse to confirm the selection and close the dropdown.

## How to layout

Follow the [labeled input controls](layout.html#labeled-input-controls) guideline.

