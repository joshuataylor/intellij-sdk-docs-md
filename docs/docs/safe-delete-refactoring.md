# Safe Delete Refactoring

<tldr>
Product Help: [Safe delete](https://www.jetbrains.com/help/idea/safe-delete.html)
</tldr>

The Safe Delete refactoring also builds on the same [Find Usages](find-usages.html) framework as [Rename Refactoring](rename-refactoring.html).

In addition to that, to support Safe Delete, a plugin needs to implement two things:

* The [RefactoringSupportProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/refactoring/src/com/intellij/lang/refactoring/RefactoringSupportProvider.java) interface, registered in the [com.intellij.lang.refactoringSupport](https://jb.gg/ipe?extensions=com.intellij.lang.refactoringSupport) extension point , and the `isSafeDeleteAvailable()` method, which checks if the Safe Delete refactoring is available for a specific PSI element

* The [PsiElement.delete()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/psi/PsiElement.java) method for the [PsiElement](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/psi/PsiElement.java) subclasses for which Safe Delete is available. Deleting PSI elements is implemented by deleting the underlying AST nodes from the AST tree (which, in turn, causes the text ranges corresponding to the AST nodes to be deleted from the document).

Example:
[delete()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/properties/properties-common/src/com/intellij/lang/properties/psi/impl/PropertyImpl.java) implementation for a Property in  [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/properties)

If needed, it's possible to further customize how Safe Delete is performed for a particular type of element (e.g., how references are searched) via [SafeDeleteProcessorDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/refactoring/safeDelete/SafeDeleteProcessorDelegate.java).

Example:
[SafeDeleteProcessorDelegate](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/properties/src/com/intellij/lang/properties/refactoring/PropertiesFilesSafeDeleteProcessor.java) implementation for [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/properties)

