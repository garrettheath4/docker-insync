#!/usr/bin/env bash
# run_bash.sh

docker run -it --env-file .env --name insync-container insync bash
