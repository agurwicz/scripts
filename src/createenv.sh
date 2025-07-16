# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Creates a Python environment.
Usage: [source] `basename ${0}` environment_name python_version
    environment_name    name of the environment to be created
    python_version      python version of the environment e.g. 3.9, 3.12
"

source "$(dirname "$(command -v ${0})")/commonscripts.sh"
get_sourced "${0}" "${BASH_SOURCE}"
usage "${1}" "${usage_message}"
check_variables "python_environments_path" "python_relative_path" "activate_relative_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

environment_name="${1}"
python_version="${2}"

packages_to_install=(pip setuptools)
environment_path="${python_environments_path}/${environment_name}"  

"${python_versions_path}/${python_version}/bin/python3" -m venv "${environment_path}"
"${environment_path}/${python_relative_path}" -m pip install --upgrade "${packages_to_install[@]}"

if [[ ${sourced} == true ]]; then
    source activateenv.sh "${environment_name}"
fi
