# Icons

Follow these guidelines to create a new icon or redesign an existing one for IntelliJ-based products.

Note:

See all icons in the [Icons list](https://intellij-icons.jetbrains.design).
Use the [IntelliJ Icons Figma plugin](ui-kit.html)
to quickly find and use icons in UI mockups.

## Style

A common style unites several icons into a set and makes them recognizable.

Use a flat geometric icon style with straight corners and edges. Flat icons remain legible even in small sizes.

Use flat shapes instead of complex 3D forms:

| Incorrect |Correct |
----------------------
| ![Style pin 3d](images/style_pin_3d.png) |![Style pin flat](images/style_pin_flat.png) |

Use straight corners and lines instead of curves. It’s recommended to use 45° and 90° angles, or 30° and 60° where possible:

| Incorrect |Correct |
----------------------
| ![Style folder round](images/style_folder_round.png) |![Style folder straigt](images/style_folder_straigt.png) |

Icons should be as simple as possible without losing their meaning. Clean and simple icons ensure readability and reduce visual clutter.

|  Incorrect  | Correct  |
--------------------------
|  ![Style soft wrap detailed](images/style_soft_wrap_detailed.png)  | ![Style soft wrap simple](images/style_soft_wrap_simple.png)  |
| Reduced the icon to its minimal form, without losing its meaning. |

## Grid and size

Basically, icons fit into a square artboard. Leave a transparent padding around the perimeter. For default 16px icons, the transparent border is 1px, so the icon’s visible part should be inside the 14px x 14px area.

![Grid](images/grid.png)
14px x 14px is the area where the visible part of the icon should fit for a 16px icon.

Content should only go beyond the borders if a [modifier](#modifier) is added, or if additional visual weight is required.

Sizes for other icon sizes can be found in the table below:

|  Icon Type  | Icons Size  | Transparent Border  |
---------------------------------------------------
|  Gutter, status bar  | 12px x 12px  | —  |
|  Tool window  | 13px x 13px  | —  |
|  Default: toolbar icons, project tree, etc.  | 16px x 16px  | 1px, except for modifier  |
|  Dialogs  | 32px x 32px  | 2px  |
|  Logo app icon  |          32px x 32px            64px x 64px            128px x 128px            256px x 256px            512px x 512px        | —  |

## Basic shapes

Use basic shapes to build icons, such as squares, circles and rectangles. Using a grid and basic shapes ensures consistent visual proportions and placement.

| ![Shape square](images/shape_square.png) Square 12px x 12px |![Shape circle](images/shape_circle.png) Circle 14px |
| ![Shape rect horizontal](images/shape_rect_horizontal.png) Horizontal rectangle 10px x 14px |![Shape rect vertical](images/shape_rect_vertical.png) Vertical rectangle 14px x 10px |

Make sure that icons have the same visual weight. The more filled an icon is, the less space it needs. Following this rule, circles, rhombuses, triangles and other non-square shapes should have larger height and width to be optically balanced with square figures.

![Shapes weight 1](images/shapes_weight_1.png)
Make the circle diameter 2px bigger than square icons’ height to compensate for the visual weight.

Icons with more details should occupy more space.

![Shapes weight 2](images/shapes_weight_2.png)
The eye icon is less detailed and occupies less space than a more complex scissors icon.

Icon weight can often take priority over the basic shape sizing. For more examples on visual weight compensation, see [Optical Effects in User Interfaces](https://medium.muz.li/optical-effects-9fca82b4cd9a).

## Stroke

Use a 2px stroke as the main drawing line. Consistent line weight makes icons cohesive.

|  ![Stroke download](images/stroke_download.png) | ![Stroke calc](images/stroke_calc.png) |
| Use consistent stroke width. |A thinner stroke can be used for subtle tweaks to the legibility of an icon and for optical correction. |

Align pixels on the X and Y axis and round to the nearest whole pixel, or 0.5px if it’s not possible to align to integer pixels. Aligning icons off the pixel grid will make the icon blurry when it’s rasterized.

Note:

To check what an icon will look like when rasterized use the `View | Canvas | Show Pixels on Zoom` option `Ctrl+P` in Sketch,
`View | Pixel Preview` `Alt+Ctrl+Y` in Illustrator.

| Incorrect |Correct |
----------------------
| ![Stroke pixels incorrect](images/stroke_pixels_incorrect.png)           If an icon is positioned off pixels,   it becomes blurry when rasterized.  |![Stroke pixels correct](images/stroke_pixels_correct.png)           Position stokes on integer pixels where possible.  |

Use the 30°, 45° and 60° angles for diagonal lines as they look sharper than diagonals with other angles.

Round shapes, small details and some letters cannot be aligned to the pixel grid. Make sure that the significant pixels have sufficient saturation.

Reduce the number of anchors as they increase the size of the image and takes longer to process it.

| Incorrect |Correct |
----------------------
| ![Stroke anchors incorrect](images/stroke_anchors_incorrect.png)           Unneeded anchors are added.  |![Stroke anchors correct](images/stroke_anchors_correct.png)           Use the minimum number of anchors.  |

## Modifier

A modifier is a small shape added over the base icon.

The default modifier position is the bottom right corner. If the base shape is badly recognizable with a modifier in the bottom right corner, or if several modifiers are needed, the modifier can be placed in other corners.

|  ![Modifier search](images/modifier_search.png)             Place the modifier in the left corner   if the base shape is badly recognizable   with the modifier in the right corner.  | ![Modifier parameter](images/modifier_parameter.png)             Place the modifier in the left corner   if there are several modifiers.  |

A modifier size is from 6px to 9px, depending on the shape's weight.
Leave a 1-2px spacing between the modifier and the main shape, to make the modifier clearly visible.

![Modifier size](images/modifier_size.png)
Modifier sizes

## Arrows

General rules for arrows: arrowhead is a filled triangle with a 90° pointing angle, a 2px body ends in a square stroke. An arrow’s orientation is horizontal, vertical, 45° or round.

![Arrows basic](images/arrows_basic.png)
Basic arrow icons

Unfilled arrowhead can be used if there is only one arrow on an icon to reduce excessive visual weight, for example, for navigation arrows, such as back and forward, up and down.

|  ![Arrow filled](images/arrow_filled.png) | ![Arrow unfilled](images/arrow_unfilled.png) |
|  90° arrowhead and 2px square stroke body. | Back arrow with unfilled arrowhead to compensate visual weight. |

Do not use other arrow styles, for example, unfilled arrows or arrows with thinned tails.

Incorrect

![Arrows incorrect](images/arrows_incorrect.png)

## Color

Do not use color as the only differentiator between icons (except for the [Noun icon](#noun-icons)) because some people do not distinguish colors. Make sure that icons are easily distinguishable by their shape.

Do not use gradients or shadows.

### Action icons

An action icon is an icon that triggers an action. It usually appears on toolbars and in dialogs.
There are 5 colors in the action icons palette.
The dark version is for Darcula theme.

|              ![Action red](images/action_red.png)                           Red  #DB5860            |             ![Action red d](images/action_red_d.png)                           Red dark  #C75450            |
|              ![Action yellow](images/action_yellow.png)                           Yellow  #EDA200            |             ![Action yellow d](images/action_yellow_d.png)                           Yellow dark  #F0A732            |
|              ![Action green](images/action_green.png)                           Green  #59A869            |             ![Action green d](images/action_green_d.png)                           Green dark  #499C54            |
|              ![Action blue](images/action_blue.png)                           Blue  #389FD6            |             ![Action blue d](images/action_blue_d.png)                           Blue dark  #3592C4            |
|              ![Action grey](images/action_grey.png)                           Grey  #6E6E6E            |             ![Action grey d](images/action_grey_d.png)                           Grey dark  #AFB1B3            |

Use these colors according to the following rules:

1. By default, action icons are grey and monochromatic:

![Colors actions grey](images/colors_actions_grey.png)

2. If an icon falls into one of the categories below, use the corresponding color:

|  Green Positive actions: run, create   ![Colors actions green](images/colors_actions_green.png)  | Red Destructive actions: stop, remove, force   ![Colors actions red](images/colors_actions_red.png)  |
|  Blue Accent color to highlight popular icons based on usage statistics, highlight small elements in complex icons    ![Colors actions blue](images/colors_actions_blue.png)  | Yellow Warning actions: attract attention to the places (e.g., code) that can be optimized or improved    ![Colors actions yellow](images/colors_actions_yellow.png)  |

3. Preserve colors in icon combinations. If an icon is colored in its full size, it should have the same color when reduced.

![Colors actions modifier](images/colors_actions_modifier.png)

4. Use green and red colors for paired icons. Color helps distinguish between similar icons faster.

![Colors actions pair](images/colors_actions_pair.png)

5. Use grey color for tool window icons. Icons are placed on the perimeter of the IDE, so they should not attract too much attention and distract users.

![Colors toolbuttons](images/colors_toolbuttons.png)

### Status icons

Color is a great way to provide status information. Use status icons that are already present in the IDE repository:

![Colors status](images/colors_status.png)
If a new icon is needed, color it according to its semantics. Make sure that the status icons are easily distinguishable by their form, as many colorblind people find it difficult to distinguish between red and green.

### Noun icons

A noun icon is an icon that appears in the tree view to mark different file types. It helps to locate items in the list faster and does not trigger an action.

The palette for noun icons is wider, because there are lots of icons in one set:

|              ![Noun grey](images/noun_grey.png)                           Grey  #9AA7B0            |             ![Noun grey 80](images/noun_grey_80.png)                           Grey 80%  #9AA7B0 op. 80%            |             ![Noun grey 60](images/noun_grey_60.png)                           Grey 60%  #9AA7B0 op. 60%            |
|              ![Noun blue](images/noun_blue.png)                           Blue  #40B6E0            |             ![Noun blue 70](images/noun_blue_70.png)                           Blue 70%  #40B6E0 op. 70%            |             ![Noun blue 60](images/noun_blue_60.png)                           Blue 60%  #40B6E0 op. 60%            |
|              ![Noun green](images/noun_green.png)                           Green  #62B543            |             ![Noun green 70](images/noun_green_70.png)                           Green 70%  #62B543 op. 70%            |             ![Noun green 60](images/noun_green_60.png)                           Green 60%  #62B543 op. 60%            |
|              ![Noun yellow](images/noun_yellow.png)                           Yellow  #F4AF3D            |             ![Noun yellow 70](images/noun_yellow_70.png)                           Yellow 70%  #F4AF3D op. 70%            |             ![Noun yellow 60](images/noun_yellow_60.png)                           Yellow 60%  #F4AF3D op. 60%            |
|              ![Noun purple](images/noun_purple.png)                           Purple  #B99BF8            |             ![Noun purple 70](images/noun_purple_70.png)                           Purple 70%  #B99BF8 op. 70%            |             ![Noun purple 60](images/noun_purple_60.png)                           Purple 60%  #B99BF8 op. 60%            |
|              ![Noun pink](images/noun_pink.png)                           Pink  #F98B9E            |             ![Noun pink 70](images/noun_pink_70.png)                           Pink 70%  #F98B9E op. 70%            |             ![Noun pink 60](images/noun_pink_60.png)                           Pink 60%  #F98B9E op. 60%            |
|              ![Noun red](images/noun_red.png)                           Red  #F26522            |             ![Noun red 70](images/noun_red_70.png)                           Red 70%  #F26522 op. 70%            |             ![Noun red 60](images/noun_red_60.png)                           Red 60%  #F26522 op. 60%            |
|              ![Noun red status](images/noun_red_status.png)                           Red status  #E05555            |             ![Noun red status 70](images/noun_red_status_70.png)                           Red status 70%  #E05555 op. 70%            |
|              ![Noun yellow d](images/noun_yellow_d.png)                           Yellow dark  #D9A343            |
|              ![Noun green android](images/noun_green_android.png)                           Green Android  #A4C639            |
|              ![Noun black](images/noun_black.png)                           Black text  #231F20 op. 70%            |

Select colors for new icons based on existing colors and users’ habits.

Use colors with 60% opacity and grey 80% for big parts, like folder icons:

![Colors nouns folder](images/colors_nouns_folder.png)
Transparent icons are used in both light and dark themes, so in most cases there’s only one version.

Use colors with 70% opacity for medium size elements that occupy about half of an icon, like file type icons:

![Colors nouns file](images/colors_nouns_file.png)
Use colors without opacity for small elements, like modifiers.

![Colors nouns modifier](images/colors_nouns_modifier.png)

## Font

To make a new icon with a letter, reuse letters from existing icons. If there's no suitable letter in existing icons, use a common sans-serif font like Arial or Open Sans.

## Export Icons

Note:

Install the [Svgo-compressor plugin](https://www.sketchapp.com/extensions/plugins/svgo-compressor/) in Sketch to optimize icons before save.

Use the SVG format for icons files. Use camelCase capitalization for icon names:

`iconName.svg`

If an icon is not the same in the dark theme, then also create:

`iconName_dark.svg`

