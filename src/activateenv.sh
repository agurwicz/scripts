# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Activates a Python environment.
Usage: source `basename ${0}` environment_name
    environment_name    name of the environment to be activated
"

source "$(dirname "$(command -v ${0})")/commonscripts.sh"
get_sourced "${0}" "${BASH_SOURCE}"
assert_sourced
usage "${1}" "${usage_message}"
check_variables "python_environments_path" "python_relative_path" "activate_relative_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

environment_name="${1}"

check_environment "${environment_name}" || return 1

source "${python_environments_path}/${environment_name}/${activate_relative_path}"
