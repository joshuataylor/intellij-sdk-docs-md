# Spring API

Spring API allows third party plugins to re-use, integrate with, or extend existing Spring Framework support in IntelliJ IDEA.

Please see [Spring Framework Support](https://lp.jetbrains.com/intellij-idea-spring/) for a general feature overview.

A popular plugin using Spring API is [hybris integration](https://plugins.jetbrains.com/plugin/7525-hybris-integration).

To develop plugins, you will need to use IntelliJ IDEA.

## Setting up Project

Set up [Gradle](creating-plugin-project.html) to target [IntelliJ IDEA](idea.html), then [add dependency](plugin-dependencies.html) to the bundled Spring plugin with ID `com.intellij.spring`.

Please use only Spring-related functionality exposed in `spring-api.jar` (sources are provided in `$IDEA_HOME$/lib/src/src_spring-boot-openapi.zip`) in your plugin.
Using any other "internal" (implementation) classes from the Spring plugin itself (`spring.jar`) is not supported.

### plugin.xml

Add `<depends>com.intellij.spring</depends>` to your `[plugin.xml](plugin-configuration-file.html)` to require the "Spring Support" plugin to be activated.
All available extension points are provided under the `com.intellij.spring` prefix.
Note that the "Spring Support" plugin itself has dependencies on a few other plugins which need to be enabled in your sandbox (see notifications on startup).

## Main Concepts

A Spring facet can be attached to a Module.
Nearly all Spring functionality requires an existing and correct setup Spring facet.

Spring facets usually contain one more user-configured or automatically provided filesets, which group a set of Spring-related configuration files (XML, Code, .properties, or other configuration files).

A fileset usually corresponds to an actual application context configuration at runtime.
Hierarchies can be modeled by depending on another fileset (possibly from another module).

As an API user, you will usually prefer working with `SpringModel`, which is built on top of fileset(s).

## API Updates

Note:

2017.3: `LocalXmlModel#setActiveProfiles` & `LocalAnnotationModel#setActiveProfiles` have been deprecated and will be removed in 2018.1.

Note:

Starting with 2016.2, the internal representation of bean type has been changed from `PsiClass` to `PsiType`, please note deprecations.

Note:

Some core classes have been changed in 14(.1); please see "Version 14(.1)" notes for info on how to replace existing API calls.

## How Do I...

Note:

See [Spring API Extension Point and Listener List](spring-extension-point-list.html) for the complete list.

### Spring Setup

To check the availability of Spring/Spring Facet, see `com.intellij.spring.model.utils.SpringCommonUtils`.

2016.2 See `com.intellij.spring.SpringLibraryUtil` to obtain information about the exact version of Spring in use.

### Spring Model

#### Obtain Spring Model by a File, PSI Element, ...

See `SpringManager#getSpringModel(s)...` and `com.intellij.spring.model.utils.SpringModelUtils`.

#### Contribute Implicit Model

See `com.intellij.spring.SpringModelProvider` to provide implicit filesets (e.g., provided by another framework in a specific configuration file).

Version 15
See `com.intellij.spring.facet.SpringAutodetectedFileSet` for a convenient base class.
Please note that auto-detected filesets cannot be edited/modified by users in Spring facet.

#### Customize Implicit Models Configuration

2017.1 See `com.intellij.spring.facet.SpringFileSetEditorCustomization` to customize presentation and/or add extra settings/actions for specific auto-detected filesets.

#### Contribute Implicit Beans

See `com.intellij.spring.model.jam.CustomComponentsDiscoverer` or `com.intellij.spring.model.SpringImplicitBeansProviderBase` to provide implicit (framework-specific) beans (e.g. "servletContext" by Spring MVC).

Version 15
`CustomComponentsDiscoverer` has been split into `com.intellij.spring.model.custom.CustomLocalComponentsDiscoverer` and `com.intellij.spring.model.custom.CustomModuleComponentsDiscoverer` respectively.

#### Contribute Custom Bean Scope

Version 14
See `com.intellij.spring.model.scope.SpringCustomBeanScope` to provide custom (e.g. framework specific) bean scopes.

#### Obtain/Create Spring Profiles

Version 14.1
`com.intellij.spring.profiles.SpringProfilesFactory`

### Beans

#### Search for Bean by Name

`com.intellij.spring.CommonSpringModel#findBeanByName`

Version 14: `com.intellij.spring.model.utils.SpringModelSearchers#findBean`

#### Search for Beans by Type

Choose one of `com.intellij.spring.CommonSpringModel#findBeansByPsiClassXXX` variants (please note deprecated methods).

Version 14: `com.intellij.spring.model.utils.SpringModelSearchers#findBeans`

Version 16: note deprecation of `SpringModelSearchParameters.BeanClass#withInheritors(GlobalSearchScope)`

#### Check If a Bean with Given Name/Type Exists

Version 14: `com.intellij.spring.model.utils.SpringModelSearchers#doesBeanExist` (please note deprecated methods)

#### Mark Bean as Infrastructure Bean

Version 14: implement `SpringInfrastructureBean`, such beans obtain a special icon and can be filtered in various places in UI.

### XML Configuration

All support for XML-based Spring configuration files is provided via [DOM-API](xml-dom-api.html).

#### Add Support for Additional Spring Namespace

See [com.intellij.spring.customNamespaces](https://jb.gg/ipe?extensions=com.intellij.spring.customNamespaces) extension point
, the registered namespace-key must match the one registered with your DOM elements via `@Namespace`.
Register available elements via standard `DomExtender<Beans>` EP or `com.intellij.spring.dom.SpringCustomNamespaces#registerExtensions` (Version 14).

Please pay attention to `getModelVersion` and `getStubVersion` (see Javadoc).

#### Add Reference to Spring Bean in DOM Element

Use the following template:

```JAVA
@Convert(SpringBeanResolveConverter.class)
@RequiredBeanType("fqn.to.required.class") // optional
GenericAttributeValue<SpringBeanPointer> getMyAttributeName();
```

### Code Configuration

#### Add Reference to Spring Bean in JAM Element

Version 14

```JAVA
JamStringAttributeMeta.Single<SpringBeanPointer> ATTRIBUTE_META =
    JamAttributeMeta.singleString("attributeName",
        new SpringBeanReferenceJamConverter("fqn.to.required.class"));
```

#### @AliasFor

Version 16
See `com.intellij.spring.model.aliasFor.SpringAliasForUtils` to obtain corresponding `@AliasFor` JAM.

### spring.factories

Version 15
See `com.intellij.spring.spi.SpringSpiManager`.

### IDE Features

#### Add Inspections to Spring Validator

Add additional inspections (e.g., for custom namespace) to Spring Validator (Settings|Compiler|Validation) via `com.intellij.spring.SpringInspectionsRegistry$Contributor`
in [com.intellij.spring.inspectionsRegistryContributor](https://jb.gg/ipe?extensions=com.intellij.spring.inspectionsRegistryContributor) extension point
.

#### Add Additional Files to Spring Validator

Version 14.1
Additional files to be processed by inspections registered with Spring Validator (e.g., specific `.properties` configuration files) can be registered via `com.intellij.spring.SpringInspectionsRegistry$AdditionalFilesContributor`

#### Configure Spring Support for Other Frameworks

Use `com.intellij.spring.facet.SpringConfigurator` to provide "automatic" configuration when Spring facet is added via the framework wizard.

#### UI/Presentation

Please do not reference bean icons from `SpringApiIcons` directly, but use `SpringPresentationProvider` to re-use the unified icon/bean name.
See `SpringBeansPsiElementCellRenderer` as a popup/list renderer.

## Spring Boot

2018.1

Spring Boot API allows extending/accessing Spring Boot-specific support in the IDE.

Warning:

While we try to maintain compatibility, please be prepared for a less strict policy.

### Setting Up

[Add dependency](plugin-dependencies.html) to the bundled Spring Boot plugin with ID `com.intellij.spring.boot`.
Sources for Spring Boot API are available in `$IDEA_HOME$/lib/src/src_spring-boot-openapi.zip`.

### Update plugin.xml

Add `<depends>com.intellij.spring.boot</depends>` to your `[plugin.xml](plugin-configuration-file.html)` to require the "Spring Boot" plugin to be activated.
All available extension points are provided under the `com.intellij.spring.boot` prefix.

### Spring Boot Library

Use `com.intellij.spring.boot.library.SpringBootLibraryUtil` to query the version and availability of common additional libraries.

### Custom Configuration Files Format

`com.intellij.spring.boot.model.SpringBootModelConfigFileContributor` allows adding support for custom config file formats.

### Auto-Configuration Support

Existing `Condition` implementations can be simulated at design time in IDE via `com.intellij.spring.boot.model.autoconfigure.conditions.ConditionalContributor`.

Custom `@ConditionalOn...` annotations implementing `com.intellij.spring.boot.model.autoconfigure.conditions.jam.ConditionalOnJamElement` will be added into evaluation automatically.

### Spring Initializr

`com.intellij.spring.boot.initializr.SpringInitializrModuleBuilderPostTask` allows performing custom setup steps after creation of the module (e.g., setup integration with a build system).

### Endpoint Tab

Use [com.intellij.spring.boot.run.endpoint](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.endpoint) extension point
to add custom actuator endpoint tabs.
Any settings should be exposed in the "Spring Boot" settings tab via [com.intellij.spring.boot.run.endpointTabConfigurable](https://jb.gg/ipe?extensions=com.intellij.spring.boot.run.endpointTabConfigurable) extension point
.

