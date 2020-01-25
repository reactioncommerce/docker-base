# Some Meteor commands fail if we use one of the slimmer Node images.
# Meteor 1.9.0 ships with Node 12.14.0. Be sure to keep these two versions in sync
# when making new versions of this image.
FROM node:12.14.0

SHELL ["/bin/bash", "-o", "pipefail", "-o", "errexit", "-u", "-c"]

ENV METEOR_VERSION 1.9
ENV PATH $PATH:/home/node/.meteor

USER node

# Install Meteor. Copy the install script to a temp file first, so that we can
# replace the hard-coded `RELEASE` var in the script with the release we want installed.
RUN wget -O /tmp/install_meteor.sh https://install.meteor.com \
 && sed -i.bak "s/RELEASE=.*/RELEASE=\"$METEOR_VERSION\"/g" /tmp/install_meteor.sh \
 && printf "\\n[-] Installing Meteor %s...\\n" "$METEOR_VERSION" \
 && sh /tmp/install_meteor.sh \
 && rm /tmp/install_meteor.sh

LABEL maintainer="Reaction Commerce <engineering@reactioncommerce.com>"
