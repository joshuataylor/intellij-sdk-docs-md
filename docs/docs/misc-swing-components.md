# Miscellaneous Swing Components

## 

`Messages`

[Messages](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/Messages.java) provides a way to show simple
message boxes, input dialogs (modal dialogs with a text field), and chooser dialogs (modal dialogs with a combo box).
On macOS, the message boxes use the native UI.

The `showCheckboxMessageDialog()` function provides an easy way to implement a Do not show this again checkbox on messages.

Tip: Avoid Modal Dialogs

It is recommended to use non-modal notifications instead of modal message boxes whenever appropriate.
Refer to the [Notification Balloons](notification-balloons.html) topic for more information.

## 

`JBSplitter`

[JBSplitter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/JBSplitter.java) is a replacement for the standard
[Swing JSplitPane](https://docs.oracle.com/en/java/javase/24/docs/api/java.desktop/javax/swing/JSplitPane.html).
Unlike some other JetBrains-enhanced Swing components, it is not a drop-in replacement and has a different API.
However, to achieve a consistent user experience, it is recommended to use `JBSplitter` instead of the standard `JSplitPane`.

To add components to the splitter, call the `setFirstComponent()` and `setSecondComponent()` methods.

`JBSplitter` supports automatic remembering of the split proportion.
To enable it, call the `setSplitterProportionKey()` method and pass the unique ID under which the proportion will be stored.

## 

`JBTabs`

[JBTabs](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/tabs/JBTabs.java) is an implementation of the tab control, used for editor tabs and a few other components.
It has a significantly different look & feel compared to the standard Swing tabs and looks less native on the macOS platform,
so it's up to the developer to choose which tab control would be more appropriate.

## Toolbars

See [Toolbar](toolbar.html) in the UI Guidelines for an overview.

[Building a Toolbar/Popup Menu from Actions](action-system.html#buildingToolbarPopupMenu) covers creating `AnAction`-based toolbars.

