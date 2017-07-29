#https://github.com/StefanScherer/dockerfiles-windows/tree/master/consul
FROM microsoft/nanoserver
ARG VERSION
ENV CONSUL_VERSION=$VERSION

RUN powershell -Command $ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue'; \
    Invoke-WebRequest $('https://releases.hashicorp.com/consul/{0}/consul_{0}_windows_amd64.zip' -f $env:CONSUL_VERSION) -OutFile 'consul.zip' -UseBasicParsing ; \
    Expand-Archive -Path consul.zip -DestinationPath . -Force ; \
    rm consul.zip ; 

ADD ./config /config/

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp
#VOLUME ["/data"]

ENTRYPOINT ["c:/consul.exe"]
