# reactioncommerce/node-prod

These Docker images are intended to be used as base images for running Reaction Commerce NodeJS projects in production (or any deployed environment). There is nothing overly specific to Reaction in them; you could use them for any NodeJS project as long as you follow the same patterns.

There are multiple versions of the Docker image, which are pushed to DockerHub as different tags, but the only difference is in which Node image they are based on, or in other words, which version of Node will run your program.

## Assumptions

- Your project uses NPM and not Yarn.
- Your project has a `./src` folder in which all of your source files live.
- Your project has a root `package.json` in which the `main` path points to some file in `./src`.

## Usage

Create a file named `Dockerfile` in the root of your project. If your project runs on Node 12, put this in the file:

```
FROM reactioncommerce/node-prod:12.10.0-v1
```

If your project runs on Node 10, put this in the file:

```
FROM reactioncommerce/node-prod:10.16.3-v1
```

If you need to pass any options to the `node` command to run your program properly, set the `NODE_OPTIONS` environment variable in your `Dockerfile`:

```
FROM reactioncommerce/node-prod:12.10.0-v1

ENV NODE_OPTIONS="--experimental-modules"
```

Nothing else should be necessary. You can build your image and try running your app:

```bash
docker build . -t my-app
docker run my-app
```

## About the images

Each `node-prod` base image has a few things baked in:
- The correct version of Node
- The latest version of NPM as of when the base image was built
- Node package binaries on PATH
- bash, curl, less, tini, and vim installed
- A bash shell
- A working directory of `/usr/local/src/app`, owned by the `node` user
- A default command that runs `node .`

And when using one of these images as `FROM` in your `Dockerfile`, the following will automatically happen when you `docker build`:

1. Copy `package.json`, `package-lock.json`, `LICENSE`, and the `src` folder into your image.
2. Run `npm ci --only=prod --ignore-scripts` in the image
