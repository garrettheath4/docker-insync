#!/bin/bash

# Do sanity checks
if [ -z "${GDRIVE_ACCOUNT}" ]; then
    echo "No google drive account given. Exiting !"
    exit 1
fi

TERM=xterm /usr/bin/insync-headless manage_ignore_list ${GDRIVE_ACCOUNT}

exit 0
