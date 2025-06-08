# Etapa 1 - Build da aplicação usando Maven com Java 24
FROM maven:3.9-amazoncorretto-24-alpine AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Etapa 2 - Imagem final com Amazon Corretto 24
FROM amazoncorretto:24-alpine-jdk
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8060
ENTRYPOINT ["java", "-jar", "app.jar"]
