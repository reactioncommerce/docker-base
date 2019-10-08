# Reaction Docker Base Images

This repo contains general Docker images used by various [Reaction Commerce](https://www.reactioncommerce.com/index) projects. Refer to the specific image documentation.

Images:

- [node-dev](./images/node-dev/README.md)
- [node-prod](./images/node-prod/README.md)

## Published Images

Every merge/push to `trunk` branch will rebuild all `Dockerfiles` and push them to DockerHub as part of the CircleCI workflow. If you add a new image, add it to the workflow steps in `.circleci/config.yml`.

These are the published image tags:

- [reactioncommerce/node-dev](https://hub.docker.com/r/reactioncommerce/node-dev/tags)
- [reactioncommerce/node-prod](https://hub.docker.com/r/reactioncommerce/node-prod/tags)
