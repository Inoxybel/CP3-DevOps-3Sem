# imagem de compilação
FROM mcr.microsoft.com/dotnet/framework/sdk:4.8 AS build

WORKDIR /app

# copia csproj e restaura as dependencias
COPY ./AppFuncional /app

WORKDIR /app/AppMvc

RUN nuget restore ../AppFuncional.sln

RUN msbuild AppMvc.csproj /p:Configuration=Release /p:Platform="AnyCPU"

# imagem de runtime
FROM mcr.microsoft.com/dotnet/framework/aspnet:4.8-windowsservercore-ltsc2019

WORKDIR /inetpub/wwwroot

COPY --from=build /app/AppMvc ./

RUN powershell -Command \
    Import-module IISAdministration; \
    New-IISSite -Name "AppMvc" -PhysicalPath C:\inetpub\wwwroot -BindingInformation "*:8000:"

EXPOSE 8000

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]
