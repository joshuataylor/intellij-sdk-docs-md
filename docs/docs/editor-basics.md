# Basics of Working with the Editor

This tutorial will lead you through a series of steps showing how to work with the IntelliJ Platform Editor, how to access and modify text it contains, and how to handle events sent to the editor.

* [1. Working with Text](working-with-text.html)

* [2. Editor Coordinates System. Positions and Offsets](coordinates-system.html)

* [3. Handling Editor Events](editor-events.html)

Tip:

The part of the API described in this tutorial only allows operations with "plain text".
For operations that require access to the PSI, please see [Program Structure Interface (PSI)](psi.html).

The following are referenced in the tutorial:

* The [editor_basics](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/editor_basics/) plugin code sample,

* [editor-ui-api package](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/editor-ui-api),

* Those not found in `editor-ui-api` package: * [EditorActionManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/editor/actionSystem/EditorActionManager.java), * [EditorActionHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/editor/actionSystem/EditorActionHandler.java), * [TypedActionHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/editor/actionSystem/TypedActionHandler.java), * [TypedAction](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/editor/actionSystem/TypedAction.java).

Related topics:

* [Action System](action-system.html)

* [Threading Model](threading-model.html)

