@echo off

REM  Retrieve JSON for JENKINS build and output status as HTML color for ThingM blink(1) tool
REM  Needs blink1-jenkins.ps1 script for PowerShell 3.x (or higher) 
REM
REM  Author: Christian Dähn, Schwerin 2017
REM
REM  MIT License

REM  By default we assume the scripts are in the same directory
set SCRIPT_PATH=%~dp0
powershell -executionpolicy bypass -File "%SCRIPT_PATH%\blink1-jenkins.ps1"