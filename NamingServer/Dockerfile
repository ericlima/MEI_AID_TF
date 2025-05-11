# Usa imagem base com Java 24
FROM eclipse-temurin:24-jdk AS builder

# Define diretório de trabalho dentro do container
WORKDIR /app

# Copia o JAR gerado para dentro do container
COPY target/NamingServer-0.0.1-SNAPSHOT.jar app.jar
#COPY src/main/resources/mei_aid.jks mei_aid.jks

# Expõe a porta que o Eureka Server usará
EXPOSE 8761

# Define o comando de inicialização da aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]
