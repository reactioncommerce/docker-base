# reactioncommerce/meteor

These Docker images are intended to be used as base images for projects that need to run `meteor` CLI commands in the container.

There are multiple versions of the Docker image, which are pushed to DockerHub as different tags, but the only difference is in which Node image they are based on and which version of Meteor they include. They are tagged with the the Meteor version and include the same Node version that version of Meteor ships with.

## Assumptions

None

## Usage

Create a file named `Dockerfile` in the root of your project. Put this in the file, substituting the version of Meteor you need (if an image for it exists in this repo):

```
FROM reactioncommerce/meteor:1.8.1-v1
```

After the `FROM` line, add other directives that are necessary to build your image.

To build your image and try running your app:

```bash
docker build . -t my-app
docker run my-app
```
