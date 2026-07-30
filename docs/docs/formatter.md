# 16. Formatter

<tldr>
Reference: [Code Formatter](code-formatting.html)

Code: [SimpleBlock](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleBlock.java),
[SimpleFormattingModelBuilder](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleFormattingModelBuilder.java)

Testing: [5. Formatter Test](formatter-test.html)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

The IntelliJ Platform includes a powerful framework for implementing formatting for custom languages.
A formatter enables reformatting code automatically based on code style settings.
The formatter controls spaces, indents, wrap, and alignment.

## Define a Block

The formatting model represents the formatting structure of a file as a tree of [Block](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/code-style-api/src/com/intellij/formatting/Block.java) objects, with associated indent, wrap, alignment, and spacing settings.
The goal is to cover each PSI element with such a block.
Since each block builds its children's blocks, it can generate extra blocks or skip any PSI elements.
Define [SimpleBlock](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleBlock.java) based on [AbstractBlock](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/code-style-impl/src/com/intellij/psi/formatter/common/AbstractBlock.java).

```JAVA
public class SimpleBlock extends AbstractBlock {

  private final SpacingBuilder spacingBuilder;

  protected SimpleBlock(@NotNull ASTNode node, @Nullable Wrap wrap, @Nullable Alignment alignment,
                        SpacingBuilder spacingBuilder) {
    super(node, wrap, alignment);
    this.spacingBuilder = spacingBuilder;
  }

  @Override
  protected List<Block> buildChildren() {
    List<Block> blocks = new ArrayList<>();
    ASTNode child = myNode.getFirstChildNode();
    while (child != null) {
      if (child.getElementType() != TokenType.WHITE_SPACE) {
        Block block = new SimpleBlock(child, Wrap.createWrap(WrapType.NONE, false), Alignment.createAlignment(),
            spacingBuilder);
        blocks.add(block);
      }
      child = child.getTreeNext();
    }
    return blocks;
  }

  @Override
  public Indent getIndent() {
    return Indent.getNoneIndent();
  }

  @Nullable
  @Override
  public Spacing getSpacing(@Nullable Block child1, @NotNull Block child2) {
    return spacingBuilder.getSpacing(this, child1, child2);
  }

  @Override
  public boolean isLeaf() {
    return myNode.getFirstChildNode() == null;
  }

}
```

## Define a Formatting Model Builder

Define a formatter that removes extra spaces except for the single spaces around the property separator:

Before:

```PROPERTIES
foo  =    bar
```

After:

```PROPERTIES
foo = bar
```

Create [SimpleFormattingModelBuilder](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleFormattingModelBuilder.java) by implementing [FormattingModelBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/code-style-api/src/com/intellij/formatting/FormattingModelBuilder.java).

```JAVA
final class SimpleFormattingModelBuilder implements FormattingModelBuilder {

  private static SpacingBuilder createSpaceBuilder(CodeStyleSettings settings) {
    return new SpacingBuilder(settings, SimpleLanguage.INSTANCE)
        .around(SimpleTypes.SEPARATOR)
        .spaceIf(settings.getCommonSettings(SimpleLanguage.INSTANCE.getID()).SPACE_AROUND_ASSIGNMENT_OPERATORS)
        .before(SimpleTypes.PROPERTY)
        .none();
  }

  @Override
  public @NotNull FormattingModel createModel(@NotNull FormattingContext formattingContext) {
    final CodeStyleSettings codeStyleSettings = formattingContext.getCodeStyleSettings();
    return FormattingModelProvider
        .createFormattingModelForPsiFile(formattingContext.getContainingFile(),
            new SimpleBlock(formattingContext.getNode(),
                Wrap.createWrap(WrapType.NONE, false),
                Alignment.createAlignment(),
                createSpaceBuilder(codeStyleSettings)),
            codeStyleSettings);
  }

}
```

## Register the Formatter

The ``SimpleFormattingModelBuilder` implementation is registered with the IntelliJ Platform in the plugin configuration file using the [com.intellij.lang.formatter](https://jb.gg/ipe?extensions=com.intellij.lang.formatter) extension point
.

```XML
<extensions defaultExtensionNs="com.intellij">
  <lang.formatter
      language="Simple"
      implementationClass="org.intellij.sdk.language.SimpleFormattingModelBuilder"/>
</extensions>
```

## Run the Project

[Run](creating-plugin-project.html#running-the-plugin) the plugin.

Open the example Simple Language [properties file](lexer-and-parser-definition.html#run-the-project) in the IDE Development Instance.
Add some extra spaces around the `=` separator between `language` and `English`.
Reformat the code by invoking `Code | Reformat File...` dialog and choose Run.

![Formatter](images/formatter.png)

