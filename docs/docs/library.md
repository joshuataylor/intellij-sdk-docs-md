# Library

<tldr>
Product Help: [Libraries](https://www.jetbrains.com/help/idea/library.html)
</tldr>

A library is an archive of compiled code (such as JAR files) that modules depend on.

A particular type of programmatically defined libraries is [Predefined Libraries](#predefined-libraries).

## Library Types

The IntelliJ Platform supports three types of libraries:

### Module Library

The library classes are visible only in this module, and the library information is recorded in the module `.iml` file.

### Project Library

The library classes are visible within the project, and the library information is recorded under the `.idea/libraries` directory or in the project `.ipr` file.

### Global Library

The library information is recorded in the `applicationLibraries.xml` file in `$USER_HOME$/.IntelliJIdea/config/options` directory. Global libraries are similar to project libraries but are visible for different projects.

## Working with Libraries

Note: Workspace Model API (2024.2+)

The [Workspace Model](workspace-model.html) API is available since 2024.2 for use by third-party plugins and should be preferred over using the [Project Model](project-model.html) API.

See [Interoperability with Project Model API](workspace-model.html#interoperability) and [Usage Examples](workspace-model-usages.html).

Package [com.intellij.openapi.roots.libraries](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/libraries) provides functionality for working with project libraries and JAR files.

### Getting Module Dependency Libraries

To get the list of libraries that a module depends on, use `OrderEnumerator.forEachLibrary` as follows.

Kotlin:

```KOTLIN
val libraryNames = mutableListOf<String>()
ModuleRootManager.getInstance(module).orderEntries()
  .forEachLibrary {
    libraryNames.addIfNotNull(it.name)
    true
  }
Messages.showInfoMessage(
  libraryNames.joinToString("\n"),
  "Libraries in Module"
)
```

Java:

```JAVA
List<String> libraryNames = new ArrayList<>();
ModuleRootManager.getInstance(module).orderEntries()
  .forEachLibrary(library -> {
    String libraryName = library.getName();
    if (libraryName != null) {
      libraryNames.add(libraryName);
    }
    return true;
  });
Messages.showInfoMessage(
  StringUtil.join(libraryNames, "\n"),
  "Libraries in Module"
);
```

This sample code outputs a list of libraries that the given module depends on.

### Getting a List of All Libraries

To manage the lists of application and project libraries, use [LibraryTable](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/libraries/LibraryTable.java).
The list of application-level library tables is accessed by calling [LibraryTablesRegistrar.getLibraryTable()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/libraries/LibraryTablesRegistrar.java), whereas the list of project-level library tables is accessed via `LibraryTablesRegistrar.getLibraryTable(Project)`.
Get the list of libraries in it via `LibraryTable.getLibraries()`.

To get the list of all module libraries defined in a given module, use API from [OrderEntryUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-impl/src/com/intellij/openapi/roots/impl/OrderEntryUtil.java):

```KOTLIN
OrderEntryUtil.getModuleLibraries(ModuleRootManager.getInstance(module))
```

### Getting the Library Content

[Library](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/libraries/Library.java) provides the `getUrls()` method to get a list of source roots and classes the library includes.

Kotlin:

```KOTLIN
val roots = StringBuilder()
roots.appendLine("The ${lib.name} library includes:")
roots.appendLine("Sources:")
for (sourcesUrl in lib.getUrls(OrderRootType.SOURCES)) {
  roots.appendLine(sourcesUrl)
}
roots.appendLine("Classes:")
for (classesUrl in lib.getUrls(OrderRootType.CLASSES)) {
  roots.appendLine(classesUrl)
}
Messages.showInfoMessage(roots.toString(), "Library Info")
```

Java:

```JAVA
StringBuilder roots = new StringBuilder();
roots.append("The " + lib.getName() + " library includes:\n");
 roots.append("Sources:\n");
for (String sourcesUrl : lib.getUrls(OrderRootType.SOURCES)) {
  roots.append(sourcesUrl).append("\n");
}
roots.append("Classes:\n");
for (String classesUrl : lib.getUrls(OrderRootType.CLASSES)) {
  roots.append(classesUrl).append("\n");
}
Messages.showInfoMessage(roots.toString(), "Library Info");
```

### Creating a Library

For module-level libraries, use the simplified APIs from [ModuleRootModificationUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ModuleRootModificationUtil.java) to add a library with a single API call.
An example of using these APIs can be found in the [project_model](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/project_model/src/main/java/org/intellij/sdk/project/model/ModificationAction.java) code sample.

Procedure: Library Creation Steps

### Adding Contents or Modifying a Library

Procedure: Adding/Changing Library Roots

### Adding a Library Dependency to a Module

Use `ModuleRootModificationUtil.addDependency(Module, Library)` from under a [write action](threading-model.html#write-actions).

### Checking Belonging to a Library

The [ProjectFileIndex](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ProjectFileIndex.java) interface implements a number of methods that can be used to check whether the specified file belongs to the project library classes or library sources.

* To check if a specified virtual file is a compiled class file use ```KOTLIN ProjectFileIndex.isLibraryClassFile(virtualFile) ```

* To check if a specified virtual file or directory belongs to library classes use ```KOTLIN ProjectFileIndex.isInLibraryClasses(virtualFileorDirectory) ```

* To check if the specified virtual file or directory belongs to library sources use ```KOTLIN ProjectFileIndex.isInLibrarySource(virtualFileorDirectory) ```

See the [project_model](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/project_model/src/main/java/org/intellij/sdk/project/model/ProjectFileIndexSampleAction.java) sample plugin to see how the method mentioned above can be applied.

More details on libraries can be found in the [plugin_model](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/project_model/src/main/java/org/intellij/sdk/project/model/LibrariesAction.java) code sample.

## Predefined Libraries

[AdditionalLibraryRootsProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/AdditionalLibraryRootsProvider.java) registered in [com.intellij.additionalLibraryRootsProvider](https://jb.gg/ipe?extensions=com.intellij.additionalLibraryRootsProvider) extension point
allows
providing synthetic/predefined libraries ([SyntheticLibrary](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/SyntheticLibrary.java)) in a project without exposing them in the model.
By default, they're also hidden from the UI.

