
$ErrorActionPreference = 'Stop'

#######################################################
# Assumes the mkcert tool is already in the current directory
$currentDirectory=Get-Location
$localMkCert=Join-Path -Path $currentDirectory -ChildPath "mkcert.exe"


#######################################################
# Set %CAROOT% to a local directory rather than using the
#  the default folder under %localAppData%
#  this makes it easier to delete stuff made by this test
$env:CAROOT=Join-Path -path  $currentDirectory -ChildPath "CARoot"

# Use mkcert to uninstall the previously created root certificate
# This will show a dialog asking you to confirm the uninstall
& $localMkCert -uninstall
