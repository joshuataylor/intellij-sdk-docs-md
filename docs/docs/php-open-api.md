# PHP Open API

## Dependency in plugin.xml

```XML
<depends>com.jetbrains.php</depends>
```

## PHP PSI

`com.jetbrains.php.lang.psi.elements.*;`

## Utility Classes

### 

`PhpFilePathUtils`

`com.jetbrains.php.lang.psi.elements.impl.PhpFilePathUtils` contains helper methods for working with paths from PSI elements.

* `getFileName()` returns a constant string representation of the path from the PSI element. For example, for the expression: ```PHP // in file: /bin/folder/file.php __DIR__ . "/file2.php"; ``` it returns `"/bin/folder/file2.php"`. Note that the element passed as an argument can contain any expression that can be statically evaluated to a constant.

* `getReferences()` returns all path references from the PSI element. Using this method in conjunction with [PsiReferenceContributor](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/psi/PsiReferenceContributor.java) you can add autocompletion for string literals in the specific contexts. For example, if certain PHP functions in your code accept paths, you can autocomplete them when writing arguments. Note that PhpStorm automatically adds references for concatenation expressions with `__DIR__` or `dirname(__FILE__)` function call.

## PHP Extension Points

Note:

See [PHP Extension Point and Listener List](php-extension-point-list.html) for the complete list.

