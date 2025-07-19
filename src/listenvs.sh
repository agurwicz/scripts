# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Lists all Python environments.
Usage: $(basename ${0})   
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
get_sourced "${0}" "${BASH_SOURCE}"
usage "${1}" "${usage_message}"

check_variables "python_environments_path" "python_relative_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

for environment_path in "${python_environments_path}"/*; do
    environment_name="$(basename ${environment_path})"
    python_path="${python_environments_path}/${environment_name}/${python_relative_path}"
    
    python_version="$("${python_path}" --version)"
    python_version=($python_version)
    python_version=${python_version[1]}

    echo ${environment_name}: ${python_version}
done
