# Split Icon Button

<tldr>
Implementation: [SplitButtonAction](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/openapi/actionSystem/SplitButtonAction.java)
</tldr>

A split icon button appears on a horizontal [toolbar](toolbar.html) and consists of two parts: the main icon and a triangle icon for the action list.

![Split icon button](images/split_icon_button.png)

## When to use

Use the split icon button to reduce the number of actions on a horizontal toolbar if all the following conditions are met:

* There are already many controls on the toolbar.

* There is a group of similar actions.

* The user invokes one action more often than others. Or the user invokes one action several times, then switches to another action and invokes it several times but does not switch between actions too often.

Note:
To decide whether to add actions to the toolbar, follow the [Toolbar](toolbar.html#what-items-to-add-on-toolbar) guidelines.

## How to use

### Add icons to all menu actions

Make sure that all actions in the drop-down menu have icons. When an action is selected, its icon will be shown on the toolbar.

![Split icon button main action icon](images/split_icon_button_main_action_icon.png)

### Disable unavailable actions

Do not hide the unavailable actions but show them as disabled to help users locate them in the future. The action menu should always open even if all the items in it are disabled.

![Split icon button disabled item](images/split_icon_button_disabled_item.png)

