# Code Completion

<tldr>
Product Help: [Code completion](https://www.jetbrains.com/help/idea/auto-completing-code.html)
</tldr>

Two types of code completion can be provided by custom language plugins: reference completion and contributor-based completion.

Reference completion is easier to implement but supports only the basic completion action.

Contributor-based completion provides more features, supports all completion types
(`Code | Code Completion | Basic` and `Type Matching`),
and can be used, for example, to implement keyword completion.

## Reference Completion

To fill the completion list, the IDE calls [PsiReference.getVariants()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/PsiReference.java) either on the reference at the caret location or on a dummy reference that would be placed at the caret.
This method needs to return an array of objects containing either strings, [PsiElement](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/PsiElement.java) instances or instances of [LookupElement](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/lookup/LookupElement.java) (see [Lookup Items](#lookup-items) below).
If a `PsiElement` instance is returned in the array, the completion list shows the icon for the element.

A common way to implement `getVariants()` is to use the same function for walking up the tree as in [PsiReference.resolve()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/PsiReference.java)
using a [PsiScopeProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/scope/PsiScopeProcessor.java) which collects all declarations passed to its `execute()` method and returns
them as an array for filling the completion list.

### Symbol Reference Completion

Warning:

This API is currently in development and thus in experimental state.
See also [References](declarations-and-references.html#references).

To provide completion variants by a `PsiSymbolReference` implement
[PsiCompletableReference](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/model/psi/PsiCompletableReference.java).

## Contributor-Based Completion

Implementing [CompletionContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/completion/CompletionContributor.java) gives the greatest control over the operation of code completion.
Register in [com.intellij.completion.contributor](https://jb.gg/ipe?extensions=com.intellij.completion.contributor) extension point
and specify the `language` attribute (unless it works on any supported language).

Note:

Note that the Javadoc of that class contains a detailed FAQ for implementing code completion.

The core scenario of using [CompletionContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/completion/CompletionContributor.java) consists of calling the `extend()` method and passing in the [Element Pattern](element-patterns.html)
specifying the context in which this completion variant is applicable.
The [CompletionProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/completion/CompletionProvider.java) then adds the items to show in the completion list.

Keep in mind that the pattern is checked against the leaf PSI element.
To match a composite element, use `withParent()` or `withSuperParent()` methods.

If completion items do not depend on indexes (e.g., keywords), it can be marked as [dumb aware](indexing-and-psi-stubs.html#DumbAwareAPI).

Examples:

* [JUnitPropertiesCompletionContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/junit/properties/src/com/intellij/junit/properties/JUnitPropertiesCompletionContributor.kt) for completing properties in `junit-platform.properties` files.

* [Custom Language Support Tutorial: Completion Contributor](completion-contributor.html)

## Lookup Items

Items shown in the completion list are represented by instances of [LookupElement](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/lookup/LookupElement.java).
These instances are typically created through [LookupElementBuilder](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/lookup/LookupElementBuilder.java).

If there's only one lookup item to be shown, the behavior can be customized via [AutoCompletionPolicy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/lookup/AutoCompletionPolicy.java).

### Lookup Item Attributes

Text
: Shown left-aligned.

Text attributes
: Text color/grayed text, Bold, Italic, Underlined, Strikeout

Tail text
: Shown next to the main item text (not used for prefix matching).
Can be grayed text.
Example: parameter list of a method

Type text
: Shown right-aligned in the lookup list.
Can be grayed text.
Example: containing class of a method

Icon/Type icon
: See [Working with Icons](icons.html).

Insert handler
: The [InsertHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/completion/InsertHandler.java) is called when the item is selected and performs additional modifications of the inserted text.
It can also [show the completion popup](#showing-completion-popup-programmatically) after insertion.
Example: add parentheses for a method call ([ParenthesesInsertHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/completion/util/ParenthesesInsertHandler.java))

### Runtime Presentation

The item presentation can also be performed via (re-usable) [LookupElementRenderer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/lookup/LookupElementRenderer.java).

For expensive calculations (for example, the presentation of an item to be shown depends on other items), use `LookupElementBuilder.withExpensiveRenderer()` to invoke the renderer in the background
while the completion list is already populating.

### Sorting

Use [PrioritizedLookupElement](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/completion/PrioritizedLookupElement.java) to control item sorting
if all lookup items are guaranteed to be provided by this `CompletionContributor`.

## Code Completion FAQ

### Skipping Completion Popup

To skip the completion popup in the current context (for example, inside comments), implement [CompletionConfidence](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/completion/CompletionConfidence.java)
registered in [com.intellij.completion.confidence](https://jb.gg/ipe?extensions=com.intellij.completion.confidence) extension point
.

This can also be used to prevent skipping provided by other plugins by returning `ThreeState.NO` and registering the extension with `order="first"`.

### Showing Completion Popup Programmatically

To trigger completion upon typing a specific character in the editor, override
[TypedHandlerDelegate.checkAutoPopup()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-api/src/com/intellij/codeInsight/editorActions/TypedHandlerDelegate.java)
registered in [com.intellij.typedHandler](https://jb.gg/ipe?extensions=com.intellij.typedHandler) extension point
.

If all conditions match, invoke [AutoPopupController.scheduleAutoPopup()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-impl/src/com/intellij/codeInsight/AutoPopupController.java) and return `Result.STOP`.

### Completion Popup Events

Use [LookupListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/codeInsight/lookup/LookupListener.java) to receive notifications about completion popup lifecycle events.

