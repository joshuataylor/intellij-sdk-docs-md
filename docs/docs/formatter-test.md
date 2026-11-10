# 5. Formatter Test

<tldr>
Tested Functionality: [16. Formatter](formatter.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

See also [FormatterTestCase](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/testFramework/src/com/intellij/psi/formatter/FormatterTestCase.java) as convenient base class.

## Define Test Data

Create the `FormatterTestData.simple` file in the `testData` directory.

```PROPERTIES
# You are reading the ".properties" entry.
! The exclamation mark can also mark text as comments.
website=https://en.wikipedia.org/



language= English
# The backslash below tells the application to continue reading
# the value onto the next line.
message  =  Welcome to \
          Wikipedia!
# Add spaces to the key
key\ with\ spaces = This is the value that could be looked up with the key "key with spaces".
# Unicode
tab :\u0009
```

## Define a Test Method

Add the `testFormatter()` method to `SimpleCodeInsightTest` [previously defined](completion-test.html#define-a-test).

* Again, this method configures the test fixture by using the test file.

* The code style Simple Language settings for spaces and blank lines are set.

* The file is then formatted according to the settings.

* The formatted file is compared to the expected results in the benchmark file `DefaultTestData.simple`.

```JAVA
public void testFormatter() {
  myFixture.configureByFile("FormatterTestData.simple");
  CodeStyle.getLanguageSettings(myFixture.getFile()).SPACE_AROUND_ASSIGNMENT_OPERATORS = true;
  CodeStyle.getLanguageSettings(myFixture.getFile()).KEEP_BLANK_LINES_IN_CODE = 2;
  WriteCommandAction.writeCommandAction(getProject()).run(() ->
      CodeStyleManager.getInstance(getProject()).reformatText(
          myFixture.getFile(),
          List.of(myFixture.getFile().getTextRange())
      )
  );
  myFixture.checkResultByFile("DefaultTestData.simple");
}
```

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

