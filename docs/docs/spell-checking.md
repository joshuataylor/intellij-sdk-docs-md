# Spell Checking

<tldr>
Product Help: [Spell Checking](https://www.jetbrains.com/help/idea/spellchecking.html)
</tldr>

Spell Checking is used to check the correctness of natural languages within code.
Language plugins can implement customized spell checking by implementing
[SpellcheckingStrategy](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/src/com/intellij/spellchecker/tokenizer/SpellcheckingStrategy.java)
and registering it in the [com.intellij.spellchecker.support](https://jb.gg/ipe?extensions=com.intellij.spellchecker.support) extension point
.

Examples:

* [Custom Language Support Tutorial: Spell Checking](spell-checking-strategy.html)

* [JavaSpellcheckingStrategy](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/java/java-impl/src/com/intellij/spellchecker/JavaSpellcheckingStrategy.java)

* [HtmlSpellcheckingStrategy](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/xml/src/HtmlSpellcheckingStrategy.java)

## 

`SpellcheckingStrategy`

`SpellcheckingStrategy` adjusts the spell checking behavior for PSI elements of a custom language
by providing methods to define:

1. Which PSI elements should be checked by this strategy.

2. How to extract the text from PSI elements.

3. How the text is broken into single words.

The class already contains a default strategy for spell checking of basic parts such as comments,
identifiers and plain text.
If you don't need anything else, you can just inherit from this class and register it.

If you need to check spelling for some specific elements in your language, then override `getTokenizer()`
and use `isMyContext()` to determine if a PSI element should be checked by your strategy.
The `getTokenizer()` method returns an instance of
[Tokenizer](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/src/com/intellij/spellchecker/tokenizer/Tokenizer.java)
and is explained below.

### 

`Tokenizer`

The `tokenize()` method of `Tokenizer` defines which portions of a PSI element
need to be spell-checked by feeding them into the
[TokenConsumer](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/src/com/intellij/spellchecker/tokenizer/TokenConsumer.java).
In the simplest case, the whole PSI element is consumed and its entire text is split into words and
checked for spelling.
For these simple cases, `SpellcheckingStrategy` already contains predefined tokenizers:

* `SpellcheckingStrategy.TEXT_TOKENIZER` for simple text elements.

* `SpellcheckingStrategy.EMPTY_TOKENIZER` for elements that don't require checking.

* `myCommentTokenizer` for comments.

* `myXmlAttributeTokenizer` for XML attributes.

However, there are situations where only fragments of the PSI element are textual content.
In these cases, `tokenize()` can take care of extracting the correct text-ranges and feed them
sequentially into the `TokenConsumer`.
If elements in your language require such special handling, then define a tokenizer by deriving from `Tokenizer`
and implement `tokenize()` with the logic you need.

Example:
[MethodNameTokenizerJava](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/java/java-impl/src/com/intellij/spellchecker/MethodNameTokenizerJava.java)

#### 

`Splitter`

In `Tokenizer.tokenize()` the `consumeToken()` method can take an instance of
[Splitter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/src/com/intellij/spellchecker/inspections/Splitter.java) as the second argument.
The `Splitter` defines how the text is broken into words which is not always as simple as splitting
at white space.
Consider, for instance, identifiers or variables that follow camel-case or snake-case naming and that
need to be separated differently to spell check single parts.
As an example, please see how
[IdentifierSplitter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/src/com/intellij/spellchecker/inspections/IdentifierSplitter.java),
splits identifiers into separate words.

A custom language can define special splitting rules for elements by deriving from `Splitter` and
implementing the logic for obtaining words from the passed text in the `split()` method.

## Suppressing Spellchecking

Custom languages that support the suppression of inspection annotations can derive from
[SuppressibleSpellcheckingStrategy](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/src/com/intellij/spellchecker/tokenizer/SuppressibleSpellcheckingStrategy.java)
to make spell checking suppressible.
The implementation overrides `isSuppressedFor()` to check if a spell check warning is suppressed for the passed element and
overriding `getSuppressActions()` to add quick fix actions that suppress warnings.

Example:
[XmlSpellcheckingStrategy](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/xml/src/XmlSpellcheckingStrategy.java)

## Providing Dictionaries

### 

`BundledDictionaryProvider`

Some custom languages may have a distinct fixed set of words or key identifiers.
These words can be provided in additional dictionaries from
[BundledDictionaryProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/src/com/intellij/spellchecker/BundledDictionaryProvider.java).
Implement `getBundledDictionaries()` to return paths to the word dictionaries (`*.dic` files) and
register it with the [com.intellij.spellchecker.bundledDictionaryProvider](https://jb.gg/ipe?extensions=com.intellij.spellchecker.bundledDictionaryProvider) extension point
.

Example:
[PythonBundledDictionaryProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/python/src/com/jetbrains/python/spellchecker/PythonBundledDictionaryProvider.java)

### 

`RuntimeDictionaryProvider`

[RuntimeDictionaryProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/spellchecker/src/com/intellij/spellchecker/dictionary/RuntimeDictionaryProvider.java)
allows providing (dynamic) dictionaries generated at runtime, e.g., downloaded from a server, created from project sources on-the-fly, etc.
Register in [com.intellij.spellchecker.dictionary.runtimeDictionaryProvider](https://jb.gg/ipe?extensions=com.intellij.spellchecker.dictionary.runtimeDictionaryProvider) extension point
.

Example:
[PyPackagesDictionary](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/python/src/com/jetbrains/python/packaging/PyPackagesDictionary.kt)

## Grammar Checks (Grazie plugin)

[Grazie Lite](https://plugins.jetbrains.com/plugin/12175-grazie-lite) (bundled) and
[Grazie Pro](https://plugins.jetbrains.com/plugin/16136-grazie-pro/)
plugins provide intelligent spelling and grammar checks for all texts.

To use the API mentioned below, add a [dependency](plugin-dependencies.html) on plugin ID `tanvd.grazi`.

### 

`TextExtractor`

To define how to extract natural language text from PSI, implement
[TextExtractor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/grazie/src/main/kotlin/com/intellij/grazie/text/TextExtractor.java)
and register in [com.intellij.grazie.textExtractor](https://jb.gg/ipe?extensions=com.intellij.grazie.textExtractor) extension point
.

Example: [JavaTextExtractor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/grazie/java/src/main/kotlin/com/intellij/grazie/ide/language/java/JavaTextExtractor.java)

### 

`ProblemFilter`

To ignore specific reported problems, implement [ProblemFilter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/grazie/src/main/kotlin/com/intellij/grazie/text/ProblemFilter.java)
registered in [com.intellij.grazie.problemFilter](https://jb.gg/ipe?extensions=com.intellij.grazie.problemFilter) extension point
.

Example: [JavadocProblemFilter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/grazie/java/src/main/kotlin/com/intellij/grazie/ide/language/java/JavadocProblemFilter.java)

