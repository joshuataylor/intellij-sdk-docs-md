# SDK

<tldr>
Product Help: [SDKs](https://www.jetbrains.com/help/idea/working-with-sdks.html)
</tldr>

Every project uses a Software Development Kit (SDK).
For Java projects, the SDK is referred to as the JDK (Java Development Kit).
The SDK determines which API library is used to build the project.
If a project is multi-module, the project SDK by default is common for all modules within the project.
Optionally, individual SDKs for each module can be configured.

## Working with SDKs

Note: Workspace Model API (2024.2+)

The [Workspace Model](workspace-model.html) API is available since 2024.2 for use by third-party plugins and should be preferred over using the [Project Model](project-model.html) API.

See [Interoperability with Project Model API](workspace-model.html#interoperability) and [Usage Examples](workspace-model-usages.html).

### Getting Project SDK Information

The information about the project SDK is accessed via [ProjectRootManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/projectModel-api/src/com/intellij/openapi/roots/ProjectRootManager.java) like the following example shows

```JAVA
Sdk projectSdk = ProjectRootManager.getInstance(project).getProjectSdk();
```

### Getting and Setting Project SDK Attributes

* To get the project-level SDK: ```JAVA Sdk projectSdk = ProjectRootManager.getInstance(project).getProjectSdk(); ```

* To get the project-level SDK name: ```JAVA String projectSdkName = ProjectRootManager.getInstance(project).getProjectSdkName(); ```

* To set the project-level SDK: ```JAVA ProjectRootManager.getInstance(project).setProjectSdk(sdk); ```

* To set the project-level SDK name: ```JAVA ProjectRootManager.getInstance(project).setProjectSdkName(name, sdk.getSdkType().getName()); ```

See the [project_model](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/project_model/src/main/java/org/intellij/sdk/project/model/ProjectSdkAction.java) code sample to get more familiar with the SDK manipulation toolset.

### Available SDKs

[ProjectJdkTable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/projectModel-api/src/com/intellij/openapi/projectRoots/ProjectJdkTable.java) can be used to query and modify configured SDKs.

### Working with a Custom SDK

To create a custom SDK, provide a class extending [SdkType](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-core/src/com/intellij/openapi/projectRoots/SdkType.java), leave `saveAdditionalData()` blank, and register it
in the [com.intellij.sdkType](https://jb.gg/ipe?extensions=com.intellij.sdkType) extension point
.

To make SDK settings persistent, override `setupSdkPaths()` and save settings by `modificator.commitChanges()`:

```JAVA

@Override
public boolean setupSdkPaths(@NotNull Sdk sdk, @NotNull SdkModel sdkModel) {
  SdkModificator modificator = sdk.getSdkModificator();
  modificator.setVersionString(getVersionString(sdk));
  modificator.commitChanges(); // save
  return true;
}
```

To let a user select an SDK, see [ProjectJdksEditor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/java/idea-ui/src/com/intellij/openapi/projectRoots/ui/ProjectJdksEditor.java).

However, it is not recommended to use "SDK" in non-IntelliJ IDEA IDEs.
Although "SDK" is available in most JetBrains products, `ProjectJdksEditor` is specific to Java, making the operation around "SDK" difficult.
The recommended way of managing "SDK" settings is to create a [CustomStepProjectGenerator](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/ide/util/projectWizard/CustomStepProjectGenerator.java) implementation and save settings in a [PersistentStateComponent](persisting-state-of-components.html).

## Assisting in Setting Up an SDK

Prompting the user with a notification to set up an SDK can help them get up-and-running with a plugin faster.
Use [com.intellij.projectSdkSetupValidator](https://jb.gg/ipe?extensions=com.intellij.projectSdkSetupValidator) extension point
to register
an implementation of [ProjectSdkSetupValidator](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/codeInsight/daemon/ProjectSdkSetupValidator.java)
to notify the user if they are missing an SDK.

The following is a simplified example that checks whether an instance of "DemoSdk" has been configured in the project when the user opens a "DemoFileType":

```KOTLIN
internal class DemoProjectSdkSetupValidator : ProjectSdkSetupValidator {
  override fun isApplicableFor(project: Project, file: VirtualFile): Boolean {
    return file.fileType == DemoFileType
  }

  override fun getErrorMessage(project: Project, file: VirtualFile): String? {
    if (ProjectJdkTable.getInstance().getSdksOfType(DemoSdkType.getInstance()).isEmpty()) {
      return "No DemoSdks are configured for this project!"
    }
    return null
  }

  override fun getFixHandler(project: Project, file: VirtualFile):
        EditorNotificationPanel.ActionHandler {
    return SdkPopupFactory.newBuilder()
        .withProject(project)
        .withSdkTypeFilter { it is DemoSdkType }
        .updateSdkForFile(file)
        .buildEditorNotificationPanelHandler()
  }
}
```

Within `DemoProjectSdkSetupValidator`:

* `isApplicableFor()` checks what condition(s) should be met to run the validation.

* `getErrorMessage()` runs the validation and returns an appropriate error message if the validation fails.

* If the validation is successful, then it should return null.

* `getFixHandler()` returns an `EditorNotificationPanel.ActionHandler` that enables the user to execute a quick fix to resolve the validation issue.

Warning:

`ProjectSdkSetupValidator` will not work in IntelliJ Platform-based IDEs such as PyCharm.
In such cases, you should register an implementation of [EditorNotificationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/EditorNotificationProvider.java)
via [com.intellij.editorNotificationProvider](https://jb.gg/ipe?extensions=com.intellij.editorNotificationProvider) extension point
and override the `createNotificationPanel()` method with the conditionality and panel setup you want.

