# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Lists all Python environments.
Usage: `basename ${0}`   
"

source "$(dirname "$(command -v ${0})")/commonscripts.sh"
get_sourced "${0}" "${BASH_SOURCE}"
usage "${1}" "${usage_message}"
check_variables "python_environments_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

ls "${python_environments_path}"
