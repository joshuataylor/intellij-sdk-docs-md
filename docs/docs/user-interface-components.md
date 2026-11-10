# User Interface Components

<tldr>
UI Guidelines: [Overview](ui-guidelines-welcome.html)
</tldr>

The IntelliJ Platform includes a large number of custom [Swing](https://en.wikipedia.org/wiki/Swing_(Java)) components.
Using those components in a plugin will ensure that the plugin looks and works consistently with the UI of the rest of the IDE, and can often reduce the code size compared to using the default Swing components.
Use inspection `Plugin DevKit | Code | Undesirable class usage` to highlight replacement components provided by the platform.

Tip: Inspecting existing UI

Use [UI Inspector](internal-ui-inspector.html) to locate the underlying Swing component implementation or to inspect an existing UI at runtime.

Note:

UI forms like [Dialogs](dialog-wrapper.html) or [Settings](settings.html) should use [Kotlin UI DSL](kotlin-ui-dsl-version-2.html) (IntelliJ Platform 2021.3+).

Using UI Designer plugin with Kotlin is [not supported](https://youtrack.jetbrains.com/issue/KTIJ-791).

Please refer to [Writing Short and Clear](writing-short.html) in UI Guidelines on writing UI-related texts.

See [UI Kit](ui-kit.html) when using [Figma](https://www.figma.com) to design UI.

The following components are particularly noteworthy:

* Menus and toolbars are built using [Action System](action-system.html)

* [Tool Windows](tool-windows.html)

* [Dialogs](dialog-wrapper.html)

* [Popups](popups.html)

* [Informing Users](informing-users.html) * [Notification Balloons](notification-balloons.html)

* [File and Class Choosers](file-and-class-choosers.html)

* [Editor Components](editor-components.html)

* [List and Tree Controls](lists-and-trees.html)

* [Status Bar Widgets](status-bar-widgets.html)

* Tables (TableView) (TBD)

* Drag & Drop Helpers (TBD)

* [Miscellaneous Swing Components](misc-swing-components.html)

See also [User Interface FAQ](ui-faq.html).

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

