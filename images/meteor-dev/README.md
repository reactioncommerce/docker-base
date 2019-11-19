# reactioncommerce/meteor-dev

These Docker images are intended to be used as images for running Reaction Commerce Meteor projects in while developing. There is nothing overly specific to Reaction in them; you could use them for any Meteor project as long as you follow the same patterns.

There are multiple versions of the Docker image, which are pushed to DockerHub as different tags, but the only difference is in which Meteor image they are based on, or in other words, which version of Meteor will run your program.

> `meteor-dev` images are the same as `node-dev` images except with Meteor preinstalled

## Assumptions

- Your project uses NPM and not Yarn.
- Your project has a root `package.json` with a "start:dev" script that runs the Meteor project in development mode

## Usage

Under the service in `docker-compose.yml`:

```
image: reactioncommerce/meteor-dev:1.8.1-v1
volumes:
  - .:/usr/local/src/app:cached
  - meteor_local:/usr/local/src/app/.meteor/local
  - node_modules:/usr/local/src/app/node_modules # do not link node_modules in, and persist it between dc up runs
```

This means "use the meteor-dev image and link in all files and folders in the project root directory except node_modules and .meteor/local".

The image is configured to always fix volume mount issues and run `npm install` when you start a new container.
