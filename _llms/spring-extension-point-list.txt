# Spring API Extension Point and Listener List

<tldr>
Product-Specific Plugin Development: [Spring API](spring-api.html)

See Also: [Extensions](plugin-extensions.html), [Listeners](plugin-listeners.html)
</tldr>

Tip:

See [IntelliJ Platform Extension Point and Listener List](intellij-platform-extension-point-list.html) for IntelliJ Platform.

Note:

Spring API Extension Points and Listeners are available in the Spring-related plugins,
which are available in [IntelliJ IDEA Plugin Development](idea.html).

66 Extension Points and 6 Listeners

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

## Spring

### Spring – Listeners

| Topic |Listener |
-------------------
| [SpringFileSetService#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.spring.facet.SpringFileSetService.SpringFileSetListener) |`SpringFileSetListener` |
| [SpringBeansViewSettings#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.spring.toolWindow.SpringBeansViewSettings.Listener) |`Listener` |

### intellij.spring.core.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.autodetected.filesets](https://jb.gg/ipe?extensions=com.intellij.spring.autodetected.filesets)      |`SpringAutodetectedFilesetsSearcher` |
| [com.intellij.spring.autodetected.models](https://jb.gg/ipe?extensions=com.intellij.spring.autodetected.models)      |`SpringAutodetectedModelsSearcher` |
| [com.intellij.spring.beanClassLineMarker](https://jb.gg/ipe?extensions=com.intellij.spring.beanClassLineMarker)      |`BeanClassLineMarker` |
| [com.intellij.spring.beans.stereotype](https://jb.gg/ipe?extensions=com.intellij.spring.beans.stereotype)      |`SpringBeanStereotype` |
| [com.intellij.spring.classAccessInfoProvider](https://jb.gg/ipe?extensions=com.intellij.spring.classAccessInfoProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`SpringClassAccessInfoProvider` |
| [com.intellij.spring.componentScanExtender](https://jb.gg/ipe?extensions=com.intellij.spring.componentScanExtender)      |`ComponentScanExtender` |
| [com.intellij.spring.conditionalEvaluatorProvider](https://jb.gg/ipe?extensions=com.intellij.spring.conditionalEvaluatorProvider)      |`ConditionalEvaluatorProvider` |
| [com.intellij.spring.configSearcherScopeModifier](https://jb.gg/ipe?extensions=com.intellij.spring.configSearcherScopeModifier)      |`ConfigSearcherScopeModifier` |
| [com.intellij.spring.configurator](https://jb.gg/ipe?extensions=com.intellij.spring.configurator)      |`SpringConfigurator` |
| [com.intellij.spring.customBeanScope](https://jb.gg/ipe?extensions=com.intellij.spring.customBeanScope)      |`SpringCustomBeanScope` |
| [com.intellij.spring.customConverterProvider](https://jb.gg/ipe?extensions=com.intellij.spring.customConverterProvider)      |`Provider` |
| [com.intellij.spring.customLocalComponentsDiscoverer](https://jb.gg/ipe?extensions=com.intellij.spring.customLocalComponentsDiscoverer)      |`CustomLocalComponentsDiscoverer` |
| [com.intellij.spring.customModuleComponentsDiscoverer](https://jb.gg/ipe?extensions=com.intellij.spring.customModuleComponentsDiscoverer)      |`CustomModuleComponentsDiscoverer` |
| [com.intellij.spring.customNamespaces](https://jb.gg/ipe?extensions=com.intellij.spring.customNamespaces)      |`SpringCustomNamespaces` |
| [com.intellij.spring.effective.types.provider](https://jb.gg/ipe?extensions=com.intellij.spring.effective.types.provider)      |`SpringBeanEffectiveTypeProvider` |
| [com.intellij.spring.factoryMethodTypeHandler](https://jb.gg/ipe?extensions=com.intellij.spring.factoryMethodTypeHandler)      |`CustomFactoryMethodTypeHandler` |
| [com.intellij.spring.fileSetEditorCustomization](https://jb.gg/ipe?extensions=com.intellij.spring.fileSetEditorCustomization)      |`SpringFileSetEditorCustomization` |
| [com.intellij.spring.inspectionsRegistryAdditionalFilesContributor](https://jb.gg/ipe?extensions=com.intellij.spring.inspectionsRegistryAdditionalFilesContributor)      |`AdditionalFilesContributor` |
| [com.intellij.spring.inspectionsRegistryContributor](https://jb.gg/ipe?extensions=com.intellij.spring.inspectionsRegistryContributor)      |`Contributor` |
| [com.intellij.spring.jam.customMetaImplementation](https://jb.gg/ipe?extensions=com.intellij.spring.jam.customMetaImplementation)      |`n/a` |
| [com.intellij.spring.localAnnotationModelDependentModelsProvider](https://jb.gg/ipe?extensions=com.intellij.spring.localAnnotationModelDependentModelsProvider)      |`LocalAnnotationModelDependentModelsProvider` |
| [com.intellij.spring.localModelProducer](https://jb.gg/ipe?extensions=com.intellij.spring.localModelProducer)      |`SpringLocalModelProducer` |
| [com.intellij.spring.placeholderReferenceResolver](https://jb.gg/ipe?extensions=com.intellij.spring.placeholderReferenceResolver)      |`SpringPlaceholderReferenceResolver` |
| [com.intellij.spring.resourceTypeProvider](https://jb.gg/ipe?extensions=com.intellij.spring.resourceTypeProvider)      |`SpringResourceTypeProvider` |
| [com.intellij.spring.scriptBeanPsiClassDiscoverer](https://jb.gg/ipe?extensions=com.intellij.spring.scriptBeanPsiClassDiscoverer)      |`ScriptBeanPsiClassDiscoverer` |
| [com.intellij.spring.settingsProvider](https://jb.gg/ipe?extensions=com.intellij.spring.settingsProvider)      |`SpringSettingsProvider` |
| [com.intellij.spring.springComponentContainerProvider](https://jb.gg/ipe?extensions=com.intellij.spring.springComponentContainerProvider)      |`SpringComponentContainerProvider` |
| [com.intellij.spring.springDataSourceInfoProvider](https://jb.gg/ipe?extensions=com.intellij.spring.springDataSourceInfoProvider)      |`SpringDataSourceInfoProvider` |
| [com.intellij.spring.springTemplateProvider](https://jb.gg/ipe?extensions=com.intellij.spring.springTemplateProvider)      |`SpringTemplateProvider` |
| [com.intellij.spring.testingAnnotationsProvider](https://jb.gg/ipe?extensions=com.intellij.spring.testingAnnotationsProvider)      |`SpringTestingAnnotationsProvider` |
| [com.intellij.spring.testingImplicitContextsProvider](https://jb.gg/ipe?extensions=com.intellij.spring.testingImplicitContextsProvider)      |`SpringTestingImplicitContextsProvider` |
| [com.intellij.spring.valueConverter](https://jb.gg/ipe?extensions=com.intellij.spring.valueConverter)      |`SpringValueConvertersProvider` |

### intellij.spring.el.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.el.contexts](https://jb.gg/ipe?extensions=com.intellij.spring.el.contexts)      |`SpringElContextsExtension` |
| [com.intellij.spring.el.injection.context](https://jb.gg/ipe?extensions=com.intellij.spring.el.injection.context)      |`SpringElInjectionContext` |

### intellij.spring.graph.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.gutterDiagramActionProvider](https://jb.gg/ipe?extensions=com.intellij.spring.gutterDiagramActionProvider)      |`SpringGutterDiagramActionProvider` |

## Spring Boot Plugin

### Spring Boot Plugin – Listeners

| Topic |Listener |
-------------------
| [SpringBootEndpointsTabSettings#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.spring.boot.run.lifecycle.tabs.SpringBootEndpointsTabSettings.Listener) |`Listener` |

### intellij.spring.boot.core.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.boot.configFileDetector](https://jb.gg/ipe?extensions=com.intellij.spring.boot.configFileDetector)      |`SpringBootConfigFileDetector` |
| [com.intellij.spring.boot.configUnresolvedClassReferenceFixesProvider](https://jb.gg/ipe?extensions=com.intellij.spring.boot.configUnresolvedClassReferenceFixesProvider)      |`SpringBootConfigUnresolvedClassReferenceFixesProvider` |
| [com.intellij.spring.boot.customHintReferenceProvider](https://jb.gg/ipe?extensions=com.intellij.spring.boot.customHintReferenceProvider)      |`SpringBootCustomHintReferenceProvider` |
| [com.intellij.spring.boot.importsManager](https://jb.gg/ipe?extensions=com.intellij.spring.boot.importsManager)      |`SpringBootImportsManager` |
| [com.intellij.spring.boot.languageSpecificBridge](https://jb.gg/ipe?extensions=com.intellij.spring.boot.languageSpecificBridge)      |`SpringBootLanguageSpecificBridge` |
| [com.intellij.spring.boot.modelConditionalContributor](https://jb.gg/ipe?extensions=com.intellij.spring.boot.modelConditionalContributor)      |`ConditionalContributor` |
| [com.intellij.spring.boot.modelConfigFileContributor](https://jb.gg/ipe?extensions=com.intellij.spring.boot.modelConfigFileContributor)      |`SpringBootModelConfigFileContributor` |
| [com.intellij.spring.boot.modelConfigFileNameContributor](https://jb.gg/ipe?extensions=com.intellij.spring.boot.modelConfigFileNameContributor)      |`SpringBootModelConfigFileNameContributor` |
| [com.intellij.spring.boot.modelExtender](https://jb.gg/ipe?extensions=com.intellij.spring.boot.modelExtender)      |`SpringBootModelExtender` |
| [com.intellij.spring.boot.replacementTokenResolver](https://jb.gg/ipe?extensions=com.intellij.spring.boot.replacementTokenResolver)      |`SpringBootReplacementTokenResolver` |

### intellij.spring.boot.mvc.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.boot.mvc.templateAvailabilityProvider](https://jb.gg/ipe?extensions=com.intellij.spring.boot.mvc.templateAvailabilityProvider)      |`TemplateAvailabilityProvider` |

### intellij.spring.boot.run.shared.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.boot.run.configuration](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.configuration)      |`SpringBootConfigurationExtenderProducer` |
| [com.intellij.spring.boot.run.mainClassInfoProvider](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.mainClassInfoProvider)      |`SpringBootMainClassInfoProvider` |

### intellij.spring.boot.run.xml

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.boot.run.applicationUpdatePolicy](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.applicationUpdatePolicy)      |`SpringBootApplicationUpdatePolicy` |
| [com.intellij.spring.boot.run.applicationUrlPathProviderFactory](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.applicationUrlPathProviderFactory)      |`SpringBootApplicationUrlPathProviderFactory` |
| [com.intellij.spring.boot.run.endpoint](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.endpoint)      ![Experimental](https://img.shields.io/badge/-Experimental-violet?style=flat-square) |`Endpoint` |
| [com.intellij.spring.boot.run.endpointTabConfigurable](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.endpointTabConfigurable)      ![Project-Level](https://img.shields.io/badge/-Project--Level-blue?style=flat-square) |`EndpointTabConfigurable` |
| [com.intellij.spring.boot.run.liveBeansPanelContent](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.liveBeansPanelContent)      |`LiveBeansPanelContent` |
| [com.intellij.spring.boot.run.runtimeApplicationProvider](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.runtimeApplicationProvider)      |`SpringBootRuntimeApplicationProvider` |

## Spring Data Plugin

### Spring Data Plugin – Listeners

| Topic |Listener |
-------------------
| [SpringRepositoriesViewSettings#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.spring.data.commons.view.SpringRepositoriesViewSettings.Listener) |`Listener` |

## Spring Debugger Plugin

### Spring Debugger Plugin – Listeners

| Topic |Listener |
-------------------
| [SpringDebugModelListener.Companion#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.spring.debugger.model.SpringDebugModelListener) |`SpringDebugModelListener` |

### com.intellij.spring.debugger

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.debugger.configCodeVisionProvider](https://jb.gg/ipe?extensions=com.intellij.spring.debugger.configCodeVisionProvider)      ![Internal](https://img.shields.io/badge/-Internal-darkred?style=flat-square) |`SpringConfigFileCodeVisionInfoProvider` |
| [com.intellij.spring.debugger.runConfigurationExtender](https://jb.gg/ipe?extensions=com.intellij.spring.debugger.runConfigurationExtender)      |`SpringDebuggerRunConfigurationExtender` |
| [com.intellij.spring.debugger.sessionListener](https://jb.gg/ipe?extensions=com.intellij.spring.debugger.sessionListener)      |`SpringDebuggerSessionListener` |

## Spring GraphQL Plugin

### com.intellij.spring.graphql

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.graphql.appPathProvider](https://jb.gg/ipe?extensions=com.intellij.spring.graphql.appPathProvider)      |`GraphQLApplicationPathProvider` |

## Spring Messaging Plugin

### com.intellij.spring.messaging

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.messaging.urlProvider](https://jb.gg/ipe?extensions=com.intellij.spring.messaging.urlProvider)      |`SpringMessagingUrlProvider` |

## Spring Security Plugin

### com.intellij.spring.security

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.security.rolesProvider](https://jb.gg/ipe?extensions=com.intellij.spring.security.rolesProvider)      |`SpringSecurityRolesProvider` |

## Spring Web Plugin

### Spring Web Plugin – Listeners

| Topic |Listener |
-------------------
| [SpringMvcViewSettings#TOPIC](https://jb.gg/ipe/listeners?topics=com.intellij.spring.mvc.toolwindow.SpringMvcViewSettings.Listener) |`Listener` |

### com.intellij.spring.mvc

| Extension Point |Implementation |
-----------------------------------
| [com.intellij.spring.mvc.apiversioning.support](https://jb.gg/ipe?extensions=com.intellij.spring.mvc.apiversioning.support)      |`SpringWebApiVersioningSupport` |
| [com.intellij.spring.mvc.applicationPathProvider](https://jb.gg/ipe?extensions=com.intellij.spring.mvc.applicationPathProvider)      |`SpringApplicationPathProvider` |
| [com.intellij.spring.mvc.completion.controllerParamTypeProvider](https://jb.gg/ipe?extensions=com.intellij.spring.mvc.completion.controllerParamTypeProvider)      |`ControllerParameterProvider` |
| [com.intellij.spring.mvc.mergingMvcRequestMappingLineMarkerProvider](https://jb.gg/ipe?extensions=com.intellij.spring.mvc.mergingMvcRequestMappingLineMarkerProvider)      |`SpringMergingMvcRequestMappingLineMarkerProvider` |
| [com.intellij.spring.mvc.springEndpointsIconProvider](https://jb.gg/ipe?extensions=com.intellij.spring.mvc.springEndpointsIconProvider)      |`SpringEndpointsIconProvider` |
| [com.intellij.spring.mvc.viewResolverFactory](https://jb.gg/ipe?extensions=com.intellij.spring.mvc.viewResolverFactory)      |`ViewResolverFactory` |

