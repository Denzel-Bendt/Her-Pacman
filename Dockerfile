# Gebruik een officiële .NET SDK als builder image
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app

# Kopieer de projectbestanden en restore dependencies
COPY *.csproj ./
RUN dotnet restore

# Kopieer de rest van de applicatie en bouw deze
COPY . ./
RUN dotnet publish -c Release -o out

# Gebruik een runtime image voor de container
FROM mcr.microsoft.com/dotnet/runtime:7.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "MyCSharpApp.dll"]
