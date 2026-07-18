# Rider Plugin Development

<tldr>
IDE
: [Homepage](https://www.jetbrains.com/rider), [Versions](https://www.jetbrains.com/rider/download/other.html)

Plugins
: [JetBrains Marketplace](https://plugins.jetbrains.com/rider)
</tldr>

Rider plugins are generally used to expose the functionality of a [ReSharper](https://www.jetbrains.com/resharper/) plugin.
[Rider](https://www.jetbrains.com/rider/) uses the IntelliJ Platform somewhat [differently](intellij-platform.html#rider) than other Platform-based based IDEs.
Rider uses the IntelliJ Platform to provide the user interface for a C# and .NET IDE but uses ReSharper to provide the language-specific features.

Tip:

Rider is free for non-commercial use

## IntelliJ IDEA Configuration for Rider Plugin Development

Although there is no dedicated Rider SDK, the [ReSharper DevGuide](https://www.jetbrains.com/help/resharper/sdk/getting_started.html) addresses the subject of plugins for Rider.
The documentation describes the [configuration](https://www.jetbrains.com/help/resharper/sdk/creating_plugin.html) of the Gradle build script and `settings.gradle` file to build a Rider plugin using the [Gradle build system](creating-plugin-project.html) in IntelliJ IDEA.

Note:

See [Rider Extension Point and Listener List](rider-extension-point-list.html) for the complete list.

## Developing Rider Plugins with the IDEA and ReSharper SDKs

Before starting a new Rider plugin project, review the article [Writing plugins for ReSharper and Rider](https://blog.jetbrains.com/dotnet/2019/02/14/writing-plugins-resharper-rider/).
In particular, this article discusses One Template to Rule Them All, a way to quickly get started writing plugins for both Rider and ReSharper.

More background information is available in the [Building a .NET IDE with JetBrains Rider](https://www.codemag.com/Article/1811091/Building-a-.NET-IDE-with-JetBrains-Rider) article, which includes a high-level description of the Rider Protocol communication process between Rider and ReSharper.
The article is a good counterpoint to the ReSharper DevGuide content, which discusses the protocol at the code level.

## Including Custom Settings into a Plugin

Rider plugins may introduce their own `.DotSettings` files with customized [ReSharper settings](https://www.jetbrains.com/help/resharper/Sharing_Configuration_Options.html).
This is useful e.g., when a plugin brings its own file templates.

For the ReSharper part to pick these settings, the settings files should be available in the plugin JAR file under the path `dotnet/Extensions/$backend-plugin-id$/settings`, where `backend-plugin-id` is calculated according to the following rules:

* if the IntelliJ plugin id (the [&lt;id&gt;](plugin-configuration-file.html#idea-plugin__id) element of the `[plugin.xml](plugin-configuration-file.html)`) includes a dot, then `backend-plugin-id` is the same as the IntelliJ plugin id;

* otherwise, the `backend-plugin-id` is a concatenation of the IntelliJ plugin vendor name (the [&lt;vendor&gt;](plugin-configuration-file.html#idea-plugin__vendor) element of the `plugin.xml`) and the IntelliJ plugin id.

For example, for a plugin with the following `plugin.xml` contents, the file `dotnet/Extensions/com.example.awesomeplugin/settings/templates.DotSettings` would be picked up:

```XML
<idea-plugin>
  <id>com.example.awesomeplugin</id>
  <!-- ... -->
</idea-plugin>
```

And the following `plugin.xml` would require placing the file under `dotnet/Extensions/Jean-Luc Picard.Enterprise/settings/templates.DotSettings` path:

```XML
<idea-plugin>
  <id>Enterprise</id>
  <vendor>Jean-Luc Picard</vendor>
  <!-- ... -->
</idea-plugin>
```

## Using Custom Icons from the Dotnet Rider Plugin Part

Some feature integrations, like adding a new gutter mark or a new line marker, require passing an Icon from the Dotnet plugin part to the IntelliJ plugin part.

A registration of an icon for such cases can be accomplished so:

```CSHARP
public static class MyIconIds
{
	// Note that the path string can _not_ start with a "/" here!
    public static readonly IconId RiderIconId =
            new FrontendIconId("icons/rider.svg");
}
```

Then an icon should be turned into a model icon to be passed through the protocol with a call similar to the following:

```CSHARP
var modelIcon = Shell.Instance.GetComponent<IIconHost>()
        .Transform(frontendIconId);
```

The complete lifting routine in the IntelliJ plugin part for a model yielded by `IIconHost` can be achieved in the following way:

```KOTLIN
// Get the first classloader from the list
// [RiderIconsCache::class.java.classLoader, ...pluginClassLoaders]
// that has the `path` in its resources
fun tryGetClassLoaderForPath(path: String): ClassLoader? {
	/* ... */
}

fun liftIcon(model: FrontendIconModel): Icon {
	return RiderIconCache.getInstance().getOrPut(model.path) {
		val iconLoader = tryGetClassLoaderForPath(model.path)
		if (iconLoader == null) {
			return@getOrPut ReSharperIcons.Special.InvalidIcon
		}

		val foundIcon = IconLoader.findIcon(model.path, iconLoader)
		if (foundIcon == null) {
			return@getOrPut ReSharperIcons.Special.InvalidIcon
		}
	}
}
```

If it is required for an implementation of a custom feature, the entry point for this conversion can be called so:

```KOTLIN
val icon = service<ProtocolIconRegistryService>().createIcon(iconModel)
```

The example for such icon passing can be found in the [JetBrains Rider Plugin Template](https://github.com/ForNeVeR/rider-plugin-template).

Please note that this way of setting up backend icon IDs for a plugin will work only in Rider.
If the plugin is designed to work with both ReSharper and Rider, add the icon as a custom compiled icon
following the instructions in the [ReSharper DevGuide](https://www.jetbrains.com/help/resharper/sdk/Platform__Icons.html#custom-compiled-icons).

To be loaded in the IntelliJ Platform, such icons are expected to be present under `/resharper/$category/$iconName.svg` in some plugin resources directory, where:

* `$category` is the name of the generated `ThemedIcons` C# class without the `ThemedIcons` suffix

* `$iconName` is the name of the generated icon C# class The classloader lookup routine is the same in this case as with the `FrontendIconModel`s.

## Open Source Rider Plugins

It can be useful to refer to existing projects to help understand how to build plugins for Rider.
The following list of plugins is all open source and can demonstrate how to implement different functionality.
Please note that the list includes ReSharper plugins as well as Rider plugins.
Since a lot of Rider's language features are shared with the ReSharper engine, and since the Rider SDK includes the ReSharper SDK, then it can be useful to look at ReSharper plugins too.
Also note that these plugins might not be up to date with the current SDK.

* [Unity support for both ReSharper and Rider](https://github.com/JetBrains/resharper-unity)

* [F# support in JetBrains Rider](https://github.com/JetBrains/fsharp-support)

* [AgentMulder](https://github.com/ERNICommunity/AgentMulder/)

* [CognitiveComplexity](https://github.com/matkoch/resharper-cognitivecomplexity/)

* [CyclomaticComplexity](https://github.com/JetBrains/resharper-cyclomatic-complexity/)

* [Exceptional](https://github.com/CSharpAnalyzers/ExceptionalReSharper/)

* [HeapAllocationsViewer](https://github.com/citizenmatt/resharper-heapview/)

* [InternalsVisibleTo](https://github.com/hmemcpy/ReSharper.InternalsVisibleTo/)

* [PresentationAssistant](https://github.com/JetBrains/resharper-presentation-assistant/)

* [StyleCop](https://github.com/StyleCop/StyleCop.ReSharper/)

* [Xao](https://github.com/hmemcpy/ReSharper.Xao/)

* [Azure Toolkit for Rider](https://github.com/JetBrains/azure-tools-for-intellij)

* [T4 language support for both ReSharper and Rider](https://github.com/JetBrains/ForTea)

## Getting Help

For plugin implementation support and questions, see the
[Getting Help](getting-help.html#problems-with-code-support-issues) section.

