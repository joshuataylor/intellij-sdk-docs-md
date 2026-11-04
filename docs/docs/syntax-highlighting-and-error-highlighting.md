# Syntax and Error Highlighting

<tldr>
Product Help: [Colors and fonts](https://www.jetbrains.com/help/idea/configuring-colors-and-fonts.html)

UI Guidelines: [Inspections](inspections.html)
</tldr>

The syntax and error highlighting are performed on multiple levels: [Lexer](#lexer), [Parser](#parser), and [Annotator](#annotator)/[External Annotator](#external-annotator).

## Text Attributes Key

How a particular range of text should be highlighted is defined via [TextAttributesKey](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/editor/colors/TextAttributesKey.java).
An instance of this class is created for every distinct type of item that should be highlighted (keyword, number, string literal, etc.).

The `TextAttributesKey` defines the default attributes applied to items of the corresponding type (for example, keywords are bold, numbers are blue, string literals are bold and green).
Highlighting from multiple `TextAttributesKey` items can be layered — for example, one key may define an item's boldness and another one its color.

Tip: Looking up existing TextAttributeKey

To inspect applied `TextAttributesKey`(s) in the editor for the element at the caret, use `Jump to Colors and Fonts` action.

The underlying `TextAttributeKey`'s external name for items in `Settings | Editor | Color Scheme` can be inspected using [UI Inspector](internal-ui-inspector.html#inspecting-settings).

## Color Settings

The mapping of the `TextAttributesKey` to specific attributes used in an editor is defined by the [EditorColorsScheme](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/openapi/editor/colors/EditorColorsScheme.java) class.
It can be configured by the user via `Settings | Editor | Color Scheme` by providing an implementation of [ColorSettingsPage](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-api/src/com/intellij/openapi/options/colors/ColorSettingsPage.java).

To look up the external name for a setting in the IDE, use [UI Inspector](internal-ui-inspector.html#inspecting-settings).

The `File | Export | Files or Selection to HTML` feature uses the same syntax highlighting mechanism as the editor.
Thus, it will work automatically for custom languages that provide a syntax highlighter.

Examples:

* [ColorSettingsPage](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/properties/src/com/intellij/lang/properties/PropertiesColorsPage.java) for [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/properties)

* [DebuggerColorsPage](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/xdebugger-impl/ui/src/com/intellij/xdebugger/impl/ui/DebuggerColorsPage.java) and its [com.intellij.colorSettings declaration](https://github.com/JetBrains/intellij-community/tree/master/platform/xdebugger-impl/ui/resources/intellij.platform.debugger.impl.ui.xml) with a localized name

* [Custom Language Support Tutorial: Color Settings Page](syntax-highlighter-and-color-settings-page.html)

Note:

See the note about Language Defaults and support for additional color schemes in [Color Scheme Management](color-scheme-management.html).

### Registering a Color Settings Page

The extension point to use depends on the IntelliJ Platform version the plugin targets.

2026.3+:

Register the color settings page in [com.intellij.colorSettings](https://jb.gg/ipe?extensions=com.intellij.colorSettings) extension point
:

```XML
<extensions defaultExtensionNs="com.intellij">
  <colorSettings
      implementation="com.example.MyColorSettingsPage"
      displayName="My Language"/>
</extensions>
```

For a localized page name, use the `key` and `bundle` attributes instead of `displayName`:

```XML
<extensions defaultExtensionNs="com.intellij">
  <colorSettings
      implementation="com.example.MyColorSettingsPage"
      bundle="messages.MyBundle"
      key="color.settings.my.language.name"/>
</extensions>
```

The page class still implements `ColorSettingsPage`.
The values in the declaration must match the values that the page class returns, because the IDE uses the declaration in the Settings tree and the class on the page itself.

The [ColorSettingsPageEP](https://github.com/JetBrains/intellij-community/tree/master/platform/platform-impl/src/com/intellij/application/options/colors/ColorSettingsPageEP.java) bean supports the following attributes:

| Attribute |Required |Description |
------------------------------------
| `implementation` |yes |FQN of the `ColorSettingsPage` implementation. |
| `displayName` |yes (1) |The non-localized page name. It must match `getDisplayName()`.  For a localized name, omit `displayName` and use `key` and `bundle`.   |
| `key` and `bundle` |yes (1) |The [localization](internationalization.html#message-bundles) key and bundle for the page name. The resolved name must match `getDisplayName()`.  If `bundle` is omitted, the plugin's [&lt;resource-bundle&gt;](plugin-configuration-file.html#idea-plugin__resource-bundle) is used.   |
| `pageId` |no |The ID of the page. The default is the `implementation` value, which is also what `getId()` returns by default.  Specify it only if the page class overrides `getId()`, and use the same value.  The common [id](plugin-configuration-file.html#idea-plugin__extensions__-) attribute of extensions does not set the page ID.   |
| `priority` |no |The group of the page in the Color Scheme tree, as a [DisplayPriority](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-api/src/com/intellij/psi/codeStyle/DisplayPriority.java) value, for example, `COMMON_SETTINGS`. The default is `LANGUAGE_SETTINGS`.  Specify it if the page class implements [DisplayPrioritySortable](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-api/src/com/intellij/psi/codeStyle/DisplayPrioritySortable.java), and use the value that `getPriority()` returns.   |
| `keyLanguageIn` |no |A comma-separated list of [platform prefixes](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/util/PlatformUtils.java) of the products in which the page belongs to the `KEY_LANGUAGE_SETTINGS` group, for example, `keyLanguageIn="WebStorm,PhpStorm"`. In all other products, the page uses the `priority` value.  Use it if `getPriority()` returns a different value depending on the product.   |
| `groupWeight` |no |The order of the page within its `priority` group. Pages with a higher weight come first. Pages with equal weight are sorted by name. The default is 0.  Specify it if the page class implements `DisplayPrioritySortable.getWeight()`, and use the same value.   |
| `beta` |no |`true` adds a Beta label next to the page name in the Settings tree. |

(1) Either `displayName` or `key` and `bundle` must be specified, depending on whether the page name is localized.
If the declaration states no name, the IDE reports an error.

Earlier versions:

Register the color settings page in [com.intellij.colorSettingsPage](https://jb.gg/ipe?extensions=com.intellij.colorSettingsPage) extension point
:

```XML
<extensions defaultExtensionNs="com.intellij">
  <colorSettingsPage
      implementation="com.example.MyColorSettingsPage"/>
</extensions>
```

Warning: Deprecated extension point

The `com.intellij.colorSettingsPage` extension point is deprecated since 2026.3 but still works.
If the plugin's [since-build](plugin-configuration-file.html#idea-plugin__idea-version) is 263 or later, use `com.intellij.colorSettings` instead.

A plugin that also supports earlier versions can register the page class with both extension points.
2026.3 and later use the `com.intellij.colorSettings` declaration and ignore the `com.intellij.colorSettingsPage` one.
Earlier versions ignore the unknown `com.intellij.colorSettings` declaration, but the plugin then can't be loaded or unloaded [without a restart](dynamic-plugins.html) in them.
If that matters, register only `com.intellij.colorSettingsPage` until the plugin drops support for versions earlier than 2026.3.

## Lexer

The first syntax highlighting level is based on the lexer output and is provided through the [SyntaxHighlighter](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/openapi/fileTypes/SyntaxHighlighter.java) interface.
The syntax highlighter returns the `TextAttributesKey` instances for each token type, which needs special highlighting.
For highlighting lexer errors use [HighlighterColors.BAD_CHARACTER](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/editor/HighlighterColors.java).

Examples:

* [SyntaxHighlighter](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/properties/properties-psi-api/src/com/intellij/lang/properties/PropertiesHighlighter.java) implementation for [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/properties)

* [Custom Language Support Tutorial: Syntax Highlighter](syntax-highlighter-and-color-settings-page.html)

Tip: Creating highlighted code sample

Use [HtmlSyntaxInfoUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-impl/src/com/intellij/openapi/editor/richcopy/HtmlSyntaxInfoUtil.java) to create Lexer-based highlighted code samples, e.g., for usage in documentation.

### Semantic Highlighting

[Semantic highlighting](https://www.jetbrains.com/help/idea/configuring-colors-and-fonts.html#semantic-highlighting) provides an additional coloring layer to improve the visual distinction of several related items (e.g., method parameters, local variables).

Register [RainbowVisitor](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-impl/src/com/intellij/codeInsight/daemon/RainbowVisitor.java)
in [com.intellij.highlightVisitor](https://jb.gg/ipe?extensions=com.intellij.highlightVisitor) extension point
.
[Color Settings](#color-settings) must implement [RainbowColorSettingsPage](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-api/src/com/intellij/openapi/options/colors/RainbowColorSettingsPage.java) in addition.

## Parser

The second level of error highlighting happens during parsing.
If, according to the grammar of the language, a particular sequence of tokens is invalid, the [PsiBuilder.error()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/lang/PsiBuilder.java) method can highlight the invalid tokens and display an error message showing why they are not valid.

See [Syntax Errors](syntax-errors.html) on how to programmatically suppress these errors in certain contexts.

## Annotator

The third level of highlighting is performed through the [Annotator](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-api/src/com/intellij/lang/annotation/Annotator.java) interface.
A plugin can register one or more annotators in the [com.intellij.annotator](https://jb.gg/ipe?extensions=com.intellij.annotator) extension point
, and these annotators are called during the background highlighting pass to process the elements in the custom language's PSI tree.
Attribute `language` should be set to the Language ID where this annotator applies to.
If highlighting data requires invoking external tools, use an [External Annotator](#external-annotator) instead.

Annotators can analyze not only the syntax, but also the semantics using PSI, and thus can provide much more complex syntax and error highlighting logic.
The annotator can also provide quick fixes to problems it detects.
When the file is changed, the annotator is called incrementally to process only changed elements in the PSI tree.

Annotators not requiring information from [indexes](indexing-and-psi-stubs.html) can be marked [dumb aware](indexing-and-psi-stubs.html#DumbAwareAPI) to work during indexing (e.g., for additional [syntax highlighting](#syntax)). (2023.1+)

Note:

See also [Code Inspections](code-inspections-and-intentions.html) which offer more fine-grained control and some additional features.

### Errors/Warning

See the [Inspections](inspections.html) topic in UI Guidelines on how to write message texts for highlighting/quick fixes.

To highlight a region of a text as a warning or error:

```JAVA
holder.newAnnotation(HighlightSeverity.WARNING, "Invalid code") // or HighlightSeverity.ERROR
    .withFix(new MyFix(psiElement))
    .create();
```

### Syntax

To apply additional syntax highlighting:

```JAVA
holder.newSilentAnnotation(HighlightSeverity.INFORMATION)
    .range(rangeToHighlight)
    .textAttributes(MyHighlighter.EXTRA_HIGHLIGHT_ATTRIBUTE)
    .create();
```

Examples:

* [Annotator](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/properties/properties-psi-impl/src/com/intellij/lang/properties/PropertiesAnnotator.java) for [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/properties)

* [Custom Language Support Tutorial: Annotator](annotator.html)

## External Annotator

If the custom language employs external tools for validating files in the language (for example, using the Xerces library for XML schema validation),
it can provide an implementation of the [ExternalAnnotator](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-api/src/com/intellij/lang/annotation/ExternalAnnotator.java) interface and register
it in [com.intellij.externalAnnotator](https://jb.gg/ipe?extensions=com.intellij.externalAnnotator) extension point
(`language` attribute must be specified).

The `ExternalAnnotator` highlighting has the lowest priority and is invoked only after all other background processing has completed.
It uses the same [AnnotationHolder](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-api/src/com/intellij/lang/annotation/AnnotationHolder.java) interface for converting the output of the external tool into editor highlighting.

To skip running specific `ExternalAnnotator` for a given file, register an [ExternalAnnotatorsFilter](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-api/src/com/intellij/lang/ExternalAnnotatorsFilter.java) extension
in [com.intellij.daemon.externalAnnotatorsFilter](https://jb.gg/ipe?extensions=com.intellij.daemon.externalAnnotatorsFilter) extension point
.

To enable running `ExternalAnnotator` during indexing in [dumb mode](indexing-and-psi-stubs.html#dumb-mode), it can be marked [dumb aware](indexing-and-psi-stubs.html#DumbAwareAPI) (2023.3).

## Controlling Highlighting

Existing highlighting can be suppressed programmatically in certain contexts, see [Controlling Highlighting](controlling-highlighting.html).

To force re-highlighting all open or specific file(s) (e.g., after changing plugin-specific settings), use
[DaemonCodeAnalyzer.restart()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-api/src/com/intellij/codeInsight/daemon/DaemonCodeAnalyzer.java).

## Order of Running Highlighting

[Inspections](code-inspections-and-intentions.html) and [annotators](#annotator) do not run sequentially on each `PsiElement` anymore.
Instead, they're run in parallel on all relevant PSI independently with the following consequences.

Independent Annotators

[Annotators](#annotator) are run independent of each other: if an annotator found an error, it no longer stops annotating the `PsiElement`'s parents.
Effectively, there is "more" highlighting now.

Highlight Range

Producing highlights must be done as close as possible for the relevant `PsiElement`.
For example, instead of

```TEXT
annotate(PsiFile) {
  <<highlight all relevant identifiers>>
}
```

this approach should be used:

```TEXT
annotate(PsiIdentifier) {
  <<highlight this identifier if it's relevant>>
}
```

The latter version:

* performs faster highlighting – it doesn't have to wait until all other identifiers are visited

* removes outdated highlights faster – right after the identifier was visited and the annotator didn't produce a highlighting anymore

