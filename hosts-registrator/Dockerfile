FROM microsoft/nanoserver

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV DOCKER_VERSION 17.03.0-ce

RUN Invoke-WebRequest $('https://get.docker.com/builds/Windows/x86_64/docker-{0}.zip' -f $env:DOCKER_VERSION) -OutFile 'docker.zip' -UseBasicParsing; \
	Expand-Archive -Path 'docker.zip' -DestinationPath c:/ -Force; \
	rm docker.zip; \
	cp c:/docker/docker.exe c:/;

RUN ls c:/
	
COPY UpdateHostsWithContainers.ps1 C:/
CMD c:/UpdateHostsWithContainers.ps1
