# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Creates empty Jupyter Notebook in \$PWD and opens in PyCharm.
Usage: `basename ${0}` notebook_name
    notebook_name    name of the notebook to be created
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
get_sourced "${0}" "${BASH_SOURCE}"
assert_not_sourced || return 1
usage "${1}" "${usage_message}"
check_variables "pycharm_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

notebook_name="${1}"

"$(dirname "$(command -v ${0})")/createnotebook.sh" "${notebook_name}"
open -na "${pycharm_path}" --args "${PWD}"
