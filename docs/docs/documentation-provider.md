# 20. Documentation

<tldr>
Reference: [Documentation](documentation.html)

Code: [SimpleDocumentationProvider](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleDocumentationProvider.java),
[SimpleUtil](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleUtil.java)

Testing: [11. Documentation Test](documentation-test.html)
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

Note:

For plugins targeting IntelliJ Platform version 2023.1 or later, it is recommended to use the
[Documentation Target API](documentation.html#documentation-target-api).

A [DocumentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/lang/documentation/DocumentationProvider.java)
helps users by showing documentation for symbols like method calls inside the editor.
For the custom language tutorial, we're implementing a version of this extension point (EP) for the Simple Language that shows the key/value,
the file where it is defined, and any related documentation comment.

## Implement a Documentation Provider and Register the EP

In the first step, we create an empty class that extends
[AbstractDocumentationProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/analysis-api/src/com/intellij/lang/documentation/AbstractDocumentationProvider.java)
and register it in the `[plugin.xml](plugin-configuration-file.html)`.

```JAVA
final class SimpleDocumentationProvider extends AbstractDocumentationProvider { }
```

Make sure the extension is registered in the `plugin.xml` as shown below:

```XML
<extensions defaultExtensionNs="com.intellij">
  <!-- Other extensions… -->
  <lang.documentationProvider
      language="Simple"
      implementationClass="org.intellij.sdk.language.SimpleDocumentationProvider"/>
</extensions>
```

## Ensure That the Correct PSI Element Is Used

For the Simple Language, we consider two use-cases:

1. A Simple key is [used inside a Java string literal](reference-contributor.html),
and we would like to show documentation for the key/value right from the reference inside the Java file.

2. The cursor is already over a key/value definition inside a Simple file, in which case we would also like to show its documentation.

To ensure that the IntelliJ Platform chooses the correct element of type `SimpleProperty` when `View | Quick Documentation` is called,
we create a dummy implementation of `generateDoc()`:

```JAVA
@Override
public @Nullable String generateDoc(PsiElement element,
                                    @Nullable PsiElement originalElement) {
  return super.generateDoc(element, originalElement);
}
```

Now, we set a breakpoint in our dummy implementation, debug the plugin, and call `View | Quick Documentation`
for the Simple property both in the Java file and the Simple file.
We do this by placing the cursor over the key and invoking `View | Quick Documentation` to show the documentation.

In both cases, we find that the element provided is `SimplePropertyImpl`, which is exactly what we hoped for.
However, there are two drawbacks: inside a Java string, your cursor needs to be directly over `key` in the string `"simple:key"` to make Quick Documentation work.
Since the Simple Language only allows for one property per string,
it would be nice if Quick Documentation worked no matter where your cursor was positioned in the string as long as the string contained a Simple property.
Inside a Simple file, the situation is similar, and calling `View | Quick Documentation` only works when the cursor is positioned on the key.

Refer to the [Addendum](#addendum) below, which explains how to improve on this situation by additionally overriding the `getCustomDocumentationElement()` method.

## Extract Documentation Comments from Key/Value Definitions

While `SimpleProperty` elements will provide us with their key and value, we have no direct access to a possible comment that is preceding the key/value definition.
Since we would like to show this comment in the documentation as well, we need a small helper function that extracts the text from the comment.
This function will reside in the `SimpleUtil` class and will find, for instance, the comment preceding `apikey` in the following short example:

```PROPERTIES
# An application programming interface key (API key) is a unique
# identifier used to authenticate a user, developer, or calling
# program to an API.
apikey=ph342m91337h4xX0r5k!11Zz!
```

The following implementation will check if there is any comment preceding a `SimpleProperty`, and if there is,
it will collect all comment lines until it reaches either the previous key/value definition or the beginning of the file.
One caveat is that since we're collecting the comment lines backwards, we need to reverse the list before joining them into a single string.
A simple regex is used to remove the leading hash characters and whitespaces from each line.

```JAVA
/**
 * Attempts to collect any comment elements above the Simple key/value pair.
 */
public static @NotNull String findDocumentationComment(SimpleProperty property) {
  List<String> result = new LinkedList<>();
  PsiElement element = property.getPrevSibling();
  while (element instanceof PsiComment || element instanceof PsiWhiteSpace) {
    if (element instanceof PsiComment) {
      String commentText = element.getText().replaceFirst("[!# ]+", "");
      result.add(commentText);
    }
    element = element.getPrevSibling();
  }
  return StringUtil.join(Lists.reverse(result), "\n ");
}
```

## Render the Documentation

With easy ways to access the key, the value, the file, and a possible documentation comment,
we now have everything in place to provide a useful implementation of `generateDoc()`.

```JAVA
/**
 * Extracts the key, value, file and documentation comment of a Simple key/value entry and returns
 * a formatted representation of the information.
 */
@Override
public @Nullable String generateDoc(PsiElement element, @Nullable PsiElement originalElement) {
  if (element instanceof SimpleProperty) {
    final String key = ((SimpleProperty) element).getKey();
    final String value = ((SimpleProperty) element).getValue();
    final String file = SymbolPresentationUtil.getFilePathPresentation(element.getContainingFile());
    final String docComment = SimpleUtil.findDocumentationComment((SimpleProperty) element);

    return renderFullDoc(key, value, file, docComment);
  }
  return null;
}
```

The creation of the rendered documentation is done in a separate method for clarity.
It uses `DocumentationMarkup` to align and format the contents.

```JAVA
/**
 * Creates the formatted documentation using {@link DocumentationMarkup}. See the Java doc of
 * {@link com.intellij.lang.documentation.DocumentationProvider#generateDoc(PsiElement, PsiElement)} for more
 * information about building the layout.
 */
private String renderFullDoc(String key, String value, String file, String docComment) {
  StringBuilder sb = new StringBuilder();
  sb.append(DocumentationMarkup.DEFINITION_START);
  sb.append("Simple Property");
  sb.append(DocumentationMarkup.DEFINITION_END);
  sb.append(DocumentationMarkup.CONTENT_START);
  sb.append(value);
  sb.append(DocumentationMarkup.CONTENT_END);
  sb.append(DocumentationMarkup.SECTIONS_START);
  addKeyValueSection("Key:", key, sb);
  addKeyValueSection("Value:", value, sb);
  addKeyValueSection("File:", file, sb);
  addKeyValueSection("Comment:", docComment, sb);
  sb.append(DocumentationMarkup.SECTIONS_END);
  return sb.toString();
}
```

The `addKeyValueSection()` method used is just a small helper function to reduce repetition.

```JAVA
/**
 * Creates a key/value row for the rendered documentation.
 */
private void addKeyValueSection(String key, String value, StringBuilder sb) {
  sb.append(DocumentationMarkup.SECTION_HEADER_START);
  sb.append(key);
  sb.append(DocumentationMarkup.SECTION_SEPARATOR);
  sb.append("<p>");
  sb.append(value);
  sb.append(DocumentationMarkup.SECTION_END);
}
```

After implementing all the steps above, the IDE will show the rendered documentation for a Simple key when called with `View | Quick Documentation`.

## Implement Additional Functionality

We can provide implementations for additional functionality that comes with a `DocumentationProvider`.
For instance, when simply hovering the mouse over the code, it also shows documentation after a short delay.
It's not necessary that this popup shows the exact same information as when calling `View | Quick Documentation`, but for this tutorial, we'll do just that.

```JAVA
/**
 * Provides documentation when a Simple Language element is hovered with the mouse.
 */
@Override
public @Nullable String generateHoverDoc(@NotNull PsiElement element, @Nullable PsiElement originalElement) {
  return generateDoc(element, originalElement);
}
```

When the mouse hovers over code with `Ctrl`/`Cmd` pressed, the IDE shows navigation information of the symbol under the cursor,
such as its namespace or package.
The implementation below will show the Simple key and the file where it is defined.

```JAVA
/**
 * Provides the information in which file the Simple language key/value is defined.
 */
@Override
public @Nullable String getQuickNavigateInfo(PsiElement element, PsiElement originalElement) {
  if (element instanceof SimpleProperty) {
    final String key = ((SimpleProperty) element).getKey();
    final String file = SymbolPresentationUtil.getFilePathPresentation(element.getContainingFile());
    return "\"" + key + "\" in " + file;
  }
  return null;
}
```

Finally, `View | Quick Documentation` can also be called from a selected entry within the autocompletion popup.
In that case, language developers need to ensure that the correct PSI element for generating the documentation is provided.
In the case of Simple Language, the lookup element is already a `SimpleProperty` and no additional work needs to be done.
In other circumstances, you can override `getDocumentationElementForLookupItem()`and return the correct PSI element.

## Addendum: Choosing a Better Target Element

To be able to call `View | Quick Documentation` for Simple properties in all places of a Java string literal, two steps are required:

1. The extension point needs to be changed from `com.intellij.lang.documentationProvider` to `com.intellij.documentationProvider` because only then
the Simple DocumentationProvider is called for PSI elements with a different language.

2. The `getCustomDocumentationElement()` method needs to be implemented to find the correct target PSI element for creating the documentation.

Therefore, the current version of the code could be extended to check whether `View | Quick Documentation` was called from inside a Java string or a Simple file.
It then uses PSI and `PsiReference` functionalities to determine the correct target element.
This allows getting documentation for a Simple property no matter where it was called inside a Java string literal or a Simple property definition.

```JAVA
@Override
public @Nullable PsiElement getCustomDocumentationElement(@NotNull Editor editor,
                                                          @NotNull PsiFile file,
                                                          @Nullable PsiElement context,
                                                          int targetOffset) {
  if (context != null) {
    // In this part the SimpleProperty element
    // is extracted from inside a Java string
    if (context instanceof PsiJavaToken &&
        ((PsiJavaToken) context).getTokenType().equals(JavaTokenType.STRING_LITERAL)) {
      PsiElement parent = context.getParent();
      PsiReference[] references = parent.getReferences();
      for (PsiReference ref : references) {
        if (ref instanceof SimpleReference) {
          PsiElement property = ref.resolve();
          if (property instanceof SimpleProperty) {
            return property;
          }
        }
      }
    }
    // In this part the SimpleProperty element is extracted
    // when inside of a .simple file
    else if (context.getLanguage() == SimpleLanguage.INSTANCE) {
      PsiElement property =
        PsiTreeUtil.getParentOfType(context, SimpleProperty.class);
      if (property != null) {
        return property;
      }
    }
  }
  return super.getCustomDocumentationElement(
      editor, file, context, targetOffset);
}
```

