# Source is abbreviated as Src, Destination is abbreviated as Dest

$NumberOfPaths = Read-Host -Prompt "How many directories do you want to copy?"
$LogDrive = Read-Host -Prompt "Which drive do you want to save the log to?"

For ($i=1; $i -le $NumberOfPaths; $i++){
    $NewPath = Read-Host -Prompt "Enter Source Path $i"
	New-Variable -Name "SrcPath$i" -Value $NewPath -Force
	$NewPath = Read-Host -Prompt "Enter Destination Path $i"
	New-Variable -Name "DestPath$i" -Value $NewPath -Force
}

For ($i=1; $i -le $NumberOfPaths; $i++){
	$CurrentSrc = Get-Variable -Name "SrcPath$i" -ValueOnly
	$CurrentDest = Get-Variable -Name "DestPath$i" -ValueOnly
	robocopy $CurrentSrc $CurrentDest /MIR /SEC /XJ /XX /E /V /R:2 /W:1 /TEE /LOG:"${LogDrive}:\robocopy$i.log"
}
