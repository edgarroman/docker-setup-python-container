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
python -m venv /opt/venv
source /opt/venv/bin/activate
pip install django
django-admin startproject mysite .
python manage.py runserver 0:8000
```

## Production

## Build

Note: `--platform=linux/amd64` for newer macs with M1/M2 processors

```sh
docker buildx build . --platform linux/amd64 --target=production -t mypythonapp:0.5
```

to run

```sh
# old: docker run -ti --platform linux/amd64 -p 8000:8000 --rm mypythonapp:DEV
docker run -d -p 8000:8000 mypythonapp:0.5
```

If you get the error: `WARNING: The requested image's platform (linux/amd64) does not match the detected host platform (linux/arm64/v8) and no specific platform was requested 64f75af4c7d42883d67a27d80380bcc96896febbb284145866a2a700443ac322` then run:

```sh
docker run -d -p 8000:8000 --platform linux/amd64 mypythonapp:0.5
```

to get interactive shell

```sh
docker run -ti --platform linux/amd64 -p 8000:8000 --rm mypythonapp:0.5  /bin/bash
```
