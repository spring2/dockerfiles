. .\version.ps1

function Build {
param
(
    [string] $version,
    [string] $dockerfile = "Dockerfile",
	[string] $suffix = ""
)
	$latest = "latest${suffix}"
	$v = "${version}${suffix}"
	Write-Host "Building spring2/${image}:${v}"

	docker build --build-arg VERSION=${version} -t spring2/${image}:$latest -f $dockerfile .
	docker tag spring2/${image}:$latest spring2/${image}:${v}
}

Build -version $version
Build -version $nano_version -dockerfile "Dockerfile.nanoserver" -suffix "-nanoserver"
