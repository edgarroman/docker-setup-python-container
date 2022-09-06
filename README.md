# docker-setup-python-container

Development workflow for Python/Django apps using Docker

## Overview

Ideally a Django app has a webserver and nginx in front of it.

## Philosophy

Do we start with Linix distro?
or Python version?
or NGINX installed?
or preconfigured other option?

## Debug

To explore the image, run:

```sh
docker run --platform linux/amd64 --rm -t -i phusion/passenger-full bash -l
```

## Build

Note: `--platform=linux/amd64` for newer macs with M1/M2 processors

```sh
docker build . -t mypythonapp:DEV --platform=linux/amd64
```

to run

```sh
docker run -ti --platform linux/amd64 --rm mypythonapp:DEV
```

to get interactive shell

```sh
docker run -ti --platform linux/amd64 -p 8000:8000 --rm mypythonapp:DEV  /bin/bash
```

## Development

To run the container

```sh
docker compose run --rm -p 8000:8000 app bash
```

### Django setup

```sh
python -m venv ve
source ve/bin/activate
pip install django
django-admin startproject mysite .
python manage.py runserver 0:8000
```
