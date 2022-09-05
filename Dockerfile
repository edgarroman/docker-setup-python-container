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

ADD ./docker_image_build_scripts /image_build

# Change active user to root
USER 0

RUN /image_build/setup.sh

# Change active user to be non-root
USER 1001

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
