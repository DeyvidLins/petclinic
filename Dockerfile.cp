FROM openjdk:11.0.1-jre-slim-stretch
EXPOSE 8080
ARG JAR=spring-petclinic-2.4.0.BUILD-SNAPSHOT.jar
COPY target/$JAR /app.jar
CMD ["java","-jar","/app.jar"]


