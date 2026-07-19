# Open Source Plugins Extension Point and Listener List

<tldr>
Repository: [intellij-plugins](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/)

See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Overview of Extension Points and Listeners for open source plugins available in [IntelliJ IDEA Plugin Development](idea.html) and other IDEs.

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

IntelliJ Platform version: 2026.1.4.

80 Extension Points and 10 Listeners

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

## IntelliJ Open Source Plugins

### com.intellij.cpp-diagnostics

[com.intellij.cpp-diagnostics](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/cpp-diagnostics/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.clion.diagnostics.toolchainDescriptionProvider](https://jb.gg/ipe?extensions=com.intellij.clion.diagnostics.toolchainDescriptionProvider)      |[ToolchainDescriptionProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/cpp-diagnostics/src/com/jetbrains/cidr/cpp/diagnostics/toolchain/ToolchainDescriptionProvider.kt) |
| [com.intellij.clion.diagnostics.workspaceDescriptionProvider](https://jb.gg/ipe?extensions=com.intellij.clion.diagnostics.workspaceDescriptionProvider)      |[WorkspaceDescriptionProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/cpp-diagnostics/src/com/jetbrains/cidr/cpp/diagnostics/workspace/WorkspaceDescriptionProvider.kt) |

### com.thoughtworks.gauge

[com.thoughtworks.gauge](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/gauge/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.thoughtworks.gauge.moduleImporter](https://jb.gg/ipe?extensions=com.thoughtworks.gauge.moduleImporter)      |[GaugeModuleImporter](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/gauge/src/com/thoughtworks/gauge/wizard/GaugeModuleImporter.java) |

### gherkin

[gherkin](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/cucumber/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.plugins.cucumber.injector.injectorExtensionPoint](https://jb.gg/ipe?extensions=org.jetbrains.plugins.cucumber.injector.injectorExtensionPoint)      |[GherkinInjectorExtensionPoint](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/cucumber/src/org/jetbrains/plugins/cucumber/injector/GherkinInjectorExtensionPoint.java) |
| [org.jetbrains.plugins.cucumber.steps.cucumberJvmExtensionPoint](https://jb.gg/ipe?extensions=org.jetbrains.plugins.cucumber.steps.cucumberJvmExtensionPoint)      |[CucumberJvmExtensionPoint](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/cucumber/src/org/jetbrains/plugins/cucumber/CucumberJvmExtensionPoint.java) |

### idea.plugin.protoeditor

[idea.plugin.protoeditor](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/protobuf/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.protobuf.codeImplementationSearcher](https://jb.gg/ipe?extensions=com.intellij.protobuf.codeImplementationSearcher)      |[PbCodeImplementationSearcher](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/protobuf/protoeditor-core/src/com/intellij/protobuf/ide/gutter/PbGeneratedCodeConverterProvider.kt) |
| [com.intellij.protobuf.fileResolveProvider](https://jb.gg/ipe?extensions=com.intellij.protobuf.fileResolveProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[FileResolveProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/protobuf/protoeditor-core/src/com/intellij/protobuf/lang/resolve/FileResolveProvider.java) |
| [com.intellij.protobuf.generatedCodeConverterProvider](https://jb.gg/ipe?extensions=com.intellij.protobuf.generatedCodeConverterProvider)      |[PbGeneratedCodeConverterProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/protobuf/protoeditor-core/src/com/intellij/protobuf/ide/gutter/PbGeneratedCodeConverterProvider.kt) |
| [com.intellij.protobuf.nameGeneratorContributor](https://jb.gg/ipe?extensions=com.intellij.protobuf.nameGeneratorContributor)      |[NameGeneratorContributor](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/protobuf/protoeditor-core/src/com/intellij/protobuf/lang/names/NameGeneratorContributor.java) |
| [com.intellij.protobuf.projectSettingsConfigurator](https://jb.gg/ipe?extensions=com.intellij.protobuf.projectSettingsConfigurator)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ProjectSettingsConfigurator](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/protobuf/protoeditor-core/src/com/intellij/protobuf/ide/settings/ProjectSettingsConfigurator.java) |
| [com.intellij.protobuf.schemaProvider](https://jb.gg/ipe?extensions=com.intellij.protobuf.schemaProvider)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[SchemaProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/protobuf/protoeditor-core/src/com/intellij/protobuf/lang/resolve/SchemaProvider.java) |

### intellij.angular.backend.xml

[intellij.angular.backend.xml](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Angular/angular-backend/resources/intellij.angular.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.angular2.configProvider](https://jb.gg/ipe?extensions=org.angular2.configProvider)      |[AngularConfigProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Angular/angular-backend/src/org/angular2/cli/config/AngularConfigProvider.kt) |
| [org.angular2.entitiesSource](https://jb.gg/ipe?extensions=org.angular2.entitiesSource)      |[Angular2EntitiesSource](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Angular/angular-backend/src/org/angular2/entities/Angular2EntitiesSource.kt) |
| [org.angular2.frameworkHandler](https://jb.gg/ipe?extensions=org.angular2.frameworkHandler)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[Angular2FrameworkHandler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Angular/angular-backend/src/org/angular2/entities/Angular2FrameworkHandler.kt) |
| [org.angular2.importsHandler](https://jb.gg/ipe?extensions=org.angular2.importsHandler)      |[Angular2ImportsHandler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Angular/angular-backend/src/org/angular2/codeInsight/imports/Angular2ImportsHandler.kt) |
| [org.angular2.jsHandlersFactory](https://jb.gg/ipe?extensions=org.angular2.jsHandlersFactory)      |[Angular2JSHandlersFactory](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Angular/angular-backend/src/org/angular2/codeInsight/Angular2HandlersFactory.kt) |
| [org.angular2.templateScopesProvider](https://jb.gg/ipe?extensions=org.angular2.templateScopesProvider)      |[Angular2TemplateScopesProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Angular/angular-backend/src/org/angular2/codeInsight/template/Angular2TemplateScopesProvider.kt) |

### intellij.jhipster.xml

[intellij.jhipster.xml](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/jhipster/resources/intellij.jhipster.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.jhipster.fieldTypeReferenceProvider](https://jb.gg/ipe?extensions=com.intellij.jhipster.fieldTypeReferenceProvider)      |[JdlFieldTypeReferenceProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/jhipster/src/com/intellij/jhipster/psi/JdlFieldTypeReferenceProvider.java) |

### intellij.prettierJS

[intellij.prettierJS](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/prettierJS/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.prettierjs.codeStyleInstaller](https://jb.gg/ipe?extensions=com.intellij.prettierjs.codeStyleInstaller)      |[PrettierCodeStyleInstaller](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/prettierJS/src/com/intellij/prettierjs/codeStyle/PrettierCodeStyleInstaller.java) |

### intellij.vuejs.backend.xml

[intellij.vuejs.backend.xml](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/vuejs/vuejs-backend/resources/intellij.vuejs.backend.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.vuejs.containerInfoProvider](https://jb.gg/ipe?extensions=com.intellij.vuejs.containerInfoProvider)      |[VueContainerInfoProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/vuejs/vuejs-backend/src/org/jetbrains/vuejs/model/source/VueContainerInfoProvider.kt) |
| [com.intellij.vuejs.templateScopesProvider](https://jb.gg/ipe?extensions=com.intellij.vuejs.templateScopesProvider)      |[VueTemplateScopesProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/vuejs/vuejs-backend/src/org/jetbrains/vuejs/codeInsight/template/VueTemplateScopesProvider.kt) |
| [com.intellij.vuejs.templateSymbolScopesProvider](https://jb.gg/ipe?extensions=com.intellij.vuejs.templateSymbolScopesProvider)      |[VueTemplateSymbolScopesProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/vuejs/vuejs-backend/src/org/jetbrains/vuejs/codeInsight/template/VueTemplateSymbolScopesProvider.kt) |

### name.kropp.intellij.makefile

[name.kropp.intellij.makefile](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/makefile/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.makefile.runConfigurationCustomizer](https://jb.gg/ipe?extensions=com.intellij.makefile.runConfigurationCustomizer)      |[MakefileRunConfigurationCustomizer](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/makefile/src/com/jetbrains/lang/makefile/MakefileRunConfigurationCustomizer.kt) |
| [com.intellij.makefile.toolWindowStripeController](https://jb.gg/ipe?extensions=com.intellij.makefile.toolWindowStripeController)      |[MakefileToolWindowStripeController](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/makefile/src/com/jetbrains/lang/makefile/toolWindow/MakefileToolWindowStripeController.kt) |

### tslint

[tslint](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/tslint/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.tslint.configDetector](https://jb.gg/ipe?extensions=com.intellij.tslint.configDetector)      |[TsLintConfigDetector](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/tslint/src/com/intellij/lang/javascript/linter/tslint/config/TsLintConfigDetector.java) |

## Dart Plugin

### Dart Plugin – Listeners

| Topic |Listener |
-------------------
| [DartAnalysisServerMessages#DART_ANALYSIS_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.lang.dart.analyzer.DartAnalysisServerMessages.DartAnalysisNotifier) |[DartAnalysisNotifier](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Dart/src/com/jetbrains/lang/dart/analyzer/DartAnalysisServerMessages.java) |

### Dart

[Dart](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Dart/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [Dart.completionExtension](https://jb.gg/ipe?extensions=Dart.completionExtension)      |[DartCompletionExtension](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Dart/src/com/jetbrains/lang/dart/ide/completion/DartCompletionExtension.java) |
| [Dart.completionTimerExtension](https://jb.gg/ipe?extensions=Dart.completionTimerExtension)      |[DartCompletionTimerExtension](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/Dart/src/com/jetbrains/lang/dart/ide/completion/DartCompletionTimerExtension.java) |

## Devicetree Plugin

### Devicetree Plugin – Listeners

| Topic |Listener |
-------------------
| [ChangeListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.dts.settings.DtsSettings.ChangeListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[ChangeListener](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/dts/src/com/intellij/dts/settings/DtsSettings.kt) |

### com.intellij.dts

[com.intellij.dts](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/dts/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.clion.dtsUtil](https://jb.gg/ipe?extensions=com.intellij.clion.dtsUtil)      |[DtsCMakeUtil](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/dts/src/com/intellij/dts/cmake/DtsCMakeUtil.kt) |
| [com.intellij.dts.settings.disabler](https://jb.gg/ipe?extensions=com.intellij.dts.settings.disabler)      |[DtsSettingsDisabler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/dts/src/com/intellij/dts/settings/DtsSettingsDisabler.kt) |

### intellij.dts.cmake.xml

[intellij.dts.cmake.xml](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/dts/cmake/resources/intellij.dts.cmake.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.dts.cmake.configurationDataProvider](https://jb.gg/ipe?extensions=com.intellij.dts.cmake.configurationDataProvider)      |[DtsCMakeModelConfigurationDataProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/dts/cmake/src/com/intellij/dts/cmake/impl/DtsCMakeModelConfigurationDataProvider.kt) |

## Flex Plugin

### Flex Plugin – Listeners

| Topic |Listener |
-------------------
| [FlexBuildConfigurationChangeListener#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.lang.javascript.flex.projectStructure.model.impl.FlexBuildConfigurationChangeListener) |[FlexBuildConfigurationChangeListener](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/flex/src/com/intellij/lang/javascript/flex/projectStructure/model/impl/FlexBuildConfigurationChangeListener.java) |

### com.intellij.flex

[com.intellij.flex](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/flex/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.flex.breakpoint.type.provider](https://jb.gg/ipe?extensions=com.intellij.flex.breakpoint.type.provider)      ![Non-Dynamic](https://img.shields.io/badge/-Non--Dynamic-orange?style=flat-square) |[BreakpointTypeProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/flex/src/com/intellij/lang/javascript/flex/debug/FlexBreakpointsHandler.java) |

## OSGi Plugin

### OSGi Plugin – Listeners

| Topic |Listener |
-------------------
| [FrameworkDefinitionListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.osmorc.settings.FrameworkDefinitionListener) |[FrameworkDefinitionListener](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/osmorc/src/org/osmorc/settings/FrameworkDefinitionListener.java) |

### Osmorc

[Osmorc](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/osmorc/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [Osmorc.frameworkIntegrator](https://jb.gg/ipe?extensions=Osmorc.frameworkIntegrator)      |[FrameworkIntegrator](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/osmorc/src/org/osmorc/frameworkintegration/FrameworkIntegrator.java) |

## Perforce Helix Core

### Perforce Helix Core – Listeners

| Topic |Listener |
-------------------
| [PerforceSettings#OFFLINE_MODE_EXITED](https://jb.gg/ipe/listeners?topics=java.lang.Runnable) |`Runnable` |
| [P4ConfigListener#TOPIC](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.perforce.perforce.connections.P4ConfigListener)  ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[P4ConfigListener](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/PerforceIntegration/src/org/jetbrains/idea/perforce/perforce/connections/PerforceExternalConfigTracker.kt) |
| [P4EnvHelper#P4_ENV_CHANGED](https://jb.gg/ipe/listeners?topics=org.jetbrains.idea.perforce.perforce.connections.P4EnvHelper.P4EnvListener)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[P4EnvListener](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/PerforceIntegration/src/org/jetbrains/idea/perforce/perforce/connections/P4EnvHelper.java) |

### PerforceDirectPlugin

[PerforceDirectPlugin](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/PerforceIntegration/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [Perforce.P4ConnectionParametersProvider](https://jb.gg/ipe?extensions=Perforce.P4ConnectionParametersProvider)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |[P4ConnectionParametersProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/PerforceIntegration/src/org/jetbrains/idea/perforce/perforce/connections/P4ConnectionParametersProvider.kt) |

## PlatformIO for CLion Plugin

### PlatformIO for CLion Plugin – Listeners

| Topic |Listener |
-------------------
| [PlatformioServiceKt#PLATFORMIO_UPDATES_TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.cidr.cpp.embedded.platformio.PlatformioUpdatesNotifier)  ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |[PlatformioUpdatesNotifier](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/platformio/src/com/jetbrains/cidr/cpp/embedded/platformio/PlatformioService.kt) |
| [PlatformioSettingsListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.jetbrains.cidr.cpp.embedded.platformio.project.PlatformioSettingsListener) |[PlatformioSettingsListener](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/platformio/src/com/jetbrains/cidr/cpp/embedded/platformio/project/PlatformioSettings.kt) |

## Qodana Plugin

### intellij.qodana.coverage.xml

[intellij.qodana.coverage.xml](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/coverage/resources/intellij.qodana.coverage.xml)

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.qodana.coverage.cloudArtifactsProcessor](https://jb.gg/ipe?extensions=com.intellij.qodana.coverage.cloudArtifactsProcessor)      |[CoverageCloudArtifactsProcessor](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/coverage/src/org/jetbrains/qodana/staticAnalysis/inspections/coverage/CoverageCloudArtifactsProcessor.kt) |

### intellij.qodana.inspectionKts.xml

[intellij.qodana.inspectionKts.xml](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/inspectionKts/core/resources/intellij.qodana.inspectionKts.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.jetbrains.qodana.inspectionKts.customPluginsForKtsClasspathProvider](https://jb.gg/ipe?extensions=org.jetbrains.qodana.inspectionKts.customPluginsForKtsClasspathProvider)      |[CustomPluginsForKtsClasspathProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/inspectionKts/core/src/org/jetbrains/qodana/inspectionKts/CustomPluginsForKtsClasspathProvider.kt) |
| [org.jetbrains.qodana.inspectionKts.customPsiFileFactory](https://jb.gg/ipe?extensions=org.jetbrains.qodana.inspectionKts.customPsiFileFactory)      |[CustomPsiFileFactory](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/inspectionKts/core/src/org/jetbrains/qodana/inspectionKts/fileFactory/CustomPsiFileFactory.kt) |
| [org.jetbrains.qodana.inspectionKts.defaultImportProvider](https://jb.gg/ipe?extensions=org.jetbrains.qodana.inspectionKts.defaultImportProvider)      |[InspectionKtsDefaultImportProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/inspectionKts/core/src/org/jetbrains/qodana/inspectionKts/imports.kt) |
| [org.jetbrains.qodana.inspectionKts.examples.provider](https://jb.gg/ipe?extensions=org.jetbrains.qodana.inspectionKts.examples.provider)      |[Provider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/inspectionKts/core/src/org/jetbrains/qodana/inspectionKts/examples/InspectionKtsExample.kt) |
| [org.jetbrains.qodana.inspectionKts.postProcessorFactory](https://jb.gg/ipe?extensions=org.jetbrains.qodana.inspectionKts.postProcessorFactory)      |[CompiledInspectionKtsPostProcessorFactory](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/inspectionKts/core/src/org/jetbrains/qodana/inspectionKts/InspectionKtsFileStatus.kt) |
| [org.jetbrains.qodana.inspectionKts.psiViewerSupport](https://jb.gg/ipe?extensions=org.jetbrains.qodana.inspectionKts.psiViewerSupport)      |[PsiViewerSupport](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/inspectionKts/core/src/org/jetbrains/qodana/inspectionKts/ui/psi-viewer.kt) |
| [org.jetbrains.qodana.inspectionKts.templates.provider](https://jb.gg/ipe?extensions=org.jetbrains.qodana.inspectionKts.templates.provider)      |[Provider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/inspectionKts/core/src/org/jetbrains/qodana/inspectionKts/templates/InspectionKtsTemplate.kt) |

### org.intellij.qodana

[org.intellij.qodana](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/resources/META-INF/plugin.xml)

| Extension Point |Implementation |
-----------------------------------
| [org.intellij.qodana.azureCiConfigUpdateHandler](https://jb.gg/ipe?extensions=org.intellij.qodana.azureCiConfigUpdateHandler)      |[AzureCIConfigHandler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/ci/AzureCIConfigHandler.kt) |
| [org.intellij.qodana.bitbucketCiConfigUpdateHandler](https://jb.gg/ipe?extensions=org.intellij.qodana.bitbucketCiConfigUpdateHandler)      |[BitbucketCIConfigHandler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/ci/BitbucketCIConfigHandler.kt) |
| [org.intellij.qodana.circleCiConfigUpdateHandler](https://jb.gg/ipe?extensions=org.intellij.qodana.circleCiConfigUpdateHandler)      |[CircleCIConfigHandler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/ci/CircleCIConfigHandler.kt) |
| [org.intellij.qodana.configUpdateHandler](https://jb.gg/ipe?extensions=org.intellij.qodana.configUpdateHandler)      |[ConfigUpdateHandler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/ConfigUpdateHandler.kt) |
| [org.intellij.qodana.contextMarginProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.contextMarginProvider)      |[ContextMarginProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/sarif/ContextMarginProvider.kt) |
| [org.intellij.qodana.cyclomaticComplexityFileVisitor](https://jb.gg/ipe?extensions=org.intellij.qodana.cyclomaticComplexityFileVisitor)      |[CyclomaticComplexityMetricFileVisitor](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/inspections/metrics/inspections/cyclomaticComplexity/CyclomaticComplexityMetricFileVisitor.kt) |
| [org.intellij.qodana.dynamicInspectionsInitializer](https://jb.gg/ipe?extensions=org.intellij.qodana.dynamicInspectionsInitializer)      |[DynamicInspectionInitializer](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/util/src/org/jetbrains/qodana/util/DynamicInspectionInitializer.kt) |
| [org.intellij.qodana.externalToolsConfigurationProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.externalToolsConfigurationProvider)      |[ExternalToolsConfigurationProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/inspections/runner/externalTools/ExternalToolsConfigurationProvider.kt) |
| [org.intellij.qodana.externalToolsProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.externalToolsProvider)      |[ExternalToolsProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/inspections/runner/externalTools/ExternalToolsProvider.kt) |
| [org.intellij.qodana.githubCiConfigHandler](https://jb.gg/ipe?extensions=org.intellij.qodana.githubCiConfigHandler)      |[GitHubCIConfigHandler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/ci/GitHubCIConfigHandler.kt) |
| [org.intellij.qodana.gitlabCiConfigHandler](https://jb.gg/ipe?extensions=org.intellij.qodana.gitlabCiConfigHandler)      |[GitLabCIConfigHandler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/ci/GitLabCIConfigHandler.kt) |
| [org.intellij.qodana.globalFlowFingerprintCalculator](https://jb.gg/ipe?extensions=org.intellij.qodana.globalFlowFingerprintCalculator)      |[CustomGlobalFlowFingerprintCalculator](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/inspections/runner/globalOutput/CustomGlobalFlowFingerprintCalculator.kt) |
| [org.intellij.qodana.globalOutputConsumer](https://jb.gg/ipe?extensions=org.intellij.qodana.globalOutputConsumer)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[GlobalOutputConsumer](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/inspections/runner/globalOutput/GlobalOutputConsumer.kt) |
| [org.intellij.qodana.highlightInfoActionProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.highlightInfoActionProvider)      |[QodanaHighlightInfoActionProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/highlight/QodanaHighlightInfoActionProvider.kt) |
| [org.intellij.qodana.highlightingListener](https://jb.gg/ipe?extensions=org.intellij.qodana.highlightingListener)      |[QodanaHighlightingListener](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/highlight/QodanaHighlightingListener.kt) |
| [org.intellij.qodana.inspectionProfileProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.inspectionProfileProvider)      |[QodanaInspectionProfileProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/profile/QodanaInspectionProfileProvider.java) |
| [org.intellij.qodana.jenkinsConfigHandler](https://jb.gg/ipe?extensions=org.intellij.qodana.jenkinsConfigHandler)      |[JenkinsConfigHandler](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/ci/JenkinsConfigHandler.kt) |
| [org.intellij.qodana.loggingActivity](https://jb.gg/ipe?extensions=org.intellij.qodana.loggingActivity)      |[QodanaLoggingActivity](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/inspections/runner/log/QodanaLoggingActivity.kt) |
| [org.intellij.qodana.metricTable](https://jb.gg/ipe?extensions=org.intellij.qodana.metricTable)      |[MetricTable](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/inspections/metrics/database/tables/MetricTable.kt) |
| [org.intellij.qodana.metricsAggregator](https://jb.gg/ipe?extensions=org.intellij.qodana.metricsAggregator)      |[MetricAggregator](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/inspections/metrics/aggregators/MetricAggregator.kt) |
| [org.intellij.qodana.problemsViewModuleSupport](https://jb.gg/ipe?extensions=org.intellij.qodana.problemsViewModuleSupport)      |[QodanaGroupByModuleSupport](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/ui/problemsView/QodanaGroupByModuleSupport.kt) |
| [org.intellij.qodana.projectDescriber](https://jb.gg/ipe?extensions=org.intellij.qodana.projectDescriber)      |[QodanaProjectDescriber](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/projectDescription/QodanaProjectDescriber.kt) |
| [org.intellij.qodana.qodanaHighlightInfoComparator](https://jb.gg/ipe?extensions=org.intellij.qodana.qodanaHighlightInfoComparator)      |[QodanaHighlightInfoComparator](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/QodanaHighlightInfoComparator.kt) |
| [org.intellij.qodana.qodanaHighlightInfoTypeProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.qodanaHighlightInfoTypeProvider)      |[QodanaHighlightInfoTypeProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/QodanaHighlightInfoTypeProvider.kt) |
| [org.intellij.qodana.qodanaHighlightingSupportInfoProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.qodanaHighlightingSupportInfoProvider)      |[QodanaHighlightingSupportInfoProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/QodanaHighlightingSupportInfoProvider.kt) |
| [org.intellij.qodana.qodanaInspectionRetrievalLauncher](https://jb.gg/ipe?extensions=org.intellij.qodana.qodanaInspectionRetrievalLauncher)      |[QodanaInspectionRetrievalLauncher](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/QodanaInspectionRetrievalLauncher.kt) |
| [org.intellij.qodana.qodanaScriptFactory](https://jb.gg/ipe?extensions=org.intellij.qodana.qodanaScriptFactory)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[QodanaScriptFactory](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/script/QodanaScriptFactory.kt) |
| [org.intellij.qodana.qodanaYamlItemProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.qodanaYamlItemProvider)      |[QodanaYamlItemProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/settings/QodanaYamlItem.kt) |
| [org.intellij.qodana.quickFixesStrategyProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.quickFixesStrategyProvider)      |[QuickFixesStrategyProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/sarif/QuickFixesStrategyProvider.kt) |
| [org.intellij.qodana.reportMetadataArtifact](https://jb.gg/ipe?extensions=org.intellij.qodana.reportMetadataArtifact)      |[ReportMetadataArtifactProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/report/LoadedReport.kt) |
| [org.intellij.qodana.repositoryInfoProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.repositoryInfoProvider)      |[RepositoryInfoProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/RepositoryInfoProvider.kt) |
| [org.intellij.qodana.repositoryRevisionProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.repositoryRevisionProvider)      |[RepositoryRevisionProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/RepositoryRevisionProvider.kt) |
| [org.intellij.qodana.sarifReportContributor](https://jb.gg/ipe?extensions=org.intellij.qodana.sarifReportContributor)      |[SarifReportContributor](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/sarif/SarifReportContributor.kt) |
| [org.intellij.qodana.scopeExtender](https://jb.gg/ipe?extensions=org.intellij.qodana.scopeExtender)      |[InspectionToolScopeExtender](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/scopes/QodanaScopeExtenderProvider.kt) |
| [org.intellij.qodana.scopeExtenderProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.scopeExtenderProvider)      |[QodanaScopeExtenderProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/scopes/QodanaScopeExtenderProvider.kt) |
| [org.intellij.qodana.setupCIProviderFactory](https://jb.gg/ipe?extensions=org.intellij.qodana.setupCIProviderFactory)      |[SetupCIProviderFactory](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/ui/ci/SetupCIProvider.kt) |
| [org.intellij.qodana.vcsIgnoredFilesProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.vcsIgnoredFilesProvider)      |[VcsIgnoredFilesProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/extensions/VcsIgnoredFilesProvider.kt) |
| [org.intellij.qodana.vcsRevisionProvider](https://jb.gg/ipe?extensions=org.intellij.qodana.vcsRevisionProvider)      |[VcsRevisionProvider](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/vcs/VcsRevisionProvider.kt) |
| [org.intellij.qodana.workflowExtension](https://jb.gg/ipe?extensions=org.intellij.qodana.workflowExtension)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |[QodanaWorkflowExtension](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/qodana/core/src/org/jetbrains/qodana/staticAnalysis/workflow/QodanaWorkflowExtension.kt) |

## Serial Port Monitor Plugin

### Serial Port Monitor Plugin – Listeners

| Topic |Listener |
-------------------
| [SerialPortsListener.Companion#SERIAL_PORTS_TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.plugins.serialmonitor.service.SerialPortsListener) |[SerialPortsListener](https://github.com/JetBrains/intellij-plugins/tree/idea/261.26222.65/serial-monitor/src/main/java/com/intellij/plugins/serialmonitor/service/SerialPortsListener.kt) |

