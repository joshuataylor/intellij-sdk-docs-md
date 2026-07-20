# Legacy Project Wizard API

Tip:

Plugins targeting versions 2024.2 and newer should implement the [New Project Wizard API](new-project-wizard.html).

## Implementing a New Module Type

Additional support for specific tools and technologies is usually done via implementing some certain module type, which is attached to the project.
A new module type should be derived from the class [ModuleType](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-core/src/com/intellij/openapi/module/ModuleType.java).

## Custom Project Wizard

The main utilities to configure a custom project wizard can be found in the package [lang-api.ide.util.projectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-api/src/com/intellij/ide/util/projectWizard).
These classes and interfaces serve the following purposes:

* Modification of the configuration wizard view

* Adding new steps to the wizard

* Providing additional settings for project creation

* Handling activities during project creation

* Initial environment configuration

### Module Type

To create a new module type, implement [ModuleType](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-core/src/com/intellij/openapi/module/ModuleType.java) parameterized by [ModuleBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-core/src/com/intellij/ide/util/projectWizard/ModuleBuilder.java) and register it in the [com.intellij.moduleType](https://jb.gg/ipe?extensions=com.intellij.moduleType) extension point
in [plugin.xml](plugin-configuration-file.html) file.

### Implementing Module Builder

To set up a new module environment, [ModuleBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-core/src/com/intellij/ide/util/projectWizard/ModuleBuilder.java) should be extended and registered in the [com.intellij.moduleBuilder](https://jb.gg/ipe?extensions=com.intellij.moduleBuilder) extension point
.

Functionality which is mandatory to implement consists of:

* `void setupRootModel(ModifiableRootModel)` - sets up a root model for the new module

* `ModuleType getModuleType()` - returns a module type

See [JavaModuleBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/java/openapi/src/com/intellij/ide/util/projectWizard/JavaModuleBuilder.java) to understand better how to implement a module builder.

Tip:

If your module type is based on the Java module and meant to support Java as well, extending [JavaModuleBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/java/openapi/src/com/intellij/ide/util/projectWizard/JavaModuleBuilder.java) is enough.
No extension point needs to be registered.
Refer to the [GroovyAwareModuleBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/groovy/src/org/jetbrains/plugins/groovy/config/GroovyAwareModuleBuilder.java) to see how [JavaModuleBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/java/openapi/src/com/intellij/ide/util/projectWizard/JavaModuleBuilder.java) can be extended.

Note:

Starting with the 2022.1 release, IntelliJ-based IDEs use the refreshed project wizard, and some module builder base classes return `false` from `isAvailable()` when the new wizard is enabled.
If your module builder is not visible in 2022.1, make sure that your `ModuleBuilder.isAvailable()` returns `true`.

### Implementing Module Builder Listener

Module builder listener reacts on a new module creation, which could be done either as a part of the project creation process or as adding a new module to the already existing project.
To provide a certain behavior right after a module has been created, a module builder must implement [ModuleBuilderListener.moduleCreated(Module)](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-core/src/com/intellij/ide/util/projectWizard/ModuleBuilderListener.java).

Examples of the tasks executed right after a module has been created may include configuring module roots, looking up for an SDK and setting it up, adding a specific facet if required, etc.

### Adding New Wizard Steps

Adding new steps to the module wizard can be done by overriding [AbstractModuleBuilder.createWizardSteps(WizardContext, ModulesProvider)](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-core/src/com/intellij/ide/util/projectWizard/AbstractModuleBuilder.java).

If this method returns a non-empty array of [ModuleWizardStep](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-core/src/com/intellij/ide/util/projectWizard/ModuleWizardStep.java) objects, new steps will be shown in their indexing order while creating a new module.

`ModuleWizardStep` has two methods to be overridden:

* `JComponent getComponent()` - defines the step's UI

* `void updateDataModel()` - commits data from UI into `ModuleBuilder` and `WizardContext`

## Facet

Facets in IntelliJ are the way to store multiple kinds of module-specific settings, for example, to make a language support or framework available in some given module.
To understand facets better from the end-user's point of view, see the [Facet](facet.html) documentation section.

## Implementing Project Structure Detector

To support the creation of your module when a project is imported from existing sources, extend [ProjectStructureDetector](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/java/idea-ui/src/com/intellij/ide/util/projectWizard/importSources/ProjectStructureDetector.java).
To detect the files your module supports, implement `ProjectStructureDetector.detectRoots()`.

Detecting files is not enough - it is also required to create a module for the project, if appropriate, by implementing `setupProjectStructure()`.
Here is an example that creates a module if no other modules exist in the project structure.

```JAVA
@Override
public void setupProjectStructure(
    @NotNull Collection<DetectedProjectRoot> roots,
    @NotNull ProjectDescriptor projectDescriptor,
    @NotNull ProjectFromSourcesBuilder builder) {

  List<ModuleDescriptor> modules = projectDescriptor.getModules();
  if (modules.isEmpty()) {
    modules = new ArrayList<>();
    for (DetectedProjectRoot root : roots) {
      modules.add(new ModuleDescriptor(root.getDirectory(),
          MyModuleType.getInstance(), ContainerUtil.emptyList()));
    }
    projectDescriptor.setModules(modules);
  }
}
```

