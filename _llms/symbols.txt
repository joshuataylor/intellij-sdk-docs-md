# Symbols

Warning:

This API is currently in development and thus in an experimental state.

A symbol is a semantic element in some model, e.g., language or framework model.

The IntelliJ Platform uses [Symbol](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/model/Symbol.java) to represent symbols, and `Symbol` serves as a link between Platform APIs, such as navigation, finding usages, or renaming.
This API allows implementing the same functionalities as in the [References and Resolve](references-and-resolve.html) mechanism, but it is a more abstract concept not limited to connecting only PSI elements.
The platform obtains the target symbol from a [declaration](declarations-and-references.html#declarations) or by resolving a [reference](declarations-and-references.html#references) and then uses it to perform an action.
The [PsiElement](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/psi/PsiElement.java) is considered as an element in the source tree (enhanced `ASTNode`).
`Symbol` decouples semantic actions from [PSI](psi.html).

A `Symbol` is not required to be backed by a `PsiElement`, and it is incorrect to try to obtain the `PsiElement` from a `Symbol`.
`Symbol` is not required to be bound to a `Project` as well, meaning the same instance might be shared between [projects](project.html).

Examples:

* Java local variable is a symbol in Java language model, it's backed by a `PsiVariable` element.

* Compiled class is a symbol in JVM model, it's backed by JDK library stubs, and it's not bound to any project.

* Spring Bean is a symbol in [Spring framework model](spring-api.html), it's defined on-the-fly by framework support (not backed by a `PsiElement`) and bound to a `Project`.

* Database column is a symbol defined by data source (not backed by a `PsiElement`) and not bound to a `Project` since database elements might be shared between projects.

See also [Poly Symbols](polysymbols.html).

## Lifecycle

The `Symbol` instance is expected to stay valid within a single [read action](threading-model.html), which means it's safe to pass the instance to different APIs.
A `Symbol` instance should not be referenced between read actions.
One should create a pointer via `Symbol.createPointer()` in the current read action, and then call `Pointer.dereference()` to obtain a `Symbol` instance in the subsequent read action.

## Sample plugins

* Java: [StringFormatSymbolReferenceProvider](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/java/java-impl/src/com/siyeh/ig/format/StringFormatSymbolReferenceProvider.java)

* JVM languages: [LoggingArgumentSymbolReferenceProvider](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/jvm/jvm-analysis-impl/src/com/intellij/analysis/logging/resolve/LoggingArgumentSymbolReferenceProvider.kt)

* Markdown: [link labels](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/plugins/markdown/model/src/main/kotlin/org/intellij/plugins/markdown/model/psi/labels)

