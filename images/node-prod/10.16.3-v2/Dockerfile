FROM node:10.16.3-alpine

# hadolint ignore=DL3018
RUN apk --no-cache add bash curl less tini vim make python2
SHELL ["/bin/bash", "-o", "pipefail", "-o", "errexit", "-u", "-c"]

WORKDIR /usr/local/src/app
ENV PATH=$PATH:/usr/local/src/app/node_modules/.bin

# Allow yarn/npm to create ./node_modules
RUN chown node:node .

# Install the latest version of NPM (as of when this
# base image is built)
RUN npm i -g npm@latest

# Copy specific things so that we can keep the image
# as small as possible without relying on each repo
# to include a .dockerignore file.
ONBUILD ARG NPM_TOKEN
ONBUILD COPY --chown=node:node package.json ./
ONBUILD COPY --chown=node:node package-lock.json .npmrc* LICENSE* ./
ONBUILD COPY --chown=node:node ./src ./src

USER node

# Install dependencies
ONBUILD RUN npm ci --only=prod --ignore-scripts
# delete npm token
ONBUILD RUN rm -f .npmrc || :

# If any Node flags are needed, they can be set in
# the NODE_OPTIONS env variable.
#
# NOTE: We would prefer to use `node .` but relying on
# Node to look up the `main` path is currently broken
# when ECMAScript module support is enabled. When this
# is fixed, change command to:
#
# CMD ["tini", "--", "node", "."]
#
CMD ["tini", "--", "npm", "start"]
