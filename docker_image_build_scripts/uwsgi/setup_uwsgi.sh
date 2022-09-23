#!/bin/bash
set -e
# Activate some helper utilities that we'll us in this file like 'header', 'run', and 'chgroup_dir_to_rw_zero'
source ${IMAGE_BUILD_ROOT}/helpers/helper_functions

UWSGI_VERSION=2.0.20

header "Setting up uWSGI version $UWSGI_VERSION"

UWSGI_USER_CONF_DIR=${APP_SCRIPTS}/etc/

run pip install -Iv uwsgi==$UWSGI_VERSION

# Place a dummy wsgi application file in the user directory
run cp -r ${IMAGE_BUILD_ROOT}/uwsgi/hello.wsgi ${APP_SCRIPTS}/hello.wsgi
run cp -r ${IMAGE_BUILD_ROOT}/uwsgi/uwsgi-config.ini ${APP_SCRIPTS}/uwsgi-config.ini
run cp -r ${IMAGE_BUILD_ROOT}/uwsgi/startwsgi.py ${APP_SCRIPTS}/startwsgi.py

# make log directory
run mkdir -p /var/log/uwsgi
chgroup_dir_to_rw_zero "/var/log/uwsgi"

# Install the startup file
run mkdir /etc/service/uwsgi
run cp -r ${IMAGE_BUILD_ROOT}/uwsgi/uwsgi.sh ${APP_SCRIPTS}/uwsgi.sh
run chmod +x ${APP_SCRIPTS}/uwsgi.sh
