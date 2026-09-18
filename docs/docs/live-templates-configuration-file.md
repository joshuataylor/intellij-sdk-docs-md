# Live Templates Configuration File

This page lists and describes all the elements and attributes used in live templates configuration files.

## Configuration Structure Overview

Note:

Elements described on this page are available in [quick
documentation](https://www.jetbrains.com/help/idea/viewing-reference-information.html#inline-quick-documentation) since IntelliJ IDEA 2025.1.

The [Plugin DevKit](https://plugins.jetbrains.com/plugin/22851-plugin-devkit) plugin must be
installed and enabled.

* [&lt;templateSet&gt;](#templateSet) * [&lt;template&gt;](#templateSet__template) * [&lt;variable&gt;](#templateSet__template__variable) * [&lt;context&gt;](#templateSet__template__context) * [&lt;option&gt;](#templateSet__template__context__option)

## 

`templateSet`

<tldr>
Reference: [Live Templates](live-templates.html)
, [Live Templates (IntelliJ IDEA Web Help)](https://www.jetbrains.com/help/idea/settings-live-templates.html)
</tldr>

The live templates file root element.

Required
: yes

Attributes
: * `group` (optional) Name of the template set group, which is displayed in `Settings | Editor | Live Templates` list. If the group name is not provided, then templates' XML file name is used by default.

* `replace` (optional) Name of a template group that this template set replaces. Templates from the replaced group are removed and are skipped in settings and completion.

Children
: * [&lt;template&gt;](#templateSet__template)

### 

`template`

Describes a template.

Required
: no

Attributes
: * `id` (optional) Optional template identifier.

* `name` (required) The template abbreviation typed by users in the editor to expand it. The abbreviation must be unique in the group containing the template.

* `value` (required) The text that the template is expanded to. It may contain plain text and reference [variables](#templateSet__template__variable) in the format `$VARIABLE_NAME$`. To escape a dollar sign `$` in the template text, use `$$`.

* `resource-bundle` (optional) Message bundle containing the template description specified by `key`.

* `key` (optional) The key of the template description provided in a message bundle defined by `resource-bundle`. Description is used in the UI. Overrides the value of `description`.

* `description` (optional) The template description used in the UI. It is ignored if the description is provided with `resource-bundle` and `key`.

* `shortcut` (optional) Defines a character that expands the template. Allowed values: * `SPACE` - space key * `TAB` - tab key * `ENTER` - enter key * `CUSTOM` - key defined in the By default expand with field in `Settings | Editor | Live Templates` * `NONE` - disables expanding with a key

* `toReformat` (optional) Defines whether the inserted code should be reformatted according to the language code style. Default value: `false`.

* `toShortenFQNames` (optional) Defines whether qualified names in the expanded code should be shortened, for example, fully qualified names of Java classes are imported. Shortening qualified names is performed in implementations of [TemplateOptionalProcessor](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-impl/src/com/intellij/codeInsight/template/impl/TemplateOptionalProcessor.java). Default value: `false`.

* `useStaticImport` (optional) Defines whether symbols used in the expanded code should be statically imported, if possible. Importing symbols statically is performed in implementations of [TemplateOptionalProcessor](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-impl/src/com/intellij/codeInsight/template/impl/TemplateOptionalProcessor.java). Default value: `false`.

* `deactivated` (optional) Allows deactivating the template. Deactivated templates are listed in the UI and can be activated by users. Default value: `false`.

Children
: * [&lt;context&gt;](#templateSet__template__context)

* [&lt;variable&gt;](#templateSet__template__variable)

#### 

`variable`

<tldr>
Reference: [Template Variables](https://www.jetbrains.com/help/idea/edit-template-variables-dialog.html)
</tldr>

Defines a variable to be used in the template `value`.
A single template can provide multiple variables.

The order of the variables determines the order in which the IDE will switch between
the corresponding input fields when the template is expanded.

Required
: no

Attributes
: * `name` (optional) The variable name that is referenced in the [&lt;template&gt;](#templateSet__template) element's `value` attribute.

* `expression` (optional) Expression to calculate the value of the corresponding template input field automatically. The expression may contain the following constructs: * string constants in escaped double quotes, for example, `&quot;value&quot;` * names of other variables defined in the template, for example, `ANOTHER_VAR` * functions ([built-in](https://www.jetbrains.com/help/idea/template-variables.html#predefined_functions) or [custom](creating-live-template-functions.html)) with possible arguments

* `defaultValue` (optional) The default value for the corresponding input field of the expanded template if the expression does not give any result after calculation. It can refer to other live template variables, for example, `ANOTHER_VAR`. To define the default value as a literal, enclose it in escaped quotation marks, for example, `&quot;value&quot;`.

* `alwaysStopAt` (optional) If `true`, the IDE will always stop at the corresponding input of the expanded template. If `false`, the IDE will skip the corresponding input of the expanded template if the input value is defined. Default value: `false`.

Examples
: * Empty variable allowing to provide a value manually by a user: ```XML <variable name="MY_VAR" expression="" defaultValue="" alwaysStopAt="true"/> ```

* Variable inserting the content of the clipboard, and referencing the `PLACEHOLDER` variable if the clipboard content is empty: ```XML <variable name="PLACEHOLDER" expression="" defaultValue="" alwaysStopAt="true"/> <variable name="MY_VAR" expression="clipboard()" defaultValue="PLACEHOLDER" alwaysStopAt="true"/> ```

* Variable invoking completion and providing the `myValue` value if the completion doesn't provide any result: ```XML <variable name="MY_VAR" expression="complete()" defaultValue="&quot;myValue&quot;" alwaysStopAt="true"/> ```

#### 

`context`

Defines a mapping of a context type (for example, a Java method, a Markdown file) to applicability of the template
in this context type.

Required
: no

Children
: * [&lt;option&gt;](#templateSet__template__context__option)

Example
: ```XML
<context>
<option name="JAVA_CODE" value="true"/>
<option name="JAVA_COMMENT" value="false"/>
<option name="JAVA_STRING" value="false"/>
</context>
```



##### 
`option`







An entry specifying whether a given context type defined by the
`name` attribute is applicable for the template.



Required
: no


Attributes
: * `name` (required) The context type name. To implement a custom context type, see the [context type implementation](providing-live-templates.html#implement-templatecontexttype) tutorial.

  * `value` (required) A boolean value determining whether the context type defined with the [&lt;option&gt;](#templateSet__template__context__option) element's `name` attribute is applicable for the template. As context types are hierarchical, the `false` value can be used when the parent context type is applicable, and it is required to disable the applicability of more specific child context types.




        Note: Something missing?

            If a topic is not covered in the above sections,
                let us know via the Feedback widget displayed on the right,
                or [other channels](getting-help.html#problems-with-the-guide).
            


            Be specific about the topics and reasons for adding them and leave your email in case we need
                more details. Thanks for your feedback!


        


    












