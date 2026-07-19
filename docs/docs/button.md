# Button

<tldr>
Implementation:
[JButton](https://docs.oracle.com/javase/tutorial/uiswing/components/button.html)
</tldr>

![Cancel and Save buttons](images/button_example.png)

## When to use

Use a button to invoke an immediate action:

![When to use a button](images/button_when_to_use.png)

## When not to use

| ![Using links instead of buttons](images/button_link_instead.png) |Use a link instead if:                         * The action takes the user to another page of the same dialog or an external source like documentation. Note: Exception: the Next and Previous buttons in wizard navigation.    * The command is a secondary action that isn't related to the primary purpose of the window, and the space is constrained.                    |
| ![Using toolbar buttons instead of buttons](images/button_toolbar.png) |Use a [toolbar button](toolbar.html) instead if there are several buttons related to a table or list.                    |
| ![Using split buttons instead of buttons](images/button_split_button.png) |Use a [split button](split-button.html) instead if:                         * There are more than two related actions, but the space is limited and/or packed.    * The action isn't common and is dangerous, for example, can destroy user data and cannot be easily undone.                    |
|                      ![Using built-in buttons instead of buttons](images/button_built_in_button.png)                  |Use a [built-in button](built-in-button.html) instead if it's related to an input field, combo box,                     search field.                    |

## How to use

### Label

Use an action name as a button label.

#### Use title capitalization

Use [title capitalization](capitalization.html) for button labels.

#### Use imperative verbs

Write the label as an imperative verb, for example, Save, Print, Cancel. Use title capitalization.

Note:
Exceptions: standard buttons like OK, Back/Forward,
Previous/Next, Yes/No, Agree,
Options, Settings, Details.

#### Be specific

The button should answer the question in the title, so the user can skip the description. Prefer specific
labels over
generic ones:

Correct
![Specific button in a dialog](images/button_delete_dialog.png)
Incorrect
![Generic button in a dialog](images/button_delete_dialog_incorrect.png)
Note:

Exception: the Cancel button if it's clear what action is being canceled.
For example, use
Cancel instead of Don’t Delete.

Do not
use the word
Now in labels because buttons always trigger an immediate action:

|                              Correct                             ![A button with 'Check for Updates' label](images/button_check_for_updates.png)                          |Incorrect                             ![A button with 'Check Now' label](images/button_check_now.png) |

#### Be short and clear

The label should be short, not more than five words. If it’s not obvious what element the button is related
to, add more
words to make it clear. Prefer clear labels to short ones:

| Correct                             ![A button with the 'Edit Action Icon...' label](images/button_active_edit_action.png) |Acceptable                             ![A button with 'Edit' label](images/button_edit.png) |

#### Ellipsis

* Add an ellipsis if additional actions such as adding more info or confirming the action are required.

* Don't add an ellipsis if another window is opened, but no more input from the user is required. For example, About, Details.

![Buttons with ellipsis](images/button_ellipsis.png)

### Button states

#### Default

![Default button on macOS and Windows](images/button_default.png)
* The default button confirms the main purpose of a dialog. It is triggered by pressing `Enter` or `Ctrl+Enter` on Windows/Linux and `Enter` or `Cmd+Enter` on macOS. Note: Exception: if the focus is on an element that uses the `Enter` key, for example, a text area, the default button is triggered only by `Ctrl+Enter` on Windows/Linux and `Cmd+Enter` on macOS.

* The default button should always be present in a dialog. Only one button in a dialog can be the default one.

* If an action that a default button performs is dangerous, which means it can lead to data loss, there should always be an easy way to undo it. Otherwise, use a secondary button for a dangerous action and a default button for a safe action: ![A dialog with secondary and primary buttons](images/button_merge_dialog.png)

#### Focused

!['Cancel' button in a focused state](images/button_focused.png)
All buttons can get focus, even on macOS if the
Full Keyboard Access
option is disabled in Preferences > Keyboard >
Shortcuts.
A focused button behavior varies on macOS/Linux and Windows.

macOS:

* A focused button is invoked by pressing `Space`. Focused and default buttons are independent, so when the focus moves from one button to another, the default button does not change.

* Make the second most popular button in the dialog focused. It’s recommended to have one default and one focused button so that most of the actions can be triggered using the keyboard.

* It’s recommended to have one default and one focused button so that most of the actions can be triggered using the keyboard.

Windows, Linux:

* The focused button is triggered by pressing `Enter` or `Space`. If a non-default button gets focus, the default button is invoked using `Ctrl+Enter`. On pressing the `Tab` key, the New Window button gets the focus and is triggered with `Enter` or `Space` . The original This Window button is triggered with `Ctrl+Enter`. If the focus moves to the control that’s not a button, the original default button is triggered by `Enter`.

Correct
![A dialog with buttons: 'New Window' (focused), 'Cancel', and 'This Window' (default).](images/button_open_project_dialog.png)
Incorrect
![A dialog with buttons: 'New Window', 'Cancel', and 'This Window' (default and focused).](images/button_open_project_dialog_incorrect.png)

#### Disabled

![Disabled button](images/button_disabled.png)
Disable a button if:

* The control to which the button is related is disabled.

* Not all required fields in the dialog are filled.

Other [standard buttons](#common-buttons) are described below. They can be regular or default buttons.

#### Hover

On hovering over a button, show a tooltip with the shortcut and the action name if it can be clarified.
For more details,
see [Context help](context-help.html).

If the action is clear, show the shortcut only. If the action can be clarified, show the action name and the shortcut:

![Hovered buttons](images/button_hovered.png)

### Common buttons

#### Apply

|                          ![Hovered buttons](images/button_apply.png)                       |                         Use the Apply button in dialogs with many settings that affect how data is displayed. The                             Apply button                             allows you to save and preview the effect of the selected options and continue changing the                             settings, for example, change the editor color scheme in settings.                           The Apply should be [disabled](#disabled) if no changes have been made in the dialog.                                                 |

#### Cancel

|                          ![Hovered buttons](images/button_cancel.png)                       |                             TheCancel button reverts the app to the state before the dialog was                                 invoked and works as an equivalent to the `Esc` key.                               If a confirmation button is present in a dialog, for example,                             OK or                             Save, it’s required to have the Cancel button.                               If it is not clear what will happen on clicking the Cancel button,                             make the label more [specific](#be-specific), for example, Continue Editing.                        |

#### Close

|                          ![Hovered buttons](images/button_close.png)                       |                         Use the                             Close                             label only if nothing can be changed in the dialog and there is no confirmation button, for example, in                             the                             `Help \| My Productivity`                             dialog.                             In all other cases, use the                             Cancel                             button.                                                 |

#### Help

|                          ![Hovered buttons](images/button_help.png)                       |                         The help button appears in the bottom-left corner of a dialog and                             opens a documentation website. Add this button if the dialog's functionality is described                             in documentation.                            |

