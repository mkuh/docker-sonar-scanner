#!/bin/sh

if [ -z ${SONAR_URL+x} ]; then
  echo "Undefined \"SONAR_URL\" env" && exit 1
fi

URL=$SONAR_URL

BEFEHL="sonar-scanner -Dsonar.host.url=$URL"

if [ -z ${SONAR_TOKEN} ]; then
  echo "Undefined \"SONAR_TOKEN\" env" &&  exit 1
fi
BEFEHL="$BEFEHL -Dsonar.login=${SONAR_TOKEN} "

$BEFEHL $@
