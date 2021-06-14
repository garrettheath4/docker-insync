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


### Get Authorization Code

<!-- Note: Please update the [AuthCodeUrl] URL at the bottom of this file if the URL in this section changes -->

* Full URL

        https://accounts.google.com/AccountChooser?continue=https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fv2%2Fauth%3Fscope%3Demail%2Bprofile%2Bhttps%253A%252F%252Fwww.googleapis.com%252Fauth%252Fdrive%2Bhttps%253A%252F%252Fwww.googleapis.com%252Fauth%252Factivity%26redirect_uri%3Durn%253Aietf%253Awg%253Aoauth%253A2.0%253Aoob%26hl%3Den%26client_id%3D468017360789.apps.googleusercontent.com%26response_type%3Dcode%26access_type%3Doffline

    * Base URL: `https://accounts.google.com/AccountChooser`
    * `?continue=` URL encoded version of:

            https://accounts.google.com/o/oauth2/v2/auth?scope=email+profile+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fdrive+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Factivity&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&hl=en&client_id=468017360789.apps.googleusercontent.com&response_type=code

        * Sub URL: `https://accounts.google.com/o/oauth2/auth`
        * `?scope=` URL encoded version of:

                email+profile+https://www.googleapis.com/auth/drive+https://www.googleapis.com/auth/activity

        * `&redirect_uri=` URL encoded version of:

                urn:ietf:wg:oauth:2.0:oob

        * `&hl = en`
        * `&client_id=468017360789.apps.googleusercontent.com`
        * `&response_type=code`
        * `&access_type=offline`


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
[AuthCodeUrl]: https://accounts.google.com/AccountChooser?continue=https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fv2%2Fauth%3Fscope%3Demail%2Bprofile%2Bhttps%253A%252F%252Fwww.googleapis.com%252Fauth%252Fdrive%2Bhttps%253A%252F%252Fwww.googleapis.com%252Fauth%252Factivity%26redirect_uri%3Durn%253Aietf%253Awg%253Aoauth%253A2.0%253Aoob%26hl%3Den%26client_id%3D468017360789.apps.googleusercontent.com%26response_type%3Dcode%26access_type%3Doffline

