# 10. Reference Test

<tldr>
Tested Functionality: [10. Reference Contributor](reference-contributor.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

## Define Test Data

This test reuses the Simple Language file `DefaultTestData.simple`.

Create the test file `ReferenceTestData.java` in the `testData` directory.
This file has one Simple Language prefix and key, with the caret placed after the key.

```JAVA
public class Test {
  public static void main(String[] args) {
    System.out.println("simple:website<caret>");
  }
}
```

## Define a Test Method

Add the `testReference()` method to `SimpleCodeInsightTest` [previously defined](completion-test.html#define-a-test).
This test is configured by the test files.
The fixture gets the `PsiReference` at the caret position, and then asserts the resolved `SimpleProperty.value()` with the known value of that key.

```JAVA
public void testReference() {
  PsiReference referenceAtCaret =
      myFixture.getReferenceAtCaretPositionWithAssertion("ReferenceTestData.java", "DefaultTestData.simple");
  final SimpleProperty resolvedSimpleProperty = assertInstanceOf(referenceAtCaret.resolve(), SimpleProperty.class);
  assertEquals("https://en.wikipedia.org/", resolvedSimpleProperty.getValue());
}
```

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

