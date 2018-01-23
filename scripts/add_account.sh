#!/usr/bin/env bash

# Do sanity checks
if [ -z "${GDRIVE_ACCOUNT}" ]; then
    echo 'No Google Drive account given.'
    exit 1
fi

if [ -z "${GDRIVE_AUTHCODE}" ]; then
    echo 'No Google Drive authentication code given.'
    echo 'To get the authenticatiom code, go to http://goo.gl/kTvy0y and follow prompts.'
    exit 2
fi

if [ -n "${GDRIVE_ACCOUNT}" ] && [ -n "${GDRIVE_AUTHCODE}" ]; then
    mkdir -p "/data/${GDRIVE_ACCOUNT}"
    /usr/bin/insync-headless add_account -a "${GDRIVE_AUTHCODE}" -p "/data/${GDRIVE_ACCOUNT}"
    /usr/bin/insync-headless set_autostart yes
else
    echo 'ERROR: GDRIVE_ACCOUNT or GDRIVE_AUTHCODE were not set.'
    exit 3
fi

exit 0
