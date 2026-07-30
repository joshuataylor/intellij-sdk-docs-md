# Workspace Model

The Workspace Model represents the project's structure and all its elements, such as [modules](module.html), [libraries](library.html), [SDKs](sdk.html), [facets](facet.html),
and other configurable project components.
It provides a generic storage for entities describing the user's workspace while maintaining full
[interoperability](#interoperability) with the [Project Model](project-model.html).

Note: Workspace Model API (2024.2+)

The [Workspace Model]() API is available since 2024.2 for use by third-party plugins and should be preferred over using the [Project Model](project-model.html) API.

See [Interoperability with Project Model API](#interoperability) and [Usage Examples](workspace-model-usages.html).

## Why a New API?

There are several problems with the approach that has been used to represent the [project model](project-model.html) (configuration of modules, libraries, facet, artifacts, etc.)
in the IntelliJ Platform for more than 15 years.

### Structure

Different project model parts are stored in separate project-level and module-level services
([ModuleManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/module/ModuleManager.kt),
[ModuleRootManager](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/roots/ModuleRootManager.java),
[LibraryTable](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/roots/libraries/LibraryTable.java),
etc.).

They're implemented independently, and the project model has no single entry point.
This leads to code duplication and complicates bulk modifications of project model elements, since you need to manually track modifiable instances of the model elements
or create special wrappers to do it (see [IdeModifiableModelsProvider](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/external-system-api/src/com/intellij/openapi/externalSystem/service/project/IdeModifiableModelsProvider.java)).

### Serialization

There is no way to serialize the project model’s entire content in a binary format to cache it or pass it to another process.

### Reuse

The project model interfaces ([Module](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/module/Module.java),
[Library](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/roots/libraries/Library.java),
[Facet](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-core/src/com/intellij/facet/Facet.java),
etc.) are highly coupled with the API that is only available inside the IDE process and its component management system.
It is not possible to reuse those interfaces in other processes (e.g., inside the build process or inside the process that imports data from Gradle)
or when the project hasn't yet been initialized (e.g., inside the New Project dialog).

Thus, separate representations of project model elements are necessary:

* [JpsProject](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/jps/model-api/src/org/jetbrains/jps/model/JpsProject.java), [JpsModule](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/jps/model-api/src/org/jetbrains/jps/model/module/JpsModule.java), [JpsLibrary](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/jps/model-api/src/org/jetbrains/jps/model/library/JpsLibrary.java), etc. for the build process

* [ProjectData](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/external-system-api/src/com/intellij/openapi/externalSystem/model/project/ProjectData.java), [ModuleData](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/external-system-api/src/com/intellij/openapi/externalSystem/model/project/ModuleData.java), [LibraryData](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/external-system-api/src/com/intellij/openapi/externalSystem/model/project/LibraryData.java), etc. for the importing process

All these places must be updated everytime something in the project model is changed.
The Workspace Model uses its own storage that is Platform-independent and can be reused in different places.

### Flexibility

The project model concepts were created for [IntelliJ IDEA](idea.html) before the IntelliJ Platform accommodated a variety of languages.
Many common interfaces like
[Module](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/module/Module.java) and
[Library](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/roots/libraries/Library.java)
still have Java-specific properties.
This makes it harder to reuse them for other languages and technologies, and there is no simple way to create new language-specific concepts and use them in the model.

## Concepts and Implementation

Workspace Model introduces a unified data structure that stores the project configuration and doesn't have to be used from the IDE process.
The implementation heavily relies on [Persistent Data Structure](https://en.wikipedia.org/wiki/Persistent_data_structure) that allows using a
model snapshot without fear that it will be modified during an interaction.

### Entities

Types of entities in the storage are represented by interfaces extending
[WorkspaceEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/storage/src/com/intellij/platform/workspace/storage/WorkspaceEntity.kt) (see [Entity Declaration](workspace-model-entity-declaration.html)).
All operations can be performed on entities.
Properties of entities may be of a restricted set of types only, see [Entity Properties](workspace-model-entity-properties.html) for details.

### Storage

Their instances are stored in [VersionedEntityStorage](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/storage/src/com/intellij/platform/workspace/storage/VersionedEntityStorage.kt),
which provides access to the current [ImmutableEntityStorage](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/storage/src/com/intellij/platform/workspace/storage/EntityStorage.kt),
an immutable snapshot of the storage state which isn't affected by further modifications of the storage.

### Modification

Modifying entities is performed via
[MutableEntityStorage](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/storage/src/com/intellij/platform/workspace/storage/MutableEntityStorage.kt).
Modifications are performed on copies of the original entities, so they don't affect old snapshots (see [Entity Mutation](workspace-model-entity-mutation.html)).

### Relationships

Entities are organized into a direct acyclic graph by optional [parent-child relationships](workspace-model-entity-properties.html#parent-child-relationship).
The storage maintains the consistency of such relations: if a child entity has a non-null reference to a parent entity, it is removed when the parent entity is removed or changed to point to a different child entity.

[Symbolic (soft) references](workspace-model-entity-properties.html#symbolic-references) between entities are supported.
It is also possible to [link objects](workspace-model-entity-read.html#arbitrary-data) of arbitrary types with entities.

## Interoperability with Project Model API

New implementations of the [Project Model](project-model.html) interfaces store their data in
Workspace Model in corresponding entities.

The following table maps to corresponding Workspace Model API and usage samples.

| Project Structure Element |Project Model API |Workspace Model API |Workspace Model API Usage |
------------------------------------------------------------------------------------------------
| [Module](module.html) |[Module](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/core-api/src/com/intellij/openapi/module/Module.java) |[ModuleEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/module.kt) |[Module](workspace-model-usages.html#module) |
| [Content Root](module.html#content-roots) |[ContentEntry](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/roots/ContentEntry.java) |[ContentRootEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/roots.kt) |[Roots](workspace-model-usages.html#roots) |
| [Source Root](module.html#source-roots) |[SourceFolder](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/roots/SourceFolder.java) |[SourceRootEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/roots.kt) |[Roots](workspace-model-usages.html#roots) |
| [SDK](sdk.html) |[Sdk](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/projectRoots/Sdk.java) |[SdkEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/sdk.kt) |  |
| [Library](library.html) |[Library](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/projectModel-api/src/com/intellij/openapi/roots/libraries/Library.java) |[LibraryEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/dependencies.kt) |[Library](workspace-model-usages.html#library) |
| [Facet](facet.html) |[Facet](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/lang-core/src/com/intellij/facet/Facet.java) |[FacetEntity](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/workspace/jps/src/com/intellij/platform/workspace/jps/entities/facet.kt) |  |

[WorkspaceModel](https://github.com/JetBrains/intellij-community/tree/idea/262.8665.337/platform/backend/workspace/src/WorkspaceModel.kt)
allows performing operations as with the [Project Model](project-model.html) API,
but via a single entry point, see also [Usage Examples](workspace-model-usages.html).

