# Internal Actions - LaF Defaults

The LaF Defaults window provides a key-value pair lookup for UI Controls.
It also allows interactive prototyping of UI Control color changes.

LaF stands for Look and Feel, see [Swing Tutorial](https://docs.oracle.com/javase/tutorial/uiswing/lookandfeel/index.html) for more details.

Tip:

If the menu item `Tools | Internal Actions` is not available in the IDE, then the first step is [Enabling Internal Mode](enabling-internal.html).

## Opening LaF Defaults

The LaF Defaults window is opened by selecting the menu item `Tools | Internal Actions | UI | LaF Defaults`.

It has two columns representing key-value pairs for UI Controls:

* The Name column contains the UI Control `key` for each IntelliJ Platform UI element available at runtime.

* The Value column contains the UI Control color `value` for each IntelliJ Platform UI element.

## Using the LaF Panel

### Finding UI Controls

The LaF Defaults window is used interactively by entering a UI element type - e.g. `Panel` - in the Filter text box at the top.
LaF Defaults shows the list of UI Control names matching the filter.

Enable Colors only to show only entries with color value.

Clicking on one of the names narrows the information to show only the key-value pair for that UI element:

![LaF Lookup](images/internal_lafd_win.png)

### Prototyping the Color of UI Controls

The color of UI Controls can be changed (in real time) by clicking in the Value column next to a Name (`key`) of interest.
The Choose Color window is displayed.
Color changes can be specified as RGB, HSB, hexadecimal, or using the graphical color picker.
Pressing the Choose button changes the UI Control color immediately.

UI Control colors can be reset using the Choose Color window, or by resetting the [theme](https://www.jetbrains.com/help/idea/settings-appearance.html).

