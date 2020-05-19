FROM python:3.7-alpine
MAINTAINER DAG_Test

ENV PYTHONUNBUFFERED 1

# Install dependencies
COPY ./requirements.txt /requirements.txt
RUN apk add --update --no-cache mariadb-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers mariadb-dev
RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps
# Setup directory structure
RUN mkdir /app
WORKDIR /app
COPY ./app/ /app

RUN adduser -D user
USER user

CMD ["python", "manage.py", "runserver", "0.0.0.0", "8090"]