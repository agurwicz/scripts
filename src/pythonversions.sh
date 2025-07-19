# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Lists all Python versions available.
Usage: $(basename ${0})   
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
get_sourced "${0}" "${BASH_SOURCE}"
usage "${1}" "${usage_message}"

check_variables "python_versions_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

for version_path in "${python_versions_path}"/*; do
    python_path="${version_path}/bin/python"
    if [[ -f "${python_path}" || -f "${python_path}2" || -f "${python_path}3" ]]; then
        echo "$(basename ${version_path})"
    fi
done
