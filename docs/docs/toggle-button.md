# Toggle Button

<tldr>
Implementation: see [Control](#control)
</tldr>

The toggle button is used to switch between On and Off states.

![Toggle button example](images/toggle_button_example.png)

## When to use

Use the toggle button to switch the state of an item in search results:

![Example se](images/example_se.png)
Do not use the toggle button for items in dialogs and menus. Instead, use a checkbox in dialogs and a checkmark in menus:

![When to use dialog or menu](images/when_to_use_dialog_or_menu.png)

## How to use

### Label

The toggle button in search results should duplicate the option from the settings or the menu.
Label and capitalization should be the same as on the option label:

![Label checkbox](images/label_checkbox.png)
Setting in the preferences

![Label checkbox se](images/label_checkbox_se.png)
The same setting in search results

Do not make a setting available only from search results.

If the setting is in a tree or menu, use the toggle button label to specify where the setting is located:

![Label tree](images/label_tree.png)
Setting in a tree

![Label tree se](images/label_tree_se.png)
The same setting in search results; separate tree levels with a colon

![Label menu](images/label_menu.png)
Setting in the main menu

![Label menu se](images/label_menu_se.png)
The same setting in search results; separate the first menu level with a vertical bar, and separate others with a colon

Refer to [checkbox](checkbox.html) for writing checkbox labels and menu labels.

Do not add the word "On" or "Off" to the item name, since the state description is already in the toggle button.

### Control

A toggle button is implemented with the [OnOffButton](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/components/OnOffButton.java) class.
But generally, you shouldn't use the class directly.
The IDE automatically places the buttons in the search feed if you follow one of the patterns described below:

1. If this is a system or editor or another kind of settings, register the corresponding [BooleanOptionDescription](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ide/ui/search/BooleanOptionDescription.java) for the option. The options can be bound (but not limited) to a [SearchTopHitProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ide/SearchTopHitProvider.kt) instance which is registered in `plugin.xml` with the `<search.topHitProvider implementation="fq.class.name"/>` tag.

For example, see the [SystemOptionsTopHitProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-impl/src/com/intellij/ide/ui/SystemOptionsTopHitProvider.java) class that represents matching of Reopen last project on startup checkbox to `BooleanOptionDescription`.

2. Implement your own action that's inherited from [ToggleAction](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/actionSystem/ToggleAction.java) and registered in `plugin.xml`.

The toggle button changes state when it is clicked with the mouse or when `Enter` is pressed on the item line.

