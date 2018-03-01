#!/usr/bin/env bash
# run_interactive.sh

container_name=insync-container

if ( docker container ls --all --filter name="$container_name" | grep -F "$container_name" > /dev/null ); then
	echo "Removing existing container"
	docker container rm insync-container > /dev/null
fi

echo "Creating new container"
docker run --interactive --tty --env-file .env --name insync-container insync
