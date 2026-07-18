# User interface overview

By default, all IntelliJ-based IDEs use the following layout:

![Main Window](images/ui_overview_main_window.png)

The main application window of all IntelliJ-based IDEs by default includes the following parts:

* [Main toolbar](#main-toolbar) at the top

* [Stripes](#stripes) on the left and right sides that provide quick access to tool windows

* [Tool windows](#tool-windows) that surround the editor on the right, left, and bottom

* [Editor area](#editor-area)

* [Status bar](#status-bar) at the bottom

IntelliJ Platform also provides the following container elements:

* [Dialogs](#dialogs)

* [Popups](#popups)

* [Notifications](#notifications)

* [Context menus](#context-menus)

See the full list of UI components in [Components](components.html).

## Main toolbar

The main toolbar provides quick access to the most commonly used tools for managing the IDE and projects.
The main toolbar is fully [customizable](https://www.jetbrains.com/help/idea/customize-actions-menus-and-toolbars.html#customize-main-toolbar),
which means that the user may hide unnecessary widgets and buttons and add new ones.

![Main toolbar](images/ui_overview_main_toolbar.png)
### Project widget

A drop-down control that allows opening existing projects or creating new ones:

![Project widget](images/ui_overview_project_widget.png)

### VCS widget

A drop-down control for managing VCS branches:

![VCS widget](images/ui_overview_vcs_widget.png)

### Run widget

A drop-down control for choosing run configurations and buttons for running and debugging the code:

![Run widget](images/ui_overview_run_widget.png)

### Toolbar buttons

The icon buttons that provide quick access to Search, Settings, and other important IDE features.

![Main toolbar buttons](images/ui_overview_main_toolbar_buttons.png)

### Main menu (on Windows and Linux)

On Windows and Linux, the toolbar also includes the Hamburger button:

![Main toolbar on Windows](images/ui_overview_main_toolbar_windows.png)
On clicking the Hamburger button, the menu items are shown on the right:

![Main menu expanded](images/ui_overview_main_toolbar_windows_expanded.png)
You can also opt for showing the menu above the toolbar:

![Main menu expanded on a separate line](images/ui_overview_main_toolbar_windows_expanded_dark_down.png)

## Tool windows

Tool windows are the panes inside the main application window that serve for solving different tasks,
for example, navigating through the project files in the Project tool window or working with Terminal in the
Terminal tool window:

![Terminal tool window](images/ui_overview_tool_window.png)
See more in [Tool windows](tool-window.html).

## Stripes

The left and right sides of the main window feature vertical stripes containing tool window buttons.
These appear as icons by default but can be configured to display tool window names beneath them:

![Stripes](images/ui_overview_stripes.png)
See more in [Show and hide tool windows names](https://www.jetbrains.com/help/idea/tool-windows.html#show_or_hide_tool_window_names).

## Editor area

Editor area is the main working area in IntelliJ IDEs that is used to write, read, and modify code:

![Editor](images/ui_overview_editor.png)
### Code editor

The IntelliJ code editor provides highlighting, navigation, refactorings, and other powerful code insights features.
See implementation details in [Editor basics](editor-basics.html).

### Editor tabs

Tabs display the file name and extension. They can be [pinned](https://www.jetbrains.com/help/idea/using-code-editor.html#pin-or-unpin-a-tab), [opened in separate windows](https://www.jetbrains.com/help/idea/using-code-editor.html#detach_tab) or in a [split view](https://www.jetbrains.com/help/idea/using-code-editor.html#split_screen).

![Editor tabs](images/ui_overview_tabs.png)
See more details on working with tabs in the editor in [Editor tabs](https://www.jetbrains.com/help/idea/using-code-editor.html#manage_tabs). For UI component reference, go to [Tabs](tabs.html).

### Inspection widget

A small control in the top-right corner of the editor shows the number of errors, warnings, and typos and allows navigating to the detailed view in the Project tool window.

![Inspection widget](images/ui_overview_inspection_widget.png)
See more in [File and project analysis](https://www.jetbrains.com/help/idea/file-and-project-analysis.html#analysis-current-file).

### Gutter

A vertical area along the left side of the editor that provides important information and action icons within easy reach. It shows line numbers and buttons for folding, navigating, and running and debugging code along with VCS stripes and other controls.

![Editor gutter](images/ui_overview_gutter.png)
See more in [Editor gutter](https://www.jetbrains.com/help/idea/editor-gutter.html).

### Inlays

Hints that show additional information like parameter types or variable values and interactive controls for showing annotations, usages, and more.

![Inlays](images/ui_overview_inlays.png)
See more in [implementation details](inlay-hints.html) and [user guidelines](https://www.jetbrains.com/help/idea/inlay-hints.html).

### Floating toolbar

A small toolbar that appears when you select a code fragment in the editor. It contains buttons and controls for the most popular actions relevant in the current context,
such as quick fixes, AI-actions, basic refactorings, and code-formatting options:

![Floating toolbar](images/ui_overview_floating_toolbar.png)
See more in [Floating toolbar](https://www.jetbrains.com/help/idea/working-with-source-code.html#floating_toolbar).

## Status bar

The status bar on the bottom of the main window displays information on the current state of the project and the IDE as well as the path to the currently opened file:

![Status bar](images/ui_overview_status_bar.png)
### Navigation bar

The left part of the status bar by default is occupied by the navigation bar that is a compact alternative for the Project tool window.
It shows a path to the selected file and allows you to go to other files and directories using this path:

![Navigation bar](images/ui_overview_navigation_bar.png)

### Status bar widgets

The right part of the status bar contains status bar widgets which show statuses of various IDE and project settings and provide actions for changing these settings.
For example, the indent widget shows the number of spaces for code formatting in the current file and allows users to change this number:

![Status bar widget](images/ui_overview_status_bar_widget.png)
See more information on status bar widgets implementation in [Status Bar Widgets](status-bar-widgets.html).

## Dialogs

In the IntelliJ Platform, dialogs are modal windows that appear over the main application screen and require user actions to proceed.
The dialogs might be used for different purposes, such as setting up the IDE and projects, creating new instances, asking for confirmations, and so on.

### Dialog examples

Settings:

![Settings dialog](images/ui_overview_settings.png)
Welcome screen:

![Welcome screen](images/ui_overview_welcome_screen.png)
New project wizard:

![New project wizard](images/ui_overview_new_project.png)

## Popups

A popup is a lightweight window that appears above the application screen. Unlike the dialogs, popups do not have the standard OS
title bar and are usually dismissed by clicking outside.

### Popup examples

Completion popup:

![Completion popup](images/ui_overview_completion.png)
Documentation popup:

![Documentation popup](images/ui_overview_documentation.png)

## Notifications

In IntelliJ Platform, different components are used to inform users about various events and status changes, depending on the severity and context of the message.

### Balloons

[Notification balloons](balloon.html) inform users on the events or system states related to a project or IDE:

![Notification balloon](images/ui_overview_balloon.png)

### Alerts

Alerts are modal windows that draw the user's attention to crucial information or ask for confirmation before proceeding:

![Alert](images/ui_overview_alert.png)

### Banners

[Banners](banner.html) appear on top of the editor or in tool windows. They inform the user about the state of a specific context and suggest context-related actions and quick fixes.

![Banner](images/ui_overview_banner.png)

## Context menus

Context menus list actions available in the current context and open on right-click:

![Context menu](images/ui_overview_menu.png)

