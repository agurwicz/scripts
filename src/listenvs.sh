# Obtained from https://github.com/agurwicz/scripts.
# Lists all Python environments.

usage_message="
Usage: `basename ${0}`   
"

if [[ "${0}" == "${BASH_SOURCE}" ]]; then sourced=false; else sourced=true; fi
source "$(dirname "$(command -v ${0})")/commonscripts.sh"
usage "${1}" "${usage_message}"
check_variables "python_environments_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

ls "${python_environments_path}"
