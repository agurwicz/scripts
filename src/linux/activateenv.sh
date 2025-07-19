# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Activates a Python environment.
Usage: source $(basename ${0}) environment_name
    environment_name    name of the environment to be activated
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
usage "${1}" "${usage_message}"
get_sourced "${0}" "${BASH_SOURCE}"
assert_sourced

environment_name="${1}"

check_variables "python_environments_path" "python_relative_path" "activate_relative_path" "environment_name" || return 1     

assert_environment_exist "${environment_name}" || return 1

source "${python_environments_path}/${environment_name}/${activate_relative_path}"
