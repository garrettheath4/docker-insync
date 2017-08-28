#!/bin/bash

# Do sanity checks
if [ -z "${GDRIVE_ACCOUNT}" ]; then
    echo "No Google Drive account given."
fi

if [ -z "${GDRIVE_AUTHCODE}" ]; then
    echo "No Google Drive authentication code given."
    echo "To get the authenticatiom code, go to http://goo.gl/kTvy0y and follow prompts."
fi

if [ -n "${GDRIVE_ACCOUNT}" ] && [ -n "${GDRIVE_AUTHCODE}" ]; then
    mkdir -p "/data/${GDRIVE_ACCOUNT}"
    /usr/bin/insync-headless add_account -a "${GDRIVE_AUTHCODE}" -p "/data/${GDRIVE_ACCOUNT}"
    /usr/bin/insync-headless set_autostart yes
fi

exit 0
