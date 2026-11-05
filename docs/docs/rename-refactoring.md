# Rename Refactoring

<tldr>
Product Help: [Rename refactorings](https://www.jetbrains.com/help/idea/rename-refactorings.html)
</tldr>

The Rename refactoring operation is quite similar to that of [Find Usages](find-usages.html).
It uses the same rules for locating the element to be renamed and the same index of words for finding the files that may have references to the element being renamed.

When the rename refactoring is performed, the method [PsiNamedElement.setName()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/PsiNamedElement.java) is called for the renamed element, and [PsiReference.handleElementRename()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/PsiReference.java) is called for all references to the renamed element.
These methods perform basically the same action: replace the underlying AST node of the PSI element with the node containing the new text entered by the user.
Creating an entirely correct AST node from scratch is quite tricky.
Thus, surprisingly, the easiest way to get the replacement node is to create a dummy file in the custom language so that it would contain the necessary node in its parse tree, build the parse tree and extract the required node from it.

Examples:

* [setName()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties/properties-common/src/com/intellij/lang/properties/psi/impl/PropertyImpl.java) implementation for a [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties)

* [Custom Language Support Tutorial: Reference Contributor](reference-contributor.html)

If a renamed reference extends [PsiReferenceBase](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/PsiReferenceBase.java), renaming is performed by invoking the [ElementManipulator.handleContentChange()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/ElementManipulator.java), responsible for handling the content change and calculating the text range of reference inside the element.

To disable renaming for specific elements, implement `com.intellij.openapi.util.Condition<T>` for PsiElement of type `T` and register it
in [com.intellij.vetoRenameCondition](https://jb.gg/ipe?extensions=com.intellij.vetoRenameCondition) extension point
.

## Name Validation

[NamesValidator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/analysis-api/src/com/intellij/lang/refactoring/NamesValidator.java) allows a plugin to check if the name entered by the user in the `Rename` dialog is a valid identifier (and not a keyword) according to the custom language rules.
If an implementation of this interface is not provided by the plugin, Java rules for validating identifiers are used.
Implementations of `NamesValidator` are registered in the [com.intellij.lang.namesValidator](https://jb.gg/ipe?extensions=com.intellij.lang.namesValidator) extension point
.

Example:
[PropertiesNamesValidator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties/src/com/intellij/lang/properties/PropertiesNamesValidator.java) for [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties)

Another way to check is
[RenameInputValidator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/refactoring/src/com/intellij/refactoring/rename/RenameInputValidator.java),
unlike `NamesValidator` it allows you to more flexibly check the entered name for correctness based on the rule defined in the `isInputValid()` method.

To determine which elements this validator will apply to, override the `getPattern()` method returning the pattern of the element to validate.

Example:
[YAMLAnchorRenameInputValidator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/yaml/backend/src/resolve/YAMLAnchorRenameInputValidator.java) validating YAML language anchor names

`RenameInputValidator` can be extended to
[RenameInputValidatorEx](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/refactoring/src/com/intellij/refactoring/rename/RenameInputValidatorEx.java)
to override the default error message.
The `getErrorMessage()` method should return a custom error message in case of an invalid name, or `null` otherwise.

Note that `getErrorMessage()` only works if all `RenameInputValidator` accept the new name in `isInputValid()` and the name is a valid identifier for the language of the element.

Example:
[YamlKeyValueRenameInputValidator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/yaml/src/refactoring/rename/YamlKeyValueRenameInputValidator.java) validating YAML language keys

Implementations of `RenameInputValidator` or `RenameInputValidatorEx` are registered in the [com.intellij.renameInputValidator](https://jb.gg/ipe?extensions=com.intellij.renameInputValidator) extension point
.

## Custom Rename UI and Workflow

Further customization of the Rename refactoring processing is possible on multiple levels.
Providing a custom implementation of the [RenameHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/refactoring/src/com/intellij/refactoring/rename/RenameHandler.java) interface allows you to entirely replace the UI and workflow of the rename refactoring, and also to support renaming something which is not a [PsiElement](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/PsiElement.java) at all.

Example:
[PropertyRenameHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/groovy/src/org/jetbrains/plugins/groovy/refactoring/rename/PropertyRenameHandler.java) for renaming a Groovy property

If you're okay with the standard UI but need to extend the default logic of renaming, you can provide an implementation of the [RenamePsiElementProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/refactoring/rename/RenamePsiElementProcessor.java) interface.
This allows you to:

* Rename an element different from the one on which the action was invoked (a super method, for example)

* Rename multiple elements at once (if their names are linked according to the logic of your language)

* Check for name conflicts (existing names, etc.)

* Customize how a search for code references or text references is performed

* etc.

Example:
[RenamePsiElementProcessor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties/src/com/intellij/lang/properties/refactoring/rename/RenamePropertyProcessor.java) for renaming a property in [Properties plugin language](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/properties)

