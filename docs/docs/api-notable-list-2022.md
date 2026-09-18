# Notable Changes in IntelliJ Platform and Plugins API 2022.*

Early Access Program (EAP) releases of upcoming versions are available [here](https://eap.jetbrains.com).

## 2022.3

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

### IntelliJ Platform 2022.3

Display of previews for Intentions and Quick Fixes
: Intentions and Quick Fix actions now display a preview for the code changes. Read [this article](code-intentions-preview.html) to learn more about this feature.

Specify language for Intention
: Specify `<language>` in [com.intellij.intentionAction](https://jb.gg/ipe?extensions=com.intellij.intentionAction) extension point
registration to avoid instantiating language-specific intentions in non-relevant places.

"Heavy" Brace Matching
: Alternative extension point to implement [Brace Matching](additional-minor-features.html#brace-matching) in background thread.

Injection Text Formatting
: Delegation of formatting can be controlled using dedicated [extension point](language-injection.html#formatting).

Specifying Threading for Actions
: Implementations of `AnAction` need to override `getActionUpdateThread()` as detailed in [Principal Implementation Overrides](action-system.html#principal-implementation-overrides).

Threading assertions in tests
: All rules for [threading](threading-model.html) are now checked in tests as well.

Mapping New UI icons
: See [New UI Icons](icons.html#new-ui-icons) on how to provide additional icons.

### IntelliJ IDEA 2022.3

Unbundled plugins
: Several plugins (Haml, Jakarta EE: WebSockets, JBoss Seam, Spring WebSocket, Stylus, Tapestry, Vaadin, ZKM-Unscramble) have been unbundled. The IDE will suggest installation if the project contains related framework dependency. If your plugin depends on them, users will need to install them from the [JetBrains Marketplace](https://plugins.jetbrains.com).

## 2022.2

### IntelliJ Platform 2022.2

Highlighting References
: Highlight references automatically via [Additional Highlighting](references-and-resolve.html#additional-highlighting).

## 2022.1

### IntelliJ Platform 2022.1

New Project Wizard
: The New Project wizard has been refreshed and some base [ModuleBuilder](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-core/src/com/intellij/ide/util/projectWizard/ModuleBuilder.java) classes return `false` from the `isAvailable()` method. If your module builder extends a base class and is hidden in the 2022.1 wizard, override the method to return `true`.

External System Test Framework
: Available as `com.jetbrains.intellij.platform:external-system-test-framework` from [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html), see [Testing](external-system-integration.html#testing).

### IntelliJ IDEA 2022.1

Unbundled plugins
: Several plugins (Grails, Jakarta EE: Batch Applications, Jakarta EE: Server Faces (JSF), Jakarta EE: Web Services (JAX-WS), Jetty, Smali Support, Spring Batch, Spring Integration Patterns, Spring Web Services, WebLogic, WebSphere) have been unbundled. The IDE will suggest installation if the project contains related framework dependency. If your plugin depends on them, users will need to install them from the [JetBrains Marketplace](https://plugins.jetbrains.com).

### Maven Plugin 2022.1

Published Maven Test Framework
: Available as `com.jetbrains.intellij.maven:maven-test-framework` from [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html), See also `TestFrameworkType.Plugin.Maven` test-framework available from [Plugin Test Frameworks](tools-intellij-platform-gradle-plugin-types.html#TestFrameworkType-Plugin).

