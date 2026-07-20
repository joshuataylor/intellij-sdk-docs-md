# Kotlin Notebook Integration

<tldr>
GitHub: [Kotlin Notebook IntelliJ Platform](https://github.com/Kotlin/kotlin-notebook-intellij-platform)

Examples: [Kotlin Notebook IntelliJ Platform examples](https://github.com/Kotlin/kotlin-notebook-intellij-platform/tree/master/examples)

JetBrains Platform Forum: [Kotlin Notebook](https://platform.jetbrains.com/c/intellij-platform/kotlin-notebook/25) category
</tldr>

Warning:

Kotlin Notebook is being sunset starting from IntelliJ IDEA 2026.2.
See the [blog post](https://blog.jetbrains.com/idea/2026/06/kotlin-notebook-sunset/) for more details.

The Kotlin Notebook IntelliJ Platform integration enables interactive development and experimentation with IntelliJ Platform APIs directly within a notebook environment. This integration allows developers to run IntelliJ Platform code within the active IDE runtime, removing traditional barriers associated with plugin project setup, compilation, and deployment.

Like Jupyter Notebooks, Kotlin Notebook provides an interactive platform for prototyping, testing, and exploring IntelliJ Platform functionality through executable code cells.

## Getting Started

To begin using the IntelliJ Platform integration:

Procedure:

Once executed, the necessary IntelliJ Platform libraries are loaded into the Kotlin Notebook classpath, making them available for import in subsequent cells.

## Core Features

### UI Rendering

The integration enables direct rendering of UI components within notebook cells. When working with [Kotlin UI DSL](kotlin-ui-dsl-version-2.html) or standard Swing components, returning them as a response causes immediate rendering with full interactivity.

```KOTLIN
import com.intellij.ui.dsl.builder.panel
import java.awt.Dimension

panel {
  row {
    checkBox("Check me!")
  }
}.apply {
  size = Dimension(500, 200)
}
```

Use the `runInEdt` helper to ensure code execution on the [Event Dispatch Thread (EDT)](threading-model.html) and handle exceptions gracefully:

```KOTLIN
runInEdt {
    // UI code that must run on EDT
}
```

### Resource Management

The integration provides automatic resource management through the IntelliJ Platform's [Disposer](disposers.html) mechanism. A dedicated `notebookDisposable` variable allows registration of elements that need cleanup:

```KOTLIN
Disposer.register(notebookDisposable, myDisposable)

Disposer.register(notebookDisposable) {
  // ...
}
```

### Plugin Loading

By default, only the core IntelliJ Platform is loaded into the classpath. To use other plugins (bundled or installed), explicitly load them using:

```KOTLIN
loadPlugins("Git4Idea", "com.intellij.java")
```

### Extension Registration

Unlike traditional plugin development with `plugin.xml`, the integration provides programmatic extension registration:

```KOTLIN
registerExtension(extensionPointName, instance)
```

## Global Variables

When the IntelliJ Platform integration is loaded, the following variables are automatically available in your Kotlin Notebook environment.
These variables provide access to essential IDE components, configuration information, and management interfaces.

| Variable |Type |Description |
-------------------------------
| `idePath` |`Path` |Represents the resolved file system path to the IntelliJ Platform installation directory. |
| `ide` |[ProductInfoBasedIde](https://github.com/JetBrains/intellij-plugin-verifier/tree/1.409/intellij-plugin-structure/structure-ide/src/main/java/com/jetbrains/plugin/structure/ide/ProductInfoBasedIde.kt) |Represents an IDE instance, which allows interacting with plugins and resolving their dependencies based on the IDE's configuration. |
| `notebookDisposable` |[Disposable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/src/com/intellij/openapi/Disposable.java) |Represents a disposable used for managing the IntelliJ Platform lifetime of the current notebook. |
| `notebookPluginDescriptor` |[PluginMainDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-impl/src/com/intellij/ide/plugins/IdeaPluginDescriptorImpl.kt) |Represents a plugin descriptor for the plugin created with Kotlin Notebook IntelliJ Platform integration. |
| `pluginManager` |[PluginManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-impl/src/com/intellij/ide/plugins/PluginManager.java) |Instance of the `PluginManager`, which allows accessing information about plugins and their states in the current IDE environment. |
| `pluginRepository` |[PluginRepository](https://github.com/JetBrains/intellij-plugin-verifier/tree/1.409/intellij-plugin-verifier/verifier-repository/src/main/java/com/jetbrains/pluginverifier/repository/PluginRepository.kt) |Instance of `PluginRepository`, responsible for managing plugins via the JetBrains Marketplace plugin repository. |
| `productInfo` |[ProductInfo](https://github.com/JetBrains/intellij-plugin-verifier/tree/1.409/intellij-plugin-structure/structure-intellij/src/main/java/com/jetbrains/plugin/structure/intellij/platform/ProductInfo.kt) |Lazily initialized property containing current IntelliJ Platform product information. |

## Notebook Helpers

| Function |Description |
-------------------------
| `error(message: String)` |Throws an exception with the specified message, which will be printed as the cell's output. |
| `loadPlugins(vararg pluginIds: String)` |Loads plugins installed in the current IDE into the script context based on their plugin IDs. This method also supports optionally loading plugin classes and class loaders. |
| `runInEdt(block: () -> Unit)` |Runs the given block in the [Event Dispatch Thread (EDT)](threading-model.html). If an exception is thrown, it is displayed in the cell's output. |

## IntelliJ Platform Helpers

| Function |Description |
-------------------------
| `currentProject()` |Returns the current open [Project](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/project/Project.java) instance. |
| `currentEditor()` |Returns the current [FileEditor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/editor-ui-api/src/com/intellij/openapi/fileEditor/FileEditor.java) instance or null if no editor is open. |
| `registerExtension(extensionPointName: ExtensionPointName<T>, instance: T)` |Registers an extension programmatically for the given extension point. |
| `registerExtension(extensionPointName: String, instance: T)` |Registers an extension programmatically for the given extension point. |

## Examples

Note:

See [Kotlin Notebook IntelliJ Platform](https://github.com/Kotlin/kotlin-notebook-intellij-platform/tree/master/examples) project repository for more examples.

### Accessing IDE Information

```KOTLIN
println("IDE: ${productInfo.name}")
println("Version: ${productInfo.version}")
println("Build: ${productInfo.buildNumber}")
```

### Loading and Using Plugins

```KOTLIN
loadPlugins("com.intellij.gradle")
```

```KOTLIN
import com.intellij.gradle.toolingExtension.util.GradleVersionUtil

GradleVersionUtil.isCurrentGradleAtLeast("8.13.0")
```

### Registering Extension

```KOTLIN
import com.intellij.codeInsight.editorActions.CopyPastePreProcessor
import com.intellij.openapi.editor.Editor
import com.intellij.openapi.editor.RawText
import com.intellij.openapi.project.Project
import com.intellij.psi.PsiFile

class MyCopyPastePreProcessor : CopyPastePreProcessor {
  override fun preprocessOnCopy(
    file: PsiFile?,
    startOffsets: IntArray?,
    endOffsets: IntArray?,
    text: String?,
  ) = null

  override fun preprocessOnPaste(
    project: Project?,
    file: PsiFile?,
    editor: Editor?,
    text: String?,
    rawText: RawText?,
  ) = "Hello, World!"
}

registerExtension(CopyPastePreProcessor.EP_NAME, MyCopyPastePreProcessor())
```

### Rendering Kotlin UI DSL Components

```KOTLIN
import com.intellij.ui.dsl.builder.panel
import java.awt.Dimension

panel {
  row {
    checkBox("Check me!")
      .comment("A comment for this checkbox")
  }
}.apply {
  size = Dimension(500, 200)
}
```

### Rendering Dialog

```KOTLIN
import com.intellij.openapi.ui.Messages

runInEdt {
  Messages.showMessageDialog(
    null,
    "This is a modal dialog message",
    "Dialog Title",
    Messages.getInformationIcon()
  )
}
```

### Creating Disposable Tool Window

```KOTLIN
import com.intellij.icons.AllIcons
import com.intellij.openapi.application.runInEdt
import com.intellij.openapi.util.Disposer
import com.intellij.openapi.wm.ToolWindowManager

val project = currentProject()
val toolWindowManager = ToolWindowManager.getInstance(project)

runInEdt {
  val toolWindow = toolWindowManager.getToolWindow("My Tool Window")
    ?: toolWindowManager.registerToolWindow("My Tool Window") {
      icon = AllIcons.General.Error
    }

  Disposer.register(notebookDisposable) {
    toolWindow.remove()
  }
}
```

