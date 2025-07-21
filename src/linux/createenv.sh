# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Creates a Python environment.
Usage: [source] $(basename ${0}) environment_name python_version [-a | --activate]
    environment_name    name of the environment to be created
    python_version      python version of the environment e.g. 3.9, 3.12
    -a, optional        activate the environment after creation
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
usage "${1}" "${usage_message}"
get_sourced "${0}" "${BASH_SOURCE}"

environment_name="${1}"
python_version="${2}"
if [[ "${3}" == "-a" || "${3}" == "--activate" ]]; then activate=true; else activate=false; fi

check_variables "python_environments_path" "python_relative_path" "activate_relative_path" "environment_name" "python_version" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

assert_environment_not_exist "${environment_name}" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}
if [[ ${activate} == true && ${sourced} == false ]]; then
    echo "Error: Script must be sourced to activate."
    exit 1
fi

packages_to_install=(pip setuptools)
environment_path="${python_environments_path}/${environment_name}"  

"${python_versions_path}/${python_version}/bin/python3" -m venv "${environment_path}"
"${environment_path}/${python_relative_path}" -m pip install --upgrade "${packages_to_install[@]}"

if [[ ${activate} == true ]]; then
    source "$(dirname "$(command -v ${0})")/activateenv.sh" "${environment_name}"
fi
