# Reaction Docker Base Images

[![CircleCI](https://circleci.com/gh/reactioncommerce/docker-base/tree/trunk.svg?style=svg)](https://circleci.com/gh/reactioncommerce/docker-base/tree/trunk)

This repo contains general Docker images used by various [Reaction Commerce](https://www.reactioncommerce.com/index) projects. Refer to the specific image documentation.

Images:

- [node-dev](./images/node-dev/README.md)
- [node-prod](./images/node-prod/README.md)
- [meteor](./images/meteor/README.md)

## Published Images

Every merge/push to `trunk` branch will rebuild all `Dockerfiles` and push them to DockerHub as part of the CircleCI workflow.

These are the published image tags:

- [reactioncommerce/node-dev](https://hub.docker.com/r/reactioncommerce/node-dev/tags)
- [reactioncommerce/node-prod](https://hub.docker.com/r/reactioncommerce/node-prod/tags)
- [reactioncommerce/meteor](https://hub.docker.com/r/reactioncommerce/meteor/tags)

## Adding a New Image

In `/images`, add a new folder named whatever you want the image name to be. In that folder, add a subfolder for each version of the image. This could be based on a version of the FROM image, the version of a dependency that is installed in it, or whatever else makes sense for that image. Regardless, append `-v1` to the version folder name so that changes can be made in the future and published with a new tag, even if the underlying version designator hasn't changed.

In each version folder, add a file named `Dockerfile`. In it, define the image you want to build. If you need to copy any scripts into your image and run them, put them in a subfolder named `scripts` alongside your `Dockerfile`. Alternatively, if multiple images need the same script, you can place it in `/scripts` at the project root. All files there are copied into the image-specific `scripts` folder before each image is built. To copy them into your image, add something like this line to your `Dockerfile`:

```Dockerfile
COPY ./scripts /usr/local/src/app-scripts
```

## Building an Image

On your development computer, you can test building an image with this command:

```sh
./dockerfiles.sh build images/image-name/version/Dockerfile
```

Substitute the proper path to your Dockerfile.

If for some reason you want to test building all images, you can leave off the Dockerfile path:

```sh
./dockerfiles.sh build
```

## Pushing an Image to DockerHub

The command `./dockerfiles.sh push` will push all built images to DockerHub, but you need proper permissions. It's best to let CircleCI do this, which it does after every successful merge to `trunk`.
