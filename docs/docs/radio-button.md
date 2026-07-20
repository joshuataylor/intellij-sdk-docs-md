# Radio Button

<tldr>
Implementation: [JBRadioButton](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/ui/components/JBRadioButton.java)
</tldr>

![01 radio button](images/01_Radio%20Button.png)

## When to use

Use a radio button group to choose one option from 2 to 4 mutually exclusive options.

## When not to use

### Several options can be selected

Use a group of [checkboxes](checkbox.html) when several options can be selected.

### Yes or No Options

For only two opposing yes/no options, use a checkbox.

|        Correct![A correct example of using a checkbox instead of radiobuttons](images/02_When_to_use_correct.png)      |       Incorrect![An incorrect example of using radiobuttons instead of a checkbox](images/02_When_to_use_incorrect.png)      |

### 2-5 options with short labels

If the options have short labels, use a segmented button.

![03 when to use segmented button](images/03_When_to_use_Segmented_button.png)

### When to use a drop-down instead

Consider using a [drop-down list](drop-down.html) if:

* There are more than 5 options:

|        Correct![A correct example of using a drop-down list instead of radiobuttons](images/04_When_to_use_correct.png)      |       Incorrect![An incorrect example of using radiobuttons for a list of 5 or more options](images/04_When_to_use_incorrect.png)      |

* The options have long labels.

* The screen space is limited.

* The option might be used less often than other options on the screen.

* There are other drop-down lists in the same group of UI components. A radio button group is more noticeable than a drop-down list, so it will look like a more important setting.

* The setting combines several UI components into one control:

![05 when to use segmented button](images/05_When_to_use_Segmented_button.png)

## How to use

### Label

| ![Label example](images/06_How_to_use.png) |A label accompanies each radio button and is placed next to it.   |
| ![An example of a label spanning two lines.](images/07_How_to_use.png) |If a label is long, split it into two lines. Avoid labels that take more than two lines. See recommendations on writing concise labels below.   |

#### Implementation

Kotlin UI DSL:

```KOTLIN
radioButton(
    "<html>Show options before adding<br>to version control</html>")
```

Java:

```JAVA
new JRadioButton(
    "<html>Show options before adding<br>to version control</html>");
```

### Writing guidelines

* Use sentence-style capitalization.

* Do not use ending punctuation.

* Use the imperative form of verbs.

* Do not use negation in labels as it complicates understanding.

* Make labels short and intelligible — see [Writing short and clear text](writing-short.html).

|        Correct![A correct example of using a drop-down list instead of radiobuttons](images/08_How_to_use_correct.png)      |       Incorrect![An incorrect example of using radiobuttons for a list of 5 or more options](images/08_How_to_use_incorrect.png)      |

### Group label

| ![Label example](images/10_How_to_use.png) |Always start a radio button group with a group label to explain what the options are for. Use a colon at the end of a group label.   |
| ![An example of a label spanning two lines.](images/09_How_to_use.png) |Use a checkbox or another radio button as a group label if the radio button group needs to be turned on or off.   |

## Sizes and placement

Follow the layout of [checkboxes and radio-buttons](layout.html#checkboxes-and-radio-buttons)

