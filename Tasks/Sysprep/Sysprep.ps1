# Commands to stop and disable the InstallService
Write-Host -Message 'Stopping InstallService'
Stop-Service InstallService
Write-Host -Message 'Setting InstallService Startup to Disabled'
Set-Service -Name InstallService -StartupType Disabled

# Commands to remove specified AppxPackages for all users
Get-AppxPackage -AllUsers -Name "microsoft.Epmshellextension" | Remove-AppxPackage
Get-AppxPackage -AllUsers -Name "PaloAltoNetworks.GlobalProtect" | Remove-AppxPackage
Get-AppxPackage -AllUsers -Name "Microsoft.CompanyPortal" | Remove-AppxPackage
Get-AppxPackage -AllUsers -Name "SpotifyAB.SpotifyMusic" | Remove-AppxPackage
Get-AppxPackage -AllUsers -Name "MSTeams" | Remove-AppxPackage
Get-AppxPackage -AllUsers -Name "Microsoft.EpmShellExtension" | Remove-AppxPackage
Get-AppxPackage -AllUsers -Name "Microsoft.Winget.Source" | Remove-AppxPackage

$newProcess = new-object System.Diagnostics.ProcessStartInfo "sysprep.exe" 
$newProcess.WorkingDirectory = "${env:SystemDrive}\windows\system32\sysprep" 
$newProcess.Arguments = "/generalize /oobe /shutdown" 
Write-Host $newProcess.Arguments 
$newProcess.Verb = "runas"; 
$process = [System.Diagnostics.Process]::Start($newProcess);
