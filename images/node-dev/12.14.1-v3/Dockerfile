FROM node:12.14.1-alpine

# hadolint ignore=DL3018
RUN apk --no-cache --update add bash curl less shadow su-exec tini vim python2 make git
SHELL ["/bin/bash", "-o", "pipefail", "-o", "errexit", "-u", "-c"]

# Allow yarn/npm to create ./node_modules
RUN mkdir -p /usr/local/src/app && chown node:node /usr/local/src/app

# Install the latest version of NPM (as of when this
# base image is built)
RUN npm i -g npm@latest

# Install yalc for use with the
# package-(link|unlink|update) scripts
RUN npm i -g yalc

COPY ./scripts /usr/local/src/app-scripts

WORKDIR /usr/local/src/app
ENV PATH=$PATH:/usr/local/src/app/node_modules/.bin \
    BUILD_ENV=development NODE_ENV=development

# hadolint ignore=DL3002
USER root
ENTRYPOINT ["tini", "--", "/usr/local/src/app-scripts/entrypoint.sh"]
