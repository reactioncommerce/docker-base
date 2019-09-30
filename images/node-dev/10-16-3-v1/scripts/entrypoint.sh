#!/usr/bin/env bash

# Please Use Google Shell Style: https://google.github.io/styleguide/shell.xml

# ---- Start unofficial bash strict mode boilerplate
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -o errexit  # always exit on error
set -o errtrace # trap errors in functions as well
set -o pipefail # don't ignore exit codes when piping output
set -o posix    # more strict failures in subshells
# set -x          # enable debugging

IFS=$'\n\t'
# ---- End unofficial bash strict mode boilerplate

cd /usr/local/src/app
# change the node user's uid:gid to match the repo root directory's
usermod --uid "$(stat -c "%u" .)" --non-unique node |& grep -v "no changes" || true
/usr/local/src/app-scripts/fix-volumes.sh
unset IFS
echo "Installing dependencies..."
su-exec node npm install --no-audit
echo "Starting the project in development mode..."
exec su-exec node npm run start:dev
