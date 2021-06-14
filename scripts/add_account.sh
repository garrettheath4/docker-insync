#!/usr/bin/env bash

# Do sanity checks
if [ -z "${GDRIVE_ACCOUNT}" ]; then
    echo 'No Google Drive account given.'
    exit 1
fi

if [ -z "${GDRIVE_AUTHCODE}" ]; then
    echo 'No Google Drive authentication code given.'
    echo 'To get the authentication code, go to https://insynchq.com/auth?cloud=gd and follow prompts.'
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
