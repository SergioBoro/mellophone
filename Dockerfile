FROM tomcat:latest
# TODO environment
ARG MELLOPHONE_MAJOR=6.1-SNAPSHOT

RUN rm -rf webapps/ROOT && rm -rf webapps/manager && rm -rf webapps/docs && rm -rf webapps/examples && rm -rf webapps/host-manager

# MELLOPHONE
ADD https://artifactory.corchestra.ru/artifactory/libs-snapshot-local/ru/curs/mellophone/${MELLOPHONE_MAJOR}/mellophone-${MELLOPHONE_MAJOR}.war webapps/mellophone.war

RUN unzip webapps/mellophone.war -d webapps/mellophone && rm webapps/mellophone.war

COPY config.xml config.xml
