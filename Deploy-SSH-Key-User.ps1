$ErrorActionPreference = "Stop"

# Get the public key file generated previously on your client
$authorizedKey = Get-Content -Path ".\id_rsa.pub"

# Generate the PowerShell to be run remote that will copy the public key file generated previously on your client to the authorized_keys file on your server
$remotePowershell = "powershell New-Item -Force -ItemType Directory -Path $env:USERPROFILE\.ssh; Add-Content -Force -Path $env:USERPROFILE\.ssh\authorized_keys -Value '$authorizedKey'"

# Connect to your server and run the PowerShell using the $remotePowerShell variable
ssh razumovsky_r@ssh-windows.razumovsky.me $remotePowershell
