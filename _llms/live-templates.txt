# Live Templates

<tldr>
Product Help: [Live templates](https://www.jetbrains.com/help/idea/using-live-templates.html)
</tldr>

Live Templates are customizable rules that allow developers to abbreviate repetitive text patterns or surround code fragments with repetitive constructs in the editor.

When a user types the designated abbreviation followed by a configurable expansion key (usually `Tab`), the IDE transforms the preceding input sequence to its full-length output, and update the cursor position.

For example, consider a Java `for` loop.
Typically, the end user would need to type `for (int i = 0; i < 10; i++) {<Enter><Tab><Enter><Enter>}<Up>`.
This pattern may be shortened to `fori<Tab>` and the remaining contents will be expanded, leaving the following structure:

```JAVA
for (int i = [|]; i < []; i++) {
  []
}
```

As the user completes each section of the `for` loop and presses `Tab`, the cursor advances to the next position in the editor.

Another use-case for live templates is surrounding the selected code with additional constructs.
When a user selects a code fragment and invokes the `Code | Surround With...` action and chooses the template from the list, the code is wrapped with the content defined in the template.

Consider the following Java method with the selected fragment inside `<selection>`:

```JAVA
public void testMethod() {
  <selection>getActions()</selection>
}
```

Invoking the `Code | Surround With...` action and selecting the Iterate Iterable or array template would transform the code to:

```JAVA
public void testMethod() {
  for (Action action : getActions()) {
    <cursor>
  }
}
```

Note:

See the [Surround With](surround-with.html) section for the information on how to implement more advanced code surrounding.

For more information about creating Custom Live Templates, refer to the [corresponding documentation](https://www.jetbrains.com/idea/help/creating-and-editing-live-templates.html).

These sections describe how to add Live Templates, and their associated building blocks, to plugins.

* [Providing Live Templates](providing-live-templates.html) * [Live Templates Configuration File](live-templates-configuration-file.html)

* [Creating New Functions for Live Templates](creating-live-template-functions.html)

