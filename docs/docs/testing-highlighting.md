# Testing Highlighting

Note: Testing Tutorial and Code Samples

Check out [this step-by-step tutorial](writing-tests-for-plugins.html) teaching how to write and run automated tests for a custom language plugin.

Also, code samples
[comparing_string_references_inspection](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/comparing_string_references_inspection)
and [conditional_operator_intention](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/conditional_operator_intention) demonstrate using tests.

Tip: Configuring Test Frameworks (2024.2+)

All required [test-framework dependencies](tools-intellij-platform-gradle-plugin-dependencies-extension.html#testing) must be declared explicitly.

When writing plugin tests, a common task is testing various kinds of highlighting (inspections, annotators, parser error highlighting, etc.).
The IntelliJ Platform provides a dedicated utility and markup format for this task.

To test the highlighting for the file currently loaded into the in-memory editor, invoke [CodeInsightTestFixture.checkHighlighting()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/testFramework/src/com/intellij/testFramework/fixtures/CodeInsightTestFixture.java).
The parameters to the method specify which severities should be taken into account when comparing the results with the expected results: errors are always taken into account, whereas warnings, weak warnings, and infos are optional.
To ignore verifying additional highlighting, set parameter `ignoreExtraHighlighting` to `true`.

Alternatively, you can use `CodeInsightTestFixture.testHighlighting()`, which loads a [testdata file](test-project-and-testdata-directories.html) into the in-memory editor and highlights it as a single operation.

Example:
[Custom Language Support Tutorial: Testing Annotator](annotator-test.html)

## Inspections

Inspections to be tested must be enabled explicitly.
This is done by calling `CodeInsightTestFixture.enableInspections()` in the setup method of the test or directly in a test method, before the call to `CodeInsightTestFixture.checkHighlighting()`.

## Syntax Highlighting

To test syntax highlighting provided by [Lexer](implementing-lexer.html), use [EditorTestUtil.testFileSyntaxHighlighting()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/testFramework/src/com/intellij/testFramework/EditorTestUtil.java).

This method takes the tested file and the answer file describing expected highlighting information for each token.
The answer file format is as follows:

```TEXT
token_value
    EXPECTED_TEXT_ATTRIBUTE_KEY => FALLBACK_KEY
string␣value
    MY_TEXT_ATTRIBUTE_KEY => MY_FALLBACK_KEY => DEFAULT_STRING
```

It starts with token value, which is the actual token value from the tested file (space characters in token value are replaced with `␣`).
It is followed by indented list of text attribute keys, starting with the key defined for the given token, followed by fallback keys separated by `=>`.

Creating an answer file from scratch would be cumbersome process, so it is recommended to provide only the tested file and executing the test.
Test will fail and the expected answer file will be generated.
Review the generated file carefully, and provide fixes to the syntax highlighter and the answer file if needed.

## Expected Highlighting Results

The expected results of the highlighting are specified directly in the source file.
The platform supports an extensive XML-like markup language for this.
In its simplest form, the markup looks like this:

```XML
<warning descr="expected warning message">code to be highlighted</warning>
```

A more realistic example, embedded in Java test data to be highlighted:

```XML
public int <warning descr="The compareTo() method does not reference 'foo' which is referenced from equals(); inconsistency may result">compareTo</warning>(Simple other) {
  return 0;
}
```

### Severities

The tag name specifies the severity of the expected highlighting.
The following severities are supported:

* `<error>`

* `<warning>`

* `<weak_warning>`

* `<info>`

* `<inject>` for an [injected fragment](language-injection.html)

* `<symbolName>` for a marker that highlights an identifier according to its type

* any custom severity can be referenced by its name

### Optional Attributes

The tag can also have the following optional attributes.

Message

* `descr` expected message associated with the highlighter (if not specified, any text will match). If the message contains a quotation mark, it can be escaped by putting two backslash characters before it.

* `tooltip` expected tooltip message

Visual

* `textAttributesKey` expected [TextAttributesKey](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/editor/colors/TextAttributesKey.java) referenced by its `externalName`

* `foregroundColor`, `backgroundColor`, `effectColor` expected colors for the highlighting

* `effectType` expected effect type for the highlighting (see [EffectType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/editor/markup/EffectType.java))

* `fontType` expected font style for the highlighting (`0` - normal, `1` - bold, `2` - italic, `3` - bold italic)

### Special Cases

Nested tags are supported:

```XML
<warning>warning_highlight<info>warning_and_info_highlight</info>warning_highlight</warning>
```

Overlapping tags (annotations) are currently not supported in the test framework (but displayed correctly in the editor, albeit this is not an officially supported scenario):

```XML
<warning>warning_highlight<info>warning-and_info_highlight</warning>info_highlight</info>
```

### Generating Test Data

To generate an expected highlighting result file for a test:

1. Make sure that Plugin DevKit plugin is installed and [internal mode is enabled](enabling-internal.html).

2. [Create a Scratch file](https://www.jetbrains.com/help/idea/scratches.html#create-scratch-file) for the tested language.

3. Write code causing tested highlighting.

4. Invoke the `Tools | Internal Actions | DevKit | Toggle Expected Highlighting Markup` action.

