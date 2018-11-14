# testRegistry
A locally hosted registry that has a certificate from a private CA.



## Usage

1. Clone this repo to a local directory
2. In a powershell terminal, run `.\Install-CertificateAuthority.ps1`
   This will:
   - Download mkcert.exe from github, and put it in the local folder.
   - Create a CA cert/key pair in a local subdirectory called CARoot.
   - Install the CA cert in the windows certificate store.

3. In a powershell terminal, run `.\Create-Certificate.ps1`
   This will:
   - Create a cert/key pair for 127.0.0.1 using the CA in CARoot.
   - Copy that cert/key pair into ./certs/ directory.

4. Run "docker-compose up" in the same directory
   This will start a local registry, on port 5443, using the certificates.

5. Goto https://127.0.0.1:5443/v2/_catalog to test the registry is running and the certificate is trusted.
(Might not work in Firefox as that does NOT use the Windows Certificate Store by default)



## Uninstall
Everything should be under the directory into which you cloned this repo, except the CA cert in the Windows Certificate Store.  To undo/clean up after testing:
 - Remove the local CA cert from the Window Certificate Store, by running `Remove-CertificateAuthority.ps1`.
 - Delete the the cloned directory.
