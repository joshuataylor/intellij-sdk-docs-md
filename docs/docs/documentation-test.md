# 11. Documentation Test

<tldr>
Tested Functionality: [20. Documentation](documentation-provider.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

## Define a Test Method

Add the `testDocumentation()` method to `SimpleCodeInsightTest` [previously defined](completion-test.html#define-a-test).
This test uses the files `DocumentationTestData.java` and `DocumentationTestData.simple` from the `testData` directory
to construct a test project and opens the first one in the editor with the virtual caret positioned at the usage of the Simple Language property.

Using the `DocumentationManager`, it checks if a target element for documentation is found, retrieves the documentation provider for the
Simple Language and creates the documentation string for the target element.
Finally, the documentation string is verified against the expected output.

```JAVA
public void testDocumentation() {
  myFixture.configureByFiles("DocumentationTestData.java", "DocumentationTestData.simple");
  final PsiElement originalElement = myFixture.getElementAtCaret();
  PsiElement element = DocumentationManager
      .getInstance(getProject())
      .findTargetElement(myFixture.getEditor(), originalElement.getContainingFile(), originalElement);

  if (element == null) {
    element = originalElement;
  }

  final DocumentationProvider documentationProvider = DocumentationManager.getProviderFromElement(element);
  final String generateDoc = documentationProvider.generateDoc(element, originalElement);
  assertNotNull(generateDoc);
  assertSameLinesWithFile(getTestDataPath() + "/" + "DocumentationTest.html.expected", generateDoc);
}
```

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

