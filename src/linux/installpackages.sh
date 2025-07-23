# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Installs and upgrades packages in a Python environment.
Usage: [source] $(basename ${0}) \"packages\" [environment_name] [-a | --activate]
    packages            list of packages to install and upgrade (accepts versions with \"package==version\")
    environment_name    name of the environment to install in (default: currently active environment)
    -a, optional        activate the environment after installation
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
usage "${1}" "${usage_message}"
get_sourced "${0}" "${BASH_SOURCE}"

packages="${1}"
environment_name="${2}"
if [[ "${3}" == "-a" || "${3}" == "--activate" ]]; then activate=true; else activate=false; fi

if [[ ! "${environment_name}" == "" ]]; then
    check_variables "python_environments_path" "python_relative_path" "environment_name"|| {
        [[ ${sourced} == true ]] && return 1 || exit 1
    }
    assert_environment_exist "${environment_name}" || {
        [[ ${sourced} == true ]] && return 1 || exit 1
    }
    if [[ ${activate} == true && ${sourced} == false ]]; then
        echo "Error: Script must be sourced to activate."
        exit 1
    fi
    python_path="${python_environments_path}/${environment_name}/${python_relative_path}"
else
    python_path="python"
fi

packages=(${packages})
"${python_path}" -m pip install --upgrade --no-cache-dir $(echo "${packages[@]}")  # Using `echo` or it doesn't work when sourced.

if [[ ${activate} == true ]]; then
    source "$(dirname "$(command -v ${0})")/activateenv.sh" "${environment_name}"
fi
