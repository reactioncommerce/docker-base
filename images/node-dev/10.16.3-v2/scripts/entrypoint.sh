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

run_user="node"
# change the node user's uid:gid to match the repo root directory's
usermod --uid "$(stat -c "%u" .)" --non-unique "${run_user}" |& grep -v "no changes" || true
"$(dirname "${BASH_SOURCE[0]}")/fix-volumes.sh"
command=(npm run start:dev)
if [[ $# -gt 0 ]]; then
  # shellcheck disable=SC2206
  command=($@)
fi
echo "Installing dependencies..."
if [[ -f /usr/local/src/app/yarn.lock ]]; then
  echo "(Using Yarn because there is a yarn.lock file)"
  su-exec node yarn install
else
  su-exec node npm install --no-audit
fi
echo "Starting the project in development mode..."
unset IFS
exec su-exec "${run_user}" "${command[@]}"
