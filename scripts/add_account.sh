#!/bin/bash

# Do sanity checks
if [ -z "${GDRIVE_ACCOUNT}" ]; then
    echo "No google drive account given. Exiting !"
    exit 1
fi

if [ -z "${GDRIVE_AUTHCODE}" ]; then
    echo "No google drive authentication code given. Exiting !"
    echo "To get the authenticatiom code, go to http://goo.gl/kTvy0y and follow prompts."
    exit 1
fi

mkdir -p "/data/${GDRIVE_ACCOUNT}"
/usr/bin/insync-headless add_account -a "${GDRIVE_AUTHCODE}" -p "/data/${GDRIVE_ACCOUNT}"
/usr/bin/insync-headless set_autostart yes

exit 0
