# About This Guide

This guide is split into several parts, similar to a textbook.
Each one builds on the content of the previous section, but it is not necessary to read the guide in order.
The [Key Topics](key-topics.html) page aims to link to the pages that are necessary to be able to understand the architecture and get started building plugins.

All source links and reference lists target IntelliJ Platform 2026.2.

Note:

While browsing this guide, you will notice that there are topics that are greyed out.
Unfortunately, the guide is not complete and contains placeholders for specific topics.
We are working on increasing the coverage, but if you get stuck due to missing content, please see the [Getting Help](getting-help.html) section for details on how to get moving again.

The guide is also [Open Source on GitHub](https://github.com/JetBrains/intellij-sdk-docs), and Pull Requests for new content, corrections or updates are always gratefully received.
Please see the [Contributing](intellij-sdk-docs-original-contributing.html) page for details.

Tip:

See also [Glossary](glossary.html) for a handy reference of common terms.

## Plugins

Describes how to create a plugin that can extend the IntelliJ Platform.
Includes details on how to set up the project, register extension points, target specific versions of the IntelliJ Platform, and how to package, deploy, and test your plugins.

## Base Platform

Describes the foundational layer of the architecture, which provides many features and utilities, such as the component model, the user interface, documents and editors, the virtual file system, settings, threading, and background tasks.
The Base Platform layer mainly comprises the functionality of the IntelliJ Platform that does not target language features or parsing.

## Project Model

Documents the Project Model, which represents the files and configuration of the currently loaded project, as well as the build system used to build the project.

## PSI

The Program Structure Interface (PSI) builds the syntactic and semantic models for lots of different file types.
This section describes how to work with the PSI, navigating and manipulating the syntax trees, and also looks at the powerful references system, which allows a syntax tree node to reference an item in the semantic model.
It also details how PSI creates and uses indexes.

## Features

Describes how to extend and interact with various features that use the PSI layer, such as code completion, navigation, `Alt+Enter` items, intentions, refactorings, and more.
See also the section on Custom Languages below for language-specific features that are only applicable when adding support for a new language.

## Testing

Describes the available infrastructure for writing automated tests covering the functionality of plugins.

## Custom Languages

Plugins frequently extend support for existing languages, such as adding inspections to Java files.
This section describes how to add support to the IntelliJ Platform for a new language that isn't supported by default, creating parsers, syntactic and semantic models, and all the features that build on top.

## Product Specific

A lot of the functionalities in the IntelliJ Platform are language and product agnostic.
For example, code inspections work the same in Java as they do in Ruby; it is just the syntax trees and semantic information that is different.
This section describes product-specific features, such as specific project model differences and how to target them in a plugin.

## Custom IDEs

Documents how to use the IntelliJ Platform to create a new, custom IDE, rather than plugins to an existing product, e.g., WebStorm, or Android Studio.

## Themes

Describes how to create a theme for IntelliJ Platform-based IDEs.
Includes details on how to set up the theme project, customize, build, and publish it on JetBrains Marketplace.

## Resources

Links to [useful resources](useful-links.html), a [Glossary](glossary.html), [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html), tips on how to [Explore the IntelliJ Platform API](explore-api.html) and [Learning Resources](learning-resources.html).

## API and Compatibility

Information on [Verifying Plugin Compatibility](verifying-plugin-compatibility.html) and list of [backwards-incompatible](api-changes-list.html) API changes as well as [notable changes and new features](api-notable.html) in each major release of the IntelliJ Platform.

## Tooling

Reference and usage guides for commonly used tools like the [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html).

## UI Guidelines

How to create consistent and usable user interfaces.

