Param(
	$NumberOfPaths = 1,
	$LogDrive = "D"
)

#Source is abbreviated as Src, Destination is abbreviated as Dest

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
	robocopy /E /COPY:S /IS /IT /XJ /R:2 /W:1 $CurrentSrc $CurrentDest
}
