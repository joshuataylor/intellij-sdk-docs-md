# Notable Changes in IntelliJ Platform and Plugins API 2024.*

Early Access Program (EAP) releases of upcoming versions are available [here](https://eap.jetbrains.com).

Warning: Gradle Plugin

The Gradle plugin must be chosen depending on the target
[platform version](build-number-ranges.html#platformVersions).

2024.2+
: Requires
[IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html)

2022.3+
: Recommended
[IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html)
: Requires
[Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html)
(Obsolete)
1.10.1+

## 2024.3

### IntelliJ Platform 2024.3

Dumb-aware "Highlight Usages"
: [Semantic Highlight Usages](additional-minor-features.html#semantic-highlight-usages) can be marked as [DumbAware API](indexing-and-psi-stubs.html#DumbAwareAPI).

`ParsingTestCase`: stable PSI check
: [ParsingTestCase](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/testFramework/src/com/intellij/testFramework/ParsingTestCase.java) verifies that reparsing causes no changes (Parser bug).

Performance test classes and methods renamed to Benchmark
: * [PerformanceTestInfo](https://github.com/JetBrains/intellij-community/tree/242/platform/testFramework/src/com/intellij/testFramework/PerformanceTestInfo.java) has been renamed to [BenchmarkTestInfo](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/testFramework/src/com/intellij/testFramework/BenchmarkTestInfo.java)

* [PlatformTestUtil.newPerformanceTest*()](https://github.com/JetBrains/intellij-community/tree/242/platform/testFramework/src/com/intellij/testFramework/PlatformTestUtil.java) methods have been renamed to [PlatformTestUtil.newBenchmark*()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/testFramework/src/com/intellij/testFramework/PlatformTestUtil.java)

Testing: `Logger.error()` behaviour
: Does not throw during tests anymore, see [issue](https://youtrack.jetbrains.com/issue/IJPL-453) for details.

### IntelliJ IDEA 2024.3

Unbundled Swing UI Designer Plugin
: [Install](https://plugins.jetbrains.com/plugin/25304-swing-ui-designer) from JetBrains Marketplace.
Consider using [Kotlin UI DSL](kotlin-ui-dsl-version-2.html) for forms instead.

## 2024.2

### IntelliJ Platform 2024.2

Dumb-aware intentions and quick-fixes
: Mark implementations as enabled during indexing, see [DumbAware API](indexing-and-psi-stubs.html#DumbAwareAPI).

Workspace Model API
: [Workspace Model](workspace-model.html) represents the project's structure and all its elements and replaces the existing [Project Model](project-model.html).

Testing: `ProjectActivity`
: Executed asynchronously now during tests, see [How to handle ProjectActivity?](testing-faq.html#how-to-handle-projectactivity).

Testing: indexes
: Indexes are now built asynchronously during tests, see [How to handle indexing?](testing-faq.html#how-to-handle-indexing).

`ToggleAction` in popups
: No longer closes popups, see [Popup Menus](action-system.html#toggleActionPopupMenus)

### Kotlin Plugin

Depending on K1 API
: Plugins using K1 API classes must adjust their usages, see [Migrating Your IntelliJ IDEA Kotlin Plugin to K2 Mode](https://blog.jetbrains.com/platform/2024/09/migrating-your-kotlin-plugin-to-k2-mode/).

### PyCharm 2024.2

Project setup
: Note [changes in project setup](pycharm.html#python242) when targeting PyCharm Professional.

## 2024.1

### IntelliJ Platform 2024.1

Bundled Localization
: Initial plugin [localization](providing-translations.html#translated-elements) capabilities.

Using Coroutines
: It is now recommended to use [Kotlin Coroutines](kotlin-coroutines.html) for asynchronous code.

Running highlighting
: Highlighting is now performed more efficiently, please refer to [Order of Running Highlighting](syntax-highlighting-and-error-highlighting.html#order-of-running-highlighting).

Status bar widget for LSP servers
: Language plugins using LSP can now provide their status for [Status Bar Integration](language-server-protocol.html#status-bar-integration).

Cached Values and Dumb Mode
: Note change for [Using ProjectRootManager as a Dependency](psi-performance.html#projectRootManagerDependency).

Saving Settings on background thread
: Saving project/application [settings](settings.html) is no longer performed on [EDT](threading-model.html) to avoid freezes. [Issue](https://youtrack.jetbrains.com/issue/IJPL-127/Save-project-application-settings-on-background-thread)

### IntelliJ IDEA 2024.1

Unbundled plugins
: Several plugins (Cucumber Groovy, Cucumber Java) have been unbundled. The IDE will suggest installation if the project contains related framework dependency. If a plugin depends on them, users will need to install them from the [JetBrains Marketplace](https://plugins.jetbrains.com).

