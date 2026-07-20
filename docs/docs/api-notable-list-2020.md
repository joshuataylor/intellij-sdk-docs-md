# Notable Changes in IntelliJ Platform and Plugins API 2020.*

We've published our roadmap for the IntelliJ Platform for 2020: [Part I](https://blog.jetbrains.com/idea/2019/12/intellij-platform-roadmap-for-2020/) [Part II](https://blog.jetbrains.com/idea/2020/01/intellij-based-ide-features-roadmap-for-2020/)

## 2020.3

### IntelliJ Platform 2020.3

IntelliJ Platform migrated to Java 11
: Using Java 11 is now required, please see [blog post](https://blog.jetbrains.com/platform/2020/09/intellij-project-migrates-to-java-11/).

Internal changes in Project Model
: Internal changes related to a significant redesign of the representation of project models have been made, please see [blog post](https://blog.jetbrains.com/platform/2020/10/new-implementation-of-project-model-interfaces-in-2020-3/) for details. This shouldn't affect any plugins using the IntelliJ API properly and which don't access internal classes.

Reparsing of `IReparseableLeafElementType`
: For elements whose `IElementType` implements this interface, platform attempts reparse when a modification is made right before or after the leaf element preventing reparsing the whole file.

Generating HTML fragments
: Use [HtmlBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/src/com/intellij/openapi/util/text/HtmlBuilder.java) for generating formatted content, e.g., for [Documentation](documentation.html).

Extensible HTML Lexer/Parser
: Implement [HtmlEmbeddedContentSupport](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/xml/xml-parser/src/com/intellij/html/embedding/HtmlEmbeddedContentSupport.kt) and register in [com.intellij.html.embeddedContentSupport](https://jb.gg/ipe?extensions=com.intellij.html.embeddedContentSupport) extension point
to embed arbitrary tokens into any tag or attribute.
Please note that old API from `com.intellij.lexer.BaseHtmlLexer` is no longer working.

Action System
: New features in [Action System](action-system.html): `<override-text>` works now for [&lt;group&gt;](plugin-configuration-file.html#idea-plugin__actions__group) as well, [&lt;synonym&gt;](plugin-configuration-file.html#idea-plugin__actions__action__synonym) provides alternative names when searching for actions, and groups can be excluded from search results.

Welcome Screen customization
: To provide additional custom tabs, implement [WelcomeTabFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/wm/WelcomeTabFactory.java) and register in [com.intellij.welcomeTabFactory](https://jb.gg/ipe?extensions=com.intellij.welcomeTabFactory) extension point
.

File Type association with the IDE
: To control file type association with the IDE in the operating system, implement [OSFileIdeAssociation](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/fileTypes/OSFileIdeAssociation.java).

Reader Mode customization
: Implement [ReaderModeProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/editor-ui-api/src/com/intellij/codeInsight/actions/ReaderModeProvider.kt) and register in [com.intellij.readerModeProvider](https://jb.gg/ipe?extensions=com.intellij.readerModeProvider) extension point
to apply custom settings for files rendered in reader mode. Provide `com.intellij.codeInsight.actions.ReaderModeMatcher` to disable Reader Mode for particular set of files.

Text Editor customization
: Implement [TextEditorCustomizer](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-impl/src/com/intellij/openapi/fileEditor/impl/text/TextEditorCustomizer.kt) and register in [com.intellij.textEditorCustomizer](https://jb.gg/ipe?extensions=com.intellij.textEditorCustomizer) extension point
to customize created editors.

Note: `TextEditorCustomizer` has been marked internal since 2024.2.
See [the replacement](api-internal.html#intellij-platform).

### JavaScript Plugin 2020.3

Published Javascript Testframework
: This allows using existing test base classes, see [WebStorm Plugin Development](webstorm.html#javascript-test-framework) page for details.

### CLion/AppCode 2020.3

Required changes in project setup
: When targeting 2020.3, please see this [migration guide](https://blog.jetbrains.com/clion/2020/12/migration-guide-for-plugins-2020-3/).

## 2020.2

### IntelliJ Platform 2020.2

Constructor Injection in `Configurable` forbidden
: Please obtain necessary components only when needed (logged as ERROR now).

`VirtualFile` lookup via `Path`
: Added `VirtualFileManager.findFileByNioPath()`/`refreshAndFindFileByNioPath()`. See also `VirtualFile.toNioPath()`.

Tooltip descriptions for icons
: Register resource bundle via [com.intellij.iconDescriptionBundle](https://jb.gg/ipe?extensions=com.intellij.iconDescriptionBundle) extension point
to provide tooltips automatically for all [SimpleColoredComponent](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/SimpleColoredComponent.java) renderers.

Specify incompatibility with Module
: A plugin can [mark itself incompatible](plugin-compatibility.html#declaring-incompatibility-with-module) if IDE contains specified module.

`com.intellij.openapi.editor.markup.MarkupModel` methods using `TextAttributesKey`
: To support on-the-fly Editor color scheme switching, change calls from methods taking `TextAttributes`.

Support for WebP images
: The platform now bundles support for images in [WebP](https://en.wikipedia.org/wiki/WebP) format.

FileType mapping via hashbang (`#!`)
: Specify `hashBangs` attribute in [com.intellij.fileType](https://jb.gg/ipe?extensions=com.intellij.fileType) extension point
. [Issue](https://youtrack.jetbrains.com/issue/IDEA-175757)

Add information to About dialog
: Implement [AboutPopupDescriptionProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-impl/src/com/intellij/ide/AboutPopupDescriptionProvider.kt) and register in [com.intellij.aboutPopupDescriptionProvider](https://jb.gg/ipe?extensions=com.intellij.aboutPopupDescriptionProvider) extension point
.

Previewing Intention/Quick Fix
: To support preview in intention popup, suitable [FileModifier](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/codeInsight/intention/FileModifier.java) must be provided (default implementation `FileModifier.getFileModifierForPreview()` works for most cases).

Delegate Run Anything/Terminal commands to IDE features
: Switch to matching IDE feature by implementing [TerminalShellCommandHandler](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/execution-impl/src/com/intellij/terminal/TerminalShellCommandHandler.kt) ([com.intellij.terminal.shellCommandHandler](https://jb.gg/ipe?extensions=com.intellij.terminal.shellCommandHandler) extension point
). [Blog post](https://blog.jetbrains.com/idea/2020/07/run-ide-features-from-the-terminal/)

Deprecating JavaFX in favor of JCEF
: We recommend switching to [JCEF](embedded-browser-jcef.html), please see [blog post](https://blog.jetbrains.com/platform/2020/07/javafx-and-jcef-in-the-intellij-platform/) for details.

ASM Library 8.0.1
: Updated from 7.0.1.

Validating Lexer for editor highlighting
: Lexer is wrapped using [ValidatingLexerWrapper](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/editor-ui-ex/src/com/intellij/openapi/editor/ex/util/ValidatingLexerWrapper.java) to verify it generates a continuous sequence of tokens and doesn't stall during iteration.

### IntelliJ IDEA 2020.2

Unbundled plugins
: Several plugins (ASP, CFML, Flash/Flex, GWT, JBoss Seam Pageflow, JBoss Seam, JBoss jBPM, OSGi, Play Framework, Resin, Seam Navigation, Tapestry, Virgo/dmServer) for no longer actively maintained technology have been unbundled. If your plugin depends on them, users will need to install them from the [JetBrains Marketplace](https://plugins.jetbrains.com).

## 2020.1

### IntelliJ Platform 2020.1

Dynamic Plugins
: [Compatible plugins](dynamic-plugins.html) can be installed, updated and uninstalled without requiring IDE restart.

[com.intellij.openapi.application.TransactionGuard](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/application/TransactionGuard.java) deprecated
: Usage is deprecated and can be replaced with `com.intellij.openapi.application.Application.invokeLater()` in most cases, please consult Javadoc for more details.

`RecursionManager.assertOnMissedCache()` enabled by default in tests
: Please see [RecursionManager.CachingPreventedException](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/src/com/intellij/openapi/util/RecursionManager.java) Javadoc and [this issue](https://youtrack.jetbrains.com/issue/IDEA-228809) for details.

`ResolveCache` using `IdempotenceChecker` in tests
: Reports when the same reference resolves non-equivalent results in different threads, see [IdempotenceChecker](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-impl/src/com/intellij/util/IdempotenceChecker.java).

Refactoring dialog: builtin "Open in editor" option
: Set `addOpenInEditorCheckbox` constructor parameter to enable it in custom `RefactoringDialog` implementation.

Configurable status bar widgets
: Use [com.intellij.statusBarWidgetFactory](https://jb.gg/ipe?extensions=com.intellij.statusBarWidgetFactory) extension point
to provide widgets that can be disabled or reordered, see [Status Bar Widgets](status-bar-widgets.html).

JCEF Support
: Allows [embedding](embedded-browser-jcef.html) a Chromium-based browser in the IDE.

Override text presentation for actions depending on menu context
: Set the [&lt;override-text&gt;](plugin-configuration-file.html#idea-plugin__actions__action__override-text) element within the [&lt;action&gt;](plugin-configuration-file.html#idea-plugin__actions__action) declaration in `[plugin.xml](plugin-configuration-file.html)`.

Changes in Project Open/Import
: Import from Existing Sources has been removed from the Welcome Screen, leaving only Open or Import, which calls a different extension than the one previously used to contribute a wizard step to Import from Existing Sources (which is still available in the File menu). To support Open or Import, a plugin must provide [ProjectOpenProcessor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/projectImport/ProjectOpenProcessor.kt).
`ProjectOpenProcessor.canOpenProject()` should return `true` for the folder selected by the user only if it guarantees `doOpenProject()` can handle it. If there are several matching processors, a simple chooser dialog is shown. If additional manual configuration is necessary, a modal dialog can be shown in `doOpenProject()` - however, it is highly recommended performing all setup automatically (like Maven and Gradle plugins do).

### IntelliJ IDEA 2020.1

EOL for JetBrains TFS Plugin
: Please use [Azure DevOps](https://plugins.jetbrains.com/plugin/7981-azure-devops) plugin instead, see [blog post](https://blog.jetbrains.com/idea/2020/01/end-of-support-for-tfs-2014-and-older/) for more details.

Unbundled plugins
: Several plugins (Cloud Foundry, Google App Engine) for no longer actively maintained technology have been unbundled. If your plugin depends on them, users will need to install them from the [JetBrains Marketplace](https://plugins.jetbrains.com).

