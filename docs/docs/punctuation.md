# Punctuation

Use the following rules for labels and description texts in IntelliJ user interfaces. For punctuation in numbers and times, see [Data formats](data-formats.html).

## Ellipsis

End an action name with an ellipsis if it opens a dialog where input is required or possible. An ellipsis helps users understand if an action is immediate, or additional interaction is to follow.

This rule applies to actions in the following controls: [button](button.html), [link](link.html), menu item.

Examples:

|          Save All           Build Project        |         Happens immediately, no ellipsis      |
|          Import Settings…           Export to HTML…        |         Opens dialogs that require input      |
|          Project Structure…      |         Opens a complex dialog where input is not required but possible      |
|          Tip of the Day           About IntelliJ IDEA        |         Opens dialogs that just show information, no input is either required or possible      |

Use an ellipsis at the end of a truncated text if there is no scrollbar and this is not a table column, see [truncation in table columns](table.html#sizes-and-placement). Provide a way to show the full text, for example, expand the control or show a tooltip on hover.

![2 01 truncated text](images/2_01_truncated_text.png)
A notification can be expanded to show the full text.

Use an ellipsis with verbs describing an ongoing process, for example, Searching… See more examples in [Progress text](progress-text.html).

Use the ellipsis character … (`U+2026` in Unicode). Do not use three separate "dot" characters.

## Period

Do not put a period at the end of a single sentence, even if it is a complete sentence.

![1 01 no period 1](images/1_01_no_period_1.png)![1 01 no period 2](images/1_01_no_period_2.png)
If a text consists of several sentences, put a period after each sentence.
![1 02 periods several sentences](images/1_02_periods_several_sentences.png)

Do not put a period at the end of an IDE action.

![1 03 periods action](images/1_03_periods_action.png)
The empty text consists of two sentences, but the second one is an IDE action, so it should not have a period.

Note that links that are not IDE actions can have a period in the end.

![1 04 period navigation link](images/1_04_period_navigation_link.png)

## Comma

Use a comma:

Before a conjunction in a list of three or more items (the Oxford or serial comma).

Border for a text field, combo box, or spinner

Between symbols in series.

Use the following characters: &, $, ., and *

## Colon

Use a colon after labels for inputs and radio button / checkbox groups.

![Input focus](images/input_focus.png)![Checkbox when to use](images/checkbox_when_to_use.png)
Do not use a colon if a label and text inside the input element make a phrase.

![Input placeholder default](images/input_placeholder_default.png)

## Contractions

Generally, do not use contractions.

Path can’t be found → Path cannot be found

Use contractions only if the action name has 4 and more words, and the contracted word does not affect the meaning significantly.

What’s New in IntelliJ IDEA

Don’t or Do not:

* Always contract in the phrase Don’t [some verb] again. The phrase is common, and the meaning is easily recognized. ![3 01 dont ask again](images/3_01_dont_ask_again.png)

* In other cases, do not contract. The full form reduces chances that the relevant meaning might be missed.

Don’t send → Do not send

Do not save, forget passwords after restart

## Quotation marks

Use single quotation marks by default.

Note:

Use a straight single quotation mark ' (`U+0027`). Do not use opening and closing quotation marks ‘ ’ (`U+2018`/`U+2019`).

Indexing library 'KotlinJavaRuntime'

Error parsing '.mvn/maven.config'

Add 'root=true' to the beginning of the file

Show 'Scratches and Consoles' in the Project view

Do not use quotation marks for keyboard key names.

Type an expression and press 'Enter' → press Enter

Do not use double quotation marks.

## Question marks

Use only in alerts when asking for confirmation.

A file with this name already exists. Do you want to overwrite it?

Avoid in other cases.

Forgot password? → Remind password

## Exclamation points

Do not use. Exclamation points can cause the sentence tone to be interpreted as aggressive, condescending, or overly informal.

