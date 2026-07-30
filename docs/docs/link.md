# Link

<tldr>
Implementation: [ActionLink](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ui/components/ActionLink.kt), [DropDownLink](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ui/components/DropDownLink.kt)
</tldr>

![A preview of link types: default, drop-down, and external.](images/link.png)

## When to use

### Navigation inside a window

Use a regular link for navigation between pages of the same window. In the example below Manage scopes… opens another page in Settings for editing the values.

|          Correct         ![A vertical list of three options: 'Non-Project Files', 'Problems', and 'Production', followed by a 'Manage scopes…' link below.](images/link_when_to_1_correct.png)      |         Incorrect         ![A vertical list of three options: 'Non-Project Files', 'Problems', and 'Production', followed 'Manage scopes' button below.](images/link_when_to_1_incorrect.png)      |

### Web resources

Use an external link for navigation to web resources. See below for the [external link icon](#external-link-icon).

![Text 'Learn more about what is logged' with 'what is logged' as an external link with an arrow icon.](images/link_when_to_2.png)

### Secondary actions in packed UI areas

Use a regular or [drop-down link](#drop-down-link) for secondary actions in packed or small UI areas.

![Build and run section with 'Modify options' drop-down link. Contains a Java SDK selector, a command line arguments selector, and a program arguments input.](images/link_when_to_4.png)

### Secondary actions in a tree or table

#### Some items can be changed

Use a link as a secondary action for some items of a tree or table.

![A tree with a checkbox and four dependent controls, and links 'Set…' in the first and the fourth control](images/link_when_to_5.png)

#### All items can be changed

If a link in every tree or table line has meaningful formatting, leave it.

For example, links in the Push Commits window help understand the relation between them: [remote repository] : [branch]; moving these links elsewhere would break this meaning.

![Links in the Push Commits window 'origin : master'](images/link_when_to_6_3.png)

## When not to use

### Primary actions

Use a [button](button.html) or a [drop down list](drop-down.html) for primary actions. These controls can be selected from the keyboard and are bigger and easier to click.

|          Correct         ![The Commit Message input with primary and secondary actions as buttons.](images/link_when_not_to_1_correct.png)      |         Incorrect         ![The Commit Message input with primary and secondary actions as links.](images/link_when_not_to_1_incorrect.png)      |

### Secondary actions in a tree or table

#### Editable items

When all items can be changed, add an [icon button](icon-button.html) to a toolbar.

|          Correct         ![Table with a toolbar with icon-buttons](images/link_when_to_6_correct.png)      |         Incorrect         ![Table with a link 'Edit…' in every row](images/link_when_to_6_incorrect.png)      |

#### List of choices

For a list of choices, add a separate table column of drop-down cells (see [Table](table.html#editing-values)).

|          Correct         ![Table with a toolbar with icon-buttons](images/link_when_not_to_3_correct.png)      |         Incorrect         ![Table with a link 'Edit…' in every row](images/link_when_not_to_3_incorrect.png)      |

### Simple UI

Use a [button](button.html) or a [drop down list](drop-down.html) when a UI is not constrained.
These controls can be selected from the keyboard and are bigger and easier to click.

|        Correct       ![A stack of controls with a button 'Edit' following one of the controls.](images/link_when_not_to_2_correct.png)      |
|        Incorrect       ![A stack of controls with a link 'Edit' following one of the controls.](images/link_when_not_to_2_incorrect.png)      |

## How to use

### Writing guidelines

#### Use sentence capitalization

Follow the [sentence capitalization](capitalization.html#sentence) guideline.

|        Correct       ![A 'Modify options' drop-down with the sentence style capitalization.](images/link_how_to_1_correct.png)      |       Incorrect       ![A 'Modify Options' drop-down with the title style capitalization.](images/link_how_to_1_incorrect.png)      |

#### Ellipsis

Add an ellipsis to a link if it opens another UI area where input is possible. See examples for the [Button](button.html).

|        Correct       ![A vertical list of three options: 'Non-Project Files', 'Problems', and 'Production', followed by a 'Manage scopes…' link below. The link has an ellipsis in the end.](images/link_how_to_2_correct.png)      |       Incorrect       ![Vertical list of three options: 'Non-Project Files', 'Problems', and 'Production', followed by a 'Manage scopes' link below. The link doesn't have an ellipsis in the end.](images/link_how_to_2_incorrect.png)      |

#### Wording

Do not use words like `navigate` or `click here`. A link already implies navigation or clicking.

|        Correct       ![Link 'Proxy settings…'.](images/link_how_to_3_correct.png)      |       Incorrect       ![Link 'Navigate to general proxy settings'.](images/link_how_to_3_incorrect.png)      |

|        Correct       ![Link 'Download drivers…'.](images/link_how_to_4_correct.png)      |       Incorrect       ![Text reading 'Click here to download drivers' where 'here' is a link.](images/link_how_to_4_incorrect.png)      |

#### Make it informative

When possible, replace `Learn more` and other generic phrases with more informative ones.

|        Correct       ![Link 'How to use Closure Linter'.](images/link_how_to_5_correct.png)      |       Incorrect       ![Link 'Learn more'.](images/link_how_to_5_incorrect.png)      |

### Link as a part of text

A link can be a part of a checkbox or radio button label or of any stand-alone text, like the text in an [empty state](empty-state.html) or in [context help](context-help.html):

![Checkbox 'Use console font instead of the default font' where 'default font' is a link.](images/link_how_to_6.png)
Make a link the minimum phrase that is enough to understand what will happen without reading the whole text:

|        Correct       ![Text reading 'Learn more about what is logged' where 'what is logged' is a link.](images/link_how_to_7_correct.png)      |       Incorrect       ![Link 'Learn more about what is logged'.](images/link_how_to_7_incorrect.png)      |

### External link icon

Add the arrow icon for an external link. The icon shows that the user will switch to a browser and lose the current context.

![Text 'Learn more about what is logged' where 'what is logged' is an external link with the external link icon.](images/link_how_to_8.png)
#### Implementation

Kotlin:

```KOTLIN
val externalLink = ActionLink("External link") {
  BrowserUtil.browse("https://www.jetbrains.com")
}.apply {
  setExternalLinkIcon()
}
```

Java:

```JAVA
ActionLink externalLink = new ActionLink(
    "External link",
    event -> BrowserUtil.browse("https://www.jetbrains.com")
);
externalLink.setExternalLinkIcon();
```

### Help icon

Use the help icon in links in [empty states](empty-state.html) to indicate that this is an external help resource. The arrow icon in this case is unnecessary.

|        Correct       ![Empty state in the Database tool window with an explanation text and a help source link 'Defining a database' with the help icon.](images/link_how_to_9_correct.png)      |       Incorrect       ![Empty state in the Database tool window with an explanation text and an external link 'Defining a database' with the external link icon.](images/link_how_to_9_incorrect.png)      |

### Drop-down link

Drop-down links show a context menu or a popup. To implement, use [DropDownLink](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-api/src/com/intellij/ui/components/DropDownLink.kt).

![Control 'Changes from 2 commits' where '2 commits' is a drop-down link opening a list of all commits](images/link_dropdown.png)

## Placement

* For default links follow [layout of buttons and links](layout.html#buttons-and-links).

* For drop-down links follow [layout of labeled controls](layout.html#labeled-input-controls).

## Built-in behavior

A focused link is activated from the keyboard with `Space`.

