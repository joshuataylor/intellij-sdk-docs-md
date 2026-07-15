# Tool Window

A tool window is a pane inside the main IDE window. For information about tool windows, see [IntelliJ IDEA Web Help](https://www.jetbrains.com/help/idea/tool-windows.html). For information about implementing tool windows, see [Tool Windows](tool-windows.html).

![Toolwindow](images/toolwindow.png)

## When to use

Tool windows provide access to information, tools, and services that support coding. They let users manage the project, run and debug applications, view git changes, and work with external systems — all without leaving the main workspace.

## Tool window structure

![Toolwindow structure](images/toolwindow_structure.png)
### Tool window name

* The name should be [short and descriptive](writing-short.html), preferably not longer than two words.

* Use title-case capitalization.

* Provide an abbreviation if a common one exists when tool window names are shown in the stripes. For example, `Pull Requests` becomes `PR`.

| ![Toolwindow name](images/toolwindow_name.png) |![Toolwindow name stripes](images/toolwindow_name_stripes.png) |

### Icon

Add an icon for the tool window button. The icon should be created in two sizes: 20×20px and 16×16px, grey, and monochromatic. See how to create icons in the [icons guidelines](icons-style.html).

#### Icon badge for feedback

Show a colored badge above the icon if the tool window content changes and can contain different types of feedback, for example, new updates or errors.

Do not change the icon for the tool window button when the content changes.

![Toolwindow badge](images/toolwindow_badge.png)

### Tabs

Add [tabs](tabs.html) to group related content or create similar instances, like run sessions, history for files, find results. The tabs for similar entities should be closable.

![Toolwindow tabs](images/toolwindow_tabs.png)

### Toolbar

Add a toolbar for [frequently used actions and filters](toolbar.html#what-items-to-add-on-toolbar). For more details, see the [toolbar guidelines](toolbar.html).

## How to use

### Visibility

If a tool window has no content yet, show its button by default only if the window contains basic functionality that is likely to be used for all projects, for example, Version Control or Problems. Otherwise, hide the tool window button by default. Hidden tool windows are still available under More tool windows menu.

| Correct![Toolwindow more correct](images/toolwindow_more_correct.png) |Incorrect![Toolwindow more incorrect](images/toolwindow_more_incorrect.png) |

Don't show the tool window button if the tool window is not relevant to the current project configuration. For example, don't show the Maven tool window for a project without Maven configuration files.

### Orientation

#### Vertical window

Vertical tool windows work better for trees, for example, Project, Structure, or Maven tool windows.

![Toolwindow vertical](images/toolwindow_vertical.png)

#### Horizontal window

Horizontal tool windows work better for tables, wide content, or master-detail panels, for example, Git Log, Terminal, or Problems.

![Toolwindow horizontal](images/toolwindow_horizontal.png)

### Empty state

If a tool window has no content yet, show [empty state](empty-state.html) to help users start working with the tool window.

| Correct![Toolwindow empty state correct](images/toolwindow_empty_state_correct.png) |Incorrect![Toolwindow empty state incorrect](images/toolwindow_empty_state_incorrect.png) |

