# Modifying Project View Structure

This tutorial is meant to illustrate how the project tree structure view appearance can be modified programmatically.

This topic describes the [treeStructureProvider](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/tree_structure_provider) sample plugin.

The steps below show how to filter out and keep visible only text files and directories in the Project View Panel.

Other use cases include:

* grouping/nesting related entries, e.g., [GUI Designer](https://www.jetbrains.com/help/idea/gui-designer-basics.html) `.form` file and related bound class ([FormMergerTreeStructureProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/plugins/ui-designer/src/com/intellij/uiDesigner/projectView/FormMergerTreeStructureProvider.java)).

* provide additional "nested" nodes, e.g., contents of custom archive file

## 

Implement Custom `TreeStructureProvider`

To provide custom Structure View behaviour, implement [TreeStructureProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/editor-ui-api/src/com/intellij/ide/projectView/TreeStructureProvider.java) with the nodes filtering logic in `modify()` method.
If access to indexes is not required, it can be marked [dumb aware](indexing-and-psi-stubs.html#DumbAwareAPI).

The example below shows how to filter out all the Project View nodes except those which correspond to text files and directories.

```JAVA
final class TextOnlyTreeStructureProvider implements TreeStructureProvider {

  @NotNull
  @Override
  public Collection<AbstractTreeNode<?>> modify(@NotNull AbstractTreeNode<?> parent,
                                                @NotNull Collection<AbstractTreeNode<?>> children,
                                                ViewSettings settings) {
    ArrayList<AbstractTreeNode<?>> nodes = new ArrayList<>();
    for (AbstractTreeNode<?> child : children) {
      if (child instanceof PsiFileNode) {
        VirtualFile file = ((PsiFileNode) child).getVirtualFile();
        if (file != null && !file.isDirectory() && !(file.getFileType() instanceof PlainTextFileType)) {
          continue;
        }
      }
      nodes.add(child);
    }
    return nodes;
  }

}
```

## 

Register Custom `TreeStructureProvider`

Register the implementation in [com.intellij.treeStructureProvider](https://jb.gg/ipe?extensions=com.intellij.treeStructureProvider) extension point
to the [plugin.xml](https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/tree_structure_provider/src/main/resources/META-INF/plugin.xml)

```XML
<extensions defaultExtensionNs="com.intellij">
  <treeStructureProvider implementation="org.intellij.sdk.treeStructureProvider.TextOnlyTreeStructureProvider"/>
</extensions>
```

## Compile and Run the Plugin

See [Code Samples](code-samples.html) on how to set up and run the plugin.

After going through the steps described above, you can see only text files and directories belonging to a project in the Project View.

![Text Files](images/text_only.png)

