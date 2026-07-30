# Facet

<tldr>
Product Help: [Facets](https://www.jetbrains.com/help/idea/facet-page.html), [Adding frameworks (facet)](https://www.jetbrains.com/help/idea/adding-support-for-frameworks-and-technologies.html)
</tldr>

A facet represents configuration specific for a particular framework/technology, associated with a module.
A module can have multiple facets.
For example, Spring Framework-specific configuration is stored in a dedicated [Spring facet](https://www.jetbrains.com/help/idea/spring-projects.html).

## Working with Facets

Note: Workspace Model API (2024.2+)

The [Workspace Model](workspace-model.html) API is available since 2024.2 for use by third-party plugins and should be preferred over using the [Project Model](project-model.html) API.

See [Interoperability with Project Model API](workspace-model.html#interoperability) and [Usage Examples](workspace-model-usages.html).

### Managing Facets

To create, search, and access the list of facets for a module, use [FacetManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-core/src/com/intellij/facet/FacetManager.java).

### Facet-Based Tool Window

A [tool window](tool-windows.html) dependent on the existence of given facet(s) can be registered
via [com.intellij.facet.toolWindow](https://jb.gg/ipe?extensions=com.intellij.facet.toolWindow) extension point
.

## Facet Basics Sample

See [Facet Basics](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/facet_basics) sample plugin project.

