# 4. Annotator Test

<tldr>
Tested Functionality: [7. Annotator](annotator.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

## Define Input Test Data

The `DefaultTestData.simple` file is reused for this test.

Create an input test file `AnnotatorTestData.java` in the `testData` directory.
This file contains two instances of Simple Language embedded in the Java code.
The first instance is a valid use of the `simple:` prefix followed by the Simple Language key `website`.
The second is a valid prefix but an invalid key `websit`, as noted by the test `<error>` [highlighting](testing-highlighting.html).

```JAVA
public class Test {
  public static void main(String[] args) {
    System.out.println("simple:website");
    System.out.println("simple:<error descr="Unresolved property">websit</error>");
  }
}
```

Tip:

See how to [generate highlighting test data](testing-highlighting.html#generating-test-data).

## Define a Test Method

Add the `testAnnotator()` method to `SimpleCodeInsightTest` [previously defined](completion-test.html#define-a-test).
Again, this method configures the test fixture by using the test files.
It then calls the `checkHighlighting()` method to verify weak warnings.

```JAVA
public void testAnnotator() {
  myFixture.configureByFiles("AnnotatorTestData.java", "DefaultTestData.simple");
  myFixture.checkHighlighting(false, false, false, true);
}
```

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

