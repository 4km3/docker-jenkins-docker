FROM jenkins/jenkins:lts
MAINTAINER Rodrigo de la Fuente <rodrigo@delafuente.email>

LABEL Description="Jenkins container with docker.io binary"   \
      Vendor="ACME Products"                                  \
      Version="1.0"

ENV DOCKER_HOST 172.17.0.1:4243

USER root

RUN  set -e;                                                    \
     apt-get update;                                            \
     apt-get install -y                                         \
         apt-transport-https                                    \
         ca-certificates                                        \
         curl                                                   \
         gnupg2                                                 \
         software-properties-common;                            \
     curl -fsSL                                                 \
         https://download.docker.com/linux/debian/gpg           \
         | apt-key add -;                                       \
     add-apt-repository                                         \
     "deb [arch=amd64] https://download.docker.com/linux/debian \
     $(lsb_release -cs)                                         \
      stable";                                                  \
     apt-get update;                                            \
     apt-get install -y docker-ce;                              \
     /usr/local/bin/install-plugins.sh                          \
                yet-another-docker-plugin

USER jenkins
