# Registering a File Type

<tldr>
Product Help: [File type associations](https://www.jetbrains.com/help/idea/creating-and-registering-file-types.html)
</tldr>

The first step in developing a custom language plugin is registering a file type associated with the language.

The IDE typically determines the type of a file by looking at its filename or extension.

A custom language file type is a class derived from [LanguageFileType](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/fileTypes/LanguageFileType.java), which passes a [Language](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/lang/Language.java) subclass to its base class constructor.

## Registration

Use [com.intellij.fileType](https://jb.gg/ipe?extensions=com.intellij.fileType) extension point
to register `LanguageFileType` implementation and instance via `implementationClass` and `fieldName` attributes.
Also, `name` and `language` must be declared matching `FileType.getName()` and ID of language returned from `LanguageFileType.getLanguage()`, respectively.

To associate the file type in the IDE, specify one or more associations listed in the following table.

| Association type |Attribute |Attribute value |
------------------------------------------------
| Filename extension(s) |`extensions` |Semicolon-separated list of extensions, without `.` prefix |
| Hard coded file name(s) |`fileNames`/ `fileNamesCaseInsensitive`   |Semicolon-separated list of exact (case-insensitive) file names |
| Filename pattern(s) |`patterns` |Semicolon-separated list of patterns (`*` and `?`) |
| Hashbang |`hashBangs` |Semicolon-separated list of hash bang patterns |

Examples

* [Custom Language Support Tutorial: Language and File Type](language-and-filetype.html)

* [LanguageFileType](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/fileTypes/LanguageFileType.java) subclass in [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/properties/properties-psi-api/src/com/intellij/lang/properties/PropertiesFileType.java)

To verify that the file type is registered correctly, you can implement the [LanguageFileType.getIcon()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/fileTypes/LanguageFileType.java) method and verify that the correct icon (see [Working with Icons](icons.html)) is displayed for files associated with your file type.

## Additional Features

If you want IDEs to show a hint prompting users that your plugin supports a specific file type, see [Plugin Recommendations](https://plugins.jetbrains.com/docs/marketplace/intellij-plugin-recommendations.html).

To control file type association with the IDE in the operating system, implement [OSFileIdeAssociation](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/fileTypes/OSFileIdeAssociation.java).

