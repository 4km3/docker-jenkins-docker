# jenkins-docker
Run a Jenkins server with Docker.io binaries included

## Building
```console
$ docker build -t 4km3/jenkins-docker .
```
## Configuration
The dockerhost must expose the Docker API via network. Include the following snippet in /etc/default/docker
```text
DOCKER_OPTS="-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock"
```
and restart the service

If you are running a systemd based distro, create a Drop-in snippet with the following content:
/etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock

and then restart the docker daemon

## Running
It is recommended to start a volume docker to store the Jenkins data
```console
$ docker create                 \
    -v /var/jenkins_home        \
    --name jenkins-data         \
    4km3/jenkins-docker
```
Then create the Jenkins container using the volume from jenkins-data
```console
# docker create                                  \
    --name jenkins-docker                        \
    -p 8080:8080                                 \
    -p 50000:50000                               \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --volumes-from jenkins-data                  \
    4km3/jenkins-docker
```
The docker container can be started or stopped at will
```console
# docker start jenkins-docker
```
The Jenkins web interface is available at localhost:8080

## Acknowledgements
Thanks a lot to pancho horrillo @panchoh for his invaluable guidance
