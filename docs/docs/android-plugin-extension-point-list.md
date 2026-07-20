# Android Plugin Extension Point and Listener List

<tldr>
Product-Specific Plugin Development: [Android Studio](android-studio.html)

See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

127 Extension Points and 36 Listeners

## Legend

Tip:

See also [Explore the IntelliJ Platform API](explore-api.html) for more information and strategies.

### Listeners

Topic
searches for usages inside existing implementations of open-source IntelliJ Platform plugins via [IntelliJ Platform Explorer](https://jb.gg/ipe).

Listener
links corresponding listener to implement.

See [Listeners](plugin-listeners.html) on how to register listeners.

### Extension Points

Extension Point
searches for usages inside existing implementations of open-source IntelliJ Platform plugins via [IntelliJ Platform Explorer](https://jb.gg/ipe).

Implementation
is the related Extension Point class.

See [Extensions](plugin-extensions.html) on how to declare extensions in your plugin.

### Tags

See [Verifying Plugin Compatibility](verifying-plugin-compatibility.html) for overview of API status.

| Tag |Description |Details |
-----------------------------
| ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |Deprecated API |See code documentation for replacement. |
| ![Removal](https://img.shields.io/badge/-Removal-red?style=flat-square) |Scheduled for Removal API |Annotated with [@ApiStatus.ScheduledForRemoval](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             See code documentation for replacement.   |
| ![Obsolete](https://img.shields.io/badge/-Obsolete-grey?style=flat-square)                          |Obsolete API |Annotated with [@ApiStatus.Obsolete](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             Do not use in new code, see code documentation for replacement.   |
| ![Experimental API](https://img.shields.io/badge/-Experimental-violet?style=flat-square)                               |Experimental API |Annotated with [@ApiStatus.Experimental](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             API might be altered or removed without prior notice.   |
| ![Internal API](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |Internal API |Annotated with [@ApiStatus.Internal](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             Must not be used by third party plugins, see [Internal API Migration](api-internal.html).   |
| ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |Project-LevelExtension Point/Topic   |Can have [Project](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/project/Project.java)                             as constructor parameter.                               - Extension Point: declared with `area="IDEA_PROJECT"`                               - Listener: registered in [&lt;projectListeners&gt;](plugin-configuration-file.html#idea-plugin__projectListeners)                                |
| ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |`DumbAware`                             Extension Point   |Implementations marked with [DumbAware](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/project/DumbAware.java)                             will be processed during [dumb                                 mode](indexing-and-psi-stubs.html#dumb-mode).                          |
| ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |Non-DynamicExtension Point   |Installation/update of plugin requires restarting the IDE, see [Dynamic Plugins](dynamic-plugins.html).                          |

## Android Plugin

### Android Plugin – Listeners

| Topic |Listener |
-------------------
| [BuildAnalyzerStorageManager.Companion#DATA_IS_READY_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.build.attribution.BuildAnalyzerStorageManager.Listener) |[Listener](https://github.com/JetBrains/android/tree/idea/262.8665.258/build-attribution/src/com/android/build/attribution/BuildAnalyzerStorageManager.kt) |
| [StatefulButtonNotifier#BUTTON_STATE_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.assistant.StatefulButtonNotifier)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[StatefulButtonNotifier](https://github.com/JetBrains/android/tree/idea/262.8665.258/assistant/src/com/android/tools/idea/assistant/StatefulButtonNotifier.java) |
| [TutorialCardRefreshNotifier#TUTORIAL_CARD_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.assistant.TutorialCardRefreshNotifier) |[TutorialCardRefreshNotifier](https://github.com/JetBrains/android/tree/idea/262.8665.258/assistant/src/com/android/tools/idea/assistant/TutorialCardRefreshNotifier.java) |
| [EmulatorLogListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.avdmanager.EmulatorLogListener) |[EmulatorLogListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/avdmanager/EmulatorLogListener.kt) |
| [IssueProviderListener#UI_CHECK](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.common.error.IssueProviderListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[IssueProviderListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/common/error/IssueProvider.kt) |
| [IssueProviderListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.common.error.IssueProviderListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[IssueProviderListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/common/error/IssueProvider.kt) |
| [ComposeAnimationListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.compose.preview.ComposePreviewRepresentation.ComposeAnimationListener) |[ComposeAnimationListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/compose-designer/src/com/android/tools/idea/compose/preview/ComposePreviewRepresentation.kt) |
| [FastPreviewManager#FAST_PREVIEW_MANAGER_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.editors.fast.FastPreviewManager.Companion.FastPreviewManagerListener) |[FastPreviewManagerListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/editors/fast/FastPreviewManager.kt) |
| [GradleBuildState#GRADLE_BUILD_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.gradle.project.build.GradleBuildListener) |[GradleBuildListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/src/com/android/tools/idea/gradle/project/build/GradleBuildListener.java) |
| [GradleSyncStateImplKt#GRADLE_SYNC_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.gradle.project.sync.GradleSyncListenerWithRoot) |[GradleSyncListenerWithRoot](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/src/com/android/tools/idea/gradle/project/sync/GradleSyncListenerWithRoot.kt) |
| [FilterStatusChanged.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.logcat.filters.FilterTextField.FilterStatusChanged) |[FilterStatusChanged](https://github.com/JetBrains/android/tree/idea/262.8665.258/logcat/src/com/android/tools/idea/logcat/filters/FilterTextField.kt) |
| [MergedManifestSnapshotComputeListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.model.MergedManifestSnapshotComputeListener) |[MergedManifestSnapshotComputeListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/model/MergedManifestManager.kt) |
| [SafeArgsModeModuleService#MODE_CHANGED](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.nav.safeargs.module.SafeArgsModeModuleService.SafeArgsModeChangedListener) |[SafeArgsModeChangedListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/nav/safeargs/common/src/com/android/tools/idea/nav/safeargs/module/SafeArgsModeModuleService.kt) |
| [NavigationResourcesModificationListenerKt#NAVIGATION_RESOURCES_CHANGED](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.nav.safeargs.project.NavigationResourcesChangeListener) |[NavigationResourcesChangeListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/nav/safeargs/common/src/com/android/tools/idea/nav/safeargs/project/NavigationResourcesModificationListener.kt) |
| [MultiTemplateRenderer#TEMPLATE_RENDERER_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.npw.model.MultiTemplateRenderer.TemplateRendererListener) |[TemplateRendererListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-npw/src/com/android/tools/idea/npw/model/MultiTemplateRenderer.kt) |
| [ProjectApplicationIdsProvider.Companion#PROJECT_APPLICATION_IDS_CHANGED_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.projectsystem.ProjectApplicationIdsProvider.ProjectApplicationIdsListener) |[ProjectApplicationIdsListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/ProjectApplicationIdsProvider.kt) |
| [ProjectSystemBuildUtil#PROJECT_SYSTEM_BUILD_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.projectsystem.ProjectSystemBuildManager.BuildListener) |[BuildListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/ProjectSystemBuildManager.kt) |
| [ProjectSystemSyncUtil#PROJECT_SYSTEM_SYNC_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.projectsystem.ProjectSystemSyncManager.SyncResultListener) |[SyncResultListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/ProjectSystemSyncManager.kt) |
| [ClearLogcatListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.run.ClearLogcatListener) |[ClearLogcatListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/ClearLogcatListener.kt) |
| [DeviceHeadsUpListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.run.DeviceHeadsUpListener) |[DeviceHeadsUpListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/DeviceHeadsUpListener.java) |
| [ShowLogcatListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.run.ShowLogcatListener) |[ShowLogcatListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/ShowLogcatListener.kt) |
| [ApplicationDeployListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.run.configuration.execution.ApplicationDeployListener) |[ApplicationDeployListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/configuration/execution/ApplicationDeployerImpl.kt) |
| [SdkInstallListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.sdk.SdkInstallListener) |[SdkInstallListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/sdk/SdkInstallListener.kt) |
| [DeviceMirroringSettingsListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.streaming.DeviceMirroringSettingsListener) |[DeviceMirroringSettingsListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/streaming/DeviceMirroringSettingsListener.java) |
| [EmulatorSettingsListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.streaming.EmulatorSettingsListener) |[EmulatorSettingsListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/streaming/EmulatorSettingsListener.java) |
| [Listener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.streaming.actions.FloatingXrToolbarState.Listener) |[Listener](https://github.com/JetBrains/android/tree/idea/262.8665.258/streaming/src/com/android/tools/idea/streaming/actions/ToggleFloatingXrToolbarAction.kt) |
| [StreamingContextMenuAdvertisementCloser#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.streaming.core.StreamingContextMenuAdvertisementCloser) |[StreamingContextMenuAdvertisementCloser](https://github.com/JetBrains/android/tree/idea/262.8665.258/streaming/src/com/android/tools/idea/streaming/core/StreamingContextMenuAdvertisementCloser.java) |
| [AndroidTestSuiteView#ANDROID_TEST_SUITE_TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.testartifacts.instrumented.testsuite.api.AndroidTestResultListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[AndroidTestResultListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/testartifacts/src/com/android/tools/idea/testartifacts/instrumented/testsuite/api/AndroidTestResultListener.kt) |
| [TransportDeviceManager#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.transport.TransportDeviceManager.TransportDeviceManagerListener) |[TransportDeviceManagerListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-transport/src/com/android/tools/idea/transport/TransportDeviceManager.java) |
| [Listener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.idea.uibuilder.options.NlOptionsConfigurable.Listener) |[Listener](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/uibuilder/options/NlOptionsConfigurable.kt) |
| [OpenHomeTabListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.profilers.taskbased.home.OpenHomeTabListener) |[OpenHomeTabListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/profilers/src/com/android/tools/profilers/taskbased/home/OpenHomeTabListener.kt) |
| [OpenPastRecordingsTabListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.profilers.taskbased.pastrecordings.OpenPastRecordingsTabListener) |[OpenPastRecordingsTabListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/profilers/src/com/android/tools/profilers/taskbased/pastrecordings/OpenPastRecordingsTabListener.kt) |
| [CreateProfilerTaskTabListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.profilers.taskbased.task.CreateProfilerTaskTabListener) |[CreateProfilerTaskTabListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/profilers/src/com/android/tools/profilers/taskbased/task/CreateProfilerTaskTabListener.kt) |
| [OpenProfilerTaskTabListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.android.tools.profilers.taskbased.task.OpenProfilerTaskTabListener) |[OpenProfilerTaskTabListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/profilers/src/com/android/tools/profilers/taskbased/task/OpenProfilerTaskTabListener.kt) |
| [ResourceFolderManager#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.android.facet.ResourceFolderManager.ResourceFolderListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ResourceFolderListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/org/jetbrains/android/facet/ResourceFolderManager.kt) |
| [ResourceFolderManager#EARLY_TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.android.facet.ResourceFolderManager.ResourceFolderListener) |[ResourceFolderListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/org/jetbrains/android/facet/ResourceFolderManager.kt) |

### adt-ui.xml

[adt-ui.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/adt-ui/resources/META-INF/adt-ui.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.android.toolWindow](https://jb.gg/ipe?extensions=com.intellij.android.toolWindow)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[ToolWindowFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/wm/ToolWindowFactory.kt) |

### aiplugin-api.xml

[aiplugin-api.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/ml-api/src/resources/META-INF/aiplugin-api.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.gemini.geminiPluginApi](https://jb.gg/ipe?extensions=com.android.tools.idea.gemini.geminiPluginApi)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[GeminiPluginApi](https://github.com/JetBrains/android/tree/idea/262.8665.258/ml-api/src/main/kotlin/com/android/tools/idea/gemini/GeminiPluginApi.kt) |
| [com.android.tools.idea.ml.studioBotExternalFlags](https://jb.gg/ipe?extensions=com.android.tools.idea.ml.studioBotExternalFlags)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[StudioBotExternalFlags](https://github.com/JetBrains/android/tree/idea/262.8665.258/ml-api/src/main/kotlin/com/android/tools/idea/gemini/StudioBotExternalFlags.kt) |

### android-adb.xml

[android-adb.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-adb/resources/META-INF/android-adb.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.run.deviceNameRenderer](https://jb.gg/ipe?extensions=com.android.run.deviceNameRenderer)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DeviceNameRendererEx](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-adb/src/com/android/tools/idea/ddms/DeviceNameRendererEx.java) |
| [com.android.tools.idea.deviceProvisioner](https://jb.gg/ipe?extensions=com.android.tools.idea.deviceProvisioner)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DeviceProvisionerFactory](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-adb/src/com/android/tools/idea/deviceprovisioner/DeviceProvisionerFactory.kt) |

### android-common.xml

[android-common.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-common/resources/META-INF/android-common.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.googleapis.googleApiKeyProvider](https://jb.gg/ipe?extensions=com.android.googleapis.googleApiKeyProvider)      |[GoogleApiKeyProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-common/src/com/android/tools/idea/googleapis/GoogleApiKeyProvider.kt) |
| [com.android.tools.idea.login.googleLoginCredentialProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.login.googleLoginCredentialProvider)      |[GoogleLoginCredentialProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-common/src/com/android/tools/idea/login/GoogleLoginCredentialProvider.kt) |

### android-editing-metrics.xml

[android-editing-metrics.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/editing/metrics/resources/META-INF/android-editing-metrics.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.editing.metrics.codeEditedListener](https://jb.gg/ipe?extensions=com.android.tools.idea.editing.metrics.codeEditedListener)      |[CodeEditedListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/editing/metrics/src/com/android/tools/idea/editing/metrics/CodeEditedListener.kt) |

### android-execution-common.xml

[android-execution-common.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/execution/common/resources/META-INF/android-execution-common.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.execution.common.androidConfigurationExecutorProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.execution.common.androidConfigurationExecutorProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[Provider](https://github.com/JetBrains/android/tree/idea/262.8665.258/execution/common/src/com/android/tools/idea/execution/common/AndroidConfigurationExecutor.kt) |
| [com.android.tools.idea.execution.common.debug.utils.facetFinderToken](https://jb.gg/ipe?extensions=com.android.tools.idea.execution.common.debug.utils.facetFinderToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[FacetFinderToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/execution/common/src/com/android/tools/idea/execution/common/debug/utils/FacetFinder.kt) |

### android-kotlin.common.xml

[android-kotlin.common.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-kotlin/idea-android/common/resources/META-INF/android-kotlin.common.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.kotlin.androidDexer](https://jb.gg/ipe?extensions=org.jetbrains.kotlin.androidDexer)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[AndroidDexer](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/kotlin/jvm-debugger/evaluation/src/org/jetbrains/kotlin/idea/debugger/evaluate/classLoading/AndroidDexer.kt) |

### android-lang.xml

[android-lang.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-lang/resources/META-INF/android-lang.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.lang.androidSql.contextProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.lang.androidSql.contextProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[Provider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-lang/src/com/android/tools/idea/lang/androidSql/AndroidSqlContext.kt) |

### android-navigator.xml

[android-navigator.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-navigator/resources/META-INF/android-navigator.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.navigator.androidViewNodeProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.navigator.androidViewNodeProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidViewNodeProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-navigator/src/com/android/tools/idea/navigator/nodes/AndroidViewNodeProvider.kt) |

### android-npw.xml

[android-npw.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-npw/resources/META-INF/android-npw.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.androidProjectEntryProvider](https://jb.gg/ipe?extensions=com.android.androidProjectEntryProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`n/a` |
| [com.android.moduleDescriptionProvider](https://jb.gg/ipe?extensions=com.android.moduleDescriptionProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ModuleDescriptionProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-npw/src/com/android/tools/idea/npw/module/ModuleDescriptionProvider.kt) |

### android-plugin.xml

[android-plugin.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/resources/META-INF/android-plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.customProjectTypeImporter](https://jb.gg/ipe?extensions=com.android.customProjectTypeImporter)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[CustomProjectTypeImporter](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/project/CustomProjectTypeImporter.java) |
| [com.android.ide.androidConfigurableContributor](https://jb.gg/ipe?extensions=com.android.ide.androidConfigurableContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidConfigurableContributor](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/structure/dialog/AndroidConfigurableContributor.kt) |
| [com.android.ide.sdkEventListener](https://jb.gg/ipe?extensions=com.android.ide.sdkEventListener)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidSdkEventListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/sdk/IdeSdks.java) |
| [com.android.rendering.renderErrorContributor](https://jb.gg/ipe?extensions=com.android.rendering.renderErrorContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[Provider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/rendering/RenderErrorContributor.java) |
| [com.android.rendering.renderSecurityManagerOverrides](https://jb.gg/ipe?extensions=com.android.rendering.renderSecurityManagerOverrides)      |[RenderSecurityManagerOverrides](https://github.com/JetBrains/android/tree/idea/262.8665.258/rendering/src/com/android/tools/rendering/security/RenderSecurityManagerOverrides.kt) |
| [com.android.run.androidDebugger](https://jb.gg/ipe?extensions=com.android.run.androidDebugger)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidDebugger](https://github.com/JetBrains/android/tree/idea/262.8665.258/execution/common/src/com/android/tools/idea/execution/common/debug/AndroidDebugger.java) |
| [com.android.run.androidLaunchTaskContributor](https://jb.gg/ipe?extensions=com.android.run.androidLaunchTaskContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidLaunchTaskContributor](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/AndroidLaunchTaskContributor.java) |
| [com.android.run.deployTargetProvider](https://jb.gg/ipe?extensions=com.android.run.deployTargetProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DeployTargetProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/editor/DeployTargetProvider.java) |
| [com.android.tools.idea.actions.annotations.inferAnnotationsToken](https://jb.gg/ipe?extensions=com.android.tools.idea.actions.annotations.inferAnnotationsToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[InferAnnotationsToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/actions/annotations/InferAnnotationsToken.kt) |
| [com.android.tools.idea.actions.exportProjectZipExcludesContributor](https://jb.gg/ipe?extensions=com.android.tools.idea.actions.exportProjectZipExcludesContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ExportProjectZipExcludesContributor](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/actions/ExportProjectZipExcludesContributor.java) |
| [com.android.tools.idea.analytics.ideBrandProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.analytics.ideBrandProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[IdeBrandProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/analytics/IdeBrandProvider.kt) |
| [com.android.tools.idea.databinding.layoutBindingSupport](https://jb.gg/ipe?extensions=com.android.tools.idea.databinding.layoutBindingSupport)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LayoutBindingSupport](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/databinding/LayoutBindingSupport.kt) |
| [com.android.tools.idea.diagnostics.report.logsProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.diagnostics.report.logsProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DiagnosticsSummaryFileProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/diagnostics/report/DiagnosticsSummaryFileProvider.kt) |
| [com.android.tools.idea.editors.manifest.manifestPanelToken](https://jb.gg/ipe?extensions=com.android.tools.idea.editors.manifest.manifestPanelToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ManifestPanelToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/editors/manifest/ManifestPanelToken.kt) |
| [com.android.tools.idea.flags.experimentalSettingsContributor](https://jb.gg/ipe?extensions=com.android.tools.idea.flags.experimentalSettingsContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ExperimentalSettingsContributor](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/flags/ExperimentalSettingsContributor.kt) |
| [com.android.tools.idea.imports.androidMavenImportToken](https://jb.gg/ipe?extensions=com.android.tools.idea.imports.androidMavenImportToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidMavenImportToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/imports/AndroidMavenImportToken.kt) |
| [com.android.tools.idea.lang.databinding.dataBindingCompletionSupport](https://jb.gg/ipe?extensions=com.android.tools.idea.lang.databinding.dataBindingCompletionSupport)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DataBindingCompletionSupport](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/lang/databinding/DataBindingCompletionSupport.kt) |
| [com.android.tools.idea.lang.databinding.dataBindingExpressionSupport](https://jb.gg/ipe?extensions=com.android.tools.idea.lang.databinding.dataBindingExpressionSupport)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DataBindingExpressionSupport](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/lang/databinding/DataBindingExpressionSupport.kt) |
| [com.android.tools.idea.layoutlib.layoutLibraryProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.layoutlib.layoutLibraryProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LayoutLibraryProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/layoutlib-loader/src/com/android/tools/idea/layoutlib/LayoutLibraryLoader.java) |
| [com.android.tools.idea.liveedit.tokens.buildSystemLiveEditServices](https://jb.gg/ipe?extensions=com.android.tools.idea.liveedit.tokens.buildSystemLiveEditServices)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[BuildSystemLiveEditServices](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/deployment/liveedit/tokens/BuildSystemLiveEditServices.kt) |
| [com.android.tools.idea.manifest.manifestClassToken](https://jb.gg/ipe?extensions=com.android.tools.idea.manifest.manifestClassToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ManifestClassToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/manifest/ManifestClassToken.kt) |
| [com.android.tools.idea.ndk.nativeWorkspaceProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.ndk.nativeWorkspaceProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[NativeWorkspaceProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/ndk/NativeWorkspaceProvider.kt) |
| [com.android.tools.idea.rendering.renderIssueCollectionConsumer](https://jb.gg/ipe?extensions=com.android.tools.idea.rendering.renderIssueCollectionConsumer)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[Provider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/rendering/RenderIssueCollectionConsumer.java) |
| [com.android.tools.idea.rendering.tokens.buildSystemFilePreviewServices](https://jb.gg/ipe?extensions=com.android.tools.idea.rendering.tokens.buildSystemFilePreviewServices)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[BuildSystemFilePreviewServices](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/rendering/tokens/BuildSystemFilePreviewServices.kt) |
| [com.android.tools.idea.res.resourceClassToken](https://jb.gg/ipe?extensions=com.android.tools.idea.res.resourceClassToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ResourceClassToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/res/ResourceClassToken.kt) |
| [com.android.tools.idea.run.configuration.editors.androidWearConfigurationEditorToken](https://jb.gg/ipe?extensions=com.android.tools.idea.run.configuration.editors.androidWearConfigurationEditorToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidWearConfigurationEditorToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/configuration/editors/AndroidWearConfigurationEditor.kt) |
| [com.android.tools.idea.run.deployment.liveedit.liveEditStudioBotActionFactory](https://jb.gg/ipe?extensions=com.android.tools.idea.run.deployment.liveedit.liveEditStudioBotActionFactory)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LiveEditStudioBotActionFactory](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/editors/liveedit/ui/LiveEditStudioBotActionFactory.kt) |
| [com.android.tools.idea.run.deployment.liveedit.vibeTransformerProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.run.deployment.liveedit.vibeTransformerProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[VibeTransformerProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/deployment/liveedit/VibeTransformerProvider.kt) |
| [com.android.tools.idea.run.editor.androidDebuggerInfoProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.run.editor.androidDebuggerInfoProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidDebuggerInfoProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/editor/AndroidDebuggerInfoProvider.java) |
| [com.android.tools.idea.run.editor.testRunParametersToken](https://jb.gg/ipe?extensions=com.android.tools.idea.run.editor.testRunParametersToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[TestRunParametersToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/run/editor/TestRunParameters.java) |
| [com.android.tools.idea.testartifacts.instrumented.androidTestConfigurationProducerToken](https://jb.gg/ipe?extensions=com.android.tools.idea.testartifacts.instrumented.androidTestConfigurationProducerToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidTestConfigurationProducerToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/testartifacts/instrumented/AndroidTestConfigurationProducer.kt) |
| [com.android.tools.idea.testartifacts.instrumented.testRunConfigurationOptions](https://jb.gg/ipe?extensions=com.android.tools.idea.testartifacts.instrumented.testRunConfigurationOptions)      |[TestRunConfigurationOptions](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/testartifacts/instrumented/AndroidTestConfigurationProducer.kt) |
| [com.android.tools.idea.ui.designer.overlays.overlayProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.ui.designer.overlays.overlayProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[OverlayProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/ui/designer/overlays/OverlayProvider.java) |
| [com.android.tools.idea.ui.guiTestingStatusProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.ui.guiTestingStatusProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[GuiTestingStatusProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/ui/GuiTestingStatusProvider.java) |
| [com.android.tools.idea.ui.resourcemanager.importer.createDefaultResDirectoryToken](https://jb.gg/ipe?extensions=com.android.tools.idea.ui.resourcemanager.importer.createDefaultResDirectoryToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[CreateDefaultResDirectoryToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/ui/resourcemanager/importer/DesignAssetImporter.kt) |
| [com.android.tools.idea.wizard.template.wizardTemplateProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.wizard.template.wizardTemplateProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`WizardTemplateProvider` |
| [org.jetbrains.android.actions.newResourceCreationHandler](https://jb.gg/ipe?extensions=org.jetbrains.android.actions.newResourceCreationHandler)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[NewResourceCreationHandler](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/org/jetbrains/android/actions/NewResourceCreationHandler.java) |
| [org.jetbrains.android.refactoring.unusedResourcesToken](https://jb.gg/ipe?extensions=org.jetbrains.android.refactoring.unusedResourcesToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[UnusedResourcesToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/org/jetbrains/android/refactoring/UnusedResourcesProcessor.kt) |

### android-templates.xml

[android-templates.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-templates/resources/META-INF/android-templates.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.templates.additionalTemplateActionsProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.templates.additionalTemplateActionsProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AdditionalTemplateActionsProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-templates/src/com/android/tools/idea/templates/AdditionalTemplateActionsProvider.java) |

### apkanalyzer.xml

[apkanalyzer.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/apkanalyzer/resources/META-INF/apkanalyzer.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.apk.viewer.apkAnalyzerToken](https://jb.gg/ipe?extensions=com.android.tools.idea.apk.viewer.apkAnalyzerToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ApkAnalyzerToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/apkanalyzer/src/com/android/tools/idea/apk/viewer/ApkAnalyzerToken.kt) |

### app-inspection.xml

[app-inspection.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/app-inspection/ide/resources/META-INF/app-inspection.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.appinspection.ide.resolver.artifactResolverFactoryToken](https://jb.gg/ipe?extensions=com.android.tools.idea.appinspection.ide.resolver.artifactResolverFactoryToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ArtifactResolverFactoryToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/app-inspection/ide/src/com/android/tools/idea/appinspection/ide/resolver/ArtifactResolverFactory.kt) |

### app-inspector.xml

[app-inspector.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/app-inspection/inspector/ide/resources/META-INF/app-inspector.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.appinspection.inspector.ide.appInspectorTabProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.appinspection.inspector.ide.appInspectorTabProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AppInspectorTabProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/app-inspection/inspector/ide/src/com/android/tools/idea/appinspection/inspector/ide/AppInspectorTabProvider.kt) |

### assistant.xml

[assistant.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/assistant/resources/META-INF/assistant.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.assistant.actionHandler](https://jb.gg/ipe?extensions=com.android.tools.idea.assistant.actionHandler)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AssistActionHandler](https://github.com/JetBrains/android/tree/idea/262.8665.258/assistant/src/com/android/tools/idea/assistant/AssistActionHandler.java) |
| [com.android.tools.idea.assistant.actionStateManager](https://jb.gg/ipe?extensions=com.android.tools.idea.assistant.actionStateManager)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AssistActionStateManager](https://github.com/JetBrains/android/tree/idea/262.8665.258/assistant/src/com/android/tools/idea/assistant/AssistActionStateManager.java) |
| [com.android.tools.idea.assistant.assistantBundleCreator](https://jb.gg/ipe?extensions=com.android.tools.idea.assistant.assistantBundleCreator)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AssistantBundleCreator](https://github.com/JetBrains/android/tree/idea/262.8665.258/assistant/src/com/android/tools/idea/assistant/AssistantBundleCreator.java) |
| [com.android.tools.idea.assistant.navlistener](https://jb.gg/ipe?extensions=com.android.tools.idea.assistant.navlistener)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AssistNavListener](https://github.com/JetBrains/android/tree/idea/262.8665.258/assistant/src/com/android/tools/idea/assistant/AssistNavListener.java) |
| [com.android.tools.idea.assistant.panelFactory](https://jb.gg/ipe?extensions=com.android.tools.idea.assistant.panelFactory)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[PanelFactory](https://github.com/JetBrains/android/tree/idea/262.8665.258/assistant/src/com/android/tools/idea/assistant/PanelFactory.java) |
| [com.android.tools.idea.assistant.scrollHandler](https://jb.gg/ipe?extensions=com.android.tools.idea.assistant.scrollHandler)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ScrollHandler](https://github.com/JetBrains/android/tree/idea/262.8665.258/assistant/src/com/android/tools/idea/assistant/ScrollHandler.java) |

### com.android.tools.gradle.dcl

[com.android.tools.gradle.dcl](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-declarative-lang-ide/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.gradle.dcl.ide.declarativeSchemaProvider](https://jb.gg/ipe?extensions=com.android.tools.gradle.dcl.ide.declarativeSchemaProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |`n/a` |

### compose-designer.xml

[compose-designer.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/compose-designer/resources/META-INF/compose-designer.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.compose.preview.composeEditorNotificationProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.compose.preview.composeEditorNotificationProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[EditorNotificationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/EditorNotificationProvider.java) |
| [com.android.tools.idea.compose.preview.composeStudioBotActionFactory](https://jb.gg/ipe?extensions=com.android.tools.idea.compose.preview.composeStudioBotActionFactory)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ComposeStudioBotActionFactory](https://github.com/JetBrains/android/tree/idea/262.8665.258/compose-designer/src/com/android/tools/idea/compose/preview/ComposeStudioBotActionFactory.kt) |

### customview.xml

[customview.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/customview/resources/META-INF/customview.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.customview.preview.customViewEditorNotificationProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.customview.preview.customViewEditorNotificationProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[EditorNotificationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/EditorNotificationProvider.java) |

### databinding.xml

[databinding.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/databinding/resources/META-INF/databinding.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.databinding.bindingLayoutToken](https://jb.gg/ipe?extensions=com.android.tools.idea.databinding.bindingLayoutToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[BindingLayoutToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/databinding/src/com/android/tools/idea/databinding/BindingLayoutToken.kt) |

### designer.xml

[designer.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/resources/META-INF/designer.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.designer.issueFixActionProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.designer.issueFixActionProvider)      |[IssueFixActionProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/common/error/IssueFixActionProvider.kt) |
| [com.android.tools.idea.uibuilder.analytics.resizeTracker](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.analytics.resizeTracker)      |[ResizeTracker](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/uibuilder/analytics/ResizeTracker.kt) |
| [com.android.tools.idea.uibuilder.editor.multirepresentation.sourcecode.sourceCodePreviewRepresentationProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.editor.multirepresentation.sourcecode.sourceCodePreviewRepresentationProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[PreviewRepresentationProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/uibuilder/editor/multirepresentation/PreviewRepresentationProvider.kt) |
| [com.android.tools.idea.uibuilder.editorNotificationProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.editorNotificationProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |[EditorNotificationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/EditorNotificationProvider.java) |
| [com.android.tools.idea.uibuilder.handlers.constraint.constraintLayoutExtension](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.handlers.constraint.constraintLayoutExtension)      |[ConstraintLayoutExtension](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/uibuilder/handlers/constraint/ConstraintComponentUtilities.java) |
| [com.android.tools.idea.uibuilder.handlers.uiBuilderHandlerToken](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.handlers.uiBuilderHandlerToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[UIBuilderHandlerToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/uibuilder/handlers/UIBuilderHandlerToken.kt) |
| [com.android.tools.idea.uibuilder.handlers.viewHandlerProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.handlers.viewHandlerProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ViewHandlerProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/uibuilder/handlers/ViewHandlerProvider.kt) |
| [com.android.tools.idea.uibuilder.property.motionEditorNlPropertiesModelProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.property.motionEditorNlPropertiesModelProvider)      |[NlPropertiesModelProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/uibuilder/property/NlPropertiesModel.kt) |
| [com.android.tools.idea.uibuilder.property.motionEditorNlPropertiesViewProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.property.motionEditorNlPropertiesViewProvider)      |[NlPropertiesViewProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/uibuilder/property/NlPropertiesView.kt) |
| [com.android.tools.idea.uibuilder.scene.decorator.nlDecoratorProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.scene.decorator.nlDecoratorProvider)      |[Provider](https://github.com/JetBrains/android/tree/idea/262.8665.258/designer/src/com/android/tools/idea/uibuilder/scene/decorator/NlSceneDecoratorFactory.java) |
| [com.android.tools.idea.uibuilder.troubleshooting.infoCollector](https://jb.gg/ipe?extensions=com.android.tools.idea.uibuilder.troubleshooting.infoCollector)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[TroubleInfoCollector](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-impl/src/com/intellij/troubleshooting/TroubleInfoCollector.java) |

### gradle-dsl-android.xml

[gradle-dsl-android.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl-android/resources/META-INF/gradle-dsl-android.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.gradle.dsl.gradleDeclarativeBuildModelProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.gradle.dsl.gradleDeclarativeBuildModelProvider)      |[GradleDeclarativeBuildModelProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl/src/com/android/tools/idea/gradle/dsl/model/GradleDeclarativeBuildModelProvider.kt) |
| [com.android.tools.idea.gradle.dsl.gradleDeclarativeSettingsModelProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.gradle.dsl.gradleDeclarativeSettingsModelProvider)      |[GradleDeclarativeSettingsModelProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl/src/com/android/tools/idea/gradle/dsl/model/GradleDeclarativeSettingsModelProvider.kt) |

### gradle-dsl.xml

[gradle-dsl.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl/resources/META-INF/gradle-dsl.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.gradleModelProvider](https://jb.gg/ipe?extensions=com.android.tools.gradleModelProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[GradleModelProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl/src/com/android/tools/idea/gradle/dsl/api/GradleModelProvider.java) |
| [com.android.tools.idea.gradle.dsl.blockModelProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.gradle.dsl.blockModelProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[BlockModelProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl/src/com/android/tools/idea/gradle/dsl/model/BlockModelProvider.kt) |
| [com.android.tools.idea.gradle.dsl.transformerFactory](https://jb.gg/ipe?extensions=com.android.tools.idea.gradle.dsl.transformerFactory)      |[GradleDslTransformerFactory](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl/src/com/android/tools/idea/gradle/dsl/parser/GradleDslTransformerFactory.java) |
| [com.android.tools.idea.versionCatalogFilesGradleModel](https://jb.gg/ipe?extensions=com.android.tools.idea.versionCatalogFilesGradleModel)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[VersionCatalogFilesModel](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl/src/com/android/tools/idea/gradle/dsl/model/VersionCatalogFilesModel.kt) |

### intellij.android.gradle.dsl.android.xml

[intellij.android.gradle.dsl.android.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl-android/resources/intellij.android.gradle.dsl.android.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.gradle.dsl.gradleDeclarativeBuildModelProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.gradle.dsl.gradleDeclarativeBuildModelProvider)      |[GradleDeclarativeBuildModelProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl/src/com/android/tools/idea/gradle/dsl/model/GradleDeclarativeBuildModelProvider.kt) |
| [com.android.tools.idea.gradle.dsl.gradleDeclarativeSettingsModelProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.gradle.dsl.gradleDeclarativeSettingsModelProvider)      |[GradleDeclarativeSettingsModelProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/gradle-dsl/src/com/android/tools/idea/gradle/dsl/model/GradleDeclarativeSettingsModelProvider.kt) |

### layout-inspector.xml

[layout-inspector.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/layout-inspector/resources/META-INF/layout-inspector.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.layoutinspector.pipeline.appinspection.compose.getComposeLayoutInspectorJarToken](https://jb.gg/ipe?extensions=com.android.tools.idea.layoutinspector.pipeline.appinspection.compose.getComposeLayoutInspectorJarToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[GetComposeLayoutInspectorJarToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/layout-inspector/src/com/android/tools/idea/layoutinspector/pipeline/appinspection/compose/ComposeLayoutInspectorClient.kt) |
| [com.android.tools.idea.layoutinspector.stateinspection.filterProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.layoutinspector.stateinspection.filterProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LayoutInspectorStateInspectionFilterProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/layout-inspector/src/com/android/tools/idea/layoutinspector/stateinspection/LayoutInspectorStateInspectionFilterProvider.kt) |
| [com.android.tools.idea.layoutinspector.stateinspection.stateReadRewriter](https://jb.gg/ipe?extensions=com.android.tools.idea.layoutinspector.stateinspection.stateReadRewriter)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LayoutInspectorStateReadRewriter](https://github.com/JetBrains/android/tree/idea/262.8665.258/layout-inspector/src/com/android/tools/idea/layoutinspector/stateinspection/LayoutInspectorStateReadRewriter.kt) |

### lint-plugin.xml

[lint-plugin.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/lint/resources/META-INF/lint-plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.lint.common.lintIdeSupport](https://jb.gg/ipe?extensions=com.android.tools.idea.lint.common.lintIdeSupport)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LintIdeSupport](https://github.com/JetBrains/android/tree/idea/262.8665.258/lint/src/com/android/tools/idea/lint/common/LintIdeSupport.kt) |
| [com.android.tools.idea.lint.common.lintQuickFixProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.lint.common.lintQuickFixProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LintIdeQuickFixProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/lint/src/com/android/tools/idea/lint/common/LintIdeQuickFixProvider.java) |
| [com.android.tools.idea.lint.common.updateDepsProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.lint.common.updateDepsProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DependencyUpdateProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/lint/src/com/android/tools/idea/lint/common/AndroidLintUpdatableDependencyInspection.kt) |

### logcat.xml

[logcat.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/logcat/resources/META-INF/logcat.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.logcat.consoleFilterProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.logcat.consoleFilterProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LogcatConsoleFilterProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/logcat/src/com/android/tools/idea/logcat/LogcatConsoleFilterProvider.kt) |
| [com.android.tools.idea.logcat.logcatR8MappingToken](https://jb.gg/ipe?extensions=com.android.tools.idea.logcat.logcatR8MappingToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LogcatR8MappingsToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/logcat/src/com/android/tools/idea/logcat/LogcatR8MappingsToken.kt) |
| [com.android.tools.idea.logcat.messages.exceptionMessageRewriter](https://jb.gg/ipe?extensions=com.android.tools.idea.logcat.messages.exceptionMessageRewriter)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ExceptionMessageRewriter](https://github.com/JetBrains/android/tree/idea/262.8665.258/logcat/src/com/android/tools/idea/logcat/messages/ExceptionMessageRewriter.kt) |

### native-symbolizer.xml

[native-symbolizer.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/native-symbolizer/resources/META-INF/native-symbolizer.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.nativeSymbolizer.moduleSymbolSourceContributor](https://jb.gg/ipe?extensions=com.android.tools.nativeSymbolizer.moduleSymbolSourceContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ModuleSymbolSourceContributor](https://github.com/JetBrains/android/tree/idea/262.8665.258/native-symbolizer/src/com/android/tools/nativeSymbolizer/SymbolSource.kt) |

### naveditor.xml

[naveditor.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/nav/editor/resources/META-INF/naveditor.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.naveditor.dialogs.addDeeplinkDialogToken](https://jb.gg/ipe?extensions=com.android.tools.idea.naveditor.dialogs.addDeeplinkDialogToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AddDeeplinkDialogToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/nav/editor/src/com/android/tools/idea/naveditor/dialogs/AddDeeplinkDialog.java) |
| [com.android.tools.idea.naveditor.editor.addDestinationMenuToken](https://jb.gg/ipe?extensions=com.android.tools.idea.naveditor.editor.addDestinationMenuToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AddDestinationMenuToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/nav/editor/src/com/android/tools/idea/naveditor/editor/AddDestinationMenu.kt) |
| [com.android.tools.idea.naveditor.surface.navDesignSurfaceToken](https://jb.gg/ipe?extensions=com.android.tools.idea.naveditor.surface.navDesignSurfaceToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[NavDesignSurfaceToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/nav/editor/src/com/android/tools/idea/naveditor/surface/NavDesignSurfaceToken.java) |

### pipeline.xml

[pipeline.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-transport/resources/META-INF/pipeline.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.transport.transportConfigContributor](https://jb.gg/ipe?extensions=com.android.tools.idea.transport.transportConfigContributor)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[TransportConfigContributor](https://github.com/JetBrains/android/tree/idea/262.8665.258/android-transport/src/com/android/tools/idea/transport/TransportConfigContributor.java) |

### profilers.xml

[profilers.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/profilers-android/resources/META-INF/profilers.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.profilers.profilerProgramRunnerToken](https://jb.gg/ipe?extensions=com.android.tools.idea.profilers.profilerProgramRunnerToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ProfilerProgramRunnerToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/profilers-android/src/com/android/tools/idea/profilers/ProfilerProgramRunnerToken.kt) |

### project-system-gradle-plugin.xml

[project-system-gradle-plugin.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/resources/META-INF/project-system-gradle-plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.gradle.androidModuleDataService](https://jb.gg/ipe?extensions=com.android.gradle.androidModuleDataService)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidModuleDataServiceExtension](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/src/com/android/tools/idea/projectsystem/gradle/sync/AndroidModuleDataServiceExtension.kt) |
| [com.android.gradle.sync.postSyncProjectCleanupStep](https://jb.gg/ipe?extensions=com.android.gradle.sync.postSyncProjectCleanupStep)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ProjectCleanupStep](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/src/com/android/tools/idea/gradle/project/sync/setup/post/ProjectCleanupStep.java) |
| [com.android.gradle.sync.postSyncProjectSetupStep](https://jb.gg/ipe?extensions=com.android.gradle.sync.postSyncProjectSetupStep)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ProjectSetupStep](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/src/com/android/tools/idea/gradle/project/sync/setup/post/ProjectSetupStep.java) |
| [com.android.moduleImporter](https://jb.gg/ipe?extensions=com.android.moduleImporter)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidModuleImporter](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/src/com/android/tools/idea/gradle/project/AndroidModuleImporter.kt) |
| [com.android.tools.idea.gradle.errorQuickFixProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.gradle.errorQuickFixProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[GradleErrorQuickFixProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/src/com/android/tools/idea/gradle/project/build/events/GradleErrorQuickFixProvider.kt) |
| [com.android.tools.idea.gradle.project.importing.gradleProjectImporter](https://jb.gg/ipe?extensions=com.android.tools.idea.gradle.project.importing.gradleProjectImporter)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[GradleProjectImporterExtension](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/src/com/android/tools/idea/gradle/project/importing/GradleProjectImporterExtension.kt) |
| [com.android.tools.idea.testartifacts.testsuite.temp.testSuiteViewAdaptorProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.testartifacts.testsuite.temp.testSuiteViewAdaptorProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[TestSuiteViewAdaptorProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system-gradle/src/com/android/tools/idea/testartifacts/testsuite/temp/TestSuiteViewAdaptorProvider.kt) |

### project-system-plugin.xml

[project-system-plugin.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/resources/META-INF/project-system-plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.androidStartupActivity](https://jb.gg/ipe?extensions=com.android.androidStartupActivity)      |[AndroidStartupActivity](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/AndroidStartupActivity.kt) |
| [com.android.project.projectsystem](https://jb.gg/ipe?extensions=com.android.project.projectsystem)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidProjectSystemProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/AndroidProjectSystemProvider.kt) |
| [com.android.tools.idea.memorysettings.memorySettingsToken](https://jb.gg/ipe?extensions=com.android.tools.idea.memorysettings.memorySettingsToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[MemorySettingsToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/memorysettings/MemorySettingsToken.java) |
| [com.android.tools.idea.model.mergedManifestInfoToken](https://jb.gg/ipe?extensions=com.android.tools.idea.model.mergedManifestInfoToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[MergedManifestInfoToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/model/MergedManifestInfoToken.java) |
| [com.android.tools.idea.projectsystem.ApplicationProjectContextProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.projectsystem.ApplicationProjectContextProvider)      |[ApplicationProjectContextProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/ApplicationProjectContext.kt) |
| [com.android.tools.idea.projectsystem.androidIconProviderProjectToken](https://jb.gg/ipe?extensions=com.android.tools.idea.projectsystem.androidIconProviderProjectToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidIconProviderProjectToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/AndroidIconProviderProjectToken.kt) |
| [com.android.tools.idea.projectsystem.dynamicAppFeatureOnFeatureToken](https://jb.gg/ipe?extensions=com.android.tools.idea.projectsystem.dynamicAppFeatureOnFeatureToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DynamicAppFeatureOnFeatureToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/DynamicAppFeatureOnFeatureToken.kt) |
| [com.android.tools.idea.projectsystem.findDependenciesWithResourcesToken](https://jb.gg/ipe?extensions=com.android.tools.idea.projectsystem.findDependenciesWithResourcesToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[FindDependenciesWithResourcesToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/FindDependenciesWithResourcesToken.kt) |
| [com.android.tools.idea.projectsystem.libraryDependenciesTroubleInfoCollectorToken](https://jb.gg/ipe?extensions=com.android.tools.idea.projectsystem.libraryDependenciesTroubleInfoCollectorToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[LibraryDependenciesTroubleInfoCollectorToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/LibraryDependenciesTroubleInfoCollectorToken.kt) |
| [com.android.tools.idea.projectsystem.pseudoLocalesToken](https://jb.gg/ipe?extensions=com.android.tools.idea.projectsystem.pseudoLocalesToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[PseudoLocalesToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/com/android/tools/idea/projectsystem/PseudoLocalesToken.kt) |
| [org.jetbrains.android.facet.resourceFolderManagerToken](https://jb.gg/ipe?extensions=org.jetbrains.android.facet.resourceFolderManagerToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ResourceFolderManagerToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/project-system/src/org/jetbrains/android/facet/ResourceFolderManagerToken.kt) |

### resources-explorer.xml

[resources-explorer.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/resources/com/android/tools/idea/ui/resourcemanager/META-INF/resources-explorer.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.resourceImporter](https://jb.gg/ipe?extensions=com.android.resourceImporter)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[ResourceImporter](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/ui/resourcemanager/plugin/ResourceImporter.kt) |
| [com.android.resourceViewer](https://jb.gg/ipe?extensions=com.android.resourceViewer)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[DesignAssetRenderer](https://github.com/JetBrains/android/tree/idea/262.8665.258/android/src/com/android/tools/idea/ui/resourcemanager/plugin/DesignAssetRenderer.kt) |

### safeargs.common.xml

[safeargs.common.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/nav/safeargs/common/resources/META-INF/safeargs.common.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.nav.safeargs.module.safeArgsModeToken](https://jb.gg/ipe?extensions=com.android.tools.idea.nav.safeargs.module.safeArgsModeToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[SafeArgsModeToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/nav/safeargs/common/src/com/android/tools/idea/nav/safeargs/module/SafeArgsModeModuleService.kt) |

### server-flags.xml

[server-flags.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/server-flags/resources/META-INF/server-flags.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.mendelFlagsProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.mendelFlagsProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[MendelFlagsProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/server-flags/src/com/android/tools/idea/mendel/MendelFlagsProvider.kt) |

### testartifacts.xml

[testartifacts.xml](https://github.com/JetBrains/android/tree/idea/262.8665.258/testartifacts/resources/META-INF/testartifacts.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.android.tools.idea.testartifacts.instrumented.androidRunConfigurationToken](https://jb.gg/ipe?extensions=com.android.tools.idea.testartifacts.instrumented.androidRunConfigurationToken)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidRunConfigurationToken](https://github.com/JetBrains/android/tree/idea/262.8665.258/testartifacts/src/com/android/tools/idea/testartifacts/instrumented/AndroidRunConfigurationToken.kt) |
| [com.android.tools.idea.testartifacts.instrumented.testsuite.AndroidTestSuiteActionProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.testartifacts.instrumented.testsuite.AndroidTestSuiteActionProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[AndroidTestSuiteDetailsActionProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/testartifacts/src/com/android/tools/idea/testartifacts/instrumented/testsuite/actions/AndroidTestSuiteDetailsActionProvider.kt) |
| [com.android.tools.idea.testartifacts.instrumented.testsuite.api.testResultsPsiElementProvider](https://jb.gg/ipe?extensions=com.android.tools.idea.testartifacts.instrumented.testsuite.api.testResultsPsiElementProvider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[TestResultsPsiElementProvider](https://github.com/JetBrains/android/tree/idea/262.8665.258/testartifacts/src/com/android/tools/idea/testartifacts/instrumented/testsuite/api/TestResultsPsiElementProvider.kt) |

