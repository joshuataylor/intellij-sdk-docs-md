# Context Help

Use context help to briefly explain how a functionality works if it is not clear from the UI or the application behavior. A full description of the functionality should be provided in [product web help](https://www.jetbrains.com/help/idea/).

Context help can be shown as an [inline help text](inline-help-text.html), in a [help tooltip](tooltip.html), and in an [empty state](empty-state.html).

## Inline help text

Use an [inline help text](inline-help-text.html) in settings dialogs that are not constrained by space and are not frequently used. Since settings are rarely changed, users may forget their purpose, so displaying the information immediately makes sense.

![Context help in an inline text](images/context_help_inline_text.png)

## Tooltip

Use a [tooltip](tooltip.html):

* If the space is not enough for showing the inline help text.

* In frequently used dialogs, tool windows, or popups. The more often a person uses an interface, the more likely they are to remember what each option does.

* For icons or other controls that do not have a label.

![Context help in a tooltip](images/context_help_tooltip.png)

## Empty state

Fill in [empty states](empty-state.html) of tool windows, tables, trees, and other containers with:

* a reason why the data is missing

* an action that can fix it

* a link to a corresponding article in the web help.

![Empty state of a tool window](images/empty_state_structure.png)

## When to use

Below are rules for [tooltips](tooltip.html) and [inline texts](inline-help-text.html).

|        ![Explain a setting](images/context_help_explain.png)      |         Explain complex behavior that a short action or a setting name cannot convey clearly.        |
|        ![Input format requirements](images/context_help_input_format.png)      |         Provide input format requirements and examples.        |
|        ![Suggest alternative ways](images/context_help_alternatives.png)      |         Suggest alternative ways.        |
|        ![Warn about possible issues](images/context_help_input_warning.png)      |         Warn about possible issues.        |
|        ![Explain limitations](images/context_help_limitation.png)      |         Explain limitations.        |
|        ![Provide quick navigation to related settings](images/context_help_navigation.png)      |         Provide quick navigation to related settings.        |
|        ![Explain IDE-specific entities](images/context_help_terms.png)      |         Explain IDE-specific entities.        |

## When not to use

### Do not explain UI

Do not use context help to explain how the user interface works. If it needs explaining, consider redesigning the UI.

|        Correct       ![Don't explain how UI elements should work](images/context_help_explain_ui_correct.png)      |       Incorrect       ![Incorrect UI requires additional explanation](images/context_help_explain_ui_incorrect.png)      |

### Do not explain common actions

Do not explain common actions and entities. Show a regular tooltip with an action name and shortcut in this case.

|        Correct       ![Don't explain common actions](images/context_help_explain_simple_correct.png)      |       Incorrect       ![Common actions are explained in the tooltip](images/context_help_explain_simple_incorrect.png)      |

### Do not clutter UI with context help

Do not explain each option. Too many help icons or too much inline text make a dialog cluttered and harder to navigate visually.
If all options need to be explained, consider rewriting the labels to make them clearer.

|        Correct       ![Don't explain every option](images/context_help_explain_too_many_correct.png)      |       Incorrect       ![Every option has its tooltip](images/context_help_explain_too_many_incorrect.png)      |

## How to use

See [Inline help text](inline-help-text.html), [Tooltip](tooltip.html), and [Empty State](empty-state.html).

