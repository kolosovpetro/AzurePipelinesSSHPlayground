$OpenSSHStatus = Get-WindowsCapability -Online | Where-Object Name -like 'OpenSSH.Server*'
Write-Host "Package name: $( $OpenSSHStatus.Name )"
Write-Host "Package state: $( $OpenSSHStatus.State )"

if ($OpenSSHStatus.State -eq "NotPresent")
{
    Write-Host "Package is missing"
}
