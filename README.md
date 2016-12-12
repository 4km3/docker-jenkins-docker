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

If you are running a systemd based distro, create a Drop-in snippet at
/etc/systemd/system/docker.service.d/override.conf with the following content:
```
[Service] 
ExecStart= 
ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock
```

and then restart the docker daemon

## Running
Using docker named volumes is recommended for data persistance across upgrades.
A docker-compose is provided for convenience.
```
$ docker-compose up
```
will start and create a named volume automatically if not present.
Should you want to remove the named volume, you can do it via:
```
$ docker-compose down
$ docker volume rm dockerjenkinsdocker_jenkins-storage
```
if docker-compose was run from this directory. Otherwise check naming with
```
$ docker volume ls
```
The Jenkins web interface is available at localhost:8080

## Acknowledgements
Thanks a lot to pancho horrillo @panchoh for his invaluable guidance
