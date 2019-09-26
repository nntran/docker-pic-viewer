# pic-viewer

A simple application to illustrate Docker volume.

It's base on Docker and Flask framework.


## How to use it ?

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


To view your own picture, you need to mount a volume and put a picture to the mounted folder. The picture must named as `photo.jpg`.

```sh
docker run -v <my-folder>:/pic_viewer/static -p 5000:5000 pic-viewer
```

You have to refresh navigator or clear the cache in order to view your picture.
