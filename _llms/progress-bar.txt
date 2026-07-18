# Progress Bar

<tldr>
Implementation: [JProgressBar](https://docs.oracle.com/javase/tutorial/uiswing/components/progress.html)
</tldr>

A progress bar informs users about the progress of a lengthy operation.

![01 progress bar](images/01%20progress_bar.png)

## When to use

### Long-running background operations

Use a progress bar to indicate long-running operations that don’t block the user interface but require visual tracking.

![14 in status bar](images/14%20in_status_bar.png)

### Background content update

When it is important to show that content is being updated, use an inline progress bar for background updates. The user can continue working with the content while a background process is performed.
Do not show a process name for an inline progress.

![09 inline processes](images/09%20inline_processes.png)

### Downloading and installing

Display a progress bar near the button while the action is being performed.

![17 downloading](images/17%20downloading.png)

## How to use

### Types

Use a determinate progress bar if the process duration is known. Otherwise, use indeterminate progress bar:

![02 determinate and indeterminate](images/02%20determinate_and_%20indeterminate.png)
If an indeterminate process reaches a point where its duration can be determined, switch to a determinate progress bar:

![04 determinate to indeterminate](images/04%20determinate_to_indeterminate.png)

### Process name and details

A progress bar can have a process name and process details.

#### Process name

Show the name of an operation being performed above the progress bar.
Use the continuous form of the verb that describes the operation. Add an ellipsis at the end to indicate that the process is ongoing.

![05 process name](images/05_process%20name.png)
If the vertical space is limited, place the process name with a colon on the left:

![07 process name on the left](images/07%20process_name_on_the_left.png)

#### Process details

Show information about the current stage of an operation to make long-running tasks more predictable and manageable.

Show details below the progress bar on a single line. The length of details is limited by the width of the progress bar.

![05 process details](images/05_process%20details.png)
Details example:

* The current step: “Uploading file 3 of 10”

* The name of a file, module, or library: “Fetching guava-31.1.jar”

* Remaining time or percentage completed.

* Round the remaining time to one of the following values: 1, 2, 3, 5, 10, 15, 20, or 30 seconds (or minutes). For example, if 7 minutes and 50 seconds remain, show “About 10 minutes left.” If less than 5 seconds remain, show “About 5 seconds left.”

* If the user can control the process (for example, stop it after a certain time), update the timer dynamically every second.

### Process controls

Place process controls on the right next to the progress bar. On hover over the icon, show the name of the control under the progress bar instead of process details.

![17 stop button](images/17%20stop_button.png)
#### Cancel or Stop button

Add a Cancel button if the process can be safely interrupted. If interrupting the process does not restore the system to its previous state, name the button Stop.

![17 cancel button](images/17%20cancel_button.png)

#### Pause button

If the process takes a long time and can prevent the user from performing tasks, provide an option to pause a process.

Note:

It is recommended to run the process in the background so it doesn’t interrupt the user, instead of offering a pause option.

|        ![Pause button](images/18%20pause_button.png)      |       Replace process details with the "Pause" comment on hover over the Pause icon.        |
|           ![Process on pause](images/19%20resume_button.png)          |         If a user pauses the process, show "Paused" under the progress bar. Replace the Pause icon with Resume.         |
|           ![Resume button](images/20%20resume_button.png)          |         Show "Resume" under the progress bar and when hovered over the Resume button.         |

#### Process status

If a process consists of substeps that can fail but do not terminate the process, then use green and red colors to show the intermediate status.
For example, show the status of the running tests:

![15 process status](images/15%20process_status.png)

### Placement in dialog or popup

Note:

Place the progress bar in a modal dialog if the IDE cannot function properly until  the process is completed.

Use a process name as a dialog or popup header, capitalize the title and remove the ellipsis. Process details appear above the progress bar. For a single progress bar, use a button to cancel or pause the process instead of an icon:

![13 in dialog](images/13%20in_dialog.png)
For several processes in a group, add a common header and use icons for process controls:

![16 process control](images/16%20process_control.png)
#### Process completion

Hide the progress bar as soon as the process completes.

