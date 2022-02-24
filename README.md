# learn-docker
Docker experimentation
## Docker commands
Build an image from a docker file `docker build -t <repository>/<tag_name> .` eg `docker build -t mydockerimage:latest .` It creates an image with the tag and uses the default Dockerfile in the directory that the command is run from.


`docker run -it --name mycontainer linuxdev:experiment /bin/bash`

SSH and stuff
`docker build --ssh leica=$SSH_AUTH_SOCK -t linuxdev:experiment .`

`docker cp`
`docker ps -a`
`docker rm`
`docker rmi`
