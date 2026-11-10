# Persisting State of Components

The IntelliJ Platform provides an API that allows components or services to persist their state between restarts of the IDE.
The API allows for persisting simple key-value entries and complex state classes.

Note: Split Mode

[Split plugins](split-mode-and-remote-development.html) may need explicit frontend and backend synchronization metadata in addition to a regular `PersistentStateComponent` implementation.
See [Persistent State Component in Split Mode](persistent-state-in-split-mode.html).

Warning:

For persisting sensitive data like passwords, see [Persisting Sensitive Data](persisting-sensitive-data.html).

## 

Using `PersistentStateComponent`

[PersistentStateComponent](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/components/PersistentStateComponent.java) allows for persisting state classes and gives the most flexibility for defining the values to be persisted, their format, and storage location.

To use it:

* mark a [service](plugin-services.html) (project or application-level service for storing project or application data, respectively) as implementing `PersistentStateComponent`

* define the state class

* specify the [storage location](#defining-the-storage-location) using [@State](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/components/State.java)

Note that instances of extensions can't persist their state by implementing `PersistentStateComponent`.
If an extension needs to have a persistent state, define a separate service responsible for managing that state.

### 

Implementing the `PersistentStateComponent` Interface

Kotlin:

The recommended approach to implementing a persistent state component in Kotlin is to extend one of the base classes:

1. [SimplePersistentStateComponent](#SimplePersistentStateComponent)

2. [SerializablePersistentStateComponent](#SerializablePersistentStateComponent) (available and recommended since 2022.2)

Both classes implement [PersistentStateComponentWithModificationTracker](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/components/PersistentStateComponentWithModificationTracker.java) and track modifications count internally (in most cases; see details below).
The `getStateModificationCount()` method helps avoid calling `PersistentStateComponent.getState()` to check whether the state is changed and must be saved.

#### SimplePersistentStateComponent

[SimplePersistentStateComponent](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/components/SimplePersistentStateComponent.kt) is parameterized by a subclass of [BaseState](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/components/BaseState.kt).
`BaseState` provides a set of handy [property delegates](https://kotlinlang.org/docs/delegated-properties.html), which make it easy to create properties with default values.

Delegates track simple property modifications internally.
Note that incremental collection modification (adding, removing, or modifying collection objects) may require manual `BaseState.incrementModificationCount()` invocation (see its Javadoc for details).

Example:

```KOTLIN
@Service
@State(...)
class MySettings : SimplePersistentStateComponent<MySettings.State>(State()) {
  class State : BaseState() {
    var value by string("default value")
  }
}
```

#### SerializablePersistentStateComponent

[SerializablePersistentStateComponent](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/components/SerializablePersistentStateComponent.kt) is parameterized with an immutable state data class.

State properties are exposed for reading and modification via persistent state component class' properties.
The state properties are modified by copying the state and overwriting a modified value within `SerializablePersistentStateComponent.updateState()`, which ensures atomic modification and thread safety.

The copy-on-write approach allows for full internal modification tracking.

Example:

```KOTLIN
@Service
@State(...)
class MySettings : SerializablePersistentStateComponent<MySettings.State>(State()) {

  var stringValue: String
    get() = state.stringValue
    set(value) {
      updateState {
        it.copy(stringValue = value)
      }
    }

  data class State (
    @JvmField val stringValue: String = "default value"
  )
}
```

Java:

The implementation of `PersistentStateComponent` must be parameterized with the type of state class.
The state class can either be a separate class or the class implementing `PersistentStateComponent`.

#### Persistent Component with Separate State Class

In this case, the state class instance is typically stored as a field in the `PersistentStateComponent` implementation.
When the state is loaded from the storage, it is assigned to the state field (see `loadState()`):

```JAVA
@Service
@State(...)
class MySettings implements PersistentStateComponent<MySettings.State> {

  static class State {
    public String value;
  }

  private State myState = new State();

  @Override
  public State getState() {
    return myState;
  }

  @Override
  public void loadState(State state) {
    myState = state;
  }
}
```

Using a separate state class is the recommended approach.

#### Persistent Component Being a State Class

In this case, `getState()` returns the component itself, and `loadState()` copies properties of the state loaded from storage to the component instance:

```JAVA
@Service
@State(...)
class MySettings implements PersistentStateComponent<MySettings> {

  public String stateValue;

  @Override
  public MySettings getState() {
    return this;
  }

  @Override
  public void loadState(MySettings state) {
    XmlSerializerUtil.copyBean(state, this);
  }
}
```

### Implementing the State Class

The implementation of `PersistentStateComponent` works by serializing public fields, [annotated](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations) private fields (see also [Customizing the XML format of persisted values](#customizing-the-xml-format-of-persisted-values)), and bean properties into an XML format.

To exclude a public field or bean property from serialization, annotate the field or getter with [@Transient](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations/Transient.java).

Note that the state class must have a default constructor.
It should return the component's default state: the one used if there is nothing persisted in the XML files yet.

State class should have an `equals()` method, but state objects are compared by fields if it is not implemented.

The following types of values can be persisted:

* numbers (both primitive types, such as `int`, and boxed types, such as `Integer`)

* booleans

* strings

* collections

* maps

* enums

For other types, extend [Converter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/api.kt).
See the example below.

#### Converter Example

```JAVA
class LocalDateTimeConverter extends Converter<LocalDateTime> {
  public LocalDateTime fromString(@NotNull String value) {
    long epochMilli = Long.parseLong(value);
    ZoneId zoneId = ZoneId.systemDefault();
    return Instant.ofEpochMilli(epochMilli)
        .atZone(zoneId)
        .toLocalDateTime();
  }

  public String toString(LocalDateTime value) {
    ZoneId zoneId = ZoneId.systemDefault();
    long toEpochMilli = value.atZone(zoneId)
        .toInstant()
        .toEpochMilli();
    return Long.toString(toEpochMilli);
  }
}
```

Define the converter above in [@OptionTag](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations/OptionTag.java) or [@Attribute](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations/Attribute.java):

```JAVA
class State {
  @OptionTag(converter = LocalDateTimeConverter.class)
  public LocalDateTime dateTime;
}
```

### Defining the Storage Location

To specify where precisely the persisted values are stored, add the `@State` annotation to the `PersistentStateComponent` implementation.

It has the following fields:

* `name` (required) – specifies the name of the state (name of the root tag in XML).

* `storages` – one or more of [@Storage](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/components/Storage.java) annotations to specify the storage locations. Optional for project-level values – a standard project file is used in this case.

* `reloadable` (optional) – if set to false, a full project (or application) reload is required when the XML file is changed externally, and the state has changed.

The simplest ways of specifying the `@Storage` annotation are as follows:

* `@Storage(StoragePathMacros.WORKSPACE_FILE)` – for values stored in the project workspace file (project-level components only).

* `@Storage("yourName.xml")` – if a component is project-level, for `.ipr`-based projects, a standard project file is used automatically, and there is no need to specify anything.

The state is persisted in a separate file by specifying a different setting for the `value` parameter, which was the `file` parameter before 2016.x.

Note:

For application-level storage, it is strongly recommended to use a custom file.
Using of `other.xml` is deprecated.

When planning the storage location, consider its intended purpose.
A project-level custom file should be preferred for storing plugin settings.
To store cached values, use `@Storage(StoragePathMacros.CACHE_FILE)`.
Refer to [StoragePathMacros](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/projectModel-api/src/com/intellij/openapi/components/StoragePathMacros.java) for commonly used macros.

The `roamingType` parameter of the `@Storage` annotation specifies whether and how the settings are shared between IDE installations.
See [Roaming Types](roaming-settings.html#roaming-types) for details.

### Customizing the XML Format of Persisted Values

Note:

Consider using annotation parameters only to achieve backward compatibility.
Otherwise, feel free to file issues about specific serialization cosmetics.

To use the default bean serialization but customize the storage format in XML (for example, for compatibility with previous versions of a plugin or externally defined XML formats), use the
[@Tag](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations/Tag.java),
[@Attribute](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations/Attribute.java),
[@Property](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations/Property.java),
[@MapAnnotation](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations/MapAnnotation.java),
[@XMap](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations/XMap.java),
and [@XCollection](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/util/xmlb/annotations/XCollection.java)
annotations.

If the state to serialize doesn't map cleanly to a JavaBean, then `org.jdom.Element` can be used as the state class.
In that case, use the `getState()` method to build an XML element with an arbitrary structure, which then is saved directly in the state XML file.
In the `loadState()` method, deserialize the JDOM element tree using any custom logic.
This is not recommended and should be avoided whenever possible.

To disable the expansion of path macros ([PathMacro](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/macro/src/com/intellij/ide/macro/PathMacro.java))
in stored values, implement [PathMacroFilter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/jps/model-serialization/src/com/intellij/openapi/application/PathMacroFilter.java)
and register in [com.intellij.pathMacroFilter](https://jb.gg/ipe?extensions=com.intellij.pathMacroFilter) extension point
.

### Migrating Persisted Values

If the underlying persistence model or storage format has changed, a [ConverterProvider](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/conversion/ConverterProvider.java) can provide [ProjectConverter](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/lang-impl/src/com/intellij/conversion/ProjectConverter.java), whose `getAdditionalAffectedFiles()` method returns affected files to migrate and performs programmatic migration of stored values.

### Persistent Component Lifecycle

The `PersistentStateComponent.loadState()` method is called in two cases:

1. After the component is created (only if there is some non-default state persisted for the component)

2. After the XML file with the persisted state is changed externally (for example, if the project file was updated from the version control system)

In the latter case, the component is responsible for updating the UI and other related components according to the changed state.

The `PersistentStateComponent.getState()` method is called every time the settings are saved (for example, on frame deactivation or when closing the IDE).
If the state returned from `getState()` is equal to the default state (obtained by creating the state class with a default constructor), nothing is persisted in the XML.
Otherwise, the returned state is serialized in XML and stored.

## 

Using `PropertiesComponent` for Simple Non-Roamable Persistence

Use the [PropertiesComponent](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/core-api/src/com/intellij/ide/util/PropertiesComponent.java) service
to persist a small number of simple values, such as toggle states, counters, or strings.

This map-like API supports primitive types (`boolean`, `int`, `long`, and `float`),
`String` values, and collections of `String` values.
It can persist application-level and project-level values.

Warning:

[Roaming](roaming-settings.html) is disabled for `PropertiesComponent`, so use it only for local or temporary properties that do not need backup or sync.

To retrieve a `PropertiesComponent` instance, use:

* `PropertiesComponent.getInstance()` for application-level values.

* `PropertiesComponent.getInstance(Project)` for project-level values.

Warning:

When using `PropertiesComponent`, follow these guidelines:

* `PropertiesComponent` is a service-like class, so [service retrieval rules](plugin-services.html#retrieving-a-service) apply.

* Prefix keys with the plugin ID because all plugins share the same persistence namespace.

### Persisting a Toggle, Switch or Other Boolean Values

To persist a boolean value that is disabled by default:

Java:

```JAVA
// Key is prefixed with plugin ID to prevent conflicts
private static final String PREVIEW_KEY = "com.example.plugin.preview";

// Persist a toggle
PropertiesComponent.getInstance().setValue(PREVIEW_KEY, value);
```

Kotlin:

```KOTLIN
// Key is prefixed with plugin ID to prevent conflicts
private const val PREVIEW_KEY = "com.example.plugin.preview"

// Persist a toggle
PropertiesComponent.getInstance().setValue(PREVIEW_KEY, value)
```

Calling `setValue(PREVIEW_KEY, true)` stores `true` under the key.
Calling `setValue(PREVIEW_KEY, false)` doesn't store `false`.
Instead, it removes the key, because `false` is the default value for the two-argument `setValue()`.

To retrieve the value:

Java:

```JAVA
// Enable the preview if the stored value is "true" (a missing key counts as "false")
if (PropertiesComponent.getInstance().isTrueValue(PREVIEW_KEY)) {
  enablePreview();
}
```

Kotlin:

```KOTLIN
// Enable the preview if the stored value is "true" (a missing key counts as `false`)
if (PropertiesComponent.getInstance().isTrueValue(PREVIEW_KEY)) {
  enablePreview()
}
```

`isTrueValue()` parses the stored value with [Boolean.parseBoolean()](https://docs.oracle.com/en/java/javase/21/docs/api/java.base/java/lang/Boolean.html#parseBoolean(java.lang.String)),
so it returns `true` only if the value is the string `true` (ignoring case), and `false` for any other value or a missing key.

To persist a boolean value that should be enabled by default, specify the default value.

Java:

```JAVA
// Persist a value only when it differs from the default
PropertiesComponent.getInstance().setValue(PREVIEW_KEY, value, true);
```

Kotlin:

```KOTLIN
// Persist a value only when it differs from the default
PropertiesComponent.getInstance().setValue(PREVIEW_KEY, value, true)
```

The three-argument `setValue()` stores the value only when it differs from the default.
Otherwise, it removes the key.

To retrieve the value, pass the same default value to `getBoolean()`:

Java:

```JAVA
// Retrieve a value with `true` as the default
boolean isPreviewVisible = PropertiesComponent.getInstance().getBoolean(PREVIEW_KEY, true);
```

Kotlin:

```KOTLIN
// Retrieve a value with `true` as the default
val isPreviewVisible = PropertiesComponent.getInstance().getBoolean(PREVIEW_KEY, true)
```

If the key is missing, `getBoolean()` returns the specified default value.

Use `updateValue()` when a value change must also trigger additional work:

Java:

```JAVA
if (PropertiesComponent.getInstance().updateValue(PREVIEW_KEY, enabled)) {
  updatePreview();
}
```

Kotlin:

```KOTLIN
if (PropertiesComponent.getInstance().updateValue(PREVIEW_KEY, enabled)) {
  updatePreview()
}
```

`updateValue()` always stores `true` or `false` and returns `true` only when the value changed.
Unlike `setValue()`, it does not remove the key when the value equals a default.

### Persisting Primitive Values

Use typed methods for `int`, `float`, and `String` values.
Use the same default value in the getter and setter.

Java:

```JAVA
// Keys are prefixed with plugin ID to prevent conflicts
private static final String PREVIEW_LIMIT_KEY = "com.example.plugin.previewLimit";
private static final String PREVIEW_ZOOM_KEY = "com.example.plugin.previewZoom";
private static final String PREVIEW_STYLE_KEY = "com.example.plugin.previewStyle";

PropertiesComponent properties = PropertiesComponent.getInstance();
// Persist values only when they differ from the defaults
properties.setValue(PREVIEW_LIMIT_KEY, limit, 20);
properties.setValue(PREVIEW_ZOOM_KEY, zoom, 1.0f);
properties.setValue(PREVIEW_STYLE_KEY, style, "compact");
```

Kotlin:

```KOTLIN
// Keys are prefixed with plugin ID to prevent conflicts
private const val PREVIEW_LIMIT_KEY = "com.example.plugin.previewLimit"
private const val PREVIEW_ZOOM_KEY = "com.example.plugin.previewZoom"
private const val PREVIEW_STYLE_KEY = "com.example.plugin.previewStyle"

val properties = PropertiesComponent.getInstance()
// Persist values only when they differ from the defaults
properties.setValue(PREVIEW_LIMIT_KEY, limit, 20)
properties.setValue(PREVIEW_ZOOM_KEY, zoom, 1.0f)
properties.setValue(PREVIEW_STYLE_KEY, style, "compact")
```

To retrieve the values, pass the same default values:

Java:

```JAVA
PropertiesComponent properties = PropertiesComponent.getInstance();
// Retrieve values with the same defaults as used when persisting them
int limit = properties.getInt(PREVIEW_LIMIT_KEY, 20);
float zoom = properties.getFloat(PREVIEW_ZOOM_KEY, 1.0f);
String style = properties.getValue(PREVIEW_STYLE_KEY, "compact");
```

Kotlin:

```KOTLIN
val properties = PropertiesComponent.getInstance()
// Retrieve values with the same defaults as used when persisting them
val limit = properties.getInt(PREVIEW_LIMIT_KEY, 20)
val zoom = properties.getFloat(PREVIEW_ZOOM_KEY, 1.0f)
val style = properties.getValue(PREVIEW_STYLE_KEY, "compact")
```

`getInt()` and `getFloat()` return the default when the key is absent or invalid,
whereas `getValue()` returns it only when the key is absent.
Each three-argument `setValue()` follows the same default-value rule:
it stores the value only when it differs from the default and otherwise removes the key.

### Persisting Multiple Strings

Use `setList()` and `getList()` to persist a collection of strings.

Java:

```JAVA
// Key is prefixed with plugin ID to prevent conflicts
private static final String RECENT_PREVIEWS_KEY = "com.example.plugin.recentPreviews";

// Persist a list of strings
PropertiesComponent.getInstance().setList(RECENT_PREVIEWS_KEY, recentPreviews);
```

Kotlin:

```KOTLIN
// Key is prefixed with plugin ID to prevent conflicts
private const val RECENT_PREVIEWS_KEY = "com.example.plugin.recentPreviews"

// Persist a list of strings
PropertiesComponent.getInstance().setList(RECENT_PREVIEWS_KEY, recentPreviews)
```

`setList()` stores a copy of the collection.

To retrieve the list:

Java:

```JAVA
// Retrieve the list, or `null` if no list is stored
List<String> recentPreviews = PropertiesComponent.getInstance().getList(RECENT_PREVIEWS_KEY);
```

Kotlin:

```KOTLIN
// Retrieve the list, or `null` if no list is stored
val recentPreviews = PropertiesComponent.getInstance().getList(RECENT_PREVIEWS_KEY)
```

If the key is missing, `getList()` returns `null`, so handle this case before using the list.

### Resetting Stored Values

Use `unsetValue()` to remove a stored value for a key.

Java:

```JAVA
PropertiesComponent.getInstance().unsetValue(PREVIEW_STYLE_KEY);
```

Kotlin:

```KOTLIN
PropertiesComponent.getInstance().unsetValue(PREVIEW_STYLE_KEY)
```

The next read returns the default value because the key is absent.

### Detecting the Presence of a Value

Java:

```JAVA
boolean hasSavedStyle = PropertiesComponent.getInstance().isValueSet(PREVIEW_STYLE_KEY);
```

Kotlin:

```KOTLIN
val hasSavedStyle = PropertiesComponent.getInstance().isValueSet(PREVIEW_STYLE_KEY)
```

Use `isValueSet()` only when a saved value must be distinguished from an absent key.

### Storage Mechanism

The underlying storage mechanism is an internal implementation detail.

Project-level values are stored in the project’s `.idea/workspace.xml` file, while application-level values are stored in the IDE [configuration directory](https://www.jetbrains.com/help/idea/directories-used-by-the-ide-to-store-settings-caches-plugins-and-logs.html#config-directory).

## 

Legacy API (`JDOMExternalizable`)

Older components use [JDOMExternalizable](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/openapi/util/JDOMExternalizable.java) for persisting state.
It uses the `readExternal()` method for reading the state from a JDOM element, and `writeExternal()` to write the state.

Implementations can manually store the state in attributes and sub-elements or use [DefaultJDOMExternalizer](https://github.com/JetBrains/intellij-community/tree/idea/263.7307.200/platform/util/src/com/intellij/openapi/util/DefaultJDOMExternalizer.java) to store the values of all public fields automatically.

Components save their state in the following files:

* Project-level: project (`.ipr`) file. However, if the workspace option in the `[plugin.xml](plugin-configuration-file.html)` file is set to `true`, then the workspace (`.iws`) file is used instead.

* Module-level: module (`.iml`) file.

