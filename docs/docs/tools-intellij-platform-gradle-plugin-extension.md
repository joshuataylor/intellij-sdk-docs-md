# IntelliJ Platform Extension

Tip: FAQ

See [IntelliJ Platform Gradle Plugin – FAQ](tools-intellij-platform-gradle-plugin-faq.html) and [Migrating from Gradle IntelliJ Plugin (1.x)](tools-intellij-platform-gradle-plugin-migration.html).

The IntelliJ Platform Gradle Plugin introduces a top-level `intellijPlatform` extension.
It consists of sections dedicated to the general Gradle plugin configuration, `plugin.xml` definition, publishing, signing, and verifying of the output plugin for IntelliJ-based IDEs.

## IntelliJ Platform

After the IntelliJ Platform Gradle Plugin is [applied](tools-intellij-platform-gradle-plugin.html#setup), the `intellijPlatform` extension can be used to configure the plugin and common settings of the provided tasks.

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  buildSearchableOptions = true
  instrumentCode = true
  projectName = project.name
  sandboxContainer = "..."

  pluginConfiguration {
    // ...
  }
  publishing {
    // ...
  }
  signing {
    // ...
  }
  pluginVerification {
    // ...
  }
}
```

Groovy:

```GROOVY
intellijPlatform {
  buildSearchableOptions = true
  instrumentCode = true
  projectName = project.name
  sandboxContainer = '...'

  pluginConfiguration {
    // ...
  }
  publishing {
    // ...
  }
  signing {
    // ...
  }
  pluginVerification {
    // ...
  }
}
```

### 

`platformPath`

Provides read-only access to the IntelliJ Platform dependency artifact path.

Access
: Read-only

Type
: `Path`

Default value
: Path of the current IntelliJ Platform

### 

`productInfo`

Provides read-only access to the [ProductInfo](tools-intellij-platform-gradle-plugin-types.html#ProductInfo) object associated with the IntelliJ Platform dependency configured for the current project.

Access
: Read-only

Type
: [ProductInfo](tools-intellij-platform-gradle-plugin-types.html#ProductInfo)

Default value
: [ProductInfo](tools-intellij-platform-gradle-plugin-types.html#ProductInfo) of the current IntelliJ Platform

### 

`autoReload`

Enables auto-reload of dynamic plugins.
Dynamic plugin will be reloaded automatically when its content is modified.

This allows a much faster development cycle by avoiding a full restart of the development instance after code changes.

Type
: `Property<Boolean>`

Default value
: `true`

See also:

* [Enabling Auto-Reload](ide-development-instance.html#enabling-auto-reload)

* [Task Awares: AutoReloadAware](tools-intellij-platform-gradle-plugin-task-awares.html#AutoReloadAware)

### 

`buildSearchableOptions`

Builds an index of UI components (searchable options) for the plugin.
Controls the execution of the [buildSearchableOptions](tools-intellij-platform-gradle-plugin-tasks.html#buildSearchableOptions) task.

Type
: `Property<Boolean>`

Default value
: `true`

See also:

* [Gradle Property: noSearchableOptionsWarning](tools-intellij-platform-gradle-plugin-gradle-properties.html#noSearchableOptionsWarning)

### 

`instrumentCode`

Enables the [instrumentCode](tools-intellij-platform-gradle-plugin-tasks.html#instrumentCode) of the compiled classes.

Controls the execution of the [instrumentCode](tools-intellij-platform-gradle-plugin-tasks.html#instrumentCode) task.

Type
: `Property<Boolean>`

Default value
: `true`

### 

`projectName`

Defines the project name, which is used for creating file structure and the build archive.

Type
: `Property<String>`

Default value
: `project.name`

### 

`sandboxContainer`

The path to the sandbox container where tests and IDE instances read and write data.

Type
: `DirectoryProperty`

Default value
: `[rootProject]/.intellijPlatform/sandbox`

See also:

* [Tasks: prepareSandbox](tools-intellij-platform-gradle-plugin-tasks.html#prepareSandbox)

* [Task Awares: SandboxAware](tools-intellij-platform-gradle-plugin-task-awares.html#SandboxAware)

### 

`splitMode`

Warning:

[Split Mode](split-mode-and-remote-development.html) requires the IntelliJ Platform in version `2025.3` or later.

Allows for checking how a plugin works in remote development mode, when one machine is running the backend part and another is running a frontend part (JetBrains Client) which connects to the backend.

This property allows running the IDE with backend and frontend parts running in separate processes.
Use [pluginInstallationTarget](#intellijPlatform-pluginInstallationTarget) to specify whether the developed plugin is installed in the frontend, backend, or both parts.

Type
: `Property<Boolean>`

Default value
: `false`

See also:

* [Task Awares: SplitModeAware](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware)

### 

`pluginInstallationTarget` (formerly `splitModeTarget`)

Warning:

[Split Mode](split-mode-and-remote-development.html) requires the IntelliJ Platform in version `241.14473` or later.

Specifies in which part of the product the developed plugin should be installed.
The default is backend-only, but [split plugins](split-mode-and-remote-development.html) often use `BOTH`.

Type
: [Property&lt;PluginInstallationTarget&gt;](tools-intellij-platform-gradle-plugin-types.html#SplitModeAware-PluginInstallationTarget)

Default value
: [PluginInstallationTarget.BACKEND](tools-intellij-platform-gradle-plugin-types.html#SplitModeAware-PluginInstallationTarget)

See also:

* [Task Awares: SplitModeAware](tools-intellij-platform-gradle-plugin-task-awares.html#SplitModeAware)

## Plugin Configuration

Configures the plugin definition and stores values in the `plugin.xml` file.
Data provided to the `intellijPlatform.pluginConfiguration {}` extension is passed to the [patchPluginXml](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml) task, which augments the `plugin.xml` file with new values.

Requires the [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform) plugin to be applied.

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  // ...

  pluginConfiguration {
    id = "my-plugin-id"
    name = "My Awesome Plugin"
    version = "1.0.0"
    description = "It's an awesome plugin!"
    changeNotes =
      """
      A descriptive release note...
      """.trimIndent()

    productDescriptor {
      // ...
    }
    ideaVersion {
      // ...
    }
    vendor {
      // ...
    }
  }
}
```

Groovy:

```GROOVY
intellijPlatform {
  // ...

  pluginConfiguration {
    id = 'my-plugin-id'
    name = 'My Awesome Plugin'
    version = '1.0.0'
    description = 'It\'s an awesome plugin!'
    changeNotes =
      """
      A descriptive release note...
      """.stripIndent()

    productDescriptor {
      // ...
    }
    ideaVersion {
      // ...
    }
    vendor {
      // ...
    }
  }
}
```

See also:

* [Product Descriptor](#intellijPlatform-pluginConfiguration-productDescriptor)

* [Idea Version](#intellijPlatform-pluginConfiguration-ideaVersion)

* [Vendor](#intellijPlatform-pluginConfiguration-vendor)

### 

`id`

The plugin's unique identifier.
This should mirror the structure of fully qualified Java packages and must remain distinct from the IDs of existing plugins.
This ID is a technical descriptor used not only within the IDE, but also on [JetBrains Marketplace](https://plugins.jetbrains.com/).

Please restrict input to characters, numbers, and `.`/`-`/`_` symbols, and aim for a concise length.

The provided value will populate the [&lt;id&gt;](plugin-configuration-file.html#idea-plugin__id) element.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.pluginId](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-pluginId)

### 

`name`

The plugin's display name, visible to users.
It should use Title Case.

The provided value is used to populate the [&lt;name&gt;](plugin-configuration-file.html#idea-plugin__name) element.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.pluginName](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-pluginName)

### 

`version`

The plugin version, presented in the Plugins settings dialog and on its JetBrains Marketplace page.

For plugins uploaded to the JetBrains Marketplace, [semantic versioning](https://plugins.jetbrains.com/docs/marketplace/semver.html) must be adhered to.

The provided value is used as a [&lt;version&gt;](plugin-configuration-file.html#idea-plugin__version) element.

Type
: `Property<String>`

Default value
: `project.version`, or empty when the project version is `unspecified`

See also:

* [Tasks: patchPluginXml.pluginVersion](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-pluginVersion)

### 

`description`

The plugin description, which is presented on the JetBrains Marketplace plugin page and in the Plugins settings dialog.
Basic HTML elements such as text formatting, paragraphs, and lists are permitted.

The description content is automatically enclosed in `<![CDATA[... ]]>`.

The provided value is used to populate the [&lt;description&gt;](plugin-configuration-file.html#idea-plugin__description) element.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.pluginDescription](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-pluginDescription)

### 

`changeNotes`

A concise summary of new features, bug fixes, and alterations provided in the latest plugin version.
These change notes will be displayed on the JetBrains Marketplace plugin page and in the Plugins settings dialog.
Basic HTML elements such as text formatting, paragraphs, and lists are permitted.

The change notes content is automatically enclosed in `<![CDATA[... ]]>`.

The provided value is used to populate the [&lt;change-notes&gt;](plugin-configuration-file.html#idea-plugin__change-notes) element.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.changeNotes](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-changeNotes)

If the Gradle Changelog Plugin (`org.jetbrains.changelog`) is applied, this value defaults to the rendered changelog entry for the current plugin version, or to the unreleased entry when no matching version exists.
The IntelliJ Platform Gradle Plugin also configures the Changelog Plugin defaults for empty groups, repository URL from `pluginRepositoryUrl`, and an empty version prefix.

## Product Descriptor

A part of the [Plugin Configuration](#intellijPlatform-pluginConfiguration) which describes the `product-descriptor` element.

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  // ...

  pluginConfiguration {
    // ...

    productDescriptor {
      code = "MY_CODE"
      releaseDate = "20240217"
      releaseVersion = "20241"
      optional = false
      eap = false
    }
  }
}
```

Groovy:

```GROOVY
intellijPlatform {
  // ...

  pluginConfiguration {
    // ...

    productDescriptor {
      code = 'MY_CODE'
      releaseDate = '20240217'
      releaseVersion = '20241'
      optional = false
      eap = false
    }
  }
}
```

See also:

* [How to add required parameters for paid plugins](https://plugins.jetbrains.com/docs/marketplace/add-required-parameters.html)

### 

`code`

The product code for the plugin, used in the JetBrains Sales System.
The value must be pre-approved by JetBrains and must adhere to [specified requirements](https://plugins.jetbrains.com/docs/marketplace/add-required-parameters.html).

The provided value is used for a `<product-descriptor code="">` element attribute.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.productDescriptorCode](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-productDescriptorCode)

* [Plugin Configuration File: product-descriptor](plugin-configuration-file.html#idea-plugin__product-descriptor)

### 

`releaseDate`

The release date of the major version, formatted as `YYYYMMDD`.

The provided value is used for the `<product-descriptor release-date="">` element attribute.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.productDescriptorReleaseDate](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-productDescriptorReleaseDate)

* [Plugin Configuration File: product-descriptor](plugin-configuration-file.html#idea-plugin__product-descriptor)

### 

`releaseVersion`

The major version, represented in a specific numerical format.

The provided value is used for the `<product-descriptor release-version="">` element attribute.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.productDescriptorReleaseVersion](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-productDescriptorReleaseVersion)

* [Plugin Configuration File: product-descriptor](plugin-configuration-file.html#idea-plugin__product-descriptor)

### 

`optional`

The boolean value that indicates if the plugin is a [Freemium](https://plugins.jetbrains.com/docs/marketplace/freemium.html) plugin.

The provided value is used for the `<product-descriptor optional="">` element attribute.

Type
: `Property<Boolean>`

Default value
: `false`

See also:

* [Tasks: patchPluginXml.productDescriptorOptional](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-productDescriptorOptional)

* [Plugin Configuration File: product-descriptor](plugin-configuration-file.html#idea-plugin__product-descriptor)

### 

`eap`

Specifies the boolean value determining whether the plugin is an EAP release.

The provided value is used for the `<product-descriptor eap="">` element attribute.

Type
: `Property<Boolean>`

Default value
: `false`

See also:

* [Tasks: patchPluginXml.productDescriptorOptional](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-productDescriptorOptional)

* [Plugin Configuration File: product-descriptor](plugin-configuration-file.html#idea-plugin__product-descriptor)

## Idea Version

A part of the [Plugin Configuration](#intellijPlatform-pluginConfiguration) which describes the [&lt;idea-version&gt;](plugin-configuration-file.html#idea-plugin__idea-version) element.

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  // ...

  pluginConfiguration {
    // ...

    ideaVersion {
      sinceBuild = "241"
      untilBuild = "241.*"
    }
  }
}
```

Groovy:

```GROOVY
intellijPlatform {
  // ...

  pluginConfiguration {
    // ...

    ideaVersion {
      sinceBuild = '241'
      untilBuild = '241.*'
    }
  }
}
```

See also:

* [Build Number Ranges](build-number-ranges.html)

### 

`sinceBuild`

The earliest IDE version that is compatible with the plugin.

The provided value is used for the `<idea-version since-build=""/>` element attribute.

The default value is set to the `MAJOR` build number based on the currently selected IntelliJ Platform, like `233`.

Type
: `Property<String>`

Default value
: `MAJOR`

See also:

* [Tasks: patchPluginXml.sinceBuild](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-sinceBuild)

### 

`untilBuild`

The latest IDE version that is compatible with the plugin.
An undefined value signifies compatibility with all IDEs starting from the version mentioned in `since-build`,
including potential future builds that may cause compatibility issues.

The provided value is used for the `<idea-version until-build=""/>` element attribute.

The default value is set to the `MAJOR.*` version based on the currently selected IntelliJ Platform, such as `233.*`.

The `until-build` attribute can be unset by providing `provider { null }` as a value:

Kotlin:

```KOTLIN
intellijPlatform {
  pluginConfiguration {
    ideaVersion {
      untilBuild = provider { null }
    }
  }
}
```

Groovy:

```GROOVY
intellijPlatform {
  pluginConfiguration {
    ideaVersion {
      untilBuild = provider { null }
    }
  }
}
```

Type
: `Property<String>`

Default value
: `MAJOR.*`

See also:

* [Tasks: patchPluginXml.untilBuild](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-untilBuild)

## Vendor

A part of the [Plugin Configuration](#intellijPlatform-pluginConfiguration) which describes the [&lt;vendor&gt;](plugin-configuration-file.html#idea-plugin__vendor) element.

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  // ...

  pluginConfiguration {
    // ...

    vendor {
      name = "JetBrains"
      email = "hello@jetbrains.com"
      url = "https://www.jetbrains.com"
    }
  }
}
```

Groovy:

```GROOVY
intellijPlatform {
  // ...

  pluginConfiguration {
    // ...

    vendor {
      name = 'JetBrains'
      email = 'hello@jetbrains.com'
      url = 'https://www.jetbrains.com'
    }
  }
}
```

### 

`name`

The name of the vendor or the organization ID (if created), as displayed in the Plugins settings dialog and on the JetBrains Marketplace plugin page.

The provided value is used as the value of the [&lt;vendor&gt;](plugin-configuration-file.html#idea-plugin__vendor) element.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.vendorName](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-vendorName)

### 

`email`

The email address of the vendor.

The provided value is used for the `<vendor email="">` element attribute.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.vendorEmail](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-vendorEmail)

### 

`url`

The URL to the vendor's homepage.

The provided value is used for the `<vendor url="">` element attribute.

Type
: `Property<String>`

See also:

* [Tasks: patchPluginXml.vendorUrl](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml-vendorUrl)

## Caching

Configures caching related to resolving IntelliJ Platform dependencies and storing plugin-generated artifacts.

The caching extension provides:

* Project cache path used by the IntelliJ Platform Gradle Plugin.

* IDEs sub-extension to control caching of downloaded IDEs (enable/disable, storage path, IDE directories naming).

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  // ...

  caching {
    // Root cache used by the plugin for project-specific files
    // path = layout.projectDirectory.dir(".intellijPlatform") // custom example

    ides {
      enabled.set(true)
      // path = layout.buildDirectory.dir("ides-cache")
      // Customize directory name for a resolved IDE
      name.set { requested -> "${'$'}{requested.type.code}-${'$'}{requested.version}" }
    }
  }
}
```

Groovy:

```GROOVY
intellijPlatform {
  // ...

  caching {
    // Root cache used by the plugin for project-specific files
    // path = layout.projectDirectory.dir('.intellijPlatform') // custom example

    ides {
      enabled = true
      // path = layout.buildDirectory.dir('ides-cache')
      // Customize directory name for a resolved IDE
      name = { requested -> "${'$'}{requested.type.code}-${'$'}{requested.version}" }
    }
  }
}
```

### 

`path`

Specifies the IntelliJ Platform project cache location.

The IntelliJ Platform cache is used for storing IntelliJ Platform Gradle Plugin-specific files, such as:

* XML files generated for the [localPlatformArtifacts()](tools-intellij-platform-gradle-plugin-repositories-extension.html#additional-repositories) local Ivy repository

* coroutines Java agent file resolved for tasks using [CoroutinesJavaAgentAware](tools-intellij-platform-gradle-plugin-task-awares.html#CoroutinesJavaAgentAware)

* extracted IntelliJ Platform archives instead of using Gradle cache

* serialized IDE layout indices used for bundled plugin and module dependency resolution

This path can be changed with the [org.jetbrains.intellij.platform.intellijPlatformCache](tools-intellij-platform-gradle-plugin-gradle-properties.html#intellijPlatformCache) Gradle property

Type
: `DirectoryProperty`

Default value
: `[rootProject]/.intellijPlatform/`

## Caching IDEs

Controls caching of IntelliJ Platform IDE distributions downloaded by the plugin.

Example:

Kotlin:

```KOTLIN
intellijPlatform.caching.ides {
  enabled = false
  path = layout.projectDirectory.dir(".intellijPlatform/ides")
  name = { requested -> "${'$'}{requested.type}-${'$'}{requested.version}" }
}
```

Groovy:

```GROOVY
intellijPlatform.caching.ides {
  enabled = false
  path = layout.projectDirectory.dir('.intellijPlatform/ides')
  name = { requested -> "${'$'}{requested.type}-${'$'}{requested.version}" }
}
```

### 

`enabled`

Indicates whether caching for IntelliJ Platform IDEs is enabled globally.

Type
: `Property<Boolean>`

Default value
: `false`

### 

`path`

The cache root directory for storing downloaded IDEs.

Type
: `DirectoryProperty`

Default value
: `[rootProject]/.intellijPlatform/ides/`

See also:

* [Gradle Property: intellijPlatformIdesCache](tools-intellij-platform-gradle-plugin-gradle-properties.html#intellijPlatformIdesCache)

### 

`name`

Function that returns a cache directory name for a given requested IntelliJ Platform artifact.

Type
: `Property<(RequestedIntelliJPlatform) -> String>`

Default value
: `$type-$version`

See also:

* [Types: RequestedIntelliJPlatform](tools-intellij-platform-gradle-plugin-types.html#RequestedIntelliJPlatform)

## Publishing

Configures the publishing process of the plugin.
All values are passed to the [publishPlugin](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin) task.

Requires the [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform) plugin to be applied.

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  // ...

  publishing {
    host = ""
    token = "7hR4nD0mT0k3n_8f2eG"
    channels = listOf("default")
    ideServices = false
    hidden = false
  }
}
```

Groovy:

```GROOVY
intellijPlatform {
  // ...

  publishing {
    host = ''
    token = '7hR4nD0mT0k3n_8f2eG'
    channels = ['default']
    ideServices = false
    hidden = false
  }
}
```

### 

`host`

The hostname used for publishing the plugin.

Type
: `Property<String>`

Default value
: `https://plugins.jetbrains.com`

See also:

* [Tasks: publishPlugin.host](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin-host)

### 

`token`

Authorization token.
Defaults to the `PUBLISH_TOKEN` environment variable.

Type
: `Property<String>`

Required
: yes

Default value
: `PUBLISH_TOKEN` environment variable

See also:

* [Tasks: publishPlugin.token](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin-token)

### 

`channels`

A list of channel names to upload plugin to.

Type
: `ListProperty<String>`

Default value:
: `listOf("default")`

See also:

* [Tasks: publishPlugin.channels](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin-channels)

### 

`ideServices`

Specify if the [IDE Services](https://www.jetbrains.com/ide-services/) plugin repository service should be used.

Type
: `Property<Boolean>`

Default value
: `false`

See also:

* [Tasks: publishPlugin.ideServices](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin-ideServices)

### 

`hidden`

Publish the plugin update and mark it as hidden to prevent public visibility after approval.

Type
: `Property<Boolean>`

Default value
: `false`

See also:

* [Tasks: publishPlugin.hidden](tools-intellij-platform-gradle-plugin-tasks.html#publishPlugin-hidden)

* [Hidden release](https://plugins.jetbrains.com/docs/marketplace/hidden-plugin.html)

## Signing

Plugin signing configuration.

Requires the [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform) plugin to be applied.

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  // ...

  signing {
    cliPath = file("/path/to/marketplace-zip-signer-cli.jar")
    keyStore = file("/path/to/keyStore.ks")
    keyStorePassword = "..."
    keyStoreKeyAlias = "..."
    keyStoreType = "..."
    keyStoreProviderName = "..."
    privateKey = "..."
    privateKeyFile = file("/path/to/private.pem")
    password = "..."
    certificateChain = "..."
    certificateChainFile = file("/path/to/chain.crt")
  }
}
```

Groovy:

```GROOVY
intellijPlatform {
  // ...

  signing {
    cliPath = file('/path/to/marketplace-zip-signer-cli.jar')
    keyStore = file('/path/to/keyStore.ks')
    keyStorePassword = '...'
    keyStoreKeyAlias = '...'
    keyStoreType = '...'
    keyStoreProviderName = '...'
    privateKey = '...'
    privateKeyFile = file('/path/to/private.pem')
    password = '...'
    certificateChain = '...'
    certificateChainFile = file('/path/to/chain.crt')
  }
}
```

See also:

* [Plugin Signing](plugin-signing.html)

* [Tasks: signPlugin](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin)

* [Task Awares: SigningAware](tools-intellij-platform-gradle-plugin-task-awares.html#SigningAware)

* [Marketplace ZIP Signer](https://github.com/JetBrains/marketplace-zip-signer)

### 

`cliPath`

A path to the local Marketplace ZIP Signer CLI tool to be used.

Type
: `RegularFileProperty`

See also:

* [Task Awares: SigningAware](tools-intellij-platform-gradle-plugin-task-awares.html#SigningAware)

### 

`keyStore`

KeyStore file path.
Refers to `ks` CLI option.

Type
: `Property<String>`

See also:

* [Tasks: signPlugin.keyStore](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-keyStore)

### 

`keyStorePassword`

KeyStore password.
Refers to `ks-pass` CLI option.

Type
: `Property<String>`

See also:

* [Tasks: signPlugin.keyStorePassword](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-keyStorePassword)

### 

`keyStoreKeyAlias`

KeyStore key alias.
Refers to `ks-key-alias` CLI option.

Type
: `Property<String>`

See also:

* [Tasks: signPlugin.keyStoreKeyAlias](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-keyStoreKeyAlias)

### 

`keyStoreType`

KeyStore type.
Refers to `ks-type` CLI option.

Type
: `Property<String>`

See also:

* [Tasks: signPlugin.keyStoreType](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-keyStoreType)

### 

`keyStoreProviderName`

JCA KeyStore Provider name.
Refers to `ks-provider-name` CLI option.

Type
: `Property<String>`

See also:

* [Tasks: signPlugin.keyStoreProviderName](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-keyStoreProviderName)

### 

`privateKey`

Encoded private key in the PEM format.
Refers to `key` CLI option.

Takes precedence over the [privateKeyFile](#intellijPlatform-signing-privateKeyFile) property.
Defaults to the `PRIVATE_KEY` environment variable when `privateKeyFile` is not set.

Type
: `Property<String>`

Default value
: `PRIVATE_KEY` environment variable

See also:

* [Tasks: signPlugin.privateKey](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-privateKey)

### 

`privateKeyFile`

A file with an encoded private key in the PEM format.
Refers to `key-file` CLI option.

Type
: `RegularFileProperty`

See also:

* [Tasks: signPlugin.privateKeyFile](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-privateKeyFile)

### 

`password`

Password required to decrypt the private key.
Refers to `key-pass` CLI option.
Defaults to the `PRIVATE_KEY_PASSWORD` environment variable.

Type
: `Property<String>`

Default value
: `PRIVATE_KEY_PASSWORD` environment variable

See also:

* [Tasks: signPlugin.password](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-password)

### 

`certificateChain`

A string containing X509 certificates.
The first certificate from the chain will be used as a certificate authority (CA).
Refers to `cert` CLI option.

Takes precedence over the [certificateChainFile](#intellijPlatform-signing-certificateChainFile) property.
Defaults to the `CERTIFICATE_CHAIN` environment variable when `certificateChainFile` is not set.

Type
: `Property<String>`

Default value
: `CERTIFICATE_CHAIN` environment variable

See also:

* [Tasks: signPlugin.certificateChain](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-certificateChain)

### 

`certificateChainFile`

Path to the file containing X509 certificates.
The first certificate from the chain will be used as a certificate authority (CA).
Refers to `cert-file` CLI option.

Type
: `RegularFileProperty`

See also:

* [Tasks: signPlugin.certificateChainFile](tools-intellij-platform-gradle-plugin-tasks.html#signPlugin-certificateChainFile)

## Verify Plugin

IntelliJ Plugin Verifier CLI tool configuration.

Requires the [Platform](tools-intellij-platform-gradle-plugin-plugins.html#platform) plugin to be applied.

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  // ...

  pluginVerification {
    cliPath = file("/path/to/plugin-verifier-cli.jar")
    freeArgs = listOf("foo", "bar")
    failureLevel = VerifyPluginTask.FailureLevel.ALL
    verificationReportsDirectory = "build/reports/pluginVerifier"
    verificationReportsFormats = VerifyPluginTask.VerificationReportsFormats.ALL
    externalPrefixes = "com.example"
    teamCityOutputFormat = false
    subsystemsToCheck = VerifyPluginTask.Subsystems.ALL
    ignoredProblemsFile = file("/path/to/ignoredProblems.txt")

    ides {
      // ...
    }
  }
}
```

Groovy:

```GROOVY
import org.jetbrains.intellij.platform.gradle.tasks.VerifyPluginTask

intellijPlatform {
  // ...

  pluginVerification {
    cliPath = file('/path/to/plugin-verifier-cli.jar')
    freeArgs = ['foo', 'bar']
    failureLevel = VerifyPluginTask.FailureLevel.ALL
    verificationReportsDirectory = 'build/reports/pluginVerifier'
    verificationReportsFormats = VerifyPluginTask.VerificationReportsFormats.ALL
    externalPrefixes = 'com.example'
    teamCityOutputFormat = false
    subsystemsToCheck = VerifyPluginTask.Subsystems.ALL
    ignoredProblemsFile = file('/path/to/ignoredProblems.txt')

    ides {
      // ...
    }
  }
}
```

See also:

* [Verifying Plugin Compatibility](verifying-plugin-compatibility.html)

* [Tasks: verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin)

* [Task Awares: PluginVerifierAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginVerifierAware)

* [Verify Plugin IDEs](#intellijPlatform-pluginVerification-ides)

* [IntelliJ Plugin Verifier CLI](https://github.com/JetBrains/intellij-plugin-verifier)

### 

`cliPath`

A path to the local IntelliJ Plugin Verifier CLI tool to be used.

Type
: `RegularFileProperty`

See also:

* [Task Awares: PluginVerifierAware](tools-intellij-platform-gradle-plugin-task-awares.html#PluginVerifierAware)

### 

`failureLevel`

Defines the verification level at which the task should fail if any reported issue matches.

Type
: [ListProperty&lt;FailureLevel&gt;](tools-intellij-platform-gradle-plugin-types.html#FailureLevel)

Default value
: [FailureLevel.COMPATIBILITY_PROBLEMS](tools-intellij-platform-gradle-plugin-types.html#FailureLevel), [FailureLevel.INTERNAL_API_USAGES](tools-intellij-platform-gradle-plugin-types.html#FailureLevel), [FailureLevel.OVERRIDE_ONLY_API_USAGES](tools-intellij-platform-gradle-plugin-types.html#FailureLevel)

See also:

* [Tasks: verifyPlugin.failureLevel](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-failureLevel)

### 

`externalPrefixes`

The list of class prefixes from the external libraries.
The Plugin Verifier will not report `No such class` for classes of these packages.

Type
: `ListProperty<String>`

See also:

* [Tasks: verifyPlugin.externalPrefixes](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-externalPrefixes)

### 

`freeArgs`

The list of free arguments is passed directly to the IntelliJ Plugin Verifier CLI tool.

They can be used in addition to the arguments that are provided by dedicated options.

Type
: `ListProperty<String>`

See also:

* [Tasks: verifyPlugin.freeArgs](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-freeArgs)

### 

`ignoredProblemsFile`

A file that contains a list of problems that will be ignored in a report.

Type
: `RegularFileProperty`

See also:

* [Tasks: verifyPlugin.ignoredProblemsFile](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-ignoredProblemsFile)

### 

`subsystemsToCheck`

Which subsystems of the IDE should be checked.

Type
: `Subsystems`

Default value
: [Subsystems.ALL](tools-intellij-platform-gradle-plugin-types.html#Subsystems)

See also:

* [Tasks: verifyPlugin.subsystemsToCheck](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-subsystemsToCheck)

### 

`teamCityOutputFormat`

A flag that controls the output format.
If set to `true`, the [TeamCity](https://www.jetbrains.com/teamcity/) compatible output will be returned to stdout.

Type
: `Property<Boolean>`

Default value
: `false`

See also:

* [Tasks: verifyPlugin.teamCityOutputFormat](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-teamCityOutputFormat)

### 

`verificationReportsDirectory`

The path to the directory where verification reports will be saved.

Type
: `DirectoryProperty`

Default value
: `[buildDirectory]/reports/pluginVerifier`

See also:

* [Tasks: verifyPlugin.verificationReportsDirectory](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-verificationReportsDirectory)

### 

`verificationReportsFormats`

The output formats of the verification reports.

Type
: `ListProperty<VerificationReportsFormats>`

Default value
: [VerificationReportsFormats.PLAIN](tools-intellij-platform-gradle-plugin-types.html#VerificationReportsFormats), [VerificationReportsFormats.HTML](tools-intellij-platform-gradle-plugin-types.html#VerificationReportsFormats)

See also:

* [Tasks: verifyPlugin.verificationReportsFormats](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin-verificationReportsFormats)

## Verify Plugin IDEs

The extension to define the IDEs to be used along with the IntelliJ Plugin Verifier CLI tool for the binary plugin verification.

It provides a set of helpers which add relevant entries to the configuration, which later is used to resolve IntelliJ-based IDE binary releases.
When no IDEs are configured explicitly, `recommended()` is applied by default.
Disable this fallback with the [verifyPluginDefaultRecommendedIdes](tools-intellij-platform-gradle-plugin-gradle-properties.html#verifyPluginDefaultRecommendedIdes) Gradle property.

Example:

Kotlin:

```KOTLIN
intellijPlatform {
  // ...

  pluginVerification {
    // ...

    ides {
      create(IntelliJPlatformType.RustRover, "2023.3")
      local(file("/path/to/ide/"))
      current()
      latest()
      recommended()
      select {
        types = listOf(IntelliJPlatformType.PhpStorm)
        channels = listOf(ProductRelease.Channel.RELEASE)
        sinceBuild = "232"
        untilBuild = "241.*"
      }
    }
  }
}
```

Groovy:

```GROOVY
import org.jetbrains.intellij.platform.gradle.IntelliJPlatformType
import org.jetbrains.intellij.platform.gradle.models.ProductRelease

intellijPlatform {
  // ...

  pluginVerification {
    // ...

    ides {
      create IntelliJPlatformType.RustRover, "2023.3"
      local file('/path/to/ide/')
      current()
      latest()
      recommended()
      select {
        it.types = [IntelliJPlatformType.PhpStorm]
        it.channels = [ProductRelease.Channel.RELEASE]
        it.sinceBuild = '232'
        it.untilBuild = '241.*'
      }
    }
  }
}
```

See also:

* [Verifying Plugin Compatibility](verifying-plugin-compatibility.html)

* [Tasks: verifyPlugin](tools-intellij-platform-gradle-plugin-tasks.html#verifyPlugin)

* [Types: IntelliJPlatformType](tools-intellij-platform-gradle-plugin-types.html#IntelliJPlatformType)

* [Types: ProductRelease.Channel](tools-intellij-platform-gradle-plugin-types.html#ProductRelease-Channel)

* [Types: ProductReleasesValueSource.FilterParameters](tools-intellij-platform-gradle-plugin-types.html#ProductReleasesFilterParameters)

| Function |Description |
-------------------------
| `create(...)` |Adds a dependency to a binary IDE release to be used for testing with the IntelliJ Plugin Verifier. |
| `local(localPath)` |Adds the local IDE to be used for testing with the IntelliJ Plugin Verifier. |
| `current()` |Adds the currently targeted IntelliJ Platform to the verification IDE list. |
| `latest(configure)` |Resolves the latest available IDE release for each selected type. |
| `recommended()` |Retrieves matching IDEs using the default configuration based on the currently used IntelliJ Platform and applies them for IntelliJ Plugin Verifier. |
| `select(configure)` |Retrieves matching IDEs using custom [ProductReleasesValueSource.FilterParameters](tools-intellij-platform-gradle-plugin-types.html#ProductReleasesFilterParameters) filter parameters. |

Provider-based IDE lists can use `orRecommended()` to fall back to the default recommended IDE list when the provider has no value.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

