FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

COPY . .

RUN chmod +x mvnw
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/target/*.jar app.jar
COPY src/main/resources/ca.pem /app/ca.pem

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]