$ErrorActionPreference = 'Stop'; 
$ProgressPreference = 'SilentlyContinue';

filter timestamp {"$(Get-Date -Format o): $_"}

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

$hostsfile = $env:HOSTSFILE
if (test-path $hostsfile) {
	"Using $hostsfile" | timestamp
} else {
	"$hostsfile not found, exiting" | timestamp
	exit 1
}

while ($true) {
	$hosts = Get-Content $hostsfile
	$newhosts = ""
	$hosts | Where-Object {$_ -notmatch '.docker'} | % { if ($_ -ne "") {$newhosts = "${newhosts}$_`r`n"} }

	$i=0
	./docker.exe ps -q | % { 
		$servicename=$(./docker.exe inspect --format '{{ .Name }}' $_ ).Substring(1)
		$ipaddress=$(./docker.exe inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $_)

		$newhosts += "${ipaddress}`t${servicename}.docker`r`n"
		$i++
	}
	
	if ($hosts -ne $newhosts) {
		"Updating with $i containers" | timestamp
		set-content -path $hostsfile -value $newhosts
	} else {
		"no changes" | timestamp
	}

	sleep -seconds 30
}
