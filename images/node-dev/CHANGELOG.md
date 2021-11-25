# Change Log

## 14.18.1-v1

- Update node base to 14.18.1

## 14.11.0-v1

- New base dev and prod images based on node v14.11.0
- Had to add g++ alpine package as a dependency to get sharp dependency to build

## 12.14.1-v1

Create a new image, `12.14.1-v1`, which:

- is updated to the 12.14.1 LTS version of Node
- uses the same entry point script as `12.10.0-v4` but with a slight change to the last `echo` so that "Starting the project in development mode..." is printed only for `docker-compose up` and not for `docker-compose run`.

## 10.16.3-v4 and 12.10.0-v4

Update the `fix-volumes.sh` script so it will fix volumes correctly on Mac while still working on Linux, too. Also better "fix-volumes" logging.

## 10.16.3-v3 and 12.10.0-v3

Fix a bug in the `entrypoint.sh` script so it will not run as root.

## 10.16.3-v2 and 12.10.0-v2

The `node-dev` images `10.16.3-v2` and `12.10.0-v2` are the same as `v1` except that the entry point script, if it sees a `yarn.lock` file, will install dependencies using Yarn instead.
