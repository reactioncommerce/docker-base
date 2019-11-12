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

dockerfiles_to_process() {
  declare -a args=($@)
  if [[ ${#args[@]} -gt 0 ]]; then
    printf '%s\n' "${args[@]}"
    return
  fi
  git ls-files | grep -e '/Dockerfile$'
}

main() {
  cd "$(dirname "${BASH_SOURCE[0]}")"
  root_dir="$(pwd -P)"
  subcommand="$1"
  shift

  dockerfiles_to_process "$@" | {
    while IFS= read -r file_path; do
      name=$(echo "${file_path}" |  awk -F / '{print $(NF-2)}')
      context_dir=$(dirname "${file_path}")
      tag=$(echo "${file_path}" |  awk -F / '{print $(NF-1)}')
      case "${subcommand}" in
      build)
        # Copy root /scripts to context /scripts
        context_scripts_dir="${context_dir}/scripts"
        root_scripts_dir="${root_dir}/scripts"
        cp -a "${root_scripts_dir}/." "${context_scripts_dir}"

        # Do build
        docker build -t "reactioncommerce/${name}:${tag}" "${context_dir}"
        ;;
      push)
        docker push "reactioncommerce/${name}:${tag}"
        ;;
      *)
        echo "Usage $0 <build|push> [dockerfile_path...]" 1>&2
        exit 1
        ;;
      esac

    done
  }
}

main "$@"
