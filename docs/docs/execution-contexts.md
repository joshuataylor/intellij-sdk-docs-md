# Execution Contexts

The IntelliJ Platform provides APIs that allow tracking the progress of background processes and canceling their
execution when they are canceled by a user, or they become obsolete due to some changes in the data model.

Available execution contexts differ depending on the IntelliJ Platform version.
For the details, select the required tab below.

2024.2+:

Background processes can be executed in two contexts:

* [Coroutine Execution Context](#coroutine-execution-context) — available since 2024.2

* [Progress Indicator](#progress-indicator) — obsolete since 2024.1

Currently, the Progress Indicator context is the most widely used approach in the IntelliJ Platform.
As the platform's execution model moves towards [coroutines](launching-coroutines.html), this approach
can be considered obsolete.

Starting with 2024.2, it is recommended to execute new code in the [Coroutine Execution Context](#coroutine-execution-context).

The following sections explain the contexts and provide information about process cancellation, progress
tracking, and switching between contexts.

## Coroutine Execution Context

Tip:

Suspending and Blocking contexts available in 2024.1 have been unified into the Coroutine Execution Context.
See the [Reconsider blockingContext](https://youtrack.jetbrains.com/issue/IJPL-445/Reconsider-blockingContext) issue for more details.

Code [executed in Kotlin coroutines](launching-coroutines.html) is executed in the Coroutine Execution Context.
Since 2024.2, coroutines are recommended for executing background tasks to maximize CPU utilization.
Note that executing code in coroutines is possible only with [Kotlin](using-kotlin.html).

While code executed in the Coroutine Execution Context should use suspending functions,
sometimes it is required to call non-suspending/blocking APIs that use methods such as
`ProgressManager.checkCanceled()` or `ModalityState.defaultModalityState()`.
Since 2024.2, these methods work as expected without the need to switch to the Blocking Context
explicitly with [blockingContext()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt) (in 2024.2+, it is effectively a no-operation function).

Tip:

Inspection
Plugin DevKit | Code | Forbidden in suspend context method usage
reports calling blocking code from Suspending Context.
While this is not an error, it is recommended to use suspending counterparts if they exist.

2024.1:

Background processes can be executed in three contexts:

* [Suspending Context (Coroutines)](#suspending-context-coroutines) — available since 2024.1

* [Blocking Context](#blocking-context)

* [Progress Indicator](#progress-indicator) — obsolete since 2024.1

Currently, the Progress Indicator context is the most widely used approach in the IntelliJ Platform.
As the platform's execution model moves towards [coroutines](launching-coroutines.html), this approach
can be considered obsolete.

Starting with 2024.1, it is recommended to execute new code in the
[Suspending Context](#suspending-context-coroutines).

The following sections explain the contexts and provide information about process cancellation, progress
tracking, and switching between contexts.

## Suspending Context (Coroutines)

Code [executed in Kotlin coroutines](launching-coroutines.html) is executed in the Suspending Context.
Since 2024.1, this context is recommended for executing background tasks to maximize CPU utilization.
Note that executing code in coroutines is possible only with [Kotlin](using-kotlin.html).

In the Suspending Context, methods such as `ProgressManager.checkCanceled()` or `ModalityState.defaultModalityState()`
won't have any effect.
Therefore, if their behavior is required, [switch to a blocking
context](#switching-between-contexts).

Tip:

Inspection
Plugin DevKit | Code | Forbidden in suspend context method usage
reports calling blocking code from the Suspending Context.

## Blocking Context

Executing tasks in the Blocking Context means executing them on a thread without access to the [coroutine context](#suspending-context-coroutines) (basically, in non-suspending functions)
and not under the [Progress Indicator](#progress-indicator).
Such tasks can still be canceled, but they can't report progress.

Plugins should not execute new code in the Blocking Context.
Always prefer executing tasks in the [Suspending Context](#suspending-context-coroutines)
or under the [Progress Indicator](#progress-indicator) if a plugin cannot use Kotlin.

Tip:

Functions which schedule execution via
[Application.executeOnPooledThread()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/application/Application.java)
and similar methods, and which rely on
[ProgressManager.checkCanceled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressManager.java) should be annotated with
[@RequiresBlockingContext](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/util/concurrency/annotations/RequiresBlockingContext.kt) to inform clients about the required switch to
the Blocking Context.

Inspection
Plugin DevKit | Code | Calling method should be annotated with @RequiresBlockingContext
reports missing annotations.

## Progress Indicator

Code executed via the Progress API
([ProgressManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressManager.java),
[ProgressIndicator](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressIndicator.java),
etc.)
is executed in the Progress Indicator execution context.
See the [Progress API](background-processes.html#progress-api) section for details.

Tip: Obsolete approach since 2024.1

Executing code under the Progress Indicator is obsolete since 2024.1.
It is advised to use Kotlin coroutines in new code.

Please note that obsolete status does not mean deprecation.
Executing code using the Progress API is still allowed, but coroutines are recommended as a more
performant solution.

## Execution Contexts APIs

### Cancellation Check

The following table presents APIs to use for checking whether a task was canceled in different execution
contexts.

Tip:

See [Background Processes: Cancellation](background-processes.html#cancellation) for
general cancellation mechanism explanation.

2024.2+:

| Coroutine Execution Context |                                   * [checkCanceled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt)    * [ProgressManager.checkCanceled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressManager.java)                                |
| Progress Indicator |                                       * [ProgressIndicator.checkCanceled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressIndicator.java)    * [ProgressManager.checkCanceled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressManager.java)                                    |

2024.1:

| Suspending Context |                                   * [ensureActive()](https://kotlinlang.org/api/kotlinx.coroutines/kotlinx-coroutines-core/kotlinx.coroutines/ensure-active.html) from Kotlin coroutine's API                                    Warning:                                       Note that                                     [ProgressManager.checkCanceled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressManager.java)                                     does not work in the Suspending Context.                                     To enable it,                                     [switch to blockingContext()](#switching-between-contexts),                                     if it is not possible to change the code.                                                                 |
| Blocking Context |                                   * [ProgressManager.checkCanceled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressManager.java)                                |
| Progress Indicator |                                       * [ProgressIndicator.checkCanceled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressIndicator.java)    * [ProgressManager.checkCanceled()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressManager.java)                                    |

### Progress Reporting

The following table presents the possibilities and APIs to use for reporting progress in different
execution contexts.

2024.2+:

| Coroutine Execution Context |                                       * [ProgressStep](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/progress/src/impl/ProgressStep.kt) - a step-based progress reporting (see its KDoc for details)    * [RawProgressReporter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/progress/src/RawProgressReporter.kt) - a raw text, details, and fraction reporting (invoked via [reportRawProgress()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/progress/src/steps.kt))                                                                                Any [report*Progress()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/progress/src/steps.kt)                                         function must be used inside `withBackgroundProgress()`, `withModalProgress()`,                                         or `runWithModalProgressBlocking()` from [tasks.kt](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/progress/shared/src/tasks.kt).                                         Otherwise, if there is no reporter in the context, using `report*Progress()` will                                         have no effect.                                         Example:                                                                             ```KOTLIN withBackgroundProgress(...) { // or other     // ...     reportProgress { reporter -> // or another report*Progress         // do tasks and report progress     }     // ... } ```                                    |
| Progress Indicator |                                     [ProgressIndicator's](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressIndicator.java)                                     or [ProgressManager's](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressManager.java)                                     methods                                     See [Background Processes: Tracking                                         Progress](background-processes.html#tracking-progress) for details.                                    |

2024.1:

| Suspending Context |                                       * [ProgressStep](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/progress/src/impl/ProgressStep.kt) - a step-based progress reporting (see its KDoc for details)    * [RawProgressReporter](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/progress/src/RawProgressReporter.kt) - a raw text, details, and fraction reporting (invoked via [reportRawProgress()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/progress/src/steps.kt))                                                                                Any [report*Progress()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/progress/src/steps.kt)                                         function must be used inside `withBackgroundProgress()`, `withModalProgress()`,                                         or `runWithModalProgressBlocking()` from [tasks.kt](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/progress/shared/src/tasks.kt).                                         Otherwise, if there is no reporter in the context, using `report*Progress()` will                                         have no effect.                                         Example:                                                                             ```KOTLIN withBackgroundProgress(...) { // or other     // ...     reportProgress { reporter -> // or another report*Progress         // do tasks and report progress     }     // ... } ```                                    |
| Blocking Context |                                 unavailable                              |
| Progress Indicator |                                     [ProgressIndicator's](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressIndicator.java)                                     or [ProgressManager's](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/ProgressManager.java)                                     methods                                     See [Background Processes: Tracking                                         Progress](background-processes.html#tracking-progress) for details.                                    |

### Switching Between Contexts

The following table presents the possibilities and APIs to use for switching between different execution
contexts.

2024.2+:

|  |To Coroutine Execution Context |To Progress Indicator |
-----------------------------------------------------------
| From Coroutine Execution Context |- |[coroutineToIndicator()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt) 1 |
| From Progress Indicator |[runBlockingCancellable()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt) |- |
|                                  1                                 `coroutineToIndicator()`                                     was originally internal and created to aid                                     platform migration.                                     It is not recommended to switch from the Coroutine Execution Context to the Progress Indicator.                                     Use it only if there is no other option.                              |

2024.1:

|  |To Suspending Context |To Blocking Context |To Progress Indicator |
-----------------------------------------------------------------------
| From Suspending Context |- |`blockingContext()` 1 |unavailable 3 |
| From Blocking Context |`runBlockingCancellable()` 2 |- |unavailable 4 |
| From Progress Indicator |`runBlockingCancellable()` 2 |unavailable |- |
|                                  1                                 [blockingContext()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt)                                     enables `ProgressManager.checkCanceled()`, forwards modality state, etc.                                     It has an opposite behavior to `runBlockingCancellable()`.                                     Since 2024.2, it is a no-operation function, as the Blocking Context was unified                                     with the Suspending Context into the Coroutine Execution Context.                                                                    2                                 [runBlockingCancellable()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt)                                     has an opposite behavior to `blockingContext()`                                                                    3                                 [coroutineToIndicator()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt)                                     is an internal API to aid platform migration                                                                    4                                 [blockingContextToIndicator()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/core-api/src/com/intellij/openapi/progress/coroutines.kt)                                     is an internal API to aid platform migration                              |

It is only possible to:

* switch from the Blocking Context or Progress Indicator to the Suspending Context

* switch from the Suspending Context to the Blocking Context

The lack of an API for switching from Suspending and Blocking contexts to the Progress Indicator is
intentional.
Cancellable and trackable tasks should be run in coroutines as the Progress Indicator is obsolete since
2024.1.

Note: Something missing?

If a topic is not covered in the above sections,
let us know via the Feedback widget displayed on the right,
or [other channels](getting-help.html#problems-with-the-guide).

Be specific about the topics and reasons for adding them and leave your email in case we need
more details. Thanks for your feedback!

