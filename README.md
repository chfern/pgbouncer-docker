# PgBouncer

A Dockerized pgBouncer for postgres connection pooling. This image is available in [dockerhub](https://hub.docker.com/repository/docker/fernandochristyanto/pgbouncer) for pulling.

## How To Use This Image

### Configuration File Setup

1. Create a `pgbouncer.ini` file, refer to `pgbouncer.ini.example`
2. Create a `userlist.txt` file, refer to `userlist.txt.example`

### Running the container

This image expects pgbouncer configuration files to be placed in `/etc/pgbouncer/*`.  
To run a container, execute:

```sh
docker run -it  \
-v $(pwd)/pgbouncer.ini:/etc/pgbouncer/pgbouncer.ini \
-v $(pwd)/userlist.txt:/etc/pgbouncer/userlist.txt \
fernandochristyanto/pgbouncer:1.15.0
```

This container exposes pgbouncer at port `6432`