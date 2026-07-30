# Run Configurations Tutorial

<tldr>
Product Help: [Run/Debug Configuration](https://www.jetbrains.com/idea/help/run-debug-configuration.html)
</tldr>

This step-by-step guide shows how to register and implement a simple [run configuration](run-configurations.html).
Run configurations are used to run internal and external processes from within IntelliJ Platform based products.

The full implementation is available in the [code samples](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/run_configuration).

## Pre-Requirements

Create an empty plugin project.
See the [Creating a Plugin Project](creating-plugin-project.html) section for details.

## 

Implement a `ConfigurationType`

Implement [ConfigurationType](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/execution/src/com/intellij/execution/configurations/ConfigurationType.java):

```JAVA
final class DemoRunConfigurationType extends ConfigurationTypeBase {

  static final String ID = "DemoRunConfiguration";

  DemoRunConfigurationType() {
    super(ID, "Demo", "Demo run configuration type",
        NotNullLazyValue.createValue(() -> AllIcons.Nodes.Console));
    addFactory(new DemoConfigurationFactory(this));
  }

}
```

## 

Register the `ConfigurationType`

Register implemented configuration type in [com.intellij.configurationType](https://jb.gg/ipe?extensions=com.intellij.configurationType) extension point
in the [plugin.xml](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/run_configuration/src/main/resources/META-INF/plugin.xml):

```XML
<extensions defaultExtensionNs="com.intellij">
  <configurationType
      implementation="org.jetbrains.sdk.runConfiguration.DemoRunConfigurationType"/>
</extensions>
```

## 

Implement a `ConfigurationFactory`

Implement a new [ConfigurationFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/execution/src/com/intellij/execution/configurations/ConfigurationFactory.java) through which custom run configurations will be created.

```JAVA
public class DemoConfigurationFactory extends ConfigurationFactory {

  protected DemoConfigurationFactory(ConfigurationType type) {
    super(type);
  }

  @Override
  public @NotNull String getId() {
    return DemoRunConfigurationType.ID;
  }

  @NotNull
  @Override
  public RunConfiguration createTemplateConfiguration(
      @NotNull Project project) {
    return new DemoRunConfiguration(project, this, "Demo");
  }

  @Nullable
  @Override
  public Class<? extends BaseState> getOptionsClass() {
    return DemoRunConfigurationOptions.class;
  }

}
```

Implement corresponding configuration options class extending [RunConfigurationOptions](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/execution/src/com/intellij/execution/configurations/RunConfigurationOptions.kt) to store settings.

```JAVA
public class DemoRunConfigurationOptions extends RunConfigurationOptions {

  private final StoredProperty<String> myScriptName =
      string("").provideDelegate(this, "scriptName");

  public String getScriptName() {
    return myScriptName.getValue(this);
  }

  public void setScriptName(String scriptName) {
    myScriptName.setValue(this, scriptName);
  }

}
```

## 

Implement a `RunConfiguration`

To make your changes visible from the UI, implement a new run configuration.

Note:

In most of the cases it is sufficient derive a custom run configuration class from the [RunConfigurationBase](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/execution/src/com/intellij/execution/configurations/RunConfigurationBase.java).
If implementing specific settings externalization rules and I/O behaviour is required, use [RunConfiguration](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/execution/src/com/intellij/execution/configurations/RunConfiguration.java) interface.

```JAVA
public class DemoRunConfiguration extends RunConfigurationBase<DemoRunConfigurationOptions> {

  protected DemoRunConfiguration(Project project,
                                 ConfigurationFactory factory,
                                 String name) {
    super(project, factory, name);
  }

  @NotNull
  @Override
  protected DemoRunConfigurationOptions getOptions() {
    return (DemoRunConfigurationOptions) super.getOptions();
  }

  public String getScriptName() {
    return getOptions().getScriptName();
  }

  public void setScriptName(String scriptName) {
    getOptions().setScriptName(scriptName);
  }

  @NotNull
  @Override
  public SettingsEditor<? extends RunConfiguration> getConfigurationEditor() {
    return new DemoSettingsEditor();
  }

  @Nullable
  @Override
  public RunProfileState getState(@NotNull Executor executor,
                                  @NotNull ExecutionEnvironment environment) {
    return new CommandLineState(environment) {
      @NotNull
      @Override
      protected ProcessHandler startProcess() throws ExecutionException {
        GeneralCommandLine commandLine =
            new GeneralCommandLine(getOptions().getScriptName());
        OSProcessHandler processHandler = ProcessHandlerFactory.getInstance()
            .createColoredProcessHandler(commandLine);
        ProcessTerminatedListener.attach(processHandler);
        return processHandler;
      }
    };
  }

}
```

## 

Implement the `SettingsEditor`

```JAVA
public class DemoSettingsEditor extends SettingsEditor<DemoRunConfiguration> {

  private final JPanel myPanel;
  private final TextFieldWithBrowseButton scriptPathField;

  public DemoSettingsEditor() {
    scriptPathField = new TextFieldWithBrowseButton();
    scriptPathField.addBrowseFolderListener(null,
        FileChooserDescriptorFactory.createSingleFileDescriptor().withTitle("Select Script File"));
    myPanel = FormBuilder.createFormBuilder()
        .addLabeledComponent("Script file", scriptPathField)
        .getPanel();
  }

  @Override
  protected void resetEditorFrom(DemoRunConfiguration demoRunConfiguration) {
    scriptPathField.setText(demoRunConfiguration.getScriptName());
  }

  @Override
  protected void applyEditorTo(@NotNull DemoRunConfiguration demoRunConfiguration) {
    demoRunConfiguration.setScriptName(scriptPathField.getText());
  }

  @NotNull
  @Override
  protected JComponent createEditor() {
    return myPanel;
  }

}
```

## Compile and Run the Plugin

Procedure:

