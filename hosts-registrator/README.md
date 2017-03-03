# host-registrator

Docker image that will monitor local docker-engine for containers and update a volume mapped hosts file, allowing for name resolution to your local docker containers by name.

```
docker run -d --restart=always `
	--name host-registrator `
	-e HOSTSFILE=c:/etc/hosts `
	-e DOCKER_HOST=172.16.0.1:2375 `
	-v C:/Windows/System32/drivers/etc:c:/etc `
	spring2/host-registrator
```

Make sure that docker-engine is looking for tcp connections:
```
C:\ProgramData\docker\config> cat .\daemon.json
{
        "hosts": ["tcp://0.0.0.0:2375", "npipe://"],
        "fixed-cidr": "172.16.0.0/20"
}
```

NOTE: make sure that the docker-engine port is open
```
# Open firewall port 2375
netsh advfirewall firewall add rule name="docker engine" dir=in action=allow protocol=TCP localport=2375
```

