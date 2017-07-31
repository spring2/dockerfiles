. .\version.ps1

Write-Host "Building spring2/${image}:${version}"

docker build --build-arg VERSION=${version} -t spring2/${image}:latest -f Dockerfile .
docker tag spring2/${image}:latest spring2/${image}:${version}
