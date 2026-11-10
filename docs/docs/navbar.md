# Navigation Bar

<tldr>
Product Help: [Navigation bar](https://www.jetbrains.com/help/idea/guided-tour-around-the-user-interface.html#navigation-bar)
</tldr>

The navigation bar implementation is used to customize and extend the
[navigation bar](https://www.jetbrains.com/help/idea/guided-tour-around-the-user-interface.html#navigation-bar)
structure.

The starting point for the navigation bar extension is the
[NavBarModelExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-impl/src/com/intellij/ide/navigationToolbar/NavBarModelExtension.java)
interface, which is registered in the [com.intellij.navbar](https://jb.gg/ipe?extensions=com.intellij.navbar) extension point
.

To reuse the IntelliJ Platform implementation, extend one of two classes:

* [DefaultNavBarExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-impl/src/com/intellij/ide/navigationToolbar/DefaultNavBarExtension.java)

* [StructureAwareNavBarModelExtension](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/structure-view-impl/src/com/intellij/ide/navigationToolbar/StructureAwareNavBarModelExtension.kt)

## Default Navigation Bar

`DefaultNavBarExtension` is the basic implementation of the navigation bar for any files.
Inherit from this class to create a simple navigation bar that changes the display of folders or files for the language.

In this case, overriding the following two methods is usually enough:

* `getPresentableText()` – returns a string representation of the navigation bar part element passed to it.

* `getIcon()` – returns the icon for the navigation bar part passed to it.

## Structure Aware Navigation Bar

`StructureAwareNavBarModelExtension` is an advanced implementation that provides the ability to display specific file elements (e.g., the name of classes, functions, etc.) in a bar e.g.,
the name of the class at the current caret position.
Inherit from it to add navigation bar support to the language with support for specific file elements.

Note:

Don't forget to implement [Structure View](structure-view.html), this is necessary to build a file structure model based on which the navigation bar displays a specific element.

In this case, also override `getLanguage()` in addition to the two methods described earlier, this method returns the language instance for which this extension will work.

The `adjustElement()` method modifies the navigation bar element.
It can be used, for example, to show a class in the navigation bar when the caret is located in a comment that is attached to the class.

Overriding other methods is usually not needed unless the plugin provides its own implementation of the entire `NavBarModelExtension` interface.

Note that the `getSuitableClasses()` method on the structure view model class that implements `com.intellij.ide.structureView.TextEditorBasedStructureViewModel` (see [Structure View](structure-view.html))
must return all the element types to display in the navigation bar.

Example: [Custom Language Support Tutorial: Structure Aware Navigation Bar](structure-aware-navbar.html)

