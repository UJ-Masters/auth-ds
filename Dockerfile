# Build the application first using Maven
FROM maven:3.8-openjdk-11 as build
WORKDIR /app
COPY . .
RUN mvn package

# Inject the JAR file into a new container to keep the file small
FROM openjdk:8-jre-alpine
WORKDIR /app
COPY --from=build /app/auth-service/target/auth-service-1.0.0-SNAPSHOT.jar /app/app.jar
EXPOSE 80
ENTRYPOINT ["sh", "-c"]

ENV Environment env-dev

CMD ["java -jar -Dspring.profiles.active=${Environment} app.jar"]
