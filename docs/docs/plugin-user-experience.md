# Plugin User Experience (UX)

User Experience (UX) is a term describing the experience users feel when using a product.
It covers not only aspects like visual presentation, performance, stability, or ease of use, but anything that affects the user's satisfaction.
It's an overall impression of using a product that strongly indicates whether a user likes it or not.

IntelliJ Platform-based plugins are products, and providing a good UX is very important for retaining users and making them recommend the plugin to others.
A bad plugin UX can negatively impact the user base, as users tend to abandon plugins that bring frustration, e.g., by instability, poor performance, or complexity.

The following sections explain the selected plugin UX areas.

## General Advice

Great IntelliJ Platform plugins, like any other products, should bring significant value to users.
When planning the work, talk to users and try to understand what they need the most and prioritize crucial functionalities.

If unsure about an implemented solution, consider sharing the work in progress with a limited group of users (e.g., colleagues or active community members) and gathering the feedback that will help improve the final result.
See the [Custom Release Channels](publishing-plugin.html#specifying-a-release-channel) section for information on how to automate sharing the pre-release plugin versions.

### Feedback

Gathering feedback on the existing features can help identify what works well and what should be improved, which also increases the overall plugin quality.

[Video](https://www.youtube.com/v/J3VEfTUX6Bs)
This session covers best practices for addressing feature requests, handling bug reports, navigating diverse communication styles, and fostering user engagement.

## Ease of Use

Plugins should be just easy to use.
Ideally, all the features should work out of the box after the installation, without any special user interactions, like manually enabling crucial plugin features.
Default settings should reflect the typical plugin usage in a standard project.

All the settings and actions should be easy to find and be placed in the proper [settings](settings.html) or [action group](grouping-actions-tutorial.html), e.g.:

* Framework plugin settings should be placed under the `Settings | Languages & Frameworks`

* Action marking a directory as a plugin-specific root type should be added to `Mark Directory as...` group

Plugins that are hard to configure with features that are hard to find may be quickly abandoned out of frustration.

## Stability

Plugins that throw a lot of errors visible in the messages panel and execute actions resulting in incorrect behavior, e.g., generating incorrect code, are considered unstable and unreliable.

To improve the overall stability and minimize the risk of introducing regression issues, it is critical to implement [functional tests](testing-plugins.html) with a low maintenance cost.
It is a great safety net, which in the long term, will speed up development and help release new versions without the fear of breaking existing plugin features.

It's nearly impossible to develop software without bugs, so it is recommended to set up an issue tracker where users can report errors.
In addition, it's worth implementing [error reporting](ide-infrastructure.html#error-reporting) that allows sending reports directly from within the IDE, with all required information attached.
To reproduce and understand problems in production, use [logging](ide-infrastructure.html#logging) consistently.

## Performance

Even if a plugin works correctly and looks pleasing, poor performance will impact user satisfaction.
Slow highlighting, code completion, code generation, and other features may break the user's workflow and cause frustration leading to plugin uninstallation.
Always try to follow the performance tips described on the relevant topic pages, e.g., [PSI Performance](psi-performance.html), [Avoiding UI Freezes](threading-model.html#avoiding-ui-freezes), [Improving Indexing Performance](indexing-and-psi-stubs.html#improving-indexing-performance).

Making as much functionality as possible working during [dumb mode](indexing-and-psi-stubs.html#dumb-mode) can also improve perceived performance.
For [split plugins](split-mode-and-remote-development.html), perceived performance also depends on where feature logic runs.
Tool windows, dialogs, editor interactions, and other latency-sensitive behavior should be designed for frontend and backend separation from the start.
See [Split Mode (Remote Development)](split-mode-and-remote-development.html) and [Implementing a Feature for Split Mode](split-mode-feature-development.html).

### Optimal UX in Split Mode

An IDE working in [Split Mode](split-mode-and-remote-development.html) has separate frontend and backend processes that likely work on physically different machines.

If a plugin is installed on the backend and provides interactive UI, the feature may still work, but every meaningful interaction crosses the frontend and backend boundary.
The result can be laggy tool windows, dialogs, popups, typing assistance, other editor reactions.

If a plugin is installed on the frontend and assumes direct access to project-local resources, it can end up working with the wrong machine or without the required backend state.
Typical problem areas include file system access, VFS events, PSI, indexes, project model, and external process execution.

The best UX usually comes from keeping UI and immediate interactions on the frontend, project-local and heavy logic on the backend, and exchanging only the required data between them.
See [Split Mode (Remote Development)](split-mode-and-remote-development.html) and [Implementing a Feature for Split Mode](split-mode-feature-development.html).

## Distribution Size

In addition to the plugin execution performance, it is recommended to optimize the size of the plugin distribution that is downloaded by users from JetBrains Marketplace.
Users with a poor internet connection may cancel the download when they realize that it will take too long to wait for a plugin they are not sure will meet their expectations.

Consider the following techniques for optimizing the plugin distribution size:

* Decrease the number of dependencies. Check if the target platform includes utilities (like those mentioned in [User Interface FAQ](ui-faq.html)) or [libraries](api-changes-list.html#bundled-library-updates) the plugin needs and reuse them.

* Make sure no unneeded or multiple versions of the same dependencies are packaged in the plugin distribution.

* Optimize assets like icons, images, videos, etc.

* If large resources (e.g., SDKs, reference documentation) are needed only in specific setups, consider downloading them by the plugin on-demand instead of bundling them in the plugin distribution.

[Obfuscation](https://plugins.jetbrains.com/docs/marketplace/obfuscate-the-plugin.html) may also help reduce the distribution file size.

## Consistent Behavior

When designing and implementing features, review existing functionalities of the IDE and plugins and design new features in a similar and consistent way.
A consistent approach will make it easier for users to work with the plugin, increasing overall satisfaction.

When implementing [custom language support](custom-language-support.html), review and consider implementing extension points from the [Additional Minor Features](additional-minor-features.html) list so that the plugin provides an experience consistent with other plugins.

## Consistent and Good-Looking UI

If a plugin UI significantly differs from the other application parts, it can feel alien to people and might be considered low quality or neglected.
Review and follow the rules described in the [UI Guidelines](ui-guidelines-welcome.html).
Pay attention to [icons](icons-style.html) and make them match the IDE style.
Use the UI controls recommended for a given use case.
Use [UI Inspector](internal-ui-inspector.html) to see how the existing UI is implemented.

## High-Quality Texts

Bad-quality labels or texts with typos and grammatical errors make a bad impression.
All the UI texts should follow the rules described in the Text section of the [UI Guidelines](ui-guidelines-welcome.html).
It is recommended to proofread the texts or use one of the [spellcheck plugins](https://plugins.jetbrains.com/search?tags=Spellcheck).

## Plugin Description and Presentation

The description on the plugin page is the place where users have the first contact with the plugin, and its content helps them to decide if it is what they are looking for. The description should be clear, polished, and follow the rules described in the JetBrains Marketplace [documentation](https://plugins.jetbrains.com/docs/marketplace/best-practices-for-listing.html#plugin-description).
See also this webinar about [5 tips for optimizing the JetBrains Marketplace plugin page](https://youtu.be/oB1GA9JeeiY?t=52).

## Providing Translations

[Translating](providing-translations.html) the plugin may improve the experience and increase the adoption of non-English speaking users, for example, in the dynamically growing Chinese market.
Even if translating is not planned in the nearest future, it is recommended to make the plugin ready for translation by following recommendations from the [Internationalization](internationalization.html) section.

