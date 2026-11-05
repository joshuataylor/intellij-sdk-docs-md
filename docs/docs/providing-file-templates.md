# Providing File and Code Templates

The IntelliJ Platform allows plugins to provide custom file templates specific to the plugin's functionalities.
In order to include custom templates in the plugin, a template file has to be created and placed in the specific place of plugin resources, depending on the template's purpose.

## Creating File Templates

There are multiple ways of creating file templates:

* [Use &quot;File | Save File as Template…&quot; action](https://www.jetbrains.com/help/idea/using-file-and-code-templates.html#save-file-as-template)

* [Create a new file template](https://www.jetbrains.com/help/idea/using-file-and-code-templates.html#create-new-template)

* [Copy an existing file template](https://www.jetbrains.com/help/idea/using-file-and-code-templates.html#copy-existing-template)

Once the file templates are created and saved, they should be copied to the plugin project's `resources` directory.
The created template can be found in the [IDE configuration directory](https://www.jetbrains.com/help/idea/directories-used-by-the-ide-to-store-settings-caches-plugins-and-logs.html#config-directory) in the `fileTemplates` directory, or they can be exported via `File | Manage IDE Settings | Export Settings` by selecting the File Templates (schemes) checkbox.
The exported ZIP file will contain the `fileTemplates` directory with the created templates.
The `fileTemplates` directory should be moved to the plugin project's `resources` folder, and the `.ft` extension must be added to the template files, e.g., `My Class.java` must be renamed to `My Class.java.ft`.

The template name and extension displayed in the IDE settings will automatically be extracted from the file name.
The Enable Live Templates option will be enabled if the template's content includes a `#[[$` fragment.
Note that [live templates](live-templates.html) expressions should be surrounded with `#[[` and `]]#` tokens to avoid being parsed by the Apache Velocity template engine.

Note:

Please note that adding templates with child/multiple files in custom plugins is currently not supported.

### File Templates Categories

File templates can be assigned to one of the predefined categories depending on their purpose and type.

#### Files

The Files category contains templates used for creating new files.
This is the main category, and it includes all templates placed directly in the `fileTemplates` directory.
It should contain only templates for given language core entities, e.g., a class, an interface, or other items that users very frequently create.
If the language defines a lot of core entities, see [Custom "Create File From Template" Actions](using-file-templates.html#custom-create-file-from-template-actions) for a more user-friendly solution.

#### Includes

The Includes category contains reusable fragments used for including in other file templates using the Apache Velocity `#parse()` directive, e.g., license header or documentation comment skeleton.
It includes templates located in the `fileTemplates/includes` directory.

#### Code

The Code category contains templates used for inserting in existing files, e.g., a code fragment used in an [intention action](code-intentions.html) or [quick fix](code-inspections.html#quick-fix-implementation).
It includes templates located in the `fileTemplates/code` directory.

#### Internal

The Internal category contains templates that are not visible in the IDE settings by default and cannot be edited by users.
It includes templates located in the `fileTemplates/internal` directory.

#### Other

The Other category contains other templates organized in groups.
It includes templates located in the `fileTemplates/j2ee` directory and registered via the [com.intellij.fileTemplateGroup](https://jb.gg/ipe?extensions=com.intellij.fileTemplateGroup) extension point
.
Note that the `j2ee` directory name is historical and unrelated to the J2EE technology.
This category is intended for templates that are not used for creating core language entities or are used less frequently by users, e.g., a specific XML configuration file, a framework-specific class in Java language, etc.
To include file templates in the Other section of the `Settings | Editor | File and Code Templates` settings page, provide an implementation of the
[FileTemplateGroupDescriptorFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-api/src/com/intellij/ide/fileTemplates/FileTemplateGroupDescriptorFactory.java)
and register it via the [com.intellij.fileTemplateGroup](https://jb.gg/ipe?extensions=com.intellij.fileTemplateGroup) extension point
.

Example:
[MavenFileTemplateGroupFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/maven/src/main/java/org/jetbrains/idea/maven/utils/MavenFileTemplateGroupFactory.java)

Note that
[FileTemplateGroupDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-api/src/com/intellij/ide/fileTemplates/FileTemplateGroupDescriptor.java)
is a subclass of
[FileTemplateDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/ide/fileTemplates/FileTemplateDescriptor.java),
which allows creating nested groups.

## Creating File Template Description

By default, the description contains generic text about the syntax and properties of the given template.
It is highly recommended to provide a custom description explaining its purpose and any available properties.
Overriding the default description is achieved by creating an HTML file with the name matching template's name but with the `.html` extension.
Example:

* Template file name: `My Class.java.ft`

* Description file name: `My Class.java.html`

The description file must be located in the same directory as the template file.
It is recommended to follow the convention from the
[default.html](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-resources-en-file-templates/src/fileTemplates/default.html)
file.

Warning:

If a plugin project is multi-module, and it combines resources into a single JAR, make sure that all template description files have unique names or paths.
Otherwise, only the last packed description file will exist in the distribution package.

Tip:

See the [Bundled Translations](providing-translations.html#bundled-translations) section for information about how to provide file template description translations in plugins.

## Providing Default File Template Properties

A file template body can use a set of [predefined properties](https://www.jetbrains.com/help/idea/file-template-variables.html#predefined_template_variables) exposed by the IntelliJ Platform out of the box.
Some languages or frameworks may require additional properties exposed to existing templates.
To provide custom properties, implement
[DefaultTemplatePropertiesProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-api/src/com/intellij/ide/fileTemplates/DefaultTemplatePropertiesProvider.java)
and register it via the [com.intellij.defaultTemplatePropertiesProvider](https://jb.gg/ipe?extensions=com.intellij.defaultTemplatePropertiesProvider) extension point
.

Example: Java Plugin's
[TemplatePackagePropertyProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/java/java-impl/src/com/intellij/ide/fileTemplates/TemplatePackagePropertyProvider.java)
providing `PACKAGE_NAME` property based on the directory a file is created in.

