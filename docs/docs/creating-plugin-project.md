# Creating a Plugin Project

The recommended approach to creating a plugin is the IDE Plugin wizard available in IntelliJ IDEA.
The wizard is available when Gradle and Plugin DevKit plugins are [installed and enabled](https://www.jetbrains.com/help/idea/managing-plugins.html).

It is also possible to create plugins via the web [IDE Plugin generator](https://plugins.jetbrains.com/generator).

Note:

This page describes the wizard available in IntelliJ IDEA 2026.1 and newer.

The IDE Plugin wizard available in older versions may differ in available options.
If the newest IDE cannot be used, consider generating a project via the [web generator](https://plugins.jetbrains.com/generator) and opening the generated project in the IDE.

Procedure: Create an IDE Plugin

The created project structure is described in the `README.md` file in the Project structure section.

## Running the Plugin

Note:

If the Add sample code checkbox was not checked during the project generation, add sample code.
For example, follow the [Creating Actions](creating-actions-tutorial.html) tutorial to add a menu action.

Classic Plugin:

The generated project contains the Run IDE with Plugin [run configuration](https://www.jetbrains.com/help/idea/run-debug-configuration.html) that can be executed via the `Run | Run...` action or can be found in the Gradle tool window under the Run Configurations node.

To execute the Gradle `runIde` task directly, open the Gradle tool window and search for the runIde task under the Tasks node.
If it's not on the list, click the Sync All Gradle Projects button on the [toolbar](https://www.jetbrains.com/help/idea/jetgradle-tool-window.html#gradle_toolbar) at the top of the Gradle tool window.
Then double-click it to execute.

Split Mode (Remote Dev) Plugin:

The generated project contains the Run IDE with Plugin (Split Mode) [run configuration](https://www.jetbrains.com/help/idea/run-debug-configuration.html) that can be executed via the `Run | Run...` action.

Alternatively, run Run IDE with Plugin (Backend) and Run IDE with Plugin (Frontend) separately.

To execute the Gradle tasks directly, open the Gradle tool window and search for the runIdeBackend and runIdeFrontend tasks under the Tasks node.
If they are not on the list, click the Sync All Gradle Projects button on the [toolbar](https://www.jetbrains.com/help/idea/jetgradle-tool-window.html#gradle_toolbar) at the top of the Gradle tool window.
Then double-click tasks to execute.

To debug a plugin in a standalone IDE instance, please see [How to Debug Your Own IntelliJ IDEA Instance](https://medium.com/agorapulse-stories/how-to-debug-your-own-intellij-idea-instance-7d7df185a48d) blog post.

Tip:

For more information about how to work with Gradle-based projects see the [Working with Gradle in IntelliJ IDEA](https://www.youtube.com/watch?v=6V6G3RyxEMk) screencast and working with [Gradle tasks](https://www.jetbrains.com/help/idea/work-with-gradle-tasks.html) in the IntelliJ IDEA help.

