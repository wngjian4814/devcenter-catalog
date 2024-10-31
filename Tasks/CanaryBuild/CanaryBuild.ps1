# Join the Windows Insider Program using PowerShell
# This script should be run as Administrator

# Define registry paths for Insider settings
$InsiderPath = "HKLM:\SOFTWARE\Microsoft\WindowsSelfHost\UI\Selection"
$ContentPath = "HKLM:\SOFTWARE\Microsoft\WindowsSelfHost\Applicability"

# Ensure paths exist
if (!(Test-Path $InsiderPath)) { New-Item -Path $InsiderPath -Force | Out-Null }
if (!(Test-Path $ContentPath)) { New-Item -Path $ContentPath -Force | Out-Null }

# Configure for Canary channel (adjust "UIRing" and "Ring" to other values for different channels)
New-ItemProperty -Path $InsiderPath -Name "UIContentType" -Value "Mainline" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $InsiderPath -Name "UIRing" -Value "Canary" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $ContentPath -Name "BranchName" -Value "Canary" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $ContentPath -Name "ContentType" -Value "Mainline" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $ContentPath -Name "Ring" -Value "Canary" -PropertyType String -Force | Out-Null

# Enable Telemetry to allow Insider settings to apply
$TelemetryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection"
if (!(Test-Path $TelemetryPath)) { New-Item -Path $TelemetryPath -Force | Out-Null }
New-ItemProperty -Path $TelemetryPath -Name "AllowTelemetry" -Value 3 -PropertyType DWord -Force | Out-Null

Write-Output "System configured to join the Windows Insider Program (Canary Channel). Please restart your system for the changes to take effect."




 
