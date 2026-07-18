# Migrating DevKit Plugin to Gradle

Tip:

See [Revamping Plugins #3 – Migrating from DevKit to the Gradle build system](https://blog.jetbrains.com/platform/2021/12/migrating-from-devkit-to-the-gradle-build-system/) blog post for a step-by-step walk-through.

Converting a plugin created with the old DevKit approach (which can be used for [creating themes](creating-theme-project.html)) to a Gradle-based plugin project can be done using the New Project wizard to create a Gradle-based project around the existing DevKit-based project:

* Ensure the directory containing the DevKit-based IntelliJ Platform plugin project can be fully recovered if necessary.

* Delete all the artifacts of the DevKit-based project: * `.idea` directory * `[modulename].iml` file * `out` directory

* Arrange the existing source files within the project directory in the Gradle [source set](https://docs.gradle.org/current/userguide/java_plugin.html#sec:java_project_layout) format.

* Use the [New Project](creating-plugin-project.html#create-ide-plugin) wizard as though creating a new Gradle-based plugin project from scratch. On the New Project page choose the IDE Plugin generator and set the values of: * Group to the existing package in the initial source set. * Artifact to the name of the existing plugin. * Name to the name of the directory where the existing plugin is located, e.g. if the plugin project base directory is `/Users/john/Projects/old_plugin`, it should be the `old_plugin`. * Location to the name of the plugin's parent directory, e.g. if the plugin project base directory is `/Users/john/Projects/old_plugin`, it should be the `/Users/john/Projects`.

* Click Finish to create the new Gradle-based plugin.

* [Add more modules](https://www.jetbrains.com/help/idea/gradle.html#gradle_add_module) using Gradle [source sets](https://www.jetbrains.com/help/idea/gradle.html#gradle_source_sets) as needed.

