# Build Number Ranges

Use this reference of build number ranges to specify the correct `since-build` and `until-build` values in the plugin descriptor.

Setting the actual values in `[plugin.xml](plugin-configuration-file.html)` is managed by the `patchPluginXml` Gradle task
(Reference: [2.x](tools-intellij-platform-gradle-plugin-tasks.html#patchPluginXml), [1.x](tools-gradle-intellij-plugin.html#tasks-patchpluginxml)).
See [Patching the Plugin Configuration File](configuring-plugin-project.html#patching-the-plugin-configuration-file) for further details.

## Build Numbers

Note the following regarding values for `since-build` and `until-build`:

### Valid Values

Values must represent the [actual build numbers](#build-number-format).
Any made-up numbers must not be used.
Violations are highlighted by [plugin verifier](verifying-plugin-compatibility.html), and such plugins will be rejected on JetBrains Marketplace.

For example, `233.*` is invalid for `since-build`.
Any of `999.*`, `234.*` (maximum is `233.*`) and `223.9999` are invalid for `until-build`.

### "Open-End" Compatibility

Not specifying the `until-build` attribute means it will include all future builds.
This includes future, yet unreleased versions and possibly new IDEs, which might impact compatibility later.

See [until-build](tools-intellij-platform-gradle-plugin-extension.html#intellijPlatform-pluginConfiguration-ideaVersion-untilBuild)
documentation for the necessary Gradle configuration.

### Branch Version Compatibility

To support all releases for a specific branch (major version), use a dot-star suffix (`.*`) for `until-build`.

For example, `232.*` for all 2023.2.x releases.

Warning: Compatibility Enforcement

Before publishing, the plugin must be checked using [Plugin Verifier](verifying-plugin-compatibility.html#plugin-verifier) against the specified version range (and specified compatible products) to ensure binary compatibility.
Any additional reported errors/warnings should also be fixed when possible.

Plugins hosted on [JetBrains Marketplace](https://plugins.jetbrains.com) are checked automatically.
According to [Approval Guidelines](https://plugins.jetbrains.com/legal/approval-guidelines), JetBrains will restrict incompatible plugin versions if necessary.

## Build Number Format

To denote a release, a multipart build number is used.
It consists of the following parts:

* Product ID (`IU` for IDEA Ultimate, `RM` for RubyMine, `PY` for PyCharm, `PS` for PhpStorm, etc.)

* Branch number (`223`)

* Build number in the branch (`9559`)

Branch numbers are based on the `YYYY.R` [IDE release version numbers](https://blog.jetbrains.com/blog/2016/03/09/jetbrains-toolbox-release-and-versioning-changes/).
The branch number takes the last two digits of the year and the `R` release number.
For example, `231` for 2023.1, `232` for 2023.2, and `233` for 2023.3.

The build number may have multiple components: `IU-162.94.11`, `IU-162.94.11.256.42`.
This gives more flexibility for third-party plugins and IDE developers.
Plugins may specify compatibility versions more precisely (for example, requiring a specific bugfix release); IDE vendors may have build numbers based on a specific IntelliJ Platform version and specify an additional internal version (for example, `256.42` in `XX-162.94.11.256.42`) to allow plugin developers for their IDE to specify compatibility.

Multipart build numbers can also be used in the `since-build` and `until-build` attributes of `idea-version`.
Usually, omit the product ID and use only the branch number and build number, for example:

Any 213 branch version:

```XML
<!-- 2021.3, 2021.3.1, 2021.3.2, ... -->
<idea-version since-build="213" until-build="213.*"/>
```

Specific build number:

```XML
<!-- 2021.3.3 or later -->
<idea-version since-build="213.7172.25"/>
```

Note: Build numbers for products

Specific build numbers and their corresponding release version are available via Other versions on the corresponding product's download page, for example, [Other Versions of IntelliJ IDEA](https://www.jetbrains.com/idea/download/other/).
For upcoming versions, see [The Early Access Program](https://www.jetbrains.com/resources/eap/).

See also [&quot;What versions of IntelliJ-based IDEs are supported?&quot;](https://intellij-support.jetbrains.com/hc/en-us/articles/360019574859-What-versions-of-IntelliJ-based-IDEs-are-supported-) for JetBrains IDE support policy.

## Targeting Multiple IDE Versions

Tip: Which versions should a plugin support?

For new plugins, it is recommended to support current and previous stable versions.
For example, if the current platform version is 2026.3.*, start developing the plugin by targeting 2026.2.*.
This will support:

* 2026.3.* - current major version

* 2026.2.* - previous major version

With this approach, plugins can use modern APIs, which makes them more performant.

After the plugin is released, it is not strictly required to update plugin to support only two latest major versions.
Consider supporting some older versions based on download statistics in [Statistics: Product Versions in Use](https://plugins.jetbrains.com/docs/marketplace/product-versions-in-use-statistics.html).

When supporting multiple major versions, it is strongly recommended to build against the lowest supported version to guarantee backwards-compatibility.
In the case of supporting a range of platform versions with different underlying Java level ([see below](#platformVersions)), it is required.

[Verifying Plugin Compatibility](verifying-plugin-compatibility.html) discusses tooling support to ensure compatibility with the chosen version range and IDEs.

Consult [Incompatible API Changes](api-changes-list.html) and [Notable API Changes](api-notable.html) for an overview of known breaking and relevant changes across IDE versions.

In some cases, keeping a dedicated branch and corresponding plugin release for each major IDE version might be required due to incompatibilities that cannot be solved in other ways.
The IDE will automatically install only the corresponding compatible build.

## Platform Versions

Note that there is no `YY0`.
In the `YYYY.R` versioning scheme, the `R` part starts at 1.

Warning: Gradle Plugin

The Gradle plugin must be chosen depending on the target
[platform version](#platformVersions).

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

Early Access Program (EAP) releases of upcoming versions are available [here](https://eap.jetbrains.com).

| IntelliJ Platform version |Branch |Java version |
---------------------------------------------------
| 2026.3 |[263](https://github.com/JetBrains/intellij-community/tree/263) |25 |
| 2026.2 |[262](https://github.com/JetBrains/intellij-community/tree/262) |25 |
| 2026.1 |[261](https://github.com/JetBrains/intellij-community/tree/261) |21 |
| 2025.3 |[253](https://github.com/JetBrains/intellij-community/tree/253) |21 |
| 2025.2 |[252](https://github.com/JetBrains/intellij-community/tree/252) |21 |
| 2025.1 |[251](https://github.com/JetBrains/intellij-community/tree/251) |21 |

### Earlier Versions

| IntelliJ Platform version |Branch |Java version |
---------------------------------------------------
| 2024.3 |[243](https://github.com/JetBrains/intellij-community/tree/243) |21 |
| 2024.2 |[242](https://github.com/JetBrains/intellij-community/tree/242) |21 |
| 2024.1 |[241](https://github.com/JetBrains/intellij-community/tree/241) |17 |
| 2023.3 |[233](https://github.com/JetBrains/intellij-community/tree/233) |17 |
| 2023.2 |[232](https://github.com/JetBrains/intellij-community/tree/232) |17 |
| 2023.1 |[231](https://github.com/JetBrains/intellij-community/tree/231) |17 |
| 2022.3 |[223](https://github.com/JetBrains/intellij-community/tree/223) |17 ([blog post](https://blog.jetbrains.com/platform/2022/08/intellij-project-migrates-to-java-17/)) |
| 2022.2 |[222](https://github.com/JetBrains/intellij-community/tree/222) |11 |
| 2022.1 |[221](https://github.com/JetBrains/intellij-community/tree/221) |11 |
| 2021.3 |[213](https://github.com/JetBrains/intellij-community/tree/213) |11 |
| 2021.2 |[212](https://github.com/JetBrains/intellij-community/tree/212) |11 |
| 2021.1 |[211](https://github.com/JetBrains/intellij-community/tree/211) |11 |
| 2020.3 |[203](https://github.com/JetBrains/intellij-community/tree/203) |11 ([blog post](https://blog.jetbrains.com/platform/2020/09/intellij-project-migrates-to-java-11/)) |
| 2020.2 |[202](https://github.com/JetBrains/intellij-community/tree/202) |8 |
| 2020.1 |[201](https://github.com/JetBrains/intellij-community/tree/201) |8 |

