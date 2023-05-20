# Azure SSH Playground

Virtual machine SSH connection testing out including run of ansible playbooks

- https://dev.azure.com/PetroKolosovProjects/AzureSSHPlayground

## SSH connect CLI commands

- ssh -i id_rsa razumovsky_r@74.234.112.155
- sudo ssh -i id_rsa razumovsky_r@74.234.112.155
- ssh -i id_rsa pkolosov@74.234.112.155
- ssh -o StrictHostKeyChecking=no -i id_rsa razumovsky_r@74.234.112.155
- sudo ssh -o StrictHostKeyChecking=no -i id_rsa razumovsky_r@74.234.112.155

## Config paths

- SSH WSL config is under path: `/root/.ssh/config`
- SSH Windows Client config is under path: `C:\Users\pkolosov\.ssh`

Windows Azure pipelines agent looks for ssh config in folders:

- debug3: Failed to open file:C:/Users/VssAdministrator/.ssh/config error:2
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

## Windows OpenSSH Reading

- https://youtu.be/pFTC4Rt-EDQ
- https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_keymanagement
- https://superuser.com/questions/1433917/windows-10-ssh-client-password-less-access
- https://learn.microsoft.com/en-us/windows-server/administration/openssh/openssh_server_configuration?source=recommendations