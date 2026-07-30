# Tests and Fixtures

Note: Testing Tutorial and Code Samples

Check out [this step-by-step tutorial](writing-tests-for-plugins.html) teaching how to write and run automated tests for your custom language plugin.

Also, code samples
[comparing_string_references_inspection](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/comparing_string_references_inspection)
and [conditional_operator_intention](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/conditional_operator_intention) demonstrate using tests.

The IntelliJ Platform testing infrastructure is not tied to any specific test framework.
In fact, the IntelliJ IDEA Team uses [JUnit](https://junit.org), [TestNG](https://testng.org), and [Cucumber](https://cucumber.io/) for testing different parts of the project.
However, most of the tests are written using JUnit 3.

When writing your tests, you have the choice between using a standard base class to perform the test set up for you and using a fixture class, which lets you perform the setup manually and does not tie you to a specific test framework.

Tip: Configuring Test Frameworks (2024.2+)

All required [test-framework dependencies](tools-intellij-platform-gradle-plugin-dependencies-extension.html#testing) must be declared explicitly.

With the former approach, you can use classes such as [BasePlatformTestCase](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/testFramework/src/com/intellij/testFramework/fixtures/BasePlatformTestCase.java).

With the latter approach, you use the [IdeaTestFixtureFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/testFramework/src/com/intellij/testFramework/fixtures/IdeaTestFixtureFactory.java) class to create instances of fixtures for the test environment.
You need to call the fixture creation and setup methods from the test setup method used by your test framework.

