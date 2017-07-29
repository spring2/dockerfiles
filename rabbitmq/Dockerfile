FROM microsoft/windowsservercore

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV chocolateyUseWindowsCompression false

RUN iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1')); \
    choco install -y curl;

RUN choco install -y erlang --version 19.3
ENV ERLANG_SERVICE_MANAGER_PATH="C:\Program Files\erl8.3\erts-8.3\bin"
RUN curl 'https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.10/rabbitmq-server-windows-3.6.10.zip' -o $env:TEMP\rabbitmq-server.zip; \
    Expand-Archive "$env:TEMP\rabbitmq-server.zip" -DestinationPath 'C:\Program Files\RabbitMQ Server'; \
    del "$env:TEMP\rabbitmq-server.zip";
ENV RABBITMQ_SERVER="C:\Program Files\RabbitMQ Server\rabbitmq_server-3.6.10"

ENV RABBITMQ_CONFIG_FILE="c:\rabbitmq"
COPY rabbitmq.config C:/
COPY rabbitmq.config C:/Users/ContainerAdministrator/AppData/Roaming/RabbitMQ/
COPY enabled_plugins C:/Users/ContainerAdministrator/AppData/Roaming/RabbitMQ/


EXPOSE 4369
EXPOSE 5672
EXPOSE 5671
EXPOSE 15672

WORKDIR C:/Program\ Files/RabbitMQ\ Server/rabbitmq_server-3.6.10/sbin
CMD .\rabbitmq-server.bat
