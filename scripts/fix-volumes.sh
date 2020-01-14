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

if [[ "$#" -ne 1 ]]; then
  echo "Usage: $0 [desired_owner_user]" 1>&2
  exit 1
fi

volumes=$(mount | grep -E '^/dev/' | grep -Ev ' on /etc/' || true)
if [[ -z "${volumes}" ]]; then
  echo "fix-volumes: No volumes found"
  exit
fi

desired_owner_user=$1
owner="$(id -u ${desired_owner_user}):$(id -g ${desired_owner_user})"
if [[ "${owner}" =~ ^0: ]]; then
  echo "fix-volumes: $(basename "$0") aborting instead of chowning to root."
  echo "fix-volumes: Found owner ${owner} on ${PWD}."
  exit
fi

echo "fix-volumes: Fixing all volumes to be owned by user '${desired_owner_user}''"
echo "${volumes}" | awk '{print $3}' | {
  while IFS= read -r dir; do
    mkdir -p "${dir}"
    old_owner=$(stat -c "%u:%g" "${dir}")
    if [[ "$1" != "--force" && "${old_owner}" == "${owner}" ]]; then
      echo "fix-volumes: Skipping volume ${dir}. Already owned by ${owner}"
      continue
    fi
    printf "fix-volumes: Fixing volume %s (before=%s after=%s)…" "${dir}" "${old_owner}" "${owner}"
    chown -R "${owner}" "${dir}"
    chmod -R a+r,u+rw "${dir}"
    echo "✓"
  done
}
