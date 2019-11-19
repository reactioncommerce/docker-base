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

volumes=$(mount | grep -E '^/dev/' | grep -Ev ' on /etc/' || true)
if [[ -z "${volumes}" ]]; then
  exit
fi
owner=$(stat -c "%u:%g" .)
# if [[ "${owner}" =~ ^0: ]]; then
#   echo "$(basename "$0") aborting instead of chowning to root."
#   echo "Found owner ${owner} on ${PWD}."
#   exit
# fi

echo "${volumes}" | awk '{print $3}' | {
  while IFS= read -r dir; do
    echo "${dir}"
    mkdir -p "${dir}"
    chown -R node:node "${dir}"
    echo "✓"
  done
}
