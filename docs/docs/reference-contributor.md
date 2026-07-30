# 10. Reference Contributor

<tldr>
Reference: [References and Resolve](references-and-resolve.html), [PSI References](psi-references.html)

Code: [SimpleNamedElement](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleNamedElement.java),
[SimpleNamedElementImpl](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/impl/SimpleNamedElementImpl.java),
[SimpleReference.java](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleReference.java),
[SimpleReferenceContributor](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleReferenceContributor.java),
[SimpleRefactoringSupportProvider](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleRefactoringSupportProvider.java)

Testing: [3. Completion Test](completion-test.html), [6. Rename Test](rename-test.html), [10. Reference Test](reference-test.html),
</tldr>

Tip:

This page is part of multi-step [Custom Language Support Tutorial](custom-language-support-tutorial.html).
All previous steps must be executed in sequence for the code to work.

The references functionality is one of the most important parts in the implementation of custom language support.
Resolving references means the ability to go from the usage of an element to its declaration, completion, rename refactoring, find usages, etc.

Note:

Every PSI element that can be renamed or referenced needs to implement [PsiNamedElement](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/PsiNamedElement.java) interface.

## Define a Named Element Class

The classes below show how the Simple Language fulfills the need to implement `PsiNamedElement`.

The [SimpleNamedElement](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/SimpleNamedElement.java) interface is subclassed from [PsiNameIdentifierOwner](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/PsiNameIdentifierOwner.java).

```JAVA
public interface SimpleNamedElement extends PsiNameIdentifierOwner {

}
```

The [SimpleNamedElementImpl](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/psi/impl/SimpleNamedElementImpl.java) class implements the `SimpleNamedElement` interface and extends [ASTWrapperPsiElement](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-impl/src/com/intellij/extapi/psi/ASTWrapperPsiElement.java).

```JAVA
public abstract class SimpleNamedElementImpl extends ASTWrapperPsiElement implements SimpleNamedElement {

  public SimpleNamedElementImpl(@NotNull ASTNode node) {
    super(node);
  }

}
```

## Define Helper Methods for Generated PSI Elements

Modify `SimplePsiImplUtil` to support new methods that get added to the PSI class for Simple Language.
Note that `SimpleElementFactory` isn't defined until the [next step](#define-an-element-factory), so for now it shows as an error.

```JAVA
public class SimplePsiImplUtil {

  // ...

  public static String getName(SimpleProperty element) {
    return getKey(element);
  }

  public static PsiElement setName(SimpleProperty element, String newName) {
    ASTNode keyNode = element.getNode().findChildByType(SimpleTypes.KEY);
    if (keyNode != null) {
      SimpleProperty property =
          SimpleElementFactory.createProperty(element.getProject(), newName);
      ASTNode newKeyNode = property.getFirstChild().getNode();
      element.getNode().replaceChild(keyNode, newKeyNode);
    }
    return element;
  }

  public static PsiElement getNameIdentifier(SimpleProperty element) {
    ASTNode keyNode = element.getNode().findChildByType(SimpleTypes.KEY);
    return keyNode != null ? keyNode.getPsi() : null;
  }

  // ...

}
```

## Define an Element Factory

The `SimpleElementFactory` provides methods for creating `SimpleFile`.

```JAVA
package org.intellij.sdk.language.psi;

import com.intellij.openapi.project.Project;
import com.intellij.psi.*;
import org.intellij.sdk.language.SimpleFileType;

public class SimpleElementFactory {

  public static SimpleProperty createProperty(Project project, String name) {
    SimpleFile file = createFile(project, name);
    return (SimpleProperty) file.getFirstChild();
  }

  public static SimpleFile createFile(Project project, String text) {
    String name = "dummy.simple";
    return (SimpleFile) PsiFileFactory.getInstance(project).
        createFileFromText(name, SimpleFileType.INSTANCE, text);
  }
}
```

## Update Grammar and Regenerate the Parser

Now make corresponding changes to the `Simple.bnf` grammar file by replacing the `property` definition with the lines below.
Remember to regenerate the parser after updating the file!
Right-click on the `Simple.bnf` file and select Generate Parser Code.

```BNF
property ::= (KEY? SEPARATOR VALUE?) | KEY {
  mixin="org.intellij.sdk.language.psi.impl.SimpleNamedElementImpl"
  implements="org.intellij.sdk.language.psi.SimpleNamedElement"
  methods=[getKey getValue getName setName getNameIdentifier]
}
```

## Define a Reference

Now define a reference class [SimpleReference.java](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleReference.java) to resolve a property from its usage.
As a single reference can [resolve to multiple](references-and-resolve.html#resolving-to-multiple-targets) Simple properties, it implements [PsiPolyVariantReference](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/PsiPolyVariantReference.java).
To simplify the implementation, [PsiPolyVariantReferenceBase](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/PsiPolyVariantReferenceBase.java) is used as a base class.

```JAVA
final class SimpleReference extends PsiPolyVariantReferenceBase<PsiElement> {

  private final String key;

  SimpleReference(@NotNull PsiElement element, TextRange textRange) {
    super(element, textRange);
    key = element.getText()
        .substring(textRange.getStartOffset(), textRange.getEndOffset());
  }

  @Override
  public ResolveResult @NotNull [] multiResolve(boolean incompleteCode) {
    Project project = myElement.getProject();
    List<SimpleProperty> properties = SimpleUtil.findProperties(project, key);
    List<ResolveResult> results = new ArrayList<>();
    for (SimpleProperty property : properties) {
      results.add(new PsiElementResolveResult(property));
    }
    return results.toArray(new ResolveResult[0]);
  }

  @Override
  public Object @NotNull [] getVariants() {
    Project project = myElement.getProject();
    List<SimpleProperty> properties = SimpleUtil.findProperties(project);
    List<LookupElement> variants = new ArrayList<>();
    for (SimpleProperty property : properties) {
      if (property.getKey() != null && !property.getKey().isEmpty()) {
        variants.add(LookupElementBuilder
            .create(property).withIcon(SimpleIcons.FILE)
            .withTypeText(property.getContainingFile().getName())
        );
      }
    }
    return variants.toArray();
  }

}
```

## Define a Reference Contributor

A reference contributor allows the `simple_language_plugin` to provide references to Simple Language from elements in other languages such as Java.
Create [SimpleReferenceContributor](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleReferenceContributor.java) by subclassing [PsiReferenceContributor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/PsiReferenceContributor.java).
Contribute a reference to each usage of a property:

```JAVA
final class SimpleReferenceContributor extends PsiReferenceContributor {

  @Override
  public void registerReferenceProviders(@NotNull PsiReferenceRegistrar registrar) {
    registrar.registerReferenceProvider(PlatformPatterns.psiElement(PsiLiteralExpression.class),
        new PsiReferenceProvider() {
          @Override
          public PsiReference @NotNull [] getReferencesByElement(@NotNull PsiElement element,
                                                                 @NotNull ProcessingContext context) {
            PsiLiteralExpression literalExpression = (PsiLiteralExpression) element;
            String value = literalExpression.getValue() instanceof String ?
                (String) literalExpression.getValue() : null;
            if ((value != null && value.startsWith(SIMPLE_PREFIX_STR + SIMPLE_SEPARATOR_STR))) {
              TextRange property = new TextRange(SIMPLE_PREFIX_STR.length() + SIMPLE_SEPARATOR_STR.length() + 1,
                  value.length() + 1);
              return new PsiReference[]{new SimpleReference(element, property)};
            }
            return PsiReference.EMPTY_ARRAY;
          }
        });
  }

}
```

## Register the Reference Contributor

The `SimpleReferenceContributor` implementation is registered using
the [com.intellij.psi.referenceContributor](https://jb.gg/ipe?extensions=com.intellij.psi.referenceContributor) extension point
and specifying `language="JAVA"`.

```XML
<extensions defaultExtensionNs="com.intellij">
  <psi.referenceContributor
      language="JAVA"
      implementation="org.intellij.sdk.language.SimpleReferenceContributor"/>
</extensions>
```

## Run the Project with the Reference Contributor

[Run](creating-plugin-project.html#running-the-plugin) the plugin.

The IDE now resolves the property and provides [completion](https://www.jetbrains.com/help/idea/auto-completing-code.html#basic_completion) suggestions:

![Reference Contributor](images/reference_contributor.png)
The [Rename refactoring](https://www.jetbrains.com/help/idea/rename-refactorings.html#invoke-rename-refactoring) functionality is now available from definition and usages.

![Rename](images/rename.png)

## Define a Refactoring Support Provider

Support for in-place refactoring is specified explicitly in a refactoring support provider.
Create [SimpleRefactoringSupportProvider](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/simple_language_plugin/src/main/java/org/intellij/sdk/language/SimpleRefactoringSupportProvider.java) by subclassing [RefactoringSupportProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/refactoring/src/com/intellij/lang/refactoring/RefactoringSupportProvider.java)
As long as an element is a `SimpleProperty` it is allowed to be refactored:

```JAVA
final class SimpleRefactoringSupportProvider extends RefactoringSupportProvider {

  @Override
  public boolean isMemberInplaceRenameAvailable(@NotNull PsiElement elementToRename, @Nullable PsiElement context) {
    return (elementToRename instanceof SimpleProperty);
  }

}
```

## Register the Refactoring Support Provider

The `SimpleRefactoringSupportProvider` implementation is registered with the IntelliJ Platform in the plugin configuration file
using the [com.intellij.lang.refactoringSupport](https://jb.gg/ipe?extensions=com.intellij.lang.refactoringSupport) extension point
.

```XML
<extensions defaultExtensionNs="com.intellij">
  <lang.refactoringSupport
      language="Simple"
      implementationClass="org.intellij.sdk.language.SimpleRefactoringSupportProvider"/>
</extensions>
```

## Run the Project

[Run](creating-plugin-project.html#running-the-plugin) the plugin.

The IDE now supports [refactoring](https://www.jetbrains.com/help/idea/rename-refactorings.html) suggestions:

![In Place Rename](images/in_place_rename.png)

