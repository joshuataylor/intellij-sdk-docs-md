# 3. Grammar and Parser

<tldr>
Reference: [Implementing Lexer](implementing-lexer.html), [Implementing Parser and PSI](implementing-parser-and-psi.html)

Code: [SimpleTokenType](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleTokenType.java),
[SimpleElementType](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleElementType.java)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

In order for the IntelliJ Platform to parse a Simple Language file, tokens and elements must be defined based on [IElementType](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/tree/IElementType.java).
The Simple Language grammar must also be defined to generate a parser.

## Define a Token Type

Create [SimpleTokenType](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleTokenType.java)
in the `org.intellij.sdk.language.psi` package by subclassing `IElementType`.

```JAVA
public class SimpleTokenType extends IElementType {

  public SimpleTokenType(@NotNull @NonNls String debugName) {
    super(debugName, SimpleLanguage.INSTANCE);
  }

  @Override
  public String toString() {
    return "SimpleTokenType." + super.toString();
  }

}
```

## Define an Element Type

Create the [SimpleElementType](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleElementType.java) in the `org.intellij.sdk.language.psi` package by subclassing `IElementType`.

```JAVA
public class SimpleElementType extends IElementType {

  public SimpleElementType(@NotNull @NonNls String debugName) {
    super(debugName, SimpleLanguage.INSTANCE);
  }

}
```

## Define the Grammar

Define a grammar for the Simple Language in the `org/intellij/sdk/language/Simple.bnf` file.

```BNF
{
  parserClass="org.intellij.sdk.language.parser.SimpleParser"

  extends="com.intellij.extapi.psi.ASTWrapperPsiElement"

  psiClassPrefix="Simple"
  psiImplClassSuffix="Impl"
  psiPackage="org.intellij.sdk.language.psi"
  psiImplPackage="org.intellij.sdk.language.psi.impl"

  elementTypeHolderClass="org.intellij.sdk.language.psi.SimpleTypes"
  elementTypeClass="org.intellij.sdk.language.psi.SimpleElementType"
  tokenTypeClass="org.intellij.sdk.language.psi.SimpleTokenType"
}

simpleFile ::= item_*

private item_ ::= (property|COMMENT|CRLF)

property ::= (KEY? SEPARATOR VALUE?) | KEY
```

Please see [Grammar-Kit](https://github.com/JetBrains/Grammar-Kit) documentation for more details on BNF syntax.

The grammar defines the flexibility of the support for a language.
The above grammar specifies that a property may have or may not have a key and value.
This flexibility allows the IntelliJ Platform to recognize incorrectly defined properties and provide corresponding code analysis and quick fixes.

Note that the `SimpleTypes` class in the `elementTypeHolderClass` attribute above specifies the name of a class that gets generated from the grammar in the scope of the Generate Parser Code action (see [Generate a Parser](#generate-a-parser)); it doesn't exist at this point.

## Generate a Parser

Now that the grammar is defined, generate a parser with PSI classes via Generate Parser Code from the context menu on the `Simple.bnf` file.
This step generates a parser and PSI elements in the `/src/main/gen` folder of the project.

Tip:

[Gradle Grammar-Kit Plugin](tools-gradle-grammar-kit-plugin.html) can be used alternatively.

![Parser](images/generated_parser.png)

## Add Generated Sources Root

To include the sources generated into `/src/main/gen`, the project's `sourceSets` must be expanded by inserting the following in the Gradle build script:

```KOTLIN
sourceSets {
  main {
    java {
      srcDirs("src/main/gen")
    }
  }
}
```

See `[build.gradle.kts](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/build.gradle.kts)` for the reference.

Reload the Gradle project for changes to take effect and build the project.

