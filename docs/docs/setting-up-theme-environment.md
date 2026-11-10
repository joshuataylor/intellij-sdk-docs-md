# Setting Up a Development Environment

Procedure: Preliminary Steps

## Get IntelliJ IDEA CE Source Code

Getting the IntelliJ IDEA CE source code is not a requirement for theme development as debugging the platform code while developing a theme is a rare situation.
When developing a plugin that extends IDE behavior or investigating how some components work internally, having sources makes debugging much more straightforward.

For detailed instructions on how to check out the code efficiently, refer to the Getting IntelliJ Platform section of the [IntelliJ Platform README file](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/README.md).
Note that building the checked-out sources is not required in this case.

## Configuring IntelliJ Platform Plugin SDK

Tip:

For more information about SDKs, see the [SDKs section](https://www.jetbrains.com/help/idea/working-with-sdks.html) in the IntelliJ IDEA Web Help.

### Download IntelliJ-Based IDE

To see the effects of the developed plugin in a real IDE, it is required to run the plugin in an [IDE development instance](ide-development-instance.html).
In most cases, it is enough to download and use [IntelliJ IDEA](https://www.jetbrains.com/idea/download/).
If it is required to style components used only in a specific IDE like GoLand or WebStorm, they can also be used as SDK, but debugging the core code will only work with the IntelliJ IDEA.

### Add JDK and IntelliJ Platform Plugin SDK

The first step of configuring a theme plugin SDK is adding the JDK.

Note: IDE and Java Versions

Java version must be set depending on the target
[platform version](build-number-ranges.html#platformVersions).

2026.2+
: Java 25

2024.2+
: Java 21

Procedure: Add JDK

The second step is adding IntelliJ Platform Plugin SDK that will use the JDK configured in the first step.

Procedure: Add IntelliJ Platform Plugin SDK

