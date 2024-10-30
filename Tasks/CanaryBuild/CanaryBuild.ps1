# Set script execution policy (if not already set)
Set-ExecutionPolicy RemoteSigned -Force

# Ensure that the Windows Update module is available
Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser

# Import the module
Import-Module PSWindowsUpdate

# Check if Windows Insider settings are available on the VM
$insiderKeyPath = "HKLM:\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection"
if (-Not (Test-Path $insiderKeyPath)) {
    Write-Output "Windows Insider settings not available. Ensure this VM is capable of joining the Insider Program."
    exit 1
}

# Set Windows Insider Channel to Canary
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection" -Name "UIBranch" -Value "Canary"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" -Name "BranchName" -Value "Canary"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" -Name "ContentType" -Value "Mainline"
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsSelfHost\Applicability" -Name "Ring" -Value "External"

# Connect to Windows Update servers to check for Canary builds
Write-Output "Checking for updates in the Canary channel..."
Get-WindowsUpdate -WindowsUpdate -AcceptAll -Install -Verbose

Write-Output "The VM is now enrolled in the Windows Insider Program and will install updates from the Canary channel."
 
