# Adding New Steps to Project Wizard

This tutorial shows how to add an extra step to the Project Wizard to provide additional project configuration settings.

## Pre-Requirements

Create an empty plugin project.
See the [Creating a Plugin Project](creating-plugin-project.html) section for details.

## Register Module Builder

Project configuration settings depend on the project's module type.
Register a new [com.intellij.moduleBuilder](https://jb.gg/ipe?extensions=com.intellij.moduleBuilder) extension point
in the `[plugin.xml](plugin-configuration-file.html)` configuration file.

```XML
<extensions defaultExtensionNs="com.intellij">
  <moduleBuilder
      builderClass="org.intellij.sdk.project.wizard.DemoModuleWizardStep"
      id="DEMO_STEP"
      order="first"/>
</extensions>
```

## Create a Custom Module Builder

Extend [ModuleBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-core/src/com/intellij/ide/util/projectWizard/ModuleBuilder.java) class to provide custom configuration.

```JAVA
public class DemoModuleWizardStep extends ModuleBuilder {
  public void setupRootModel(ModifiableRootModel modifiableRootModel)
      throws ConfigurationException {

  }
}
```

## Define Module Type

Set a module type for the extra wizard step to provide.
In this example, choose an `EMPTY` module type.

```JAVA
public class DemoModuleWizardStep extends ModuleBuilder {
  public void setupRootModel(ModifiableRootModel modifiableRootModel)
      throws ConfigurationException {

  }

  public ModuleType getModuleType() {
    return ModuleType.EMPTY; //or it could be any other module type
  }
}
```

## Design and Implement Wizard Steps

Provide an implementation of a custom UI component to be added to the Wizard.
In this case, leave it as a label.

```JAVA
public class DemoModuleWizardStep extends ModuleBuilder {
  public void setupRootModel(ModifiableRootModel modifiableRootModel)
      throws ConfigurationException {

  }

  public ModuleType getModuleType() {
    return ModuleType.EMPTY;
  }

  @Override
  public ModuleWizardStep[] createWizardSteps(
      @NotNull WizardContext wizardContext,
      @NotNull ModulesProvider modulesProvider) {
    return new ModuleWizardStep[]{new ModuleWizardStep() {
      @Override
      public JComponent getComponent() {
        return new JLabel("Put your content here");
      }

      @Override
      public void updateDataModel() {

      }
    }};
  }
}
```

## Checking UI Appearance

After compiling and running the plugin, create a new project using a source-compiled instance of IntelliJ IDEA.

![New Project](images/empty_project.png)
Choose an Empty Module type, click next, and get to the just added extra step.

![Extra Step](images/extra_step.png)
Modify and tune the UI component depending on requirements.

