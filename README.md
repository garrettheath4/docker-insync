Summary
-------

Docker image for synchronizing files with Google Drive using Insync (https://www.insynchq.com/).
Insync is a Google Drive synchronization client that work well on linux. You need to buy a
licence for using Insync.


Build the Image
---------------

To create this image, execute the following command in the docker-insync folder.

    docker build \
        -t garrettheath4/insync \
        .


Run the Image
-------------

Execute the following command to run your image. The first time it started, you need
to add your Google account and eventually select the files to synchronize.

    docker run \
        --name insync \
        --volumes-from <data volume container> \
        --detach \
        garrettheath4/insync:latest


Setup Insync
------------

You first need to setup Insync in order to synchronize your files with Google
Drive. To get the authenticatiom code, go to https://goo.gl/jv797S and follow
prompts.

    docker exec \
        -i \
        -t \
        insync \
        /usr/local/bin/add_account.sh <account> <auth_code>

Then optionally, select the files to synchronize. You certainly not need to
synchronize all your drive here.

    docker exec \
        -i \
        -t \
        insync \
        /usr/local/bin/manage_sync.sh <account>

It will start a curses interface for selecting the files to synchronize. You could
also manage the files to ignore.

    docker exec \
        -i \
        -t \
        insync \
        /usr/local/bin/manage_ignore.sh <account>

It will start a curses interface to manage the ignore list.
