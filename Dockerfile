FROM python:3.7-alpine
MAINTAINER ntran@ntdt.fr
ENV APP_DIR /pic-viewer
ENV FLASK_APP app.py
ENV FLASK_RUN_HOST 0.0.0.0
#ENV FLASK_ENV production 
ENV FLASK_ENV development
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
WORKDIR $APP_DIR
COPY . $APP_DIR
VOLUME ["/pic-viewer/static"]
EXPOSE 5000
CMD ["flask", "run"]