# 2. Parsing Test

<tldr>
Tested Functionality: [4. Lexer and Parser Definition](lexer-and-parser-definition.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

For more complex Lexers (e.g., having additional logic), it is advisable to add separate tests inheriting from [LexerTestCase](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/testFramework/src/com/intellij/testFramework/LexerTestCase.java).

## Update Grammar and Regenerate the Parser

Before creating the parsing test, ensure the parser definition (`Simple.bnf`) includes the lines shown below.
These additional lines facilitate testing incorrect keys.

If the lines below are not present in `Simple.bnf`, replace the existing `property` definition with the lines below.
Don't forget to regenerate the parser after updating the file!
Right-click on the `Simple.bnf` file and select Generate Parser Code.

```BNF
property ::= (KEY? SEPARATOR VALUE?) | KEY {
  pin=3
  recoverWhile="recover_property"
  mixin="org.intellij.sdk.language.psi.impl.SimpleNamedElementImpl"
  implements="org.intellij.sdk.language.psi.SimpleNamedElement"
  methods=[getKey getValue getName setName getNameIdentifier getPresentation]
}
private recover_property ::= !(KEY|SEPARATOR|COMMENT)
```

## Define Input Test Data

Create the `ParsingTestData.simple` properties file in the `testData` folder.
Note the last few lines define a purposely incorrect key.

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
# test for illegal key attempt
key\
with\
endofline = test
```

## Copy the Expected PSI Tree

The easiest way to get the expected PSI structure for any file is to use the [built-in PSI viewer](explore-api.html#internalMode).
Run the project and use `Tools | View PSI Structure...`
(enable [Internal Mode](enabling-internal.html) explicitly for the IDE instance if the menu is not available).

![PSI Tree Copy](images/plugin_copy_psi.png)
Use the Copy PSI button to copy the expected PSI structure to the clipboard.

## Define the Output Reference Test Data

Create a file `ParsingTestData.txt` with the copied PSI tree.

```PROPERTIES
Simple File(0,493)
  PsiComment(SimpleTokenType.COMMENT)('# You are reading the ".properties" entry.')(0,42)
  PsiWhiteSpace('\n')(42,43)
  PsiComment(SimpleTokenType.COMMENT)('! The exclamation mark can also mark text as comments.')(43,97)
  PsiWhiteSpace('\n')(97,98)
  SimplePropertyImpl(PROPERTY)(98,133)
    PsiElement(SimpleTokenType.KEY)('website')(98,105)
    PsiWhiteSpace(' ')(105,106)
    PsiElement(SimpleTokenType.SEPARATOR)('=')(106,107)
    PsiWhiteSpace(' ')(107,108)
    PsiElement(SimpleTokenType.VALUE)('https://en.wikipedia.org/')(108,133)
  PsiWhiteSpace('\n\n')(133,135)
  SimplePropertyImpl(PROPERTY)(135,153)
    PsiElement(SimpleTokenType.KEY)('language')(135,143)
    PsiWhiteSpace(' ')(143,144)
    PsiElement(SimpleTokenType.SEPARATOR)('=')(144,145)
    PsiWhiteSpace(' ')(145,146)
    PsiElement(SimpleTokenType.VALUE)('English')(146,153)
  PsiWhiteSpace('\n')(153,154)
  PsiComment(SimpleTokenType.COMMENT)('# The backslash below tells the application to continue reading')(154,217)
  PsiWhiteSpace('\n')(217,218)
  PsiComment(SimpleTokenType.COMMENT)('# the value onto the next line.')(218,249)
  PsiWhiteSpace('\n')(249,250)
  SimplePropertyImpl(PROPERTY)(250,293)
    PsiElement(SimpleTokenType.KEY)('message')(250,257)
    PsiWhiteSpace(' ')(257,258)
    PsiElement(SimpleTokenType.SEPARATOR)('=')(258,259)
    PsiWhiteSpace(' ')(259,260)
    PsiElement(SimpleTokenType.VALUE)('Welcome to \\n          Wikipedia!')(260,293)
  PsiWhiteSpace('\n')(293,294)
  PsiComment(SimpleTokenType.COMMENT)('# Add spaces to the key')(294,317)
  PsiWhiteSpace('\n')(317,318)
  SimplePropertyImpl(PROPERTY)(318,411)
    PsiElement(SimpleTokenType.KEY)('key\ with\ spaces')(318,335)
    PsiWhiteSpace(' ')(335,336)
    PsiElement(SimpleTokenType.SEPARATOR)('=')(336,337)
    PsiWhiteSpace(' ')(337,338)
    PsiElement(SimpleTokenType.VALUE)('This is the value that could be looked up with the key "key with spaces".')(338,411)
  PsiWhiteSpace('\n')(411,412)
  PsiComment(SimpleTokenType.COMMENT)('# Unicode')(412,421)
  PsiWhiteSpace('\n')(421,422)
  SimplePropertyImpl(PROPERTY)(422,434)
    PsiElement(SimpleTokenType.KEY)('tab')(422,425)
    PsiWhiteSpace(' ')(425,426)
    PsiElement(SimpleTokenType.SEPARATOR)(':')(426,427)
    PsiWhiteSpace(' ')(427,428)
    PsiElement(SimpleTokenType.VALUE)('\u0009')(428,434)
  PsiWhiteSpace('\n')(434,435)
  PsiComment(SimpleTokenType.COMMENT)('# test for illegal key attempt')(435,465)
  PsiWhiteSpace('\n')(465,466)
  SimplePropertyImpl(PROPERTY)(466,470)
    PsiElement(SimpleTokenType.KEY)('key')(466,469)
    PsiErrorElement:SimpleTokenType.SEPARATOR expected, got '\'(469,470)
      PsiElement(BAD_CHARACTER)('\')(469,470)
  PsiWhiteSpace('\n')(470,471)
  SimplePropertyImpl(PROPERTY)(471,476)
    PsiElement(SimpleTokenType.KEY)('with')(471,475)
    PsiErrorElement:SimpleTokenType.SEPARATOR expected, got '\'(475,476)
      PsiElement(BAD_CHARACTER)('\')(475,476)
  PsiWhiteSpace('\n')(476,477)
  SimplePropertyImpl(PROPERTY)(477,493)
    PsiElement(SimpleTokenType.KEY)('endofline')(477,486)
    PsiWhiteSpace(' ')(486,487)
    PsiElement(SimpleTokenType.SEPARATOR)('=')(487,488)
    PsiWhiteSpace(' ')(488,489)
    PsiElement(SimpleTokenType.VALUE)('test')(489,493)
```

## Define a Parsing Test

Subclass [ParsingTestCase](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/testFramework/src/com/intellij/testFramework/ParsingTestCase.java) to create `SimpleParsingTest`:
Override `getTestDataPath()`, and return the path from the root of this plugin module to the `testData` directory.

```JAVA
// Copyright 2000-2024 JetBrains s.r.o. and contributors. Use of this source code is governed by the Apache 2.0 license.

package org.intellij.sdk.language;

import com.intellij.testFramework.ParsingTestCase;

public class SimpleParsingTest extends ParsingTestCase {

  public SimpleParsingTest() {
    super("", "simple", new SimpleParserDefinition());
  }

  public void testParsingTestData() {
    doTest(true);
  }

  /**
   * @return path to test data file directory relative to root of this module.
   */
  @Override
  protected String getTestDataPath() {
    return "src/test/testData";
  }

  @Override
  protected boolean includeRanges() {
    return true;
  }

}
```

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

