# Some Meteor commands fail if we use one of the slimmer Node images.
# Make sure we use the exact version of node shipped with this exact
# version of meteor.
# For example, check this file for your meteor release tag of interest:
# https://github.com/meteor/meteor/blob/release/METEOR%401.11.1/meteor#L3
FROM node:14.17.1

SHELL ["/bin/bash", "-o", "pipefail", "-o", "errexit", "-u", "-c"]

ENV METEOR_VERSION 2.3
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
