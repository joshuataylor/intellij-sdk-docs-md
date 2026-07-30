# 3. Completion Test

<tldr>
Tested Functionality: [10. Reference Contributor](reference-contributor.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

## Define Test Data

Create the `DefaultTestData.simple` file in the `testData` directory.
This file contains test Simple language properties that will be completed in a test Java file (see the `Test` class later in this section).

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

Create a test input Java file `CompleteTestData.java` in the `testData` directory.
This file contains a Simple Language reference within the Java code at `<caret>` [special marker](test-project-and-testdata-directories.html#special-markup), which denotes the caret position to use in the test.

```JAVA
public class Test {
  public static void main(String[] args) {
    System.out.println("simple:<caret>");
  }
}
```

## Define a Test

Subclass [LightJavaCodeInsightFixtureTestCase](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/java/testFramework/src/com/intellij/testFramework/fixtures/LightJavaCodeInsightFixtureTestCase.java) to create `SimpleCodeInsightTest`.
Override `getTestDataPath()`, and return the path from the root of this plugin module to the `testData` directory.

```JAVA
/**
 * @return path to test data file directory relative to working directory in the run configuration for this test.
 */
@Override
protected String getTestDataPath() {
  return "src/test/testData";
}
```

At this point, only one test is defined in `SimpleCodeInsightTest`: `testCompletion()`.
This method:

* Configures the test using the two input files.

* Calls the basic completion functionality. Behind the scenes, this method call creates a list of possible elements to complete the embedded Simple Language reference.

* Checks the list of returned lookup strings to ensure it matches the completion variants provided by the reference.

```JAVA
public void testCompletion() {
  myFixture.configureByFiles("CompleteTestData.java", "DefaultTestData.simple");
  myFixture.complete(CompletionType.BASIC);
  List<String> lookupElementStrings = myFixture.getLookupElementStrings();
  assertNotNull(lookupElementStrings);
  assertSameElements(lookupElementStrings, "key with spaces", "language", "message", "tab", "website");
}
```

A number of related methods exist in [CodeInsightTestFixture](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/testFramework/src/com/intellij/testFramework/fixtures/CodeInsightTestFixture.java) for testing completion and lookup elements, e.g., when testing completion variants and requiring only one testdata file `CodeInsightTestFixture.testCompletionVariants()`.

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

