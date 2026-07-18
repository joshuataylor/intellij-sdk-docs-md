# 1. Tests Prerequisites

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

This page discusses the steps to configure a plugin project for creating tests.

## Create a Folder for Tests

Open the plugin project and create a separate folder named `test` under the `src` directory.
Under `test`, create the `java` folder for test source code, and the folder `testData` for [test data files](test-project-and-testdata-directories.html) and reimport the Gradle project.

```PLANTUML
@startuml

skinparam TitleFontName JetBrains Sans
skinparam TitleFontStyle plain
skinparam TitleFontSize 16
skinparam DefaultTextAlignment left

title
  src
  |_ main
    |_ java
    |_ resources
  |_ test
    |_ java
    |_ testData
end title
@enduml
```

## Set the Run Configuration Parameters

Because some tests use Java files as test data, the tests need to mock up the project's SDK.
See the [How to test a JVM language?](testing-faq.html#how-to-test-a-jvm-language) section for details.

