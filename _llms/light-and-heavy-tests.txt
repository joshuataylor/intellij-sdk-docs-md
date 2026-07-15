# Light and Heavy Tests

Note: Testing Tutorial and Code Samples

Check out [this step-by-step tutorial](writing-tests-for-plugins.html) teaching how to write and run automated tests for your custom language plugin.

Also, code samples
[comparing_string_references_inspection](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/comparing_string_references_inspection)
and [conditional_operator_intention](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/conditional_operator_intention) demonstrate using tests.

Tip: Configuring Test Frameworks (2024.2+)

All required [test-framework dependencies](tools-intellij-platform-gradle-plugin-dependencies-extension.html#testing) must be declared explicitly.

Plugin tests run in a real, rather than mocked, IntelliJ Platform environment and use real implementations for most application and project [services](plugin-services.html).

Loading and initializing all the project components and services for a project to run tests is a relatively expensive operation, and it is desired to avoid doing it for each test.
Dependently on the loading and execution time, we make a difference between light tests and heavy tests available in the IntelliJ Platform test framework:

* Light tests reuse a project from the previous test run when possible.

* Heavy tests create a new project for each test.

Light and heavy tests use different base classes or fixture classes, as described below.

Note:

Because of the performance difference, we recommend plugin developers to write light tests whenever possible.

## Light Tests

The standard way of writing a light test is to extend one of the following classes:

Default:

Use [LightPlatformTestCase](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/testFramework/src/com/intellij/testFramework/LightPlatformTestCase.java)
or [BasePlatformTestCase](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/testFramework/src/com/intellij/testFramework/fixtures/BasePlatformTestCase.java)
for tests that don't have any dependency on Java functionality.

Examples:

* [JavaCopyrightTest](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-tests/testSrc/com/intellij/copyright/JavaCopyrightTest.kt)

* [HtmlDocumentationTest](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/xml/tests/src/com/intellij/html/HtmlDocumentationTest.kt)

* [AcceptWordAsCorrectTest](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/plugins/grazie/src/test/kotlin/com/intellij/grazie/spellchecker/inspector/AcceptWordAsCorrectTest.java)

Plugins using Java PSI:

Tip: Java Test Framework (2024.2+)

An explicit dependency on `TestFramework.Plugin.Java` is required, see [test-framework dependencies](tools-intellij-platform-gradle-plugin-dependencies-extension.html#testing).

For tests that require the [Java PSI](idea.html#java-plugin) or related functionality:

* [LightJavaCodeInsightFixtureTestCase](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/testFramework/src/com/intellij/testFramework/fixtures/LightJavaCodeInsightFixtureTestCase.java) for JUnit 3

* [LightJavaCodeInsightFixtureTestCase4](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/testFramework/src/com/intellij/testFramework/fixtures/LightJavaCodeInsightFixtureTestCase4.kt) for JUnit 4 (2021.1 and later)

* [LightJavaCodeInsightFixtureTestCase5](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/testFramework/src/com/intellij/testFramework/fixtures/LightJavaCodeInsightFixtureTestCase5.kt) for JUnit 5 (2021.1 and later)

Examples:

* [PatternValidatorTest](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/plugins/IntelliLang/tests/test/org/intellij/plugins/intelliLang/pattern/PatternValidatorTest.java) (JUnit 3)

* [JavaCtrlMouseTest](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-tests/testSrc/com/intellij/java/codeInsight/javadoc/JavaCtrlMouseTest.kt) (JUnit 4)

* [MissingJavadocHighlightingTest](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-tests/testSrc/com/intellij/java/codeInsight/daemon/MissingJavadocHighlightingTest.java) (JUnit 5)

Tip:

See [How to test a JVM language?](testing-faq.html#how-to-test-a-jvm-language) on how to set up your test environment to obtain the required Mock JDK automatically.

### LightProjectDescriptor

When writing a light test, it is possible to specify the requirements of the project used in test, such as the module type, the configured [SDK](sdk.html), [facets](facet.html), [libraries](library.html), etc.
It is done by extending the [LightProjectDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/testFramework/src/com/intellij/testFramework/LightProjectDescriptor.java) class and returning the project descriptor (usually stored in `static final` field) from `getProjectDescriptor()`.

Before executing each test, the project instance will be reused if the test case returns the same project descriptor as the previous one or recreated if the descriptor is different (`equals() = false`).

When [testing JVM languages](testing-faq.html#how-to-test-a-jvm-language), see also [DefaultLightProjectDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/testFramework/src/com/intellij/testFramework/fixtures/DefaultLightProjectDescriptor.java).

## Heavy Tests

The standard way of writing a heavy test is to extend [HeavyPlatformTestCase](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/testFramework/src/com/intellij/testFramework/HeavyPlatformTestCase.java).

Examples:

* [ModuleDeleteProviderTest](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-tests/testSrc/com/intellij/openapi/roots/ui/configuration/actions/ModuleDeleteProviderTest.java)

* [FacetTypeUnloadingTest](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/idea-ui/testSrc/com/intellij/facet/FacetTypeUnloadingTest.kt)

* [SourceFolderManagerTest](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/external-system-impl/testSrc/com/intellij/openapi/externalSystem/service/project/manage/SourceFolderManagerTest.kt)

### Setting Up a Multi-Module Project

If a test requires a multi-module project, using a heavy test is required.
The following code snippet presents a multi-module Java project setup:

```JAVA
TestFixtureBuilder<IdeaProjectTestFixture> projectBuilder =
    IdeaTestFixtureFactory.getFixtureFactory().createFixtureBuilder(getName());

// fixture must be created before adding modules:
myFixture = JavaTestFixtureFactory.getFixtureFactory()
    .createCodeInsightFixture(projectBuilder.getFixture());

// add and configure modules:
JavaModuleFixtureBuilder<?> builder1 =
    projectBuilder.addModule(JavaModuleFixtureBuilder.class);
// optionally, configure the module, e.g.:
// builder1.setLanguageLevel(...);
// builder1.addJdk(...);

JavaModuleFixtureBuilder<?> builder2 =
    projectBuilder.addModule(JavaModuleFixtureBuilder.class);
// configure another module...
```

