# Recipes

## Run a custom task with a customized sandbox location

To create a custom task with the sandbox directory specified outside the default `build/idea-sandbox/[TYPE]-[VERSION]/` location, pass the new location to its `prepareSandboxTask` sandbox producer configuration:

Kotlin:

```KOTLIN
val runWithCustomSandbox by intellijPlatformTesting.runIde.registering {
  // ...

  prepareSandboxTask {
    sandboxDirectory = project.layout.buildDirectory.dir("custom-sandbox")
    sandboxSuffix = ""
  }
}
```

Groovy:

```GROOVY
intellijPlatformTesting.runIde {
  runWithCustomSandbox {
    // ...

    prepareSandboxTask {
      sandboxDirectory = project.layout.buildDirectory.dir('custom-sandbox')
      sandboxSuffix = ''
    }
  }
}
```

This will result in the following sandbox structure:

```
build/
├── custom-sandbox
│   ├── config
│   ├── log
│   ├── plugins
│   └── system
...
```

## Access IntelliJ Platform from any Gradle task

With [Task Awares](tools-intellij-platform-gradle-plugin-task-awares.html) it is possible to enhance any Gradle task with features provided with the IntelliJ Platform Gradle Plugin.

Kotlin:

```KOTLIN
import org.jetbrains.intellij.platform.gradle.tasks.aware.IntelliJPlatformVersionAware

abstract class MyTask : DefaultTask(), IntelliJPlatformVersionAware

val myTask by tasks.registering(MyTask::class) {
  doLast {
    println("platformPath = \n${platformPath}")
    println("productInfo.buildNumber = ${productInfo.buildNumber}")
  }
}
```

Groovy:

```GROOVY
import org.jetbrains.intellij.platform.gradle.tasks.aware.IntelliJPlatformVersionAware

abstract class MyTask extends DefaultTask implements IntelliJPlatformVersionAware {}

tasks.register('myTask', MyTask) {
  doLast {
    println("platformPath = \n${platformPath}")
    println("productInfo.buildNumber = ${productInfo.buildNumber}")
  }
}
```

As soon as the registered task inherits from the `*Aware` interface, such as [IntelliJPlatformVersionAware](tools-intellij-platform-gradle-plugin-task-awares.html#IntelliJPlatformVersionAware), all the related information will be injected during the configuration phase.

## Bundle additional files with the plugin

Additional files can be bundled by adding them to the plugin directory when preparing the sandbox:

Kotlin:

```KOTLIN
tasks {
  prepareSandbox {
    from(layout.projectDirectory.dir("extraFiles")) {
      into(pluginName.map { "$it/extra" })
    }
  }
}
```

Groovy:

```GROOVY
tasks.named('prepareSandbox', PrepareSandboxTask) {
  from layout.projectDirectory.dir('extraFiles')
  into it.pluginName.map { "$it/extra" }
}
```

To apply that to the custom task, use the [prepareSandboxTask](tools-intellij-platform-gradle-plugin-testing-extension.html#preparesandboxtask) reference:

Kotlin:

```KOTLIN
val runWithCustomSandbox by intellijPlatformTesting.runIde.registering {
  // ...

  prepareSandboxTask {
    from(...) {
      into(...)
    }
  }
}
```

Groovy:

```GROOVY
intellijPlatformTesting.runIde {
  runWithCustomSandbox {
    // ...

    prepareSandboxTask {
      from(...)
      into(...)
    }
  }
}
```

It is possible to apply that to all [PrepareSandboxTask](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox) with:

Kotlin:

```KOTLIN
tasks {
  withType<PrepareSandboxTask> {
    from(...) {
      into(...)
    }
  }
}
```

Groovy:

```GROOVY
tasks {
  withType(PrepareSandboxTask) {
    from(...)
    into(...)
  }
}
```

## Adjust IDE configuration by altering sandbox files

When starting the IDE locally with [runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde) task or running tests, the IDE creates and updates configuration files within the sandbox directory.
Those files may be related to trusted paths, macros, recent projects, custom plugins, color schemes, etc.
However, when running the `clean` task, all configuration files are wiped and do not persist between sessions.

Sometimes, it may be worth recreating such configuration, yet with the [prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox) task for those configurations to persist.
The following example marks the project located in the `$USER_HOME$/IdeaProjects/GradleProject` directory as trusted, like when the user clicks on the Trust Project dialog when opening it for the first time.

```KOTLIN
tasks.withType<PrepareSandboxTask> {
  doLast {
    val trustedPathsFile = sandboxConfigDirectory.file("options/trusted-paths.xml").get().asFile

    trustedPathsFile.writeText(
      """
            <application>
              <component name="Trusted.Paths">
                <option name="TRUSTED_PROJECT_PATHS">
                  <map>
                    <entry key="${'$'}USER_HOME$/IdeaProjects/GradleProject" value="true" />
                  </map>
                </option>
              </component>
            </application>
            """.trimIndent()
    )
  }
}
```

## ProGuard configuration

To configure [ProGuard](https://github.com/Guardsquare/proguard), intercept the [prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox) task and replace the plugin Jar archive produced by the [composedJar](tools-intellij-platform-gradle-plugin-tasks.html#composedJar) task with the obfuscated/minified file.

First, define the ProGuard Jar archive location and store it inside the `build/libs/` directory.
Pass the output ProGuard location to the `outjars()` helper and use it as a new sandbox input for [prepareSandbox.pluginJar](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox-pluginJar).

Finally, pass the [composedJar.archiveFile](tools-intellij-platform-gradle-plugin-tasks.html#composedJar-archiveFile) to the `injars()` helper.

Kotlin:

```KOTLIN
import proguard.gradle.ProGuardTask

buildscript {
  repositories {
    mavenCentral()
  }
  dependencies {
    classpath("com.guardsquare:proguard-gradle:7.5.0")
  }
}

tasks {
  val proguardJar = layout.buildDirectory.file("libs/$name-$version-proguard.jar")

  val proguard by registering(ProGuardTask::class) {
    injars(composedJar.map { it.archiveFile })
    outjars(proguardJar)

    // ...
  }

  prepareSandbox {
    pluginJar = proguardJar
    dependsOn(proguard)
  }
}
```

Groovy:

```GROOVY
import proguard.gradle.ProGuardTask

buildscript {
  repositories {
    mavenCentral()
  }
  dependencies {
    classpath("com.guardsquare:proguard-gradle:7.5.0")
  }
}

def proguardJar = layout.buildDirectory.file("libs/$name-$version-proguard.jar")

tasks.register('proguard', ProGuardTask) {
  it.injars(composedJar.archiveFile)
  outjars(proguardJar)

  // ...
}

prepareSandbox {
  pluginJar = proguardJar
  dependsOn(proguard)
}
```

## Run the IDE with a default argument provided

When running the IDE from the command line, you can pass an argument, like a path to the project or file, to open it automatically.
This is also possible when using the [runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde) task:

Kotlin:

```KOTLIN
tasks {
  runIde {
    argumentProviders += CommandLineArgumentProvider {
      listOf("/path/to/the/project")
    }
  }
}
```

Groovy:

```GROOVY
runIde {
  argumentProviders.add({
    ['/path/to/the/project']
  } as CommandLineArgumentProvider)
}
```

## Run the IDE in LightEdit mode

Pass the IntelliJ IDEA `-e` or `--edit` argument to [runIde](tools-intellij-platform-gradle-plugin-tasks.html#runIde) to open a file in LightEdit mode:

```BASH
./gradlew runIde --args='-e /absolute/path/to/file'
```

Omit the file path to open an empty LightEdit window. To keep this setup as a separate reusable task, register a custom `runIde` task:

Kotlin:

```KOTLIN
val runIdeLightEdit by intellijPlatformTesting.runIde.registering {
  task {
    args("-e", project.layout.projectDirectory.file("README.md").asFile.absolutePath)
  }
}
```

Groovy:

```GROOVY
intellijPlatformTesting.runIde {
  runIdeLightEdit {
    task {
      args '-e', project.layout.projectDirectory.file('README.md').asFile.absolutePath
    }
  }
}
```

## Resolve plugin from JetBrains Marketplace in the latest compatible version

When setting a dependency on an external plugin from JetBrains Marketplace, it is necessary to provide its ID and version in `pluginId:version` notation.
However, it is possible to request JetBrains Marketplace API for the compatible plugin updates with the given IntelliJ Platform build version.

The following snippet requests the API using the current IntelliJ Platform type and build version, and picks the first available version, which is later passed to the common [plugin()](tools-intellij-platform-gradle-plugin-dependencies-extension.html#plugins) dependency helper.

```KOTLIN
import org.jetbrains.intellij.platform.gradle.extensions.IntelliJPlatformDependenciesExtension
import org.jetbrains.intellij.pluginRepository.PluginRepositoryFactory

val IntelliJPlatformDependenciesExtension.pluginRepository by lazy {
    PluginRepositoryFactory.create("https://plugins.jetbrains.com")
}

fun IntelliJPlatformDependenciesExtension.pluginsInLatestCompatibleVersion(vararg pluginIds: String) =
    plugins(provider {
        pluginIds.map { pluginId ->
            val platformType = intellijPlatform.productInfo.productCode
            val platformVersion = intellijPlatform.productInfo.buildNumber

            val plugin = pluginRepository.pluginManager.searchCompatibleUpdates(
                build = "$platformType-$platformVersion",
                xmlIds = listOf(pluginId),
            ).firstOrNull()
                ?: throw GradleException("No plugin update with id='$pluginId' compatible with '$platformType-$platformVersion' found in JetBrains Marketplace")

            "${plugin.pluginXmlId}:${plugin.version}"
        }
    })

dependencies {
    // ...

    intellijPlatform {
        // ...
        pluginsInLatestCompatibleVersion("org.coffeescript", ...)
    }
}
```

