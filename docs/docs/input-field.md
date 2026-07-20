# Input Field

<tldr>
Implementation: [JBTextField](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/components/JBTextField.java)
</tldr>

An input field allows users to enter or edit a text line using the keyboard.

![Input](images/input.png)

## When to use

Use an input field if it’s not possible to enumerate the most likely values. Otherwise, use a [combo box](combo-box.html) or a [drop-down list](drop-down.html).

| Correct |Incorrect |
| ![Input when to correct](images/input_when_to_correct.png) |![Input when to incorrect](images/input_when_to_incorrect.png) |

## When not to use

### Previous input is saved

If the previous user input must be preserved, use a [combo box](combo-box.html).

![Combobox when to use 1](images/combobox_when_to_use_1.png)

### Large input

Use a [text area](text-area.html) for long or multi-line input.

![Input text area](images/input_text_area.png)

### Space is limited

If the place is constrained, use an expandable input field [ExpandableTextField](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/components/fields/ExpandableTextField.java).
For more details, see [Expand button](built-in-button.html#expand-a-field).

![Input text input expand](images/input_text_input_expand.png)

### Many predefined values

If there are many predefined values (for example, code snippets, commit author), add completion to the input field [TextFieldWithCompletion](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-impl/src/com/intellij/util/textCompletion/TextFieldWithCompletion.java). Show the completion popup when the user starts typing.

![Input completion](images/input_completion.png)

### Built-in buttons

Use [built-in buttons](built-in-button.html) to help the user enter data. For example, to browse the disk.

### Search

Use a [search field](search-field.html) to input a search query.

![Input search](images/input_search.png)

### Password

If input data is secured, replace it with dots via [JBPasswordField](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/components/JBPasswordField.java).

![Input password](images/input_password.png)

### Choosing a color

Use a color box to choose a color.

![Input colour box](images/input_colour_box.png)

## How to use

### Label

A label accompanies each input field and indicates the information type.

#### General rules

* Labels should be [short and descriptive](writing-short.html).

* Write the label as a noun and end it with a colon.

* Don't use labels to tell users what to do.

* Use [sentence-style capitalization](capitalization.html#sentence).

| Correct![Input label 1 correct](images/input_label_1_correct.png) |Incorrect![Input label 1 incorrect](images/input_label_1_incorrect.png) |

#### Label as a phrase

When writing a label as a phrase, don't use colon and ending punctuation.

| Correct![Input label 2 correct](images/input_label_2_correct.png) |Incorrect![Input label 2 incorrect](images/input_label_2_incorrect.png) |

#### Grouped input fields

If there are several input fields in a form, make labels approximately the same length to avoid gaps between labels and fields.

| Correct![Input label 3 correct](images/input_label_3_correct.png) |Incorrect![Input label 3 incorrect](images/input_label_3_incorrect.png) |

#### Disabled state

If an input field is disabled, disable the label too.

![Input disabled](images/input_disabled.png)

#### Selectable label

Make the label text selectable. The user may want to search for this option on the Internet or to send a question to support.

![Input label selected](images/input_label_selected.png)

#### Positioning a label

Place the label on the left or above the input field. For more details, see the [Layout](layout.html) topic.

| Correct![Input positioning label 1](images/input_positioning_label_1.png) |Correct![Input positioning label 2](images/input_positioning_label_2.png) |

### Placeholder

Placeholder is gray text placed inside an input field. To show placeholder text, use `JBTextField.getEmptyText().setText(...)`.

#### General rules

* Use sentence-style capitalization.

* Don't use ending punctuation or ellipsis.

* Hide the placeholder when the user starts typing, not when the input field gets the focus.

#### Optional input field

Use the placeholder to indicate that an input field is optional.

![Input placeholder optional](images/input_placeholder_optional.png)

#### Default values

Use the placeholder to show the default value.

![Input placeholder default](images/input_placeholder_default.png)
If the user overwrites the value, it can be restored by removing the new value from the input field or by clicking the Reset to default link on the right.

![Input placeholder default reset](images/input_placeholder_default_reset.png)

#### Showing examples

Don't use the placeholder to show examples because the user can get the impression that the field is already filled. Provide examples or explanation under the input field (see [Context help](context-help.html)):

| Correct![Input placeholder example correct](images/input_placeholder_example_correct.png) |Incorrect![Input placeholder example incorrect](images/input_placeholder_example_incorrect.png) |

#### Don't use placeholders as labels

Don't use the placeholder as the field label. After the field has been filled, it is difficult to understand its purpose.

| Correct![Input placeholder label correct](images/input_placeholder_label_correct.png) |Incorrect![Input placeholder label incorrect](images/input_placeholder_label_incorrect.png) |

### Prefilled value

Pre-fill the field if it has the default or a frequently used value. Use the default text color for pre-filled values:

![Input prefilled](images/input_prefilled.png)
Note:
When naming a default entity like `scope` or `notebook` which can have multiple entities in a group, pre-fill it using the entity name with a sequential number: `scope-1`, `scope-2`, etc.

Don't use Unnamed as a prefilled value. It takes time to read it and does not help the user to fill the form.

| Correct![Input prefilled unnamed correct](images/input_prefilled_unnamed_correct.png) |Incorrect![Input prefilled unnamed incorrect](images/input_prefilled_unnamed_incorrect.png) |

### Field focus

When an input field gets the focus, place the caret at the end of the text:

![Input focus](images/input_focus.png)
If users are more likely to re-enter the entire value, select the whole text when the field gets the focus:

![Input focus selection](images/input_focus_selection.png)

### Validation

If the user enters an invalid value, highlight the field with red and show an error message in a tooltip. For more details, see [Validation errors](validation-errors.html).

![Input validation](images/input_validation.png)

## Sizes and placement

### Width

Choose the width appropriate for the most common values, but not less than 65px. The field width helps the user understand what value is expected and to make sure that they fill the field correctly.

| Correct![Input width 1 correct](images/input_width_1_correct.png) |Incorrect![Input width 1 incorrect](images/input_width_1_incorrect.png) |

If the input value is longer than the field width, show the beginning of the value when the field becomes inactive.

![Input width 2](images/input_width_2.png)

### How to layout

Follow the [labeled input controls](layout.html#labeled-input-controls).

