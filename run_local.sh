#!/usr/bin/env bash

docker start insync || docker run -d --env-file .env --name insync garrettheath4/docker-insync
