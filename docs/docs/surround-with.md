# Surround With

<tldr>
Product Help: [Surround code fragments](https://www.jetbrains.com/help/idea/surrounding-blocks-of-code-with-language-constructs.html)
</tldr>

To support the Surround With action, the plugin needs to register one or more implementations of the [SurroundDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/lang/surroundWith/SurroundDescriptor.java) interface
in the [com.intellij.lang.surroundDescriptor](https://jb.gg/ipe?extensions=com.intellij.lang.surroundDescriptor) extension point
.
Each of the surround descriptors defines a possible type of code fragment that can be surrounded - for example, one surround descriptor can handle surrounding expressions, and another can handle statements.
Each surround descriptor, in turn, contains an array of [Surrounder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/lang/surroundWith/Surrounder.java) objects, defining specific templates which can be used for surrounding the selected code fragment (for example, Surround With if, Surround With for, and so on).

When the `Code | Surround With...` action is invoked, the IDE queries all surround descriptors for the language until it finds one that returns a non-empty array from its `getElementsToSurround()` method.
Then it calls the [Surrounder.isApplicable()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/lang/surroundWith/Surrounder.java) method for each surrounder in that descriptor to check if the specific template is applicable in the current context.
Once the user selects a specific surrounder from the popup menu, the [Surrounder.surroundElements()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/lang/surroundWith/Surrounder.java) method is used to execute the surround action.

Example:
[SurroundDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/groovy/src/org/jetbrains/plugins/groovy/lang/surroundWith/GroovySurroundDescriptor.java) for Groovy plugin

Note:

See the [Live Templates](live-templates.html) and [Surround Postfix Templates](advanced-postfix-templates.html#surround-postfix-templates) sections for information on how to support code surrounding with other IDE features.

