Set-Location -Path $PSScriptRoot

$zoneName = "razumovsky.me"

$newDnsEntriesHashtable = @{ }

$ubuntuVmIp = $(terraform output -raw ubuntu_vm_ip)
$windowsVmIp = $(terraform output -raw windows_vm_ip)

$newDnsEntriesHashtable["ssh-ubuntu.$zoneName"] = $ubuntuVmIp
$newDnsEntriesHashtable["ssh-windows.$zoneName"] = $windowsVmIp

.\cloudflare\Upsert-CloudflareDnsRecord.ps1 `
    -ApiToken $env:CLOUDFLARE_API_KEY `
    -ZoneName $zoneName `
    -NewDnsEntriesHashtable $newDnsEntriesHashtable
