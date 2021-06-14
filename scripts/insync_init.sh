#!/usr/bin/env bash

auth_code="$1"

if [ $# -lt 1 ]; then
	echo 'Warning: No GDRIVE_AUTHCODE received.'
	echo '         Exiting cleanly for automated build purposes.'
	echo "Date: $(date)"
else
	echo 'Starting Insync'
	/usr/bin/insync-headless start

	sleep 5

	if [ -z "$(/usr/bin/insync-headless get_account_information)" ]; then

		echo "Adding account with auth code: $auth_code"
		#add_output=$(/usr/bin/insync-headless add_account --auth-code "$auth_code" --path /data --export-option link)
		#echo "add_account :> $add_output"
		yes yes | /usr/bin/insync-headless add_account --auth-code "$auth_code" --path /data --export-option link

		#if [[ $add_output = "Error"* ]] || [[ $add_output = "Login error"* ]]; then
		#	echo 'Error detected, exiting with code 1'
		#	exit 1
		#else
			# run forever since insync-headless is running in the background
			tail -f ~/.config/Insync/out.txt || tail -f /dev/null
		#fi
	else
		/usr/bin/insync-headless get_account_information
		echo "Insync account already added"
		tail -f ~/.config/Insync/out.txt || tail -f /dev/null
	fi
fi
