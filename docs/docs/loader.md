# Loader

<tldr>
Implementation: [AnimatedIcon.Default](https://github.com/JetBrains/intellij-community/tree/idea/262.10968.63/platform/ide-core/src/com/intellij/ui/AnimatedIcon.java)

Related: [Animated Icons](icons.html#animated-icons)
</tldr>

A loader informs users about performing a lengthy operation.

![Loader](images/loader.png)

## When to use

Follow the rules for [progress indicators](progress-indicators.html).

## How to use

The loader form and sizes are the same in all themes. Use the default 16×16 loader in all cases.

Kotlin:

```KOTLIN
JLabel(
    "Loading...",
    AnimatedIcon.Default(),
    SwingConstants.LEFT
)
```

Java:

```JAVA
new JLabel(
    "Loading...",
    new AnimatedIcon.Default(),
    SwingConstants.LEFT
);
```

A loader may have a label if the process is long and the loader is shown in an empty area. In this case, use a [progress text](progress-text.html) as the label:

![Loader with progress text](images/loader_with_progress_text.png)
Remove the loader as soon as the process completes.

## Placement

|  Inside a field  | ![Placement field](images/placement_field.png)  |
|           ```JAVA ExpandableTextField textField = new ExpandableTextField(); textField.addExtension(   Extension.create(new AnimatedIcon.Default(), null, null) ); ```        |
| In a corner | ![Placement corner](images/placement_corner.png)      |
|   Next to an item  | ![Placement item](images/placement_item.png)  |
|  Before a progress text  | ![Placement progress text](images/placement_progress_text.png)      |

