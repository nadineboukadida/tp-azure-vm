#
# Build stage
#
FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /app
COPY src ./src
COPY pom.xml .
RUN mvn clean package

#
# Package stage
#

FROM openjdk:11
COPY --from=build /app/target/ob-item-service-0.0.1-SNAPSHOT.jar ./app.jar   
EXPOSE 8081   
ENTRYPOINT ["java", "-jar", "app.jar"]