$ErrorActionPreference = "Stop"

# Get the public key file generated previously on your client
$authorizedKey = Get-Content -Path ".\id_rsa.pub"

# Generate the PowerShell to be run remote that will copy the public key file generated previously on your client to the authorized_keys file on your server
$remotePowershell = "powershell Add-Content -Force -Path $env:ProgramData\ssh\administrators_authorized_keys -Value '$authorizedKey';icacls.exe ""$env:ProgramData\ssh\administrators_authorized_keys"" /inheritance:r /grant ""Administrators:F"" /grant ""SYSTEM:F"""

# Connect to your server and run the PowerShell using the $remotePowerShell variable
ssh razumovsky_r@ssh-windows.razumovsky.me $remotePowershell
