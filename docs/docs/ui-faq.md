# User Interface FAQ

Tip: Inspecting existing UI

Use [UI Inspector](internal-ui-inspector.html) to locate the underlying Swing component implementation or to inspect an existing UI at runtime.

## Useful Classes

* Package [com.intellij.ui](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/ui/)

* Package [com.intellij.util.ui](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/util/ui/)

## Colors

Always use [JBColor](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/ui/JBColor.java) instead of plain `java.awt.Color`
(highlighted via inspection Plugin DevKit | Code | Use Darcula aware JBColor).
Custom colors must be retrieved via `JBColor.namedColor()` set by the current [Theme](themes-getting-started.html).
See [Exposing Theme Metadata](themes-metadata.html) on how to expose corresponding metadata.

If it's needed to retrieve a color from one place and use it in another, do not just retrieve once and use the retrieved value.
Instead, use `JBColor.lazy()` and pass in a lambda expression to retrieve the color.
This lambda expression needs to be fast and safe enough, as it will be called every time the color is retrieved, for example, for painting.
Following this approach ensures that the color will be properly updated if it's changed at the source, for example, due to a theme or scheme change.

Generic UI colors (e.g., for drawing borders) can be accessed via [UIUtil](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/util/ui/UIUtil.java)
and [JBUI](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/util/ui/JBUI.java).
A number of hardcoded colors is defined in `JBColor`, [Gray](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/ui/Gray.java), and [LightColors](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/ui/LightColors.java)

[ColorUtil](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/ui/ColorUtil.java) allows tuning existing colors.

## Text

<tldr>
UI Guidelines: [Data Formats](data-formats.html)
</tldr>

Use [NaturalComparator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/base/src/com/intellij/openapi/util/text/NaturalComparator.java) for "natural" sorting of items.

[StringUtil](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/openapi/util/text/StringUtil.java) contains a number of useful methods for manipulating text for UI usage:

* `unpluralize()/pluralize()` using English rules

* `formatDuration()` to format duration: 2 m 3 s 456 ms

* `formatFileSize()` to format filesize: 1.23 KB

* `escapeLineBreak()` and related methods to escape special characters

* `shortenTextWithEllipsis()` and `shortenPathWithEllipsis()` to produce abbreviated UI texts ending with '…'

* `quote()` and `unquoteString()` to wrap values: Usages of "$value$": 218 found

See [Internationalization](internationalization.html) for information about internationalizing plugins.

See [NlsMessages](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/ide-core-impl/src/com/intellij/ide/nls/NlsMessages.java) to produce localized messages.

## "Recently Used" Entries

To store and retrieve values for Recently Used entries (e.g., filter values), use
[RecentsManager](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-impl/src/com/intellij/ui/RecentsManager.java).

## Current Theme: Dark or Bright?

To determine the current [Theme](themes-getting-started.html)'s style, use [JBColor.isBright()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/ui/JBColor.java).

## Borders and Insets

<tldr>
UI Guidelines: [Layout](layout.html)
</tldr>

Always create borders and insets via factory methods from [JBUI.Borders](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/util/ui/JBUI.java) and [JBUI.Insets](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/ui/src/com/intellij/util/ui/JBUI.java), which create DPI-aware instances.
Using standard DPI-agnostic instances (reported by inspection `Plugin DevKit | Code | Use DPI-aware borders` and `Plugin DevKit | Code | Use DPI-aware insets`)
can result in UI layout problems.

If you use DPI-aware insets in an empty border (`JBUI.Borders.empty()`), then the insets will be updated automatically, for example, if scaling is changed because the `IDE Zoom` action was performed or for any other reason.
If you use the insets elsewhere, you need to manually call `JBInsets.update()` in your component's `updateUI()` method to update the insets accordingly.

## Icons

### Customizing Existing Icons

Plugins may need to override icons for existing elements, for example, for XML/JSON configuration files related its functionality.

Use [FileIconProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/ide/FileIconProvider.java)
registered in [com.intellij.fileIconProvider](https://jb.gg/ipe?extensions=com.intellij.fileIconProvider) extension point

to provide custom icons for [Virtual Files](virtual-file.html).

For [PSI elements](psi.html), implement [IconProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/ide/IconProvider.java)
and register in [com.intellij.iconProvider](https://jb.gg/ipe?extensions=com.intellij.iconProvider) extension point
.

### Progress Placeholder

[LoadingDecorator](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/LoadingDecorator.kt) provides "loading" placeholder panel.

### Manipulating Icons

Use [IconUtil](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-ui/src/util/IconUtil.kt) to scale/colorize/darken/desaturate existing [icons](icons.html) as needed.

### Combining Icons

Use [RowIcon](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-ui/src/ui/RowIcon.kt) to combine icons horizontally ($modifier$ $element$).

To stack icons, use [LayeredIcon](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-ui/src/ui/LayeredIcon.kt).
[IconWithOverlay](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-ui/src/ui/icons/IconWithOverlay.java) additionally allows controlling the shape of the overlay icon.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

