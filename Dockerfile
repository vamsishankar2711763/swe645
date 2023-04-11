FROM tomcat:11.0-jdk17
LABEL maintainer="vsimhadr@gmu.edu"
COPY Survey.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]