# Base node images can be found here: https://hub.docker.com/_/python
ARG BASE_IMAGE=python:3.10.6-bullseye

#####################################################################
# Base Image 
# 
# All these commands are common to both development and production builds
#
#####################################################################
FROM $BASE_IMAGE AS base

EXPOSE 8000

# Change active user to root
USER 0

RUN apt update -y
RUN apt install vim -y

COPY ./docker_image_build_scripts /image_build

RUN /image_build/setup.sh

# Change active user to be non-root
USER 1001
WORKDIR /opt/app-root/webapp 


FROM base as production

# The next lines are for Production builds only!
COPY --chown=1001:0 ./server-code /opt/app-root/webapp/
WORKDIR /opt/app-root/webapp 
RUN python -m venv /opt/venv 
RUN /opt/venv/bin/pip install -r /opt/app-root/webapp/requirements.txt

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
