# Gradle Grammar-Kit Plugin

<tldr>
Current Release: 2023.3.0.4

GitHub: [Releases &amp; Changelog](https://github.com/JetBrains/gradle-grammar-kit-plugin/releases), [Issue Tracker](https://github.com/JetBrains/gradle-grammar-kit-plugin/issues)
</tldr>

The [Gradle Grammar-Kit Plugin](https://github.com/JetBrains/gradle-grammar-kit-plugin) automates generating lexers and parsers to support building [custom language](custom-language-support.html) plugins for IntelliJ-based IDEs when using [Grammar-Kit](https://github.com/JetBrains/Grammar-Kit).

Note: Known Limitations

The plugin does not support two-pass generation. Therefore, it does not support method mixins.

Tip:

Please see [CONTRIBUTING](https://github.com/JetBrains/gradle-grammar-kit-plugin/blob/master/CONTRIBUTING.md) on how to submit feedback and contribute to this project.

Before visiting the [Issue Tracker](https://github.com/JetBrains/gradle-grammar-kit-plugin/issues), update both plugin and Gradle to the latest versions.

## Usage

To enable this plugin in your Gradle-based project, register the plugin in the Gradle build script's `plugins` section:

Kotlin:

```KOTLIN
plugins {
  id("org.jetbrains.grammarkit") version "2023.3.0.4"
}
```

Groovy:

```GROOVY
plugins {
  id "org.jetbrains.grammarkit" version "2023.3.0.4"
}
```

Tip: Minimum Gradle Version

This project requires Gradle 7.4 or newer.
However, it is recommended to use the latest Gradle available.
See [Gradle Installation](https://gradle.org/install/) guide.

## Configuration

See also [Usage Examples](#usage-examples) below.

### Grammar-Kit Extension

After the Gradle Grammar-Kit Plugin is applied, the `grammarKit` extension can be used to configure the plugin and common settings of the provided tasks.

Tip:

In most cases, explicit configuration can be omitted.

Example:

Kotlin:

```KOTLIN
grammarKit {
  jflexRelease.set("1.7.0-1")
  grammarKitRelease.set("2021.1.2")
}
```

Groovy:

```GROOVY
grammarKit {
  jflexRelease = "1.7.0-1"
  grammarKitRelease = "2021.1.2"
}
```

#### grammarKitRelease

The release version of the [Grammar-Kit](https://github.com/JetBrains/Grammar-Kit) to use.

Type
: `String`

Default value
: `2022.3.2`

#### jflexRelease

The version of the IntelliJ-patched JFlex, a [fork of JFlex](https://github.com/JetBrains/intellij-deps-jflex) lexer generator for IntelliJ Platform API.

Type
: `String`

Default value
: `1.9.2`

#### intellijRelease

An optional IntelliJ IDEA version to build the classpath for [GenerateParser](#generateparser-task) and [GenerateLexer](#generatelexer-task) tasks.

If provided, [grammarKitRelease](#grammar-kit-extension-grammarkitrelease) and [jflexRelease](#grammar-kit-extension-jflexrelease) properties are ignored as both dependencies will be provided from the given IntelliJ IDEA release.

Type
: `String`

Default value
: `null`

## Tasks

### generateLexer

The `generateLexer` task generates a lexer for the given grammar.

The following sections describe task configuration options.
See also [Grammar-Kit Extension](#grammar-kit-extension) for common configuration.

#### sourceFile

The source `.*flex` file to generate the lexer from.

Required
: yes

Type
: `String`

#### targetOutputDir

The path to the target directory for the generated lexer.

Required
: yes

Type
: `String`

#### skeleton

An optional path to the skeleton file to use for the generated lexer.
The path will be provided as the `--skel` option.
By default, it uses the `[idea-flex.skeleton](https://raw.github.com/JetBrains/intellij-community/master/tools/lexer/idea-flex.skeleton)` skeleton file.

Type
: `String`

Default
: `null`

#### purgeOldFiles

Purge old files from the target directory before generating the lexer.

Type
: `Boolean`

Default
: `false`

### generateParser

The `generateParser` task generates a parser for the given grammar.

The following sections describe task configuration options.
See also [Grammar-Kit Extension](#grammar-kit-extension) for common configuration.

#### sourceFile

The source `.bnf` file to generate the parser from.

Required
: yes

Type
: `String`

#### targetRootOutputDir

The path to the target directory for the generated parser.

Type
: `String`

Default
: `null`

#### pathToParser

The location of the generated parser class, relative to the [targetRootOutputDir](#tasks-generateparser-targetrootOutputDir).

Required
: yes

Type
: `String`

#### pathToPsiRoot

The location of the generated PSI files, relative to the [targetRootOutputDir](#tasks-generateparser-targetrootOutputDir).

Required
: yes

Type
: `String`

#### purgeOldFiles

Purge old files from the target directory before generating the parser.

Type
: `Boolean`

Default
: `false`

## Usage Examples

* [CSV Editor](https://github.com/SeeSharpSoft/intellij-csv-validator/blob/main/build.gradle.kts)

* [Perl5 plugin](https://github.com/Camelcade/Perl5-IDEA/blob/master/plugin/core/build.gradle.kts)

* [OSS Plugins on GitHub](https://github.com/search?q=+org.jetbrains.grammarkit+language%3AGradle++NOT+is%3Aarchived+&type=code)

## Links

* [Grammar-Kit](https://github.com/JetBrains/Grammar-Kit)

* [IntelliJ-patched JFlex Sources](https://github.com/JetBrains/intellij-deps-jflex)

* [IntelliJ-patched JFlex](https://cache-redirector.jetbrains.com/intellij-dependencies/org/jetbrains/intellij/deps/jflex/jflex/)

