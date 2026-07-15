# Empty State

<tldr>
Implementation: [ComponentWithEmptyText](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/platform-api/src/com/intellij/util/ui/ComponentWithEmptyText.java)
</tldr>

Empty states of tool windows, lists, trees, tables, master-detail layouts, or other container components should be informative for the users.
Fill in the empty states with the following:

* [A reason why the container is empty](#reason-why-empty)

* [Actions to fill in the area](#actions-to-fill-the-area)

* [A link to the corresponding help topic](#help-topic)

![Empty state of a tool window](images/empty_state_structure.png)

## Reason why empty

### Explain the current state

The default pattern is `No [entity] added.` If `added`, `created`, `configured`, or other words act as synonyms in a particular case, use `added` for consistency.

|        Correct       ![Correct text in the empty state](images/empty_state_reason_correct.png)      |       Incorrect       ![Incorrect text in the empty state](images/empty_state_reason_incorrect.png)      |

### Be precise

Do not introduce new entities that are not used in the current context.
Instead, use the terms from the current UI so that the user understands
what exactly is missing:

|        Correct       ![The reason is clear](images/empty_state_clear_reason.png)      |       Incorrect       ![The reason is not clear](images/empty_state_unclear_reason.png) |

## Actions to fill the area

An action makes it easier to understand what to start with
instead of searching for the appropriate icon on the toolbar.
It can also educate about the shortcut.

### Use one or two actions

Three or more actions would make it harder to choose what to start from.

|        Correct       ![One action](images/empty_state_actions_correct.png)      |       Incorrect       ![Three actions](images/empty_state_actions_incorrect.png)      |

In rare cases, when you need to list all possible starting points, use the list layout.

If there is enough space (for example, in horizontal tool windows), you may use the table layout to place action links, shortcuts, and action descriptions:
![Table layout for actions](images/empty_state_table.png)

### Open menus from the toolbar

If an action opens a toolbar menu, open it at the same position where it
would be opened with the corresponding toolbar button. This would explain
which toolbar icon opens the menu.

|        Correct       ![Toolbar menu](images/empty_state_menu_correct.png)      |       Incorrect       ![Menu under the action](images/empty_state_menu_incorrect.png)      |

### Explain what to do when there is no action`

If there is no action that can be performed by clicking a link,
add a text describing all the required steps:

![Explain what to do when there is no action](images/empty_state_no_actions.png)

### Hide the toolbar

Hide the area's toolbar if it does not have the same action as
in the empty state. Usually, all other toolbar actions are not
relevant in this case.

Correct

![Hide the toolbar for the empty state](images/empty_state_no_actions.png)
Incorrect

![Toolbar is not needed](images/empty_state_toolbar.png)

## Help topic

|        ![Link to a help topic](images/empty_state_link_to_help.png)      |     Link to a help topic     In tool windows and [master-detail layouts](#empty-state-of-the-master-detail-layout), provide a link to a help topic that explains the functionality. Add the question mark icon in the beginning.        |
|        ![Inline hint under the table](images/empty_state_inline_help.png)      |       Context help in inline hints       In tables, trees, and lists, provide instructions according to the [inline text help](context-help.html#inline-help-text) rules.  Avoid using question mark links in these cases because such components rarely require deep explanations.    |

## Empty state of the master-detail layout

Master-detail layouts include a list or a tree on the left (in the master part)
and the details area on the right.

* If the master area is empty, display the explanation, action, and link to the help article.

* If the details area is empty, no explanations are needed. In this case, show the actions to fill in the area.

![Empty master-detail layout](images/empty_state_master_detail_layout.png)

## Writing guidelines

### Punctuation

Separate sentences in the empty state with periods, but do not put a period after the action link.
Use the ellipses at the end of the action link if this link opens a dialog or a popup which requires some input from the user.

|        Correct       ![Correct punctuation in the empty state](images/empty_state_punctuation_correct.png)      |       Incorrect       ![Incorrect punctuation in the empty state](images/empty_state_punctuation_incorrect.png)      |

### Capitalization

Use sentence capitalization in the empty state texts and links.

|        Correct       ![Correct capitalization in the empty state](images/empty_state_capitalization_correct.png)      |       Incorrect       ![Incorrect capitalization in the empty state](images/empty_state_capitalization_incorrect.png)      |

### Avoid excessive verbs

* In actions, avoid words that describe physical actions like `press` or `click` — they are obvious from how the link works.

* Avoid saying `add new`. Just use `add` because all that is added is new in the context of an empty UI area.

|        Correct       ![Correct usage of verbs in the empty state](images/empty_state_verbs_correct.png)      |       Incorrect       ![Incorrect usage of verbs in the empty state](images/empty_state_verbs_incorrect.png)      |

## Sizes and placement

Vertical spacing:

![Empty state vertical spacing](images/empty_state_vertical_spacing.png)
Minimum right and left margins:

![Empty state horizontal spacing](images/empty_state_horizontal_spacing.png)
Use non-breaking spaces in the following cases:

* Between action names and shortcuts

* For articles and prepositions

|        Correct       ![Correct usage of non-breaking spaces in the empty state](images/empty_state_non_breaking_space_correct.png)      |       Incorrect       ![Incorrect usage of non-breaking spaces in the empty state](images/empty_state_non_breaking_space_incorrect.png)      |

