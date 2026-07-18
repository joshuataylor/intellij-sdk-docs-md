# 6. Rename Test

<tldr>
Tested Functionality: [10. Reference Contributor](reference-contributor.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

## Define Input Test Data

Create the `RenameTestData.simple` properties file in the `testData` directory.

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

Create the file `RenameTestData.java` in the `testData` directory.
This file contains one Simple Language reference embedded in Java, with the [caret position](test-project-and-testdata-directories.html#special-markup) placed just after a Simple Language key.

```JAVA
public class Test {
  public static void main(String[] args) {
    System.out.println("simple:website<caret>");
  }
}
```

## Create Output Test Data

Create the `RenameTestDataAfter.simple` file in the `testData` directory.
This file contains the expected outcome of the test.
Note the `website =` in `RenameTestData.simple` should be renamed to `websiteUrl =` by the test.

```PROPERTIES
# You are reading the ".properties" entry.
! The exclamation mark can also mark text as comments.
websiteUrl = https://en.wikipedia.org/

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

## Define a Test Method

Add the `testRename()` method to the `SimpleCodeInsightTest` class [previously defined](completion-test.html#define-a-test).

* Again, this method configures the test fixture by using the test files.

* The fixture then renames the Simple Language element at the caret in `RenameTestData.java`.

* It then compares the input and output files, ignoring whitespace.

```JAVA
public void testRename() {
  myFixture.configureByFiles("RenameTestData.java", "RenameTestData.simple");
  myFixture.renameElementAtCaret("websiteUrl");
  myFixture.checkResultByFile("RenameTestData.simple", "RenameTestDataAfter.simple", false);
}
```

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

