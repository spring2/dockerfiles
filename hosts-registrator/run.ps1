docker stop host-registrator
docker rm host-registrator

docker run -d --restart=always `
	--name host-registrator `
	-e HOSTSFILE=c:/etc/hosts `
	-e DOCKER_HOST=172.16.0.1:2375 `
	-v C:/Windows/System32/drivers/etc:c:/etc `
	spring2/host-registrator