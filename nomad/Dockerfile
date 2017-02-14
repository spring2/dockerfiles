#https://github.com/StefanScherer/dockerfiles-windows/tree/master/consul
FROM microsoft/nanoserver
ENV NOMAD_VERSION 0.5.4

RUN powershell -Command $ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; \
    Invoke-WebRequest $('https://releases.hashicorp.com/nomad/{0}/nomad_{0}_windows_amd64.zip' -f $env:NOMAD_VERSION) -OutFile 'nomad.zip' -UseBasicParsing ; \
    Expand-Archive -Path nomad.zip -DestinationPath . -Force ; \
	mv nomad nomad.exe; \
    rm nomad.zip ;

#EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp
#VOLUME ["/data"]

RUN powershell -command c:/nomad.exe --version

ENTRYPOINT ["c:/nomad.exe"]
