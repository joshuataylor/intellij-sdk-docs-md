# 12. Folding Builder

<tldr>
Code: [SimpleFoldingBuilder](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleFoldingBuilder.java)

Testing: [7. Folding Test](folding-test.html)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

A folding builder identifies the folding regions in the code.
In this step of the tutorial, the folding builder is used to identify folding regions and replace the regions with specific text.
Rather than the usual practice of using a folding builder to collapse a class, method, or comments to fewer lines, the folding builder replaces Simple Language keys with their corresponding values.

## Define a Folding Builder

The [SimpleFoldingBuilder](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleFoldingBuilder.java) replaces usages of properties with their values by default.
Start by subclassing [FoldingBuilderEx](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/lang/folding/FoldingBuilderEx.java)

Note that `SimpleFoldingBuilder` is marked [dumb aware](indexing-and-psi-stubs.html#DumbAwareAPI),
which means the class is allowed to run in [dumb mode](indexing-and-psi-stubs.html#dumb-mode), when indexes are in background update.

Note:

A folding builder must implement [DumbAware](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/project/DumbAware.java) to function in this tutorial and pass tests.

The `buildFoldRegions()` method searches down a PSI tree from `root` to find all literal expressions containing the [simple prefix](annotator.html#define-an-annotator) `simple:`.
The remainder of such a string is expected to contain a Simple Language key, and so the text range is stored as a [FoldingDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/lang/folding/FoldingDescriptor.java).

The `getPlaceholderText()` method retrieves the Simple Language value corresponding to the key associated with the (ASTNode) provided.
The IntelliJ Platform uses the value to substitute for the key when the code gets folded.

```JAVA
final class SimpleFoldingBuilder extends FoldingBuilderEx implements DumbAware {

  @Override
  public FoldingDescriptor @NotNull [] buildFoldRegions(@NotNull PsiElement root,
                                                        @NotNull Document document,
                                                        boolean quick) {
    // Initialize the group of folding regions that will expand/collapse together.
    FoldingGroup group = FoldingGroup.newGroup(SimpleAnnotator.SIMPLE_PREFIX_STR);
    // Initialize the list of folding regions
    List<FoldingDescriptor> descriptors = new ArrayList<>();

    root.accept(new JavaRecursiveElementWalkingVisitor() {

      @Override
      public void visitLiteralExpression(@NotNull PsiLiteralExpression literalExpression) {
        super.visitLiteralExpression(literalExpression);

        String value = PsiLiteralUtil.getStringLiteralContent(literalExpression);
        if (value != null &&
            value.startsWith(SimpleAnnotator.SIMPLE_PREFIX_STR + SimpleAnnotator.SIMPLE_SEPARATOR_STR)) {
          Project project = literalExpression.getProject();
          String key = value.substring(
              SimpleAnnotator.SIMPLE_PREFIX_STR.length() + SimpleAnnotator.SIMPLE_SEPARATOR_STR.length()
          );
          // find SimpleProperty for the given key in the project
          SimpleProperty simpleProperty = ContainerUtil.getOnlyItem(SimpleUtil.findProperties(project, key));
          if (simpleProperty != null) {
            // Add a folding descriptor for the literal expression at this node.
            descriptors.add(new FoldingDescriptor(literalExpression.getNode(),
                new TextRange(literalExpression.getTextRange().getStartOffset() + 1,
                    literalExpression.getTextRange().getEndOffset() - 1),
                group, Collections.singleton(simpleProperty)));
          }
        }
      }
    });

    return descriptors.toArray(FoldingDescriptor.EMPTY_ARRAY);
  }

  /**
   * Gets the Simple Language 'value' string corresponding to the 'key'
   *
   * @param node Node corresponding to PsiLiteralExpression containing a string in the format
   *             SIMPLE_PREFIX_STR + SIMPLE_SEPARATOR_STR + Key, where Key is
   *             defined by the Simple language file.
   */
  @Nullable
  @Override
  public String getPlaceholderText(@NotNull ASTNode node) {
    if (node.getPsi() instanceof PsiLiteralExpression psiLiteralExpression) {
      String text = PsiLiteralUtil.getStringLiteralContent(psiLiteralExpression);
      if (text == null) {
        return null;
      }

      String key = text.substring(SimpleAnnotator.SIMPLE_PREFIX_STR.length() +
          SimpleAnnotator.SIMPLE_SEPARATOR_STR.length());

      SimpleProperty simpleProperty = ContainerUtil.getOnlyItem(
          SimpleUtil.findProperties(psiLiteralExpression.getProject(), key)
      );
      if (simpleProperty == null) {
        return StringUtil.THREE_DOTS;
      }

      String propertyValue = simpleProperty.getValue();
      // IMPORTANT: keys can come with no values, so a test for null is needed
      // IMPORTANT: Convert embedded \n to backslash n, so that the string will look
      // like it has LF embedded in it and embedded " to escaped "
      if (propertyValue == null) {
        return StringUtil.THREE_DOTS;
      }

      return propertyValue
          .replaceAll("\n", "\\n")
          .replaceAll("\"", "\\\\\"");
    }

    return null;
  }

  @Override
  public boolean isCollapsedByDefault(@NotNull ASTNode node) {
    return true;
  }

}
```

## Register the Folding Builder

The `SimpleFoldingBuilder` implementation is registered with the IntelliJ Platform in the plugin configuration file using
the [com.intellij.lang.foldingBuilder](https://jb.gg/ipe?extensions=com.intellij.lang.foldingBuilder) extension point
.

```XML
<extensions defaultExtensionNs="com.intellij">
  <lang.foldingBuilder
      language="JAVA"
      implementationClass="org.intellij.sdk.language.SimpleFoldingBuilder"/>
</extensions>
```

## Run the Project

[Run](creating-plugin-project.html#running-the-plugin) the plugin.

Now when a Java file is opened in the editor, it shows the property's value instead of the key.
This is because `SimpleFoldingBuilder.isCollapsedByDefault()` always returns `true`.
Try using `Code | Folding | Expand All` to show the key rather than the value.

![Folding](images/folding.png)

