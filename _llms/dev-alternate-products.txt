# Plugins Targeting IntelliJ Platform-Based IDEs

Plugin projects can target any (custom) IDEs, as long as the products are based on the [IntelliJ Platform](intellij-platform.html).
Such plugins are developed much like plugin projects that target IntelliJ IDEA.

Modifications are required to the project's Gradle build script and `[plugin.xml](plugin-configuration-file.html)` files, as described below
and on the individual product pages in Product Specific.
The Gradle build script is modified to specify the target product, determining the APIs available to the plugin.
The `plugin.xml` file is modified to declare the plugin's dependencies on plugins and modules.

## IntelliJ Platform Gradle Plugin (2.x)

A dependency on a specific IDE is defined in the Gradle build script using the builtin extensions listed in [Target Platforms](tools-intellij-platform-gradle-plugin-dependencies-extension.html#target-platforms).
Then, dependencies on required bundled modules and plugins must be defined in the `plugin.xml` file.
The necessary configuration for the corresponding product can be found under Product Specific (for example, for [WebStorm](webstorm.html)).

See also [Plugin Compatibility with IntelliJ Platform Products](plugin-compatibility.html).

## Gradle IntelliJ Plugin (1.x)

Warning: Obsolescence Notice

Gradle IntelliJ Plugin (1.x) is no longer under active development.

Whenever possible, use [IntelliJ Platform Gradle Plugin (2.x)](tools-intellij-platform-gradle-plugin.html) instead.

To create a new Gradle plugin project, follow the tutorial on the [Creating a Plugin Gradle Project](creating-plugin-project.html) page.
The tutorial produces a skeleton Gradle project suitable to use as a starting point.

The best practice is to use the [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) property to specify the target product.
For example, `PY` for PyCharm Professional.
Configuration using an `intellij.type` property is explained in the [Using a Product-Specific Attribute](#using-a-product-specific-attribute) section below.

NOTE: Not all products have an `intellij.type` property defined by the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html), for example, [Android Studio](android-studio.html) and [PhpStorm](phpstorm.html).
Please see their respective pages for configuration and
[Configuring Gradle Build Script Using the IntelliJ IDEA Product Attribute](#configuring-gradle-build-script-using-the-intellij-idea-product-attribute) below.

All the Gradle configuration attributes described here are discussed in-depth on the [Configuring Gradle IntelliJ Plugin (1.x)](configuring-plugin-project.html) and the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html).

Note:

To target multiple products (for example, IntelliJ IDEA and PyCharm) with the same plugin, see [Plugin Compatibility with IntelliJ Platform Products](plugin-compatibility.html) page.

### Using a Product-Specific Attribute

If the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) supports a target product directly, there will be an [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) property defined.
Specifying the target as a product-specific `intellij.type` property has two advantages:

* The APIs available to the plugin will be limited to only what is defined in the target product (unless additional plugin dependencies are specified).

* The default [IDE Development Instance](ide-development-instance.html) for running the plugin will be the target product.

A Gradle build script snippet setting a plugin project to target [PyCharm](pycharm.html) is shown below.
The [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) will fetch the matching build of PyCharm Professional to define the APIs available, and use that build of PyCharm (and associated JetBrains Runtime) as the Development Instance.
No additional product-specific configuration needs to be set in the Gradle build script:

Kotlin:

```KOTLIN
intellij {
  type.set("PY")
  version.set("2019.2.3")
}
```

Groovy:

```GROOVY
intellij {
  type = 'PY'
  version = '2019.2.3'
}
```

### Using the IntelliJ IDEA Product Attribute

If the [Gradle IntelliJ Plugin (1.x)](tools-gradle-intellij-plugin.html) does not directly support an IntelliJ Platform-based product, the Gradle build script can still be configured to target the desired product.
In this case, the build script is configured to use IntelliJ IDEA as the basis for the available APIs.
This does have the drawback that APIs not specific to the target product might accidentally be included in the plugin project.
However, testing the plugin project in the target product itself helps to find such mistakes.

Additional configuration must be done to match the version of IntelliJ IDEA to the version of the target product.
Understanding the relationship between build numbers is critical when using this approach to project configuration:

* targetIDE is the (version-specific) IntelliJ Platform-based IDE in which the plugin is intended to run, such as Android Studio or PhpStorm.

* baseIntelliJPlatformVersion is the (version-specific) IntelliJ Platform used in the build of the targetIDE. The IntelliJ Platform is defined by a specific build of the IntelliJ IDEA. The Gradle plugin attribute [intellij.version](configuring-plugin-project.html#intellij-platform-configuration) is set to be baseIntelliJPlatformVersion.

For API compatibility, the IntelliJ Platform version used in the targetIDE dictates the baseIntelliJPlatformVersion used for developing a plugin.

#### Matching Versions of the IntelliJ Platform with the Target IDE Version

The baseIntelliJPlatformVersion used in the targetIDE may not be readily apparent, depending on the product.
See the individual product pages in Product Specific for exceptions.

To find the version of the IntelliJ Platform used to build the targetIDE, use the About dialog screen for the targetIDE.
Next to Build # is the BRANCH.BUILD.FIX version of the targetIDE.
In the example shown below, the BRANCH.BUILD.FIX version is `192.7142.41`, and the product version is `2019.2.4`.
The version of the IntelliJ Platform used to build this product version is BRANCH.BUILD, or `192.7142`

![Example PhpStorm Splash Screen](images/phpstorm_build.png)
If the product version isn't clear on the About screen, consult the individual product pages in Product Specific.

The [Other IntelliJ IDEA Versions](https://www.jetbrains.com/idea/download/other.html) page is a way to find build numbers for every product version.
Additional ways include hovering over the version number for a product in [Toolbox App](https://www.jetbrains.com/toolbox-app/) or examining the About screen for IntelliJ IDEA.
In this example, IntelliJ IDEA for `2019.2.4` is build number `192.7142.36`.
Although the FIX versions are different, this is not uncommon between products, and the builds are still compatible.
The BRANCH and BUILD numbers match, therefore, in this PhpStorm example:

* The targetIDE is PhpStorm, build `192.7142.41`,

* The baseIntelliJPlatformVersion is build `192.7142.36`

This information is used to configure the plugin project's Gradle build script and `plugin.xml` file.

#### Configuring Gradle Build Script Using the IntelliJ IDEA Product Attribute

Configuring a Gradle plugin project for using baseIntelliJPlatformVersion requires changing some default settings in the Gradle build script.
Changes need to be made in two places: [intellij](tools-gradle-intellij-plugin.html#configuration-intellij-extension) extension and [runIde](tools-gradle-intellij-plugin.html#tasks-runide) task.

The Gradle plugin attributes describing the configuration of the [IntelliJ Platform used to build the plugin project](configuring-plugin-project.html#intellij-platform-configuration) must be explicitly set in the `intellij` task.
The [intellij.type](tools-gradle-intellij-plugin.html#intellij-extension-type) is `IU` because although the IntelliJ IDEA defines the IntelliJ Platform, the PHP plugin is only compatible with IntelliJ IDEA Ultimate.
The [intellij.version](tools-gradle-intellij-plugin.html#intellij-extension-version) is baseIntelliJPlatformVersion.

Any [dependencies](configuring-plugin-project.html#plugin-dependencies) on targetIDE-specific plugins or modules must be declared in the [intellij](tools-gradle-intellij-plugin.html#configuration-intellij-extension) extension.
Use the Gradle plugin attribute [intellij.plugins](tools-gradle-intellij-plugin.html#intellij-extension-plugins) to declare a dependency.
See the specific product pages in Product Specific for the targetIDE plugin or module name.

The best practice is to modify the [runIde](tools-gradle-intellij-plugin.html#tasks-runide) task to use a local installation of targetIDE as the [IDE Development Instance](ide-development-instance.html).
Set the [runIde.ideDir](tools-gradle-intellij-plugin.html#tasks-runide-idedir) attribute to the (user-specific) absolute path of the targetIDE application.
The exact path format varies by operating system.

This snippet is an example for configuring the Setup and Running DSLs in a Gradle build script specific to developing a plugin for targetIDE.

Kotlin:

```KOTLIN
intellij {
  // Define IntelliJ Platform against which to build the plugin project.
  type.set("IU")

  // Use the IntelliJ Platform BRANCH.BUILD version matching
  // "targetIDE" (PhpStorm):
  version.set("192.7142.36")   // baseIntelliJPlatformVersion

  // Require the targetIDE plugin or library. Use the stable version
  // compatible with intellij.version and intellij.type specified above:
  plugins.set(listOf("com.jetbrains.php:192.6603.42"))
}

runIde {
  // Absolute path to the installed targetIDE to use as IDE Development
  // Instance (the "Contents" directory is macOS specific):
  ideDir.set(file("/Users/$USERNAME$/Library/Application Support/JetBrains/Toolbox/apps/PhpStorm/ch-0/192.7142.41/PhpStorm.app/Contents"))
}
```

Groovy:

```GROOVY
intellij {
  // Define IntelliJ Platform against which to build the plugin project.
  type = 'IU'

  // Use the IntelliJ Platform BRANCH.BUILD version matching
  // "targetIDE" (PhpStorm):
  version = '192.7142.36'      // baseIntelliJPlatformVersion

  // Require the targetIDE plugin or library. Use the stable version
  // compatible with intellij.version and intellij.type specified above:
  plugins = ['com.jetbrains.php:192.6603.42']
}

runIde {
  // Absolute path to the installed targetIDE to use as IDE Development
  // Instance (the "Contents" directory is macOS specific):
  ideDir = file('/Users/$USERNAME$/Library/Application Support/JetBrains/Toolbox/apps/PhpStorm/ch-0/192.7142.41/PhpStorm.app/Contents')
}
```

### Configuring plugin.xml

As discussed on the [Declaring Plugin Dependencies](plugin-compatibility.html#declaring-plugin-dependencies) page of this guide, a plugin's dependency on [Modules Specific to Functionality](plugin-compatibility.html#modules-specific-to-functionality) must be declared in `plugin.xml`.
When using features (APIs) specific to the target product, a dependency on the target product module must be declared, as shown in the code snippet below.
Otherwise, if only general IntelliJ Platform features (APIs) are used, then a dependency on `com.intellij.modules.platform` must be declared as discussed in [Plugin Compatibility with IntelliJ Platform Products](plugin-compatibility.html).

Note:

In the particular case of a plugin project declaring dependencies only on other plugins, it must also declare a dependency on `com.intellij.modules.platform`.
Otherwise, the plugin project is considered to be legacy and will only load in IntelliJ IDEA.

Continuing with the example of developing a plugin for PhpStorm:

```XML
<!-- Targeting PhpStorm, so is dependent on the PHP plugin -->
<depends>com.jetbrains.php</depends>
<depends>com.intellij.modules.platform</depends>
```

