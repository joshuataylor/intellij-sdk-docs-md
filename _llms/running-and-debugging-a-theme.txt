# Running and Debugging a Theme

In most cases, the results of theme plugin can be previewed by running the Preview Theme action in the [theme description file](themes-customize.html) editor.
Sometimes, when more advanced styling options are implemented, the previewing theme may not be enough to see all the changes.
This page explains how to run or debug the theme plugin in the IDE configured as a part of [project SDK](setting-up-theme-environment.html).

## Create Plugin Run Configuration

To run and debug a plugin directly from a theme plugin project, a Plugin run configuration must be added.

Tip:

For more information about creating Run Configurations, refer to the [Run/Debug Configuration](https://www.jetbrains.com/help/idea/run-debug-configuration.html) section in IntelliJ IDEA Web Help.

Procedure: Add Plugin Run Configuration

See the [IDE Development Instance](ide-development-instance.html) section for information about advanced run configuration settings.
If additional settings, like system property, are needed, see [Run/Debug Configuration: Plugin](https://www.jetbrains.com/idea/help/run-debug-configuration-plugin.html) explaining how to configure them.

## Run/Debug Theme Plugin

To run the theme in the IDE development instance, choose `Run | Run...` and select the created run configuration.
Debugging a theme is similar, but instead of Run..., select the Debug... action.

