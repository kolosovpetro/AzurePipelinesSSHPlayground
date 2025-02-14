# Azure SSH Playground

- Configuring SSH connection to Windows server
- Configuring SSH connection to Linux server
- Testing both in Azure Pipelines CI/CD
- Configure Azure DevOps SSH Service Connection

## Azure DevOps tasks used

- [SSH@0 - SSH v0 task](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/ssh-v0?view=azure-pipelines)
- [InstallSSHKey@0 - Install SSH key v0 task](https://learn.microsoft.com/en-us/azure/devops/pipelines/tasks/reference/install-ssh-key-v0?view=azure-pipelines)

## Azure DevOps Configuration

- Configure SSH Service Connection
- Update variable group `ssh-settings` with servers fingerprints
- Update private key in secure files `id_rsa`

## Windows Server SSH setup

- `Windows Server` requires preinstalled `Chocolatey` package manager
- In this example `Packer` image is used: https://github.com/kolosovpetro/PackerAzureWindowsImages
- Enter Windows Server via `RDP`
- Run `Configure-Windows-SSH.ps1` script on Windows Server
- Execute `Deploy-SSH-Key-Admin.ps1` script from local machine
- ssh razumovsky_r@ssh-windows.razumovsky.me

## SSH commands

- ssh razumovsky_r@ssh-windows.razumovsky.me
- ssh razumovsky_r@ssh-ubuntu.razumovsky.me

## Config paths

- SSH WSL config is under path: `/root/.ssh/config`
- SSH Windows Client config is under path: `C:\Users\pkolosov\.ssh`

### Windows Azure pipelines agent looks for ssh config in folders:

- debug3: Failed to open file:C:/Users/VssAdministrator/.ssh/config error:2
- debug3: Failed to open file:C:/ProgramData/ssh/ssh_config error:2

### Windows GitHub actions agent looks for ssh config in folders:

- debug3: Failed to open file:C:/Users/runneradmin/.ssh/config error:2
- debug3: Failed to open file:C:/ProgramData/ssh/ssh_config error:2

## SCP commands

- sudo scp -i id_rsa_windows ansible_config.yml razumovsky_r@74.234.112.155:C:
  /Users/razumovsky_r/Desktop/ansible_hotel360_azdo_copy.yml
- scp -i id_rsa_windows ansible_config.yml razumovsky_r@74.234.112.155:C:
  /Users/razumovsky_r/Desktop/ansible_hotel360_azdo_copy.yml
- scp -F "C:/Users/pkolosov/.ssh/config" -i "C:/Users/pkolosov/.ssh/id_rsa_windows" ansible_hotel360.yml
  razumovsky_r@74.234.112.155:C:/Users/razumovsky_r/Desktop/ansible_hotel360_ssh_windows_copy.yml

## Generate SSH keys for Azure Pipelines

- ssh-keygen -m PEM -t rsa -b 2048
- ssh-keygen -m PEM -t rsa -b 2048 -f "id_rsa"

## Trello tasks

- Windows SSH: https://trello.com/c/VMsz7Qkh
- Ubuntu SSH: https://trello.com/c/35maBR5a
- Ansible via SSH: https://trello.com/c/bprTa7Jr
- Configure SSH on Windows server: https://trello.com/c/VMsz7Qkh
- Deploy Docker container to Ubuntu via SSH: https://trello.com/c/zKsA36wA

## Windows OpenSSH Docs

- https://youtu.be/pFTC4Rt-EDQ
- https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement
- https://superuser.com/questions/1433917/windows-10-ssh-client-password-less-access
- https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_server_configuration?source=recommendations
