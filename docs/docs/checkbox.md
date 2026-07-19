# Checkbox

<tldr>
Implementation:
[JCheckBox](https://docs.oracle.com/javase/8/docs/api/javax/swing/JCheckBox.html),
[JBCheckBox](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/platform-api/src/com/intellij/ui/components/JBCheckBox.java)
</tldr>

![A preview of checkboxes in different states](images/checkbox.png)

## When to use

Use checkboxes for yes/no choices or for selecting several items in a group:

![An example of a checkbox group with two selected options](images/checkbox_when_to_use.png)

## When not to use

If only one option in a group can be selected, use [radio button](radio-button.html):

|                      Incorrect                     ![A radio button group with only one selected option possible](images/checkbox_when_not_to_use_1_incorrect.png)                  |                     Correct                     ![Two radio buttons with clear labels](images/checkbox_when_not_to_use_1_correct.png)                  |

If the behavior in the "off" state is unclear from the checkbox label, use two [radio buttons](radio-button.html) instead
and label them accordingly:

|                      Incorrect                     ![A radio button group with only one selected option possible](images/checkbox_when_not_to_use_2_incorrect.png)                  |                     Correct                     ![Two radio buttons with clear labels](images/checkbox_when_not_to_use_2_correct.png)                  |

## How to use

### Label on the right

A label accompanies each checkbox and is placed on the right side.

|                                  Correct![A correct checkbox with the label on the right](images/checkbox_label_right_correct.png)                          |                                 Incorrect![An incorrect checkbox with the label on the left](images/checkbox_label_right_incorrect.png)                          |

### Long labels

If a label is long, split it into two lines. Use HTML formatting for that. Avoid labels that take more than two lines. See recommendations on [writing concise labels](#writing-guidelines) below.

|                          Correct![A correct checkbox with the label on the right](images/checkbox_label_long_correct.png)                      |                             Incorrect![An incorrect checkbox with the label on the left](images/checkbox_label_long_incorrect.png)                      |

#### Implementation

Kotlin UI DSL:

```KOTLIN
checkBox(
    """<html>Insert selected suggestion by pressing space, dot,<br/>
or other context-dependent keys</html>""")
```

Java:

```JAVA
new JCheckBox(
"<html>Insert selected suggestion by pressing space, dot,<br/>" +
        "or other context-dependent keys</html>");
```

### Checkboxes in a table

If a checkbox appears in a table, place the label into the column header and do not repeat it on every
row:

![A table with checkboxes where the label is placed into the column header](images/checkbox_when_to_use_3.png)
#### Implementation

Checkboxes are rendered in tables with [BooleanTableCellRenderer](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-ui/src/ui/BooleanTableCellRenderer.java)
and edited with `DefaultCellEditor(JCheckBox)` implementation.
For any column that should be rendered as a checkbox, set both a renderer and editor for consistency.
The type of data in the correspondent column of the `Table` model should either be `Boolean`
or `String` containing `true` or `false`.

```JAVA
TableColumn column = table.getColumnModel().getColumn(COLUMN_INDEX);
column.setCellEditor(JBTable.createBooleanEditor());
column.setCellRenderer(new BooleanTableCellRender());
```

### Three-state checkbox

#### Status of children

In a group of options, use the parent checkbox to show the status of its children. The state of the parent checkbox can be checked, indeterminate or unchecked. When a user clicks an indeterminate checkbox for the first time, the whole group becomes checked. The second click unchecks the whole group.

![Different states for a parent checkbox: checked, indeterminate, and unchecked](images/checkbox_three_state.png)
##### Implementation

The three-state checkbox is represented by the [ThreeStateCheckBox](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/util/ui/src/com/intellij/util/ui/ThreeStateCheckBox.java)
class which represents its state with the `ThreeStateCheckBox.State` enum containing `SELECTED,
NOT_SELECTED, DONT_CARE` states.

#### Download status

An indeterminate checkbox can also show the download status. In the example below, a remote repository with Repositories "tools-base" and "contrib" are being loaded. When loading is finished, the indeterminate checkbox will be replaced with the checked checkbox if there are commits, or an unchecked checkbox if there are no commits.

![Indeterminate checkboxes showing download status](images/checkbox_download_status.png)
##### Implementation

In a table, the three-state checkbox is represented by [ThreeStateCheckBoxRenderer](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/profile/codeInspection/ui/table/ThreeStateCheckBoxRenderer.java)
that provides both `TableCellRenderer` and `TableEditor`.
It accepts `Boolean` type in the column being supplied by the `TableModel` and
becomes `DONT_CARE` when the value in the cell is null.
Otherwise, it becomes `SELECTED` for `Boolean.TRUE`, and `NOT_SELECTED`
for `Boolean.FALSE`.

## Writing guidelines

Use sentence-style capitalization:
|                                          Correct![A correct checkbox with the imperative form of the verb](images/checkbox_writing_1_correct.png)                                  |                                         Incorrect![An incorrect checkbox with the declarative form of the verb](images/checkbox_writing_1_incorrect.png)                                  |

Do not use ending punctuation:
|                                          Correct![A correct checkbox with the imperative form of the verb](images/checkbox_writing_2_correct.png)                                  |                                         Incorrect![An incorrect checkbox with the declarative form of the verb](images/checkbox_writing_2_incorrect.png)                                  |

Use the imperative form of verbs:
|                                          Correct![A correct checkbox with the imperative form of the verb](images/checkbox_writing_3_correct.png)                                  |                                         Incorrect![An incorrect checkbox with the declarative form of the verb](images/checkbox_writing_3_incorrect.png)                                  |

Do not use negation in labels as it complicates understanding:
|                                          Correct![A correct checkbox with the imperative form of the verb](images/checkbox_writing_4_correct.png)                                  |                                         Incorrect![An incorrect checkbox with the declarative form of the verb](images/checkbox_writing_4_incorrect.png)                                  |

Note:
Exception: Do not show again checkbox.

Make labels short and intelligible. See [Writing short and clear](writing-short.html).

## How to layout

Follow the guidelines for [checkboxes and radio buttons](layout.html#checkboxes-and-radio-buttons) layout.

