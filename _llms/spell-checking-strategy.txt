# 21. Spell Checking

<tldr>
Reference: [Spell Checking](spell-checking.html)

Code: [SimpleSpellcheckingStrategy](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleSpellcheckingStrategy.java)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

Spell checking allows users to see spelling errors while editing code.

## Define a SimpleSpellcheckingStrategy

The [SimpleSpellcheckingStrategy](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleSpellcheckingStrategy.java) extends
[SpellcheckingStrategy](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/spellchecker/src/com/intellij/spellchecker/tokenizer/SpellcheckingStrategy.java)

```JAVA
final class SimpleSpellcheckingStrategy extends SpellcheckingStrategy {

  @Override
  public @NotNull Tokenizer<?> getTokenizer(PsiElement element) {
    if (element instanceof PsiComment) {
      return new SimpleCommentTokenizer();
    }

    if (element instanceof SimpleProperty) {
      return new SimplePropertyTokenizer();
    }

    return EMPTY_TOKENIZER;
  }

  private static class SimpleCommentTokenizer extends Tokenizer<PsiComment> {

    @Override
    public void tokenize(@NotNull PsiComment element, @NotNull TokenConsumer consumer) {
      // Exclude the start of the comment with its # characters from spell checking
      int startIndex = 0;
      for (char c : element.textToCharArray()) {
        if (c == '#' || Character.isWhitespace(c)) {
          startIndex++;
        } else {
          break;
        }
      }
      consumer.consumeToken(element, element.getText(), false, 0,
          TextRange.create(startIndex, element.getTextLength()),
          CommentSplitter.getInstance());
    }

  }

  private static class SimplePropertyTokenizer extends Tokenizer<SimpleProperty> {

    public void tokenize(@NotNull SimpleProperty element, @NotNull TokenConsumer consumer) {
      //Spell check the keys and values of properties with different splitters
      final ASTNode key = element.getNode().findChildByType(SimpleTypes.KEY);
      if (key != null && key.getTextLength() > 0) {
        final PsiElement keyPsi = key.getPsi();
        final String text = key.getText();
        //For keys, use a splitter for identifiers
        //Note we set "useRename" to true so that keys will be properly refactored (renamed)
        consumer.consumeToken(keyPsi, text, true, 0,
            TextRange.allOf(text), IdentifierSplitter.getInstance());
      }

      final ASTNode value = element.getNode().findChildByType(SimpleTypes.VALUE);
      if (value != null && value.getTextLength() > 0) {
        final PsiElement valuePsi = value.getPsi();
        final String text = valuePsi.getText();
        //For values, use a splitter for plain text
        consumer.consumeToken(valuePsi, text, false, 0,
            TextRange.allOf(text), PlainTextSplitter.getInstance());
      }
    }

  }

}
```

## Register the SimpleSpellcheckingStrategy

The implementation is registered with the IntelliJ Platform in the plugin
configuration file using the [com.intellij.spellchecker.support](https://jb.gg/ipe?extensions=com.intellij.spellchecker.support) extension point
.

```XML
<extensions defaultExtensionNs="com.intellij">
  <spellchecker.support language="Simple" implementationClass="org.intellij.sdk.language.SimpleSpellcheckingStrategy"/>
</extensions>
```

## Run the Project

Run the project by using the Gradle [runIde](creating-plugin-project.html#running-a-plugin-with-the-runide-gradle-task) task.

Open the `test.simple` file and make an intentional spelling mistake.
The IDE will highlight the error and suggest a quick fix.

![Spellchecking](images/spell_checking.png)

