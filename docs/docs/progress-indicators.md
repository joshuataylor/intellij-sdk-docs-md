# Progress Indicators

<tldr>
Implementation: Progress tracking in [Progress API](background-processes.html#tracking-progress) and [Kotlin Coroutines](execution-contexts.html#progress-reporting)
</tldr>

Progress indicators inform users that an operation is in progress and the application is not frozen.

## When to use

Show for operations that last more than 1 second. Do not show for shorter operations.
Remove the indicator after an operation is completed.

## Types

Two types of progress indicators are used in the IntelliJ Platform: a progress bar and a loader.

![01](images/01.png)
### Loader

Use a [loader](loader.html) for local or inline operations:

* Loading content in fields, dropdowns, comboboxes, tree or list nodes

* Loading content in an [empty state](empty-state.html)

* Showing an action in process, like applying a filter or refreshing data

### Progress Bar

Use a [progress bar](progress-bar.html) for background or system operations:

* Updating content in the main window, tool windows or editors

* Showing long-running tasks that need visual tracking

