$image = "host-registrator"
if (Test-Path env:APPVEYOR_BUILD_VERSION) { 
	$version = $env:APPVEYOR_BUILD_VERSION
} else {
	$version = "local"
}