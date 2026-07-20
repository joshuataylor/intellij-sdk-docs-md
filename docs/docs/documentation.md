# Documentation

<tldr>
Product Help: [Quick Documentation](https://www.jetbrains.com/help/idea/viewing-reference-information.html#inline-quick-documentation)
</tldr>

Custom languages can display documentation for various constructs, such as functions, methods, classes, or others, directly within the IDE.
To access the documentation, users can either select `View | Quick Documentation` or hover over a symbol.
This will open a popup that displays type information, parameters, usage descriptions, or examples.
The source of the documentation content can vary.
While it is often extracted from comments in the source code (e.g., Javadoc comments),
external resources, such as web pages, can also be accessed.

From IntelliJ Platform version 2023.1 onwards, plugin developers can choose to implement
one of three extension points (EPs) from the new Documentation Target API based on the specific use-case.
These EPs enable building documentation from
[offsets in the current editor](coordinates-system.html#editor-coordinate-systems),
[PSI elements](psi-elements.html), or [Symbols](symbols.html).
Detailed information on implementing these EPs can be found in the [Documentation Target API](#documentation-target-api) section.

Note: Targeting IDEs before 2023.1

Plugins targeting versions earlier than 2023.1 must use the [Documentation Provider API](#documentation-provider-api).
Note that as long as the transition to the new API is
not complete, the [custom language tutorial](documentation-provider.html) will continue using `DocumentationProvider`.

## Documentation Target API

Custom language developers have the flexibility to select from three distinct EPs for providing documentation to their users.
To ensure clarity and avoid confusion, we provide a high-level summary of the overall approach,
outlining the primary components and their interactions.

Procedure: Overall Approach

`DocumentationTargetProvider`
: Implement
[DocumentationTargetProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/platform/backend/documentation/DocumentationTargetProvider.java)
and register it as [com.intellij.platform.backend.documentation.targetProvider](https://jb.gg/ipe?extensions=com.intellij.platform.backend.documentation.targetProvider) extension point
to build documentation
for a certain offset in a `PsiFile` by overriding `documentationTargets()`.

`PsiDocumentationTargetProvider`
: Implement
[PsiDocumentationTargetProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/platform/backend/documentation/PsiDocumentationTargetProvider.java)
and register it as [com.intellij.platform.backend.documentation.psiTargetProvider](https://jb.gg/ipe?extensions=com.intellij.platform.backend.documentation.psiTargetProvider) extension point
to build documentation
for PSI elements by overriding `documentationTarget()`.

`SymbolDocumentationTargetProvider`
: Implement
[SymbolDocumentationTargetProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/platform/backend/documentation/SymbolDocumentationTargetProvider.java)
and register it as [com.intellij.platform.backend.documentation.symbolTargetProvider](https://jb.gg/ipe?extensions=com.intellij.platform.backend.documentation.symbolTargetProvider) extension point
to build documentation
for [Symbols](symbols.html) by overriding `documentationTarget()`.

### 

`DocumentationTarget`

Each of the implementations above returns instances of
[DocumentationTarget](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/platform/backend/documentation/DocumentationTarget.kt).
The main work is done in `computeDocumentation()` where the documentation is built from the available
information.
If a plugin implemented the now deprecated
[DocumentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/lang/documentation/DocumentationProvider.java)
before, then `computeDocumentation()` should do the work that was formerly done in
`DocumentationProvider.generateDoc()`.

In addition to showing the documentation, the `computeDocumentationHint()` method returns the text to be displayed
when the user hovers over an element with `Ctrl`/`Cmd` pressed or when
`Settings | Editor | Code Editing | Show quick documentation on hover` is enabled.
In the old API, this method was called `DocumentationProvider.getQuickNavigateInfo()`.

The `createPointer()` method manages instance restoration and ensures access to the entity across different read actions.
When implementing the `createPointer()` method, it is essential to handle invalidated PSI elements.
Unlike PSI elements, the `DocumentationTarget` API does not include an `isValid()` method and the returned pointer is expected
to be `null` if the instance (and all contained objects) cannot be restored.
See
[KotlinDocumentationTarget.createPointer()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/kotlin/code-insight/kotlin.code-insight.k2/src/org/jetbrains/kotlin/idea/k2/codeinsight/quickDoc/KotlinDocumentationTarget.kt)
as a reference.

### Examples

* [KotlinPsiDocumentationTargetProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/kotlin/code-insight/kotlin.code-insight.k2/src/org/jetbrains/kotlin/idea/k2/codeinsight/quickDoc/KotlinPsiDocumentationTargetProvider.kt)

* [KotlinDocumentationTarget](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/kotlin/code-insight/kotlin.code-insight.k2/src/org/jetbrains/kotlin/idea/k2/codeinsight/quickDoc/KotlinDocumentationTarget.kt)

* [PsiElementDocumentationTarget](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/lang/documentation/psi/PsiElementDocumentationTarget.kt)

## Documentation Provider API

Note: Deprecation Notice

As of IntelliJ Platform version 2023.1, the Documentation Provider API is deprecated and plugin
authors should use the [Documentation Target API](#documentation-target-api) instead.

Custom language developers usually extend from
[AbstractDocumentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/lang/documentation/AbstractDocumentationProvider.java)
instead of implementing the
[DocumentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/lang/documentation/DocumentationProvider.java) interface.
This implementation needs to be registered in [com.intellij.lang.documentationProvider](https://jb.gg/ipe?extensions=com.intellij.lang.documentationProvider) extension point
.

The main work is done in `generateDoc()`, which has two PSI element arguments:
the target element for which the documentation is requested and the original element under the cursor.
If IntelliJ Platform's choice of the target element isn't suitable for your language, you can override `getCustomDocumentationElement()`
and provide the correct element.

Once these steps are completed, the following additional features can be implemented:

* Implement `getQuickNavigateInfo()` to provide the text that should be displayed when an element is hovered over with `Ctrl`/`Cmd` pressed.

* Implement `generateHoverDoc()` to show different contents on mouse hover.

* Implement `getDocumentationElementForLookupItem()` to return a suitable PSI element for the given lookup element when `View | Quick Documentation` is called on an element of the autocompletion popup.

* Implement `getUrlFor()` and [ExternalDocumentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/lang/documentation/ExternalDocumentationProvider.java) to fetch documentation for elements from online resources.

### Examples

The [custom language tutorial](documentation-provider.html) contains a step-by-step guide for the `DocumentationProvider` of the Simple language.
In addition, several implementations of other languages exist in the IntelliJ Platform code, for instance:

* The [Properties Language plugin](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/properties) has a small and easy-to-understand [DocumentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/properties/src/com/intellij/lang/properties/PropertiesDocumentationProvider.java) similar to the one shown in the custom language tutorial.

* Usage examples for `DocumentationMarkup` can be found in [ThemeJsonDocumentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/devkit/intellij.devkit.themes/src/ThemeJsonDocumentationProvider.java).

## Further tips

Additionally, custom actions can be incorporated into documentation inlays and popups using the
[DocumentationActionProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/codeInsight/documentation/DocumentationActionProvider.java).
This provider should be registered with the [com.intellij.documentationActionProvider](https://jb.gg/ipe?extensions=com.intellij.documentationActionProvider) extension point
.

How the documentation for the target element is created is up to the custom language developer.
A common choice is to extract and format documentation comments.
To format the documentation contents, you should use
[DocumentationMarkup](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/lang/documentation/DocumentationMarkup.java)
to achieve a consistent output.

Tip:

Use [HtmlSyntaxInfoUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/openapi/editor/richcopy/HtmlSyntaxInfoUtil.java) to create Lexer-based highlighted code samples.

