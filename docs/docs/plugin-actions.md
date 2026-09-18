# Actions

The IntelliJ Platform provides the concept of actions.
An action is a class derived from [AnAction](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/AnAction.java), whose `actionPerformed()` method is called when its menu item or toolbar button is selected.

Actions are the most common way for a user to invoke the functionality of your plugin.
An action can be invoked from a menu or a toolbar, using a keyboard shortcut or the `Help | Find Action...` lookup.

Actions are organized into groups, which, in turn, can contain other groups.
A group of actions can form a toolbar or a menu.
Subgroups of the group can form submenus of a menu.

The user can customize all registered actions via [Menus and Toolbars](https://www.jetbrains.com/help/idea/customize-actions-menus-and-toolbars.html) settings.

Please see [Action System](action-system.html) on how to create and register actions in the IDE.

