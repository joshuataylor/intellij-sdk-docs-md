# Internal API Migration

Tip:

How to address the private API usage violations:

1. Look through the suggested replacements below, update the plugin accordingly, and upload a new version to JetBrains Marketplace.

2. For help with the replacements, please [create a YouTrack issue](https://youtrack.jetbrains.com/newIssue?project=IJPL&c=Type%20Task&c=Subsystem%20Internal%20API).
Please note that JetBrains may not be able to provide a replacement quickly, and in some cases, a replacement might not be available at all.

3. For any other issues or questions related to the Internal API usage, please [create a dedicated YouTrack issue](https://youtrack.jetbrains.com/newIssue?project=IJPL&c=Type%20Task&c=Subsystem%20Internal%20API).

This page lists commonly used API annotated with [@ApiStatus.Internal](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java),
which indicates it is private API and must not be used outside of IntelliJ Platform itself:

Tip: ApiStatus.Internal Javadoc

Indicates that the annotated element (class, method, field, etc.) must not be considered as a public API. It's made visible to allow
usages in other packages of the declaring library, but it must not be used outside of that library. Such elements
may be renamed, changed, or removed in future versions.

Such violations are reported from [Plugin Verifier](verifying-plugin-compatibility.html#plugin-verifier) and are highlighted in the IDE using a [dedicated inspection](verifying-plugin-compatibility.html#ide-support).

Each entry is mapped to its corresponding Replacement, pointing to the recommended API.

Note:

The lists are not complete and will be updated continuously.

Check the corresponding code documentation when encountering any API not listed on this page.
In some cases, such documentation might not be available inside the IDE for the current target platform version.
Use Go to file to browse the latest version in the [intellij-community](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/) GitHub repository instead.

Use the Feedback widget displayed on the right to report missing or unclear information.

## IntelliJ Platform

| Internal API |Replacement |
-----------------------------
| `AnAction.applyTextOverride()` |[override-text](plugin-configuration-file.html#idea-plugin__actions__action__override-text) |
| `ApplicationLoadListener` |See [Application Startup](plugin-components.html#application-startup) |
| `BuildNumber.currentVersion()` |Use `ApplicationInfo.getBuild()` |
| `CompactVirtualFileSet` |Use `VfsUtilCore.createCompactVirtualFileSet()` |
| `DefaultPicoContainer` |Use [extension points](plugin-extensions.html) and [services](plugin-services.html) |
| `ExperimentalUI.isNewUI()` |Use [NewUI.isEnabled()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/NewUI.java) |
| `FileTypeIndex.NAME` |Use static methods in `FileTypeIndex` directly |
| `IElementType.getDebugName()` |Override/use `IElementType.toString()` |
| `IconLoader.CachedImageIcon` |Use methods exposed in `IconLoader` |
| `IconLoader.LazyIcon` |Use `IconLoader.createLazy()` |
| `IndexingDataKeys` |[See Doc](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-impl/src/com/intellij/util/indexing/IndexingDataKeys.java) |
| `Module.getModuleFile()` |[See Doc](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/module/Module.java) |
| `Module.getModuleFilePath()` |[See Doc](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/module/Module.java) |
| `Module.getModuleTypeName()` |[See Doc](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/module/Module.java) |
| `ModuleTypeManager.registerModuleType()` |Use [com.intellij.moduleType](https://jb.gg/ipe?extensions=com.intellij.moduleType) extension point      instead. [ModuleType](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-core/src/com/intellij/openapi/module/ModuleType.java) |
| `PathMacros.setMacro()` |Use [com.intellij.pathMacroContributor](https://jb.gg/ipe?extensions=com.intellij.pathMacroContributor) extension point     . [PathMacroContributor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/application/PathMacroContributor.java) |
| `PlatformUtils` |[See Doc](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/util/PlatformUtils.java) |
| `PluginClassLoader` |Cast to [PluginAwareClassLoader](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/extensions/src/com/intellij/ide/plugins/cl/PluginAwareClassLoader.java) |
| `PluginManager.getLogger()` |Use own logger, see [Logging](ide-infrastructure.html#logging) |
| `PreloadingActivity` |Use `StartupActivity.Background` ([docs](plugin-components.html#project-open)) with atomic flag to run only once during IDE lifetime |
| `ProjectLibraryTable` |Use `LibraryTablesRegistrar.getLibraryTable()` |
| `SVGLoader` |Use `ImageLoader.loadFromResource()` |
| `ScrollBarPainter` |[See Doc](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/components/ScrollBarPainter.java) |
| `ToolWindowManager.registerToolWindow(String, RegisterToolWindowTaskBuilder)` |[False positive](https://youtrack.jetbrains.com/issue/MP-6705) from [Plugin Verifier](verifying-plugin-compatibility.html) |
| `UtilKt.targetPresentation()` |[See Doc](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/codeInsight/navigation/util.kt) |
| `TextEditorCustomizer` |Use [com.intellij.editorFactoryListener](https://jb.gg/ipe?extensions=com.intellij.editorFactoryListener) extension point      and customize editor in [EditorFactoryListener.editorCreated()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/editor-ui-api/src/com/intellij/openapi/editor/event/EditorFactoryListener.java). Get the editor instance with `TextEditorProvider.getTextEditor()` passing `event.editor`. |

## Plugins

### Database Plugin

| Internal API |Replacement |
-----------------------------
| `DbDataSource.getDelegate()` |For connection config use `DbDataSource.getConnectionConfig()`, for `LocalDataSource` use `DbImplUtil.getMaybeLocalDataSource(DasDataSource)` |

## Exceptions

The API listed in this table is currently (or was previously) marked with `@ApiStatus.Internal`, but its status has changed in the meantime (or will change).
Therefore, any reported violations can be disregarded.

| Internal API |Note |
----------------------
| [AnAction.setShortcutSet()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/AnAction.java) |Made public in 2023.3 |
| [AnimatedIcon.ANIMATION_IN_RENDERER_ALLOWED](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/ide-core/src/com/intellij/ui/AnimatedIcon.java) |Made public in 2021.3 |
| [BaseExpirableExecutor.expireWith()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/openapi/application/BaseExpirableExecutor.java) |Made public in 2023.2 |
| [BundleBase](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/BundleBase.kt) |Made public in 2022.1 |
| [CodeVisionPlaceholderCollector](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/codeInsight/codeVision/CodeVisionPlaceholderCollector.kt) |Made public in 2024.2 |
| [IdFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/indexing-api/src/com/intellij/util/indexing/IdFilter.java) |Made public in 2021.2/3 |
| [HashingStrategy](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/base/src/com/intellij/util/containers/HashingStrategy.java) |Made public in 2023.1 |
| [JsonCustomStructureViewFactory](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/json/backend/src/com/intellij/json/structureView/JsonCustomStructureViewFactory.java) |Made public in 2023.2 |
| [RunAnythingCommandLineProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/execution-impl/src/com/intellij/ide/actions/runAnything/activity/RunAnythingCommandLineProvider.kt) |Made public in 2021.3 |
| [SearchEverywhereFoundElementInfo](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-api/src/com/intellij/ide/actions/searcheverywhere/SearchEverywhereFoundElementInfo.java) |Made public in 2023.3 |
| `PhpExpectedFunctionArgument` |Made public in 2022.1 |
| `org.jetbrains.yaml.meta.*` |YAML Metadata API will be made public in 2023.1 |

Note:

The lists are not complete and will be updated continuously.

Check the corresponding code documentation when encountering any API not listed on this page.
In some cases, such documentation might not be available inside the IDE for the current target platform version.
Use Go to file to browse the latest version in the [intellij-community](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/) GitHub repository instead.

Use the Feedback widget displayed on the right to report missing or unclear information.

