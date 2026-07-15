# Notifications

Notifications inform users about the status of user or system initiated operations. They can have different actions depending on the message.

Types of notifications:

* Alert

* [Banner](banner.html)

* [Notification balloon](balloon.html)

## What notification to use

Choose a notification type based on a combination of two factors:

1. Is user action required to proceed?

* [Required immediately](#action-is-required-immediately)

* [Required but not immediately](#action-is-required-but-not-immediately)

* [Not required](#action-is-not-required-to-proceed)

2. From what context the notification was initiated?

* Editor

* Tool window

* Dialog

* Any other location

### Action is required immediately

Use an alert in any context:
![An alert 'Open Project' asking where to open 'myJavaProject' with options to cancel, open in a new window or this window](images/notification_type_alert.png)

### Action is required but not immediately

Use a [banner](banner.html) if the context is the editor, a tool window, or a dialog:
![A banner in the editor with a warning 'Project JDK is not defined' and action 'Setup JDK'](images/notification_type_banner_action_required_editor.png)

In any other context, use a [notification balloon](balloon.html).

### Action is not required to proceed

Use a [notification balloon](balloon.html) in any context except dialogs:
![A notification balloon warning about a shortcut conflict with a description and actions 'Modify shortcuts' and 'Don't show again'](images/notification_type_balloon_action_not_required.png)

In a dialog, use a [banner](banner.html):
![A banner in a dialog with a notification 'Interactive lesson available' and actions 'Open lesson' and an icon button to close the banner](images/notification_type_banner_action_required_dialog.png)

