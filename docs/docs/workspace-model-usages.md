# Usage Examples

See also [Entity Mutation](workspace-model-entity-mutation.html) and [Entity Read](workspace-model-entity-read.html) topics.

## Module

### Search Module by Name

```KOTLIN
val moduleId = ModuleId("moduleName")
val entityStorage: ImmutableEntityStorage =
  WorkspaceModel.getInstance(project).currentSnapshot
entityStorage.resolve(moduleId)
```

### Rename Module

```KOTLIN
val workspaceModel = WorkspaceModel.getInstance(project)
val moduleEntity: ModuleEntity =
  workspaceModel.currentSnapshot.resolve(ModuleId(moduleName))
writeAction {
  workspaceModel.update("Change module name") { builder ->
    builder.modifyModuleEntity(moduleEntity) {
      this.name = newModuleName
    }
  }
}
```

### 

`ModuleEntity` Creation

Creating a new
[ModuleEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/module.kt),
the legacy bridge will be created by the platform.
An important part here is the entity source.
To serialize an entity in project configuration files under the `.idea` folder, use
[JpsProjectFileEntitySource](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/workspace/jps/src/com/intellij/platform/workspace/jps/jpsEntitySources.kt).

2024.3+:

```KOTLIN
import com.intellij.workspaceModel.ide.legacyBridge.LegacyBridgeJpsEntitySourceFactory
// ...

val workspaceModel = WorkspaceModel.getInstance(project)
val moduleId = ModuleId(moduleName)
if (moduleId in workspaceModel.currentSnapshot) {
  // Module with such `ModuleId` already exists
  ...
}

val baseModuleDir = workspaceModel.getVirtualFileUrlManager()
  .getOrCreateFromUrl("file://foo/bar")
val moduleEntitySource =
    LegacyBridgeJpsEntitySourceFactory.getInstance(project)
        .createEntitySourceForModule(baseModuleDir, null)
WorkspaceModel.getInstance(project).update("Add new module") { builder ->
  val moduleEntity =
      ModuleEntity(moduleName, emptyList(), moduleEntitySource)
  builder.addEntity(moduleEntity)
}
```

2024.2:

```KOTLIN
import com.intellij.workspaceModel.ide.impl.LegacyBridgeJpsEntitySourceFactory
// ...

val workspaceModel = WorkspaceModel.getInstance(project)
val moduleId = ModuleId(moduleName)
if (moduleId in workspaceModel.currentSnapshot) {
  // Module with such `ModuleId` already exists
  ...
}

val baseModuleDir = workspaceModel.getVirtualFileUrlManager()
  .getOrCreateFromUrl("file://foo/bar")
val moduleEntitySource =
    LegacyBridgeJpsEntitySourceFactory
        .createEntitySourceForModule(project, baseModuleDir, null)
WorkspaceModel.getInstance(project).update("Add new module") { builder ->
  val moduleEntity =
      ModuleEntity(moduleName, emptyList(), moduleEntitySource)
  builder.addEntity(moduleEntity)
}
```

Tip:

Note that [LegacyBridgeJpsEntitySourceFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/projectModel-impl/src/com/intellij/workspaceModel/ide/impl/LegacyBridgeJpsEntitySourceFactory.kt) is an internal API.
It is exceptionally allowed to use it in plugins.

### Add Library Dependency to Module

A project-level library is added as a dependency to the module.

```KOTLIN
val workspaceModel = WorkspaceModel.getInstance(project)
val moduleEntity = workspaceModel.currentSnapshot
  .resolve(ModuleId(moduleName)) ?: return
workspaceModel.update("Adding new module dependency") { builder ->
  builder.modifyModuleEntity(moduleEntity) {
    val libraryId = LibraryId(
      libraryName,
      LibraryTableId.ProjectLibraryTableId
    )
    this.dependencies.add(
      LibraryDependency(libraryId, false, DependencyScope.COMPILE)
    )
  }
}
```

### Searching for Module-Containing Path

Search for content roots and source roots with required URLs and determine the `ModuleEntity` to which they belong.

```KOTLIN
val workspaceModel = WorkspaceModel.getInstance(project)
val virtualFileUrl = workspaceModel.getVirtualFileUrlManager()
  .getOrCreateFromUrl("file://foo/bar/src")

workspaceModel.currentSnapshot.getVirtualFileUrlIndex()
  .findEntitiesByUrl(virtualFileUrl)
  .mapNotNull {
    if (it is SourceRootEntity) {
      it.contentRoot.module
    } else if (it is ContentRootEntity) {
      it.module
    } else {
      null
    }
  }
```

## Library

### 

`LibraryEntity` Creation

Creating a new
[LibraryEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/dependencies.kt),
the legacy bridge will be created by the platform.

2024.3+:

```KOTLIN
import com.intellij.workspaceModel.ide.legacyBridge.LegacyBridgeJpsEntitySourceFactory
// ...

val currentSnapshot = WorkspaceModel.getInstance(project).currentSnapshot
val libraryTableId = LibraryTableId.ProjectLibraryTableId

val libraryId = LibraryId(libraryName, libraryTableId)
if (libraryId in currentSnapshot) {
  // Library with such `LibraryId` already exist
  ...
}

val libraryEntitySource =
    LegacyBridgeJpsEntitySourceFactory.getInstance(project)
        .createEntitySourceForProjectLibrary(null)
val libraryEntity = LibraryEntity(
  libraryName,
  libraryTableId, emptyList(),
  libraryEntitySource
)
WorkspaceModel.getInstance(project).update("Add new library") { builder ->
  builder.addEntity(libraryEntity)
}
```

2024.2:

```KOTLIN
import com.intellij.workspaceModel.ide.impl.LegacyBridgeJpsEntitySourceFactory
// ...

val currentSnapshot = WorkspaceModel.getInstance(project).currentSnapshot
val libraryTableId = LibraryTableId.ProjectLibraryTableId

val libraryId = LibraryId(libraryName, libraryTableId)
if (libraryId in currentSnapshot) {
  // Library with such `LibraryId` already exist
  ...
}

val libraryEntitySource =
    LegacyBridgeJpsEntitySourceFactory
        .createEntitySourceForProjectLibrary(project, null)
val libraryEntity = LibraryEntity(
  libraryName,
  libraryTableId, emptyList(),
  libraryEntitySource
)
WorkspaceModel.getInstance(project).update("Add new library") { builder ->
  builder.addEntity(libraryEntity)
}
```

Tip:

Note that [LegacyBridgeJpsEntitySourceFactory](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/projectModel-impl/src/com/intellij/workspaceModel/ide/impl/LegacyBridgeJpsEntitySourceFactory.kt) is an internal API.
It is exceptionally allowed to use it in plugins.

### Searching for Library by Root Type and URL

```KOTLIN
val workspaceModel = WorkspaceModel.getInstance(project)
val virtualFileUrlManager = workspaceModel.getVirtualFileUrlManager()
// URL that we will look for in library entities
val virtualFileUrl = virtualFileUrlManager
  .getOrCreateFromUrl("file://foo/bar")
workspaceModel.currentSnapshot.getVirtualFileUrlIndex()
  .findEntitiesByUrl(virtualFileUrl).filterIsInstance<LibraryEntity>().filter {
    it.roots.any {
      it.url == virtualFileUrl &&
              it.type == LibraryRootTypeId.SOURCES
    }
  }
```

## Roots

### Add Content Root and Source Root for Module

```KOTLIN
val workspaceModel = WorkspaceModel.getInstance(project)
val virtualFileUrlManager = workspaceModel.getVirtualFileUrlManager()

val moduleEntity = workspaceModel.currentSnapshot
  .resolve(ModuleId(moduleName)) ?: ...
val contentRootUrl = virtualFileUrlManager
  .getOrCreateFromUrl("file://foo/bar")
val sourceRootUrl = virtualFileUrlManager
  .getOrCreateFromUrl("file://foo/bar/src")
workspaceModel.update("Adding source root") { builder ->
  val contentRootEntity = ContentRootEntity(contentRootUrl, emptyList(), moduleEntity.entitySource) {
    val sourceRootEntity =
      SourceRootEntity(
        sourceRootUrl,
        SourceRootTypeId("java-source"),
        moduleEntity.entitySource
      )
    this.sourceRoots = mutableListOf(sourceRootEntity)
  }
  builder.modifyModuleEntity(moduleEntity) {
    this.contentRoots = mutableListOf(contentRootEntity)
  }
}
```

### Adding Different Types of Library Roots

Two library roots of different types are defined, and a new exclude root is added.

```KOTLIN
val workspaceModel = WorkspaceModel.getInstance(project)
val virtualFileUrlManager = workspaceModel.getVirtualFileUrlManager()
val libraryEntity = workspaceModel.currentSnapshot
  .resolve(
    LibraryId(
      libraryName,
      LibraryTableId.ProjectLibraryTableId
    )
  ) ?: ...

val sourceRoot = LibraryRoot(
  virtualFileUrlManager
    .getOrCreateFromUrl("file://foo/bar"), LibraryRootTypeId.SOURCES
)
val compiledRoot = LibraryRoot(
  virtualFileUrlManager
    .getOrCreateFromUrl("file://foo/baz"), LibraryRootTypeId.COMPILED
)
workspaceModel.update("Adding library roots") { builder ->
  builder.modifyLibraryEntity(libraryEntity) {
    this.roots = mutableListOf(sourceRoot, compiledRoot)
    // Adding new exclude root
    val virtualFileUrl = virtualFileUrlManager
      .getOrCreateFromUrl("file://foo/out")
    this.excludedRoots =
      excludedRoots + ExcludeUrlEntity(virtualFileUrl, this.entitySource)
  }
}
```

## Miscellaneous

### 

Migration of Caches Relying on `Library`/`Module`

Using `Library` or `Module` as a key on maps has a number of disadvantages:

* Can’t be used as a key for collections that rely on hashcode calculation, as these objects are mutable by their nature.

* The fact that they extend `Disposable` (see [Disposer and Disposable](disposers.html)) imposes additional difficulties.

To eliminate these shortcomings, use
[EntityPointer](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/workspace/storage/src/com/intellij/platform/workspace/storage/EntityPointer.kt).
It represents a pointer to an entity which can be stored anywhere.
The pointer can be obtained via
[WorkspaceEntity.createPointer()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/workspace/storage/src/com/intellij/platform/workspace/storage/WorkspaceEntity.kt).
An instance of this class stores an internal ID of the entity and doesn't contain the pointer to the original storage, so it's ok to
store them in long-living data structures as it won't create a memory leak.

The pointer will resolve to the same entity for the same storage and will survive modifications.
If the entity is removed or replaced by a different one via
[MutableEntityStorage.replaceBySource()](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.258/platform/workspace/storage/src/com/intellij/platform/workspace/storage/MutableEntityStorage.kt),
the pointer may either resolve to `null` or to a completely different entity which reused the same internal ID.
To be sure that the pointer resolves to the original entity, also [subscribe to changes](workspace-model-event-listening.html) in the storage.

