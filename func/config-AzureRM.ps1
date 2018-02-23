##installs Azure resource manager
find-Module azurerm | Install-Module -scope AllUsers -force 
get-module azurerm -ListAvailable

##Create AA
Get-AzureRmSubscription
Select-AzureRmSubscription -subscriptionname '8c464b16-3e9f-4502-8498-5cf48658551f'
Get-AzureRmAutomationAccount

## gets all acccounts                                                                                         
Get-AzureRmAutomationAccount

$aa = 'automation-ps-aa'
$rg = 'automation-ps-rg'
 
New-AzureRmResourceGroup -name 'automation-ps-rg' -Location westeurope
New-AzureRmAutomationAccount -name $aa -ResourceGroupName $rg -location 'West Europe'

Get-AzureRmAutomationAccount

## Creating runbooks 


$aa = 'automation-ps-aa'
$rg = 'automation-ps-rg'
New-AzureRmAutomationRunbook -name 'first-runbook-ps' -Description 'out first' -Type PowerShell -ResourceGroupName $rg -automationaccountname $aa

##Addint shit to runbook

Import-AzureRmAutomationRunbook -path 'C:\Users\hiney\Desktop\codebase\AzureTFSOctopus\func\first-runbook.ps1' -Name 'first-runbook-ps' -type PowerShell -ResourceGroupName $rg -AutomationAccountName $aa

## new ting
New-AzureRmAutomationVariable -Name 'log-age' -Encrypted $false -Description 'max number of days old a log file can be' -value 2 -ResourceGroupName $rg -AutomationAccountName $aa

## encrpyted varaible 

$securestring = 'password' | ConvertTo-SecureString -AsPlainText -Force
$credential = [Pscredential]::new('vm-admin',$securestring)
New-AzureRmAutomationCredential -Name 'login-creds' -Description 'Credentials for logging into our VM' -value $credential -ResourceGroupName $rg -AutomationAccountName $aa 
