[CmdletBinding()]
param (
    # The IP (or hostname) to create a certificate for.
    [Parameter()]
    [string]
    $IPAddress = '127.0.0.1'        
)
    
$ErrorActionPreference = 'Stop'

#######################################################
# Assumes the mkcert tool is already in the current directory
$currentDirectory=Get-Location
$localMkCert=Join-Path -Path $currentDirectory -ChildPath "mkcert.exe"


#######################################################
# Set %CAROOT% to a local directory rather than using the
#  the default folder under %localAppData%
#  this makes it easier to delete stuff made by this test
$env:CAROOT=Join-Path -path $currentDirectory -ChildPath "CARoot"

# Use mkcert to create a server certificate/key pair using
# the local root certificate
& $localMkCert $IPAddress


##Copy newly minted certs to the "certs" directory for our registry to use
$key=Join-Path     -Path $currentDirectory -ChildPath "${IPAddress}-key.pem"
$cert=Join-Path    -Path $currentDirectory -ChildPath "${IPAddress}.pem"
$certDir=Join-Path -Path $currentDirectory -ChildPath "certs"

if (!(Test-Path $certDir)) {
    New-Item -ItemType Directory -Path $certDir
}

Write-Host -ForegroundColor Green "Copying $key to $certDir\domain.key"
Copy-Item -Path $key  -Destination "$certDir\domain.key"
Write-Host -ForegroundColor Green "Copying $cert to $certDir\domain.crt"
Copy-Item -Path $cert -Destination "$certDir\domain.crt"

Write-Host -ForegroundColor Green "Now need to run `"docker-compose up`" in $currentDirectory"
