# Text Area

<tldr>
Implementation: [JBTextArea](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/components/JBTextArea.java)
</tldr>

A text area allows users to enter or edit multi-line text.

![Text area example](images/text_area_example.png)

## When to use

Use a text area if input is unconstrained and long, or if the newline character is a valid value. Example: commit message or code snippets.

Do not use a text area if:

* Input consists of several words. Use an [input field](input-field.html) instead.

* There is not enough space for a text area, or if input is normally short but can occasionally be long or multi-line. Use an [expandable input field](input-field.html#when-not-to-use) instead.

* Values are added one by one. Use a [table](table.html) instead.

* Text is read-only. Use a [description text](description-text.html) instead.

## How to use

### Label

Follow the rules for the [input field](input-field.html).

A label is required for all empty text areas.
If a text area is prefilled, and it’s clear from the context what data it contains, a label can be omitted.
For example, the following text area is used to preview file and code templates:

![No label](images/no_label.png)
If a new file template is added and the text area is empty, the label is required.

Do not put units on the right of the text area.

Do not use a [group header](group-header.html) instead of the text area label. The horizontal
line is redundant here. Use [context help](context-help.html) to explain the field behavior.

Incorrect

![Label incorrect](images/label_incorrect.png)
Correct

![Label correct](images/label_correct.png)

### Placeholder, prefilled values and field focus

Follow the rules for the input field: [placeholder](input-field.html#placeholder), [prefilled value](input-field.html#prefilled-value), [field focus](input-field.html#field-focus).

### History

If the previous user input should be saved, use `⌥↑` and `⌥↓` on macOS and `Alt+Up/Down`
on Windows and Linux to navigate through the history.
If history is available, add a note at the bottom of the input field:

![Text area history](images/text_area_history.png)
Save the current value, so that the user can return to it while navigating through the history.

### Validation

If the user types an invalid value, highlight the text area with red and show an error message in a tooltip. For more details, see [Validation errors](validation-errors.html).

![Text area error](images/text_area_error.png)

## Size and placement

Recommended sizes:

![Text area sizes](images/text_area_sizes.png)
This is the default size, it can be changed if the dialog is resized.

Height. The minimum text area height is 3 lines ~55px, so the user understands that it’s multi-line. The maximum height is not limited and should be appropriate for the most common values.

Width. The minimum text area width is 270px. It’s inconvenient to use a narrower field due to frequent line breaks. The maximum width is 80 symbols ~600px, otherwise, it’s hard to read the text.

Size the text area to display an integral number of lines of text:

| Incorrect |Correct |
----------------------
| ![Text area size 2](images/text_area_size_2.png) |![Text area size 3](images/text_area_size_3.png) |

Do not resize a text area on input. It will change the position of other controls and they can become hardly discoverable.

If the text is long and does not fit the text area, add [scrollbar](scrollbar.html).

For placement, follow the rules for the [input field](input-field.html).

## Style

Use the same colors as for the [input field](input-field.html).

Do not highlight a text area on selection, only if a validation error occurs.

### History

Background: dialog default theme color

Font: Windows, IntelliJ — default, macOS 2px smaller than default

