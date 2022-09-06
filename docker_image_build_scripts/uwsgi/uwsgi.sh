#!/bin/sh
#
#
USER_NAME=default
USER_HOME=/opt/app-root/src

exec /usr/local/bin/uwsgi \
    --socket /tmp/uwsgi.sock \
    --chmod-socket=666 \
    --ini $USER_HOME/uwsgi-config.ini

#exec /usr/local/bin/uwsgi \
#    --socket /tmp/uwsgi.sock \
#    --chmod-socket=666 \
#    --master \
#    --wsgi-file /opt/app-root/src/main.wsgi \
#    >>/var/log/uwsgi/uwsgi.log 2>&1

# exec /usr/local/bin/uwsgi \
#     --socket /tmp/uwsgi.sock \
#     --chmod-socket=666 \
#     --master \
#     --processes=5 \                 
#     --harakiri=20 \          
#     --max-requests=5000 \
#     --wsgi-file /opt/app-root/webapp/mysite/wsgi.py \
#     --home /opt/app-root/webapp/ve/ \
#     --env DJANGO_SETTINGS_MODULE=mysite.settings \
#     --chdir=/opt/app-root/webapp/ \
#     >>/var/log/uwsgi/uwsgi.log 2>&1

