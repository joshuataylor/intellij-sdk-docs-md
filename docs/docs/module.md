# Module

<tldr>
Product Help: [Modules](https://www.jetbrains.com/help/idea/modules.html)
</tldr>

A module is a discrete unit of functionality that can be run, tested, and debugged independently.
Modules include such things as source code, build scripts, unit tests, deployment descriptors, etc.

## Module Components

### Content Roots

A content root ([ContentEntry](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ContentEntry.java)) is a directory whose files belong to the module (source code, resources, etc.).
A content root defines the filesystem boundary for the module — only files under a content root are considered part of the module.
Each directory can belong to one and only one module; it is not possible to share a content root between multiple modules.
A module may have multiple content roots.

Within each content root, specific subdirectories can be designated as [source roots](#source-roots) or [exclude roots](#exclude-roots).
Both are represented as subinterfaces of [ContentFolder](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ContentFolder.java).

### Source Roots

A source root ([SourceFolder](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/SourceFolder.java)) marks a directory within a content root that contains source or resource files.
A content root can have multiple source roots underneath it.
Source roots can have different types: regular source roots, test source roots, resource roots, test resource roots, etc.
There is a single `SourceFolder` interface for all root types — they are distinguished by their [JpsModuleSourceRootType](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/jps/model-api/src/org/jetbrains/jps/model/module/JpsModuleSourceRootType.java), not by separate classes.

In IntelliJ IDEA, source roots are used as roots of the package hierarchy structure.
Java classes directly under a source root will be in the root package.
Source roots can also be used to implement more fine-grained dependency checks.
Code under a regular source root cannot depend on code under a test source root.

Tip:

Not all other IntelliJ Platform-based IDEs use source roots.

### Exclude Roots

An exclude root ([ExcludeFolder](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ExcludeFolder.java)) marks a directory within a content root whose contents are excluded from indexing, code completion, search, navigation, and compilation.
Typical uses include build output directories, generated files, or large data directories that should not be processed by the IDE.

### Order Entries

The dependencies of a module, which are stored in an ordered list.
A dependency can be a reference to an [SDK](sdk.html), a [library](library.html), or another module.

### Facets

The list of framework-specific configuration entries represented in a dedicated [Facet](facet.html).

### Other

In addition to that, a module can store other settings, such as a module-specific [SDK](sdk.html), compile output path settings, etc.
Plugins can store additional data associated with a module by creating facets or module-level components.

## Working with Modules

Note: Workspace Model API (2024.2+)

The [Workspace Model](workspace-model.html) API is available since 2024.2 for use by third-party plugins and should be preferred over using the [Project Model](project-model.html) API.

See [Interoperability with Project Model API](workspace-model.html#interoperability) and [Usage Examples](workspace-model-usages.html).

The IntelliJ Platform provides a number of classes and interfaces you can use to work with modules:

* [Module](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/module/Module.java)

* [ModuleUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-api/src/com/intellij/openapi/module/ModuleUtil.java) and [ModuleUtilCore](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/module/ModuleUtilCore.java)

* [ModuleManager](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/module/ModuleManager.kt)

* [ModuleRootManager](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ModuleRootManager.java)

* [ModuleRootModel](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ModuleRootModel.java)

* [ModifiableModuleModel](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/module/ModifiableModuleModel.java)

* [ModifiableRootModel](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ModifiableRootModel.java)

* [ContentEntry](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ContentEntry.java)

* [ContentFolder](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ContentFolder.java)

* [SourceFolder](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/SourceFolder.java)

* [ExcludeFolder](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ExcludeFolder.java)

This section discusses how to complete some common tasks related to management of modules.

See [Changing the Project Structure](project.html#changing-the-project-structure) for information on modifying project/module structure.

### How do I get a list of modules the project includes?

Use the `ModuleManager.getModules()` method.

### How do I get dependencies and classpath of a module?

Order entries include SDK, libraries and other modules the module uses.
With the IntelliJ IDEA UI, you can view order entries for a module on the Dependencies tab of the Project Structure dialog box.

To explore the module dependencies, use the [OrderEnumerator](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/OrderEnumerator.java) class.

The following code snippet illustrates how you can get classpath (classes root of all dependencies) for a module:

```JAVA
VirtualFile[] roots = ModuleRootManager.getInstance(module).orderEntries().classes().getRoots();
```

### How do I get the SDK the module uses?

Use the `ModuleRootManager.getSdk()` method.
This method returns a value of the [Sdk](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/projectRoots/Sdk.java) type.

The following code snippet illustrates how you can get detailed information on SDK the specified module uses:

```JAVA
ModuleRootManager moduleRootManager = ModuleRootManager.getInstance(module);
Sdk sdk = moduleRootManager.getSdk();
String jdkInfo = "Module: " + module.getName() +
    " SDK: " + sdk.getName() +
    " SDK version: " + sdk.getVersionString() +
    " SDK home directory: " + sdk.getHomePath();
```

### How do I get a list of modules on which this module directly depends?

Use the `ModuleRootManager.getDependencies()` method to get an array of the `Module` type values or the `ModuleRootManager.getDependencyModuleNames()` to get an array of module names.
To clarify, consider the following code snippet:

```JAVA
ModuleRootManager moduleRootManager = ModuleRootManager.getInstance(module);
Module[] dependentModules = moduleRootManager.getDependencies();
String[] dependentModulesNames = moduleRootManager.getDependencyModuleNames();
```

### How do I get a list of modules that depend on this module?

Use the `ModuleManager.getModuleDependentModules(module)` method.

Note that you can also check whether a module (module1) depends on another specified module (module2) using the `ModuleManager.isModuleDependent()` method in the following way:

```JAVA
boolean isDependent = ModuleManager.getInstance(project).isModuleDependent(module1, module2);
```

### How do I get a module to which the specified file or PSI element belongs?

* To get the project module to which the specified file belongs, use the `ModuleUtil.findModuleForFile()` static method. To clarify, consider the following code snippet:

```JAVA
String pathToFile = "/Users/john/plugins/myPlugin/src/MyAction.java";
VirtualFile virtualFile = LocalFileSystem.getInstance().findFileByPath(pathToFile);
Module module = ModuleUtil.findModuleForFile(virtualFile, myProject);
String moduleName = module == null ? "Module not found" : module.getName();
```

* To get the project module to which the specified [PSI element](psi-elements.html) belongs, use the `ModuleUtil.findModuleForPsiElement()` method.

### Storing a Reference to a Module

Use [ModulePointer](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/module/ModulePointer.java) to store a reference to a `Module` by its instance or name.
A removal or rename of the `Module` will be tracked automatically.

### Accessing Module Roots

Information about module roots can be accessed via [ModuleRootManager](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/ModuleRootManager.java).
For example, the following snippet shows how to access the content roots of a module:

```JAVA
VirtualFile[] contentRoots = ModuleRootManager.getInstance(module).getContentRoots();
```

### Checking Belonging to a Module Source Root

To check if a virtual file or directory belongs to a module source root, use the `ProjectFileIndex.getSourceRootForFile()` method.
This method returns `null` if the file or directory does not belong to any source root of modules in the project.

```JAVA
VirtualFile moduleSourceRoot = ProjectRootManager.getInstance(project).getFileIndex().getSourceRootForFile(virtualFileOrDirectory);
```

### Java: Compiler Output Properties

Obtain [CompilerModuleExtension](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/projectModel-api/src/com/intellij/openapi/roots/CompilerModuleExtension.java) for given `Module` instance to access Compiler Output path related properties.

## Receiving Notifications About Module Changes

To receive notifications about module changes (modules being added, removed or renamed), use the [message bus](messaging-infrastructure.html) and the `ProjectTopics.MODULES` topic:

```JAVA
project.getMessageBus().connect().subscribe(
    ProjectTopics.MODULES,
    new ModuleListener() {
      @Override
      public void moduleAdded(@NotNull Project project, @NotNull Module module) {
        // action
      }
    });
```

[Declarative registration](plugin-listeners.html) is available as well.

