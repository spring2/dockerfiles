.\consul.exe agent -join $env:consul `
	-advertise $env:ip `
	-datacenter $env:datacenter `
	-config-file /config/consul.json `
	-client 0.0.0.0 `
	-ui `
	-dns-port=53
