param (
    [string]$vmname,
    [string]$rgname
)

import-module azurerm 
$azureAccountName ="email"
$azurePassword = ConvertTo-SecureString "Password" -AsPlainText -Force

$psCred = New-Object System.Management.Automation.PSCredential($azureAccountName, $azurePassword)

Add-AzureAccount -Credential $psCred 

$verbosepreference = "continue"

Write-Verbose "working on vm: $vmname in $rgname"

#log into Azure
Write-Verbose '[*] logging into azure'
$conn =get-automationConnection -name  Azurerunasconnection
$null = Add-AzureRmAccount -ServicePrincipal -tenant $conn.tenantifd -applicationid  $conn.application -certifcate

# get VM status and start it up

write verbose'[*] getting vm status before delting logs'
$status (get-azurermvm -name $vmware -ResourceGroupName) $ RGName

# get credntials, create session and excute cleanup command 
$creds = GetRMAutomationCredential -name 'login-creds' -ResourceGroupName 'automation-gui-rg' -automationaccount
Write-Verbose "[*] Got Credentials for: $($creds.username)"

$session = New-PSSession -ComputerName $vmname -Credential $creds
Invoke-Command -Session $session -ScriptBlock { & 'c:\admin\log-cleanup.ps1'}

# stop VM and report its status
Write-Verbose '[*] Getting VM status to ensure it is powered off'
$null = stop-AzureRMVM -Name $vmname -ResourceGroupName $resourceGroupname $rgname -Force
$status = (Get-azurermvm -Name $vmname -ResourceGroupName $RGName -Status).Statuses[1].Code
Write-Output "$vmname status: $status"
