# 9. Completion Contributor

<tldr>
Reference: [Code Completion](code-completion.html)

Code: [SimpleCompletionContributor](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleCompletionContributor.java)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

Custom languages provide code completion using one of two approaches: Contributor and Reference-based (see [10. Reference Contributor](reference-contributor.html)) completion.

## Define a Completion Contributor

For this tutorial, the `simple_language_plugin` provides custom completion for values in Simple Language property files.
Create [SimpleCompletionContributor](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleCompletionContributor.java)
by subclassing [CompletionContributor](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/analysis-api/src/com/intellij/codeInsight/completion/CompletionContributor.java).
This rudimentary completion contributor always adds "Hello" to the completion variants result set, regardless of context:

```JAVA
final class SimpleCompletionContributor extends CompletionContributor {

  SimpleCompletionContributor() {
    extend(CompletionType.BASIC, PlatformPatterns.psiElement(SimpleTypes.VALUE),
        new CompletionProvider<>() {
          public void addCompletions(@NotNull CompletionParameters parameters,
                                     @NotNull ProcessingContext context,
                                     @NotNull CompletionResultSet resultSet) {
            resultSet.addElement(LookupElementBuilder.create("Hello"));
          }
        }
    );
  }

}
```

## Register the Completion Contributor

The `SimpleCompletionContributor` implementation is registered in the plugin configuration file using the [com.intellij.completion.contributor](https://jb.gg/ipe?extensions=com.intellij.completion.contributor) extension point
and specifying `language="Simple"`.

```XML
<extensions defaultExtensionNs="com.intellij">
  <completion.contributor
      language="Simple"
      implementationClass="org.intellij.sdk.language.SimpleCompletionContributor"/>
</extensions>
```

## Run the Project

Run the plugin by using the Gradle [runIde](creating-plugin-project.html#running-a-plugin-with-the-runide-gradle-task) task.

Open the [test.simple](lexer-and-parser-definition.html#run-the-project) file.
Erase the property "English" and invoke [Basic Code Completion](https://www.jetbrains.com/help/idea/auto-completing-code.html#invoke-basic-completion).
The choice "Hello" is shown:

![Completion](images/completion.png)

