# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Lists the scripts available.
Usage: `basename ${0}`
"

source "$(dirname "$(command -v ${0})")/commonscripts.sh"
get_sourced "${0}" "${BASH_SOURCE}"
usage "${1}" "${usage_message}"

ls "$(dirname "$(command -v ${0})")" | grep ".sh"
