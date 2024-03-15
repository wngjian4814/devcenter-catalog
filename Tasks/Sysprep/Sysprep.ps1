Write-Host -Message 'Stopping InstallService'
$service = Get-Service -Name InstallService -ErrorAction SilentlyContinue
if ($service -ne $null) {
    Stop-Service -Name InstallService
    Write-Host -Message 'InstallService stopped'
} else {
    Write-Host -Message 'InstallService is not running'
}

Write-Host -Message 'Setting InstallService Startup to Disabled'
Set-Service -Name InstallService -StartupType Disabled

# Commands to remove specified AppxPackages for all users
$packagesToRemove = @(
    "microsoft.Epmshellextension",
    "PaloAltoNetworks.GlobalProtect",
    "Microsoft.CompanyPortal",
    "SpotifyAB.SpotifyMusic",
    "MSTeams",
    "Microsoft.EpmShellExtension",
    "Microsoft.Winget.Source"
)

foreach ($package in $packagesToRemove) {
    $appxPackage = Get-AppxPackage -AllUsers -Name $package -ErrorAction SilentlyContinue
    if ($appxPackage -ne $null) {
        Remove-AppxPackage -Package $appxPackage.PackageFullName -AllUsers
        Write-Host -Message "Removed $package"
    } else {
        Write-Host -Message "$package not found"
    }
}

$newProcess = New-Object System.Diagnostics.ProcessStartInfo "sysprep.exe" 
$newProcess.WorkingDirectory = "${env:SystemDrive}\windows\system32\sysprep" 
$newProcess.Arguments = "/generalize /oobe /shutdown" 
Write-Host $newProcess.Arguments 
$newProcess.Verb = "runas"; 
$process = [System.Diagnostics.Process]::Start($newProcess);
