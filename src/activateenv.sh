#!/usr/bin/env bash
# Obtained from https://github.com/agurwicz/scripts.

if [[ "$0" == "$BASH_SOURCE" && "$1" != "-h" && "$1" != "--help" ]]; then
    echo $'\033[91mException:\033[0m Script must be sourced.'
    exit 1
fi

spawn_shell_argument="--spawn-shell"
script_path="$(dirname "$(command -v "$0")")/_activateenv.py"
command="/usr/bin/env python3 \"$script_path\" $@"

if [[ "$1" == "$spawn_shell_argument" || "$2" == "$spawn_shell_argument" ]]; then
    eval "$command"
else
    eval "$(eval "$command")"
fi
