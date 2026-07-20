# Kotlin UI DSL Version 1

<tldr>
UI Guidelines: [Layout](layout.html)
</tldr>

Warning: Kotlin UI SDL Version 1 vs 2

When targeting IntelliJ Platform 2021.3 and later, only use [Kotlin UI DSL Version 2](kotlin-ui-dsl-version-2.html) (currently called just Kotlin UI DSL).

Usage of the version documented on this page is an error since 2025.1.

Please note [breaking changes](api-changes-list.html) can occur for this API between major releases.

Kotlin UI DSL allows creating UI forms with input components bound to state objects.
The forms are built by using a declarative Kotlin syntax.
It shares similarities with [Jetpack Compose](https://developer.android.com/jetpack/compose) for Android and is intended to build UI forms or part of forms for, e.g. dialogs and settings pages.

The Kotlin UI DSL is not intended to build general UIs, like tool windows controls that trigger some actions and do not contain any input components bound to state objects.
For this purpose, use [custom Swing components](user-interface-components.html) from the IntelliJ Platform or the standard ones.

This document covers the Kotlin UI DSL in IntelliJ Platform 2019.2.
A lot of the features described in this document are not available for plugins targeting earlier versions.

The Kotlin UI DSL Version 1 functions are located in the [com.intellij.ui.layout](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-impl/src/com/intellij/ui/layout) package.

## Layout Structure

Tip:

See [Layout](layout.html) topic in UI Guidelines for recommendations on arranging UI controls in dialogs.

Use [panel](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-impl/src/com/intellij/ui/layout/layout.kt) to create UI:

```KOTLIN
panel {
  row {
    // child components
  }
}
```

Rows are created vertically from top to bottom, in the same order as lines of code that call `row`.
Inside one row, you add components from left to right in the same order calls to factory method or `()` appear in each row.
Every component is effectively placed in its own grid cell.

The label for the row can be specified as a parameter for the `row` method:

```KOTLIN
row("Parameters") { ... }
```

Rows can be nested.
Components in a nested row block are considered to be subordinate to the containing row and are indented accordingly.

```KOTLIN
row {
  checkBox(...)
  row {
    textField(...) // indented relatively to the checkbox above
  }
}
```

To put multiple components in the same grid cell, wrap them in a `cell` method:

```KOTLIN
row {
  // These two components will occupy two columns in the grid
  label(...)
  textField(...)

  // These two components will be placed in the same grid cell
  cell {
    label(...)
    textField(...)
  }
}
```

To put a component on the right side of a grid row, use the `right` method:

```KOTLIN
row {
  rememberCheckBox()
  right {
    link("Forgot password")
  }
}
```

Tip:

To visually debug layout, enable UI DSL Debug Mode from [Internal Actions - UI Submenu](internal-ui-sub.html).

## Adding Components

There are two ways to add child components.
The recommended way is to use factory methods `label`, `button`, `radioButton`, `link`, etc.
It allows you to create consistent UI and reuse common patterns.

These methods also support property bindings, allowing you to automatically load the value displayed in the component from a property and to store it back.
The easiest way to do that is to pass a reference to a Kotlin bound property:

```KOTLIN
checkBox("Show tabs in single row", uiSettings::scrollTabLayoutInEditor)
```

Note that the bound property reference syntax also can be used to reference Java fields, but not getter/setter pairs.

Alternatively, many factory methods support specifying a getter/setter pair for cases when a property mapping is more complicated:

```KOTLIN
checkBox(
  "Show file extensions in editor tabs",
  { !uiSettings.hideKnownExtensionInTabs },
  { uiSettings.hideKnownExtensionInTabs = !it })
```

If you want to add a component for which there are no factory methods, you can simply invoke an instance of your component, using the `()` overloaded operator:

```KOTLIN
val customComponent = MyCustomComponent()
panel {
  row { customComponent() }
}
```

## Supported Components

### Labels

Use the `label` method:

```KOTLIN
label("Sample text")
```

### Checkboxes

See examples above.

### Radio Buttons

Radio button groups are created using the `buttonGroup` block.
There are two ways to use it.
If the selected radio button corresponds to a specific value of a single property, pass the property binding to the `buttonGroup` method and the specific values to `radioButton` functions:

```KOTLIN
buttonGroup(mySettings::providerType) {
  row { radioButton("In native Keychain", ProviderType.KEYCHAIN) }
  row { radioButton("In KeePass", ProviderType.KEEPASS) }
}
```

If the selected radio button is controlled by multiple boolean properties, use `buttonGroup` with no binding and specify property bindings for all but one of the radio buttons:

```KOTLIN
buttonGroup {
  row { radioButton("The tab on the left") }
  row { radioButton("The tab on the right", uiSettings::activeRightEditorOnClose) }
  row { radioButton("Most recently opened tab", uiSettings::activeMruEditorOnClose) }
}
```

### Text Fields

Use the `textField` method for a simple text field:

```KOTLIN
row("Username:") {
    textField(settings::userName)
}
```

For entering numbers, use `intTextField`:

```KOTLIN
intTextField(uiSettings::editorTabLimit, columns = 4, range = EDITOR_TABS_RANGE)
```

For password text fields, there is no factory function available, so you need to use `()`:

```KOTLIN
val passwordField = JPasswordField()
val panel = panel {
  // ...
  row { passwordField() }
}
```

To specify the size of a text field, either pass the `columns` parameter as shown in the `intTextField` example above, or use `growPolicy()`:

```KOTLIN
val userField = JTextField(credentials?.userName)
val panel = panel {
  row("Username:") { userField().growPolicy(GrowPolicy.SHORT_TEXT) }
}
```

### Combo Boxes

Use the `comboBox` method with either a bound property, or a getter/setter pair:

```KOTLIN
comboBox(DefaultComboBoxModel<Int>(tabPlacements), uiSettings::editorTabPlacement)

comboBox<PgpKey>(
  pgpListModel,
  { getSelectedPgpKey() ?: pgpListModel.items.firstOrNull() },
  { mySettings.state.pgpKeyId = if (usePgpKey.isSelected) it?.keyId else null })
```

### Spinners

Use the `spinner` method:

```KOTLIN
spinner(retypeOptions::retypeDelay, minValue = 0, maxValue = 5000, step = 50)
```

### Link Label

Use the `link` method:

```KOTLIN
link("Forgot password?") {
  // handle click, e.g. showing dialog
}
```

To open URL in the browser, use `browserLink`:

```KOTLIN
browserLink("Open Homepage", "https://www.jetbrains.com")
```

### Separators

Use the `titledRow` method and put the controls under the separator into the nested block:

```KOTLIN
titledRow("Appearance") {
  row { checkBox(...) }
}
```

### Explanatory Text

Use the `comment` parameter:

```KOTLIN
checkBox(message("checkbox.smart.tab.reuse"),
       uiSettings::reuseNotModifiedTabs,
       comment = message("checkbox.smart.tab.reuse.inline.help"))
```

## Integrating Panels with Property Bindings

A panel returned by the `panel` method is an instance of [DialogPanel](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/ui/DialogPanel.kt).
This base class supports the standard `apply()`, `reset()`, and `isModified()` methods.

### Dialogs

Reference: [DialogWrapper](dialog-wrapper.html)

If you're using a [DialogPanel](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/ui/DialogPanel.kt) as the main panel of a `DialogWrapper`, the `apply()` method will be automatically called when the dialog is closed using OK action.
The other methods are unused in this case.

Use the `focused()` method to specify which control should be focused when the dialog is initialized:

```KOTLIN
return panel {
  row("Target class name:") {
    textField(::className).focused()
  }
}
```

### Configurables

Reference: [Settings Guide](settings-guide.html)

If you're using the UI DSL to implement a [Configurable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/ide-core/src/com/intellij/openapi/options/Configurable.java), use [BoundConfigurable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-api/src/com/intellij/openapi/options/BoundConfigurable.kt) as the base class.
In this case, the `Configurable` methods will be automatically delegated to the panel.

## Enabling and Disabling Controls

Use the `enableIf` method to bind the enabled state of a control to the values entered in other controls.
The parameter of the method is a predicate.

```KOTLIN
checkBox("Show tabs in single row", uiSettings::scrollTabLayoutInEditor)
  .enableIf(myEditorTabPlacement.selectedValueIs(SwingConstants.TOP))
```

The available predicates are:

* `selected` to check the selected state of a checkbox or radio button

* `selectedValueIs` and `selectedValueMatches` to check the selected item in a combo box.

Predicates can be combined with `and` and `or` infix functions:

```KOTLIN
checkBox("Hide tabs if there is no space", uiSettings::hideTabsIfNeed)
  .enableIf(myEditorTabPlacement.selectedValueMatches { it != UISettings.TABS_NONE } and
              myScrollTabLayoutInEditorCheckBox.selected)
```

## Examples

Sample usages in IntelliJ Platform IDEs:

| User Interface |Implementation |
----------------------------------
| `Settings \| Editor \| Reader Mode` |[ReaderModeConfigurable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/lang-impl/src/com/intellij/codeInsight/actions/ReaderModeConfigurable.kt) |
| New Branch dialog in Git ([Manage Git branches](https://www.jetbrains.com/help/idea/manage-branches.html)) |[GitNewBranchDialog](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/plugins/git4idea/backend/src/branch/GitNewBranchDialog.kt) |
| `Settings \| Tools \| Diff & Merge` |[DiffSettingsConfigurable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/diff-impl/src/com/intellij/diff/settings/DiffSettingsConfigurable.kt) |
| `Settings \| Editor \| General \| Editor Tabs` |[EditorTabsConfigurable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/platform-impl/src/com/intellij/application/options/editor/EditorTabsConfigurable.kt) |

Tip:

To understand how a component visible in the IDE is created in code, see the component's [added-at property in the UI Inspector](internal-ui-inspector.html#added-at-property).
Note that it is not limited only to components created with Kotlin UI DSL, but helps to understand the creation of any visible Swing component.

## FAQ

### One Cell Is Minimum, Second One Is Maximum

Set `CCFlags.growX` and `CCFlags.pushX` for some component in the second cell.

## Comparison with Kotlin UI DSL Version 2

Tip:

[Kotlin UI DSL](kotlin-ui-dsl-version-2.html) was formerly known as Kotlin UI DSL Version 2.

Kotlin UI DSL Version 1 was deprecated starting from 2021.3, and its API was gradually reduced.
Since 2025.1 its usage is considered an error.

For simplicity, Kotlin UI DSL Version 2 is now just Kotlin UI DSL.

The [new Kotlin UI DSL](kotlin-ui-dsl-version-2.html) fixes some crucial problems from version 1.
See [Migration to Version 2](#migration-to-version-2) on how to port existing UI DSL code from version 1 to the new version.

The following significant changes were made:

* Reduced API, which allows conceiving API easier and faster. Example: there were five overloaded methods `Cell.checkBox()` in version 1, now only one method remains. Functionality for binding properties is extracted into `Cell<T>.bindSelected()` methods.

* UI DSL became stricter, so the available API in every context is much smaller. Example: code like `row { row {` is forbidden now.

* Structured API is mostly based on interfaces because it's easier to learn API by grouped methods. Only a small part of the API is implemented as extensions.

* KDoc is widely used.

* MIG layout is fully removed from the new UI DSL and replaced by `GridLayout`. Because MIG layout is an external library, it's hard to fix bugs there (e.g., there are layout problems when components become invisible) and extend its functionality. Fixed focus ring cropping problems: when components are placed near the panel border focus ring could be cropped if panel insets do not specify enough space.

* Implemented [Placeholder](kotlin-ui-dsl-version-2.html#placeholder) that allows replacing components at runtime after content is shown.

### Migration to Version 2

The new API is very similar to the old one and covers almost all functionality now, so moving to the new version can be done quickly.

Version 1 is placed in `com.intellij.ui.layout` package.

Version 2 is placed in `com.intellij.ui.dsl.builder` package.

Procedure: Migration Steps

| Version 1 |Version 2 |
------------------------
| `row { row {` |`indent { row {` |
| `row { cell(isFullWidth = true)` |`row {` |
| `fullRow {` |`row {` |
| `titledRow(…) {` |`group(…) {` |
| `hideableRow` |`collapsibleGroup` |
| `cell` used as sub-grid |`row { panel { … } }` |
| `component(…)` or its invocation via `()` |`cell(…)` |
| `enableIf` |`enabledIf` |
| `checkBox(text, bindOptions)` |`checkBox(text).bindSelected(bindOptions)` |
| `radioButton(text, bindOptions)` |`radioButton(text).bindSelected(bindOptions)` |
| `comboBox(…, bindOptions)` |`comboBox(text).bindItem(bindOptions)` |
| `textField(bindOptions, columns)` |`textField().bindText(bindOptions).columns(columns)` |
| `scrollableTextArea(bindOptions, rows, columns)` |`textArea().bindText(bindOptions).rows(rows).columns(columns)` |
| `intTextField(bindOptions, columns, range, step)` |`intTextField(range, step).bindIntText(bindOptions).columns(columns)` |
| `textFieldWithBrowseButton(bindOptions, …)` |`textFieldWithBrowseButton(…).bindText(bindOptions)` |
| `.growPolicy(GrowPolicy.COLUMNS_SHORT)` |`.columns(SHORT_TEXT)` |
| `.growPolicy(GrowPolicy.MEDIUM_TEXT)` |`.columns(COLUMNS_MEDIUM)` |
| `label(…, bold = true)` |`label(…).bold()` |
| `withLeftGap()` |For previous left cell use `Cell.gap(SMALL)` |
| `withLeftGap(gapLeft)` |Please do not use custom gaps if possible |
| `withLargeLeftGap()` |Not needed, this gap is set by default |
| `withValidationOnInput` |`validationOnInput` |
| `withValidationOnApply` |`validationOnApply` |
| `withErrorOnApplyIf` |`errorOnApply` |
| `withBinding` |`bind` |

