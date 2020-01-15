# reactioncommerce/node-dev

These Docker images are intended to be used as images for running Reaction Commerce NodeJS projects in while developing. There is nothing overly specific to Reaction in them; you could use them for any NodeJS project as long as you follow the same patterns.

There are multiple versions of the Docker image, which are pushed to DockerHub as different tags, but the only difference is in which Node image they are based on, or in other words, which version of Node will run your program.

## Assumptions

- Your project uses NPM and not Yarn.
- Your project has a `./src` folder in which all of your source files live.
- Your project has a root `package.json` with a "start:dev" script that runs the Node project in development mode

## Usage

Under the service in `docker-compose.yml`:

```
image: reactioncommerce/node-dev:12.14.1-v1
volumes:
  - .:/usr/local/src/app:cached
  - reaction_api_node_modules:/usr/local/src/app/node_modules # do not link node_modules in, and persist it between dc up runs
```

This means "use the node-dev image and link in all files and folders in the project root directory except node_modules".

The image is configured to always run `npm install` when you start a new container.
