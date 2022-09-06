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

ADD ./docker_image_build_scripts /image_build

RUN /image_build/setup.sh

# Change active user to be non-root
USER 1001

RUN PS1="\[\033[35m\]Development Environment!\[\033[m\]-\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

WORKDIR /opt/app-root/webapp 

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
