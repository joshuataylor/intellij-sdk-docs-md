# Tabs

<tldr>
Implementation: [JBTabbedPane](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ui/components/JBTabbedPane.java)
</tldr>

![Tabs](images/01_Tabs.png)

## When to use

Use tabs to organize related content. Follow rules for [Groups of controls](groups-of-controls.html).

Note:

For editor tabs, use another component — [JBEditorTabs](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ui/tabs/impl/JBEditorTabs.kt)

In tool windows, tabs are generated automatically. See [Tool window](tool-window.html).

## How to use

### Label

* Use title capitalization for tab labels.

* Make labels short, preferably no more than 3 words.

* Avoid generic words such as "General" or "Advanced".

* See [Writing short and clear](writing-short.html).

Correct

![Hiding tabs that do not fit](images/02_How_to_use_correct.png)
Incorrect

![Hiding tabs that do not fit](images/02_How_to_use_incorrect.png)

### Tab Order and Layout

Place the most frequently used content in the first tab.

Tabs that do not fit allotted screen space automatically hide under the dropdown component. It is better to add no more than 8 tabs, but the number is not limited.

![Hiding tabs that do not fit](images/03_How_to_use.png)

### Unavailable content

Do not remove or disable a tab when its functions are unavailable. Explain why a tab’s content is unavailable in the body of the tab.

## Placement

### Position

Always place tabs on top of the content. It is possible to place them at other sides — bottom, left, or right — but such a placement is extremely rare and might confuse users.

### Independent content

Do not place independent content under the tabs. Create separate tabs for such content.

Correct

![Correct placment of independent content](images/06_Placement_correct.png)
Incorrect

![Incorrect placement of independent content](images/06_Placement_incorrect.png)

### Controls above tabs

When there are other UI controls above tabs, separate them with a vertical indent.

![UI controls above the tabs](images/07_Placement_correct.png)

### Tabs border

* Make sure the border of the tab reaches the edges of the area tabs occupy.

* Do not surround the tab content area with a visible border.

Correct

![Correct bottom border](images/04_Placement_correct.png)
Incorrect

![Incorrect bottom border](images/04_Placement_incorrect.png)
Incorrect

![Frame around the tab content](images/05_Placement_incorrect.png)

