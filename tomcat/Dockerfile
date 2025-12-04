FROM maven:3.8.4-openjdk-11 AS maven
WORKDIR /tmp
COPY application.properties /tmp/application.properties

RUN git clone -b code https://github.com/Omarh4700/Workshop.git  && \
    cd Workshop && \
    cp /tmp/application.properties src/main/resources/application.properties && \
    mvn clean install

FROM tomcat:9.0.75-jdk11 AS tomcat

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file from maven stage
COPY --from=maven /tmp/Workshop/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

# Important: Allow UID 1000 to write to specific directories
# We use UID 1000 directly (no need to create user)
RUN chown -R 1000:1000 /usr/local/tomcat/webapps \
                       /usr/local/tomcat/work \
                       /usr/local/tomcat/temp \
                       /usr/local/tomcat/logs

EXPOSE 8080
CMD ["catalina.sh", "run"]