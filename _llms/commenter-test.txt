# 9. Commenter Test

<tldr>
Tested Functionality: [18. Commenter](commenter.html)
</tldr>

Tip:

This page is part of multistep [Testing a Custom Language Plugin](writing-tests-for-plugins.html) tutorial.

## Define a Test Method

Add the `testCommenter()` method to the `SimpleCodeInsightTest` class [previously defined](completion-test.html#define-a-test).
This test constructs a Simple Language properties file containing one line, with the virtual caret positioned at the beginning of the line.
The test calls the commenter to insert a comment character at the caret, then verifies the results.
It again calls the line comment action to remove the comment character and verifies the results.

```JAVA
public void testCommenter() {
  myFixture.configureByText(SimpleFileType.INSTANCE, "<caret>website = https://en.wikipedia.org/");
  CommentByLineCommentAction commentAction = new CommentByLineCommentAction();
  commentAction.actionPerformedImpl(getProject(), myFixture.getEditor());
  myFixture.checkResult("#website = https://en.wikipedia.org/");
  commentAction.actionPerformedImpl(getProject(), myFixture.getEditor());
  myFixture.checkResult("website = https://en.wikipedia.org/");
}
```

## Run the Test

Run the test and make sure it's successful.

Procedure: Running tests

