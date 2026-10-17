# Stage 1: Build the artifact using Maven and Java 21
FROM maven:3.9-eclipse-temurin-21 AS build_image
WORKDIR /vprofile-project
COPY ./ .
RUN mvn clean install 

# Stage 2: Deploy to Tomcat running Java 21
FROM tomcat:10.1-jdk21
LABEL "Project"="Vprofile"
LABEL "Author"="Rajesh"

# Clear default Tomcat webapps and deploy the artifact
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build_image /vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
