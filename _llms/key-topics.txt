# Key Topics

The IntelliJ Platform is extensive and very capable, and its size and scope can initially be very daunting.
This page is intended to list the key topics that a plugin author would be interested in, and provide quick links to the most common extension points.

## Essential Concepts

* [Developing a Plugin](developing-plugins.html).

* [Testing Overview](testing-plugins.html).

* Component model - the IntelliJ Platform is a component-based application and is responsible for creating components and injecting dependencies. Understanding this is necessary for building plugins.

* [Extension Points](plugin-extensions.html) - how to register components with extension points, and how to find out what extension points are available.

* [Virtual Files](virtual-file.html) - all file access should go through the Virtual File System, which abstracts and caches the file system. It means you can work with files that are on the local file system, in a zip file or are old versions from version control.

Tip:

See also [Glossary](glossary.html) for a handy reference of common terms.

## Code Model

The IntelliJ Platform's code model is called the PSI - the [Program Structure Interface](psi.html).
The PSI parses code, builds indexes, and creates a semantic model.

## Common Extension Points

The IntelliJ Platform is extremely extensible, and most features and services can be extended.
Some common extension points are:

* [Action System](action-system.html) - menu and toolbar items

* [Code Inspections](code-inspections.html) - code analysis that looks at the syntax trees and semantic models and highlight issues in the editor.

* [Intentions](code-intentions.html) - context-specific actions that are available in the `Alt+Enter` menu when the text caret is at a particular location.

* [Code Completion](code-completion.html).

