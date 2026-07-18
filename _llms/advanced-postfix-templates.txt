# Advanced Postfix Templates

While [simple templates](postfix-templates.html) can be handled by extending
[PostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/PostfixTemplate.java)
class directly, more advanced templates require additional functionalities like selecting the expression that a template should be applied to or editing a template content.
The IntelliJ Platform provides the base classes simplifying advanced template's features implementation.

## Postfix Templates With Expression Selector

In some contexts, it is not obvious what expression a template should be applied to.
Consider the following Java code with the `var` postfix template at the end:

```JAVA
order.calculateWeight() > getMaxWeight(order.getDeliveryType()).var
```

In the above code, a postfix template could be applied to the `getMaxWeight()` method invocation and the entire comparison expression depending on the user's intention.
The postfix template implementation could automatically apply the template on the topmost or the closest applicable expression, but it is reasonable to leave the expression selection for the user.

Postfix templates with expression selector can be achieved by implementing
[PostfixTemplateWithExpressionSelector](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/PostfixTemplateWithExpressionSelector.java)
and
[PostfixTemplateExpressionSelector](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/PostfixTemplateExpressionSelector.java)
classes.

Example:
[IntroduceFieldPostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/IntroduceFieldPostfixTemplate.java)
introduces a Java class field, allowing to select one of the non-void expressions at the current offset.

## Live Template Syntax-Based Postfix Templates

The IntelliJ Platform-based IDEs provide the [Live Templates](https://www.jetbrains.com/help/idea/using-live-templates.html) feature.
It allows defining a template text with dynamic expressions, replaced with actual values depending on the context.
If the implemented postfix template's expanding behavior can be achieved with the live template syntax, it is much easier to extend the
[StringBasedPostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/StringBasedPostfixTemplate.java)
rather than implementing the expansion behavior programmatically.

Example: [StreamPostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/StreamPostfixTemplate.java) wraps array expression within the `Arrays.stream()` method.

Note:

See the [Live Templates](live-templates.html) section in SDK Docs for information on implementing the live templates feature in a plugin.

## Editable Postfix Templates

All postfix templates that return `true` from the
[PostfixTemplate.isEditable()](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/PostfixTemplate.java)
method and have a key starting with `.` (dot) can be edited.
In the simplest case, only the template's name can be edited.
To provide more advanced editing possibilities, like creating new templates in the settings dialog, editing the template's content, variables, expression conditions, etc., a plugin must implement the related
[PostfixTemplateProvider's](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/PostfixTemplateProvider.java)
methods:

* `PostfixTemplateProvider.createEditor()` - returns an instance of the [PostfixTemplateEditor](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/editable/PostfixTemplateEditor.java) class which is responsible for building the UI settings for a particular template and creating a template from the settings provided in this UI. The editor UI may contain settings controls other than the textual editor, like lists, checkboxes, etc.

* `PostfixTemplateProvider.writeExternalTemplate()` and `readExternalTemplate()` - serializes/deserializes a given template to/from XML elements. Serialized template data is stored in the [PostfixTemplateStorage](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/settings/PostfixTemplateStorage.java) [persistent component](persisting-state-of-components.html).

Implementing template, editor, and serialization methods from scratch is a tedious task, so the IntelliJ Platform provides classes that help implement editable templates:

* [EditablePostfixTemplateWithMultipleExpressions](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/editable/EditablePostfixTemplateWithMultipleExpressions.java) for editable templates with expression selector and conditions limiting the applicable contexts. Like [Live Template Syntax-Based Postfix Templates](#live-template-syntax-based-postfix-templates), it is text-based and uses the same live template syntax.

* [PostfixTemplateEditorBase](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/settings/PostfixTemplateEditorBase.java) for editors implementing the most common features like editing content, expression conditions, or using the topmost expression for template expanding

* Utility class [PostfixTemplatesUtils](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/PostfixTemplatesUtils.java) providing methods related to editable template data serialization

Examples:

* [JavaPostfixTemplateProvider](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/JavaPostfixTemplateProvider.java) providing Java editable templates

* [JavaPostfixTemplateEditor](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/editable/JavaPostfixTemplateEditor.java) implementing editor for Java editable templates

* [ObjectsRequireNonNullPostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/ObjectsRequireNonNullPostfixTemplate.java) implementing template wrapping the selected expression in `Objects.requireNonNull()` method

## Surround Postfix Templates

Existing
[Surrounder](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-api/src/com/intellij/lang/surroundWith/Surrounder.java)
implementations of the [Surround With](surround-with.html) feature required to invoke the `Code | Surround With...` action can be reused for postfix completion by extending the
[SurroundPostfixTemplateBase](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/SurroundPostfixTemplateBase.java)
class and returning the surrounder object from the `getSurrounder()` method.

Example:
[NotNullCheckPostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/NotNullCheckPostfixTemplate.java)
surrounding the selected expression with an `if` statement checking if the expression is `null`.

