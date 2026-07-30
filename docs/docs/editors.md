# Editors

<tldr>
Product Help: [Editor basics](https://www.jetbrains.com/help/idea/using-code-editor.html)
</tldr>

This section covers working with text in the IntelliJ Platform editor:

* Tutorial: [Basics of Working with the Editor](editor-basics.html) * [1. Working with Text](working-with-text.html) * [2. Editor Coordinates System. Positions and Offsets](coordinates-system.html) * [3. Handling Editor Events](editor-events.html)

* [Text Selection](text-selection.html)

* [Multiple Carets](multiple-carets.html)

## Editors FAQ

### How do I get the active editor instance?

| Context |API |
----------------
| Generic |[FileEditorManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/openapi/fileEditor/FileEditorManager.java) |
| [Action](action-system.html) |[CommonDataKeys.EDITOR](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/openapi/actionSystem/CommonDataKeys.java) |
| [PSI Elements](psi-elements.html) |[PsiEditorUtil.findEditor()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/editor-ui-api/src/com/intellij/psi/util/PsiEditorUtil.java) |

### How can I be notified about editor events?

Use project-level listener [FileEditorManagerListener](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/openapi/fileEditor/FileEditorManagerListener.java)
or [FileEditorManagerListener$Before](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/openapi/fileEditor/FileEditorManagerListener.java)
to be notified about all file open/closed/selection changed events.

### How can I set a custom editor tab name and tooltip?

[EditorTabTitleProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core-impl/src/com/intellij/openapi/fileEditor/impl/EditorTabTitleProvider.kt) registered in [com.intellij.editorTabTitleProvider](https://jb.gg/ipe?extensions=com.intellij.editorTabTitleProvider) extension point
allows
for specifying custom names and tooltips displayed in the title of editor tabs.
If access to indexes is not required, it can be marked [dumb aware](indexing-and-psi-stubs.html#DumbAwareAPI).

### How can I set a custom editor tab background color?

[EditorTabColorProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/ide-core-impl/src/com/intellij/openapi/fileEditor/impl/EditorTabColorProvider.java) registered in [com.intellij.editorTabColorProvider](https://jb.gg/ipe?extensions=com.intellij.editorTabColorProvider) extension point
allows
for the modification of the background color for specific files.
If access to indexes is not required, it can be marked [dumb aware](indexing-and-psi-stubs.html#DumbAwareAPI).

### How do I open a text editor for a "fake" file?

Create a [LightVirtualFile](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/testFramework/LightVirtualFile.java) with the contents
and open it via [FileEditorManager.openFile()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/openapi/fileEditor/FileEditorManager.java).

