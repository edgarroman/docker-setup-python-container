#!/bin/sh
#
#
USER_NAME=default
USER_HOME=/opt/app-root/src

exec /usr/local/bin/uwsgi \
    --socket /tmp/uwsgi.sock \
    --chmod-socket=666 \
    --master \
    --wsgi-file /opt/app-root/src/main.wsgi \
    >>/var/log/uwsgi/uwsgi.log 2>&1
