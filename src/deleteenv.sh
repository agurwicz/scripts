# Obtained from https://github.com/agurwicz/scripts.
# Deletes a Python environment.

usage_message="
Usage: `basename ${0}` environment_name
    environment_name    name of the environment to be deleted
"

if [[ "${0}" == "${BASH_SOURCE}" ]]; then sourced=false; else sourced=true; fi
source "$(dirname "$(command -v ${0})")/commonscripts.sh"
usage "${1}" "${usage_message}"
check_variables "python_environments_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

environment_name="${1}"

rm -rf "${python_environments_path}/${environment_name}"
