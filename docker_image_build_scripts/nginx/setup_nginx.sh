#!/bin/bash
set -e
# Activate some helper utilities that we'll us in this file like 'header', 'run', and 'chgroup_dir_to_rw_zero'
source ${IMAGE_BUILD_ROOT}/helpers/helper_functions

header "Setting up NGINX core"

run apt -y install nginx

header "Setting up NGINX hooks"

# Allows application to override NGINX settings
NGINX_USER_CONF_DIR=${APP_SCRIPTS}/etc/

# Main.d is used to add entries at the root level of nginx.conf
NGINX_CORE_MAIN_CONF_DIR=/etc/nginx/main.d/
# conf.d is used to add entries at the http level of nginx.conf
NGINX_CORE_CONF_DIR=/etc/nginx/conf.d/

# Do the system setup. Essentially we are creating the core nginx.conf
# file as well as creating /etc/nginx/conf.d/ directory that can be used
# to add numerous separate and distinct .conf files
run mkdir -p $NGINX_CORE_MAIN_CONF_DIR
run mkdir -p $NGINX_CORE_CONF_DIR
run cp -r ${IMAGE_BUILD_ROOT}/nginx/config/nginx_core.conf /etc/nginx/nginx.conf

# Do the local user setup
# By symbolic linking of the user nginx.conf file to the nginx conf directory
# the user may push updates to nginx without needing root access
run mkdir -p $NGINX_USER_CONF_DIR
run cp -r ${IMAGE_BUILD_ROOT}/nginx/config/nginx_user.conf $NGINX_USER_CONF_DIR/nginx.conf
run ln -s $NGINX_USER_CONF_DIR/nginx.conf $NGINX_CORE_CONF_DIR/nginx.conf

# Uncomment this to halt auto-start of nginx
# run touch /etc/service/nginx/down

# Log rotation
# In the file /etc/logrotate.d/nginx
#  Change the line from
#     invoke-rc.d nginx rotate
#  to
#    sv 1 nginx
#  What this does it allow runit to signal nginx with USR1 which tells nginx
#  to re-open the logfiles
#
#run sed -i 's|invoke-rc.d nginx rotate|sv 1 nginx|' /etc/logrotate.d/nginx

header "Fixup NGINX to run as non root"
# Now do extra configuration to allow NGINX to run as unprivileged user
chgroup_dir_to_rw_zero "/var/run/nginx"
chgroup_dir_to_rw_zero "/var/log/nginx"
chgroup_dir_to_rw_zero "/var/lib/nginx"
chgroup_dir_to_rw_zero "/etc/nginx"
chgroup_dir_to_rw_zero "/etc/service/nginx"
chgroup_dir_to_rw_zero $NGINX_CORE_MAIN_CONF_DIR
chgroup_dir_to_rw_zero $NGINX_USER_CONF_DIR
