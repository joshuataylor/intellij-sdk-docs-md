# Code Inspections and Intentions

<tldr>
Product Help: [Code inspections](https://www.jetbrains.com/help/idea/code-inspection.html), [Intention actions](https://www.jetbrains.com/help/idea/intention-actions.html)

UI Guidelines: [Inspections](inspections.html)
</tldr>

Code inspections analyze code for potential issues, such as errors, inefficiencies, or code smells.
Code intentions suggest improvements and refactorings to enhance readability and maintainability.

While inspections focus on detecting problems, intentions provide optional enhancements to improve code structure.
Inspections are run on a full PSI tree and report found problems, while intention actions are run only on elements under the cursor.

## Inspections

The code inspections for custom languages use the same API as all other code inspections, based on the [LocalInspectionTool](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/codeInspection/LocalInspectionTool.java) class.

The functionality of [LocalInspectionTool](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/codeInspection/LocalInspectionTool.java) partially duplicates that of [Annotator](syntax-highlighting-and-error-highlighting.html#annotator).

The main differences are:

* supports batch analysis of code (through the `Code | Inspect Code...` action)

* the possibility to turn off the inspection (globally or by suppressing them on various levels)

* ability to configure the inspection options.

If none of that is required and the analysis only needs to run in the active editor, [Annotator](syntax-highlighting-and-error-highlighting.html#annotator) provides better performance (because it supports incremental analysis) and more flexibility for highlighting errors.

Examples:

* [Code Inspections Tutorial](code-inspections.html)

* A [simple inspection](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/plugins/properties/properties-psi-impl/src/com/intellij/lang/properties/codeInspection/TrailingSpacesInPropertyInspection.java) for the [Properties language plugin](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/plugins/properties)

Tip:

See changes in the [order of running highlighting](syntax-highlighting-and-error-highlighting.html#order-of-running-highlighting) introduced in 2024.1.

### Inspections Performance

A [custom language plugin](custom-language-support.html) providing many inspections (>100) can register the default [PsiElementVisitor](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/psi/PsiElementVisitor.java)
for its language in [com.intellij.inspection.basicVisitor](https://jb.gg/ipe?extensions=com.intellij.inspection.basicVisitor) extension point
to optimize processing.

## Intentions

The code intentions for custom languages also use the standard API for intentions.
The intention classes need to implement the [IntentionAction](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/analysis-api/src/com/intellij/codeInsight/intention/IntentionAction.java) interface
and are registered using the [com.intellij.intentionAction](https://jb.gg/ipe?extensions=com.intellij.intentionAction) extension point
.

Examples:

* [Code Intentions Tutorial](code-intentions.html)

* A [simple intention action](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/plugins/groovy/src/org/jetbrains/plugins/groovy/intentions/control/SplitIfIntention.java) for Groovy

* [Custom Language Support Tutorial: Quick Fix](quick-fix.html)

