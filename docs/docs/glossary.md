# Glossary

See also [Oracle's Java Technology Glossary](https://www.oracle.com/java/technologies/glossary.html).

## A

Abstract Syntax Tree (AST)
: The [Abstract Syntax Tree](implementing-parser-and-psi.html) represents the structure of source input files.

→ [Program Structure Interface](#program-structure-interface)

Annotator
: Provides [semantic highlighting](syntax-highlighting-and-error-highlighting.html) based on underlying → [Program Structure Interface](#program-structure-interface) elements.

→ [Inspection](#inspection)

## B

Blocking Context
: Executing in the [Blocking Context](execution-contexts.html#blocking-context) means executing tasks on a thread without access to a coroutine context.

→ [Suspending Context](#suspending-context)

→ [Coroutine Execution Context](#coroutine-execution-context)

→ [Coroutine Scope](#coroutine-scope)

→ [Coroutine](#coroutine)

## C

`CancellationException` (CE)
: `java.util.concurrent.CancellationException`, `kotlin.coroutines.cancellation.CancellationException` (typealias in stdlib), `kotlinx.coroutines.CancellationException` (typealias in kotlinx-coroutines)

→ [ProcessCanceledException](#processcanceledexception)

Code Insight
: Code insight is a common name used for auto-completion, inspections, intention actions, type inference, and other features related to the code analysis.

Coroutine
: A [Kotlin coroutines](kotlin-coroutines.html) execution unit allowing for handling concurrency and asynchronous tasks efficiently with a sequential/imperative code style.

Coroutine Dispatcher
: Part of the coroutine context.
Determines a thread or a thread pool the corresponding coroutine is executed on.
See [Coroutine Dispatchers](coroutine-dispatchers.html) for more details.

→ [Coroutine](#coroutine)

Coroutine Execution Context
: Executing in the [Coroutine Execution Context](execution-contexts.html#blocking-context) means executing code (suspending or non-suspending/blocking) from a coroutine.

Coroutine Scope
: [Coroutine scopes](coroutine-scopes.html) define the lifetime of coroutines and ensure proper handling of coroutine cancellations and structured concurrency.

→ [Coroutine](#coroutine)

## D

Document Object Model (DOM)
: [XML DOM API](xml-dom-api.html) abstracts working with XML files based on a custom semantic model.

## E

Event Dispatch Thread (EDT)
: The [Event Dispatch Thread](https://docs.oracle.com/javase/tutorial/uiswing/concurrency/dispatch.html) handles all Swing events. See also [Threading Model](threading-model.html) and [EDT Dispatcher](coroutine-dispatchers.html#edt-dispatcher).

Extension Point (EP)
: Most functionality is provided by [Using Extension Points](plugin-extensions.html) provided by the platform or plugins. Plugins can also [define their own](plugin-extension-points.html) to allow extensibility.

External System (ES)
: [External System Integration](external-system-integration.html) allows integrating external project management systems.

## F

Feature Usage Statistics (FUS)
: JetBrains internal API to track feature usage in the IDE.

File Based Index (FBI)
: [File Based Index](file-based-indexes.html) allows storing key-value information based on the project's files.

## G

Gradle Build Script
: A configuration file written in Kotlin (`build.gradle.kts`) or Groovy (`build.gradle`) that describes the build process and dependencies of a plugin.

## I

Inspection
: Supports configurable [semantic highlighting](code-inspections-and-intentions.html).

→ [Annotator](#annotator)

Intention
: Provides an [automated fix](code-inspections-and-intentions.html) for commonly encountered code problems.

## L

Language Server Protocol (LSP)
: Communication standard between development tools and Language Servers, see [Language Server Protocol (LSP)](language-server-protocol.html).

Local History (LVCS)
: A builtin [→ Version Control System](#version-control-system) tracking all changes in the project [locally](https://www.jetbrains.com/help/idea/local-history.html).

Look and Feel (LaF) {#}
: Defines the visual appearance and behavior of the user interface; see [Swing Tutorial](https://docs.oracle.com/javase/tutorial/uiswing/lookandfeel/index.html).

## J

JetBrains Project System (JPS)
: Represents the project model in [External Build](external-builder-api.html#accessing-project-model-and-configuration-from-external-build) process.

JetBrains Runtime (JBR)
: The [JetBrains Runtime](ide-development-instance.html#using-a-jetbrains-runtime-for-the-development-instance) is the default bundled runtime for all IntelliJ Platform-based IDEs by JetBrains.

## N

Non-Blocking Read Action (NBRA)
: A → [Read Action](#read-action) that is canceled by a → [Write Action](#write-action). See also [Non-Blocking Read Actions](threading-model.html#non-blocking-read-actions).

## P

`ProcessCanceledException` (PCE)
: [ProcessCanceledException](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/util/base/multiplatform/src/com/intellij/openapi/progress/ProcessCanceledException.kt) An exception indicating that the currently running operation was terminated and should finish as soon as possible.

→ [CancellationException](#cancellationexception)

Program Structure Interface (PSI)
: The [Program Structure Interface](psi.html) represents a syntactic and semantic code model of the source input files.

→ [Abstract Syntax Tree](#abstract-syntax-tree)

→ [Stubs](#stubs)

## R

Read Action (RA)
: Allows accessing code-related data structures for reading purposes. See also [Threading Model](threading-model.html).

→ [Non-Blocking Read Action](#non-blocking-read-action)

→ [Write Action](#write-action)

Run Configuration (RC)
: A [Run Configuration](run-configurations.html) allows running external processes from within the IDE.

## S

Structural Search and Replace (SSR)
: Allows searching and replacing code by defining the structure of the searched code fragments, see [Structural Search and Replace Inspections](plugin-alternatives.html#structural-search-and-replace-inspections).

Stubs
: A subset of a → [Program Structure Interface](#program-structure-interface) tree in a binary serialized compact format, see [Stub Indexes](stub-indexes.html).

Suspending Context
: Executing in the [Suspending Context](execution-contexts.html#suspending-context-coroutines) means executing tasks in Kotlin coroutines.

→ [Blocking Context](#blocking-context)

→ [Coroutine Execution Context](#coroutine-execution-context)

→ [Coroutine](#coroutine)

Symbol
: A semantic element in some model, e.g., language or framework model, see [Symbols](symbols.html).

## U

Unified Abstract Syntax Tree (UAST)
: An [abstraction layer](uast.html) on the → [Program Structure Interface](#program-structure-interface) of different JVM languages.

## V

Version Control System (VCS)
: The API for [Version Control System](vcs-integration-for-plugins.html) allows accessing builtin as well as adding custom implementations.

Virtual File (VF)
: A [Virtual File](virtual-file.html) represents a file in a → [Virtual File System](#virtual-file-system).

Virtual File System (VFS)
: A [Virtual File System](virtual-file-system.html) provides a unified API for working with files represented as → [Virtual File](#virtual-file).

## W

Write Action (WA)
: Allows accessing code-related data structures for writing purposes. See also [Threading Model](threading-model.html).

→ [Read Action](#read-action)

Write Allowing Read Action (WARA)
: A coroutine → [Read Action](#read-action) that is canceled by an incoming → [Write Action](#write-action).
See [Coroutine Read Actions API](coroutine-read-actions.html#coroutine-read-actions-api) for details.

→ [Suspending Context](#suspending-context)

→ [Coroutine](#coroutine)

Write Blocking Read Action (WBRA)
: A coroutine → [Read Action](#read-action) that blocks incoming → [Write Action](#write-action).
See [Coroutine Read Actions API](coroutine-read-actions.html#coroutine-read-actions-api) for details.

→ [Suspending Context](#suspending-context)

→ [Coroutine](#coroutine)

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

