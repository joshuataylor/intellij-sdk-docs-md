# Project View

<tldr>
Product Help: [Project tool window](https://www.jetbrains.com/help/idea/project-tool-window.html)
</tldr>

* [Modifying Project View Structure](tree-structure-view.html)

## Decorating Project View Nodes

Plugin authors can modify the representation of nodes in the project view.
This is used to, e.g., change the icon of module nodes to reflect the module type or add URL and server path
to Python Jupyter directories as location strings.

To modify project view node representations, implement
[ProjectViewNodeDecorator](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/ide/projectView/ProjectViewNodeDecorator.kt)
and register it in the [com.intellij.projectViewNodeDecorator](https://jb.gg/ipe?extensions=com.intellij.projectViewNodeDecorator) extension point
.
From the interface only the `decorate()` method that modifies `ProjectViewNode`s needs to be implemented.

To update the node representation on certain events, use
[ProjectView.refresh()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-impl/src/com/intellij/ide/projectView/ProjectView.java).

