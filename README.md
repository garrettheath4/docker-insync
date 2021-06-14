Insync for Docker
=================


Summary
-------

Docker image for synchronizing files with Google Drive using [Insync].
Insync is a Google Drive synchronization client that works well on Linux. You
need to buy a licence to use Insync.


Configuration
-------------

This project is designed to automatically link Insync to an existing Google
Drive account upon startup. To do this, the following environment variables must
be set either individually as `--env` arguments to the `docker run` command or
stored in a file (for example: `.env`) to be loaded by `docker run` using the
`--env-file` argument.

    GDRIVE_ACCOUNT=garrettheath4
    GDRIVE_AUTHCODE=4/Z3ab...<REDACTED>

The `GDRIVE_AUTHCODE` can be found by [clicking here][AuthCodeUrl] and
following the prompts.


Run the Image
-------------

Execute the following command to run your image. If the container is properly
configured, Insync will automatically start, link to the Google Drive account
affiliated with the `GDRIVE_AUTHCODE` variable (see above), and begin syncing
all files to the `/data/${GDRIVE_ACCOUNT}` directory within the container.

    docker run \
        --name insync \
        --volumes-from <data volume container> \
        --detach \
        garrettheath4/docker-insync:latest


Build the Image
---------------

This image is automatically built on [Docker Hub] whenever new changes are
pushed to the [GitHub repository].

To manually build this image, execute the following command in the
`docker-insync` project folder.

    docker build \
        -t garrettheath4/docker-insync \
        .


Manually Configure Insync
-------------------------


### Add an Account

Run the following command if the automatic configuration doesn't work or if you
need to link more than one Google Drive account. To get the authentication code,
[click here][AuthCodeUrl] and follow the prompts.

    docker exec \
        -i \
        -t \
        insync \
        /usr/local/bin/add_account.sh <account> <auth_code>


### Select Files to Sync

By default, all files in Google Drive will be synced. Run the following command
to only sync specific files.

    docker exec \
        -i \
        -t \
        insync \
        /usr/local/bin/manage_sync.sh <account>

Run the following command to ignore specific files.

    docker exec \
        -i \
        -t \
        insync \
        /usr/local/bin/manage_ignore.sh <account>


Reference
---------

* [_Gotchas in Writing Dockerfile_][gotchas] from kimh.github.io



<!-- Links -->
[Insync]: https://www.insynchq.com/
[Docker Hub]: https://hub.docker.com/r/garrettheath4/docker-insync/
[GitHub repository]: https://github.com/garrettheath4/docker-insync
[gotchas]: http://kimh.github.io/blog/en/docker/gotchas-in-writing-dockerfile-en/
<!-- Note: Please update the URL in the "Get Authorization Code" section if AuthCodeUrl changes -->
[AuthCodeUrl]: https://insynchq.com/auth?cloud=gd

