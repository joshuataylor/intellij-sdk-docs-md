# Window Sizes

Follow these guidelines to select the correct size when creating a dialog or a popup for IntelliJ-based products.

For simple cases use the [default sizes](#default-sizes). When they don't work well, set [minimum sizes for components](#minimum-sizes-for-components).

## Default sizes

### Dialog

There are four recommended window sizes for dialogs: small, medium, large, and extra large. Select the size depending on the amount of content required to keep the important information visible.

![A preview of recommended window sizes for dialogs: extra small, small, medium, and large](images/dialog_popup_sizes.png)
Note:
Users shouldn't be able to make a dialog smaller than the default size.

#### Small

Size: 350×250 px.

Best for: several components that are stacked vertically.

![The Rename dialog with two input fields, two checkboxes, and actions in the dialog footer. The components are stacked vertically in one column](images/dialog_popup_sizes_extra_small.png)

#### Medium

Size: 500×350 px

Best for:

* Multiple components with short labels that are divided into two columns.

* Full-width table with two or three columns.

* Full-width code snippet or an input field with long text.

For example, the Evaluate Expressions dialog has an input field with long text and a tree with code stacked vertically:

![The Evaluate Expressions dialog that has an input field with long text and a tree with code stacked vertically](images/dialog_popup_sizes_small.png)

#### Large

Size: 750×525 px

Best for:

* Full-width table with four or more columns.

* Master-detail layout.

* Two-column layout with a code snippet or an input field with long text in any of the columns.

* Two code snippets or input fields with long texts in a row.

* Two-column layout with an image or a video in any of the columns. In this case, the image or the video takes the most space.

For example, the Run/Debug Configuration dialog has a master-detail layout with a tree in the first column and a list of controls with long texts in the second column:

![The Run/Debug Configuration dialog that has a two-column layout. There is a navigation in the first column and a list of settings in the second column](images/dialog_popup_sizes_medium.png)

#### Extra Large

Size: 1000×700 px

Best for:

* Two-column layout with code snippets or input fields with long texts in both columns.

* Three-or-more-column layout regardless of the content.

For example, the Settings dialog that has three or more columns on multiple pages:

![The Settings dialog that has three or more columns on multiple pages](images/dialog_popup_sizes_large.png)

#### Maximum width and height

Set the dialog's maximum dimensions to match the screen size to prevent resizing beyond the screen bounds.

### Popup

Note:
Users shouldn't be able to make a popup smaller than the default size.

#### Action popups

If a popup has a vertical list of actions or options, set the minimum width to 200 px.

The default width and height are adaptable to the content inside if it exceeds the minimum width.

![Insert popup 200 px wide](images/dialog_popup_sizes_popup_xxs.png)

#### Content-rich popups

If a popup has multiple sections and long texts, set the default width to medium (500 px) or large (750 px). When the default width doesn't work, set the [minimum sizes for components](#minimum-sizes-for-components).

Height is adaptable based on the content. If a popup has a scrollable content, set the default height respectively: medium (350 px) or large (525 px), and use a [scrollbar](scrollbar.html).

|           Medium            ![Documentation popup 500 px wide](images/dialog_popup_sizes_popup_adaptive_height.png)        |
|           Large            ![Search Everywhere popup 750 px wide](images/dialog_popup_sizes_popup_m.png)        |

#### Maximum width and height

Set the maximum width and height to 80% of the screen size. Use a [scrollbar](scrollbar.html) if the popup's content exceeds the set dimensions.

### Tool windows

#### Vertical tool window

* Default width: 20% of the application width.

* Minimum size: 200×500 px.

#### Horizontal tool window

* Default height: 20% of the application height.

* Minimum size: 500×200 px.

For example, the vertical Project tool window and the horizontal Build tool window with minimum sizes in Window mode:

![Vertical Project and horizontal Build tool windows with the default sizes in Window mode](images/dialog_popup_sizes_tool_window.png)

## Minimum sizes for components

When the default sizes are either too big or too small for a window, or the window has a complex layout, add minimum sizes to content inside the window. This will make the content displayed correctly and reduce any potential issues caused by resizing the window.

### How to set the size correctly

1. Select the [control](#how-the-content-is-displayed) used to display content.

2. Select the [type of content](#types-of-content) used.

3. The minimum size is the biggest size out of the two defined in the previous steps.

#### How the content is displayed

|           ![Example of a table with three cells](images/dialog_popup_sizes_table_cell.png)        |          Table cell            Width: min 65 px            Height for the whole table: min 120 px            Follow guidelines for [table sizes](table.html#sizes)          |
|            ![Example of a tree](images/dialog_popup_sizes_tree.png)        |          Tree             Width: min 250 px          |
|            ![Example of a text area](images/dialog_popup_sizes_text_area.png)        |           Text area             Width: min 270 px, max 600 px             Height: min 55 px             Follow guidelines for [text area sizes](text-area.html#size-and-placement)          |
|            ![Example of a diagram](images/dialog_popup_sizes_diagram.png)        |           Diagram             A container with horizontal and vertical insets with 100 px          |

Note:
In any other case, select the width appropriate for the most common values in the component and follow sizes and placement guidelines for [each control](components.html).

#### Types of content

|            ![Examples of a class, test, and file name](images/dialog_popup_sizes_class_test_file.png)        |           Class/test/file name             Width: min 250 px          |
|            ![Examples of a URL, path, and an FQN for class](images/dialog_popup_sizes_url_path_fqn.png)        |           URL/Path/FQN for class             Width: min 350 px          |
|            ![Examples of a class, test, or file name together with a URL, path, or an FQN for class](images/dialog_popup_sizes_class_test_file_url_path_fqn.png)        |           Class/test/file name + URL/Path/FQN for class             Width: min 400 px          |
|            ![Example of a code snippet](images/dialog_popup_sizes_code_snippet.png)        |           Code snippet or editor             Width: min 400 px             Height (when multiple lines): min 120 px          |
|            ![Example of a paragraph](images/dialog_popup_sizes_standalone_text.png)        |           Paragraph or long text             Width: min 300 px             Height (when multiple lines): min 120 px          |

#### Example 1

The Rename Inheritors dialog has a table with FQNs. Add 350 px as the minimum width for a table column. This will make the dialog wider than the default Medium size (500 px) but will show more of FQNs.

|              Correct             ![The Rename Inheritors dialog has a minimum width set for each table column](images/dialog_popup_sizes_example_1_correct.png)           |
|              Acceptable             ![The Rename Inheritors dialog has the Medium size as default](images/dialog_popup_sizes_example_1_acceptable.png)           |

#### Example 2

The Settings dialog has the default extra large size 1000 px. In Code Style | Java set 400 px as the minimum width of the code editor. This will make the dialog wider but will show more code.

|              Correct             ![The code snippet in the Code Style settings for Java is 400 px, making the dialog wider](images/dialog_popup_sizes_example_2_correct.png)           |
|              Acceptable             ![Settings dialog is 1000 px wide](images/dialog_popup_sizes_example_2_acceptable.png)           |

#### Example 3

Instead of setting a default size for the Diagram popup, add 100 px horizontal and vertical insets inside it and make the width and height adaptive to its content. This will help small diagrams be more noticeable and make the Diagram popup of any size easier to read.

|              Correct             ![Diagram popup has 100 px insets from its borders to its content](images/dialog_popup_sizes_example_3_correct.png)          |
|              Acceptable             ![Diagram popup is set to the default small size](images/dialog_popup_sizes_example_3_acceptable.png)          |

## Empty state

Some components, for example, tables, can have an [empty state](empty-state.html) when there is no content. In this case, the minimum size of a component in both empty and filled states is defined by its filled state.

For example, the size of the Custom Plugin Repository dialog is defined by the minimum size of the table that contains URLs (minimum 350 px wide), and not by the size of the smaller empty state:

|              Correct             ![The table in the Custom Plugin Repository dialog has the same sizes in both empty and filled states](images/dialog_popup_sizes_empty_state_correct.png)          |
|              Incorrect             ![The table in the Custom Plugin Repository dialog has different sizes in the empty and the filled states](images/dialog_popup_sizes_empty_state_incorrect.png)          |

