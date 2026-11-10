# Popups

The IntelliJ Platform user interface makes extensive use of popups - semi-modal windows that have no chrome (explicit closing buttons) and disappear automatically on focus loss.
Making use of these controls in a plugin ensures a consistent user experience between the plugin and the rest of the IDE.

Popups can optionally display a title, are optionally movable and resizable (and support remembering their size), and can be nested (show another popup when an item is selected).

[JBPopupFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/popup/JBPopupFactory.java) creates popups that display different kinds of components, depending on specific needs.
The most commonly used methods are:

| Method |Description |
-----------------------
| `createComponentPopupBuilder()` |Generic, allows showing any [Swing](https://docs.oracle.com/javase/tutorial/uiswing/) component.  See [ComponentPopupBuilder](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/popup/ComponentPopupBuilder.java)'s methods for possible options.  Example: [IntentionPreviewPopupUpdateProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/codeInsight/intention/impl/preview/IntentionPreviewPopupUpdateProcessor.kt) creating a popup rendering the intention preview.   |
| `createPopupChooserBuilder()` |For choosing one or more items from a plain `java.util.List`.  See [PopupChooserBuilder](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/popup/PopupChooserBuilder.java)'s methods for possible options.  Example: [ShowMessageHistoryAction](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/vcs-impl/src/com/intellij/openapi/vcs/actions/ShowMessageHistoryAction.kt) creating a popup with recent commit messages history in the commit message text area.   |
| `createConfirmation()` |For choosing between two options, and performing different actions depending on which option is selected.  Example: [VariableInplaceRenamer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/refactoring/rename/inplace/VariableInplaceRenamer.java) creating confirmation popup after invalid variable name is provided in the inplace rename action.   |
| `createActionGroupPopup()` |Show actions from an [Action Group](grouping-actions-tutorial.html) and executes the action selected by the user.  Example: [ShowRecentFindUsagesGroup](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/find/impl/ShowRecentFindUsagesGroup.java) invoked via `Edit / Find Usages / Recent Find Usages` and showing recent find usages group popup.   |

## Action Groups

Action group popups support different ways of choosing an action from the keyboard, in addition to the normal arrow keys.
Pass one of the constants in the [JBPopupFactory.ActionSelectionAid](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/popup/JBPopupFactory.java) enumeration to choose whether an action can be selected by

* pressing a key corresponding to its sequential number

* typing part of its text (speed search)

* pressing a mnemonic character

For popups with a fixed set of items, the recommended selection method is sequential numbering.
For popups with a variable and potentially large number of items, speed search typically works best.

## List Popups

To create a list-like popup which is more flexible than a simple
[JList](https://docs.oracle.com/en/java/javase/24/docs/api/java.desktop/javax/swing/JList.html)
and doesn't represent the possible choices as actions in an action group, use
[JBPopupFactory.createListPopup()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/popup/JBPopupFactory.java)
with a
[ListPopupStep](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/ide-core/src/com/intellij/openapi/ui/popup/ListPopupStep.java)
implementation (usually, [BaseListPopupStep](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/popup/util/BaseListPopupStep.java) is used as a base).
The key methods to override are:

* `getTextFor()` - returning the text to display for an item

* `onChosen()` - called when an item is selected

Return a new popup step from the `onChosen()` method to implement hierarchical (nested) popups.

## Showing Popup

Once the popup is created, display it by calling one of the `show()` methods.
Let the IntelliJ Platform automatically choose the position based on the context, by calling `showInBestPositionFor()`, or specify the position explicitly through methods like `showUnderneathOf()` and `showInCenterOf()`.

Note:

The `show()` methods return immediately and do not wait for the popup to be closed.

To perform some action when the popup is closed, use one of the following approaches:

* attach a listener to it using the `addListener()` method

* override a method of the popup contents such as [PopupStep.onChosen()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-ui/src/openapi/ui/popup/PopupStep.java)

* attach an event handler to a custom component within the popup

