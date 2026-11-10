# Project

<tldr>
Product Help: [Configure projects](https://www.jetbrains.com/help/idea/working-with-projects.html)
</tldr>

Tip:

Everything in the IntelliJ Platform SDK is done within the context of a project.

The IntelliJ Platform stores the project configuration data in XML files.
The list of those files depends on the chosen [project format](https://www.jetbrains.com/help/idea/creating-and-managing-projects.html#project-formats):

Directory-Based:

Project and workspace settings are stored in a number of XML files under the `$project_home_directory$/.idea` directory.
Each XML file is responsible for its own set of settings and can be recognized by its name: `projectCodeStyle.xml`, `encodings.xml`, `vcs.xml` etc.
As for the file-based format projects, `.iml` files describe modules.

File-Based (Legacy):

For file-based format projects (legacy), the information core to the project itself (e.g., location of the component modules, compiler settings, etc.) is stored in the `$project_name$.ipr` file.
The information about modules the project includes is stored in `$module_name$.iml` files.
Module files are created for each module.

Note that direct access to project files isn't required to load or save settings.
See [Persisting State of Components](persisting-state-of-components.html) for more information.

## Working with Projects

Note: Workspace Model API (2024.2+)

The [Workspace Model](workspace-model.html) API is available since 2024.2 for use by third-party plugins and should be preferred over using the [Project Model](project-model.html) API.

See [Interoperability with Project Model API](workspace-model.html#interoperability) and [Usage Examples](workspace-model-usages.html).

To work with projects and project files, use the following classes and interfaces:

* [Project](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/project/Project.java)

* [ProjectRootManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/roots/ProjectRootManager.java)

* [ProjectManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/project/ProjectManager.java)

* [ProjectFileIndex](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/roots/ProjectFileIndex.java)

Other classes for working with the project model are located in the [projectModel-api.openapi](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi) package.
Basic API classes and interfaces for the concepts of [Project](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/project/Project.java), [Module](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/module/Module.java) and [Application](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/application/Application.java)  are placed in the [core-api.openapi](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi) package.

### 

How to get a `Project` instance?

A Project instance is available in multiple contexts:

| Context |API |
----------------
| [Action](action-system.html) |[AnActionEvent.getProject()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/AnActionEvent.java)  [DataContext.getData(CommonDataKeys.PROJECT)](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-ui/src/openapi/actionSystem/DataContext.java)   |
| [Editor](editor-basics.html) |[Editor.getProject()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/editor-ui-api/src/com/intellij/openapi/editor/Editor.java) |
| [Module](module.html) |[Module.getProject()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/module/Module.java) |
| [PSI](psi.html) |[PsiElement.getProject()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/psi/PsiElement.java) |
| [Tests](testing-plugins.html) |[IdeaProjectTestFixture.getProject()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/testFramework/src/com/intellij/testFramework/fixtures/IdeaProjectTestFixture.java) |

It is also possible to retrieve projects in generic contexts:

* Project from [VirtualFile](virtual-file.html): * [ProjectLocator.guessProjectForFile(VirtualFile)](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/project/ProjectLocator.kt) - returns any project containing a given file. * [ProjectLocator.getProjectsForFile(VirtualFile)](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/project/ProjectLocator.kt) - returns the list of projects that a given file is a part of.

* List of currently opened projects: [ProjectManager.getOpenProjects()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/project/ProjectManager.java)

### Getting a List of Source Roots for All Modules in a Project

Use the `ProjectRootManager.getContentSourceRoots()` method.
To clarify this, consider the following code snippet:

```JAVA
String projectName = project.getName();
VirtualFile[] vFiles = ProjectRootManager.getInstance(project)
    .getContentSourceRoots();
String sourceRootsList = Arrays.stream(vFiles)
    .map(VirtualFile::getUrl)
    .collect(Collectors.joining("\n"));
Messages.showInfoMessage("Source roots for the " + projectName +
    " plugin:\n" + sourceRootsList, "Project Properties");
```

### Checking If a File Belongs to a Project

Use [ProjectFileIndex](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/roots/ProjectFileIndex.java) to get this information:

```JAVA
ProjectFileIndex projectFileIndex =
    ProjectRootManager.getInstance(project).getFileIndex();
```

### Getting the Content or Source Root to Which a File or Directory Belongs

Use the `ProjectFileIndex.getContentRootForFile()` and `ProjectFileIndex.getSourceRootForFile()` methods.
For example:

```JAVA
VirtualFile moduleContentRoot = ProjectRootManager.getInstance(project)
    .getFileIndex().getContentRootForFile(virtualFileOrDirectory);
VirtualFile moduleSourceRoot = ProjectRootManager.getInstance(project)
    .getFileIndex().getSourceRootForFile(virtualFileOrDirectory);
```

Note that this method returns `null` if the file or directory does not belong to any source root of modules in the project.

### Checking Whether a File or Directory Is Related to the Project Libraries

[ProjectFileIndex](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/roots/ProjectFileIndex.java) provides a number of methods to check whether the specified file belongs to the project library classes or library sources:

* `isLibraryClassFile()`: Returns `true` if the specified `virtualFile` is a compiled class file.

* `isInLibraryClasses()`: Returns `true` if the specified `virtualFileOrDirectory` belongs to library classes.

* `isInLibrarySource()`: Returns `true` if the specified `virtualFileOrDirectory` belongs to library sources.

### Getting the Project SDK

Note that by default, the project modules use the project SDK.
Optionally, you can configure an individual SDK for each module.
See [SDK](sdk.html) for more details.

## Changing the Project Structure

Utility classes used for modifying the project structure can be found in the package [projectModel-impl.openapi](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-impl/src/com/intellij/openapi).
Its [roots](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-impl/src/com/intellij/openapi/roots) subpackage contains instances and utilities intended for work with project and module source roots, including [ModuleRootModificationUtil](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/roots/ModuleRootModificationUtil.java) and [ProjectRootUtil](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-impl/src/com/intellij/openapi/projectRoots/impl/ProjectRootUtil.java).
Project structure changes need to be performed in [write action](threading-model.html#write-actions).

Refer to the [project_model](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/project_model/src/main/java/org/intellij/sdk/project/model/ModificationAction.java) code sample to learn how project structure modification can be implemented.

## Receiving Notifications About Project Structure Changes

To receive notifications about changes in project structure (modules or libraries being added or removed, module dependencies being changed, and so on), use the [message bus](messaging-infrastructure.html) and the `ProjectTopics.PROJECT_ROOTS` topic:

```JAVA
project.getMessageBus().connect().subscribe(
    ProjectTopics.PROJECT_ROOTS,
    new ModuleRootListener() {
      @Override
      public void rootsChanged(@NotNull ModuleRootEvent event) {
        // action
      }
    });
```

[Declarative registration](plugin-listeners.html) is available as well.

The event only notifies that something has changed; if more details are needed about what changes have occurred, keep a copy of the state of the project structure model which is relevant, and to compare it with the state after the change.

## Receiving Notification About Project Close/Open Events

Use [ProjectManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/project/ProjectManagerListener.java) [listener](plugin-listeners.html) or [project open activity](plugin-components.html#project-open).

