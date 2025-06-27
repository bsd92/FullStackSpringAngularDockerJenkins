## Étape de build
#FROM maven:3.9.6-eclipse-temurin-21-alpine AS build
#WORKDIR /app
#
## Copier les fichiers nécessaires
#COPY pom.xml .
#COPY src ./src
#
## Compiler le projet
#RUN mvn clean package -DskipTests
#
## Étape de production
#FROM eclipse-temurin:21-jdk-alpine
#WORKDIR /app
#
## Copier le jar compilé depuis l'étape de build
#COPY --from=build /app/target/*.jar app.jar
#
## Exposer le port
#EXPOSE 8080
#
## Lancer l'application
#ENTRYPOINT ["java", "-jar", "app.jar"]

#Version 2:
# Build étape
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Runtime étape
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]

