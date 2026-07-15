# 19. Quick Fix

<tldr>
Reference: [Code Inspections and Intentions](code-inspections-and-intentions.html)

Code: [SimpleElementFactory](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleElementFactory.java),
[SimpleCreatePropertyQuickFix](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleCreatePropertyQuickFix.java),
[SimpleAnnotator](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleAnnotator.java)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

A quick fix for a custom language supports the IntelliJ Platform-based IDE feature [Intention Actions](https://www.jetbrains.com/help/idea/intention-actions.html#apply-intention-actions).
For the Simple language, this tutorial adds a quick fix that helps to define an unresolved property from its usage.

## Update the Element Factory

The [SimpleElementFactory](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleElementFactory.java) is updated to include two new methods to support the user choice of creating a new property for the Simple Language quick fix.
The new `createCRLF()` method supports adding a newline to the end of the [test.simple](lexer-and-parser-definition.html#run-the-project) file before adding a new property.
A new overload of `createProperty()` creates a new `key`-`value` pair for Simple Language.

```JAVA
public class SimpleElementFactory {

  public static SimpleProperty createProperty(Project project, String name) {
    final SimpleFile file = createFile(project, name);
    return (SimpleProperty) file.getFirstChild();
  }

  public static SimpleFile createFile(Project project, String text) {
    String name = "dummy.simple";
    return (SimpleFile) PsiFileFactory.getInstance(project).createFileFromText(name, SimpleFileType.INSTANCE, text);
  }

  public static SimpleProperty createProperty(Project project, String name, String value) {
    final SimpleFile file = createFile(project, name + " = " + value);
    return (SimpleProperty) file.getFirstChild();
  }

  public static PsiElement createCRLF(Project project) {
    final SimpleFile file = createFile(project, "\n");
    return file.getFirstChild();
  }

}
```

## Define an Intention Action

The [SimpleCreatePropertyQuickFix](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleCreatePropertyQuickFix.java) creates a property in the file chosen by the user - in this case, a Java file containing a `prefix:key` - and navigate to this property after creation.
Under the hood, `SimpleCreatePropertyQuickFix` is an Intention Action.
For a more in-depth example of an Intention Action, see [conditional_operator_intention](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/conditional_operator_intention).

```JAVA
class SimpleCreatePropertyQuickFix extends BaseIntentionAction {

  private final String key;

  SimpleCreatePropertyQuickFix(String key) {
    this.key = key;
  }

  @NotNull
  @Override
  public String getText() {
    return "Create property '" + key + "'";
  }

  @NotNull
  @Override
  public String getFamilyName() {
    return "Create property";
  }

  @Override
  public boolean isAvailable(@NotNull Project project, Editor editor, PsiFile file) {
    return true;
  }

  @Override
  public void invoke(@NotNull final Project project, final Editor editor, PsiFile file) throws
      IncorrectOperationException {
    ApplicationManager.getApplication().invokeLater(() -> {
      Collection<VirtualFile> virtualFiles =
          FileTypeIndex.getFiles(SimpleFileType.INSTANCE, GlobalSearchScope.allScope(project));
      if (virtualFiles.size() == 1) {
        createProperty(project, virtualFiles.iterator().next());
      } else {
        final FileChooserDescriptor descriptor =
            FileChooserDescriptorFactory.createSingleFileDescriptor(SimpleFileType.INSTANCE);
        descriptor.setRoots(ProjectUtil.guessProjectDir(project));
        final VirtualFile file1 = FileChooser.chooseFile(descriptor, project, null);
        if (file1 != null) {
          createProperty(project, file1);
        }
      }
    });
  }

  private void createProperty(final Project project, final VirtualFile file) {
    WriteCommandAction.writeCommandAction(project).run(() -> {
      SimpleFile simpleFile = (SimpleFile) PsiManager.getInstance(project).findFile(file);
      assert simpleFile != null;
      ASTNode lastChildNode = simpleFile.getNode().getLastChildNode();
      // TODO: Add another check for CRLF
      if (lastChildNode != null/* && !lastChildNode.getElementType().equals(SimpleTypes.CRLF)*/) {
        simpleFile.getNode().addChild(SimpleElementFactory.createCRLF(project).getNode());
      }
      // IMPORTANT: change spaces to escaped spaces or the new node will only have the first word for the key
      SimpleProperty property = SimpleElementFactory.createProperty(project, key.replaceAll(" ", "\\\\ "), "");
      simpleFile.getNode().addChild(property.getNode());
      ((Navigatable) property.getLastChild().getNavigationElement()).navigate(true);
      Editor editor = FileEditorManager.getInstance(project).getSelectedTextEditor();
      assert editor != null;
      editor.getCaretModel().moveCaretRelatively(2, 0, false, false, false);
    });
  }

}
```

## Update the Annotator

When a `badProperty` annotation is created, the `badProperty.registerFix()` method in
[SimpleAnnotator](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleAnnotator.java) is called.
This method call registers the `SimpleCreatePropertyQuickFix` as the Intention Action for the IntelliJ Platform to use to correct the problem.

```JAVA
final class SimpleAnnotator implements Annotator {

  // Define strings for the Simple language prefix - used for annotations, line markers, etc.
  public static final String SIMPLE_PREFIX_STR = "simple";
  public static final String SIMPLE_SEPARATOR_STR = ":";

  @Override
  public void annotate(@NotNull final PsiElement element, @NotNull AnnotationHolder holder) {
    // Ensure the PSI Element is an expression
    if (!(element instanceof PsiLiteralExpression literalExpression)) {
      return;
    }

    // Ensure the PSI element contains a string that starts with the prefix and separator
    String value = literalExpression.getValue() instanceof String ? (String) literalExpression.getValue() : null;
    if (value == null || !value.startsWith(SIMPLE_PREFIX_STR + SIMPLE_SEPARATOR_STR)) {
      return;
    }

    // Define the text ranges (start is inclusive, end is exclusive)
    // "simple:key"
    //  01234567890
    TextRange prefixRange = TextRange.from(element.getTextRange().getStartOffset(), SIMPLE_PREFIX_STR.length() + 1);
    TextRange separatorRange = TextRange.from(prefixRange.getEndOffset(), SIMPLE_SEPARATOR_STR.length());
    TextRange keyRange = new TextRange(separatorRange.getEndOffset(), element.getTextRange().getEndOffset() - 1);

    // highlight "simple" prefix and ":" separator
    holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
        .range(prefixRange).textAttributes(DefaultLanguageHighlighterColors.KEYWORD).create();
    holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
        .range(separatorRange).textAttributes(SimpleSyntaxHighlighter.SEPARATOR).create();


    // Get the list of properties for given key
    String key = value.substring(SIMPLE_PREFIX_STR.length() + SIMPLE_SEPARATOR_STR.length());
    List<SimpleProperty> properties = SimpleUtil.findProperties(element.getProject(), key);
    if (properties.isEmpty()) {
      holder.newAnnotation(HighlightSeverity.ERROR, "Unresolved property")
          .range(keyRange)
          .highlightType(ProblemHighlightType.LIKE_UNKNOWN_SYMBOL)
          // ** Tutorial step 19. - Add a quick fix for the string containing possible properties
          .withFix(new SimpleCreatePropertyQuickFix(key))
          .create();
    } else {
      // Found at least one property, force the text attributes to Simple syntax value character
      holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
          .range(keyRange).textAttributes(SimpleSyntaxHighlighter.VALUE).create();
    }
  }

}
```

## Run the Project

Run the project by using the Gradle [runIde](creating-plugin-project.html#running-a-plugin-with-the-runide-gradle-task) task.
Open the test [Java file](annotator.html#run-the-project).

To test `SimpleCreatePropertyQuickFix`, change `simple:website` to `simple:website.url`.
The key `website.url` is highlighted by `SimpleAnnotator` as an invalid key, as shown below.
Choose "Create Property".

![Quick Fix](images/quick_fix.png)
The IDE opens the `test.simple` file and adds `website.url` as a new key.
Add the new value `jetbrains.com` for the new `website.url` key.

![New Property](images/new_property.png)
Now switch back to the Java file; the new key is highlighted as valid.

