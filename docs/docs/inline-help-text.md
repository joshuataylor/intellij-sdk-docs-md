# Inline Help Text

Inline help texts provide useful information about settings:

![Inline help text](images/context_help_inline_text.png)

## When to use

Follow the rules for [context help](context-help.html).

## How to use

### Text length

Show no more than five lines of help text to not clutter the screen.
Text width is limited to 70 characters.
![Inline text height](images/inline_text_height.png)
Show more than five lines only when a text cannot be shortened for legal purposes.

![Inline text legal](images/inline_text_legal.png)
#### Implementation

```KOTLIN
panel {
  row {
    checkBox("Send usage statistics when using EAP versions")
      .comment("""
        <p>Help JetBrains improve its products by sending anonymous
        data about features and plugins used, hardware and software
        configuration, statistics on types of files, number of files
        per project, etc.</p>
        <br/>
        <p>Please note that this will not include personal data or
        any sensitive information, such as source code, file names,
        etc. The data sent complies with the
        <a href=\"https://www.jetbrains.com\">
        JetBrains Privacy Policy</a></p>
        """.trimIndent()
      )
  }
}
```

### Links

Provide a [link](link.html) to the corresponding help article or to a place in the IDE where the related settings can be found.
Place the link at the end of the text where possible so that it does not disrupt reading.

|        Internal link       ![Internal link](images/inline_text_internal_link.png)      |       External link       ![External link](images/inline_text_external_link.png)      |

### Text style formatting

#### Avoid highlighting

Avoid text highlighting. Usually, the help text is short, and no highlighting in bold or italics is needed:
|        Correct       ![Avoid highlighting: correct](images/inline_text_formatting_correct.png)      |       Incorrect       ![Avoid highlighting: incorrect](images/inline_text_formatting_incorrect.png)      |

#### Avoid brackets

Avoid using brackets in control labels and place this information in the inline text instead:
|        Correct       ![Avoid brackets: correct](images/inline_text_brackets_correct.png)      |       Incorrect       ![Avoid brackets: incorrect](images/inline_text_brackets_incorrect.png)      |

### Writing guidelines

* Make help text [short and descriptive](writing-short.html).

* Do not repeat the setting name in the help text:

|        Correct       ![Avoid brackets: correct](images/inline_text_repetition_correct.png)      |       Incorrect       ![Avoid brackets: incorrect](images/inline_text_repetition_incorrect.png)      |

## Placement

### Labeled inputs, checkboxes, radio buttons, and buttons

Place the help text to the right of labeled inputs (fields, combo boxes, or text areas), checkboxes, buttons, or radio buttons if all the following applies:

* The space to the right is empty.

* The help text has 1–5 words, not counting articles and prepositions.

* The control label has 1–5 words.

Labeled inputs:

![Input fields with inline texts on the right](images/inline_text_on_the_right_input_field.png)
#### Implementation

```KOTLIN
panel {
  row("Plugin update policy:") {
      comboBox(listOf("Default", "Non default"))
      comment("Ignore by Maven 3+")
  }
  row("Thread count:") {
      textField()
      comment("-T option")
  }
}
```

Checkboxes:

![Checkboxes with inline texts on the right](images/inline_text_on_the_right_checkbox.png)
#### Implementation

```KOTLIN
panel {
  row {
    checkBox("Build project automatically")
    comment("Works while not running / debugging")
  }
  row {
    checkBox("Compile independent modules in parallel")
    comment("May require larger heap size")
  }
}
```

Buttons:

![Button with inline texts on the right](images/inline_text_on_the_right_button.png)

In other cases, place the help text under the UI controls:

![Input filed with inline text on the bottom](images/inline_text_on_the_bottom.png)
#### Implementation

```KOTLIN
panel {
  row("Default directory:") {
    textFieldWithBrowseButton()
      .comment(
        "Preselected in Open and New | Project dialogs"
      )
  }
}
```

If there is no space under the UI control, use the [help tooltip](tooltip.html#question-mark-icon-for-help-tooltips) with the question mark icon for labeled inputs, checkboxes, and radio buttons.
For buttons, use the help tooltip without the icon.

### Trees, lists, and tables

#### Text applies to the whole component

If the help text applies to a whole list, tree, or table, place it below the control.
![Inline text under the table](images/inline_text_under_table.png)
##### Implementation

```KOTLIN

import javax.swing.JTable

panel {
  row {
    cell(createTable()) // Actual table creation
      .align(Align.FILL)
      .comment("""
        &lt;Project> is content roots of all modules,
        all immediate descendants<br/>of the projects base
        directory, and .idea directory contents
        """.trimIndent()
      )
  }.resizableRow()
}
```

#### Text applies to a single item

If the help text applies to a single list, tree, or table item, its location will depend on its length.
##### Short texts

Place short texts (1–10 words) to the right of the item:
![Inline text under the table](images/inline_text_on_the_right_tree.png)

##### Long texts

* Place longer texts (more than 10 words) into the detail part of master-detail layouts:

![Inline text on the bottom of the master detail layout](images/inline_text_on_the_bottom_master_detail.png)
* For other cases, use the [help tooltip](tooltip.html#question-mark-icon-for-help-tooltips) with the question mark icon:

![Inline text on the bottom of the master detail layout](images/tooltip_list.png)

### Group of controls

If the help text applies to several UI controls, place it at the bottom of the group.

![Inline text for a group of controls](images/inline_text_group.png)
#### Implementation

Use [Panel.group()](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/dsl/builder/Panel.kt) as the border for panels that need title and possibly the gray line on the right of the title:

```KOTLIN
panel {
  group("Build and Run") {
    row("Build and run with:") {
      comboBox(listOf("IntelliJ IDEA", "Gradle"))
    }
    row("Run tests with:") {
      comboBox(listOf("IntelliJ IDEA", "Gradle"))
    }
    row {
      comment("""
        <p>By default IntelliJ IDEA uses Gradle to build the project
        and run the tasks.</p>
        <p>In a pure Java/Kotlin project, building and running
        by means of IDE might be faster, thanks to optimizations.
        Note, that the IDE doesn't support all Gradle plugins and
        the project might not be built correctly with some of them.</p>
        """.trimIndent()
      )
    }
  }
  group("Gradle") {
    row("Use Gradle from:") {
      comboBox(gradleModel)
    }
  }
}
```

Find more examples by invoking the Tools | Internal Actions | UI | Kotlin UI DSL | UI DSL Showcase action (available in [internal mode](enabling-internal.html) and clicking the View source links on specific pages.

