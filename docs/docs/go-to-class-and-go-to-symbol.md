# Go to Class and Go to Symbol

<tldr>
Product Help: [Searching Everywhere](https://www.jetbrains.com/help/idea/searching-everywhere.html)
</tldr>

A custom language plugin can provide its items to be included in the lists shown when the user chooses the `Navigate | Class` or `Navigate | Symbol` action.

Provide implementations of [ChooseByNameContributorEx](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/navigation/ChooseByNameContributorEx.java) interface (separate implementations need to be provided for Class and Symbol, respectively), and register them
in the [com.intellij.gotoClassContributor](https://jb.gg/ipe?extensions=com.intellij.gotoClassContributor) extension point
or [com.intellij.gotoSymbolContributor](https://jb.gg/ipe?extensions=com.intellij.gotoSymbolContributor) extension point
.

Each `ChooseByNameContributorEx` implementation must provide the following methods:

* `processNames(@NotNull Processor<? super String> processor, @NotNull GlobalSearchScope scope, @Nullable IdFilter filter)` Feeds the processor with a complete list of names available in a specified scope, which the IDE will then filter according to the text typed by the user in the dialog. Using [Indexing and PSI Stubs](indexing-and-psi-stubs.html) to obtain matching candidates is highly recommended to improve performance.

* `processElementsWithName(String name, Processor<? super NavigationItem> processor, FindSymbolParameters parameters)` Feeds the processor with a list of [NavigationItem](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/navigation/NavigationItem.java) instances (typically [PsiElement](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/PsiElement.java)) matching the given name and parameters. Processed `NavigationItem`s specify the destinations to jump to when a specific item is selected from the list.

Example:

* [Custom Language Support Tutorial: Go To Symbol Contributor](go-to-symbol-contributor.html)

