# IntelliJ Platform Plugin Template

The IntelliJ Platform Plugin Template is the alternative solution for creating a new Gradle-based IntelliJ Platform plugin with the [New Project Wizard](creating-plugin-project.html).

## Modular Plugin Template

Note: Experimental

The modular template is intended for plugins that are designed for [Split Mode](split-mode-and-remote-development.html) and modular plugin packaging from the start.

With increasing demand for the remote development support, JetBrains advices plugin developers to design their plugins modularly where UI and business logic are detached from each other.

Use the modular template when a plugin is expected to provide optimal low-latency UX and correct project interaction in [Split Mode](split-mode-and-remote-development.html) as well as in a monolithic IDE. To start developing a [split plugin](split-mode-and-remote-development.html), use the [IntelliJ Platform Modular Plugin Template](https://github.com/JetBrains/intellij-platform-modular-plugin-template).

The modular template provides:

* frontend, backend, and shared module layout

* split-mode-oriented Gradle configuration

* ready-to-use examples of RPC-based communication

## Classic Plugin Template

[IntelliJ Platform Plugin Template](https://github.com/JetBrains/intellij-platform-plugin-template) is a GitHub repository that provides a pure boilerplate template to make it easier to create a new Gradle-based plugin project.

The main goal of this template is to speed up the setup phase of plugin development for both new and experienced developers by preconfiguring the project scaffold and CI, linking to the proper documentation pages, and keeping everything organized.

Tip:

Note: This template uses [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html).

GitHub Template allows you to create a new repository from the scaffold without having to copy and paste content, clone repositories, or clear the history manually.
All you have to do is click the Use this template button on the GitHub project page (you must be logged in with your GitHub account).
After that, the GitHub Actions workflow will be triggered to override or remove any template-specific configurations, such as the plugin name, current changelog, etc.

Once this is complete, the project is ready to be cloned to your local environment and opened with [IntelliJ IDEA](https://www.jetbrains.com/idea/download).

For more details, refer to the [IntelliJ Platform Plugin Template](https://github.com/JetBrains/intellij-platform-plugin-template) project documentation.

Note:

The recording of the Busy Plugin Developer. Episode 0 webinar describes and shows [how to use the IntelliJ Platform Plugin Template](https://youtu.be/-6D5-xEaYig?t=230) in detail.

