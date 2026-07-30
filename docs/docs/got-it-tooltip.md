# Got It Tooltip

<tldr>
Implementation: [GotItTooltip](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/ui/GotItTooltip.kt)

Related: ["Got It" Notification](informing-users.html#gotIt)
</tldr>

A Got It tooltip informs users about a new or changed behavior and provides a short summary of the change.

![Got it](images/got_it.png)

## Structure

![Got it structure](images/got_it_structure.png)
### Body text

Always add the body text.  Shortly describe what the tooltip is showing.

Don't use body text as a title.

|        Correct![Got it body correct](images/got_it_body_correct.png)      |       Incorrect![Got it body incorrect](images/got_it_body_incorrect.png)      |

### Title

Add a header if the body text is 2 lines and more. A header should be short and quickly explain what a tooltip is about.

|        Correct![Got it title correct](images/got_it_title_correct.png)      |       Incorrect![Got it title incorrect](images/got_it_title_incorrect.png)      |

#### Implementation

Kotlin:

```KOTLIN
GotItTooltip(TOOLTIP_ID, GET_IT_TEXT, parentDisposable)
    .withHeader("The reader mode is on")
```

Java:

```JAVA
new GotItTooltip(TOOLTIP_ID, GET_IT_TEXT, parentDisposable)
    .withHeader("The reader mode is on");
```

### Step counter

Use a step counter to number a sequence of related Got It tooltips.

![Got it steps](images/got_it_steps.png)

### Shortcut

Use a shortcut if the tooltip describes an action that has a shortcut.

![Got it shortcut](images/got_it_shortcut.png)
#### Implementation

Kotlin:

```KOTLIN
GotItTooltip(
    TOOLTIP_ID,
    { "You can rename usages ${shortcut("My.Action")}" },
    parentDisposable
)
```

Java:

```JAVA
new GotItTooltip(
    TOOLTIP_ID,
    gotItTextBuilder -> {
        String shortcut = gotItTextBuilder.shortcut("My.Action");
        return "You can rename usages " + shortcut;
    },
    parentDisposable
);
```

### Link

Add a link if users might want to revert changes in a feature or configure it.

Note:
Only one link can be added

![Got it link](images/got_it_link.png)
#### Implementation

Kotlin:

```KOTLIN
GotItTooltip(TOOLTIP_ID, TOOLTIP_TEXT, parentDisposable)
    .withLink("Disable for all files", this::actionMethodReference)
```

Java:

```JAVA
new GotItTooltip(TOOLTIP_ID, TOOLTIP_TEXT, parentDisposable)
    .withLink("Disable for all files", this::actionMethodReference);
```

Add an external link if there is a help source that can further explain the functionality.

![Got it link ext](images/got_it_link_ext.png)
#### Implementation

Kotlin:

```KOTLIN
GotItTooltip(TOOLTIP_ID, GOT_IT_TEXT, parentDisposable)
    .withBrowserLink("How to use", new URL("https://example.com"))
```

Java:

```JAVA
new GotItTooltip(TOOLTIP_ID, GOT_IT_TEXT, parentDisposable)
    .withBrowserLink("How to use", new URL("https://example.com"));
```

## When to use

### Small UI controls

Point to small and essential controls that can be overlooked in a dense interface.

### New feature

Introduce users to a feature improvement contextually when they start using it. Explain how it works and highlight its benefits.

|        Correct![Got it feature correct](images/got_it_feature_correct.png)      |       Incorrect![Got it feature incorrect](images/got_it_feature_incorrect.png)      |

### Changed behavior

Suggest a new pattern to a user's task that improves their workflow.

### Ambiguous behavior

Explain behavior that is not clear from the UI.

For example, when extracting a method, users can change only the method name in the blue box. The tooltip explains where to change the order of parameters in the parentheses and other properties of a method:

![Got it ambiguous](images/got_it_ambiguous.png)

## When not to use

### Presenting a new tool

Don't use the Got It tooltip as a marketing tool. It distracts users, especially during startup. Use marketing channels for this purpose.

### Nothing to point to

When there is nothing to point to in a dialog or a tool window, use a [banner](banner.html).

|        Correct![Got it banner correct](images/got_it_banner_correct.png)      |       Incorrect![Got it banner incorrect](images/got_it_banner_incorrect.png)      |

### Feedback from the interface

Don't use Got It tooltips to give users feedback from the interface. Use [notifications](balloon.html) instead.

|        Correct![Got it feedback correct](images/got_it_feedback_correct.png)      |       Incorrect![Got it feedback incorrect](images/got_it_feedback_incorrect.png)      |

### New option in a tree or list

For updates to frequently used menus, use a badge instead of a Got It tooltip to avoid disrupting the user's existing workflow.

|        Correct![Got it tree correct](images/got_it_tree_correct.png)      |       Incorrect![Got it tree incorrect](images/got_it_tree_incorrect.png)      |

## How to use

### Single use

Show a Got It tooltip only once. Never show it again after the user closes it

### Showing a group of tooltips

Show a sequence of tooltips only when users initiate it. Users can start a tooltip tour, for example, by pressing a respective button in the interface.

For example, Start Quick Tour initiates a tour of the new functionality:

![Got it initiate](images/got_it_initiate.png)

### Text length and formatting

* Show no more than 5 lines of body text. If the text does not fit, leave only the essential information and add a link to a help article. Make the help text [short and descriptive](writing-short.html).

* Use sentence case both for the header and body text, and follow the [punctuation rules](punctuation.html).

* Don't use style formatting. It makes the tooltip harder to read.

|        Correct![Got it content correct](images/got_it_content_correct.png)      |       Incorrect![Got it content incorrect](images/got_it_content_incorrect.png)      |

### Positioning

Don't cover the information the user is currently working with.

|        Correct![Got it position correct](images/got_it_position_correct.png)      |       Incorrect![Got it position incorrect](images/got_it_position_incorrect.png)      |

#### Implementation

See four predefined point providers in the [GotItTooltip](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/platform-impl/src/com/intellij/ui/GotItTooltip.kt) class.

Kotlin:

```KOTLIN
GotItTooltip(TOOLTIP_ID, GOT_IT_TEXT, parentDisposable)
    .show(gutterComponent, GotItTooltip.TOP_MIDDLE)
```

Java:

```JAVA
new GotItTooltip(TOOLTIP_ID, GOT_IT_TEXT, parentDisposable)
    .show(gutterComponent, GotItTooltip.TOP_MIDDLE);
```

### Timeout for hiding

Consider adding a timeout if:

* The text is no longer than 10 words.

* The tooltip appears at the place at which the user is currently looking.

* There is no link in the tooltip.

For example, the Got It tooltip has a timeout because the text is short, the user has just started the Rename refactoring, and is very likely looking at this place:

![Got it short](images/got_it_short.png)
#### Implementation

Default timeout duration is 5 seconds. A custom duration can be set:

Kotlin:

```KOTLIN
GotItTooltip(TOOLTIP_ID, GOT_IT_TEXT, parentDisposable)
    .withTimeout(3000)
```

Java:

```JAVA
new GotItTooltip(TOOLTIP_ID, GOT_IT_TEXT, parentDisposable)
    .withTimeout(3000);
```

### Versioning

If a tooltip is triggered by an action or plugin installation, do not tie them to the current IDE version. In this case, users might miss a tooltip if they are using this functionality or plugin for the first time in the next IDE version.

## Built-in behavior

### Frequency

By default, a tooltip is shown only once per user.

### Closable

The tooltip disappears when:

* `Esc` is pressed

* User clicks any place outside the tooltip

* On a timeout

### Multiple Got It tooltips

If several tooltips appear at the same time, they are shown one by one.

### Text width

The tooltip width adjusts automatically to make the right margin 16 px. Text width is 280 px by default.

