# Toolbar

<tldr>
Related: [Building a Toolbar/Popup Menu from Actions](action-system.html#buildingToolbarPopupMenu)
</tldr>

A toolbar provides quick access to frequently used actions and settings. It appears in dialogs, popups, tool windows, lists, trees, and tables.

![A toolbar with 6 icons and a drop-down list](images/toolbar.png)

## Toolbar items

![A toolbar with all kinds of UI controls that can appear on it: an action icon button, a drop-down icon button, a toggle icon button, a split icon button, a search field, a button, a label, a toolbar drop-down list and an overflow chevron](images/toolbar_items.png)
The following controls can appear on a toolbar:

* [Icon button](icon-button.html): action, toggle, or drop-down

* [Split icon button](split-icon-button.html)

* [Toolbar drop-down list](toolbar-drop-down.html)

* [Search field](search-field.html)

* [Button](button.html)

* Separator

* Label

* Chevron

## What items to add on toolbar

### Frequently used items

Add actions and settings that are frequently used:

* If usage statistics are available, frequent use is more than 5% of this feature's users.

* If usage statistics are not available: * Add items that are needed for the most common use cases of this feature. * If possible, add usage statistics logging for toolbar items that lack it. Check statistics after 3–4 weeks of use. If the items are used by less than 5% of the feature's users, consider removing them from the toolbar.

Note:
Exception: some actions can be used most frequently because they are widely known, like the Copy and Paste actions. Place such actions on the toolbar only to promote them. Otherwise, place them only in a context menu or the main menu.

### New items

When adding a new action or setting for a UI area that already has a toolbar: if the new item is expected to be used frequently, add it to increase its discoverability.

## How to use

### Location

Toolbars can be horizontal or vertical. Which type to use, depends on what control the toolbar is used for.

#### Lists, trees, tables

Use horizontal toolbars for lists, trees, and tables that appear in dialogs and popups. Place the toolbar at the top of the control.

![A horizontal toolbar with 5 icons above a tree](images/toolbar_dialogs_horizontal.png)

#### Vertical tool windows

Use horizontal toolbars in tool windows that are vertical by default.

![The Commit tool window with a horizontal toolbar above a tree with changes](images/toolbar_vertical_tool_window.png)

#### Horizontal tool windows

Use vertical toolbars for tool windows that are horizontal by default. Place the toolbar on the left in a tool window.

![The Problems tool window with a vertical toolbar on the left of the tree with file errors](images/toolbar_horizontal_tool_window.png)

If a horizontal tool window has several sections, place a toolbar on the right in sections after the first one if these conditions are true:

* The sections are a master-detail layout, with a list or tree on the left and a selected item's details on the right.

* The toolbar contains actions that are used occasionally, like the Soft-Wrap setting in the Console section of the Build tool window.

This way the toolbar would not break the connection between the master and the detail sections.

![The Build tool window with the vertical toolbar on the right of the Console section](images/toolbar_horizontal_tool_window_at_right.png)

A horizontal toolbar can be used in a horizontal tool window in the two cases:

* The toolbar contains items used for managing processes, like Step In and Step Out in the Debug tool window, or Run and Stop in the Run tool window. A horizontal toolbar makes the actions more noticeable and easy to reach.

* The toolbar contains items that need horizontal space, like a search field and drop-down lists in the Git tool window.

![The Debug tool window with a horizontal toolbar containing the Run, Stop, Resume, Pause, Step In, Step Out and other actions](images/toolbar_horizontal_tool_window_hor_toolbar_debug.png)![The Git tool window with a horizontal toolbar containing a search field and four drop-down lists with filters for the list of commits](images/toolbar_horizontal_tool_window_hor_toolbar_git.png)

### Items alignment

On a vertical toolbar, always top-align items.

On a horizontal toolbar:

* Left-align items by default.

* Right-align the less frequently used items.

![The Keymap settings with a tree and a toolbar above it: the Expand, Collapse and Edit icon buttons are on the left side of the toolbar, and a search field with another icon button are on the right side](images/toolbar_items_alignment.png)

### Items grouping

Group related toolbar items and separate groups with lines.

![A toolbar with three icon groups: Build, Run, Debug and Profile are the Run actions group; Git Update, Push, Diff and two more are the Git actions group; the Project Structure and Settings are the Settings group](images/toolbar_items_grouping.png)

If there are several unrelated icons, do not add separators after each icon. Separators could be entirely omitted if there are 5 and fewer icons on a toolbar.

|              Correct             ![A toolbar with five icons without separators](images/toolbar_separators_correct.png)          |Incorrect             ![A toolbar with five icons and three separators](images/toolbar_separators_incorrect.png) |

#### Label

Label a group of icons if it helps to make the icons clearer and if it’s needed to promote the icons. The icons group becomes more visible with the label.

![A horizontal toolbar with three icon groups, with a label for one of the groups](images/toolbar_items_grouping_with_label.png)

### Items order

Arrange separate items or groups in the following order by default.

If usage statistics are available, and popular items appear not at the top or left of a toolbar, consider arranging by the frequency of use.

![A vertical toolbar with icon categories ordered from top to bottom: actions, view options, an action to open a preview panel in a tool window, settings](images/toolbar_items_order.png)

### Toolbar overflow

A toolbar's width is usually limited by the element it belongs to. If there is not enough space for items on the toolbar, they are hidden under a chevron. Hovering the chevron shows the hidden items.

It is recommended to keep the number of toolbar items to what would be visible by default. Otherwise, the items will be hidden and it will be hard to discover them.

|              ![A horizontal toolbar above a tree with seven icons and an overflow chevron at the right](images/toolbar_overflow.png)          |             ![The same UI as in the previous image but with the overflow chevron hovered: the full toolbar with nine icons becomes visible](images/toolbar_overflow_hover.png)          |

#### Avoid two toolbars

Do not counter a toolbar overflow by adding more toolbars. If there are too many items on a toolbar:

* Group items under drop-down icon buttons

* Remove unpopular items by following the guidelines in [What items to add on toolbar](#what-items-to-add-on-toolbar)

|              Correct             ![A vertical toolbar with seven icons](images/more_toolbars_correct.png)          |             Incorrect             ![Two vertical toolbars stacked together with 19 icons in total](images/more_toolbars_incorrect.png)          |

### Toolbar border

For scrollable content in tool windows, do not show a toolbar border if the content is at the top scroll position. Show the border once the content is scrolled under the toolbar.

|              ![A tree with a toolbar above it. The tree is at the top scroll position, the toolbar border is not visible.](images/toolbar_scroll_top.png)          |             ![A tree with a toolbar above it. The tree is scrolled under the toolbar, the toolbar border is visible.](images/toolbar_scroll_under.png)          |

In places other than tool windows, it is fine to always show the border.

## Customization

Provide the ability to customize toolbars in the main window. To do this, add the toolbar to the list on the `Settings | Appearance & Behavior | Menus and Toolbars` page.

