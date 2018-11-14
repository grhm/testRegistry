
$ErrorActionPreference = 'Stop'

#######################################################
# Download the mkcert tool into the current directory
$url="https://github.com/FiloSottile/mkcert/releases/download/v1.1.2/mkcert-v1.1.2-windows-amd64.exe"
$currentDirectory=Get-Location
$localMkCert=Join-Path -Path $currentDirectory -ChildPath "mkcert.exe"

Write-Host -ForegroundColor Green "Downloading from $url"
Write-Host -ForegroundColor Green "Saving as $localMkCert"
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri $url -OutFile $localMkCert

#######################################################
# Set %CAROOT% to a local directory rather than using the
#  the default folder under %localAppData%
#  this makes it easier to delete stuff made by this test
$env:CAROOT=Join-Path -path  $currentDirectory -ChildPath "CARoot"

# Use mkcert to create root certificate
# This will show a dialog asking you to confirm the install
& $localMkCert -install


