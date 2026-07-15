# Structure View

<tldr>
Product Help: [Source file structure](https://www.jetbrains.com/help/idea/viewing-structure-of-a-source-file.html)
</tldr>

The Structure View implementation used for a specific file type can be customized on many levels.
If a custom language plugin provides an implementation of the [StructureView](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/editor-ui-api/src/com/intellij/ide/structureView/StructureView.java) interface, it can completely replace the standard structure view implementation with a custom user interface component.
However, for most languages, this is not necessary, and the standard `StructureView` implementation provided by IntelliJ Platform can be reused.

Tip:

To modify an existing Structure View (e.g., add/filter nodes of builtin language support), use [StructureViewExtension](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/structure-view-impl/src/com/intellij/ide/structureView/StructureViewExtension.java) registered
in [com.intellij.lang.structureViewExtension](https://jb.gg/ipe?extensions=com.intellij.lang.structureViewExtension) extension point
.

The starting point for the structure view is the [PsiStructureViewFactory](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/editor-ui-api/src/com/intellij/lang/PsiStructureViewFactory.java) interface, which is registered
in the [com.intellij.lang.psiStructureViewFactory](https://jb.gg/ipe?extensions=com.intellij.lang.psiStructureViewFactory) extension point
.

Examples:

* [PsiStructureViewFactory](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/plugins/properties/src/com/intellij/lang/properties/structureView/PropertiesStructureViewBuilderFactory.java) for [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/plugins/properties)

* [Custom Language Support Tutorial: Structure View](structure-view-factory.html)

To reuse the IntelliJ Platform implementation of the `StructureView`, the plugin returns a [TreeBasedStructureViewBuilder](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/editor-ui-api/src/com/intellij/ide/structureView/TreeBasedStructureViewBuilder.java) from its [PsiStructureViewFactory.getStructureViewBuilder()](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/editor-ui-api/src/com/intellij/lang/PsiStructureViewFactory.java) method.
As the builder model, the plugin can specify a subclass of [TextEditorBasedStructureViewModel](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/editor-ui-api/src/com/intellij/ide/structureView/TextEditorBasedStructureViewModel.java), and by overriding methods of this subclass, it customizes the structure view for a specific language.

Example:
[StructureViewModel](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/plugins/properties/properties-psi-impl/src/com/intellij/lang/properties/structureView/PropertiesFileStructureViewModel.java) for [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/plugins/properties)

The main method to override is `getRoot()`, which returns the instance of a class implementing the [StructureViewTreeElement](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/editor-ui-api/src/com/intellij/ide/structureView/StructureViewTreeElement.java) interface.
There exists no standard implementation of this interface, so a plugin will need to implement it completely.

The structure view tree is usually built as a partial mirror of the PSI tree.
In the implementation of `StructureViewTreeElement.getChildren()`, the plugin can specify which of the child elements of a specific PSI tree node need to be represented as elements in the structure view.
Another important method is `getPresentation()`, which can be used to customize the text, attributes, and icon used to represent an element in the structure view.

The implementation of `StructureViewTreeElement.getChildren()` needs to be matched by `TextEditorBasedStructureViewModel.getSuitableClasses()`.
The latter method returns an array of `PsiElement`-derived classes, which can be shown as structure view elements.
It is used to select the Structure View item matching the cursor position when the structure view is first opened or when the Autoscroll from source option is enabled.

Example:
[StructureViewTreeElement](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/plugins/properties/properties-psi-impl/src/com/intellij/lang/properties/editor/PropertyStructureViewElement.java) for [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/plugins/properties)

