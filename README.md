# docker-setup-python-container

Development workflow for Python/Django apps using Docker

## Overview

Ideally a Django app has a webserver and nginx in front of it.

## Philosophy

Do we start with Linix distro?
or Python version?

## Development

To run the container

```sh
docker compose run --rm -p 8000:8000 app bash
```

### Django setup

```sh
python -m venv venv
source venv/bin/activate
pip install django
django-admin startproject mysite .
python manage.py runserver 0:8000
```

## Production

## Build

Note: `--platform=linux/amd64` for newer macs with M1/M2 processors

```sh
docker build . --target=production --platform=linux/amd64 -t mypythonapp:0.5
```

to run

```sh
# old: docker run -ti --platform linux/amd64 -p 8000:8000 --rm mypythonapp:DEV
docker run -d -p 8000:8000 mypythonapp:0.5
```

to get interactive shell

```sh
docker run -ti --platform linux/amd64 -p 8000:8000 --rm mypythonapp:0.5  /bin/bash
```
