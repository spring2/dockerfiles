. .\version.ps1

Write-Host "Pushing spring2/${image}:${version}"

docker push spring2/${image}:${version}
docker push spring2/${image}:latest
