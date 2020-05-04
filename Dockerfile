FROM python:3.7-alpine

# Application version
ARG version=latest
# Application port
ARG port=5000

# Metadata
#MAINTAINER ntran@ntdt.fr
LABEL maintainer="ntran@ntdt.fr"
LABEL fr.ntdt.docker.image.version="${version}"
LABEL fr.ntdt.docker.image.title="Sample Picture Viewer"
LABEL fr.ntdt.docker.image.url="https://hub.docker.com/repository/docker/ntdtfr/pic-viewer"
LABEL fr.ntdt.docker.image.description="Sample image docker training"

# Environnment variables
ENV APP_DIR=/pic-viewer

# Install requirements (python, flask, ...)
RUN apk add --no-cache gcc musl-dev linux-headers curl
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy application to docker image
WORKDIR $APP_DIR
#COPY . $APP_DIR
COPY static $APP_DIR/static
COPY templates $APP_DIR/templates
COPY app.py $APP_DIR

# Declare volume
VOLUME ["/pic-viewer/static"]

# Expose server port
EXPOSE $port

# Run flask instruction
CMD ["flask", "run"]