# 8. Find Usages Test

<tldr>
Tested Functionality: [11. Find Usages Provider](find-usages-provider.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

## Define the Test Data

Create the `FindUsagesTestData.simple` file in the `testData` directory.

```PROPERTIES
# You are reading the ".properties" entry.
! The exclamation mark can also mark text as comments.
website = https://en.wikipedia.org/

language = English
# The backslash below tells the application to continue reading
# the value onto the next line.
message = Welcome to \
          Wikipedia!
# Add spaces to the key
<caret>key\ with\ spaces = This is the value that could be looked up with the key "key with spaces".
# Unicode
tab : \u0009
```

Create the test file `FindUsagesTestData.java`, which contains one embedded Simple Language prefix and key.

```JAVA
public class Test {
  public static void main(String[] args) {
    System.out.println("simple:key with spaces");
  }
}
```

## Define a Test Method

Add the `testFindUsages()` method to the `SimpleCodeInsightTest` class [previously defined](completion-test.html#define-a-test).
This test verifies the find usage functionality will identify the "key with spaces".

```JAVA
public void testFindUsages() {
  Collection<UsageInfo> usageInfos = myFixture.testFindUsages("FindUsagesTestData.simple", "FindUsagesTestData.java");
  assertEquals(1, usageInfos.size());
}
```

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

