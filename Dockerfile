# Container image that runs your code
FROM alpine:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

ENV SONAR_SCANNER_VERSION 4.4.0.2170

ADD https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${SONAR_SCANNER_VERSION}.zip  /tmp/sonar-scanner.zip

WORKDIR /tmp

RUN \
    unzip /tmp/sonar-scanner.zip && \
    mv -fv /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}/bin/sonar-scanner /usr/bin && \
    mv -fv /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}/lib/* /usr/lib && \
    rm /tmp/sonar-scanner.zip && \
    rm -r /tmp/sonar-scanner-${SONAR_SCANNER_VERSION}/

RUN \
    apk add --no-cache openjdk11-jre-headless && \
    ln -s /entrypoint.sh /usr/bin/gitlab-sonar-scanner

WORKDIR /usr/bin
