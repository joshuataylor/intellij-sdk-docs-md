# Entity Declaration

The Workspace Model allows defining types of entities.

Warning: Custom Entities

Defining custom entities is not yet available to third-party plugins, see also [Generating Entity Implementations](#generating-entity-implementations).

To declare an entity type, a Kotlin interface has to be created, which directly or indirectly extends
[WorkspaceEntity](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/workspace/storage/src/com/intellij/platform/workspace/storage/WorkspaceEntity.kt).
The entity interface must contain read-only properties only.

A nested `Builder` interface with setters for these properties, and a `companion` object which allows creating instances of the entity
are generated automatically along with the implementations (see [Generating Entity Implementations](#generating-entity-implementations)).
The platform currently provides some predefined types of entities
(see [entities](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities) package),
but they're supposed to be used only for interoperability with code which uses the project model API.

Plugins should define and use their own types of entities if they need to store framework-specific data.

## Examples

### Default and Computable Fields

See [Property Kinds](workspace-model-entity-properties.html#property-kinds).

```KOTLIN
interface GradleEntity : WorkspaceEntity {
  val test: String

  // Field with default value
  val version: Int
    @Default get() = 5
  val description: Description

  // Computable field
  val name: String
    get() = description.name
}

data class Description(
  val name: String,
  val valid: Boolean,
  val modifications: Int
)
```

### 

Parent → Child References

See [Parent-Child Relationship](workspace-model-entity-properties.html#parent-child-relationship).

```KOTLIN
interface MavenEntity : WorkspaceEntity {
  val version: Int
  val name: String
  val root: VirtualFileUrl

  val kotlinEntities: List<@Child KotlinEntity>
}

interface KotlinEntity : WorkspaceEntity {
  val name: String
  val maven: MavenEntity
}
```

### 

Soft Reference using `SymbolicEntityId`

See [SymbolicEntityId](workspace-model-entity-properties.html#symbolicentityid) and [Symbolic References](workspace-model-entity-properties.html#symbolic-references).

```KOTLIN
interface MavenEntity : WorkspaceEntityWithSymbolicId {
  val version: Int
  val name: String
  override val symbolicId: MavenId
    get() = MavenId(true, name)
}

interface KotlinEntity : WorkspaceEntity {
  val name: String
  val mavenId: MavenId
}

data class MavenId(
  val valid: Boolean,
  override val presentableName: String
) : SymbolicEntityId<MavenEntity>
```

### Reference via Extension Property

Due to the limitation that a reference must be declared on both entities, there needs to be an option to declare a reference to an entity from another module.
This can be done by declaring an extension property for the entity located outside the module.
This property must use the [WorkspaceEntity.extension()](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/workspace/storage/src/com/intellij/platform/workspace/storage/WorkspaceEntity.kt) delegate to work correctly.

Example: a `KotlinEntity` declaring a reference to the `MavenEntity` located in a different module:

'Maven' module:

```KOTLIN
interface MavenEntity: WorkspaceEntity {
  val version: Int
  val name: String
}
```

'Kotlin' module:

```KOTLIN
interface KotlinEntity: WorkspaceEntity {
  val name: String
  val maven: MavenEntity
}
val MavenEntity.kotlinEntity: @Child KotlinEntity
  by WorkspaceEntity.extension()
```

### Inheritance

For inheritance, the supertype entity must be marked using
[Abstract](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/workspace/storage/src/com/intellij/platform/workspace/storage/annotations/Abstract.kt) annotation.

See [PackagingElementEntity](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/workspace/jps/src/com/intellij/java/workspace/entities/artifact.kt),
more samples can be found in the
[com.intellij.platform.workspace.jps.entities](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities)
package.

## Generating Entity Implementations

Warning:

This feature is currently not available to third-party plugins and enabled only for the IntelliJ IDEA project itself.

After defining the entity interface, generate some code with the Generate Workspace Model Implementation action,
available from the module's context menu in the Project tool window or via `Help | Find Action`
on the currently open file.

Entity implementations can also be generated via the Generate implementation quick-fix on the interface's name element,
which is provided by inspection `Plugin DevKit | Workspace model | Generate implementation`.

Along with generating implementations for the interfaces in the `gen` source folder, this action also adds the `Builder` interface
to an entity as well as some additional methods in the file where the entity is located.

Comments surround all generated blocks:

```
//region generated code
//endregion
```

Don't edit the generated code blocks. If something is wrong with the generated code, try re-executing the action.

