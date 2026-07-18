# Data Formats

<tldr>
Related: [Text](ui-faq.html#text)
</tldr>

## Numbers

Note:

If there is a space between the number and the unit, use a non-breaking space.

|  | Examples  | When and how to use  |
---------------------------------------
| Numbers |4,255,165.00 |Space is not limited, e.g. Settings dialog:           ![Numbers](images/numbers.png)      |
| Numbers short |         10.5k           3.3M        |Space is limited, e.g. in table or lists. |
| Percentage |13% | |
| Ratios |3 of 10 | |
| Ratios short |3/10 |Space is limited, e.g. in table or lists. |
| Currency |$10 | |

## Date and time

By default, the date and time formats are taken from the system settings. The format can be changed on the `Settings | Appearance & Behavior | System Settings | Date Formats` page.

See the table below to understand in which cases to show date and time.

|  | Examples  | When and how to use  |
---------------------------------------
| Date |         Today           05 Jan           05 Jan 2017        |         Omit the time for events if the exact time does not matter, e.g., Annotate panel.           Use Today and Yesterday for the last two days, use exact date for all other days.           Do not show the year if it’s within the current calendar year.        |
| Date and time |         Today, 14:04           05 Jan, 14:04           05 Jan 2019, 14:04        |When it is important to know the exact sequence of actions, e.g., Version Control Log. |
| Time |22:49 |Omit date if the event happened today and it’s clear from the context. |
| Date and day of week |Tuesday, 30 August |         Use as headers in timelines, e.g., Event Log. The day of the week helps to quickly understand how long ago was the event.           Use Today and Yesterday for the last two days, use exact date for all other days.        |
| Approximate time |        A moment ago          10 minutes ago          2 hours ago        |Use for a single event that happened recently, e.g., in the Status bar:           ![Approximate](images/approximate.png)         Do not use in tables as it’s harder to compare.           If more than 12 hours have passed since the event, use Date format.        |

![Vcs log](images/vcs_log.png)
Version Control Log (in IntelliJ IDEA incorrect format is used at the moment)

![Event log](images/event_log.png)
Event Log

## Duration

|  | Examples  | When and how to use  |
---------------------------------------
| Period |         10 milliseconds           10 seconds           10 minutes           1 hour        |Space is not limited, e.g. Settings dialog:         ![Period](images/period.png)      |
| Time-lapse |         1 h 30 m 30 s           1 h 30 m 30.035 s           1 h           1 h 0 m 30 s           1 m 30 s           05 Jan 2019, 14:04        |Use for changing duration. Select units depending on the process type. E.g., Unit tests usually run less than a minute, so show only seconds and milliseconds. Build tasks usually run more than a minute, so show minutes and seconds.           Omit hours and seconds that do not provide additional data.    |
| Time-lapse condensed [ISO 8601 standard](https://en.wikipedia.org/wiki/ISO_8601) |1:30:01.350 |Use when space is limited or to describe a range, e.g. 1:30:01.350 – 1:30:02.350  |

![Run](images/run.png)

## Quantities of data

Use decimal numeral system.

| bits |10 bits |
| bytes |10 B |
| kilobytes |10 KB |
| megabytes |10 MB |
| gigabytes |10 GB |
| terabytes |10 TB |

![Data formats tree](images/data_formats_tree.png)

## Units

All numeric values should be given a unit or clearly labeled if they do not have suitable units, e.g. counters.

![Period](images/period.png)![No units](images/no_units.png)
Select the most convenient units.

| Incorrect |Correct |
----------------------
| ![Connection incorrect](images/connection_incorrect.png) |![Connection correct](images/connection_correct.png) |

Place units after the input field.

| Incorrect |Correct |
----------------------
| ![Caret incorrect](images/caret_incorrect.png) |![Caret correct](images/caret_correct.png) |

## Tables

Use the rules below to make it easier to compare numbers in one column.

Right-align numeric values.

![Data formats table](images/data_formats_table.png)
Include the unit in the column header if all values share the same unit. Convert each number to use the same unit.
If it’s not possible, e.g., the scatter of numbers is too large, include the unit with each value.

| Incorrect |Correct |
----------------------
| ![Table units incorrect](images/table_units_incorrect.png) |![Table units correct](images/table_units_correct.png) |

Be consistent with the precision of the significand.

| Incorrect |Correct |
----------------------
| ![Precision incorrect](images/precision_incorrect.png) |![Precision correct](images/precision_correct.png) |

