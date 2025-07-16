# Obtained from https://github.com/agurwicz/scripts.

source "$(dirname ${0})/variables.txt"
python_relative_path="bin/python"
activate_relative_path="bin/activate"

function usage {
    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        printf "%s\n" "${2}"
        exit 0
    fi
}

function get_sourced {
    if [[ "${1}" == "${2}" ]]; then 
        sourced=false
    else 
        sourced=true
    fi
}

function check_variables {
    local variables=("$@")
    local variable

    for variable in "${variables[@]}"; do
        if [[ -z "$(eval "echo \"\$$variable\"")" ]]; then
            echo "Error: Variable \"${variable}\" is not defined."
            return 1
        fi
    done
}

function check_environment {
    python_path="${python_environments_path}/${1}/${python_relative_path}"
    activate_path="${python_environments_path}/${1}/${activate_relative_path}"

    if [[ ! -f "${python_path}" || ! -f "${activate_path}" ]]; then
        echo "Error: Environment \"${1}\" does not exist."
        return 1
    fi 
}

function assert_sourced {
    if [[ ${sourced} == false ]]; then
        echo "Error: Script must be sourced."
        exit 1
    fi
}

function assert_not_sourced {
    if [[ ${sourced} == true ]]; then
        echo "Error: Script can't be sourced."
        return 1
    fi
}
