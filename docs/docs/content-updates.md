# Content Updates

This page lists notable additions and updates to the SDK documentation and [Code Samples](code-samples.html).

See [GitHub Changelog](https://github.com/JetBrains/intellij-sdk-docs/commits/main) ([RSS](https://github.com/JetBrains/intellij-sdk-docs/commits/main.atom)) for a detailed changelog.

Tip: Staying up to date

[Subscribe to Marketplace Developer News](https://jb.gg/mp-updates) to receive news and
announcements.
Also follow [@platform.jetbrains.com](https://bsky.app/profile/platform.jetbrains.com) on
Bluesky
(or [JBPlatform](https://x.com/JBPlatform) on X)
and visit
[JetBrains Platform Blog](https://blog.jetbrains.com/platform/) and
[JetBrains Marketplace on LinkedIn](https://www.linkedin.com/showcase/jetbrains-marketplace/).

## 2026

### November

Minor Changes and Additions
: * Document registering [color settings pages](syntax-highlighting-and-error-highlighting.html#registering-a-color-settings-page) with the declarative `com.intellij.colorSettings` extension point available since 2026.3.

* Document the [beta](settings-guide.html#table-of-attributes) attribute of settings declarations, which replaces the deprecated `Configurable.Beta` interface.

### October

Roaming Settings
: Add a new page about [Roaming Settings](roaming-settings.html) describing how to share the state of application-level components via Export Settings and the Backup and Sync plugin.

### July

Creating a Plugin Project
: [Creating a Plugin Project](creating-plugin-project.html) section has been revamped to describe the newest plugin creation workflow using the IDE Plugin generator.

Error Reporting
: Add a new page with details about [Error Reporting](error-reporting.html).

Debouncing and Batching Updates
: Add a new page describing [how to debounce and batch events](debounced-updates.html) with [DebouncedUpdates](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/ide-core/src/com/intellij/util/ui/update/DebouncedUpdates.kt) - a builder API for debounced/throttled update queues.

Persisting Sensitive Data
: Add more information about [persisting sensitive data](persisting-sensitive-data.html).

Integration Tests
: Update [Integration Tests](integration-tests.html) guide with information about new APIs, debugging, and more.

Minor Changes and Additions
: * Document [CLion Classic engine deprecation and migration hints](clion.html#language-engine).

* Add a notice about sunsetting [Kotlin Notebooks](tools-kotlin-notebook.html) from IntelliJ IDEA 2026.2.

### March

Split Mode (Remote Development)
: Add a new section about [Split Mode and Remote Development](split-mode-and-remote-development.html).

Top-Level Notifications
: Describe [notification balloons](notification-balloons.html) showing relevant information without interrupting the developer's flow.

### January

Coroutines on EDT and Locks
: Removed most of the content from the [Coroutines on EDT and Locks](coroutine-edt-and-locks.html) page.
The approach described there is obsolete as it was solved internally in the IntelliJ Platform.
The page and the error pattern are preserved to confirm that no fixes are needed in plugins.

## 2025

### November

Islands Theme Support
: Add a new section about [supporting the Islands Theme](supporting-islands-theme.html).

Terminal API
: Add a new section about [extending the Terminal](embedded-terminal.html).

Modular Plugins
: Add a new section about [Modular Plugins (Experimental)](modular-plugins.html) describing how to develop plugins ready for remote development contexts.

Threading Kotlin Notebooks
: Link [Kotlin Notebooks](threading-model.html#kotlin-notebooks) explaining core threading model concepts.

Minor Changes and Additions
: * Add [Using Custom Icons from the Dotnet Rider Plugin Part](rider.html#using-custom-icons-from-the-dotnet-rider-plugin-part) Using Custom Icons from the Dotnet Rider Plugin Part.

* Update [LSP supported features](language-server-protocol.html#supported-features).

### October

PSI Performance Introduction
: Describe why [caching get method results](psi-performance.html#overview) is important when working with PSI.

Avoiding `idea-version@until-build`
: Add information about recommendation to [avoid using idea-version@until-build](plugin-configuration-file.html#idea-plugin__idea-version) for plugins.

Minor Changes and Additions
: * [Extending existing themes](themes-customize.html#extending-themes).

* Clarify [reacting to closing non-modal dialogs](dialog-wrapper.html#displaying-the-dialog).

* Add an [inspection code sample for Qodana](https://github.com/JetBrains/intellij-sdk-docs/tree/main/code_samples/code_inspection_qodana).

* Hide the [Kotlin UI DSL Version 1 section](kotlin-ui-dsl.html) and make [Version 2](kotlin-ui-dsl-version-2.html) the default version in content.

* Add a link to the [Investigating UI Freezes](threading-model.html#investigating-ui-freezes) blog post.

### September

LSP Module Introduction
: Add information about specifying a required [dependency on the LSP module](language-server-protocol.html#pluginxml) since 2025.2.1.

### August

Minor Changes and Additions
: * Add information about launching coroutines from actions with [currentThreadCoroutineScope](launching-coroutines.html).

### July

Kotlin Notebook integration
: Add a new section about [Kotlin Notebook Integration](tools-kotlin-notebook.html).

Accessibility Guidelines
: Add information about making UI more [accessible](accessibility.html).

### June

Replacement of the Web Symbol API with Poly Symbol API
: Replace the Web Symbol API documentation with [Poly Symbols](polysymbols.html).

### May

New Project Wizard
: Add a new section about implementing project wizards: [New Project Wizard API](new-project-wizard.html).

Minor Changes and Additions
: * Add [Editors FAQ](editors.html#editors-faq) section.

* Extension Points and Listeners are now grouped per plugin, for example, [Java Plugin](intellij-community-plugins-extension-point-list.html#java-plugin).

* Revise and expand [Code Completion](code-completion.html), [Working with Icons](icons.html), [UI FAQ: Icons](ui-faq.html#icons) sections.

* Add [Debugger Entry Points](explore-api.html#debugger-entry-points) allowing identifying code responsible for invoked actions.

### March

Integration Testing
: Add new section [Integration Tests](integration-tests.html).

Minor Changes and Additions
: * Document [Action ID Code Insight](action-system.html#action-id-code-insight) added in 2025.1.

### February

Support Channel Update
: Updated support channels to the new [JetBrains Platform](https://platform.jetbrains.com) community forum.
See the [The JetBrains Platform Gets a New Community Space](https://blog.jetbrains.com/platform/2025/02/the-jetbrains-platform-gets-a-new-community-space/) blog post for more context.

Revamped Threading and Execution Context topics
: Reorganized [threading](threading-model.html) and [coroutines](kotlin-coroutines.html) topics structure.
Updated [Execution Contexts](execution-contexts.html) with the information about contexts available since 2024.2.

### January

Coroutines on EDT and Locks
: Added a [page](coroutine-edt-and-locks.html) describing the current implicit locking behavior on EDT launched from coroutines and planned changes with migration hints.

## 2024

### December

Live Templates Configuration File
: Added a page describing the structure and elements of [live templates configuration files](live-templates-configuration-file.html).

### August

Workspace Model
: [Workspace Model](workspace-model.html) represents the project's structure and all its elements and replaces the existing [Project Model](project-model.html).

Minor Changes and Additions
: * Updated list of [supported features](language-server-protocol.html#supported-features) for Language Server Protocol (LSP).

### July

Threading Model
: Revamp the [Threading Model](threading-model.html) page (formerly General Threading Rules) and add a new page describing [background processes](background-processes.html), including cancellation and progress tracking.

Coroutines Read Actions
: Added FAQ section and explanation of [why suspending inside the block is not allowed](coroutine-read-actions.html#why-can-t-i-suspend-inside-the-block).

### June

Code Formatter
: Rework [Code Formatter](code-formatting.html) page, extending explanations and updating content.

### May

Minor Changes and Additions
: * How to support [grammar checks](spell-checking.html#grammar-checks) provided by Grazie plugin in custom languages.

* How to provide [code vision provider](inlay-hints.html#code-vision-provider) name and description in the settings.

* How to manage [Poly Symbols context](polysymbols-context.html) detection.

### April

Plugin Internationalization
: Add [Internationalization](internationalization.html) and [Providing Translations](providing-translations.html) pages describing IDE and plugin translation possibilities and best practices.

Minor Changes and Additions
: * How to mark functionality available during indexing via [DumbAware API](indexing-and-psi-stubs.html#DumbAwareAPI).

* Move Extension Point and Listener Lists to the Resources section and split the main Extension Point and Listener List into: IntelliJ Platform, IntelliJ Platfom Plugins, and Android Plugin.

### March

Kotlin Coroutines
: Add [Kotlin Coroutines](kotlin-coroutines.html) describing how to write asynchronous code in an imperative style.

Minor Changes and Additions
: * Add [documentation](plugin-extension-points.html#error-handling) on how to handle errors and deprecations in extensions.

* Note changes in how highlighting is now [performed more efficiently](syntax-highlighting-and-error-highlighting.html#order-of-running-highlighting) in 2024.1.

### February

IntelliJ Platform Gradle Plugin 2.x (Early Access Preview)
: Add [documentation](tools-intellij-platform-gradle-plugin.html) for the next generation of Gradle tooling for plugin development.

## 2023

### December

JCEF
: Revamp [JCEF (Java Chromium Embedded Framework)](embedded-browser-jcef.html) page.

User Interface FAQ
: Added [User Interface FAQ](ui-faq.html).

Language Server Protocol (LSP)
: Added [Language Server Protocol (LSP)](language-server-protocol.html).

### November

Minor Changes and Additions
: * Add information about [executing actions programmatically](action-system.html#executing-actions-programmatically).

* Please see [Attaching Sources](tools-gradle-intellij-plugin.html#attaching-sources) on how to set up 2023.2/3 IDEs for Gradle plugin projects.

### October

Kotlin Persisting State Component
: Add an [example](persisting-state-of-components.html#implementing-the-persistentstatecomponent-interface) of a persistent state component implemented in Kotlin.

Minor Changes and Additions
: * Add section [Storing a Reference to a Module](module.html#storing-a-reference-to-a-module).

### September

Run Configuration Macros
: Add [Macros](run-configurations.html#macros) section describing how to support dynamic expandable values in run configuration settings.

Inlay Hints
: Update [Inlay Hints](inlay-hints.html) page with the information about new APIs.

Threading Model
: Update [Threading Model](threading-model.html) to reflect changes in 2023.3 platform.

Minor Changes and Additions
: * Add information about ordering [quick fixes](code-inspections.html#quick-fix-implementation) and [intentions actions](code-intentions.html#techniques-used).

* Clarify the information about [declarative inlay hints](inlay-hints.html#declarative-inlay-hints-provider) customization possibilities.

### July

Run Configurations
: Describe techniques for [simplifying run configuration settings editors](run-configurations.html#simplifying-settings-editors).

### June

Execution
: Rework [Execution](execution.html), [Run Configurations](run-configurations.html), and [Run Configurations Tutorial](run-configurations-tutorial.html) pages.

Minor Changes and Additions
: * Clarify [the syntax highlighting](testing-highlighting.html#syntax-highlighting) test file format and test implementation initial approach.

* Clarify referencing icons by paths and icon holder class constants in [Working with Icons](icons.html).

* Add information about requirements for persistent state components to be included in [the Settings Sync plugin synchronization mechanism](roaming-settings.html#backup-and-sync-plugin).

### April

Documentation
: Rework [Documentation](documentation.html) page and adapt it to the new `DocumentationTargetProvider` framework.

### March

Poly Symbols
: Add [Poly Symbols](polysymbols.html) documentation, which is a framework that simplifies web technology development
by utilizing the [Symbols](symbols.html) API and supporting custom syntaxes.

Open Source Plugins Extension Points
: Added [Open Source Plugins Extension Point and Listener List](oss-plugins-extension-point-list.html) for plugins bundled with [IntelliJ IDEA Plugin Development](idea.html) and other IDEs.

### February

Inspection Options
: Add a section on [Inspection Options](inspection-options.html), which allows extending inspection behavior based on the input provided by user at runtime.

Minor Changes and Additions
: * Add section on [New UI Icons](icons.html#new-ui-icons).

* Document [RuntimeDictionaryProvider](spell-checking.html#runtimedictionaryprovider) EP for spellchecking.

### January

Minor Changes and Additions
: * Update IDE Support section in [Verifying Plugin Compatibility](verifying-plugin-compatibility.html).

* UI Inspector: update [Specific Component Properties](internal-ui-inspector.html#specific-component-properties) and add section [Inspecting Settings](internal-ui-inspector.html#inspecting-settings).

## 2022

### December

Intention Preview
: Add information about how to prepare intentions to show [Intention Action Preview](code-intentions-preview.html).

Minor Changes and Additions
: * Add information for new [Cell.align](kotlin-ui-dsl-version-2.html#cell-align) methods in Kotlin UI DSL Version 2.

### November

Plugin User Experience
: Add a new section about how to improve [plugin UX](plugin-user-experience.html) and overall plugin quality.

Minor Changes and Additions
: * Add information about threading in Actions in [Principal Implementation Overrides](action-system.html#principal-implementation-overrides).

### October

Minor Changes and Additions
: * Add information about [sharing settings](roaming-settings.html) between different IDEs installations.

### September

Extract "Themes" part
: All the content related to [themes customization](theme-structure.html) and creating a project using the [DevKit approach](developing-themes.html) has been moved to a new [Themes](themes-getting-started.html) part.
Content has been refreshed to match the current state of the project and SDK wizards.

Spell Checking
: Add [Spell Checking](spell-checking.html) section with an [accompanying tutorial](spell-checking-strategy.html) showing how to implement a spell checking for a custom language.

Minor Changes and Additions
: * Add descriptions for the following EPs to [Additional Minor Features](additional-minor-features.html): [Prevent Error Highlighting of Files](additional-minor-features.html#prevent-error-highlighting-of-files), [Provide Fully Qualified Names (FQN) for Elements](additional-minor-features.html#provide-fully-qualified-names-fqn-for-elements), [Label Files as Test Files](additional-minor-features.html#label-files-as-test-files), [Move Statements Up and Down in the Editor](additional-minor-features.html#move-statements-up-and-down-in-the-editor).

* Add section about [Power Save Mode](ide-infrastructure.html#power-save-mode).

* Highlight references automatically via [Additional Highlighting](references-and-resolve.html#additional-highlighting)

* Language injections: controlling [Formatting](language-injection.html#formatting)

### August

Plugin Configuration Page
: Update the [Plugin Configuration File](plugin-configuration-file.html) page to describe all the elements in detail.

Source links migrated from Upsource to GitHub
: All source links now point to GitHub instead of Upsource (which is going to be [sunset](https://blog.jetbrains.com/upsource/2022/01/31/upsource-end-of-sales-announcement/)).

### July

Status Bar Widgets
: Add section [Status Bar Widgets](status-bar-widgets.html) describing how to implement your own status bar widgets.

Minor Changes and Additions
: * Add overview of [Useful Action Base Classes](action-system.html#useful-action-base-classes).

### June

PHP Type Providers
: Add section [PHP Type Providers](php-open-api-php-type-providers.html) about type providers describing type inference in PhpStorm and how to implement your own type provider.

Postfix Completion
: Add [Postfix Completion](postfix-completion.html) section explaining how to implement generating or wrapping the existing code into additional constructs without navigating the caret back.

Gradle IntelliJ Plugin
: Add [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) documentation to Tooling.

Bundling Plugin API Sources
: Add the [Bundling Plugin API Sources](bundling-plugin-openapi-sources.html) section explaining how to expose plugin API sources to dependent plugin developers.

Minor Changes and Additions
: * Add a small section to [Utility Classes](php-open-api.html#utility-classes) describing `PhpFilePathUtils` utility class.

* Add mention of the way to programmatically open an autocomplete popup to [Code Completion](code-completion.html).

* Add a small section to [Animated Icons](icons.html#animated-icons) describing animated icons.

* Moved [Gradle Grammar-Kit Plugin](tools-gradle-grammar-kit-plugin.html) documentation to Tooling.

### May

Navigation Bar
: Add [Navigation Bar](navbar.html) section with an [accompanying tutorial](structure-aware-navbar.html) showing how to implement a navigation bar for a custom language.

Inlay Hints
: Add section [Inlay Hints](inlay-hints.html) describing special markers that appear in the editor and provide additional information, like the names of the parameters that a called method expects.

Minor Changes and Additions
: * Add a small section to [Editor Components](editor-components.html) describing convenient `EditorTextField` subclasses.

* Add descriptions for the following EPs to [Additional Minor Features](additional-minor-features.html): [Recognizing Complex Multi-Block Expressions](additional-minor-features.html#recognizing-complex-multi-block-expressions), [Breadcrumbs](additional-minor-features.html#breadcrumbs), [Plain Text Completion](additional-minor-features.html#plain-text-completion), [Splitting and Joining List Constructs](additional-minor-features.html#splitting-and-joining-list-constructs), [Suggesting Rename and Change Signature Refactorings](additional-minor-features.html#suggesting-rename-and-change-signature-refactorings), [Reader Mode](additional-minor-features.html#reader-mode).

* Add small section to [Decorating Project View Nodes](project-view.html#decorating-project-view-nodes) describing how to modify the representation of nodes in the project view.

* Add [Rename Refactoring](rename-refactoring.html) paragraphs mentioning `RenameInputValidator(Ex)`.

### April

Internal API Migration
: As API annotated with `@ApiStatus.Internal` must not be used in plugins, refer to [Internal API Migration](api-internal.html) for a list corresponding API replacements and additional information.

### March

Code Samples Build Scripts Migrated to Kotlin
: All [Code Samples](code-samples.html) now use Kotlin DSL in their Gradle build scripts.

Android Studio Releases List
: Add [Android Studio Releases List](android-studio-releases-list.html) section containing a complete list of the Android Studio releases with the relevant IntelliJ IDEA release version specified.

Alternatives to Implementing a Plugin
: Add [Alternatives to Implementing a Plugin](plugin-alternatives.html) section describing alternative approaches to extending IDE functionality without actual plugin development.

### February

Parameter Info
: Add [Parameter Info](parameter-info.html) section explaining how information about function parameters can be shown in the editor.

File and Code Templates
: Add [File and Code Templates](file-and-code-templates.html) section explaining how to implement functionality that allows generating files and code fragments containing repetitive text and patterns.

### January

Highlighting
: Add [Syntax Errors](syntax-errors.html) and [Controlling Highlighting](controlling-highlighting.html) sections explaining syntax highlighting basics and filtering highlighting information.

IDE Infrastructure
: Add sections [Application Events](ide-infrastructure.html#application-events) and [Plugin Management](ide-infrastructure.html#plugin-management).

## 2021

### December

Trusted Project
: Potentially unsafe features must be guarded using [Trusted Project API](trusted-projects.html).

### November

Language Injection
: Add [Language Injection](language-injection.html) section that shows how the IntelliJ Platform handles different languages within the same source file.

### September

IDE Infrastructure
: [IDE Infrastructure](ide-infrastructure.html) handles Logging, Error Reporting, Runtime Information, and how to provide Context Help.

Extension Point Lists: Listeners, Deprecation status
: [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) now contains sections listing all provided [Listener](plugin-listeners.html) Topics. See also corresponding Extension Point Lists under Product Specific. Also, all deprecated API now has a dedicated tag.

### July

Plugin Signing
: [Plugin Signing](plugin-signing.html) describes the plugin signing process, explains how to generate a certificate, configure the Gradle [signPlugin](tools-gradle-intellij-plugin.html#tasks-signplugin) task, and introduces a standalone CLI tool.

### June

Testing FAQ
: [Testing FAQ](testing-faq.html) page lists common issues, useful classes, and techniques for writing and maintaining tests.

Documentation Provider
: Add [Documentation](documentation.html) section with an [accompanying tutorial](documentation-provider.html) that show how to implement a `DocumentationProvider` for custom languages.

### May

IDE specific Extension Point Lists
: See Product Specific.

New Guide - Explore the IntelliJ Platform API
: Add a new section [Explore the IntelliJ Platform API](explore-api.html) that describes how plugin authors work with the IntelliJ Platform API and what tools they use.

### March

Element Patterns
: Add a new section about [Element Patterns](element-patterns.html) that are used when implementing [Completion Contributors](completion-contributor.html) or [PSI Reference Contributors](psi-references.html#contributed-references).

Editor - Text Selection
: Add a new section about [Text Selection EPs](text-selection.html) and describe [ExtendWordSelectionHandler](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-api/src/com/intellij/codeInsight/editorActions/ExtendWordSelectionHandler.java).

SDK Setup Assistance
: Added a code sample to the SDK tutorial that expands on [assisting in the setup of an SDK](sdk.html#assisting-in-setting-up-an-sdk).

Unified AST
: [Unified Abstract Syntax Tree (UAST)](uast.html) allows providing features that will work across all supported JVM languages (Java, Kotlin, Scala, Groovy).

## 2020

### December

IntelliJ Platform Explorer
: Explore usages of [Extension Points](intellij-platform-extension-point-list.html) in open-source plugins using [IntelliJ Platform Explorer](https://jb.gg/ipe).

### November

Extension Point List
: All EPs [available in IJ Platform and Android](intellij-platform-extension-point-list.html) can now be browsed conveniently.

### August

README added to Code Samples
: All code samples used in this guide now come with `README`, making it easier to browse them. They can be conveniently accessed via a [separate GitHub repository](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/).

### June

Dynamic Plugins update
: Added new sections Code and Troubleshooting to [Dynamic Plugins](dynamic-plugins.html).

GitHub IntelliJ Platform Plugin Template
: Create new plugins with a preconfigured project scaffold and CI in [one click](https://github.com/JetBrains/intellij-platform-plugin-template).

Disposer & Disposable
: Added [reference](disposers.html) discussing resource cleanup/management.

### May

Settings (Preferences)
: Added [guide](settings-guide.html) and [tutorial](settings-tutorial.html) on integrating with IDE Settings dialog.

UI Inspector
: Inspect Swing components and associated data (like `AnAction` for menu item) using [UI Inspector](internal-ui-inspector.html).

### March

JCEF Support
: Allows [embedding](embedded-browser-jcef.html) Chromium-based browser in the IDE.

### February

All Code Samples converted to Gradle
: [All samples](https://github.com/JetBrains/intellij-sdk-docs/tree/main/code_samples) now use the [recommended solution](creating-plugin-project.html) of setting up plugin projects.

### January

Custom Language Support Tutorial converted to Gradle
: The [corresponding tutorial](custom-language-support-tutorial.html) and [Testing a Custom Language Plugin](writing-tests-for-plugins.html) have been updated and enhanced as well.

Targeting specific IDEs
: [Product Specific](plugin-compatibility.html) has been expanded massively, now also covering each IDE with its dedicated page.

## 2019

### December

Dynamic Plugins support
: Added starting point [Dynamic Plugins](dynamic-plugins.html) for migrating plugins (IntelliJ Platform 2020.1 and later).

Plugin Components migration
: Components being a legacy feature, the [updated page](plugin-components.html) describes migrating them to modern replacement API.

### October

Plugin Repository moved
: All contents have been moved to [JetBrains Marketplace Documentation](https://plugins.jetbrains.com/docs/marketplace/).

### July

New page: Optimizing Performance
: Optimizing performance when [working with PSI](psi-performance.html), [during indexing](indexing-and-psi-stubs.html#improving-indexing-performance), and [Avoiding UI Freezes](threading-model.html#avoiding-ui-freezes).

### May

New Page: Kotlin UI DSL
: [Describes preferred way](kotlin-ui-dsl.html) of building UI/dialogs for IntelliJ Platform 2019.2 and later.

