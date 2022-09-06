#!/bin/bash
set -e
source /image_build/buildconfig

UWSGI_VERSION=2.0.20

header "Setting up uWSGI version $UWSGI_VERSION"

USER_NAME=default
USER_HOME=/opt/app-root/src
UWSGI_USER_CONF_DIR=$USER_HOME/etc/
WEBAPP_DIR=/opt/app-root/webapp

run pip install -Iv uwsgi==$UWSGI_VERSION

# Place a dummy wsgi application file in the user directory
run cp -r /image_build/uwsgi/hello.wsgi $USER_HOME/hello.wsgi
run cp -r /image_build/uwsgi/uwsgi-config.ini $USER_HOME/uwsgi-config.ini

# Alright, now setup default uwsgi webapp
# run ln -s $USER_HOME/hello.wsgi $USER_HOME/main.wsgi

# make log directory
run mkdir -p /var/log/uwsgi
chgroup_dir_to_rw_zero "/var/log/uwsgi"

# Install the startup file
run mkdir /etc/service/uwsgi
run cp -r /image_build/uwsgi/uwsgi.sh $USER_HOME/uwsgi.sh
run chmod +x $USER_HOME/uwsgi.sh
