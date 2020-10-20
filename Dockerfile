#Dockerimage from websphere-liberty:kernel
FROM ibmcom/websphere-liberty:kernel-java8-openj9-ubi

# Default server configuration
COPY --chown=1001:0 config/server.xml /config/
COPY --chown=1001:0 config/server.env /config/
COPY --chown=1001:0 config/idpMetadata.xml /opt/ibm/wlp/usr/servers/defaultServer/resources/security/
COPY --chown=1001:0 config/key.p12 /opt/ibm/wlp/usr/servers/defaultServer/resources/security/


ENV LICENSE accept
EXPOSE 8080 9080 9448 9443 9060 443


# JEE app (Servlet, Spring-Boot, JAXB WAR)
COPY --chown=1001:0 static/samlJavaEEApp.war /config/apps/

# Setting for the verbose option (Default: false)
ARG VERBOSE=true

RUN configure.sh

#OPTIONAL: keystore with self-signed cert
COPY --chown=1001:0 config/key.p12 /opt/ibm/wlp/output/defaultServer/resources/security/

