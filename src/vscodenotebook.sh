# Obtained from https://github.com/agurwicz/scripts.
# Creates empty Jupyter Notebook in $PWD and opens in Visual Studio Code.

usage_message="
Usage: `basename ${0}` notebook_name
    notebook_name    name of the notebook to be created
"

if [[ "${0}" == "${BASH_SOURCE}" ]]; then sourced=false; else sourced=true; fi
source "$(dirname "$(command -v ${0})")/commonscripts.sh"
usage "${1}" "${usage_message}"
check_variables "vscode_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

if [[ ${sourced} == true ]]; then echo "Error: Script can't be sourced."; return 1; fi

notebook_name="${1}"
notebook_path="${PWD}/${notebook_name}.ipynb"

> "${notebook_path}"
echo "{\"cells\": [], \"metadata\": {\"kernelspec\": {\"display_name\": \"Python 3 (ipykernel)\", \"language\": \"python\", \"name\": \"python3\"}}, \"nbformat\": 4, \"nbformat_minor\": 5}" >> "${notebook_path}"

"${vscode_path}" "${notebook_path}"
