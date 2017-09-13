# Retrieve JSON for JENKINS build and output status as HTML color for blink(1) tool
#
# Needs PowerShell 3.x (or higher) 
# Needs USB RGB led "ThingM blink(1)"
# Needs Blink(1) Control - official Windows tool for blink(1)
# Needs settings.ini for Blink(1) Control with predefined color patterns for JENKINS jobs status
#
# Author: Christian Dähn, Schwerin 2017, https://github.com/3dh-de/blink1-jenkins-ps1

# settings - EDIT HERE!!!
$jenkins_host 	= "https://<MY-JENKINS-URL>"
$jenkins_project= "<MY-PROJECT-NAME>/job/<MY-JOB-NAME>"
$jenkins_user	= "<MY-USER>"
$jenkins_pass 	= "<MY-PASSWORD>"
# end of settings

# build login credentials
$root = "$jenkins_host/jenkins/job/$jenkins_project/api/json"
$pair = "$($jenkins_user):$($jenkins_pass)"
$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
$basicAuthValue = "Basic $encodedCreds"
$Headers = @{
    Authorization = $basicAuthValue
}

# get JSON from JENKINS
$json = Invoke-RestMethod -Uri $root -Headers $Headers

# Build hashtable of search and replace values.
$replacements = @{
  'red'        		= 'FAILURE'
  'blue'       		= 'SUCCESS'
  'green'      		= 'SUCCESS'
  'yellow'     		= 'UNSTABLE'
  'disabled'   		= 'UNSTABLE'
  'red_anime'  		= 'FAILURE_RUN'
  'blue_anime'		= 'SUCCESS_RUN'
  'green_anime'		= 'SUCCESS_RUN'
  'yellow_anime'	= 'UNSTABLE_RUN'
  'disabled_anime'	= 'UNSTABLE_RUN'
}

# Join all (escaped) keys from the hashtable into one regular expression.
[regex]$r = @($replacements.Keys | foreach { [regex]::Escape( $_ ) }) -join '|'

[scriptblock]$matchEval = { param( [Text.RegularExpressions.Match]$matchInfo )
  # Return replacement value for each matched value.
  $matchedValue = $matchInfo.Groups[0].Value
  $replacements[$matchedValue]
}

$pattern = $r.Replace( $json.color, $matchEval )

# return Blink(1) pattern name
echo "{ ""pattern"": ""$pattern"" }"
