#!/usr/bin/env bash

auth_code="$1"

if [ $# -lt 1 ]; then
	echo 'Warning: No GDRIVE_AUTHCODE received.'
	echo '         Exiting cleanly for automated build purposes.'
	echo "Date: $(date)"
else
	echo 'Starting Insync'
	/usr/bin/insync-headless start
	echo "start => $?"

	sleep 5

	/usr/bin/insync-headless set_autostart yes
	echo "autostart => $?"

	echo "Adding account with auth code: $auth_code"
	add_output=$(/usr/bin/insync-headless add_account --auth-code "$auth_code" --path /data --export-option link)
	add_exit_code=$?
	echo "add_account :> $add_output"
	echo "add_account => $add_exit_code"

	if [[ $add_output = "Error"* ]]; then
		echo 'Error detected, exiting with code 1'
		exit 1
	else
		# run forever since insync-headless is running in the background
		tail -f /dev/null
	fi
fi
