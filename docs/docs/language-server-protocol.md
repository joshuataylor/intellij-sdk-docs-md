# Language Server Protocol (LSP)

The [Language Server Protocol](https://microsoft.github.io/language-server-protocol/) (LSP) is an open-standard protocol developed by Microsoft. It enables communication between development tools and Language Servers.
Language Servers can provide language-specific features such as code completion, documentation, and formatting, which is far easier than implementing language support from scratch.
It also reduces the need for constant maintenance and tracking of changes in relevant languages and tools, making it easier to bring consistent language support to various development environments.

However, the canonical [Custom Language Support](custom-language-support.html) provided by IntelliJ Platform still offers a wider range of integration with IDE features than handling and presenting data provided by a Language Server.
Therefore, the LSP approach shouldn't be considered as a replacement for the existing language API, but rather as an added value.

[Video](https://www.youtube.com/v/N4bkzOqxI4E)

Gain insights into the Language Server Protocol (LSP) and its capabilities while exploring the implementation journey of the
[Contextive plugin](https://plugins.jetbrains.com/plugin/23928-contextive/),
designed to document and utilize domain terminology within codebases.
Chris Simon shares the challenges faced and offers practical tips for aspiring LSP developers.

## Supported IDEs

The integration with the Language Server Protocol is created as an extension to the commercial IntelliJ-based IDEs.
Therefore, plugins using Language Server integration are not available in
[IntelliJ IDEA](idea.html) open source builds and [Android Studio](android-studio.html) from Google.

The LSP API is publicly available as part of the IntelliJ Platform in the following IDEs:
IntelliJ IDEA, WebStorm, PhpStorm, PyCharm, DataSpell, RubyMine, CLion, DataGrip, GoLand, Rider, and RustRover.

Since 2025.1, it is also supported in unified [PyCharm without Pro subscription](https://blog.jetbrains.com/pycharm/2025/04/unified-pycharm/).

## LSP Plugin Setup

The plugin must target [IntelliJ IDEA Plugin Development](idea.html) version `2023.2` or later.

### Gradle Build Script

IntelliJ Platform Gradle Plugin (2.x):

Relevant `build.gradle.kts` configuration:

```KOTLIN
plugins {
  id("org.jetbrains.intellij.platform") version "2.20.1"
}

repositories {
  mavenCentral()

  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    intellijIdea("2026.3")
  }
}
```

Gradle IntelliJ Plugin (1.x):

Upgrade the Gradle IntelliJ Plugin to the latest version.
It will attach the LSP API sources and code documentation to the project.

Relevant `build.gradle.kts` configuration:

```KOTLIN
plugins {
  // ...
  id("org.jetbrains.intellij") version "1.17.4"
}

intellij {
  version = "2026.3"
  type = "IU"
}
```

For projects based on the [IntelliJ Platform Plugin Template](https://github.com/JetBrains/intellij-platform-plugin-template), update the Gradle IntelliJ Plugin to the latest version,
and amend the values in `gradle.properties` accordingly.

### plugin.xml

2025.2.1+:

The `plugin.xml` configuration file must specify the dependency on the LSP module:

```XML

<idea-plugin>
  <!-- ... -->
  <depends>com.intellij.modules.lsp</depends>
</idea-plugin>
```

Pre-2025.2.1:

The `plugin.xml` configuration file must specify the dependency on the IntelliJ Platform Ultimate module:

```XML

<idea-plugin>
  <!-- ... -->
  <depends>com.intellij.modules.ultimate</depends>
</idea-plugin>
```

### IDE Setup

Since 2024.2, LSP API sources are provided with the `IntelliJ IDEA sources` artifact.
See [Attaching Sources in the IDE](tools-intellij-platform-gradle-plugin.html#attaching-sources-in-the-ide) on how to enable downloading sources.
Then, use `Navigate | Class...` to open the `LspServerState` class.
In the opened editor, invoke Download IntelliJ Platform sources to download and attach sources.

#### Earlier IDE Versions

The LSP API sources are bundled in the IntelliJ IDEA distribution and can be found within the `$IDEA_INSTALLATION$/lib/src/src_lsp-openapi.zip` archive.

Note: Attaching Sources in IDE before 2024.1

Due to technical limitations in IDEs before 2024.1, it is necessary to manually attach sources to the IntelliJ IDEA Ultimate dependency.
To do so, when reviewing the compiled class which belongs to the LSP API, run the Choose Sources... action, and point to the
`$IDEA_INSTALLATION$/lib/src/src_lsp-openapi.zip` file.

## Supported Features

The LSP support provided by the IntelliJ Platform covers the following features for these releases:

### 2026.1

* Range Formatting ([textDocument/rangeFormatting](https://microsoft.github.io/language-server-protocol/specification/#textDocument_rangeFormatting)) ([IJPL-189558](https://youtrack.jetbrains.com/issue/IJPL-189558))

* Code Lens ([textDocument/codeLens](https://microsoft.github.io/language-server-protocol/specification/#textDocument_codeLens)) ([IJPL-189563](https://youtrack.jetbrains.com/issue/IJPL-189563))

* Optimize Imports ([textDocument/codeAction](https://microsoft.github.io/language-server-protocol/specification/#textDocument_codeAction) with `source.organizeImports`) ([IJPL-198789](https://youtrack.jetbrains.com/issue/IJPL-198789))

* Rename Refactoring ([textDocument/rename](https://microsoft.github.io/language-server-protocol/specification/#textDocument_rename)) [2026.1.1] ([IJPL-161013](https://youtrack.jetbrains.com/issue/IJPL-161013))

* On-Type Formatting ([textDocument/onTypeFormatting](https://microsoft.github.io/language-server-protocol/specification/#textDocument_onTypeFormatting)) [2026.1.2] (disabled by default) ([IJPL-189559](https://youtrack.jetbrains.com/issue/IJPL-189559))

Note:

All the above features are enabled by default and can be controlled via [LspClientDescriptor.lspCustomization](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspClientDescriptor.kt) (since 2026.1.4), or [LspServerDescriptor.lspCustomization](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspServerDescriptor.kt)` (before 2026.1.4).
See the [Customization](#customization) section for details.

### 2025.3

* Server Initiated Progress ([$/progress](https://microsoft.github.io/language-server-protocol/specification/#progress))

* Highlight Usages In File ([textDocument/documentHighlight](https://microsoft.github.io/language-server-protocol/specification/#textDocument_documentHighlight))

* Go To Symbol ([workspace/symbol](https://microsoft.github.io/language-server-protocol/specification/#workspace_symbol))

* File Structure / Structure ([textDocument/documentSymbol](https://microsoft.github.io/language-server-protocol/specification/#textDocument_documentSymbol))

* Breadcrumbs ([textDocument/documentSymbol](https://microsoft.github.io/language-server-protocol/specification/#textDocument_documentSymbol))

* Sticky Lines ([textDocument/documentSymbol](https://microsoft.github.io/language-server-protocol/specification/#textDocument_documentSymbol))

* Parameter Info ([textDocument/signatureHelp](https://microsoft.github.io/language-server-protocol/specification/#textDocument_signatureHelp))

* Extend Selection / Shrink Selection ([textDocument/selectionRange](https://microsoft.github.io/language-server-protocol/specification/#textDocument_selectionRange)) [2025.3.1] ([IJPL-216845](https://youtrack.jetbrains.com/issue/IJPL-216845))

* Call Hierarchy ([textDocument/prepareCallHierarchy](https://microsoft.github.io/language-server-protocol/specification/#textDocument_prepareCallHierarchy), [callHierarchy/incomingCalls](https://microsoft.github.io/language-server-protocol/specification/#callHierarchy_incomingCalls), [callHierarchy/outgoingCalls](https://microsoft.github.io/language-server-protocol/specification/#callHierarchy_outgoingCalls)) [2025.3.1] ([IJPL-210695](https://youtrack.jetbrains.com/issue/IJPL-210695))

* Type Hierarchy ([textDocument/prepareTypeHierarchy](https://microsoft.github.io/language-server-protocol/specification/#textDocument_prepareTypeHierarchy), [typeHierarchy/supertypes](https://microsoft.github.io/language-server-protocol/specification/#typeHierarchy_supertypes), [typeHierarchy/subtypes](https://microsoft.github.io/language-server-protocol/specification/#typeHierarchy_subtypes)) [2025.3.1] ([IJPL-216689](https://youtrack.jetbrains.com/issue/IJPL-216689))

### 2025.2

* Inlay Hints ([textDocument/inlayHint](https://microsoft.github.io/language-server-protocol/specification/#textDocument_inlayHint)) [2025.2.2]

* Folding Range ([textDocument/foldingRange](https://microsoft.github.io/language-server-protocol/specification/#textDocument_foldingRange)) [2025.2.2]

### 2025.1

* Document Link ([textDocument/documentLink](https://microsoft.github.io/language-server-protocol/specification/#textDocument_documentLink))

* Pull Diagnostics ([textDocument/diagnostic](https://microsoft.github.io/language-server-protocol/specifications/#diagnostic)) (enabled by default in 2025.2) [2025.1.2]

### 2024.3

* Color Preview ([textDocument/documentColor](https://microsoft.github.io/language-server-protocol/specification#textDocument_documentColor))

* Document Save Notification ([textDocument/didSave](https://microsoft.github.io/language-server-protocol/specification/#textDocument_didSave)) [2024.3.1]

* Go To Type Declaration ([textDocument/typeDefinition](https://microsoft.github.io/language-server-protocol/specification/#textDocument_typeDefinition)) [2024.3.1]

### 2024.2

* Find Usages ([textDocument/references](https://microsoft.github.io/language-server-protocol/specification#textDocument_references))

* Completion Item Resolve Request ([completionItem/resolve](https://microsoft.github.io/language-server-protocol/specification/#completionItem_resolve))

* Code Action Resolve Request ([codeAction/resolve](https://microsoft.github.io/language-server-protocol/specification/#codeAction_resolve))

* Semantic Highlighting ([textDocument/semanticTokens/full](https://microsoft.github.io/language-server-protocol/specification/#semanticTokens_fullRequest)) [2024.2.2]

### 2024.1

* Communication channel: Socket

* Execute a command ([workspace/executeCommand](https://microsoft.github.io/language-server-protocol/specification/#workspace_executeCommand))

* Apply a WorkspaceEdit ([workspace/applyEdit](https://microsoft.github.io/language-server-protocol/specification/#workspace_applyEdit))

* Show Document Request ([window/showDocument](https://microsoft.github.io/language-server-protocol/specification/#window_showDocument))

### 2023.3

* Intention actions ([textDocument/codeAction](https://microsoft.github.io/language-server-protocol/specification/#textDocument_codeAction))

* Code formatting ([textDocument/formatting](https://microsoft.github.io/language-server-protocol/specification/#textDocument_formatting))

* Request cancellation ([$/cancelRequest](https://microsoft.github.io/language-server-protocol/specification/#cancelRequest))

* Quick documentation ([textDocument/hover](https://microsoft.github.io/language-server-protocol/specification#textDocument_hover)) [2023.3.2]

* Client-side file watcher ([workspace/didChangeWatchedFiles](https://microsoft.github.io/language-server-protocol/specification#workspace_didChangeWatchedFiles)) [2023.3.2]

### 2023.2

* Communication channel: StdIO

* Errors and warnings highlighting ([textDocument/publishDiagnostics](https://microsoft.github.io/language-server-protocol/specification/#textDocument_publishDiagnostics))

* Quick-fixes for errors and warnings ([textDocument/codeAction](https://microsoft.github.io/language-server-protocol/specification/#textDocument_codeAction))

* Code completion ([textDocument/completion](https://microsoft.github.io/language-server-protocol/specification/#textDocument_completion))

* Go to Declaration ([textDocument/definition](https://microsoft.github.io/language-server-protocol/specification/#textDocument_definition))

## Basic Implementation

As a reference, check out the [Prisma ORM](https://plugins.jetbrains.com/plugin/20686-prisma-orm) open-source plugin implementation: [Prisma ORM LSP](https://github.com/JetBrains/intellij-plugins/tree/idea/263.7307.200/prisma/src/org/intellij/prisma/ide/lsp)

Tip:

The basic implementation differs between version 2026.1.4 and older because of [LSP API classes renaming](#lsp-api-refactoring).

Procedure: Minimal LSP Plugin Setup

### Status Bar Integration

A dedicated Language Services status bar widget is available to monitor the status of all LSP servers.

2026.1.4+:

Override [LspIntegrationProvider.createWidgetItem()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspIntegrationProvider.kt) to provide a custom icon and link to [the settings page](settings.html) (if available).

```KOTLIN
override fun createWidgetItem(
  lspClient: LspClient,
  currentFile: VirtualFile?
) =
  LspClientWidgetItem(
    lspClient, currentFile,
    FooIcons.PluginIcon, FooConfigurable::class.java
  )
```

Pre-2026.1.4:

Override [LspServerSupportProvider.createLspServerWidgetItem()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspServerSupportProvider.kt) to provide a custom icon and link to [the settings page](settings.html) (if available).

```KOTLIN
override fun createLspServerWidgetItem(
  lspServer: LspServer,
  currentFile: VirtualFile?
) =
  LspServerWidgetItem(
    lspServer, currentFile,
    FooIcons.PluginIcon, FooConfigurable::class.java
  )
```

If there are configuration problems preventing from starting an LSP server, the plugin can provide a widget item
with an error and give the user a hint how to fix the problem.

## Language Server Integration

Language Server is a separate process that analyzes source code and provides language-specific features to development tools.
When creating a plugin that uses LSP within the IDE, there are two possibilities for providing a Language Server to end-users:

* Bundle a [Language Server implementation](https://microsoft.github.io/language-server-protocol/implementors/servers/) binary as a resource delivered with a plugin.

* Provide a possibility for users to define the location of the Language Server binary in their environment.

The Prisma ORM plugin presents the first approach, which distributes the `prisma-language-server.js` script and uses a local Node.js interpreter to run it.

For more complex cases, the plugin may request to provide a detailed configuration with a dedicated [Settings](settings-guide.html) implementation.

## Customization

Note:

To access LSP API source code and documentation see [IDE Setup](#ide-setup).

2025.2+:

To fine-tune or disable the implementation of LSP-based features, plugins may return a customized [LspCustomization](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/customization/LspCustomization.kt) object from the `LspClientDescriptor.lspCustomization` (`LspServerDescriptor.lspCustomization` before 2026.1.4) property.
Available customization options are described by `LspCustomization`'s properties.

For example, see [PrismaLspClientDescriptor](https://github.com/JetBrains/intellij-plugins/tree/idea/263.7307.200/prisma/src/org/intellij/prisma/ide/lsp/PrismaLspClientDescriptor.kt).

The new API is backward-compatible.
Plugin LSP customizations implemented via deprecated `LspServerDescriptor`'s properties will work in 2025.2.
New LSP features will be customizable only via the new API.

Starting with 2026.1.2, on-type formatting ([textDocument/onTypeFormatting](https://microsoft.github.io/language-server-protocol/specification/#textDocument_onTypeFormatting)) is the first LSP feature disabled by default.
Review the servers and enable [LspOnTypeFormattingCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/customization/LspOnTypeFormattingCustomizer.kt) via `LspClientDescriptor.lspCustomization` where formatting while typing is appropriate.

Pre-2025.2:

To fine-tune or disable the implementation of LSP-based features, plugins may override the corresponding properties of the `LspServerDescriptor` class (see their documentation for details).

Warning:

Note that LSP support is in active development and some customization options are available only in newer versions.

To handle custom (undocumented) requests and notifications from the LSP server, override the `LspClientDescriptor.createLsp4jClient()` (`LspServerDescriptor.createLsp4jClient()` before 2026.1.4) function and the `Lsp4jClient` class according to their documentation.

To send custom (undocumented) requests and notifications to the LSP server, override `LspClientDescriptor.lsp4jServerClass` (`LspServerDescriptor.lsp4jServerClass` before 2026.1.4) property and implement the `LspClientNotification` and/or `LspRequest` classes.
The documentation in the source code includes implementation examples.

## Troubleshooting

All the IDE and LSP server communication logs are passed to the IDE log file.

To include them, add the following entry to the Help | Diagnostic Tools | Debug Log Settings… configuration dialog:

```TEXT
#com.intellij.platform.lsp
```

For more information, see the [Logging](ide-infrastructure.html#logging) section.

## Integration Overview

Integrating the Language Server Protocol (LSP) into a plugin for IntelliJ-based IDEs involves a trade-off between simple and fast language support and a complex custom language support plugin with IDE capabilities.

When considering the LSP-based approach, it is important to assess the following criteria for providing a Language Server to end users:

* OS dependency of the Language Server.

* Availability of the latest version online.

* Compatibility with breaking changes between versions.

* Feasibility of requesting the user to provide the Language Server binary path.

## Sample Plugins

Explore third-party plugins using LSP:

* [com.intellij.platform.lsp.integrationProvider](https://jb.gg/ipe?extensions=com.intellij.platform.lsp.integrationProvider) - since 2026.1.4

* [com.intellij.platform.lsp.serverSupportProvider](https://jb.gg/ipe?extensions=com.intellij.platform.lsp.serverSupportProvider) - before 2026.1.4

## LSP API Refactoring

In 2026.1.4, the LSP API classes were renamed to align with LSP terminology, where the IDE acts as the client communicating with an external language server process.
Classes with old names are deprecated, but they are preserved in the API and fully functional.

The following table lists the key classes renaming:

| Old |New |
------------
| [LspServerSupportProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspServerSupportProvider.kt) EP: `com.intellij.platform.lsp.serverSupportProvider` |[LspIntegrationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspIntegrationProvider.kt) EP: `com.intellij.platform.lsp.integrationProvider` |
| `LspServerSupportProvider.LspServerStarter` |`LspIntegrationProvider.LspClientStarter` |
| [LspServerDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspServerDescriptor.kt) |[LspClientDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspClientDescriptor.kt) |
| [ProjectWideLspServerDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/ProjectWideLspServerDescriptor.kt) |[ProjectWideLspClientDescriptor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/ProjectWideLspClientDescriptor.kt) |
| [LspServer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspServer.kt) |[LspClient](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspClient.kt) |
| [LspServerManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspServerManager.kt) |[LspClientManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/LspClientManager.kt) Service is registered for the `LspClientManager` interface only; `project.service<LspServerManager>()` returns null. Use `LspClientManager.getInstance()` (or `LspServerManager.getInstance(project)` to support versions before 2026.1.4). |
| [LspServerWidgetItem](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/lsWidget/LspServerWidgetItem.kt) |[LspClientWidgetItem](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lsp/src/api/lsWidget/LspClientWidgetItem.kt) |

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

