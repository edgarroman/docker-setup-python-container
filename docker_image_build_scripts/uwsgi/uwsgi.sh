#!/bin/sh
#
#

exec /usr/local/bin/uwsgi \
    --socket /tmp/uwsgi.sock \
    --chmod-socket=666 \
    --vacuum \
    --master \
    --processes=5 \
    --harakiri=20 \
    --max-requests=5000 \
    --ini $APP_SCRIPTS/uwsgi-config.ini
# \
#>>/var/log/uwsgi/uwsgi.log 2>&1
