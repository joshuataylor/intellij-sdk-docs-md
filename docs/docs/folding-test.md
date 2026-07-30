# 7. Folding Test

<tldr>
Tested Functionality: [12. Folding Builder](folding-builder.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

Note:

A folding builder must implement [DumbAware](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/project/DumbAware.java) to pass tests.
See [Define a Folding Builder](folding-builder.html#define-a-folding-builder) for more information.

## Define Test Data

Create a file `FoldingTestData.java` in the `testData` directory.
This java file contains markup instructions for three different cases of code folding.

```JAVA
public class Test {
    public static void main(String[] args)<fold text=' { '> {
        </fold>System.out.println("<fold text='https://en.wikipedia.org/'>simple:website</fold>");<fold text=' }'>
    }</fold>
    public static void main1(String[] args)<fold text=' { '> {
        </fold>System.out.println("<fold text='This is the value that could be looked up with the key \"key with spaces\".'>simple:key with spaces</fold>");<fold text=' }'>
    }</fold>
    public static void main2(String[] args)<fold text=' { '> {
        </fold>System.out.println("<fold text='Welcome to \n          Wikipedia!'>simple:message</fold>");<fold text=' }'>
    }</fold>
}
```

## Define a Test

Add the `testFolding()` method to the `SimpleCodeInsightTest` class [previously defined](completion-test.html#define-a-test).
This test method reuses the `DefaultTestData.simple` Simple file.

```JAVA
public void testFolding() {
  myFixture.configureByFile("DefaultTestData.simple");
  myFixture.testFolding(getTestDataPath() + "/FoldingTestData.java");
}
```

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

