# Gradle IntelliJ Plugin (1.x) – FAQ

Warning: Obsolescence Notice

Gradle IntelliJ Plugin (1.x) is no longer under active development.

Whenever possible, use [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html) instead.

## How to target 2022.3 platform?

Warning: Gradle Plugin

The Gradle plugin must be chosen depending on the target
[platform version](build-number-ranges.html#platformVersions).

2024.2+
: Requires
[IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html)

2022.3+
: Recommended
[IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html)
: Requires
[Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html)
(Obsolete)
1.10.1+

## How to modify JVM arguments of runIde task?

[runIde](tools-gradle-intellij-plugin.html#tasks-runide) task is a [Java Exec](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html) task and can be modified according to the documentation.

To add some JVM arguments while launching the IDE, configure [runIde](tools-gradle-intellij-plugin.html#tasks-runide) task as follows:

Kotlin:

```KOTLIN
tasks {
  runIde {
    jvmArgs("-DmyProperty=value")
  }
}
```

Groovy:

```GROOVY
runIde {
  jvmArgs "-DmyProperty=value"
}
```

## How to modify system properties of runIde task?

Using the [very same task documentation](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.JavaExec.html), configure [runIde](tools-gradle-intellij-plugin.html#tasks-runide) task:

Kotlin:

```KOTLIN
tasks {
  runIde {
    systemProperty("name", "value")
  }
}
```

Groovy:

```GROOVY
runIde {
  systemProperty("name", "value")
}
```

## How to disable automatic reload of dynamic plugins?

See [Enabling Auto-Reload](ide-development-instance.html#enabling-auto-reload) for important caveats.

Configure [runIde](tools-gradle-intellij-plugin.html#tasks-runide) task as follows:

Kotlin:

```KOTLIN
tasks {
  runIde {
    autoReloadPlugins.set(false)
  }
}
```

Groovy:

```GROOVY
runIde {
  autoReloadPlugins = false
}
```

## How to disable building searchable options?

Building searchable options can be disabled as a task:

Kotlin:

```KOTLIN
tasks {
  buildSearchableOptions {
    enabled = false
  }
}
```

Groovy:

```GROOVY
buildSearchableOptions.enabled = false
```

As a result of disabling building searchable options, the [Settings](settings.html) that the plugin provides won't be searchable in the `Settings` dialog.
Disabling of the task is suggested for plugins that are not intended to provide custom settings.

## How to show log file of sandbox instance?

The most convenient way to see the logs of running IDE is to add a tab to the Run tool window displaying the contents of `idea.log` file.
In the Gradle `runIde` run configuration, add the log file path according to [sandbox location](ide-development-instance.html#the-development-instance-sandbox-directory) as described in [View logs](https://www.jetbrains.com/help/idea/setting-log-options.html).

## How to add a custom file inside plugin distribution?

[prepareSandbox](tools-gradle-intellij-plugin.html#tasks-preparesandbox) task is a [Sync](https://docs.gradle.org/current/dsl/org.gradle.api.tasks.Sync.html) task and can be modified accordingly.
Something like following should work:

Kotlin:

```KOTLIN
tasks {
  prepareSandbox {
    from("yourFile") {
      into("${intellij.pluginName.get()}/lib/")
    }
  }
}
```

Groovy:

```GROOVY
prepareSandbox {
  from("yourFile") {
    into "${intellij.pluginName.get()}/lib/"
  }
}
```

## 

Task `setupDependencies` not found in root project

The [setupDependencies](tools-gradle-intellij-plugin.html#tasks-setupdependencies) task is designed to fetch the target IDE dependency from the IntelliJ Repository in the after-sync Gradle phase, but only when working inside IntelliJ IDEA – to make the IntelliJ SDK classes resolved and code completion available.
To achieve that, the [gradle-idea-ext-plugin](https://github.com/JetBrains/gradle-idea-ext-plugin) is used, which alters the IDEA project's `.idea/workspace.xml` file making the [setupDependencies](tools-gradle-intellij-plugin.html#tasks-setupdependencies) task activated on `after_sync` event.

Unfortunately, this entry remains even after disabling the `org.jetbrains.intellij` plugin in a project – the [setupDependencies](tools-gradle-intellij-plugin.html#tasks-setupdependencies) task won't be resolved appropriately, which produces the following exception:

```TEXT
Task 'setupDependencies' not found in root project 'projectName'.
```

To fix that, manually edit the `.idea/workspace.xml` file removing mentioned entry, go to the Gradle tool window, select the `Tasks Activation` action from the context menu of the root project item, and remove it.

## How to expose my plugin API sources to dependent plugins?

See the [Bundling Plugin API Sources](bundling-plugin-openapi-sources.html) section for details.

## 

The Plugin Verifier download directory is set to [...], but downloaded IDEs were also found in [...]

With the `1.10.0` release, the [runPluginVerifier](tools-gradle-intellij-plugin.html#tasks-runpluginverifier) task uses the `XDG_CACHE_HOME` environment variable (see [XDG Base Directory](https://wiki.archlinux.org/title/XDG_Base_Directory) for more details) to resolve the default directory for downloaded IDEs – instead of the user's home directory.
It is recommended to move the existing IDEs stored, e.g., in `~/.pluginVerifier/ides/` directory into `$XDG_CACHE_HOME$/pluginVerifier/ides` to avoid downloading them once again.

To keep the downloaded archives in the previous location, specify the given path explicitly to the [runPluginVerifier.downloadDir](tools-gradle-intellij-plugin.html#tasks-runpluginverifier-downloaddir) property:

Kotlin:

```KOTLIN
tasks {
  runPluginVerifier {
    downloadDir.set(System.getProperty("user.home") + "/.pluginVerifier/ides")
  }
}
```

Groovy:

```GROOVY
runPluginVerifier {
  downloadDir = System.getProperty("user.home") + "/.pluginVerifier/ides"
}
```

## JaCoCo Reports 0% Coverage

The Gradle IntelliJ Plugin, when targeting the IntelliJ SDK `2022.1+`, uses the `PathClassLoader` class loader by the following system property:

```TEXT
-Djava.system.class.loader=com.intellij.util.lang.PathClassLoader
```

Because of that, JaCoCo – and other external tools that rely on classes available in the bootstrap class loader – fail to discover plugin classes.

In addition, if the code instrumentation is enabled (see [intellij.instrumentCode](tools-gradle-intellij-plugin.html#intellij-extension-instrumentcode)), it's required to switch to the compiled and instrumented output instead of a default compiled classes.

The following changes to the Gradle configuration file:

Kotlin:

```KOTLIN
tasks {
  withType<Test> {
    configure<JacocoTaskExtension> {
      isIncludeNoLocationClasses = true
      excludes = listOf("jdk.internal.*")
    }
  }

  jacocoTestReport {
    classDirectories.setFrom(instrumentCode)
  }

  jacocoTestCoverageVerification {
    classDirectories.setFrom(instrumentCode)
  }
}
```

Groovy:

```GROOVY
test {
  jacoco {
    includeNoLocationClasses = true
    excludes = ["jdk.internal.*"]
  }
}

jacocoTestReport {
  classDirectories.setFrom(instrumentCode)
}

jacocoTestCoverageVerification {
  classDirectories.setFrom(instrumentCode)
}
```

## 

Exception `SSLPeerUnverifiedException: peer not authenticated`

When using Java `11.0.2` for building plugins, resolving dependencies (or making any other network requests) in Gradle IntelliJ Plugin fails due to the [JDK-8220723](https://bugs.openjdk.org/browse/JDK-8220723) issue with the following exception:

```TEXT
Exception in thread "main" javax.net.ssl.SSLPeerUnverifiedException: peer not authenticated
```

To fix that issue, upgrade the Java version to the latest patch available of the chosen major version.

## How to add a dependency on a plugin available in the file system?

It is possible to add a dependency on a plugin available in the file system — like a plugin update downloaded manually from JetBrains Marketplace or built separately in another project.

To configure the dependency, add the `File` instance to the [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) property and point it to the extracted plugin's directory which contains the `lib` directory.

Kotlin:

```KOTLIN
intellij {
    plugins.set(listOf(file("/path/to/plugin/")))
}
```

Groovy:

```GROOVY
intellij {
    plugins = [file("/path/to/plugin/")]
}
```

It is also possible to refer to the sandbox directory of another Gradle project — to do that, point to the `/projects/plugin-name/build/idea-sandbox/plugins/plugin-name/` directory.

## 

Kotlin compiler throws `Out of memory. Java heap space` error

Please upgrade to Kotlin 1.9.0. See the [Incremental compilation](using-kotlin.html#incremental-compilation) section if using Kotlin 1.8.20.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

