# Debouncing and Batching Updates

[DebouncedUpdates](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/ide-core/src/com/intellij/util/ui/update/DebouncedUpdates) is a utility for batching events over a time window and processing them after a delay.
It is a thin wrapper around a Kotlin channel that provides debouncing, optional deduplication, and testing utilities.
It is the recommended replacement for the obsolete `MergingUpdateQueue`.

Note:

`DebouncedUpdates` is available since 2026.2 and is marked `@ApiStatus.Experimental`.
It can be used from both Kotlin and Java.

Typical use cases include:

* Reacting to VFS or editor events — debounce notifications triggered by `BulkFileListener` or document changes, so that saving multiple files at once triggers only one update

* Search field debouncing — queue a search on every keystroke but process it only after the user pauses typing

* Batching redraw or invalidation requests — collect multiple requests triggered in quick succession and process them together, optionally deduplicating by key

* Deferring heavy work — postpone SDK detection, index rebuilds, or other expensive operations until a quiet moment

## Creating a Queue

Use one of the factory methods to create a queue.
The result must be stored as a field or property, as it is the handle used to queue items and check processing status in tests.

### 

`forScope`

Ties the queue's lifecycle to a `CoroutineScope`.
The queue stops processing when the scope is cancelled.
This is the most common option when the queue's lifetime should match a [service scope](coroutine-scopes.html#use-service-scopes):

Kotlin:

```KOTLIN
@Service(Service.Level.PROJECT)
class MyService(cs: CoroutineScope) {
  private val updateQueue = DebouncedUpdates.forScope<Unit>(cs, "my-update", 500.milliseconds)
    .runLatest { doUpdate() }

  fun scheduleUpdate() = updateQueue.queue(Unit)
}
```

Java:

```JAVA
@Service(Service.Level.PROJECT)
public final class MyService {
  private final UpdateQueue<Unit> updateQueue;

  public MyService(CoroutineScope cs) {
    updateQueue = DebouncedUpdates.<Unit>forScope(cs, "my-update", 500)
      .runLatest(ignored -> doUpdate());
  }

  public void scheduleUpdate() {
    updateQueue.queue(Unit.INSTANCE);
  }
}
```

### 

`forComponent`

Ties the queue's lifecycle to a Swing component.
Processing is automatically paused when the component is not showing and resumed once it becomes visible again:

Kotlin:

```KOTLIN
class MyPanel : JPanel() {
  private val updateQueue = DebouncedUpdates.forComponent<Unit>(this, "my-panel-update", 300.milliseconds)
    .runLatest { refreshContent() }
}
```

Java:

```JAVA
public final class MyPanel extends JPanel {
  private final UpdateQueue<Unit> updateQueue =
    DebouncedUpdates.<Unit>forComponent(this, "my-panel-update", 300)
      .runLatest(ignored -> refreshContent());
}
```

### 

`cancelOnDispose`

Optionally, a queue created with `forScope` or `forComponent` can also be cancelled when a [Disposable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/util/src/com/intellij/openapi/Disposable) is disposed:

Kotlin:

```KOTLIN
DebouncedUpdates.forScope<Unit>(cs, "my-update", 500.milliseconds)
  .cancelOnDispose(disposable)
  .runLatest { doUpdate() }
```

Java:

```JAVA
DebouncedUpdates.<Unit>forScope(cs, "my-update", 500)
  .cancelOnDispose(disposable)
  .runLatest(ignored -> doUpdate());
```

## Execution Modes

### 

`runLatest`

Executes only the most recent item queued during the delay window.
Intermediate items are dropped.
This is the most common mode, suitable for UI refresh, state sync, or search debouncing.

From Java, use `.withContext(...)` to specify the execution dispatcher explicitly:

Kotlin:

```KOTLIN
private val updateQueue = DebouncedUpdates.forScope<Unit>(cs, "my-update", 300.milliseconds)
  .runLatest { withContext(Dispatchers.UI) { repaint() } }
```

Java:

```JAVA
private final UpdateQueue<Unit> updateQueue = DebouncedUpdates.<Unit>forScope(cs, "my-update", 300)
  .withContext(CoroutinesKt.getUI(Dispatchers.INSTANCE))
  .runLatest(ignored -> repaint());
```

### 

`runBatched`

Collects all items queued during the delay window and delivers them as a `List`.
Useful when all events must be processed, not just the last one:

Kotlin:

```KOTLIN
private val redrawQueue = DebouncedUpdates.forScope<RedrawRequest>(
  scope, "redraw", 300.milliseconds
)
  .restartTimerOnAdd(true)
  .runBatched { requests ->
    requests.distinctBy { it.document to it.line }
      .forEach { redraw(it.document, it.line, it.editor) }
  }
```

Java:

```JAVA
private final UpdateQueue<RedrawRequest> redrawQueue =
  DebouncedUpdates.<RedrawRequest>forScope(scope, "redraw", 300)
    .restartTimerOnAdd(true)
    .runBatched(requests -> {
      requests.stream()
        .distinct()
        .forEach(r -> redraw(r.getDocument(), r.getLine(), r.getEditor()));
    });
```

### 

`runBatchedDistinct`

Like `runBatched`, but deduplicates items by equality and delivers them as a `Set`:

Kotlin:

```KOTLIN
private val invalidationQueue = DebouncedUpdates.forScope<VirtualFile>(cs, "invalidate", 2000.milliseconds)
  .runBatchedDistinct { files -> invalidate(files) }
```

Java:

```JAVA
private final UpdateQueue<VirtualFile> invalidationQueue =
  DebouncedUpdates.<VirtualFile>forScope(cs, "invalidate", 2000)
    .runBatchedDistinct(files -> invalidate(files));
```

## Debounce vs. Throttle Mode

By default, the timer starts when the first item is queued (throttle mode — fixed interval regardless of new items).
Setting `.restartTimerOnAdd(true)` switches to debounce mode — the timer resets on each new item,
so processing happens only after a quiet period:

Kotlin:

```KOTLIN
// Debounce: process 500ms after the last keystroke
DebouncedUpdates.forComponent<Unit>(searchField, "search", 500.milliseconds)
  .restartTimerOnAdd(true)
  .runLatest { performSearch() }
```

Java:

```JAVA
// Debounce: process 500ms after the last keystroke
DebouncedUpdates.<Unit>forComponent(searchField, "search", 500)
  .restartTimerOnAdd(true)
  .runLatest(ignored -> performSearch());
```

## Testing

Key testing methods include:

* `queue.waitForAllExecuted(timeout)` — suspends or blocks until all queued items are processed (use off EDT)

* `queue.isAllExecuted` — non-blocking check, suitable with `PlatformTestUtil.waitWithEventsDispatching()`

```KOTLIN
myService.scheduleUpdate()
updateQueue.waitForAllExecuted(5.seconds)
// assert results
```

## 

Migrating from `MergingUpdateQueue`

`DebouncedUpdates` covers the vast majority of `MergingUpdateQueue` use cases:

* Updates with a fixed identity (e.g., `Update.create("key") { ... }`) — use `runLatest`, which keeps only the most recent item

* Updates without a fixed identity collected over time — use `runBatched` or `runBatchedDistinct`, and handle any priority or merging logic in the batch handler

The only cases where `MergingUpdateQueue` should be kept are those requiring manual activation/suspension control via `activate()`/`suspend()`/`resume()`.

| Before (`MergingUpdateQueue`) |After (`DebouncedUpdates`) |
-------------------------------------------------------------
| `new MergingUpdateQueue(name, delay, true, component, this, component, true)` |`DebouncedUpdates.forComponent(component, name, delay)` |
| `new MergingUpdateQueue(name, delay, true, null, this)` |`DebouncedUpdates.forScope(cs, name, delay)` |
| `.setRestartTimerOnAdd(true)` |`.restartTimerOnAdd(true)` |
| `queue.queue(Update.create("key") { doWork() })` |`queue.queue(Unit)` with `runLatest` |
| `queue.queue(Update.create(item) { doWork(item) })` |`queue.queue(item)` with `runBatched` |
| `queue.flush()` in tests |`queue.waitForAllExecuted(5.seconds)` |

See [DebouncedUpdates](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/ide-core/src/com/intellij/util/ui/update/DebouncedUpdates) KDoc for the full API reference.

