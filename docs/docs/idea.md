# IntelliJ IDEA Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/idea), [Versions](https://www.jetbrains.com/idea/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/idea)
</tldr>

## IntelliJ IDEA Plugin Setup

### Gradle Build Script

IntelliJ Platform Gradle Plugin (2.x):

Define a dependency using [intellijIdea()](tools-intellij-platform-gradle-plugin-dependencies-extension.html), see Versions link on top of this page for all available versions.
See [Local IntelliJ Platform IDE Instance](tools-intellij-platform-gradle-plugin.html#dependenciesLocalPlatform) for using a local installation.

Minimum `build.gradle.kts` setup:

```KOTLIN
repositories {
  mavenCentral()
  intellijPlatform {
    defaultRepositories()
  }
}

dependencies {
  intellijPlatform {
    intellijIdea("<versionNumber>")
  }
}
```

Gradle IntelliJ Plugin (1.x):

The configuration of IntelliJ IDEA plugin projects follows the methods described in [Configuring Plugin Projects using the IntelliJ IDEA Product Attribute](dev-alternate-products.html#using-the-intellij-idea-product-attribute).

| `gradle-intellij-plugin` Attribute |Attribute Value |
-------------------------------------------------------
| [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) |`IU` for [IntelliJ IDEA]() |
| [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) |IDE version, e.g. `2022.2` |

## Available API

See [IntelliJ Platform Plugins Extension Point and Listener List](intellij-community-plugins-extension-point-list.html) for API from bundled plugins.

### Product-Specific APIs in IntelliJ IDEA

The following pages describe targeting APIs available in IntelliJ IDEA:

* [Spring API](spring-api.html)

* [Tomcat Integration](tomcat-integration.html)

## Java Plugin

<tldr>
Java Plugin Extension Points: [Java Plugin](intellij-community-plugins-extension-point-list.html#java-plugin)
</tldr>

Configure bundled Java [plugin dependency](plugin-dependencies.html) with plugin ID `com.intellij.java`.

[PSI Cookbook](psi-cookbook.html#java-specific) lists a number of common operations for working with Java PSI.

Depending on the exact functionality, a plugin can also target [UAST – Unified Abstract Syntax Tree](uast.html) to support multiple JVM languages, including Java and Kotlin.

### Java Test Framework

To use existing test base classes, add `TestFrameworkType.Plugin.Java` test-framework available from [Plugin Test Frameworks](tools-intellij-platform-gradle-plugin-types.html#TestFrameworkType-Plugin).

Alternatively, specify `com.jetbrains.intellij.java:java-test-framework:$VERSION$` as `testImplementation` dependency explicitly (see [IntelliJ Platform Artifacts Repositories](intellij-artifacts.html#gradle-example-for-an-individual-module-from-the-intellij-platform)).

## Kotlin Plugin

<tldr>
Kotlin Plugin Extension Points: [Kotlin Plugin](intellij-community-plugins-extension-point-list.html#kotlin-plugin)
</tldr>

Configure the bundled Kotlin [plugin dependency](plugin-dependencies.html) with plugin ID `org.jetbrains.kotlin`.

[Kotlin PSI](https://kotlin.github.io/analysis-api/fundamentals.html#kotlin-psi) explains the differences from the IntelliJ IDEA PSI and introduces the Analysis API as the new recommended way to work with Kotlin code.

See also [UAST](uast.html) on how to support multiple JVM languages, including Kotlin.

### Analysis API

Tip:

Analysis API is available since version 2024.2.

Starting from IntelliJ IDEA 2025.1, K2 Kotlin mode is enabled by default.
To ensure your plugin works with the newest versions of IntelliJ IDEA, you must migrate to the Analysis API and declare compatibility with the K2 compiler.

For migration details, see [Migrating from K1](https://kotlin.github.io/analysis-api/migrating-from-k1.html).

For comprehensive information about the Analysis API, refer to [Kotlin Analysis API Documentation](https://kotlin.github.io/analysis-api/index_md.html).

### Testing K1 (K2) mode

See [Testing in K1 Locally](https://kotlin.github.io/analysis-api/testing-in-k1-locally.html).

### Kotlin Code FAQ

[How to shorten references?](https://intellij-support.jetbrains.com/hc/en-us/community/posts/360010025120-Add-new-parameter-into-kotlin-data-class-from-IDEA-plugin?page=1#community_comment_360002950760)

## Getting Help

For plugin implementation support and questions, see the
[Getting Help](getting-help.html#problems-with-code-support-issues) section.

