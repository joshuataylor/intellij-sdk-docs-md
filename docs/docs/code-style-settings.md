# 17. Code Style Settings

<tldr>
Reference: [Code Style Settings](code-formatting.html#code-style-settings)

Code: [SimpleCodeStyleSettings](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleCodeStyleSettings.java),
[SimpleCodeStyleSettingsProvider](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleCodeStyleSettingsProvider.java),
[SimpleLanguageCodeStyleSettingsProvider](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleLanguageCodeStyleSettingsProvider.java)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

Code style settings enable defining formatting options.
A code style settings provider creates an instance of the settings and also creates an options page in Settings.
This example creates a Settings page that uses the default language code style settings, customized by a language code style settings provider.

## Define Code Style Settings

Define [SimpleCodeStyleSettings](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleCodeStyleSettings.java)
for Simple Language by subclassing [CustomCodeStyleSettings](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/code-style-api/src/com/intellij/psi/codeStyle/CustomCodeStyleSettings.java).

```JAVA
public class SimpleCodeStyleSettings extends CustomCodeStyleSettings {

  public SimpleCodeStyleSettings(CodeStyleSettings settings) {
    super("SimpleCodeStyleSettings", settings);
  }

}
```

## Define Code Style Settings Provider

The code style settings provider gives the IntelliJ Platform a standard way to instantiate `CustomCodeStyleSettings` for the Simple Language.

Define [SimpleCodeStyleSettingsProvider](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleCodeStyleSettingsProvider.java)
for Simple Language by subclassing [CodeStyleSettingsProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/psi/codeStyle/CodeStyleSettingsProvider.java).

```JAVA
final class SimpleCodeStyleSettingsProvider extends CodeStyleSettingsProvider {

  @Override
  public CustomCodeStyleSettings createCustomSettings(@NotNull CodeStyleSettings settings) {
    return new SimpleCodeStyleSettings(settings);
  }

  @Override
  public String getConfigurableDisplayName() {
    return "Simple";
  }

  @NotNull
  public CodeStyleConfigurable createConfigurable(@NotNull CodeStyleSettings settings,
                                                  @NotNull CodeStyleSettings modelSettings) {
    return new CodeStyleAbstractConfigurable(settings, modelSettings, this.getConfigurableDisplayName()) {
      @Override
      protected @NotNull CodeStyleAbstractPanel createPanel(@NotNull CodeStyleSettings settings) {
        return new SimpleCodeStyleMainPanel(getCurrentSettings(), settings);
      }
    };
  }

  private static class SimpleCodeStyleMainPanel extends TabbedLanguageCodeStylePanel {

    public SimpleCodeStyleMainPanel(CodeStyleSettings currentSettings, CodeStyleSettings settings) {
      super(SimpleLanguage.INSTANCE, currentSettings, settings);
    }

  }

}
```

## Register the Code Style Settings Provider

The `SimpleCodeStyleSettingsProvider` implementation is registered with the IntelliJ Platform in the plugin configuration file
using the [com.intellij.codeStyleSettingsProvider](https://jb.gg/ipe?extensions=com.intellij.codeStyleSettingsProvider) extension point
.

```XML
<extensions defaultExtensionNs="com.intellij">
  <codeStyleSettingsProvider
      implementation="org.intellij.sdk.language.SimpleCodeStyleSettingsProvider"/>
</extensions>
```

## Define the Language Code Style Settings Provider

Define [SimpleLanguageCodeStyleSettingsProvider](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleLanguageCodeStyleSettingsProvider.java) for Simple Language by subclassing [LanguageCodeStyleSettingsProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-api/src/com/intellij/psi/codeStyle/LanguageCodeStyleSettingsProvider.java), which provides common code style settings for a specific language.

```JAVA
final class SimpleLanguageCodeStyleSettingsProvider extends LanguageCodeStyleSettingsProvider {

  @NotNull
  @Override
  public Language getLanguage() {
    return SimpleLanguage.INSTANCE;
  }

  @Override
  public void customizeSettings(@NotNull CodeStyleSettingsCustomizable consumer, @NotNull SettingsType settingsType) {
    if (settingsType == SettingsType.SPACING_SETTINGS) {
      consumer.showStandardOptions("SPACE_AROUND_ASSIGNMENT_OPERATORS");
      consumer.renameStandardOption("SPACE_AROUND_ASSIGNMENT_OPERATORS", "Separator");
    } else if (settingsType == SettingsType.BLANK_LINES_SETTINGS) {
      consumer.showStandardOptions("KEEP_BLANK_LINES_IN_CODE");
    }
  }

  @Override
  public String getCodeSample(@NotNull SettingsType settingsType) {
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

}
```

## Register the Language Code Style Settings Provider

The ``SimpleLanguageCodeStyleSettingsProvider` implementation is registered with the IntelliJ Platform in the plugin configuration file
using the [com.intellij.langCodeStyleSettingsProvider](https://jb.gg/ipe?extensions=com.intellij.langCodeStyleSettingsProvider) extension point
.

```XML
<extensions defaultExtensionNs="com.intellij">
  <langCodeStyleSettingsProvider
      implementation="org.intellij.sdk.language.SimpleLanguageCodeStyleSettingsProvider"/>
</extensions>
```

## Run the Project

[Run](creating-plugin-project.html#running-the-plugin) the plugin.

In the IDE Development Instance, open the Simple Language code formatting page: `Settings | Editor | Code Style | Simple`.

![Code Style Settings](images/code_style_settings.png)

