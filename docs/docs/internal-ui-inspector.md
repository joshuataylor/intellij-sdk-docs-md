# Internal Actions – UI Inspector

The UI Inspector is a tool to interrogate elements of the IDE's UI to get an internal description of each element.

Tip:

If the menu item `Tools | Internal Actions` is not available in the IDE, then the first step is [Enabling Internal Mode](enabling-internal.html).

## Using the UI Inspector

Centering the cursor on a UI element and pressing `Ctrl+Alt` (`Ctrl+Option` on macOS) when clicking the left mouse button reveals the properties of the Swing component.

For example, to get information about the Build Project button's "hammer" icon on the toolbar (highlighted in green), put the mouse cursor on the icon and press `Ctrl/Cmd+Alt` while clicking the mouse.

The UI Inspector displays the icon details:

![Internal Icon Info](images/internal_ui_inspector_icon_info.png)

## 

`added-at` Property

Sometimes, inspecting a complex component's properties is not enough to understand how the component was created and configured.
UI Inspector gives the possibility of finding the code where the selected component was added, which makes it much easier to understand which APIs can be used to build custom components with similar complexity.

To find the place where the component was added, select the added-at property to show the stack trace:

![added-at stack trace](images/internal_ui_inspector_added_at.png)

## Specific Component Properties

Various components used in the IntelliJ Platform expose additional properties.
These can be useful to locate the underlying implementation, related Action, and so on.

Custom Swing components can also provide additional properties via [UiInspectorContextProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-api/src/com/intellij/internal/inspector/UiInspectorContextProvider.java) or its dedicated subclasses.

### Editor

| Type |Properties |
--------------------
| [ActiveGutterRenderer](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/openapi/editor/markup/ActiveGutterRenderer.java) (2023.1+)   |Clicked Renderer (Class) - `ActiveGutterRenderer` instance/class   |
| [GutterIconRenderer](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/openapi/editor/markup/GutterIconRenderer.java) (2023.1+)   |Clicked Renderer (Class) - `GutterIconRenderer` instance/class  Accessible Name - `GutterIconRenderer.getAccessibleName()`  Icon - `GutterIconRenderer.getIcon()`  Marker Info - Element / Navigation Handler - [LineMarkerInfo.getElement() / getNavigationHandler()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-api/src/com/intellij/codeInsight/daemon/LineMarkerInfo.java)   |
| [GutterMark](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/codeInsight/daemon/GutterMark.java) |gutter renderer - [GutterMark](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/codeInsight/daemon/GutterMark.java) implementation   |
| [Inlay](inlay-hints.html) (2023.1+)   |Inlay Renderer (Class) - `Inlay.getRenderer()` instance/class  Inlay Gutter Renderer - `Inlay.getGutterIconRenderer()`  Inlay Properties - `Inlay.getProperties()`   |
| [IntentionAction/QuickFix](code-inspections-and-intentions.html) |intention action/quick fix - [IntentionAction](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-api/src/com/intellij/codeInsight/intention/IntentionAction.java) / [QuickFix](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-api/src/com/intellij/codeInspection/QuickFix.java) implementation   |

### Action

| Type |Properties |
--------------------
| [AnAction](action-system.html) |Action - [AnAction](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/AnAction.java) implementation  Action ID - Action `id`  Action Plugin ID - contributing plugin   |
| [ActionToolbar](action-system.html) |Toolbar Group - Action Group ID  All Toolbar Groups - contained Action Group IDs  Target component - `ActionToolbar.setTargetComponent()`   |

### IDE and UI Components

| Type |Properties |
--------------------
| [DialogWrapper](dialog-wrapper.html) |dialogWrapperClass - [DialogWrapper](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-api/src/com/intellij/openapi/ui/DialogWrapper.java) implementation |
| [ToolWindow](tool-windows.html) |Tool Window ID - `id`  Tool Window Icon - `icon`  Tool Window Factory - [ToolWindowFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-api/src/com/intellij/openapi/wm/ToolWindowFactory.kt)   |
| [Tree](lists-and-trees.html) |treeModelClass - `javax.swing.tree.TreeModel` implementation |

## Inspecting Settings

Enable `Internal Actions | UI | Debugging Info in UI` (2024.2+)
(`View | Appearance | Details in Tree View` in earlier versions)
in [Internal Mode](enabling-internal.html) to show Settings page `id` in the tree.

Some additional properties are available when inspecting the Settings dialog (2023.1+).

Tip:

UI Inspector must be invoked only after opening the Settings dialog.

| Settings page  Reference   |Properties |
------------------------------------------
| All settings  [Settings Guide](settings-guide.html)   |Configurable class - [Configurable](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/ide-core/src/com/intellij/openapi/options/Configurable.java) class  Configurable ID - `id` attribute  Configurable weight - `groupWeight` attribute   |
| `Editor \| Color Scheme`  [Text Attributes Key](syntax-highlighting-and-error-highlighting.html#text-attributes-key)   |Text Attributes Key - [TextAttributesKey](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/editor/colors/TextAttributesKey.java) external name   |
| `Editor \| File Types`  [Registering a File Type](registering-file-type.html)   |FileTypeID - `FileType.getName()`  FileType Class - [FileType](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/fileTypes/FileType.java) implementation   |
| `Editor \| Inspections`  [Code Inspections](code-inspections.html)   |Inspection key - Inspection `id`  Inspection tool class - Inspection implementation   |
| `Editor \| Inlays`  [Inlay Hints](inlay-hints.html)   |Inlay Group Key - [InlayGroupSettingProvider.getGroup().key](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-api/src/com/intellij/codeInsight/hints/settings/InlayGroupSettingProvider.kt)  Inlay Group Key - [InlayGroup.key](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-api/src/com/intellij/codeInsight/hints/InlayHintsProvider.kt)  Inlay Provider Model ID - [InlayProviderSettingsModel.id](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-api/src/com/intellij/codeInsight/hints/settings/InlayProviderSettingsModel.kt)  Inlay ImmediateConfigurable ID - [ImmediateConfigurable.Case.id](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-api/src/com/intellij/codeInsight/hints/InlayHintsProvider.kt)   |
| `Editor \| Intentions`  [Intentions](code-intentions.html)   |Intention Class - [IntentionAction](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/analysis-api/src/com/intellij/codeInsight/intention/IntentionAction.java) class  Intention description directory - `<descriptionDirectoryName>`   |
| `Plugins`  [Plugin Configuration File](plugin-configuration-file.html)   |Plugin ID - Plugin `<id>`  Plugin Dependencies - IDs of dependent plugins   |

## Accessibility Checks

Since 2025.2, the UI Inspector includes the Show Accessibility Issues button that enables inspections for common accessibility problems, similar to browser tools like Google Chrome Lighthouse or apps like Accessibility Insights for Windows.
These issues are usually invisible in the UI, but they can still prevent users who rely on assistive technologies like screen readers or voice control from interacting with the UI.

For each problem, the affected value in the Properties table contains a description that explains what it affects and how to fix it.

![Accessibility Checks](images/internal_ui_inspector_accessibility_checks.png)
Tip:

Refer to the [accessibility guidelines](accessibility.html) to learn more about accessibility best practices.

