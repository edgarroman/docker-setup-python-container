#!/bin/sh
#
#
USER_NAME=default
USER_HOME=/opt/app-root/src

#exec /usr/local/bin/uwsgi \
#    --socket /tmp/uwsgi.sock \
#    --chmod-socket=666 \
#    --master \
#    --wsgi-file /opt/app-root/src/main.wsgi \
#    >>/var/log/uwsgi/uwsgi.log 2>&1

exec /usr/local/bin/uwsgi \
    --socket /tmp/uwsgi.sock \
    --chmod-socket=666 \
    --master \
    --processes=5 \                 # number of worker processes
    --harakiri=20 \                 # respawn processes taking more than 20 seconds
    --max-requests=5000 \           # respawn processes after serving 5000 requests
    --wsgi-file /opt/app-root/src/main.wsgi \
    --home /opt/app-root/webapp/ve/ \
    --env DJANGO_SETTINGS_MODULE=mysite.settings \
    --chdir=/opt/app-root/webapp/ \
    >>/var/log/uwsgi/uwsgi.log 2>&1

