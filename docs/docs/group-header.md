# Group Header

<tldr>
Implementation: [TitledSeparator](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/TitledSeparator.java)
</tldr>

A group header clearly labels a group of UI controls.

![01 group header](images/01_group_header.png)

## When to use

Follow the rules in [Groups of controls](groups-of-controls.html).

Do not use group headers when each group contains 3 controls and less. Separate with [vertical insets](layout.html#organize-with-insets) instead.

Incorrect

![6 03 group incorrect](images/6_03_group_incorrect.png)
Each group has less than 3 controls. Group headers only add noise in this case because control labels are enough to understand their purpose.

Correct

![6 03 group correct](images/6_03_group_correct.png)

## How to use

Use title capitalization for the label.

Make the label short, preferably no more than 4 words. Avoid generic words, such as "General" or "Options". See [Writing short and clear](writing-short.html).

If a group contains rarely used or advanced settings, use a collapsible group header and collapse it by default.

![02 collapsed header](images/02_collapsed_header.png)

