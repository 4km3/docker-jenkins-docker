FROM jenkins:latest
MAINTAINER Rodrigo de la Fuente <rodrigo@delafuente.email>

LABEL Description="Jenkins container with docker.io binary"   \
      Vendor="ACME Products"                                  \
      Version="1.0"

ENV DOCKER_HOST 172.17.0.1:4243

USER root

RUN  set -e;                            \
     apt-get update;                    \
     apt-get install -y docker.io;    

USER jenkins
