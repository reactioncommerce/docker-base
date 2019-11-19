FROM reactioncommerce/meteor:1.8.1-v1

# hadolint ignore=DL3002
USER root

RUN apt-get update && apt-get install sudo

COPY ./scripts /usr/local/src/app-scripts

# Ensure that all files will be linked in owned by node user.
# Every directory that will be listed in `volumes` section of
# docker-compose.yml needs to be pre-created and chown'd here.
# See https://github.com/docker/compose/issues/3270#issuecomment-363478501
RUN mkdir -p /usr/local/src/app && chown node:node /usr/local/src/app

WORKDIR /usr/local/src/app
ENV PATH=$PATH:/usr/local/src/app/node_modules/.bin \
    BUILD_ENV=development NODE_ENV=development

ENTRYPOINT ["/usr/local/src/app-scripts/entrypoint.sh"]
