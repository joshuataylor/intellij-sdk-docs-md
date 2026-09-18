# Entity Properties

Properties of an [entity](workspace-model-entity-declaration.html) are declared by properties in its interface.

## Supported Types

The following types of properties are supported:

* primitive types (`Int`, `Boolean`, etc);

* `String`

* `enum`

* an immutable `data class` with properties of supported types

* a `sealed` class which implementations are immutable data classes or objects with properties of supported types

* a nullable variant of a supported type

* `List`, `Set` or `Map` collections with elements of supported types

* [VirtualFileUrl](#virtualfileurl)

* [EntitySource](#entitysource)

* [SymbolicEntityId](#symbolicentityid)

* a [reference to another entity](#parent-child-relationship)

## Property Kinds

There are three kinds of properties: mandatory, optional, and computable properties.

### Mandatory

If a property doesn't have a default value, it is treated as mandatory.
Values of mandatory properties must be provided when an entity is created by passing parameters to the `companion` object.

### Optional

If a property has a default value, it is treated as optional.
Optional properties may be initialized in a lambda passed as the last parameter to the `companion` object.
To provide a default value for a property, define a getter for them and annotate it with
[@Default](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/annotations/Default.kt).
Properties whose type is nullable have a default value `null` implicitly, but there are no implicit default values for other types, even for primitive types.

### Computable

If a property has a getter without `@Default` annotation, it is treated as computable.
Computable properties may use data from other properties of the same entity and other entities referenced from it only.
Their values aren't saved in the storage but computed each time a property is accessed.

## 

`VirtualFileUrl`

<tldr>
See Also: [VirtualFileUrl Index](workspace-model-entity-read.html#virtualfileurl-index)
</tldr>

Represents a reference to a file or directory.
Workspace model entities must use properties of this type to store references to files instead of storing their paths or URLs as `String` properties,
because it consumes less memory and provides an efficient way to locate a
[VirtualFile](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/vfs/VirtualFile.java).

Use [VirtualFileUrlManager.getOrCreateFromUrl()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/url/VirtualFileUrlManager.kt)
or [VirtualFile.toVirtualFileUrl()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/backend/workspace/src/VirtualFileUrls.kt)
extension function to create an instance.

Use [VirtualFileUrl.virtualFile](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/backend/workspace/src/VirtualFileUrls.kt) extension property to locate a
[VirtualFile](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/core-api/src/com/intellij/openapi/vfs/VirtualFile.java) from a
[VirtualFileUrl](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/url/VirtualFileUrl.java).

Also, it is possible to automatically update references in entities when corresponding files are moved or renamed.
Currently, it is implemented to specific types of entities only in
[VirtualFileUrlWatcher](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/lang-impl/src/com/intellij/workspaceModel/ide/impl/legacyBridge/watcher/VirtualFileUrlWatcher.kt).

### 

Locating `VirtualFileUrl`

[EntityStorage.getVirtualFileUrlIndex()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/EntityStorage.kt)
provides a way to quickly find entities referring to a particular
[VirtualFileUrl](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/url/VirtualFileUrl.java).

```KOTLIN
val workspaceModel = WorkspaceModel.getInstance(project)
// Getting VirtualFileUrlManager
val virtualFileManager = workspaceModel.getVirtualFileUrlManager()
// Find or create VirtualFileUrl from the URL
val path = virtualFileManager.findByUrl("file:///foo/bar")
// Searching all entities with the path
workspaceModel.currentSnapshot.getVirtualFileUrlIndex()
  .findEntitiesByUrl(path)
```

## 

`EntitySource`

<tldr>
See Also: [EntitySource Index](workspace-model-entity-read.html#entitysource-index)
</tldr>

Describes a place where an entity came from.
It may be:

* a configuration file on disk (property [EntitySource.virtualFileUrl](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/EntitySource.kt) should be implemented to point to that file)

* some strings that identify the source

* a marker object if entities are generated automatically by some algorithm which doesn't use external data

Each entity must specify its source via the
[WorkspaceEntity.entitySource](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/WorkspaceEntity.kt) property.
For example, entities loaded from configuration files under the `.idea` directory use
[JpsProjectFileEntitySource](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/jps/src/com/intellij/platform/workspace/jps/jpsEntitySources.kt).

Information about entity sources is used by the
[MutableEntityStorage.replaceBySource()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/MutableEntityStorage.kt)
function.
See also [Replace By Source](workspace-model-entity-mutation.html#replace-by-source) section.

An entity source must be serializable along with entities, so there are some restrictions on its implementation.
It must be a `data class` that contains read-only properties of the following types:

* primitive types

* `String`

* `enum`

* `List` of another allowed type

* another `data class` with properties of the allowed types

* `sealed abstract class` where all implementations satisfy these requirements

## 

`SymbolicEntityId`

<tldr>
See Also: [SymbolicEntityId Index](workspace-model-entity-read.html#symbolicentityid-index)
</tldr>

The ID is supposed to be based on names specified by a user in the UI or in configuration files, not on some autogenerated IDs.
Can be interpreted as a business key for the concrete entity type.
[SymbolicEntityId](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/SymbolicEntityId.kt)
for an entity may include a reference to `SymbolicEntityId` of its parent entity if it is necessary to make them unique.
For example, [ModuleId](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/persistent_Id.kt)
includes only the name of the module, but
[FacetId](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/persistent_Id.kt)
includes the name of the facet and a reference to `ModuleId` of the module the facet belongs to.

The Workspace Model store is prohibited from containing two entities with the same `SymbolicEntityId`.
For example, [SymbolicIdAlreadyExistsException](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/impl/exceptions/SymbolicIdAlreadyExistsException.kt)
will be thrown when trying to add a
[ModuleEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/module.kt)
with a `ModuleId` that is already present in the
[EntityStorage](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/EntityStorage.kt).

To specify a `SymbolicEntityId` for an entity, the entity interface must extend
[WorkspaceEntityWithSymbolicId](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/SymbolicEntityId.kt)
and provide an implementation of its `symbolicId` property which returns an instance of the corresponding class.
Type parameter `<E>` of the returned instance must be equal to the entity interface.
A specific implementation of `SymbolicEntityId` may be used in properties of an entity
to create a symbolic link to an entity of the corresponding type.

Note that unlike [parent-child](#parent-child-relationship) "hard" links, symbolic links aren't guaranteed to be resolvable.
When a linked entity is removed, the entity referring to it doesn't change, and the ID will resolve to `null`.
However, if after modification of an entity, its `symbolicId` changes, properties of all other entities containing a value equal to the previous ID
are automatically replaced with the new ID.

The storage maintains an index, which can be used to quickly find all entities referring to a given entity via symbolic links, see
[EntityStorage.referrers()](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/EntityStorage.kt)
function.

An implementation must be a `data class` which contains read-only properties of the following types:

* primitive types

* `String`

* `enum`

* another `data class` with properties of the allowed types

* `sealed abstract class` where all implementations satisfy these requirements

## References between Entities

There are two ways to refer from one entity to another: using parent-child relationship (hard links) and via symbolic references (soft links).

### Parent-Child Relationship

Some types of entities may be connected by "parent-child" relationship.
It is introduced by a property in the child entity interface, which refers to the parent entity with the [Parent](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/annotations/Parent.kt) annotation,
and a property in the parent entity interface which refers to the nullable child entity.

For example, source roots are defined inside a content root in the project model, so
[ContentRootEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/roots.kt)
is defined as a parent of `SourceRootEntity`.

The storage automatically maintains the consistency of this relationship during modifications:

* if a parent entity is removed, all its child entities are also removed

* if a child entity is removed, the corresponding property in its parent entity is updated so it no longer refers to the removed entity

The property referring to the parent entity may have a type:

* `@Parent ParentEntity` indicating that the parent is mandatory

* `@Parent ParentEntity?` indicating that the parent is optional

The property referring to child entity may have a type:

* `ChildEntity?` indicating that there are zero or one child entities of the given type

* `List<ChildEntity>` indicating that there are zero, one, or more child entities of the given type

If the parent is optional, it is possible to create a child entity without the parent entity and set the reference to the parent entity to `null` for an existing child entity.
Also, if the reference to a child entity is removed from the corresponding property in the parent entity, it causes automatic removal of the child entity
if it specifies that the parent is mandatory and sets the parent reference to `null` if the parent is optional.

See the "Parent-child relationship between entities" section in
[WorkspaceEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/WorkspaceEntity.kt)
code documentation for more details.

### Symbolic References

If a configuration described by an entity refers to a configuration described by another entity, a symbolic reference may be used.
It may happen that the referenced configuration doesn't exist: in that case the reference cannot be resolved.

To define a symbolic reference, the interface of the referenced entity must extend
[WorkspaceEntityWithSymbolicId](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/SymbolicEntityId.kt),
provide an implementation of
[SymbolicEntityId](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/storage/src/com/intellij/platform/workspace/storage/SymbolicEntityId.kt)
and return it from its `symbolicId` property.
The entity which refers to it must store an instance of that `SymbolicEntityId` implementation in one of its properties.

For example, a module from the project model may depend on other modules.
This is implemented by a property with the type
[ModuleId](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/persistent_Id.kt)
which is stored inside
[ModuleDependencyItem](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/persistent_Id.kt)
`data class` stored in the
[ModuleEntity.dependencies](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/module.kt)
property.

The value of a property containing an implementation of `SymbolicEntityId` is automatically updated if the `symbolicId` property
of the referenced entity changes after modification.

