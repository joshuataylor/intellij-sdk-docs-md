# Split Button

<tldr>
Implementation: [JBOptionButton](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-api/src/com/intellij/ui/components/JBOptionButton.kt)
</tldr>

A split button is a combination of a regular [button](button.html) and a drop-down button.

![Split button](images/split_button.png)

## Anatomy

A split button consists of the main action on the left and a drop-down button that shows a dropdown
with less common actions on the right:

![Split button action anatomy](images/split_button_anatomy.png)

## When to use

### More than two related actions

When there are more than two actions related to the main action, and there is not enough space for separate buttons, put these actions into
the dropdown menu:

![Related actions in a split button](images/split_button_related_actions.png)

### The second action is dangerous and uncommon

Dangerous actions can destroy users’ data and cannot be easily undone.
To avoid accidental clicks on a dangerous action, you can hide it in the dropdown menu if this action is uncommon, for example Force Push:

![Dangerous action in a split button](images/split_button_dangerous_action.png)
An uncommon dangerous action can be the only action in the menu.

Note:
Uncommon actions are the actions called in rare cases for specific purposes. For example, the Force Push action, unlike the Commit and Push... action, is available under certain circumstances
and covers rare user scenarios. Thus, it can be considered as uncommon and hidden in the dropdown menu.

## When not to use

### Unrelated actions

If unrelated actions are hidden under the dropdown menu, they are hard to find:

Incorrect

![Unrelated actions](images/split_button_unrelated_actions.png)
Correct

![Unrelated actions in separate buttons](images/split_button_unrelated_actions_correct.png)

### Only one related action

Putting the single action in the dropdown menu doesn't save a lot of space:

Incorrect

![One related action](images/split_button_one_action.png)
Correct

![Unrelated actions in separate buttons](images/split_button_one_two_buttons.png)
Note:
Exception: If the action is [dangerous and uncommon](#the-second-action-is-dangerous-and-uncommon), you can put it in the menu.

## How to use

### Main action

Refer to the [regular button rules](button.html#how-to-use).

### Dropdown button

#### Click

* Show the dropdown menu with secondary actions.

* Hide the menu when clicking outside the menu or on the second dropdown button click.

#### Hover

Show a tooltip:

![Tooltip on hover](images/split_button_tooltip_on_hover.png)

### Dropdown menu

Place related actions into the dropdown menu. Do not duplicate the main action in the dropdown menu, otherwise it is confusing how to trigger the main action — with the button or from the menu.

Incorrect

![Duplicated actions in dropdown menu](images/split_button_duplicated_action.png)
Correct

![Unique actions in dropdown menu](images/split_button_related_actions.png)
If there is a dangerous action among other actions in the dropdown, add the line separators above and below it to lessen the chance of calling this action by mistake:

![Dangerous action in the dropdown menu](images/split_button_dangerous_action_separator.png)

## Keyboard navigation & shortcuts

* Trigger the main action when the [default](button.html#default) button shortcut is pressed if the split button is the default one.

* Open the dropdown menu with the first menu item selected on `Alt+Shift+Enter`.

* Do not show the dropdown menu when the button gains focus.

### Focus on the button

| `Space` |Invoke the main action. |
| `Arrow Down` |Show the dropdown menu with secondary actions and move focus to the first item in the menu. |
|          `Tab`           `Shift + Tab`        |Move focus to the control next to the split button and hide the dropdown menu. |

### Focus on the dropdown menu

|          `Enter`           `Space`        |Invoke the selected action. |
|          `Arrow Down`           `Arrow Up`        |           * Navigate through the elements.    * Pressing `Arrow Down` on the top element moves the focus to the bottom element.    * Pressing `Arrow Up` on the bottom element moves the focus to the top element.        |
| `Esc` |Close the dropdown menu and move the focus to the split button. |

