# Additional Minor Features

A number of commonly used minor features are listed in the following format:

EP: `fully.qualified.extensionPointName` — Extension Point Name (must be specified in `[plugin.xml](plugin-configuration-file.html)`). Click to browse usages in existing implementations of open-source plugins.

`com.extensionPoint.class` description text — Extension Point class/interface to provide functionality

Tip: Locating more Language EPs

See also [LangExtensionPoints.xml](intellij-platform-extension-point-list.html#langextensionpointsxml) to discover more Language-related Extension Points
as well as the general guide [Explore the IntelliJ Platform API](explore-api.html).

## Editing

### Brace Matching

EP: [com.intellij.lang.braceMatcher](https://jb.gg/ipe?extensions=com.intellij.lang.braceMatcher)

[PairedBraceMatcher](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/lang/PairedBraceMatcher.java)
returns an array of brace pairs ([BracePair](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/lang/BracePair.java)) specifying the characters for the opening and closing braces and the lexer token types for these characters.
(In principle, it is possible to return multi-character tokens, like "begin" and "end", as the start and end tokens of a brace pair.
The IDE will match such braces, but the highlighting for such braces will not be entirely correct.)

Certain types of braces can be marked as structural.
Structural braces have higher priority than regular braces: they are matched with each other even if there are unmatched braces of different types between them.
An opening non-structural brace is not matched with a closing one if one of them is inside a pair of matched structural braces and another is outside.
See also [Recognizing Complex Multi-Block Expressions](#recognizing-complex-multi-block-expressions).

#### "Heavy" Brace Matching

EP: [com.intellij.heavyBracesHighlighter](https://jb.gg/ipe?extensions=com.intellij.heavyBracesHighlighter)

If the brace matching is "too heavy" and should not be executed in [EDT](threading-model.html), implement
[HeavyBraceHighlighter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/codeInsight/highlighting/HeavyBraceHighlighter.java).

### Quote Handling

EP: [com.intellij.lang.quoteHandler](https://jb.gg/ipe?extensions=com.intellij.lang.quoteHandler)

To support the Insert pair quote feature, provide [QuoteHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/codeInsight/editorActions/QuoteHandler.java).
In most cases, [SimpleTokenSetQuoteHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/codeInsight/editorActions/SimpleTokenSetQuoteHandler.java) base implementation will be suitable.

### Comment Code

EP: [com.intellij.lang.commenter](https://jb.gg/ipe?extensions=com.intellij.lang.commenter)

[Commenter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/lang/Commenter.java) returns the prefix for the line comment, and the prefix and suffix for the block comment if supported by the language.
For more complex logic, use [SelfManagingCommenter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/codeInsight/generation/SelfManagingCommenter.java).

* [Custom Language Support Tutorial: Commenter](commenter.html)

### Code Folding

EP: [com.intellij.lang.foldingBuilder](https://jb.gg/ipe?extensions=com.intellij.lang.foldingBuilder)

[FoldingBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/lang/folding/FoldingBuilder.java) returns the list of foldable text ranges (as an array of [FoldingDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/lang/folding/FoldingDescriptor.java) objects), the replacement text which is shown for each range when it is folded, and the default state of each folding region (folded or unfolded).

* [Custom Language Support Tutorial: Folding Builder](folding-builder.html)

### Join Lines

EP: [com.intellij.joinLinesHandler](https://jb.gg/ipe?extensions=com.intellij.joinLinesHandler)

[JoinLinesHandlerDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/editorActions/JoinLinesHandlerDelegate.java) allows extending support smart/semantic `Edit | Join Lines` (e.g., String literal split on multiple lines).

### Smart Enter

EP: [com.intellij.lang.smartEnterProcessor](https://jb.gg/ipe?extensions=com.intellij.lang.smartEnterProcessor)

[SmartEnterProcessor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/editorActions/smartEnter/SmartEnterProcessor.java) handles `Edit | Complete Statement` (e.g., autocomplete missing semicolon/parentheses).

### Move Element Left/Right

EP: [com.intellij.moveLeftRightHandler](https://jb.gg/ipe?extensions=com.intellij.moveLeftRightHandler)

Return children of the given element from [MoveElementLeftRightHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/editorActions/moveLeftRight/MoveElementLeftRightHandler.java) for `Code | Move Element Left|Right`, e.g., method call parameters.
Alternatively, implement [PsiListLikeElement](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/PsiListLikeElement.java) in the PSI element.

### Move Statements Up and Down in the Editor

EP: [com.intellij.statementUpDownMover](https://jb.gg/ipe?extensions=com.intellij.statementUpDownMover)

[StatementUpDownMover](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/editorActions/moveUpDown/StatementUpDownMover.java)
allows for customizing the behavior of moving statements up and down.
This can be used to keep code syntactically correct when moving code in the editor, e.g., when moving
a variable declaration.

### Splitting and Joining List Constructs

EP: [com.intellij.listSplitJoinContext](https://jb.gg/ipe?extensions=com.intellij.listSplitJoinContext)

[ListSplitJoinContext](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/openapi/editor/actions/lists/ListSplitJoinContext.kt)
needs to be implemented to define the exact behavior of splitting and joining list-like constructs in a language.
The UI will show implementations of this EP as an
[intention action](https://www.jetbrains.com/help/idea/intention-actions.html)
at appropriate locations.
Developers can use the abstract classes in
[DefaultListSplitJoinContext](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/openapi/editor/actions/lists/DefaultListSplitJoinContext.kt)
for their implementation.

* [XmlAttributesSplitJoinContext](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/xml/impl/src/com/intellij/codeInsight/intentions/XmlAttributesSplitJoinContext.kt)

### Recognizing Complex Multi-Block Expressions

EP: [com.intellij.codeBlockSupportHandler](https://jb.gg/ipe?extensions=com.intellij.codeBlockSupportHandler)

[CodeBlockSupportHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/codeInsight/highlighting/CodeBlockSupportHandler.java)
allows providing text ranges for more complex code blocks like, e.g., in `if`/`elsif`/`else` blocks.
It is used to highlight markers and keywords if one is under the cursor, and for navigation to the beginning/end of blocks.
See also [Brace Matching](#brace-matching).

## Highlighting

### Reference Injection

EP: [com.intellij.referenceInjector](https://jb.gg/ipe?extensions=com.intellij.referenceInjector)

[ReferenceInjector](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/psi/injection/ReferenceInjector.java) allows users to inject pre-defined references (e.g., "Encoding", "File Reference") into `PsiLanguageInjectionHost` elements (IntelliLang plugin required).

### Prevent Error Highlighting of Files

EP: [com.intellij.problemHighlightFilter](https://jb.gg/ipe?extensions=com.intellij.problemHighlightFilter)
, [com.intellij.problemFileHighlightFilter](https://jb.gg/ipe?extensions=com.intellij.problemFileHighlightFilter)

[ProblemHighlightFilter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/codeInsight/daemon/ProblemHighlightFilter.java) and
the [com.intellij.problemFileHighlightFilter](https://jb.gg/ipe?extensions=com.intellij.problemFileHighlightFilter) extension point
(which implements
[Condition&lt;VirtualFile&gt;](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/src/com/intellij/openapi/util/Condition.java))
are used to filter out files that should not be error-highlighted because they are, e.g., outside
the current project scope.
Note that these filters should be permissive and only prevent highlighting for files that are absolutely
known to be outside the scope.

### Semantic Highlight Usages

EP: [com.intellij.highlightUsagesHandlerFactory](https://jb.gg/ipe?extensions=com.intellij.highlightUsagesHandlerFactory)

[HighlightUsagesHandlerFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/codeInsight/highlighting/HighlightUsagesHandlerFactory.java) allows highlighting e.g., Exit Points or Exceptions.
Can be [DumbAware API](indexing-and-psi-stubs.html#DumbAwareAPI) (2024.3+).

## Navigation

### Context Info

EP: [com.intellij.declarationRangeHandler](https://jb.gg/ipe?extensions=com.intellij.declarationRangeHandler)

[DeclarationRangeHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/hint/DeclarationRangeHandler.java) provides `View | Context Info` for custom languages with structure view implementation based on a [TreeBasedStructureViewBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/ide/structureView/TreeBasedStructureViewBuilder.java).

### Breadcrumbs

EP: [com.intellij.breadcrumbsInfoProvider](https://jb.gg/ipe?extensions=com.intellij.breadcrumbsInfoProvider)

[BreadcrumbsProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/ui/breadcrumbs/BreadcrumbsProvider.java)
allows for language-specific [breadcrumbs](https://www.jetbrains.com/help/idea/navigating-through-the-source-code.html#editor_breadcrumbs).
[Sticky Lines](https://www.jetbrains.com/help/idea/sticky-lines.html) feature also uses this data.

## IDE Integration

### TODO View

[ParserDefinition.getCommentTokens()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/lang/ParserDefinition.java) must return the set of tokens treated as comments to populate the TODO tool window.

### Color Preview/Chooser

EP: [com.intellij.colorProvider](https://jb.gg/ipe?extensions=com.intellij.colorProvider)

[ElementColorProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/openapi/editor/ElementColorProvider.java) renders a gutter icon for an element containing color information.

### File Includes

EP: [com.intellij.include.provider](https://jb.gg/ipe?extensions=com.intellij.include.provider)

[FileIncludeProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/psi/impl/include/FileIncludeProvider.java) provides information about include statements resolving to files (e.g., `<xi:include>` in XML).
Including/included files can then be obtained via [FileIncludeManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/psi/impl/include/FileIncludeManager.java).

### Plain Text Completion

EP: [com.intellij.completion.plainTextSymbol](https://jb.gg/ipe?extensions=com.intellij.completion.plainTextSymbol)

[PlainTextSymbolCompletionContributor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/codeInsight/completion/PlainTextSymbolCompletionContributor.java)
provides a simple way to extract lookup elements from a file so that users have completion available
in, e.g., plain text editors like VCS commit messages.

### Reader Mode

EP: [com.intellij.readerModeMatcher](https://jb.gg/ipe?extensions=com.intellij.readerModeMatcher)

[ReaderModeMatcher](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/codeInsight/actions/ReaderModeMatcher.kt)
provides a way to decide if files are shown in the correct mode: reader mode vs. normal editor mode.
Please see
[the documentation](https://www.jetbrains.com/help/idea/reader-mode.html)
to get familiar with reader mode.

### Provide Fully Qualified Names (FQN) for Elements

EP: [com.intellij.qualifiedNameProvider](https://jb.gg/ipe?extensions=com.intellij.qualifiedNameProvider)

[QualifiedNameProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/refactoring/src/com/intellij/ide/actions/QualifiedNameProvider.java)
provides features like copying and pasting references of FQN for, e.g., classes, functions, or methods.
Therefore, the `QualifiedNameProvider` implementation needs to provide logic to convert from and to FQN.

### Customized "Copy Path"

Extend from [CopyPathProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/ide/actions/CopyPathProvider.kt)
[action](action-system.html) (or `DumbAwareCopyPathProvider` if [no indexes are needed](indexing-and-psi-stubs.html#DumbAwareAPI))
and return a custom (language-specific) path from `getPathToElement()`.
Register the action with the popup menu group `<add-to-group group-id="CopyReferencePopupGroup"/>`.

* [CopyRepositoryRootPathProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/plugins/git4idea/backend/src/actions/CopyRepositoryRootPathProvider.kt)

### Label Files as Test Files

EP: [com.intellij.testSourcesFilter](https://jb.gg/ipe?extensions=com.intellij.testSourcesFilter)

[TestSourcesFilter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/roots/TestSourcesFilter.java)
allows for telling the IDE that a file is a test file; even it's not located in a directory marked as
test root.
This can be used in situations where test files are located next to source files.
If these files can be distinguished either by filename or content from source files, implementing this
EP will mark them as test files for the IDE.

## Refactoring

### Naming Suggestions

EP: [com.intellij.nameSuggestionProvider](https://jb.gg/ipe?extensions=com.intellij.nameSuggestionProvider)

[NameSuggestionProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/refactoring/src/com/intellij/refactoring/rename/NameSuggestionProvider.java) provides name suggestions for the given element, e.g., for [Rename refactoring](rename-refactoring.html).

### Suggesting Rename and Change Signature Refactorings

EP: [com.intellij.suggestedRefactoringSupport](https://jb.gg/ipe?extensions=com.intellij.suggestedRefactoringSupport)

[SuggestedRefactoringSupport](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/refactoring/suggested/SuggestedRefactoringSupport.kt)
provides functionality for suggesting rename and change signature refactorings for custom languages.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

