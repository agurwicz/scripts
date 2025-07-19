# Obtained from https://github.com/agurwicz/scripts.

usage_message="
Creates \"launch.json\" file for Visual Studio Code with default configuration.
Usage: $(basename ${0}) [environment_name] [main_relative_path]
    environment_name      name of the environment to be activated (default: \"general\")
    main_relative_path    path of the main file relative to \$PWD (default: \"main.py\")
"

source "$(dirname "$(command -v ${0})")/.commonscripts.sh"
usage "${1}" "${usage_message}"

get_sourced "${0}" "${BASH_SOURCE}"
assert_not_sourced || return 1
check_variables "python_environments_path" "python_relative_path" || exit 1

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
