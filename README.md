# blink1-jenkins-ps1
PowerShell script to poll JENKINS project status to display ist with blink(1) USB RGB LED

Polls JENKINS JSON API for a given project and job to control the USB RGB LED "ThingM blink(1)".
This script is used to add so called 'extreme feedback devices' to all develeopers machines.

The current build status is live displayed as blinking (while build is running) or slow glowing red / yellow / green colors.

## Requirements

- Software [Blink(1) Control](http://blink1.thingm.com/blink1control/)
- Windows 7 or newer with PowerShell 3.x or newer
- JENKINS 2.6 or newer
- user account with read rights for JENKINS project

## Setup

1. clone this repository to any dir, reachable by an absolute path starting with a drive letter (the blink(1) software has problems with network shares)
2. edit the `blink1-jenkins.ps1` to enter your JENKINS host url, job name, user and password
3. open Blink(1) Control, attach your blink(1) USB RGB LED
4. open the settings dialog by clicking on the settings-icon above the blink(1) image
5. import the configuration for color patterns provided in `Blink1-Control-settings.ini`
6. close settings and go to "Tools"
7. add a "script" and select the `poll-jenkins.bat` and select your polling frequency - e.g. 15 seconds
8. right click on the setting and click on "Test tool"


[Blink(1) Control GUI](Blink1-Control-settings.jpg)

If anything goes wrong, just open a command line an run `poll-jenkins.bat` manually. 

For a successful build you schould get an output like:
```
{ "pattern": "SUCCESS" }
```

The Blink(1) Control has some pitfalls - e.g. it cannot exec scripts on network shares / network profiles and sometimes it crashes. So just unplug the USB blink(1) and restart the tool on errors.
