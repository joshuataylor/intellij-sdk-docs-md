# DataGrip Extension Point and Listener List

<tldr>
Product-Specific Plugin Development: [DataGrip](data-grip.html)

See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

81 Extension Points and 29 Listeners

## Legend

Tip:

See also [Explore the IntelliJ Platform API](explore-api.html) for more information and strategies.

### Listeners

Topic
searches for usages inside existing implementations of open-source IntelliJ Platform plugins via [IntelliJ Platform Explorer](https://jb.gg/ipe).

Listener
links corresponding listener to implement.

See [Listeners](plugin-listeners.html) on how to register listeners.

### Extension Points

Extension Point
searches for usages inside existing implementations of open-source IntelliJ Platform plugins via [IntelliJ Platform Explorer](https://jb.gg/ipe).

Implementation
is the related Extension Point class.

See [Extensions](plugin-extensions.html) on how to declare extensions in your plugin.

### Tags

See [Verifying Plugin Compatibility](verifying-plugin-compatibility.html) for overview of API status.

| Tag |Description |Details |
-----------------------------
| ![Deprecated](https://img.shields.io/badge/-Deprecated-lightgrey?style=flat-square) |Deprecated API |See code documentation for replacement. |
| ![Removal](https://img.shields.io/badge/-Removal-red?style=flat-square) |Scheduled for Removal API |Annotated with [@ApiStatus.ScheduledForRemoval](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             See code documentation for replacement.   |
| ![Obsolete](https://img.shields.io/badge/-Obsolete-grey?style=flat-square)                          |Obsolete API |Annotated with [@ApiStatus.Obsolete](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             Do not use in new code, see code documentation for replacement.   |
| ![Experimental API](https://img.shields.io/badge/-Experimental-violet?style=flat-square)                               |Experimental API |Annotated with [@ApiStatus.Experimental](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             API might be altered or removed without prior notice.   |
| ![Internal API](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |Internal API |Annotated with [@ApiStatus.Internal](https://github.com/JetBrains/java-annotations/tree/24.0.0/common/src/main/java/org/jetbrains/annotations/ApiStatus.java).                             Must not be used by third party plugins, see [Internal API Migration](api-internal.html).   |
| ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |Project-LevelExtension Point/Topic   |Can have [Project](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/openapi/project/Project.java)                             as constructor parameter.                               - Extension Point: declared with `area="IDEA_PROJECT"`                               - Listener: registered in [&lt;projectListeners&gt;](plugin-configuration-file.html#idea-plugin__projectListeners)                                |
| ![DumbAware](https://img.shields.io/badge/-DumbAware-darkgreen?style=flat-square) |`DumbAware`                             Extension Point   |Implementations marked with [DumbAware](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/platform/core-api/src/com/intellij/openapi/project/DumbAware.java)                             will be processed during [dumb                                 mode](indexing-and-psi-stubs.html#dumb-mode).                          |
| ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |Non-DynamicExtension Point   |Installation/update of plugin requires restarting the IDE, see [Dynamic Plugins](dynamic-plugins.html).                          |

## DataGrip

### DataGrip – Listeners

| Topic |Listener |
-------------------
| [CloudConnectionDataStorage#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.cloud.explorer.CloudConnectionDataStorage.Listener) |`Listener` |
| [DataSourcePerFileMappings#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.console.DataSourcePerFileMappings.OnMappingsChangedListener) |`OnMappingsChangedListener` |
| [JdbcDriverManager#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.console.JdbcDriverManager.Listener) |`Listener` |
| [DatabaseSessionManager#topic](https://jb.gg/ipe/listeners?topics=com.intellij.database.console.session.DatabaseSessionManagerListener) |`DatabaseSessionManagerListener` |
| [DatabaseSession.Companion#topic](https://jb.gg/ipe/listeners?topics=com.intellij.database.console.session.DatabaseSessionStateListener) |`DatabaseSessionStateListener` |
| [AbstractDataSource#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.dataSource.AbstractDataSource.Listener) |`Listener` |
| [DataSourceModelStorage#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.dataSource.DataSourceModelStorage.Listener) |`Listener` |
| [DataSourceStorage#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.dataSource.DataSourceStorage.Listener) |`Listener` |
| [DatabaseConnectionManager#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.dataSource.DatabaseConnectionManager.Listener) |`Listener` |
| [DatabaseArtifactManager#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.dataSource.artifacts.DatabaseArtifactManager.ArtifactListener) |`ArtifactListener` |
| [DataSourceTestConnectionManager#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.dataSource.ui.DataSourceTestConnectionManager.Listener) |`Listener` |
| [DatabaseTopics#AUDIT_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.datagrid.DataAuditor) |`DataAuditor` |
| [DatabaseTopics#RESPONSE_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.datagrid.DataConsumer) |[DataConsumer](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/grid/core-impl/src/datagrid/DataConsumer.java) |
| [DatabaseTopics#REQUEST_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.datagrid.DataProducer) |[DataProducer](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/grid/core-impl/src/datagrid/DataProducer.java) |
| [ImportHead#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.dbimport.ImportHead.Listener) |`Listener` |
| [DbImportDialog#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.dbimport.editor.DbImportDialog.Listener) |`Listener` |
| [ScriptGeneratorDiagnosticListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.dialects.base.generator.ScriptGeneratorDiagnosticListener) |`ScriptGeneratorDiagnosticListener` |
| [DatabaseModelLoader#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.introspection.DatabaseModelLoader.Listener) |`Listener` |
| [DataSourceManager#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.psi.DataSourceManager.Listener) |`Listener` |
| [DbPsiFacade#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.psi.DbPsiFacade.Listener) |`Listener` |
| [SqlRoutineIndex#topic](https://jb.gg/ipe/listeners?topics=com.intellij.database.sql.backend.core.SqlRoutineIndex.SqlRoutineIndexListener) |`SqlRoutineIndexListener` |
| [DbUltimateActionsListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.util.DbUltimateActionsListener) |`DbUltimateActionsListener` |
| [DatabaseColorManager#COLOR_CHANGE_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.view.DatabaseColorManager.ColorChangeListener) |`ColorChangeListener` |
| [DatabaseConfigEditor#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.view.ui.DatabaseConfigEditor.Listener) |`Listener` |
| [CloudDatabasesPanel#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.view.ui.cloud.explorer.CloudDatabasesPanel.Listener) |`Listener` |
| [ConnectionTemplatesSideTab#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.view.ui.cloud.jba.ConnectionTemplatesSideTab.Listener) |`Listener` |
| [DataSourceTemplateConfigurable#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.database.view.ui.cloud.jba.DataSourceTemplateConfigurable.Listener) |`Listener` |
| [DatabaseSettings#TOPIC](https://jb.gg/ipe/listeners?topics=java.lang.Runnable) |`Runnable` |
| [DatabaseViewOptions#TOPIC](https://jb.gg/ipe/listeners?topics=java.lang.Runnable) |`Runnable` |

### intellij.database.connectivity.ex.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.database.artifactRepositoriesProvider](https://jb.gg/ipe?extensions=com.intellij.database.artifactRepositoriesProvider)      |`ArtifactRepositoriesProvider` |

### intellij.database.connectivity.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.database.consoleRunContextParametersTuner](https://jb.gg/ipe?extensions=com.intellij.database.consoleRunContextParametersTuner)      |`ConsoleRunContextParametersTuner` |
| [com.intellij.database.dataConsumer](https://jb.gg/ipe?extensions=com.intellij.database.dataConsumer)      |[DataConsumer](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/grid/core-impl/src/datagrid/DataConsumer.java) |
| [com.intellij.database.dataProducer](https://jb.gg/ipe?extensions=com.intellij.database.dataProducer)      |[DataProducer](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/grid/core-impl/src/datagrid/DataProducer.java) |
| [com.intellij.database.errorProvider](https://jb.gg/ipe?extensions=com.intellij.database.errorProvider)      |`ConsoleErrorProviderFactory` |
| [com.intellij.database.gridHelper](https://jb.gg/ipe?extensions=com.intellij.database.gridHelper)      |[CoreGridHelper](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/grid/core-impl/src/datagrid/CoreGridHelper.java) |
| [com.intellij.database.jdbcHelper](https://jb.gg/ipe?extensions=com.intellij.database.jdbcHelper)      |`JdbcHelper` |
| [com.intellij.database.jdbcMetadataWrapper](https://jb.gg/ipe?extensions=com.intellij.database.jdbcMetadataWrapper)      |`MDFactory` |
| [com.intellij.database.jdbcSourceLoader](https://jb.gg/ipe?extensions=com.intellij.database.jdbcSourceLoader)      |`JdbcSourceLoader` |
| [com.intellij.database.objectEditorFactory](https://jb.gg/ipe?extensions=com.intellij.database.objectEditorFactory)      |`DbmsObjectEditorFactory` |
| [com.intellij.database.objectEditorModelFactory](https://jb.gg/ipe?extensions=com.intellij.database.objectEditorModelFactory)      |`DbmsObjectEditorModelFactory` |
| [com.intellij.database.queryParametersProvider](https://jb.gg/ipe?extensions=com.intellij.database.queryParametersProvider)      |`QueryParametersProvider` |
| [com.intellij.database.queryValidator](https://jb.gg/ipe?extensions=com.intellij.database.queryValidator)      |`DbQueryValidator` |
| [com.intellij.database.remoteProcessInitializer](https://jb.gg/ipe?extensions=com.intellij.database.remoteProcessInitializer)      |`RemoteProcessInitializer` |
| [com.intellij.database.toDatabaseScriptTranslator](https://jb.gg/ipe?extensions=com.intellij.database.toDatabaseScriptTranslator)      |`ToDatabaseScriptTranslator` |

### intellij.database.core.impl.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.database.addToHSet](https://jb.gg/ipe?extensions=com.intellij.database.addToHSet)      |`n/a` |
| [com.intellij.database.artifactsConfig](https://jb.gg/ipe?extensions=com.intellij.database.artifactsConfig)      |`n/a` |
| [com.intellij.database.connectionInterceptor](https://jb.gg/ipe?extensions=com.intellij.database.connectionInterceptor)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`DatabaseConnectionInterceptor` |
| [com.intellij.database.consoleProvider](https://jb.gg/ipe?extensions=com.intellij.database.consoleProvider)      |`PersistenceConsoleProvider` |
| [com.intellij.database.dataAuditor](https://jb.gg/ipe?extensions=com.intellij.database.dataAuditor)      |`DataAuditor` |
| [com.intellij.database.dataImporter](https://jb.gg/ipe?extensions=com.intellij.database.dataImporter)      |`ImportManager` |
| [com.intellij.database.dataSourceDetector](https://jb.gg/ipe?extensions=com.intellij.database.dataSourceDetector)      |`DataSourceDetector` |
| [com.intellij.database.dataSourceManager](https://jb.gg/ipe?extensions=com.intellij.database.dataSourceManager)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`DataSourceManager` |
| [com.intellij.database.dbms](https://jb.gg/ipe?extensions=com.intellij.database.dbms)      |`n/a` |
| [com.intellij.database.definitionProvider](https://jb.gg/ipe?extensions=com.intellij.database.definitionProvider)      |`DefinitionProvider` |
| [com.intellij.database.dmlHelper](https://jb.gg/ipe?extensions=com.intellij.database.dmlHelper)      |`DmlHelper` |
| [com.intellij.database.domainRegistry](https://jb.gg/ipe?extensions=com.intellij.database.domainRegistry)      |`DomainRegistry` |
| [com.intellij.database.driversConfig](https://jb.gg/ipe?extensions=com.intellij.database.driversConfig)      |`n/a` |
| [com.intellij.database.errorHandler](https://jb.gg/ipe?extensions=com.intellij.database.errorHandler)      |`DatabaseErrorHandler` |
| [com.intellij.database.executionEnvironmentHelper](https://jb.gg/ipe?extensions=com.intellij.database.executionEnvironmentHelper)      |`ExecutionEnvironmentHelper` |
| [com.intellij.database.explainPlanProvider](https://jb.gg/ipe?extensions=com.intellij.database.explainPlanProvider)      |`ExplainPlanProvider` |
| [com.intellij.database.extensionFallback](https://jb.gg/ipe?extensions=com.intellij.database.extensionFallback)      |`n/a` |
| [com.intellij.database.geoHelper](https://jb.gg/ipe?extensions=com.intellij.database.geoHelper)      |`GeoHelper` |
| [com.intellij.database.gridColumnsManagerFactory](https://jb.gg/ipe?extensions=com.intellij.database.gridColumnsManagerFactory)      |`GridColumnsManagerFactory` |
| [com.intellij.database.hookUpHelper](https://jb.gg/ipe?extensions=com.intellij.database.hookUpHelper)      |`HookUpHelper` |
| [com.intellij.database.introspector](https://jb.gg/ipe?extensions=com.intellij.database.introspector)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`Factory` |
| [com.intellij.database.introspectorStatsProvider](https://jb.gg/ipe?extensions=com.intellij.database.introspectorStatsProvider)      |`DBIntrospectorStatsProvider` |
| [com.intellij.database.linkedDataSourceHelper](https://jb.gg/ipe?extensions=com.intellij.database.linkedDataSourceHelper)      |`LinkedDataSourceHelper` |
| [com.intellij.database.modelExternalData](https://jb.gg/ipe?extensions=com.intellij.database.modelExternalData)      |`n/a` |
| [com.intellij.database.modelFacade](https://jb.gg/ipe?extensions=com.intellij.database.modelFacade)      |`ModelFacade` |
| [com.intellij.database.modelRelationProvider](https://jb.gg/ipe?extensions=com.intellij.database.modelRelationProvider)      |`ModelRelationProvider` |
| [com.intellij.database.namingService](https://jb.gg/ipe?extensions=com.intellij.database.namingService)      |`Provider` |
| [com.intellij.database.optionProvider](https://jb.gg/ipe?extensions=com.intellij.database.optionProvider)      |`DbOptionProvider` |
| [com.intellij.database.parameterPatternProvider](https://jb.gg/ipe?extensions=com.intellij.database.parameterPatternProvider)      |`DatabaseParameterPatternProvider` |
| [com.intellij.database.processParamProvider](https://jb.gg/ipe?extensions=com.intellij.database.processParamProvider)      |`ConsoleConfigurationParamProvider` |
| [com.intellij.database.routineExecutionHelper](https://jb.gg/ipe?extensions=com.intellij.database.routineExecutionHelper)      |`RoutineExecutionHelper` |
| [com.intellij.database.runtimeErrorFixProvider](https://jb.gg/ipe?extensions=com.intellij.database.runtimeErrorFixProvider)      |[RuntimeErrorActionProvider](https://github.com/JetBrains/intellij-community/tree/idea/261.26222.65/grid/core-impl/src/connection/throwable/info/RuntimeErrorActionProvider.kt) |
| [com.intellij.database.scriptGenerator](https://jb.gg/ipe?extensions=com.intellij.database.scriptGenerator)      |`ScriptGenerator` |
| [com.intellij.database.sqlObjectBuilder](https://jb.gg/ipe?extensions=com.intellij.database.sqlObjectBuilder)      |`SqlObjectBuilder` |
| [com.intellij.database.synchronizeHandler](https://jb.gg/ipe?extensions=com.intellij.database.synchronizeHandler)      |`SynchronizeHandler` |
| [com.intellij.database.typeSystem](https://jb.gg/ipe?extensions=com.intellij.database.typeSystem)      |`DasTypeSystem` |
| [com.intellij.database.urlEditorInspector](https://jb.gg/ipe?extensions=com.intellij.database.urlEditorInspector)      |`UrlEditorInspector` |
| [com.intellij.database.urlParamEditorProvider](https://jb.gg/ipe?extensions=com.intellij.database.urlParamEditorProvider)      |`TypeDescriptorFactory` |
| [com.intellij.database.virtualFileDataSourceProvider](https://jb.gg/ipe?extensions=com.intellij.database.virtualFileDataSourceProvider)      |`VirtualFileDataSourceProvider` |

### intellij.database.dialects.mongo.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.database.mongo.resolveHelper](https://jb.gg/ipe?extensions=com.intellij.database.mongo.resolveHelper)      |`MongoJSResolveHelper` |

### intellij.database.impl.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.database.activeConnectionInfoProvider](https://jb.gg/ipe?extensions=com.intellij.database.activeConnectionInfoProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`DbActiveConnectionInfoProvider` |
| [com.intellij.database.cli.runTargetProvider](https://jb.gg/ipe?extensions=com.intellij.database.cli.runTargetProvider)      |`CliRunTargetProvider` |
| [com.intellij.database.cloudCommunicatorProvider](https://jb.gg/ipe?extensions=com.intellij.database.cloudCommunicatorProvider)      |`CloudCommunicatorProvider` |
| [com.intellij.database.cloudDataSourceProvider](https://jb.gg/ipe?extensions=com.intellij.database.cloudDataSourceProvider)      |`CloudDataSourceProvider` |
| [com.intellij.database.configValidator](https://jb.gg/ipe?extensions=com.intellij.database.configValidator)      |`DatabaseConfigValidator` |
| [com.intellij.database.databaseViewStructureExtension](https://jb.gg/ipe?extensions=com.intellij.database.databaseViewStructureExtension)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`DvStructureExtension` |
| [com.intellij.database.debuggerFacade](https://jb.gg/ipe?extensions=com.intellij.database.debuggerFacade)      |`SqlDebuggerFacade` |
| [com.intellij.database.explorer.decoration](https://jb.gg/ipe?extensions=com.intellij.database.explorer.decoration)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`DvDecorationExtension` |
| [com.intellij.database.predicatesHelper](https://jb.gg/ipe?extensions=com.intellij.database.predicatesHelper)      |`PredicatesHelper` |
| [com.intellij.database.runConsoleAvailable](https://jb.gg/ipe?extensions=com.intellij.database.runConsoleAvailable)      |`RunQueryIntentionActionAvailable` |
| [com.intellij.database.schemaDiffCustomization](https://jb.gg/ipe?extensions=com.intellij.database.schemaDiffCustomization)      |`SchemaDiffCustomization` |
| [com.intellij.database.selectInProvider](https://jb.gg/ipe?extensions=com.intellij.database.selectInProvider)      |`Extension` |
| [com.intellij.database.urlParamEditorUiProvider](https://jb.gg/ipe?extensions=com.intellij.database.urlParamEditorUiProvider)      |`TypeDescriptorUiFactory` |

### intellij.database.sql.core.impl.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.database.dialect](https://jb.gg/ipe?extensions=com.intellij.database.dialect)      |`DatabaseDialect` |
| [com.intellij.database.sqlEffectAnalyzer](https://jb.gg/ipe?extensions=com.intellij.database.sqlEffectAnalyzer)      |`SqlAffectAnalyzer` |
| [com.intellij.sql.dataSourceProvider](https://jb.gg/ipe?extensions=com.intellij.sql.dataSourceProvider)      |`DataSourceProvider` |
| [com.intellij.sql.dialect](https://jb.gg/ipe?extensions=com.intellij.sql.dialect)      |`SqlLanguageDialect` |
| [com.intellij.sql.dialectCodeStyleProvider](https://jb.gg/ipe?extensions=com.intellij.sql.dialectCodeStyleProvider)      |`SqlDialectCodeStyleProvider` |
| [com.intellij.sql.evaluationHelper](https://jb.gg/ipe?extensions=com.intellij.sql.evaluationHelper)      |`EvaluationHelper` |
| [com.intellij.sql.executionFlowAnalyzerProvider](https://jb.gg/ipe?extensions=com.intellij.sql.executionFlowAnalyzerProvider)      |`ExecutionFlowAnalyzerProvider` |
| [com.intellij.sql.formatterHelper](https://jb.gg/ipe?extensions=com.intellij.sql.formatterHelper)      |`SqlFormatterHelper` |
| [com.intellij.sql.inspectionSuppressorDelegate](https://jb.gg/ipe?extensions=com.intellij.sql.inspectionSuppressorDelegate)      |`SqlInspectionSuppressorDelegate` |
| [com.intellij.sql.membersHelper](https://jb.gg/ipe?extensions=com.intellij.sql.membersHelper)      |`SqlMembersHelper` |
| [com.intellij.sql.navigationHelper](https://jb.gg/ipe?extensions=com.intellij.sql.navigationHelper)      |`NavigationHelper` |
| [com.intellij.sql.resolveExtension](https://jb.gg/ipe?extensions=com.intellij.sql.resolveExtension)      |`SqlResolveExtension` |

### intellij.grid.scripting.impl.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.grid.scripting.ivyLocalRepository](https://jb.gg/ipe?extensions=com.intellij.grid.scripting.ivyLocalRepository)      |`IvyLocalRepository` |

