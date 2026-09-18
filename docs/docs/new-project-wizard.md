# New Project Wizard API

Tip:

This section describes the New Project Wizard API, which is also used to create modules within projects.
The page uses "project wizard" wording for brevity.

The [New Project](https://www.jetbrains.com/help/idea/new-project-wizard.html) wizard items can be grouped into two main types:

* [Language Project Generators](#language-project-generators)

* [Framework Project Generators](#framework-project-generators)

Warning:

[Language](#language-project-generators) and [framework](#framework-project-generators) project generators described on this page work only in IDEs supporting Java.
See [How to implement a project wizard for non-Java IDEs?](#how-to-implement-a-project-wizard-for-non-java-ides) in the FAQ section.

## Language Project Generators

Language project generators allow for creating general-purpose projects without specific frameworks (they can be added to the project by users later).
Examples:

* a Kotlin project

* a Python project

These items are displayed at the top in the left sidebar of the New Project dialog.

Language project generators implement
[LanguageGeneratorNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/language/LanguageGeneratorNewProjectWizard.kt)
and are registered in [com.intellij.newProjectWizard.languageGenerator](https://jb.gg/ipe?extensions=com.intellij.newProjectWizard.languageGenerator) extension point
.

The generator implementation must provide:

* `name` and `icon` used in UI

* `ordinal` that is used to sort the generator in the generator list

* `isEnabled(WizardContext)` that allows controlling displaying the item depending on the current context

* `createStep(NewProjectWizardStep)` that creates the tree of steps that users go through during the project creation. Note the provided parent step, which exposes the wizard context, data holder, and other shared properties. See [Wizard Steps](#wizard-steps) for details.

Examples:

* [KotlinNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/kotlin/project-wizard/idea/src/org/jetbrains/kotlin/tools/projectWizard/KotlinNewProjectWizard.kt) generating Kotlin projects

* [PythonNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/python/pluginJava/src/com/intellij/python/community/plugin/java/PythonNewProjectWizard.kt) generating Python projects

## Framework Project Generators

Framework project wizards allow for creating projects related to a specific technology, for example:

* a Spring Boot project

* a project generated from a Maven Archetype

* a React project

These items are displayed under language generator items in the left sidebar of the New Project dialog.

Framework project wizards implement
[GeneratorNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/GeneratorNewProjectWizard.kt)
and are registered in [com.intellij.newProjectWizard.generator](https://jb.gg/ipe?extensions=com.intellij.newProjectWizard.generator) extension point
.

The interface exposes:

* unique `id`

* `name` and `icon` used in UI

* `ordinal` that is used to sort the generator in the generator list

* `isEnabled()` that allows controlling displaying the item depending on the current IDE context

* `createStep(WizardContext)` that creates the tree of steps that users go through during the project creation. See [Wizard Steps](#wizard-steps) for details.

Example: [MavenArchetypeNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/maven/src/main/java/org/jetbrains/idea/maven/wizards/archetype/MavenArchetypeNewProjectWizard.kt) creating Maven projects from a selected archetype

## Wizard Steps

Every project wizard consists of one or more steps that users go through during project creation.
Each step contains UI elements for data necessary to create a project.
All the steps are displayed on a single screen in the project wizard dialog, which displays the Create button that creates the project.

Tip:

Wizards implemented with the old API (`ModuleBuilder`) can create multiple vertical steps that are navigable with the Next and Previous buttons in the wizard dialog.
It caused many screens to be half-empty, and to improve the UX, new wizards display all steps on a single screen.

A project wizard step implements
[NewProjectWizardStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/NewProjectWizardStep.kt).
The most important methods are:

* `setupUI()` — defines the UI components for the step. Step UI is built with [Kotlin UI DSL](kotlin-ui-dsl-version-2.html)

* `setupProject()` — applies the parameters provided in UI to the generated project

See the example implementations in the [intellij-community](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/README.md) repository.

Steps build a tree structure (read the rest of this section for details), as some steps can be displayed depending on previously selected options.
`setupUI()` and `setupProject()` of steps building the tree are applied in the order from root to leaf.
Note that `setupProject()` won't be called for hidden steps.

For convenience, the platform provides
[AbstractNewProjectWizardStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/AbstractNewProjectWizardStep.kt),
which is a base step class that takes a parent step and delegates common property accessors to the parent.
It allows sharing the [root step's](#root-step) properties by all descendant steps.

### Chaining Steps

As mentioned before, all steps are rendered on a single screen.
Merging multiple steps into a chain displayed as a single screen step is achieved with
[NewProjectWizardChainStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/NewProjectWizardChainStep.kt).
Its companion object exposes a helper method `NewProjectWizardChainStep.nextStep()`, which allows chaining steps in fluent form, for example:

```KOTLIN
override fun createStep(context: WizardContext): NewProjectWizardStep {
  return RootNewProjectWizardStep(context)
    .nextStep(::FirstProjectWizardStep)
    .nextStep(::SecondProjectWizardStep)
    .nextStep(::ThirdProjectWizardStep)
}
```

All the steps above will be created inside a single `NewProjectWizardChainStep` and will be displayed (except the root step, which exists to hold shared data) in a single dialog page:

```PLANTUML
@startsalt
scale 1.2
title New Project
{+
  [] First Step Input 1
  First Step Input 2 | "value  "
  ..
  Second Step Input  | ^Selection^
  ..
  [] Third Step Input
  --
  [Cancel]|[Create]
}
@endsalt

```

### Root Step

The root project wizard step initializes a data holder and other properties shared with all descendant steps in the wizard.

In the case of [language project generators](#language-project-generators), the `LanguageGeneratorNewProjectWizard.createStep(NewProjectWizardStep)` receives a parent step, and there is no need to initialize these values and create a root step.

In the case of [framework project generators](#framework-project-generators), the root step can be created with [RootNewProjectWizardStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/RootNewProjectWizardStep.kt), which initializes shared properties.

### Common Steps

Almost every project requires providing the project name and the location where it should be created.
Also, projects are often shared in a Git repository.
The IntelliJ Platform provides:

* [NewProjectWizardBaseStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/NewProjectWizardBaseStep.kt), which handles the project Name and Location fields

* [GitNewProjectWizardStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/GitNewProjectWizardStep.kt), which is responsible for handling Git repository initialization if the user enables it

Note that [language project generators](#language-project-generators) already include these steps out of the box, and there is no need to create them in the wizard implementation.

### Asset Steps

Warning:

Note that `AssetsNewProjectWizardStep` requires a [dependency](plugin-dependencies.html) on the Java plugin.
In addition, it is marked as an experimental API.

It is often required to populate a created project with initial assets like:

* directory structure, for example, `src/main/java`, `src/main/resources`, `src/test/java`, `src/test/resources` in a Gradle Java project

* a build-tool-specific `.gitignore` file ignoring build and other directories and files

* sample code

This can be achieved by creating a step extending [AssetsNewProjectWizardStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/java/idea-ui/src/com/intellij/ide/projectWizard/generators/AssetsNewProjectWizardStep.kt).
It allows for adding directories, static assets, assets generated from [Freemarker templates](https://freemarker.apache.org/docs/dgui_quickstart_template.html), and granting them proper file permissions.

See example implementations in the [intellij-community](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/README.md) repository.

### Steps Forking the Wizard Flow

Sometimes, a wizard requires displaying different options depending on the user's selection.
For example, depending on the selected build tool, different fields specific to the selected build tool are displayed.

Such a behavior can be implemented with
[AbstractNewProjectWizardMultiStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/AbstractNewProjectWizardMultiStep.kt).

`AbstractNewProjectWizardMultiStep` internally handles steps forking the wizard flow.
It is responsible for:

* setting up the switcher

* setting up the selected step's UI

* applying the selected step's options to the created project

Forking steps are provided with an [extension point](plugin-extension-points.html) implementing
[NewProjectWizardMultiStepFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/NewProjectWizardMultiStepFactory.kt).
Besides the parent step, `AbstractNewProjectWizardMultiStep`'s constructor receives the name of the extension point implementing `NewProjectWizardMultiStepFactory` and uses registered [extensions](plugin-extensions.html) to create steps.

Tip:

Note that a plugin must implement a custom extension point, which may allow for adding new forking steps (for example, build tools) supported by other plugins.

The [Adding Support for Custom Build Systems in Language Project Wizards](#adding-support-for-custom-build-systems-in-language-project-wizards) section lists example implementations of `AbstractNewProjectWizardMultiStep`.

#### Adding Support for Custom Build Systems in Language Project Wizards

Some language project generators contain the Build system field that allows for choosing a build system used by a project.
This is achieved by implementing `AbstractNewProjectWizardMultiStep` described above.
Example implementations are:

* [JavaNewProjectWizard.Step](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/java/idea-ui/src/com/intellij/ide/projectWizard/generators/JavaNewProjectWizard.kt) — for Java language

* [KotlinNewProjectWizard.Step](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/kotlin/project-wizard/idea/src/org/jetbrains/kotlin/tools/projectWizard/KotlinNewProjectWizard.kt) — for Kotlin language

* [GroovyNewProjectWizard.Step](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/groovy/src/org/jetbrains/plugins/groovy/config/wizard/GroovyNewProjectWizard.kt) — for Groovy language

It is possible to add support for custom build systems by implementing extensions specific to these languages.
The table below shows the supported languages with corresponding interfaces and extension points:

| Language |Interface and Extension Point |Examples |
-----------------------------------------------------
| Java |[BuildSystemJavaNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/java/idea-ui/src/com/intellij/ide/projectWizard/generators/BuildSystemJavaNewProjectWizard.kt) [com.intellij.newProjectWizard.java.buildSystem](https://jb.gg/ipe?extensions=com.intellij.newProjectWizard.java.buildSystem)      |[IntelliJJavaNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/java/idea-ui/src/com/intellij/ide/projectWizard/generators/IntelliJJavaNewProjectWizard.kt) [MavenJavaNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/maven/src/main/java/org/jetbrains/idea/maven/wizards/MavenJavaNewProjectWizard.kt) [GradleJavaNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/gradle/java/src/service/project/wizard/GradleJavaNewProjectWizard.kt) |
| Kotlin |[BuildSystemKotlinNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/kotlin/project-wizard/idea/src/org/jetbrains/kotlin/tools/projectWizard/BuildSystemKotlinNewProjectWizard.kt) [com.intellij.newProjectWizard.kotlin.buildSystem](https://jb.gg/ipe?extensions=com.intellij.newProjectWizard.kotlin.buildSystem)      |[IntelliJKotlinNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/kotlin/project-wizard/idea/src/org/jetbrains/kotlin/tools/projectWizard/IntelliJKotlinNewProjectWizard.kt) [MavenKotlinNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/kotlin/project-wizard/maven/src/org/jetbrains/kotlin/tools/projectWizard/maven/MavenKotlinNewProjectWizard.kt) [GradleKotlinNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/kotlin/project-wizard/gradle/src/org/jetbrains/kotlin/tools/projectWizard/gradle/GradleKotlinNewProjectWizard.kt) |
| Groovy |[BuildSystemGroovyNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/groovy/src/org/jetbrains/plugins/groovy/config/wizard/BuildSystemGroovyNewProjectWizard.kt) [com.intellij.newProjectWizard.groovy.buildSystem](https://jb.gg/ipe?extensions=com.intellij.newProjectWizard.groovy.buildSystem)      |[IntelliJGroovyNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/groovy/src/org/jetbrains/plugins/groovy/config/wizard/IntelliJGroovyNewProjectWizard.kt) [IntelliJGroovyNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/groovy/src/org/jetbrains/plugins/groovy/config/wizard/IntelliJGroovyNewProjectWizard.kt) [GradleGroovyNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/gradle/java/groovy/src/service/project/wizard/GradleGroovyNewProjectWizard.kt) |

### Sharing Data Between Steps

Project wizards with multiple steps may require sharing data between them.
The recommended approach includes the following implementation steps:

Procedure:

Shared data can be accessed in another step in the following way:

```KOTLIN
class AnotherStep(parent: NewProjectWizardStep) :
   AbstractNewProjectWizardStep(parent) {

   override fun setupProject(project: Project) {
     // exampleData is available via this
     if (exampleData?.value == true) {
       doSomething()
     }
     // ...
   }
   // ...
}
```

### Property Graph

[PropertyGraph](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/observable/src/com/intellij/openapi/observable/properties/PropertyGraph.kt) creates an observable dependency graph that automatically propagates changes between related properties.
It is created in the [root step](#root-step) and shared between all descendant steps via [AbstractNewProjectWizardStep.propertyGraph](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/AbstractNewProjectWizardStep.kt).

`PropertyGraph` is widely used in wizard steps to create a responsive UI that dynamically updates depending on the user's actions.
It allows for:

* conditional visibility of fields based on other selections

* dynamic validation of user inputs

* automatic updates to dependent properties when primary properties change

* and more

Consider [NewProjectWizardBaseStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/NewProjectWizardBaseStep.kt).
It implements two graph properties for the project name and path:

```KOTLIN
override val nameProperty: GraphProperty<String> =
  propertyGraph.lazyProperty(::suggestName)
override val pathProperty: GraphProperty<String> =
  propertyGraph.lazyProperty { suggestLocation().toCanonicalPath() }
```

Both properties are lazily initialized with default values based on the current context.

Data properties delegate to the graph properties:

```KOTLIN
override var name: String by nameProperty
override var path: String by pathProperty
```

Any read or update of a data or graph property will update its counterpart.

Dependencies between properties are defined during step instance initialization:

```KOTLIN
init {
  nameProperty.dependsOn(pathProperty, ::suggestUniqueName)
}
```

It means that whenever `pathProperty` is changed, the `nameProperty` will be updated using the provided `suggestUniqueName()` function.

Properties are also bound to the UI allowing for synchronizing them with the UI in both directions:

```KOTLIN
textField()
  .bindText(nameProperty.trim())
...
textFieldWithBrowseButton(fileChooserDescriptor, context.project)
   .bindText(pathProperty.toUiPathProperty())
```

In addition, there is another graph property created from path and name graph properties:

```KOTLIN
val locationProperty = pathProperty.joinCanonicalPath(nameProperty)
```

`locationProperty` will be updated whenever `pathProperty` or `nameProperty` is updated, and it will contain a path built of the path and name.
The value of the property is bound to the comment component displayed under the location row:

```KOTLIN
textFieldWithBrowseButton(fileChooserDescriptor, context.project)
  // ...
  .locationComment(context, locationProperty)
```

`PropertyGraph` has many possibilities that are hard to describe in detail.
It is recommended to experiment with existing project wizards and [exploring their implementations](explore-api.html).

#### Persisting Default Settings

It is convenient for users to remember commonly used settings, so they don't need to fill them again.
Consider the checkbox initializing a Git repository in a created project.
When the user selects it for the first time, and later they create another project, the checkbox will be automatically selected.

This behavior can be implemented by binding graph properties to persistent storage via methods from
[BindUtil](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-api/src/com/intellij/openapi/observable/util/BindUtil.kt),
for example:

```KOTLIN
private val gitProperty = propertyGraph.property(false)
    .bindBooleanStorage(GIT_PROPERTY_NAME)
```

Under the hood, properties are stored at the application level via [PropertiesComponent](persisting-state-of-components.html#using-propertiescomponent-for-simple-non-roamable-persistence) under the `GIT_PROPERTY_NAME` key.

### Example Project Wizard Steps Structure

The following diagram presents the steps flow of the Kotlin language project wizard implemented by
[KotlinNewProjectWizard](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/kotlin/project-wizard/idea/src/org/jetbrains/kotlin/tools/projectWizard/KotlinNewProjectWizard.kt).

```PLANTUML
@startuml

skinparam DefaultFontName JetBrains Sans
skinparam DefaultFontSize 14
hide empty members
hide circle

card "NewProjectWizardChainStep" {
  rectangle "RootNewProjectWizardStep" as RootStep
  rectangle "NewProjectWizardBaseStep" as BaseStep
  rectangle "GitNewProjectWizardStep" as GitStep
  rectangle "NewProjectWizardLanguageStep" as LanguageStep

  rectangle "KotlinNewProjectWizard.Step" as KotlinStep
  rectangle "MavenKotlinNewProjectWizard" as KotlinMavenWizard
  rectangle "MavenKotlinNewProjectWizard.Step" as KotlinMavenStep
  rectangle "MavenKotlinNewProjectWizard.AssetsStep" as KotlinMavenAssetsStep
  rectangle "GradleKotlinNewProjectWizard" as KotlinGradleWizard
  rectangle "GradleKotlinNewProjectWizard.Step" as KotlinGradleStep
  rectangle "GradleKotlinNewProjectWizard.AssetsStep" as KotlinGradleAssetsStep

  RootStep -down-> BaseStep
  BaseStep -down-> GitStep
  GitStep -down-> LanguageStep
  LanguageStep -down-> KotlinStep

  KotlinStep -down-> KotlinMavenWizard : "select Maven"
  KotlinMavenWizard -down-> KotlinMavenStep : "creates"
  KotlinMavenStep -down-> KotlinMavenAssetsStep

  KotlinStep -down-> KotlinGradleWizard : "select Gradle"
  KotlinGradleWizard -down-> KotlinGradleStep : "creates"
  KotlinGradleStep -down-> KotlinGradleAssetsStep
}

@enduml
```

The following steps are always present in [language project generators](#language-project-generators) and are created by the platform under the hood:

* `RootNewProjectWizardStep` — initializes shared properties like data holder and property graph

* `NewProjectWizardBaseStep` — displays project name and location options

* `GitNewProjectWizardStep` — allows for creating a Git repository for the new project

* `NewProjectWizardLanguageStep` — invisible step holding information about the chosen language (this step is deprecated and is used only for technical reasons; it shouldn't be used by plugins)

All steps are enclosed within `NewProjectWizardChainStep`, which renders them on a single screen.

`KotlinNewProjectWizard.Step` is a [multistep](#steps-forking-the-wizard-flow) that forks the wizard flow into two paths depending on the user selection in the Build system switcher:

1. Maven-specific, if the user selected Maven

2. Gradle-specific, if the user selected Gradle

It creates the actual steps by using registered step factory extensions (`MavenKotlinNewProjectWizard` and `GradleKotlinNewProjectWizard`).

Depending on the selection, the platform executes `setupUI()` and `setupProject()` methods of enabled steps.

## FAQ

### How to determine whether the current context is a project or a module creation?

Use [WizardContext.isCreatingNewProject()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-core/src/com/intellij/ide/util/projectWizard/WizardContext.java).
The wizard context is available in every step via [NewProjectWizardStep.context](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/NewProjectWizardStep.kt).

### How to add a project wizard hint?

Sometimes, a project wizard requires an explanation about the purpose of the wizard or links to an alternative item.
To add a simple comment, use [CommentNewProjectWizardStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/comment/CommentNewProjectWizardStep.kt), for example, [EmptyProjectGeneratorNewProjectWizard.CommentStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/language/EmptyProjectGeneratorNewProjectWizard.kt)

To additionally render a clickable link to another wizard, use [LinkNewProjectWizardStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/ide/wizard/comment/LinkNewProjectWizardStep.kt), for example, [MavenArchetypeNewProjectWizard.CommentStep](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/maven/src/main/java/org/jetbrains/idea/maven/wizards/archetype/MavenArchetypeNewProjectWizard.kt).

### How to implement a project wizard for non-Java IDEs?

To create project wizards for non-Java IDEs (for example, [PyCharm](https://www.jetbrains.com/pycharm/)), implement
[DirectoryProjectGenerator](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/platform/DirectoryProjectGenerator.java)
and register it in the [com.intellij.directoryProjectGenerator](https://jb.gg/ipe?extensions=com.intellij.directoryProjectGenerator) extension point
.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

