# 4. Lexer and Parser Definition

<tldr>
Reference: [Implementing Lexer](implementing-lexer.html)

Code: [Simple.flex](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/Simple.flex),
[SimpleLexerAdapter](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleLexerAdapter.java),
[SimpleFile](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleFile.java),
[SimpleTokenSets](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleTokenSets.java),
[SimpleParserDefinition](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleParserDefinition.java)

Testing: [2. Parsing Test](parsing-test.html)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

The lexical analyzer defines how the contents of a file are broken into tokens, which is the basis for supporting custom language features.
The easiest way to create a lexer is to use [JFlex](https://jflex.de/).

## Define a Lexer

Define a [Simple.flex](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/Simple.flex) file with rules for the Simple Language lexer in package `org.intellij.sdk.language`.

```JAVA
// Copyright 2000-2022 JetBrains s.r.o. and other contributors. Use of this source code is governed by the Apache 2.0 license that can be found in the LICENSE file.
package org.intellij.sdk.language;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import org.intellij.sdk.language.psi.SimpleTypes;
import com.intellij.psi.TokenType;

%%

%class SimpleLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
FIRST_VALUE_CHARACTER=[^ \n\f\\] | "\\"{CRLF} | "\\".
VALUE_CHARACTER=[^\n\f\\] | "\\"{CRLF} | "\\".
END_OF_LINE_COMMENT=("#"|"!")[^\r\n]*
SEPARATOR=[:=]
KEY_CHARACTER=[^:=\ \n\t\f\\] | "\\ "

%state WAITING_VALUE

%%

<YYINITIAL> {END_OF_LINE_COMMENT}                           { yybegin(YYINITIAL); return SimpleTypes.COMMENT; }

<YYINITIAL> {KEY_CHARACTER}+                                { yybegin(YYINITIAL); return SimpleTypes.KEY; }

<YYINITIAL> {SEPARATOR}                                     { yybegin(WAITING_VALUE); return SimpleTypes.SEPARATOR; }

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {FIRST_VALUE_CHARACTER}{VALUE_CHARACTER}*   { yybegin(YYINITIAL); return SimpleTypes.VALUE; }

({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }
```

## Generate a Lexer Class

Now generate a lexer class via `Run JFlex Generator` from the context menu on `Simple.flex` file.

Tip:

Users from China, please see [important configuration](https://github.com/JetBrains/Grammar-Kit/issues/300#issuecomment-1476498645).

The Grammar-Kit plugin uses the JFlex lexer generation.
When running for the first time, JFlex prompts for a destination folder to download the JFlex library and skeleton.
Choose the project root directory, for example `code_samples/simple_language_plugin`.

After that, the IDE generates the lexer under the `gen` directory, for example in `simple_language_plugin/src/main/gen/org/intellij/sdk/language/SimpleLexer`.

Tip:

[Gradle Grammar-Kit Plugin](tools-gradle-grammar-kit-plugin.html) can be used alternatively.

## Define a Lexer Adapter

The JFlex lexer needs to be adapted to the IntelliJ Platform Lexer API.
Implement [SimpleLexerAdapter](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleLexerAdapter.java) by subclassing [FlexAdapter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-impl/src/com/intellij/lexer/FlexAdapter.java).

```JAVA
public class SimpleLexerAdapter extends FlexAdapter {

  public SimpleLexerAdapter() {
    super(new SimpleLexer(null));
  }

}
```

## Define a Root File

The [SimpleFile](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleFile.java) implementation is the top-level node of the [tree of PsiElements](implementing-parser-and-psi.html) for a Simple Language file.

```JAVA
public class SimpleFile extends PsiFileBase {

  public SimpleFile(@NotNull FileViewProvider viewProvider) {
    super(viewProvider, SimpleLanguage.INSTANCE);
  }

  @NotNull
  @Override
  public FileType getFileType() {
    return SimpleFileType.INSTANCE;
  }

  @Override
  public String toString() {
    return "Simple File";
  }

}
```

## Define Token Sets

Define all sets of related token types from `SimpleTypes` in [SimpleTokenSets](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleTokenSets.java).

```JAVA
public interface SimpleTokenSets {

  TokenSet IDENTIFIERS = TokenSet.create(SimpleTypes.KEY);

  TokenSet COMMENTS = TokenSet.create(SimpleTypes.COMMENT);

}
```

## Define a Parser

The Simple Language parser is defined in [SimpleParserDefinition](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleParserDefinition.java) by subclassing [ParserDefinition](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/lang/ParserDefinition.java).
To avoid unnecessary classloading when initializing the extension point implementation, all `TokenSet` return values should use constants from dedicated `$Language$TokenSets` class.

```JAVA
final class SimpleParserDefinition implements ParserDefinition {

  public static final IFileElementType FILE = new IFileElementType(SimpleLanguage.INSTANCE);

  @NotNull
  @Override
  public Lexer createLexer(Project project) {
    return new SimpleLexerAdapter();
  }

  @NotNull
  @Override
  public TokenSet getCommentTokens() {
    return SimpleTokenSets.COMMENTS;
  }

  @NotNull
  @Override
  public TokenSet getStringLiteralElements() {
    return TokenSet.EMPTY;
  }

  @NotNull
  @Override
  public PsiParser createParser(final Project project) {
    return new SimpleParser();
  }

  @NotNull
  @Override
  public IFileElementType getFileNodeType() {
    return FILE;
  }

  @NotNull
  @Override
  public PsiFile createFile(@NotNull FileViewProvider viewProvider) {
    return new SimpleFile(viewProvider);
  }

  @NotNull
  @Override
  public PsiElement createElement(ASTNode node) {
    return SimpleTypes.Factory.createElement(node);
  }

}
```

## Register the Parser Definition

Registering the parser definition in the `[plugin.xml](plugin-configuration-file.html)` file makes it available to the IntelliJ Platform.
Use the [com.intellij.lang.parserDefinition](https://jb.gg/ipe?extensions=com.intellij.lang.parserDefinition) extension point
for registration.
For example, see `simple_language_plugin/src/main/resources/META-INF/plugin.xml`.

```XML
<extensions defaultExtensionNs="com.intellij">
  <lang.parserDefinition
      language="Simple"
      implementationClass="org.intellij.sdk.language.SimpleParserDefinition"/>
</extensions>
```

## Run the Project

Run the plugin by using the Gradle [runIde](creating-plugin-project.html#running-a-plugin-with-the-runide-gradle-task) task.

Create a `test.simple`  file with the following content:

```PROPERTIES
# You are reading the ".properties" entry.
! The exclamation mark can also mark text as comments.
website = https://en.wikipedia.org/
language = English
# The backslash below tells the application to continue reading
# the value onto the next line.
message = Welcome to \
          Wikipedia!
# Add spaces to the key
key\ with\ spaces = This is the value that could be looked up with the key "key with spaces".
# Unicode
tab : \u0009
```

Use the [PsiViewer plugin or built-in PSI viewer](explore-api.html#internalMode) and check how the lexer breaks the content of the file into tokens,
and the parser transforms the tokens into PSI elements.

![PSI Elements](images/psi_elements.png)

