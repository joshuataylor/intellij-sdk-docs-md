# Kotlin UI DSL

<tldr>
UI Guidelines: [Layout](layout.html)
</tldr>

Kotlin UI DSL allows creating UI forms with input components bound to state objects.
The forms are built by using a declarative Kotlin syntax and follow the official IntelliJ Platform UI conventions described in the [UI Guidelines](ui-guidelines-welcome.html).
The library is written in [Kotlin](using-kotlin.html) and makes it easy to develop user interfaces like [dialogs](dialog-wrapper.html) and [settings pages](settings.html).

The Kotlin UI DSL is not intended to build general UIs, like [tool windows](tool-window.html) controls that trigger some actions and do not contain any input components bound to state objects.
For this purpose, use [custom Swing components](user-interface-components.html) from the IntelliJ Platform or the standard ones.

The Kotlin UI DSL functions are located in the [com.intellij.ui.dsl.builder](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/dsl/builder) package.

## UI DSL Examples

It is highly recommended to take a look at the UI DSL demo available via `Tools | Internal Actions | UI | Kotlin UI DSL | UI DSL Showcase`.

Note:

Since 2026.2, this action requires the Plugin DevKit plugin to be installed.
In earlier versions, [enabling the internal mode](enabling-internal.html) is required.

It describes some UI DSL basics and contains explanations, tips, a list of all available components, and many examples with links to the source code.

Tip:

All sections below refer to the relevant tab available in this demo:

UI DSL Showcase Tab: Tab Name (Link to sources of demonstration tab)

Tip:

To understand how a component visible in the IDE is created in code, see the component's [added-at property in the UI Inspector](internal-ui-inspector.html#added-at-property).
Note that it is not limited only to components created with Kotlin UI DSL, but helps to understand the creation of any visible Swing component.

## UI DSL Basics

UI DSL Showcase Tab: Basics (Sources: [DemoBasics](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoBasics.kt))

See the following simple example of UI DSL:

```KOTLIN
panel {
  row("Enter value:") {
    textField()
  }
}
```

Building content of any form starts from `panel {` which returns [DialogPanel](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/openapi/ui/DialogPanel.kt) filled with components described inside the panel block.
A panel consists of any number of rows marked with `row` tag created vertically from top to bottom.

Every row consists of cells where the last cell in a row occupies the remaining width.
Inside one row, cells are added from left to right in the same order calls to factory methods or `cell()` appear in each row.
Cells can contain one component or a sub-panel.

If there are unoccupied cells at the end of a row, they are merged into one cell with the last non-empty cell.

## 

`Panel`

[Panel](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/dsl/builder/Panel.kt) is the start interface for building content.
It can consist of several rows and different UI groups.

### 

`Panel.row`

Adds row with the label if present.

### 

`Panel.indent`

UI DSL Showcase Tab: Gaps (Sources: [DemoGaps](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoGaps.kt))

Adds standard left indent:

```KOTLIN
row {
  label("Not indented row")
}
indent {
  row {
    label("Indented row")
  }
}
```

### 

`Panel.separator`

UI DSL Showcase Tab: Groups (Sources: [DemoGroups](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoGroups.kt))

Adds horizontal line separator with an optional title.

### 

`Panel.panel`

Creates a sub-panel that occupies the whole width and uses its own grid inside.

### 

`Panel.rowsRange`

Creates a grouped rows range to perform operations on them like `enabled`, `enabledIf` etc.
All rows use the parent grid.

### 

`Panel.group`

UI DSL Showcase Tab: Groups (Sources: [DemoGroups](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoGroups.kt))

Adds a panel with an independent grid, optional title, and some vertical space above and below the group.

```KOTLIN
group("Title") {
  row("Row:") {
    textField()
  }
}
```

### 

`Panel.groupRowsRange`

Similar to `Panel.group()` method but uses the same grid as the parent.

### 

`Panel.collapsibleGroup`

UI DSL Showcase Tab: Groups (Sources: [DemoGroups](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoGroups.kt))

Adds a collapsible panel with independent grid, title, and some vertical space above and below the group.

```KOTLIN
collapsibleGroup("Title") {
  row("Row:") {
    textField()
  }
}
```

### 

`Panel.buttonsGroup`

UI DSL Showcase Tab: Groups (Sources: [DemoGroups](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoGroups.kt))

Unions `Row.radioButton` in one group.
Must also be used for `Row.checkBox` if these are grouped with a title.

```KOTLIN
var value = true
buttonsGroup("Panel.buttonsGroup:") {
 row {
  radioButton("true", true)
 }
 row {
  radioButton("false", false)
 }
}.bind({ value }, { value = it })
```

### 

`Panel.onApply`/`onReset`/`onIsModified`

Registers callbacks that will be called from `DialogPanel.apply()`/`reset()`/`isModified()` methods.

## 

`Row`

Every row is represented by the [Row](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/dsl/builder/Row.kt) interface.
It contains all available factory methods for creating components (like `button()`, `label()`, `textField()`, etc.) and methods for row configuration.

### 

`Row.layout`

UI DSL Showcase Tab: Row Layout (Sources: [DemoRowLayout](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoRowLayout.kt))

There are three possible layouts:

* `INDEPENDENT`: all cells of the row (including label if present) independent of the parent grid. That means this row has its own grid.

* `LABEL_ALIGNED`: label is aligned with the parent grid, other components independent of the parent grid.

* `PARENT_GRID`: all components, including label (if present), are in the parent grid.

The default value is `LABEL_ALIGNED` when a label is provided for the row, `INDEPENDENT` otherwise.

```KOTLIN
row("Label:") {
  textField()
}
row("Long label:") {
  textField()
}
```

Here both labels are aligned together because rows have `LABEL_ALIGNED` by default.
If an independent layout is needed, then `INDEPENDENT` layout should be used:

```KOTLIN
row("Long label:") {
  textField()
}.layout(RowLayout.INDEPENDENT)
```

### 

`Row.resizableRow`

The row becomes resizable and occupies all vertical free space.
For several resizable rows, extra free space is divided between rows equally.

### 

`Row.rowComment`

UI DSL Showcase Tab: Comments (Sources: [DemoComments](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoComments.kt))

Adds comment after the row with an appropriate color and font.
Visibility and enabled state of the row affects row comment as well.

### 

`Row.cell`

Adds `component`.
Use it only for custom specific components, all standard components like `label()`, `button()`, `checkbox()` etc. are covered by dedicated [Row](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/dsl/builder/Row.kt) factory methods.

For example, there is no method for password field so that the following code can be used:

```KOTLIN
val passwordField = JPasswordField()
row {
  cell(passwordField)
}
```

### 

`Row.scrollCell(component)`

Adds `component` wrapped with [JBScrollPane](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/components/JBScrollPane.java).

### 

`Row.topGap`/`bottomGap`

Adds a gap above/below the current row.
It is visible together with the row.
By default, `NONE` is used.
Between unrelated settings, `SMALL` can be used.
`MEDIUM` is used between groups and usually set automatically by `group()` method and similar ones.

### 

`Row.visible`/`enabled`

UI DSL Showcase Tab: Enabled/Visible (Sources: [DemoAvailability](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoAvailability.kt))

Sets visibility/enabled state of the row, including row comment (see `Row.rowComment`) and all children recursively.
The row is invisible/disabled if there is an invisible/disabled parent.

### 

`Row.visibleIf`/`enabledIf`

UI DSL Showcase Tab: Enabled/Visible (Sources: [DemoAvailability](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoAvailability.kt))

Binds row visibility/enabled state to the provided predicate.
Below is an example of a checkbox whose enabled state depends on another checkbox:

```KOTLIN
lateinit var checkBox: Cell<JBCheckBox>
row {
  checkBox = checkBox("Check to enable option")
}
row {
  checkBox("Option 1")
}.enabledIf(checkBox.selected)
```

### 

`Row.panel`

UI DSL Showcase Tab: Groups (Sources: [DemoGroups](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoGroups.kt))

Creates a sub-panel inside the cell of the row.
The panel contains its own set of rows and cells.
For example, it is possible to create several columns by creating a row with several panels inside.

## 

`Cell`

Every component in the UI DSL builder is wrapped into [Cell](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/dsl/builder/Cell.kt) class.
Standard components should not be created directly but with factory methods from [Row](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/platform-api/src/com/intellij/ui/dsl/builder/Row.kt) class like `checkBox()`, `button()` and others because of additional functionality, e.g., `textField()` is configured with the column's width, radio buttons are placed into radio buttons groups.

### 

`Cell.component`

`JComponent` that occupies the cell.

### 

`Cell.horizontalAlign`/`verticalAlign`

Tip:

Deprecated in 2022.3, use [Cell.align](#cell-align) instead.

Sets horizontal/vertical alignment of content inside the cell.

```KOTLIN
row("Row:") {
  textField()
    .horizontalAlign(HorizontalAlign.FILL)
}
```

### 

`Cell.align`

Updates horizontal and/or vertical alignment of the component inside the cell.
Default alignment is `AlignX.LEFT` and `AlignY.CENTER`.

To stretch the content on whole cell, use `AlignX.FILL`/`AlignY.FILL`/`Align.FILL`.
For setting both horizontal and vertical alignment, use `Align` constants or overloaded plug operator
like `align(AlignX.LEFT + AlignY.TOP)`.

```KOTLIN
row("Row:") {
  textField()
    .align(AlignX.FILL)
}
```

### 

`Cell.resizableColumn`

UI DSL Showcase Tab: Tips (Sources: [DemoExamples](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoExamples.kt))

Marks a column of the cell as resizable: the column occupies all extra horizontal space in the panel and changes size together with the panel.
It's possible to have several resizable columns, which means extra space is shared between them.
There is no need to set resizable for cells in different rows, but in the same column: it has no additional effect.
Note that the size and placement of components in columns are managed by [Cell.align](#cell-align) ([Cell.horizontalAlign/verticalAlign](#cell-horizontalVerticalAlign) for pre-2022.3).

```KOTLIN
row("Row") {
  textField()
    .resizableColumn()
  link("Config...") {}
}
```

### 

`Cell.gap`

UI DSL Showcase Tab: Gaps (Sources: [DemoGaps](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoGaps.kt))

Separates the next cell in the current row with `rightGap`.
`RightGap.SMALL` gap is set after row label automatically by `Panel.row()` methods.

Below are some cases where `RightGap.SMALL` should be used:

```KOTLIN
row {
  val checkBox = checkBox("Use mail:")
                  .gap(RightGap.SMALL)
  textField()
}
row("Width:") {
  textField()
    .gap(RightGap.SMALL)
  label("pixels")
}
```

### 

`Cell.visible`/`enabled`

UI DSL Showcase Tab: Enabled/Visible (Sources: [DemoAvailability](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoAvailability.kt))

Sets visibility/enabled state of the cell and all children recursively.
The cell is invisible/disabled if there is an invisible/disabled parent.

### 

`Cell.visibleIf`/`enabledIf`

UI DSL Showcase Tab: Enabled/Visible (Sources: [DemoAvailability](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoAvailability.kt))

Binds cell visibility/enabled state to the provided predicate.

```KOTLIN
row {
  val mailCheckBox = checkBox("Use mail:")
                      .gap(RightGap.SMALL)
  textField()
    .enabledIf(mailCheckBox.selected)
}
```

### 

`Cell.comment`

UI DSL Showcase Tab: Comments (Sources: [DemoComments](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoComments.kt))

Adds comment under the cell aligned by left edge with an appropriate color and font size (macOS uses smaller font).
Comment can contain HTML tags except `<html>`, which is added automatically.
The comment occupies the available width before the following comment (if present) or the whole remaining width.
Visibility and enabled state of the cell affect comment as well.

```KOTLIN
row("Label:") {
  textField()
    .comment("Comment for textField")
}
```

### 

`Cell.label`

UI DSL Showcase Tab: Components Labels (Sources: [DemoComponentLabels](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoComponentLabels.kt))

Adds label at the specified position.
`LabelPosition.TOP` labels occupy available width before the next top label (if present) or the whole remaining width.
Visibility and enabled state of the cell affect the label as well.

```KOTLIN
row {
  textField()
    .label("Cell label on top:", LabelPosition.TOP)
}
```

### 

`Cell.onApply`/`onReset`/`onIsModified`

Registers callbacks that will be called for the component from `DialogPanel.apply()`/`reset()`/`isModified()` methods.

## Placeholder

Used as a reserved cell in the layout.
It can be created by `Row.placeholder()` method and populated by content later via component property or reset to `null`.

## Bindings

It is possible to bind component values to properties with the following methods.

### 

`Cell.validationRequestor`

Binds `component` value changing to property.
The property is updated when the value is changed and is not related to `DialogPanel.apply()`.
The method is rarely used directly.
There are many extensions for specific components described in [Cell.bind](#cellbind).

Tip:

In versions before 2023.3, use `Cell.graphProperty`.

### 

`Cell.bind`

UI DSL Showcase Tab: Binding (Sources: [DemoBinding](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/plugins/devkit/intellij.devkit.uiDsl/src/showcase/DemoBinding.kt))

Binds `component` value provided by `componentGet` and `componentSet` methods to the specified binding property.
The property is applied only when `DialogPanel.apply()` is invoked.
Methods `DialogPanel.isModified()` and `DialogPanel.reset()` are also supported automatically for bound properties.

The `bind()` method is rarely used directly.
There are many extensions for specific components, see the following example:

```KOTLIN
row {
  checkBox("Checkbox")
    .bindSelected(model::checkbox)
}
row("textField:") {
  textField()
    .bindText(model::textField)
}
row("intTextField(0..100):") {
  intTextField()
    .bindIntText(model::intTextField)
}
row("comboBox:") {
  comboBox(Color.values())
    .bindItem(model::comboBoxColor)
}
row("slider:") {
  slider(0, 100, 10, 50)
    .bindValue(model::slider)
}
row("spinner:") {
  spinner(0..100)
    .bindIntValue(model::spinner)
}
buttonsGroup(title = "radioButton:") {
 for (value in Color.values()) {
  row {
   radioButton(value.name, value)
  }
 }
}.bind(model::radioButtonColor)
```

