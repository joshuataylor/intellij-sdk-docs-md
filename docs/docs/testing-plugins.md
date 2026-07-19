# Testing Overview

Most of the tests in the IntelliJ Platform codebase are model-level functional tests.
What this means is the following:

* The tests run in a headless environment that uses real production implementations for most components, except for many UI components.

* The tests usually test a feature as a whole rather than individual functions that comprise its implementation.

* The tests do not test the Swing UI and work directly with the underlying model instead (see also [Integration and UI Tests](#integration-and-ui-tests)).

* Most tests take a source file or a set of source files as [input data](test-project-and-testdata-directories.html), execute a feature, and compare the output with expected results. Results can be specified as another set of source files, [special markup](testing-highlighting.html) in the input file, or directly in the test code.

The most significant benefit of this test approach is that tests are very stable and require very little maintenance once written, no matter how much the underlying implementation is refactored or rewritten.

In a product with 20+ years of a lifetime that has gone through many internal refactorings, we find that this benefit dramatically outweighs the downsides of slower test execution and more difficult debugging of failures compared to more isolated unit tests.

## Mocks

Another consequence of our testing approach is that we do not provide a recommended approach to mocking.
We have a few tests in our codebase that use JMock.
Still, in general, we find it difficult to mock all the interactions with IntelliJ Platform components that your plugin class will need to have.
We recommend working with real components instead.
See also [How to replace a component/service in tests?](testing-faq.html#how-to-replace-a-componentservice-in-tests) and [How to replace extension points in tests?](testing-faq.html#how-to-replace-extension-points-in-tests).

## Integration and UI Tests

[Video](https://www.youtube.com/v/UJexzfG01Qo)
Check out [Introduction to Integration Tests](integration-tests-intro.html) tutorial that guides through setup process and writing the first test.

## Topics

Note: Testing Tutorial and Code Samples

Check out [this step-by-step tutorial](writing-tests-for-plugins.html) teaching how to write and run automated tests for your custom language plugin.

Also, code samples
[comparing_string_references_inspection](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/comparing_string_references_inspection)
and [conditional_operator_intention](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/conditional_operator_intention) demonstrate using tests.

* [Tests and Fixtures](tests-and-fixtures.html)

* [Light and Heavy Tests](light-and-heavy-tests.html)

* [Test Project and Testdata Directories](test-project-and-testdata-directories.html)

* [Writing Tests](writing-tests.html)

* [Testing Highlighting](testing-highlighting.html)

* [Testing FAQ](testing-faq.html)

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

