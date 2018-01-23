FROM debian:jessie
MAINTAINER Garrett Heath Koller, garrettheath4@gmail.com
#Based on the work of Christophe Burki, christophe.burki@gmail.com

# install system requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
    locales \
    wget && \
    apt-get autoremove -y && \
    apt-get clean

RUN echo "deb http://apt.insynchq.com/ubuntu trusty non-free contrib" > /etc/apt/sources.list.d/insync.list && \
    wget --no-check-certificate -O - https://d2t3ff60b2tol4.cloudfront.net/services@insynchq.com.gpg.key | apt-key add - && \
    apt-get update && apt-get install -y --no-install-recommends \
    insync-headless && \
    apt-get clean

# configure locales and timezone
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen && \
    cp /usr/share/zoneinfo/America/New_York /etc/localtime && \
    echo "America/New_York" > /etc/timezone

# s6 install and config
COPY bin/* /usr/bin/
COPY configs/etc/s6 /etc/s6/
RUN chmod a+x /usr/bin/s6-* && \
    chmod a+x /etc/s6/.s6-svscan/finish /etc/s6/insync/run /etc/s6/insync/finish

# install scripts
COPY scripts/* /usr/local/bin/
RUN chmod a+x /usr/local/bin/*

# initialize Insync
RUN mkdir -p /data
ENTRYPOINT /usr/bin/insync-headless start && sleep 2 && \
           /usr/bin/insync-headless set_autostart yes && \
           /usr/bin/insync-headless add_account --auth-code "${GDRIVE_AUTHCODE}" --path /data --export-option link && \
           /usr/bin/insync-headless quit && \
           /usr/bin/insync-headless start --no-daemon

# CMD ["/usr/bin/s6-svscan", "/etc/s6"]
# CMD ["/etc/s6/insync/run"]
# CMD /bin/bash
# CMD ["/usr/bin/insync-headless", "start", "--no-daemon"]
