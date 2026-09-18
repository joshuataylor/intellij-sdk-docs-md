# Postfix Templates

The IntelliJ Platform allows plugins to provide custom postfix templates specific to the supported languages, frameworks, or libraries.

To provide custom postfix templates for an existing or custom language, register an implementation of
[PostfixTemplateProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/PostfixTemplateProvider.java)
in the [com.intellij.codeInsight.template.postfixTemplateProvider](https://jb.gg/ipe?extensions=com.intellij.codeInsight.template.postfixTemplateProvider) extension point
.

The `PostfixTemplateProvider` extension contains the list of templates that extend the
[PostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/PostfixTemplate.java)
class.
During the code completion mechanism, all postfix template providers registered for the current language are queried for their templates.
All templates enabled and applicable in the current context will be added to the completion popup items set.

Examples:

* [JavaPostfixTemplateProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/JavaPostfixTemplateProvider.java) providing Java postfix templates

* [PyPostfixTemplateProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/python/src/com/jetbrains/python/codeInsight/postfix/PyPostfixTemplateProvider.java) providing Python postfix templates

## Postfix Templates Implementation

The simplest way to create a postfix template is by extending the
[PostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-impl/src/com/intellij/codeInsight/template/postfix/templates/PostfixTemplate.java)
class and implementing the key methods:

* `boolean isApplicable()` determining whether the template can be used in the context described by parameters

* `void expand()` inserting the template content in the editor

Examples:

* [InstanceofExpressionPostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/InstanceofExpressionPostfixTemplate.java) surrounding an expression with the instanceof check

* [TryWithResourcesPostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/TryWithResourcesPostfixTemplate.java) wrapping a selected expression in try-with-resources block

Note:

See the [Advanced Postfix Templates](advanced-postfix-templates.html) section for information on how to implement postfix templates with more advanced features and editing possibilities.

## Postfix Template Description

All postfix templates must provide descriptions and examples showing the code before and after a template is expanded.
The files describing the template must be placed in the plugin's `resources` in the `postfixTemplates/$TEMPLATE_NAME$` where the $TEMPLATE_NAME$ directory must match the simple name of the template class,
e.g., for a template implemented in `com.example.IntroduceVariablePostfixTemplate` class, the directory name should be named as `IntroduceVariablePostfixTemplate`.

Providing the description explaining the template purpose and context details is achieved by creating the `description.html` file.

Providing the code snippets showing the template in "before" and "after" expanding states is achieved via the `before.$EXTENSION$.template` and `after.$EXTENSION$.template` files accordingly.
The $EXTENSION$ placeholder should be replaced with the extension of the template language, e.g., `before.kt.template` for a Kotlin template.

Warning:

If a plugin project is multi-module, and it combines resources into a single JAR, make sure that all template description files have unique names or paths.
Otherwise, only the last packed description file will exist in the distribution package.

Tip:

See the [Bundled Translations](providing-translations.html#bundled-translations) section for information about how to provide postfix template description translations in plugins.

The code snippets included in the example files can use the `<spot>` marker, which should surround the most important code parts, e.g., expression to expand and position of the caret after expanding.
Marked parts will be highlighted in the `Settings | Editor | General | Postfix Completion` settings page, making it easier for users to understand how a template is expanded, e.g.:

* `before.java.template`: ```JAVA <spot>cart.getProducts()</spot>.var ```

* `after.java.template`: ```JAVA List<Product> products = cart.getProducts();<spot></spot> ```

Template example files can also use the `$key` placeholder which is replaced with the actual template key in the preview UI, e.g., consider a template with the `var` key:

Content:

```JAVA
cart.getProducts()$key
```

Rendition:

```JAVA
cart.getProducts().var
```

The gutter icons for a postfix template class allow navigating to the corresponding description and before/after files in plugin resources.

Example:
[TryWithResourcesPostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/java/java-impl/resources/postfixTemplates/TryWithResourcesPostfixTemplate)
directory containing description files for
[TryWithResourcesPostfixTemplate](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/java/java-impl/src/com/intellij/codeInsight/template/postfix/templates/TryWithResourcesPostfixTemplate.java)
template.

