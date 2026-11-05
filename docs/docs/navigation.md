# Navigation

Warning:

This API is currently in development and thus in experimental state.

The `Navigate | Declaration or Usages` action is performed in several steps.

## Direct Navigation

Direct navigation is the navigation from `PsiElement` to another `PsiElement`,
such as navigation from `break` keyword to the end of a loop in Java, without showing any popups.

To provide `PsiElement` for direct navigation, implement and register
[DirectNavigationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/navigation/DirectNavigationProvider.java)
in [com.intellij.lang.directNavigationProvider](https://jb.gg/ipe?extensions=com.intellij.lang.directNavigationProvider) extension point
.

## Symbol Navigation

If there is no Direct navigation available under the caret, then the IntelliJ Platform proceeds with `Symbol` navigation.
In this step the IntelliJ Platform computes the navigation targets based on target symbols,
which it obtains by resolving a [reference](declarations-and-references.html#references).
If there are several target symbols or several navigation targets defined for a symbol,
then the IDE shows the navigation popup to ask the user to choose where to go.

The [NavigationTarget](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/platform/backend/navigation/NavigationTarget.java)
is essentially a pair of a `Navigatable` and
a [TargetPresentation](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/platform/backend/presentation/TargetPresentation.kt)
instances (where to go and what to show in the popup).

To provide navigation targets by a `Symbol`, either:

* implement and register [SymbolNavigationProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/navigation/SymbolNavigationProvider.java) in [com.intellij.symbolNavigation](https://jb.gg/ipe?extensions=com.intellij.symbolNavigation) extension point ;

* or implement [NavigatableSymbol](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/navigation/NavigatableSymbol.java) in the `Symbol`.

## Showing Usages

If there are no navigation targets available, then the IntelliJ Platform starts finding usages of the target symbol
obtained by resolving a [reference](declarations-and-references.html#references)
or from a [declaration](declarations-and-references.html#declarations).

Note:

Existing implementations of the mentioned extension points can be found on the [IntelliJ Platform Explorer](explore-api.html#search-the-intellij-platform-explorer).

