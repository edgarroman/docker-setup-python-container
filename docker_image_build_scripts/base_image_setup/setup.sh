#!/bin/bash
set -e
# Activate some helper utilities that we'll us in this file like 'header', 'run', and 'chgroup_dir_to_rw_zero'
source ${IMAGE_BUILD_ROOT}/helpers/helper_functions

header "Base Image Setup"

# ensure all newly created directories and files are group accessible
run umask 002

# For the application service scripts and configs
run mkdir -p ${APP_SCRIPTS}

# For binaries and scripts
run mkdir -p ${SETUP_DIR_BIN}

# For daemons and network services
run mkdir -p ${SETUP_DIR_SBIN}

# When running an interactive bash shell, we want to customize the prompt and other
# environment preferences.  Since the user we are using does not have a home directory,
# we'll just plop the .bashrc in the root directory.  Bash will look in the root as part 
# of the rc search process
run cp -r ${IMAGE_BUILD_ROOT}/base_image_setup/custom.bashrc /.bashrc

header "Installing tini"

TINI_VERSION=v0.19.0
run wget https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini -O $SETUP_DIR_SBIN/tini

# Use these lines if you want to 
#run wget https://github.com/krallin/tini/releases/download/$TINI_VERSION/tini.asc -O $SETUP_DIR_SBINtini.asc
##run gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \
## && gpg --verify /tini.asc
run chmod g+x ${SETUP_DIR_SBIN}/tini


##########################################################################
# Install our entrypoint script to handle when started as a random user
run cp -r ${IMAGE_BUILD_ROOT}/base_image_setup/entrypoint.sh $SETUP_DIR_BIN/entrypoint.sh
run chmod g+x $SETUP_DIR_BIN/entrypoint.sh

# This is our little startup script
run cp -r ${IMAGE_BUILD_ROOT}/base_image_setup/init.sh $SETUP_DIR_BIN/init.sh
run chmod g+x $SETUP_DIR_BIN/init.sh

##########################################################################
# For all the files we created we need to assign them to group zero and allow users of group zero
# to be able to read and write
chgroup_dir_to_rw_zero ${APP_SCRIPTS}
chgroup_dir_to_rw_zero ${SETUP_DIR_BIN}
chgroup_dir_to_rw_zero ${SETUP_DIR_SBIN}

