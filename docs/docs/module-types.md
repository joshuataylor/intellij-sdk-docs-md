# Supporting Module Types

IntelliJ Platform provides a set of standard module types.
However, an application might need a module of a type that isn't supported yet.
This tutorial shows how to register a new module type and link it to the project creation procedure and the UI.

The source code for the [module](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/module) and [project_wizard](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/project_wizard) code samples is used throughout this tutorial.

## Pre-Requirements

Create an empty plugin project.
See the [Creating a Plugin Project](creating-plugin-project.html) section for details.

Note:

The UI for selecting module types and the creation of modules through project wizard is IntelliJ IDEA-specific.

## Register a New Module Type

Add a new `com.intellij.moduleType` implementation with the IntelliJ Platform in the `[plugin.xml](plugin-configuration-file.html)` configuration file.

```XML
<extensions defaultExtensionNs="com.intellij">
  <moduleType
      id="DEMO_MODULE_TYPE"
      implementationClass="org.intellij.sdk.module.DemoModuleType"/>
</extensions>
```

## 

Implement `ModuleType` Interface

Create the `DemoModuleType` implementation based on [ModuleType](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-core/src/com/intellij/openapi/module/ModuleType.java).

`getNodeIcon()` should return module type specific icon.

```JAVA
final class DemoModuleType extends ModuleType<DemoModuleBuilder> {

  private static final String ID = "DEMO_MODULE_TYPE";

  DemoModuleType() {
    super(ID);
  }

  public static DemoModuleType getInstance() {
    return (DemoModuleType) ModuleTypeManager.getInstance().findByID(ID);
  }

  @NotNull
  @Override
  public DemoModuleBuilder createModuleBuilder() {
    return new DemoModuleBuilder();
  }

  @NotNull
  @Override
  public String getName() {
    return "SDK Module Type";
  }

  @NotNull
  @Override
  public String getDescription() {
    return "Example custom module type";
  }

  @NotNull
  @Override
  public Icon getNodeIcon(@Deprecated boolean b) {
    return SdkIcons.Sdk_default_icon;
  }

  @Override
  public ModuleWizardStep @NotNull [] createWizardSteps(@NotNull WizardContext wizardContext,
                                                        @NotNull DemoModuleBuilder moduleBuilder,
                                                        @NotNull ModulesProvider modulesProvider) {
    return super.createWizardSteps(wizardContext, moduleBuilder, modulesProvider);
  }

}
```

## Implement Custom Module Builder

Create `DemoModuleBuilder` based on [ModuleBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-core/src/com/intellij/ide/util/projectWizard/ModuleBuilder.java).

```JAVA
public class DemoModuleBuilder extends ModuleBuilder {

  @Override
  public void setupRootModel(@NotNull ModifiableRootModel model) {
  }

  @Override
  public ModuleType<DemoModuleBuilder> getModuleType() {
    return DemoModuleType.getInstance();
  }

  @Nullable
  @Override
  public ModuleWizardStep getCustomOptionsStep(WizardContext context, Disposable parentDisposable) {
    return new DemoModuleWizardStep();
  }

}
```

## Provide Custom Wizard Steps

Provide a straightforward implementation of UI components for the project creating stage.
Create a generic `DemoModuleWizardStep` based on [ModuleWizardStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-core/src/com/intellij/ide/util/projectWizard/ModuleWizardStep.java)

```JAVA
public class DemoModuleWizardStep extends ModuleWizardStep {

  @Override
  public JComponent getComponent() {
    return new JLabel("Provide some setting here");
  }

  @Override
  public void updateDataModel() {
    //todo update model according to UI
  }

}
```

## Creating a Module of New Type

After compiling and running the plugin in a development instance, create a new project.
Select `File | New | Module...`.
A new module type and its settings panel are available in the Project Wizard.

![New Module Type](images/new_module_type.png)

