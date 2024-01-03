# GATEWAY
FROM openjdk:21-rc-jdk AS gateway
WORKDIR /app
COPY ./jar/fandelo-one-gateway-0.0.1-SNAPSHOT.jar .
CMD ["java", "-jar", "fandelo-one-gateway-0.0.1-SNAPSHOT.jar"]

# USER
FROM openjdk:21-rc-jdk AS user
WORKDIR /app
COPY ./jar/fandelo-one-user-0.0.1-SNAPSHOT.jar .
# ENV SPRING_PROFILES_ACTIVE=dev
CMD ["java", "-jar", "fandelo-one-user-0.0.1-SNAPSHOT.jar"]
# CMD ["tail", "-f", "/dev/null"]

# MAIl
FROM openjdk:21-rc-jdk AS mail
WORKDIR /app
COPY ./jar/fandelo-one-mail-0.0.1-SNAPSHOT.jar .
CMD ["java", "-jar", "fandelo-one-mail-0.0.1-SNAPSHOT.jar"]