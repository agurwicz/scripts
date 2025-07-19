# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Creates empty Jupyter Notebook in \$PWD.
Usage: $(basename ${0}) notebook_name
    notebook_name    name of the notebook to be created
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
usage "${1}" "${usage_message}"

get_sourced "${0}" "${BASH_SOURCE}"
assert_not_sourced || return 1

notebook_name="${1}"

check_variables "notebook_name" || exit 1

notebook_path="${PWD}/${notebook_name}.ipynb"

> "${notebook_path}"
echo "{\"cells\": [], \"metadata\": {\"kernelspec\": {\"display_name\": \"Python 3 (ipykernel)\", \"language\": \"python\", \"name\": \"python3\"}}, \"nbformat\": 4, \"nbformat_minor\": 5}" >> "${notebook_path}"
