FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build

WORKDIR .

COPY . .

RUN dotnet restore

RUN dotnet build

WORKDIR ./DishNutriDataAPI

EXPOSE 5263

CMD ["dotnet", "run"]