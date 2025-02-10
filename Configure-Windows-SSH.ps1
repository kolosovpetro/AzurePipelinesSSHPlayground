choco install openssh -y -f

Set-Location "C:\Program Files\OpenSSH-Win64"

powershell.exe -ExecutionPolicy Bypass -File install-sshd.ps1

New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' `
    -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22

net start sshd
net start ssh-agent

Set-Service sshd -StartupType Automatic
Set-Service ssh-agent -StartupType Automatic
