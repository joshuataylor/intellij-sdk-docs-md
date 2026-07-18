# Code Samples

This guide comes with a number of sample plugins available from dedicated [intellij-sdk-code-samples](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/) GitHub repository.

Please see `README.md` which lists all available code samples with a short description.

Each sample is stored in a dedicated folder and is accompanied by its own `README.md`.
Links to the corresponding tutorial or reference page in this tutorial, as well as a list of relevant show-cased elements are provided.

## Using Gradle

All sample plugins are based on Gradle, see [Creating a Plugin Gradle Project](creating-plugin-project.html) to get started.

Additionally, the [Working with Gradle in IntelliJ IDEA](https://youtu.be/6V6G3RyxEMk) screencast offers a thorough introduction to Gradle functionality inside IntelliJ IDEA.

## Setting up Code Samples

Make sure plugins Git, Gradle, and Plugin DevKit are enabled.

Warning: Installing Plugin DevKit plugin

Plugin DevKit
plugin must be installed from JetBrains Marketplace ([Plugin Homepage](https://plugins.jetbrains.com/plugin/22851-plugin-devkit))
as it is not bundled since version 2023.3.

Clone the [intellij-sdk-code-samples](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/) GitHub repository via Git | Clone....
After successful cloning, the IDE suggests opening the project.

Select the code sample(s) to import via the [Gradle tool window](https://www.jetbrains.com/help/idea/gradle.html#link_gradle_project).

Alternatively, import all code samples available by choosing `_gradleCompositeBuild`, which links all Gradle projects in a Composite Build.

After successful import, the project appears in the Gradle tool window tree as a new node.

Assign a Java 17 SDK in `Settings | Build, Execution, Deployment | Build Tools | Gradle` for Gradle JVM.

Invoke Reload All Gradle Projects from the Gradle tool window toolbar if necessary.

## Running Code Samples

Run the plugin by using the Gradle [runIde](creating-plugin-project.html#executing-the-plugin) task shown under the corresponding project's Tasks node in the Gradle tool window.

