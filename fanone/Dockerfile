# GATEWAY
FROM openjdk:21-rc-jdk AS gateway
WORKDIR /app
COPY ./jar/fandelo-one-gateway-0.0.1-SNAPSHOT.jar .
ENV SPRING_PROFILES_ACTIVE=dev
CMD ["java", "-jar", "fandelo-one-gateway-0.0.1-SNAPSHOT.jar"]

# USER
FROM openjdk:21-rc-jdk AS user
WORKDIR /app
COPY ./jar/fandelo-one-user-0.0.1-SNAPSHOT.jar .
ENV SPRING_PROFILES_ACTIVE=dev
CMD ["java", "-jar", "fandelo-one-user-0.0.1-SNAPSHOT.jar"]
