# Grav
Docker image for [Grav](https://getgrav.org), based on the [Amazon Linux 2017.09 Docker Image](https://hub.docker.com/_/amazonlinux/)

> _Requires Docker to be installed and running :whale2: [Docker Install](https://docs.docker.com/engine/installation/)_

## Build the image
```bash
$ git clone git@github.com:ishahid/grav.git && cd grav && docker build -t grav .
```

## Or pull the image from Docker Hub
```bash
$ docker pull ishahid/grav:latest
```

## Run the image
```bash
$ docker run -d -p 8000:80 ishahid/grav
```

## Installation
Point your browser to http://localhost:8000 and complete the setup. Read the [Basic Tutorial](https://learn.getgrav.org/basics/basic-tutorial) to learn how it works.
