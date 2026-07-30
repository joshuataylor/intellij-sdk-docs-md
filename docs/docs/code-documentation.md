# Documentation

<tldr>
Product Help: [Quick Documentation](https://www.jetbrains.com/help/idea/viewing-reference-information.html#inline-quick-documentation)
</tldr>

Quick Documentation helps users by showing documentation, e.g., for classes, functions, or methods inside the editor.
Plugin authors implement
[DocumentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/lang/documentation/DocumentationProvider.java)
to show documentation for particular [PSI elements](psi-elements.html).

Implementations of `DocumentationProvider` can be registered either at the [com.intellij.documentationProvider](https://jb.gg/ipe?extensions=com.intellij.documentationProvider) extension point
or
the [com.intellij.lang.documentationProvider](https://jb.gg/ipe?extensions=com.intellij.lang.documentationProvider) extension point
.
It is recommended to use the latter one when creating documentation that targets a specific language because providers registered
as `com.intellij.lang.documentationProvider` will only be called for elements from that language.
This is the reason they require the `language` attribute when registering the EP in the `[plugin.xml](plugin-configuration-file.html)`.
The bigger picture here is that documentation providers co-exist and if there is more than one provider for the same element,
the first one that returns a value different from `null` wins.

Although discouraged, the ordering of documentation providers can be influenced by using the `order` attribute when registering the extension.
For instance, PythonCore [plugin.xml](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/python/pluginCore/resources/META-INF/plugin.xml) uses the following to call the external documentation
provider before the default one (registered with `id="pythonDocumentationProvider"`):

```XML
<lang.documentationProvider
  language="Python"
  implementationClass="com.jetbrains.python.documentation.PythonExternalDocumentationProvider"
  order="before pythonDocumentationProvider"/>
```

For detailed instructions on how to implement a `DocumentationProvider`, please refer to the [Custom Language Support](documentation.html)
section and the descriptions in the [Custom Language Support Tutorial](documentation-provider.html).

