# Icon Button

<tldr>
Implementation: [ActionButton](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/platform-impl/src/com/intellij/openapi/actionSystem/impl/ActionButton.java)
</tldr>

| ![Using links instead of buttons](images/toolbar_icon_button.png) |             A toolbar icon button contains only an icon. There are three types of icon buttons:               * An action triggers immediately.    * A toggle switches between on and off states.    * A drop-down opens a menu.            |

## When to use

Follow the guidelines for the [Toolbar](toolbar.html#what-items-to-add-on-toolbar).

## How to use

### Icon

Use an [existing icon](https://intellij-icons.jetbrains.design) or create a new one following the [icon guidelines](icons-style.html).

### Tooltip

| ![Using links instead of buttons](images/toolbar_icon_button_tooltip.png) |Always provide a tooltip for an icon button. Include a shortcut if there is one. See [Tooltip](tooltip.html) for details. |

### States

| ![Using links instead of buttons](images/toolbar_icon_button_states.png) |When an action is not available in a particular context, disable the icon button. |

### Filter badge

![Using links instead of buttons](images/toolbar_icon_button_badge.png)
For filter actions, show a badge over an icon when a non-default option is selected. The badge helps to see if the content is in its default state or filtered.

### Search option icon

![Using links instead of buttons](images/toolbar_icon_button_search_option.png)
Search option icons have a more noticeable pressed state to allow quickly seeing what affects the search results. See [Search options](search-field.html#search-options) for details.

