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

cd "$(dirname "${BASH_SOURCE[0]}")/.."
declare -a CI_SCRIPTS=(npx --quiet --package @reactioncommerce/ci-scripts@1.8.4)
"${CI_SCRIPTS[@]}" lint-dockerfiles
"${CI_SCRIPTS[@]}" lint-shell-scripts
./dockerfiles.sh build
if [[ -n "${CIRCLE_PR_USERNAME}" ]]; then
   echo "No deploy for forks"
   exit
fi
if [[ "$(git rev-parse --abbrev-ref HEAD)" != "trunk" ]]; then
   echo "Only docker push the trunk git branch"
   exit
fi
docker login -u "$DOCKER_USER" -p "$DOCKER_PASS"
./dockerfiles.sh push
