# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Opens a script in \$PATH.
Usage: $(basename ${0}) script_name
    script_name    name of the script to open
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
get_sourced "${0}" "${BASH_SOURCE}"
usage "${1}" "${usage_message}"

script_name="${1}"

check_variables "script_name" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}
    
script_path=$(which "${script_name}.sh")

if [[ ! -f ${script_path} ]]; then
    echo "Error: Script not found."
    [[ ${sourced} == true ]] && return 1 || exit 1
fi

open "${script_path}"
