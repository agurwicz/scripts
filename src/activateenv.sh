# Obtained from https://github.com/agurwicz/scripts.
# Activates a Python environment.

usage_message="
Usage: source `basename ${0}` environment_name
    environment_name    name of the environment to be activated
"

if [[ "${0}" == "${BASH_SOURCE}" ]]; then sourced=false; else sourced=true; fi
source "$(dirname "$(command -v ${0})")/commonscripts.sh"
usage "${1}" "${usage_message}"
check_variables "python_environments_path" "python_relative_path" "activate_relative_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

if [[ ${sourced} == false ]]; then echo "Error: Script must be sourced."; exit 1; fi

environment_name="${1}"

check_environment "${environment_name}" || return 1

source "${python_environments_path}/${environment_name}/${activate_relative_path}"
