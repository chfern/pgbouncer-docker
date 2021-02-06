FROM ubuntu:20.04 as ubuntu

LABEL maintainer christyantofernando@gmail.com

RUN apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y --no-install-recommends \
  sudo \
  make \
  wget \
  build-essential \
  pkg-config \
  libevent-dev \
  libssl-dev

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

# TODO: Check cert
RUN wget https://www.pgbouncer.org/downloads/files/1.15.0/pgbouncer-1.15.0.tar.gz --no-check-certificate && \
  tar zxvf pgbouncer-1.15.0.tar.gz && \
  rm pgbouncer-1.15.0.tar.gz && \
  cd pgbouncer-1.15.0 && \
  ./configure --prefix=/usr/local && \
  make && \
  make install && \
  cd ../ && \
  rm -rf pgbouncer-1.15.0 && \
  rm -rf /var/lib/apt/lists/*

USER pgbouncer

EXPOSE 6432

ENTRYPOINT ["pgbouncer"]
CMD ["/etc/pgbouncer/pgbouncer.ini"]