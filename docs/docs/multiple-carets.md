# Multiple Carets

<tldr>
Product Help: [Multiple cursors and selection ranges](https://www.jetbrains.com/help/idea/multicursor.html)
</tldr>

Most editor actions (keyboard navigation, text insertion and deletion, etc.) will be applied to each caret independently.
Each caret has its own associated selection, which is a continuous range of document characters (can be empty).
When after some action two or more carets end up in the same visual position, they are merged into a single caret with their associated selections merged into a single one.
A similar thing will happen when selections for several carets become overlapped: only one of the carets will remain, and the selections will be merged.

There's a concept of primary caret — the one on which non-multi-caret-aware actions and the actions which need a single-point document context (like code completion) will operate.
Currently, the most recent caret is considered the primary one.

## Core Functionality

Core logic related to multi-caret implementation such as accessing currently existing carets, adding and removing carets, is available via [CaretModel](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/editor-ui-api/src/com/intellij/openapi/editor/CaretModel.java).
For text selection, see [SelectionModel](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/editor-ui-api/src/com/intellij/openapi/editor/SelectionModel.java).

Methods in `CaretModel` and `SelectionModel` to query and modify caret and selection positions work by default on the primary caret.
In the context of `CaretModel.runForEachCaret()` method though, they operate on the current caret.

`SelectionModel.getBlockSelectionStarts()` and `getBlockSelectionEnds()` work in multi-caret state, returning all selected regions.

## Editor Actions

### 

`EditorAction` and `EditorActionHandler`

When [EditorActionHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/editor/actionSystem/EditorActionHandler.java) is invoked, an additional parameter will be passed to it: a caret instance on which it should operate, or `null` if it's invoked without any caret context.
If the handler invokes another handler (delegate handler for the same `actionId` or a completely unrelated handler), that parameter should normally be passed to the delegate unchanged (unless no context caret has been provided to the handler, but it needs to invoke another handler on a specific caret).
Of course, the handler can just ignore the caret parameter if its functionality is not related to caret/selection position.

If the handler needs to implement multi-caret functionality it can do so explicitly in the overridden `doExecute` method, but if it just needs that method to be invoked for each caret, it suffices to pass a parameter to `EditorActionHandler` constructor to make `doExecute` called for each caret when the handler is invoked without a specific caret context.

### Editor Action Delegates

The following delegates are available:

* [EnterHandlerDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/codeInsight/editorActions/enter/EnterHandlerDelegate.java)

* [BackspaceHandlerDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/codeInsight/editorActions/BackspaceHandlerDelegate.java)

* [JoinLinesHandlerDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/codeInsight/editorActions/JoinLinesHandlerDelegate.java)

* [EditorNavigationDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/editor/EditorNavigationDelegate.java)

* [SmartEnterProcessor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/codeInsight/editorActions/smartEnter/SmartEnterProcessor.java)

* [CommentCompleteHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/codeInsight/editorActions/CommentCompleteHandler.java)

* [StatementUpDownMover](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/codeInsight/editorActions/moveUpDown/StatementUpDownMover.java)

* [CodeBlockProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/codeInsight/editorActions/CodeBlockProvider.java)

There is no need to make any changes in the handlers to support multiple carets — they are already invoked for each caret.

## Typing Actions

### 

`TypedActionHandler`, `TypedHandlerDelegate`

[TypedActionHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/editor/actionSystem/TypedActionHandler.java) and [TypedHandlerDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/codeInsight/editorActions/TypedHandlerDelegate.java) implementations are invoked only once for each typed character.
If those handlers need to support multiple carets, they will need to implement that explicitly.

[EditorModificationUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/editor/EditorModificationUtil.java).
`typeInStringAtCaretHonorMultipleCarets()` method is available to do the most common task in this case: inserting the same text into all caret positions and/or moving all carets relatively to their current position.
Examples of its usage:

* [TypedAction](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/editor/actionSystem/TypedAction.java).

* [XmlGtTypedHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/xml/xml-ui-common/src/com/intellij/codeInsight/editorActions/XmlGtTypedHandler.java).

Note:

[TypedHandlerDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/codeInsight/editorActions/TypedHandlerDelegate.java) implementations are invoked automatically for each caret.
If one wants to implement custom multicaret behaviour on typing, [TypedActionHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/editor/actionSystem/TypedActionHandler.java) needs to be provided instead.

## Code Insight Actions

Existing actions inheriting from [CodeInsightAction](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/codeInsight/actions/CodeInsightAction.java) will work for primary caret only.
To support multiple carets, one should subclass [MultiCaretCodeInsightAction](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/codeInsight/actions/MultiCaretCodeInsightAction.java) instead.
Each caret might have a different editor and PSI instance, so using the old API is not possible.

