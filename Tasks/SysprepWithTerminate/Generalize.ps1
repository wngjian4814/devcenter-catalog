$newProcess = new-object System.Diagnostics.ProcessStartInfo "sysprep.exe" 
$newProcess.WorkingDirectory = "${env:SystemDrive}\windows\system32\sysprep" 
$newProcess.Arguments = "/sysprep /oobe /generalize /quit" 
Write-Host $newProcess.Arguments 
$newProcess.Verb = "runas"; 
$process = [System.Diagnostics.Process]::Start($newProcess);
