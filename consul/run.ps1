$env:DOCKER_HOST="vdc-qasapptst01"

docker stop consul-agent
docker rm consul-agent

$hostname = $env:DOCKER_HOST.ToUpper()
$fqdn=[System.Net.Dns]::GetHostByName($env:DOCKER_HOST)  | FL HostName | Out-String | %{ "{0}" -f $_.Split(':')[1].Trim() }
write-host $fqdn
write-host $hostname
$consul = [System.Net.Dns]::GetHostAddresses($fqdn)
write-host $consul
$ip='10.100.63.83'
$ip


$consul = "10.100.63.177"
$consul

$domain='STORMWIND-LOCAL'
docker run -d --restart=always `
	-p 8300:8300 `
	-p 8301:8301/tcp -p 8301:8301/udp -p 8302:8302/tcp -p 8302:8302/udp -p 8400:8400 -p 8500:8500 -p 53:53/udp `
	-h $hostname `
	--name consul-agent `
	-e CONSUL=$consul `
	-e IP=$ip `
	-e DATACENTER=$domain `
	-v c:/consul:c:/consul `
	spring2/consul `
	agent -join $consul `
	-advertise $ip `
	-datacenter $domain `
	-config-file /consul/config/consul.json `
	-data-dir /consul/data `
	-client 0.0.0.0 `
	-ui `
	-dns-port=53

