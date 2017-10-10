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
	if (test-path $hostsfile) {
		try {
			$hosts = Get-Content $hostsfile -ErrorAction Stop
			$newhosts = ""
			$original = ""
			$hosts | Select | % { if ($_.trim() -ne "") {$original = "${original}$_`r`n"} }
			$hosts | Where-Object {$_.trim() -notmatch '.docker'} | % { if ($_.trim() -ne "") {$newhosts = "${newhosts}$_`r`n"} }
			

			$i=0
			./docker.exe ps -q | % { 
				$servicename=$(./docker.exe inspect --format '{{ .Name }}' $_ ).Substring(1)
				$ipaddress=$(./docker.exe inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $_)

				$newhosts += "${ipaddress}`t`t${servicename}.docker`r`n"
				$i++
			}

			if ($original -ne "" -and $original -ne $newhosts) {
				"Updating with $i containers" | timestamp
				set-content -path $hostsfile -value $newhosts.trim()
			} else {
				"no changes" | timestamp
			}
		} catch {
			"Unhandled exception: $_"
		}
	} else {
		"ERROR: $hostsfile not found" | timestamp
	}
		
	sleep -seconds 30
}
