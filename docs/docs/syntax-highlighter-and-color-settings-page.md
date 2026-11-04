# 5. Syntax Highlighter and Color Settings Page

<tldr>
Reference: [Syntax and Error Highlighting](syntax-highlighting-and-error-highlighting.html)

Code: [SimpleSyntaxHighlighter](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleSyntaxHighlighter.java),
[SimpleSyntaxHighlighterFactory](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleSyntaxHighlighterFactory.java),
[SimpleColorSettingsPage](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleColorSettingsPage.java)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

The first level of syntax highlighting is based on the lexer output, and is provided by `SyntaxHighlighter`.
A plugin can also define color settings based on `ColorSettingPage` so the user can configure highlight colors.

## Define a Syntax Highlighter

The [SimpleSyntaxHighlighter](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleSyntaxHighlighter.java) class extends [SyntaxHighlighterBase](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/openapi/fileTypes/SyntaxHighlighterBase.java).
As recommended in [Color Scheme Management](color-scheme-management.html#text-attribute-key-dependency), the Simple Language highlighting text attributes are specified as a dependency on one of standard IntelliJ Platform keys.
For the Simple Language, define only one scheme.

```JAVA
public class SimpleSyntaxHighlighter extends SyntaxHighlighterBase {

  public static final TextAttributesKey SEPARATOR =
      createTextAttributesKey("SIMPLE_SEPARATOR", DefaultLanguageHighlighterColors.OPERATION_SIGN);
  public static final TextAttributesKey KEY =
      createTextAttributesKey("SIMPLE_KEY", DefaultLanguageHighlighterColors.KEYWORD);
  public static final TextAttributesKey VALUE =
      createTextAttributesKey("SIMPLE_VALUE", DefaultLanguageHighlighterColors.STRING);
  public static final TextAttributesKey COMMENT =
      createTextAttributesKey("SIMPLE_COMMENT", DefaultLanguageHighlighterColors.LINE_COMMENT);
  public static final TextAttributesKey BAD_CHARACTER =
      createTextAttributesKey("SIMPLE_BAD_CHARACTER", HighlighterColors.BAD_CHARACTER);


  private static final TextAttributesKey[] BAD_CHAR_KEYS = new TextAttributesKey[]{BAD_CHARACTER};
  private static final TextAttributesKey[] SEPARATOR_KEYS = new TextAttributesKey[]{SEPARATOR};
  private static final TextAttributesKey[] KEY_KEYS = new TextAttributesKey[]{KEY};
  private static final TextAttributesKey[] VALUE_KEYS = new TextAttributesKey[]{VALUE};
  private static final TextAttributesKey[] COMMENT_KEYS = new TextAttributesKey[]{COMMENT};
  private static final TextAttributesKey[] EMPTY_KEYS = new TextAttributesKey[0];

  @NotNull
  @Override
  public Lexer getHighlightingLexer() {
    return new SimpleLexerAdapter();
  }

  @Override
  public TextAttributesKey @NotNull [] getTokenHighlights(IElementType tokenType) {
    if (tokenType.equals(SimpleTypes.SEPARATOR)) {
      return SEPARATOR_KEYS;
    }
    if (tokenType.equals(SimpleTypes.KEY)) {
      return KEY_KEYS;
    }
    if (tokenType.equals(SimpleTypes.VALUE)) {
      return VALUE_KEYS;
    }
    if (tokenType.equals(SimpleTypes.COMMENT)) {
      return COMMENT_KEYS;
    }
    if (tokenType.equals(TokenType.BAD_CHARACTER)) {
      return BAD_CHAR_KEYS;
    }
    return EMPTY_KEYS;
  }

}
```

### Define a Syntax Highlighter Factory

The factory provides a standard way for the IntelliJ Platform to instantiate the syntax highlighter for Simple Language files.
Here, [SimpleSyntaxHighlighterFactory](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleSyntaxHighlighterFactory.java)
subclasses [SyntaxHighlighterFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/openapi/fileTypes/SyntaxHighlighterFactory.java).

```JAVA
final class SimpleSyntaxHighlighterFactory extends SyntaxHighlighterFactory {

  @NotNull
  @Override
  public SyntaxHighlighter getSyntaxHighlighter(Project project, VirtualFile virtualFile) {
    return new SimpleSyntaxHighlighter();
  }

}
```

### Register the Syntax Highlighter Factory

Register the factory with the IntelliJ Platform in the plugin configuration file using the [com.intellij.lang.syntaxHighlighterFactory](https://jb.gg/ipe?extensions=com.intellij.lang.syntaxHighlighterFactory) extension point
.

```XML
<extensions defaultExtensionNs="com.intellij">
  <lang.syntaxHighlighterFactory
      language="Simple"
      implementationClass="org.intellij.sdk.language.SimpleSyntaxHighlighterFactory"/>
</extensions>
```

### Run the Project with Default Colors

Open the example Simple Language [properties file](lexer-and-parser-definition.html#run-the-project) (`test.simple`) in the IDE Development Instance.
The colors for Simple Language Key, Separator, and Value highlighting default to the IDE Language Defaults for Keyword, Braces, Operators, and Strings, respectively.

![Syntax highlighter](images/syntax_highlighter.png)

## Define a Color Settings Page

The color settings page adds the ability for users to customize color settings for the highlighting in Simple Language files.
The [SimpleColorSettingsPage](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleColorSettingsPage.java)
implements [ColorSettingsPage](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-api/src/com/intellij/openapi/options/colors/ColorSettingsPage.java).

```JAVA
final class SimpleColorSettingsPage implements ColorSettingsPage {

  private static final AttributesDescriptor[] DESCRIPTORS = new AttributesDescriptor[]{
      new AttributesDescriptor("Key", SimpleSyntaxHighlighter.KEY),
      new AttributesDescriptor("Separator", SimpleSyntaxHighlighter.SEPARATOR),
      new AttributesDescriptor("Value", SimpleSyntaxHighlighter.VALUE),
      new AttributesDescriptor("Bad value", SimpleSyntaxHighlighter.BAD_CHARACTER)
  };

  @Override
  public Icon getIcon() {
    return SimpleIcons.FILE;
  }

  @NotNull
  @Override
  public SyntaxHighlighter getHighlighter() {
    return new SimpleSyntaxHighlighter();
  }

  @NotNull
  @Override
  public String getDemoText() {
    return """
        # You are reading the ".properties" entry.
        ! The exclamation mark can also mark text as comments.
        website = https://en.wikipedia.org/
        language = English
        # The backslash below tells the application to continue reading
        # the value onto the next line.
        message = Welcome to \\
                  Wikipedia!
        # Add spaces to the key
        key\\ with\\ spaces = This is the value that could be looked up with the key "key with spaces".
        # Unicode
        tab : \\u0009""";
  }

  @Nullable
  @Override
  public Map<String, TextAttributesKey> getAdditionalHighlightingTagToDescriptorMap() {
    return null;
  }

  @Override
  public AttributesDescriptor @NotNull [] getAttributeDescriptors() {
    return DESCRIPTORS;
  }

  @Override
  public ColorDescriptor @NotNull [] getColorDescriptors() {
    return ColorDescriptor.EMPTY_ARRAY;
  }

  @NotNull
  @Override
  public String getDisplayName() {
    return "Simple";
  }

}
```

It is supported to group related attributes like operators or braces by separating the nodes with `//`, e.g.:

```JAVA
AttributesDescriptor[] DESCRIPTORS = new AttributesDescriptor[] {
    new AttributesDescriptor("Operators//Plus", MySyntaxHighlighter.PLUS),
    new AttributesDescriptor("Operators//Minus", MySyntaxHighlighter.MINUS),
    new AttributesDescriptor("Operators//Advanced//Sigma", MySyntaxHighlighter.SIGMA),
    new AttributesDescriptor("Operators//Advanced//Pi", MySyntaxHighlighter.PI),
    //...
};
```

### Register the Color Settings Page

Register the Simple Language color settings page with the IntelliJ Platform in the plugin configuration file using the [com.intellij.colorSettingsPage](https://jb.gg/ipe?extensions=com.intellij.colorSettingsPage) extension point
.

```XML
<extensions defaultExtensionNs="com.intellij">
  <colorSettingsPage
      implementation="org.intellij.sdk.language.SimpleColorSettingsPage"/>
</extensions>
```

Note:

The Simple Language sample plugin targets a version earlier than 2026.3.
Plugins targeting 2026.3 or later should register the page in the `com.intellij.colorSettings` extension point instead.
See [Registering a Color Settings Page](syntax-highlighting-and-error-highlighting.html#registering-a-color-settings-page) for details.

### Run the Project

[Run](creating-plugin-project.html#running-the-plugin) the plugin.

In the IDE Development Instance, open the Simple Language highlight settings page: `Settings | Editor | Color Scheme | Simple`.
Each color initially inherits from a Language Defaults value.

![Color Settings Page](images/color_settings_page.png)

