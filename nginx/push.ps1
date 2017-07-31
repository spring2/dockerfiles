. .\version.ps1

function Push {
param
(
    [string] $version,
    [string] $suffix = ""
)

	$latest = "latest${suffix}"
	$v = "${version}${suffix}"
	Write-Host "Pushing spring2/${image}:${v}"

	docker push spring2/${image}:${v}
	docker push spring2/${image}:${latest}
}

Push -version $stable_version
Push -version $mainline_version
Push -version $nano_version -suffix "-nanoserver"
