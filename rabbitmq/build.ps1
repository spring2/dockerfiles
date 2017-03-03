$ErrorActionPreference = 'Stop'; 
$ProgressPreference = 'SilentlyContinue';

Function check-result {
	if ($LastExitCode -ne 0) {
		$e = [char]27
		$start = "$e[1;31m"
		$end = "$e[m"
		$text = "ERROR: Exiting with error code $LastExitCode"
		Write-Host "$start$text$end"
		return $false
	}
	return $true
}

Function Invoke-Exe {
Param(
    [parameter(Mandatory=$true)][string] $cmd,
    [parameter(Mandatory=$true)][string] $args
	
)
	Write-Host "Executing: `"$cmd`" --% $args"
	Invoke-Expression "& `"$cmd`" $args"
	$result = check-result
	if (!$result) {
		throw "ERROR executing EXE"
	}
}

$image="rabbitmq"
$build="3.6.5"

invoke-exe -cmd docker -args "build -t spring2/${image}:$build ."
invoke-exe -cmd docker -args "tag spring2/${image}:$build spring2/${image}:latest"

invoke-exe -cmd docker -args "push spring2/${image}:$build"
invoke-exe -cmd docker -args "push spring2/${image}:latest"
