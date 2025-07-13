# Obtained from https://github.com/agurwicz/scripts.
# Creates "launch.json" file for Visual Studio Code with default configuration.

usage_message="
Usage: `basename ${0}` [environment_name] [main_relative_path]
    environment_name      name of the environment to be activated (default: \"general\")
    main_relative_path    path of the main file relative to \$PWD (default: \"main.py\")
"

if [[ "${0}" == "${BASH_SOURCE}" ]]; then sourced=false; else sourced=true; fi
source "$(dirname "$(command -v ${0})")/commonscripts.sh"
usage "${1}" "${usage_message}"
check_variables "python_environments_path" "python_relative_path" || {
    [[ ${sourced} == true ]] && return 1 || exit 1
}

if [[ ${sourced} == true ]]; then echo "Error: Script can't be sourced."; return 1; fi

environment_name="${1:-general}"
main_relative_path="${2:-main.py}"
vscode_directory="${PWD}/.vscode"
launch_file="${vscode_directory}/launch.json"

mkdir -p "${vscode_directory}"
> "${launch_file}"

cat <<EOF > "${launch_file}"
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "main",
            "program": "\${workspaceFolder}/${main_relative_path}",
            "python": "${python_environments_path}/${environment_name}/${python_relative_path}",
            "type": "debugpy",
            "request": "launch",
            "console": "internalConsole",
            "internalConsoleOptions": "openOnSessionStart"
        }
    ]
}
EOF
