# Required Experience

The IntelliJ Platform is a JVM application, implemented mostly in [Java](https://www.oracle.com/java/) and [Kotlin](https://kotlinlang.org).
At this time, it's not possible to develop plugins for the IntelliJ Platform in non-JVM languages).

Note: Plugin Alternatives

In some cases, implementing an actual IntelliJ Platform plugin might not be necessary, as [alternative solutions](plugin-alternatives.html) exist.

Developing a plugin for the IntelliJ Platform requires knowledge and experience with the following technologies and concepts:

* Java, Kotlin, or any other JVM language, and its standard and third-party libraries

* [Gradle](https://gradle.org/) or a similar build system (for example, Maven)

* [Swing](https://en.wikipedia.org/wiki/Swing_(Java)) for building user interfaces

* [Java Concurrency Model](https://docs.oracle.com/javase/tutorial/essential/concurrency/index.html)

* experience with IntelliJ Platform-based IDE (for example, [IntelliJ IDEA](https://www.jetbrains.com/idea/))

Keep in mind that the IntelliJ Platform is a large project, and while we are doing our best to cover as many topics as possible,
it is not possible to include every feature and use-case in the documentation.
Developing a plugin will sometimes require digging into the [IntelliJ Platform code](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/README.md)
and analyzing the [example implementations in other plugins](https://jb.gg/ipe).

Tip:

It is highly recommended to get familiar with the [Explore the IntelliJ Platform API](explore-api.html) section before starting with the plugin implementation.

