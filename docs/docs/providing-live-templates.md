# Providing Live Templates

This tutorial illustrates how to add default Custom Live Templates to an IntelliJ Platform plugin, and assign valid contexts for these templates based on the surrounding code and file type.
In addition, the tutorial discusses how to export existing Live Templates, and bundle them within a plugin.
Any Live Template that can be created and exported can be added to a plugin by following the Template Creation, Export, and Extension Point Registration processes.

This tutorial uses the SDK code sample [live_templates](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/live_templates).

## Template Creation

Get started by [creating a new Live Template](https://www.jetbrains.com/idea/help/creating-and-editing-live-templates.html) within the IntelliJ Platform-based IDE:

* Add a new Template Group, "Markdown" and create a new Live Template under this group.

* Assign the template the abbreviation "{".

* Assign the description "SDK: New link reference".

* Paste the following snippet into the Template text field:

```TEXT
[$TEXT$]($LINK$)$END$
```

The variables `$TEXT$` and `$LINK$` may be further configured in the Edit variables dialogue to reorder their precedence and bind to the functions that invoke auto-completion at the appropriate time.
In the Edit variables dialog, set the Expression for the `LINK` to `complete()` using the combo box.

There are many [predefined functions](https://www.jetbrains.com/help/idea/template-variables.html#predefined_functions) that developers should become familiar with before implementing any unique functionality in a plugin.

Tip:

Consider iteratively testing the Live Template using the current editor and a markdown file to minimize debugging later.

## Export the Live Template

Once the Live Template produces the expected result, [export the Live Template](https://www.jetbrains.com/help/idea/sharing-live-templates.html).
The export produces a file called `Markdown.xml` with the following contents:

Note:

See [Live Templates Configuration File](live-templates-configuration-file.html) for a detailed description of the templates XML file structure and elements.

```XML
<templateSet group="Markdown">
  <template
      name="{"
      value="[$TEXT$]($LINK$)$END$"
      description="SDK: New link reference"
      toReformat="false"
      toShortenFQNames="false">
    <variable
        name="TEXT"
        expression=""
        defaultValue=""
        alwaysStopAt="true"/>
    <variable
        name="LINK"
        expression="complete()"
        defaultValue=""
        alwaysStopAt="true"/>
  </template>
</templateSet>
```

Tip:

To [localize](providing-translations.html) the description, instead of the `description` attribute, use `key` and `resource-bundle` attributes pointing to a key
in a [message bundle](internationalization.html#message-bundles).
A quick fix to extract the localized key is available since 2024.2.

Copy this file into the [plugin's resources folder](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/live_templates/src/main/resources/liveTemplates).

## 

Implement `TemplateContextType`

A [TemplateContextType](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/codeInsight/template/TemplateContextType.java) tells the IntelliJ Platform where the Live Template is applicable: Markdown files.
Every context must have a unique `TemplateContextType` defined for it, and the Platform defines many context types out of the box.
The `MarkdownContext` class defines it for Markdown files.
Ultimately, a file's extension determines the applicable Markdown context.

```JAVA
final class MarkdownContext extends TemplateContextType {

  MarkdownContext() {
    super("Markdown");
  }

  @Override
  public boolean isInContext(@NotNull TemplateActionContext templateActionContext) {
    return templateActionContext.getFile().getName().endsWith(".md");
  }

}
```

Note:

Once the `MarkdownContext` is defined, be sure to add the new context type to the previously created Live Template settings file.

Within the `<template>...</template>` elements in the `Markdown.xml` [Live Template definition file](#export-the-live-template), add the following context elements:

```XML
<template>
  <variable ... />
  <context>
    <option name="MARKDOWN" value="true"/>
  </context>
</template>
```

It is not always necessary to define your own `TemplateContextType`, as there are many existing template contexts already defined in the IntelliJ Platform.
Consider reusing one of the many existing template context types that inherit from `TemplateContextType` if you are augmenting language support to an existing area.

## Completing the Live Template Implementation

Depending on the version of the IntelliJ Platform, different steps are used to complete the implementation of the feature.

2022.3+:

Using the [com.intellij.defaultLiveTemplates](https://jb.gg/ipe?extensions=com.intellij.defaultLiveTemplates) extension point
and [com.intellij.liveTemplateContext](https://jb.gg/ipe?extensions=com.intellij.liveTemplateContext) extension point
, register the implementations with the IntelliJ Platform.
The `file` attribute in [com.intellij.defaultLiveTemplates](https://jb.gg/ipe?extensions=com.intellij.defaultLiveTemplates) extension point
specifies `path/filename` under the `src/main/resources` folder.

Specify required `contextId` attribute in [com.intellij.liveTemplateContext](https://jb.gg/ipe?extensions=com.intellij.liveTemplateContext) extension point
instead of [TemplateContextType](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/codeInsight/template/TemplateContextType.java) constructor (existing declarations will continue working).

```XML
<extensions defaultExtensionNs="com.intellij">
  <defaultLiveTemplates file="/liveTemplates/Markdown.xml"/>
  <liveTemplateContext
          contextId="MARKDOWN"
          implementation="org.intellij.sdk.liveTemplates.MarkdownContext"/>
</extensions>
```

Earlier versions:

Using the [com.intellij.defaultLiveTemplates](https://jb.gg/ipe?extensions=com.intellij.defaultLiveTemplates) extension point
and [com.intellij.liveTemplateContext](https://jb.gg/ipe?extensions=com.intellij.liveTemplateContext) extension point
, register the implementations with the IntelliJ Platform.
The `file` attribute in the [com.intellij.defaultLiveTemplates](https://jb.gg/ipe?extensions=com.intellij.defaultLiveTemplates) extension point
specifies `path/filename` under the `src/main/resources` folder.

```XML
<extensions defaultExtensionNs="com.intellij">
  <defaultLiveTemplates file="/liveTemplates/Markdown.xml"/>
  <liveTemplateContext
      implementation="org.intellij.sdk.liveTemplates.MarkdownContext"/>
</extensions>
```

## Check Plugin

Now verify the plugin is working correctly.
Run the plugin in a Development Instance and verify there is a new entry under `Settings | Live Templates | Markdown | { (SDK: New link reference)`.

Finally, create a new file `test.md` and confirm that the Live Template works by entering a `{` character and then pressing `Tab`.

