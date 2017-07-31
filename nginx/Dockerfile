#https://github.com/mbentley/docker-windows-containers-examples
FROM microsoft/windowsservercore:latest
ARG VERSION
ENV NGINX_VERSION $VERSION

RUN mkdir c:\build\nginx\source &&\
  powershell -Command "invoke-WebRequest -uri ('http://nginx.org/download/nginx-{0}.zip' -f $env:NGINX_VERSION) -OutFile 'c:\nginx.zip' -UseBasicParsing" &&\
  powershell -Command "Expand-Archive -Path C:\nginx.zip -DestinationPath C:\ -Force" &&\
  del c:\nginx.zip &&\
  powershell -Command "Rename-Item ('c:\nginx-{0}' -f $env:NGINX_VERSION) 'c:\nginx'" 

WORKDIR /nginx/
EXPOSE 80 443
CMD nginx.exe -g "daemon off;"
