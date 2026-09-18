# Plugin Development FAQ

This page contains miscellaneous FAQs. See [Problems with Code - Support Issues](getting-help.html#problems-with-code-support-issues) on how to post new questions.

Tip:

Other common FAQs:

* [IDE Infrastructure](ide-infrastructure.html)

* [User Interface FAQ](ui-faq.html)

* [Testing FAQ](testing-faq.html)

* [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html)

See also [Explore the IntelliJ Platform API](explore-api.html) for more information and strategies.

## Working with XML and XML DOM

Tip:

See also [XML DOM API](xml-dom-api.html).

### How do I register a DTD or XSD?

To register a bundled DTD/XSD file, use [com.intellij.standardResource](https://jb.gg/ipe?extensions=com.intellij.standardResource) extension point

for static
or [com.intellij.standardResourceProvider](https://jb.gg/ipe?extensions=com.intellij.standardResourceProvider) extension point

for programmatic registration.

## Refactoring

### How can I receive notifications about refactoring events?

[RefactoringEventListener](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/refactoring/src/com/intellij/refactoring/listeners/RefactoringEventListener.java)

### How do I show a refactoring dialog programmatically?

[RefactoringActionHandlerFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-api/src/com/intellij/refactoring/RefactoringActionHandlerFactory.java)

## Editors, Documents and Files

* [How can I show several editors for a single file in tabs?](https://intellij-support.jetbrains.com/hc/en-us/community/posts/206795495-Alternative-Editors-ala-HTML-Preview)

