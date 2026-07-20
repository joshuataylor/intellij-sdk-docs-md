# Custom Language Support

IntelliJ Platform is a powerful platform for building development tools targeting any language.
Most of the IDE features consist of language-independent (provided by the platform) and language-specific parts.
Supporting a particular feature for a new language can be achieved with a small amount of effort:
a plugin must implement only the language-specific part.

## Reference

This part of the documentation explains the main concepts of the Language API and guides you through the sequence of steps that are usually required to develop a custom language plugin.
You can obtain additional information about the Language API from the Javadoc comments for the Language API classes and from the Properties language support source code, which is part of the [IntelliJ Platform](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/README.md) source code.

## Tutorial

If you prefer a full example to the detailed descriptions offered in this section, please check out a step-by-step tutorial on how to create custom language support for Simple Language:
[Custom Language Support Tutorial](custom-language-support-tutorial.html).
Corresponding steps from the tutorial are linked under the "Example" section on each page of this reference.

The webinar [How We Built Comma, the Raku IDE, on the IntelliJ Platform](https://blog.jetbrains.com/platform/2020/01/webinar-recording-how-we-built-comma-the-raku-ide-on-the-intellij-platform/) offers an excellent introduction as well.

[Video: How We Built Comma, the Raku IDE, on the IntelliJ Platform](https://www.youtube.com/v/zDP9uUMYrvs)

## Topics

### Initial Setup

* [Registering a File Type](registering-file-type.html)

* [Implementing Parser and PSI](implementing-parser-and-psi.html)

* [Implementing Lexer](implementing-lexer.html)

* [Syntax and Error Highlighting](syntax-highlighting-and-error-highlighting.html)

*

### Resolving and Completion

* [References and Resolve](references-and-resolve.html) * [Symbols](symbols.html) * [Declarations and References](declarations-and-references.html) * [Poly Symbols](polysymbols.html)

* [Navigation](navigation.html)

* [Code Completion](code-completion.html)

*

### Refactoring

* [Find Usages](find-usages.html)

* [Safe Delete Refactoring](safe-delete-refactoring.html)

* [Rename Refactoring](rename-refactoring.html)

*

### Editor and IDE Features

* [Code Formatter](code-formatting.html)

* [Go to Class and Go to Symbol](go-to-class-and-go-to-symbol.html)

* [Code Inspections and Intentions](code-inspections-and-intentions.html)

* [Documentation](documentation.html)

* [Structure View](structure-view.html)

* [Parameter Info](parameter-info.html)

* [Navigation Bar](navbar.html)

* [Inlay Hints](inlay-hints.html)

* Code Hierarchy

* [Spell Checking](spell-checking.html)

* [Surround With](surround-with.html)

* [Additional Minor Features](additional-minor-features.html)

*

See [Language Server Protocol (LSP)](language-server-protocol.html) for supporting language servers.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

