# pic-viewer

A sample application for Docker training. 

This project is base on Docker and Flask framework and introduces the following notions :

* Containerization with Docker
* Docker volume mapping
* Using Docker Compose for building images and running containers
* Deploying application to Swarm and Kubernetes orchestrators
* Zero downtime rolling update and blue/green deployment
* Automated building and deployment with a Jenkins pipeline


## How to use it ?

### Get the project

```
git clone https://github.com/nntran/pic-viewer-docker-flask
```

### Build

```sh
docker build --rm --tag pic-viewer .
```

### Run

```sh
docker run --rm -p 5000:5000 pic-viewer
```

It serve at http://localhost:5000

It will show the docker pickture ;)

[![](./static/photo.jpg)](http://localhost:5000)


To view your own picture, you need to mount a volume and put a picture to the mounted folder. The picture must named as `picture.jpg`.

```sh
docker run -v <my-folder>:/pic_viewer/static -p 5000:5000 pic-viewer
```

You have to refresh navigator or clear the cache in order to view your picture.
