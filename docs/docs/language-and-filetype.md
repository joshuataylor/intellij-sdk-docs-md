# 2. Language and File Type

<tldr>
Reference: [Registering a File Type](registering-file-type.html)

Code: [SimpleLanguage](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleLanguage.java),
[SimpleIcons](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleIcons.java),
[SimpleFileType](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleFileType.java)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

The IntelliJ Platform determines file type by examining the name of a file.
Each language has [Language](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/lang/Language.java) and [LanguageFileType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/fileTypes/LanguageFileType.java) objects defining the language.
Register the `LanguageFileType` with the IntelliJ Platform in the plugin configuration file.

## Define the Language

The language implemented in this tutorial is named "Simple" - note the case of the name.
The [SimpleLanguage](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleLanguage.java) class is defined in the `org.intellij.sdk.language` package of the `simple_language_plugin` code sample:

```JAVA
public class SimpleLanguage extends Language {

  public static final SimpleLanguage INSTANCE = new SimpleLanguage();

  private SimpleLanguage() {
    super("Simple");
  }

}
```

## Define an Icon

The [icon](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/resources/icons/jar-gray.png) for the Simple Language is defined by the
[SimpleIcons](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleIcons.java) class.
Please see [Working with Icons](icons.html) for details on how to define and use icons.

```JAVA
public class SimpleIcons {

  public static final Icon FILE = IconLoader.getIcon("/icons/jar-gray.png", SimpleIcons.class);

}
```

## Define a File Type

The [SimpleFileType](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleFileType.java) is defined by subclassing [LanguageFileType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/fileTypes/LanguageFileType.java):

```JAVA
public final class SimpleFileType extends LanguageFileType {

  public static final SimpleFileType INSTANCE = new SimpleFileType();

  private SimpleFileType() {
    super(SimpleLanguage.INSTANCE);
  }

  @NotNull
  @Override
  public String getName() {
    return "Simple File";
  }

  @NotNull
  @Override
  public String getDescription() {
    return "Simple language file";
  }

  @NotNull
  @Override
  public String getDefaultExtension() {
    return "simple";
  }

  @Override
  public Icon getIcon() {
    return SimpleIcons.FILE;
  }

}
```

## Register the File Type

The Simple Language file type is registered via the [com.intellij.fileType](https://jb.gg/ipe?extensions=com.intellij.fileType) extension point
in `[plugin.xml](plugin-configuration-file.html)` and registered with `*.simple` extension:

```XML
<extensions defaultExtensionNs="com.intellij">
  <fileType
      name="Simple File"
      implementationClass="org.intellij.sdk.language.SimpleFileType"
      fieldName="INSTANCE"
      language="Simple"
      extensions="simple"/>
</extensions>
```

## Run the Project

[Run](creating-plugin-project.html#running-the-plugin) the plugin.

Create an empty file with the extension `.simple`, and IntelliJ IDEA automatically associates it with our language.
Note the appearance of the Simple Language file icon next to the `test.simple` file in the Project Tool Window, and the editor tab for the file.

![File Type Factory](images/file_type_factory.png)

