# 1. Prerequisites

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

## Download and Install IntelliJ IDEA

Download and install IntelliJ IDEA from [here](https://www.jetbrains.com/idea/download/).

## Check out IntelliJ Platform Source Files

Note:

While not required, having the full sources of the platform and all bundled plugins available for browsing allows finding related implementations.

Download the IntelliJ Platform source files as described in the IntelliJ IDEA [README](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/README.md) file.

## Install Required Plugins

Make sure that the Plugin DevKit and Gradle plugins are enabled.

Warning: Installing Plugin DevKit plugin

Plugin DevKit
plugin must be installed from JetBrains Marketplace ([Plugin Homepage](https://plugins.jetbrains.com/plugin/22851-plugin-devkit))
as it is not bundled since version 2023.3.

Install and enable [Grammar-Kit](https://plugins.jetbrains.com/plugin/6606-grammar-kit) and [PsiViewer](https://plugins.jetbrains.com/plugin/227-psiviewer) (optionally) plugins.

## Create a Project

Create an empty [IntelliJ Platform Plugin project](creating-plugin-project.html).

