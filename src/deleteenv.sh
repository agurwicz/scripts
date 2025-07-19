# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Deletes a Python environment.
Usage: $(basename ${0}) environment_name
    environment_name    name of the environment to be deleted
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
get_sourced "${0}" "${BASH_SOURCE}"
usage "${1}" "${usage_message}"

environment_name="${1}"

check_variables "python_environments_path" "environment_name" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

assert_environment_exist "${environment_name}" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

rm -rf "${python_environments_path}/${environment_name}"
