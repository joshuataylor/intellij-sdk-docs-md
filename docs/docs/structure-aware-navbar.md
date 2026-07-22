# 15. Structure Aware Navigation Bar

<tldr>
Reference: [Navigation Bar](navbar.html)

Code: [SimpleStructureAwareNavbar](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleStructureAwareNavbar.java)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

Structure-aware navbar allows displaying specific file elements in the
[navigation bar](https://www.jetbrains.com/help/idea/guided-tour-around-the-user-interface.html#navigation-bar),
depending on the location of the caret in it.
For example, in Java this is used to display the class and method in which the caret is currently located.

## Define a Structure-Aware Navbar

The [SimpleStructureAwareNavbar](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleStructureAwareNavbar.java) implements
[StructureAwareNavBarModelExtension](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/structure-view-impl/src/com/intellij/ide/navigationToolbar/StructureAwareNavBarModelExtension.kt).

```JAVA
final class SimpleStructureAwareNavbar extends StructureAwareNavBarModelExtension {

  @NotNull
  @Override
  protected Language getLanguage() {
    return SimpleLanguage.INSTANCE;
  }

  @Override
  public @Nullable String getPresentableText(Object object) {
    if (object instanceof SimpleFile) {
      return ((SimpleFile) object).getName();
    }
    if (object instanceof SimpleProperty) {
      return ((SimpleProperty) object).getName();
    }

    return null;
  }

  @Override
  @Nullable
  public Icon getIcon(Object object) {
    if (object instanceof SimpleProperty) {
      return AllIcons.Nodes.Property;
    }

    return null;
  }

}
```

## Register the Structure-Aware Navbar

The `SimpleStructureAwareNavbar` implementation is registered with the IntelliJ Platform in the plugin
configuration file using the [com.intellij.navbar](https://jb.gg/ipe?extensions=com.intellij.navbar) extension point
.

```XML
<extensions defaultExtensionNs="com.intellij">
  <navbar implementation="org.intellij.sdk.language.SimpleStructureAwareNavbar"/>
</extensions>
```

## Run the Project

[Run](creating-plugin-project.html#running-the-plugin) the plugin.

Open the `test.simple` file and position the caret on any property.
The navigation bar displays the name and icon of this property.

![Structure Aware Navbar](images/structure_aware_navbar.png)

