
## Install  OpenSSH.Server 
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

## Change server start-up to Automatic 
Set-Service -Name sshd -StartupType 'Automatic'

## Start the Server and change start-up to Automatic
Start-Service sshd

## Configure winrm to allow unencrypted connections
## winrm get winrm/config/service
## netsh advfirewall firewall add rule name="WinRM Access" dir=in action=allow protocol=TCP localport=5985
New-NetFirewallRule -DisplayName "WinRM and SSH Access" -Direction inbound -Profile Any -Action Allow -LocalPort 22,5985 -Protocol TCP
winrm set winrm/config/client/auth '@{Basic="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
winrm set winrm/config/service '@{AllowUnencrypted=\"true\"}'

