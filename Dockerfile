# Base node images can be found here: https://hub.docker.com/_/python
ARG BASE_IMAGE=python:3.10-slim-bullseye

# Things you can update:
#  - version of tini - see base_image_setup/setup.sh
#  - verison of nginx - see nginx/setup.sh
#  - version of uwsgi - see uwsgi/setup.sh
#

#####################################################################
# Base Image 
# 
# All these commands are common to both development and production builds
#
#####################################################################
FROM $BASE_IMAGE AS base

#################################################
# Default folders and whatnot
ARG IMAGE_BUILD_ROOT=/image_build
ARG SETUP_DIR_BIN=/usr/local/bin
ARG SETUP_DIR_SBIN=/usr/local/sbin
ARG USER_NAME=default 
# Be careful changing these next two since other files in the build process 
# are expecting these values
ARG APP_HOME=/opt/app-root/webapp
ARG APP_SCRIPTS=/opt/app-root/src

EXPOSE 8000

#################################################
# Change active user to root
USER 0

#################################################
# Update packages
RUN apt update -y
# Feel free to add vim you you enjoy using that
#RUN apt-get install vim -y
# Needed to get tini
RUN apt-get install wget -y
# Needed to build uwsgi
RUN apt-get install gcc -y

COPY ./docker_image_build_scripts/helpers /image_build/helpers

COPY ./docker_image_build_scripts/base_image_setup /image_build/base_image_setup
RUN /image_build/base_image_setup/setup.sh

COPY ./docker_image_build_scripts/nginx /image_build/nginx
RUN /image_build/nginx/setup_nginx.sh

COPY ./docker_image_build_scripts/uwsgi /image_build/uwsgi
RUN /image_build/uwsgi/setup_uwsgi.sh

RUN chgrp -R 0 /opt
RUN chmod -R g+rwX /opt

# Change active user to be non-root
USER 1001
WORKDIR ${APP_HOME}

#####################################################################
# Production Image 
# 
# Some changes are needed for a production build
#
#####################################################################
FROM base as production

# Remove any packages we downloaded for building the image or development workflow
USER 0
RUN apt-get purge vim -y && apt-get purge wget -y && apt-get purge gcc -y 
RUN apt clean 

# Copy over the app source code into the app home dir
COPY --chown=1001:0 ./server-code /opt/app-root/webapp/

USER 1001
RUN python -m venv /opt/venv 
RUN /opt/venv/bin/pip install -r /opt/app-root/webapp/requirements.txt

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
