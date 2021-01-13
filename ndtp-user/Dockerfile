# escape=`
# Start with a base image containing Java runtime
FROM adoptopenjdk/openjdk11
ENV PATH = "C:\Deport\2020_DAUM_NDTP\ndtp\ndtp-user\build\libs"
# Add Author info
LABEL maintainer="dhkim"

# Add a volume to /tmp
VOLUME ["/tmp", "/data"]

# Make port 8080 available to the world outside this container
EXPOSE 8080

# The application's jar file
ARG JAR_FILE=${PATH}/demo-0.0.1-SNAPSHOT.war

# Add the application's jar to the container
ADD ${JAR_FILE} demo-boot.jar
# Run the jar file
ENTRYPOINT ["java","-jar","/app/demo-boot.jar"]