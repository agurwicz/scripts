#!/usr/bin/env bash
# Obtained from https://github.com/agurwicz/scripts.

if [[ "$0" == "$BASH_SOURCE" && "$1" != "-h" && "$1" != "--help" ]]; then
    echo $'\033[91mException:\033[0m Script must be sourced.'
    exit 1
fi

eval "$(/usr/bin/env python3 "$(dirname "$(command -v "$0")")/_activateenv.py" "$@")"
