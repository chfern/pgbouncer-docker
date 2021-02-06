FROM ubuntu:20.04 as ubuntu

LABEL maintainer christyantofernando@gmail.com

RUN mkdir -p /var/lib/pgbouncer && \
  mkdir -p /usr/local/src/pgbouncer && \
  mkdir -p /etc/pgbouncer && \
  touch /etc/pgbouncer/pgbouncer.ini && \
  touch /etc/pgbouncer/userlist.txt && \
  groupadd -r pgbouncer --gid=999 && \
  useradd -u 999 -g 999 pgbouncer --home-dir=/var/lib/pgbouncer && \
  chown -R pgbouncer:pgbouncer /var/lib/pgbouncer && \
  chown -R pgbouncer:pgbouncer /etc/pgbouncer

WORKDIR /usr/local/src/pgbouncer

ADD ./pgbouncer-1.15.0 .

RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  make \
  build-essential \
  pkg-config \
  libevent-dev \
  libssl-dev && \
  ./configure --prefix=/usr/local && \
  make && \
  make install && \
  rm -rf * && \
  rm -rf /var/lib/apt/lists/*

USER pgbouncer

EXPOSE 6432

ENTRYPOINT ["pgbouncer"]
CMD ["/etc/pgbouncer/pgbouncer.ini"]