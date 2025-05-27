# Usa imagem base com Java 24
FROM eclipse-temurin:24-alpine-3.21 AS builder

ENV JAVA_OPTS="-XX:+UnlockExperimentalVMOptions --add-opens java.base/sun.misc=ALL-UNNAMED"

# Define diretório de trabalho dentro do container
WORKDIR /app

# Copia o JAR gerado para dentro do container
COPY target/*.jar app.jar
#COPY src/main/resources/mei_aid.jks mei_aid.jks

# Expõe a porta que o Eureka Server usará
EXPOSE 8761

# Define o comando de inicialização da aplicação
ENTRYPOINT java $JAVA_OPTS -jar app.jar