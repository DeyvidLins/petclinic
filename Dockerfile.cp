FROM openjdk:8-jdk-alpine
# Add Maintainer Info

# Add a volume pointing to /tmp
VOLUME /tmp

# Make port 8080 available to the world outside this containe
EXPOSE 8080

# The application's jar file
ARG JAR_FILE=target/spring-petclinic-2.4.0.BUILD-SNAPSHOT.jar

# Add the application's jar to the container
ADD ${JAR_FILE} app.jar

# Run the jar file 
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]
