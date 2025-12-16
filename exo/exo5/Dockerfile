# Étape 1 :
FROM maven:3.8.4-openjdk-17-slim AS builder

WORKDIR /build

COPY ./app_java_spring/pom.xml .

RUN mvn dependency:go-offline

COPY ./app_java_spring/src /build/src

RUN mvn clean package

# Étape 2 :
FROM eclipse-temurin:25

WORKDIR /opt/app

RUN ls -l /build/target

# COPY --from=builder /build/target/japp.jar .

EXPOSE 8080

CMD ["java", "-jar", "japp.jar"]
