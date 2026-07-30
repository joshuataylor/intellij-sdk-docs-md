# Informing Users

<tldr>
UI Guidelines: [Notifications](notification-types.html)
</tldr>

One of the leading design principles is avoiding the use of modal message boxes for notifying the user about errors and other situations that may warrant the user's attention.
As a replacement, the IntelliJ Platform provides multiple non-modal notification UI options.

## Dialogs

<tldr>
UI Guidelines: [Validation Errors](validation-errors.html)
</tldr>

When working in a dialog, do not check the validity of the input and notify the user about invalid data with a modal dialog when the OK button is pressed.
Instead, use
[DialogWrapper.doValidate()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/openapi/ui/DialogWrapper.java)
described in the [Dialogs](dialog-wrapper.html#input-validation) section.

## Editor Hints

For actions invoked from the editor (such as refactorings, navigation actions, and different code insight features), the best way to notify the user about the inability to perform an action is to use the [HintManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/codeInsight/hint/HintManager.java) class.

Its method `showErrorHint()` displays a floating popup above the editor which is automatically hidden when the user starts performing another action in the editor.
Other [HintManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/codeInsight/hint/HintManager.java) methods can be used for displaying other kinds of non-modal notification hints over an editor.

## Editor Banner

<tldr>
UI Guidelines: [Banner](banner.html)
</tldr>

Notifications that appear at the top of the file editor are a great way to ask the user to take an important action that would otherwise impede their experience if ignored (e.g., missing SDK, setup/project configuration requiring user input).

Register an implementation of [EditorNotificationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ui/EditorNotificationProvider.java)
using [com.intellij.editorNotificationProvider](https://jb.gg/ipe?extensions=com.intellij.editorNotificationProvider) extension point
.
If access to indexes is not required, it can be marked [dumb-aware](indexing-and-psi-stubs.html#DumbAwareAPI).

A commonly used UI implementation is [EditorNotificationPanel](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ui/EditorNotificationPanel.java).

## "Got It" Notification

<tldr>
UI Guidelines: [Got It Tooltip](got-it-tooltip.html)
</tldr>

Use to highlight important new/changed features via [GotItTooltip](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/ui/GotItTooltip.kt).

## Notification Balloons

The most general way to display non-modal notifications is to use [notification balloons](notification-balloons.html).

