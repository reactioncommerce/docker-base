# Change Log

## 12.14.1-v1

Create a new image, `12.14.1-v1`, which:

- is updated to the 12.14.1 LTS version of Node
- uses the same entry point script as `12.10.0-v3` but with a slight change to the last `echo` so that "Starting the project in development mode..." is printed only for `docker-compose up` and not for `docker-compose run`.

## 10.16.3-v3 and 12.10.0-v3

Fix a bug in the `entrypoint.sh` script so it will not run as root.

## 10.16.3-v2 and 12.10.0-v2

The `node-dev` images `10.16.3-v2` and `12.10.0-v2` are the same as `v1` except that the entry point script, if it sees a `yarn.lock` file, will install dependencies using Yarn instead.
