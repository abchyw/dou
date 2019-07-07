FROM openjdk:11.0.2-jre-slim-stretch

RUN mkdir /app

ARG JAR_FILE

COPY ${JAR_FILE} /app/api.jar
COPY ./entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

WORKDIR /app
# Application port
EXPOSE 8080

ENTRYPOINT ["/entrypoint.sh"]
