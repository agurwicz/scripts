# Obtained from https://github.com/agurwicz/scripts.
# Variables and methods to be used in other scripts.


#### Modify values here ####

python_environments_path=""
python_versions_path=""
vscode_path=""
pycharm_path=""

#### Do not modify under this line ####


function usage {

    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        printf "%s\n" "${2}"
        exit 0
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

case "$(uname -sr)" in
    Darwin* | Linux*)
        python_relative_path="bin/python"
        activate_relative_path="bin/activate";;

    CYGWIN* | MINGW* | MINGW32* | MSYS*)
        python_relative_path="Scripts/python.exe"
        activate_relative_path="Scripts/activate.bat";;
    
    *)
        echo 'Error: OS not recognized'
        exit 1;;
esac
