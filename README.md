# Scripts

Scripts used in my day to day, (re)written in Python for easier cross-platform compatibility.
Special thanks and appropriate credits go to [Lance Endres](https://github.com/lendres) for [initially organizing and improving the Python scripts for Windows](https://github.com/lendres/Python-Scripts).


Add the [`src`](src) directory to `$PATH` for access from anywhere.

> [!IMPORTANT]
> Variables in [`variables.json`](src/variables.json) need to be defined before use.

Each script contains a *help* option that explains its usage. Run it with:
```bash
<script>.py {-h | --help}
```

We are open to suggestions and contributions to the repository. 
Please feel free to open pull requests/issues for contribution and discussion, or fork to add your own scripts.

## Running

We aim to minimize the command overhead to run the scripts.

### macOS/Linux

The shebang `#!/usr/bin/env python3` allows running with `<script>.py` instead of `python <script>.py`. 

To run only with `<script>`, without the extension, a solution is to create functions mapping each command to a script call.
For example, add the following to `.bashrc` or equivalent:
```bash
# Obtained from https://github.com/agurwicz/scripts.
for script_path in "<scripts_path>"/*; do
    if [[ -f "${script_path}" && "${script_path}" == *.py ]]; then
        file_name="$(basename ${script_path})"
        eval "${file_name%.*}() { "<python_path>" "${script_path}" \${@} }"
    fi
done
unset script_path
```
Where `<scripts_path>` is the location of [`src`](src), and `<python_path>` is the path to a Python interpreter, e.g. `python` or `/usr/bin/python3`.

## List of Scripts

| Script                                             | Purpose                                                                       | macOS/Linux? | Windows?         |
|----------------------------------------------------|-------------------------------------------------------------------------------|:------------:|:----------------:|
| [`createenv`](src/createenv.py)                    | Creates Python environment.                                                   | ✅           | not tested       |
| [`activateenv`](src/activateenv.py)                | Activates Python environment.                                                 | ✅           | not tested       |
| [`deleteenv`](src/deleteenv.py)                    | Deletes Python environment.                                                   | ✅           | not tested       |
| [`listenvs`](src/listenvs.py)                      | Lists all Python environments.                                                | ✅           | not tested       |
| [`installpackages`](src/installpackages.py)        | Installs and upgrades packages in Python environment.                         | ✅           | not tested       |
| [`listpythonversions`](src/listpythonversions.py)  | Lists all Python versions available.                                          | ✅           | not tested       |
| [`listscripts`](src/listscripts.py)                | Lists scripts available.                                                      | ✅           | not tested       |
| [`catscript`](src/catscript.py)                    | Prints content of script in `$PATH`.                                          | ✅           | not tested       |
| [`openscript`](src/openscript.py)                  | Opens script in `$PATH`.                                                      | ✅           | not tested       |
| [`createlaunchjson`](src/createlaunchjson.py)      | Creates "launch.json" file for Visual Studio Code with default configuration. | ✅           | not tested       |
| [`createnotebook`](src/createnotebook.py)          | Creates empty Jupyter Notebook in `$PWD`.                                     | ✅           | not tested       |
| [`pycharmnotebook`](src/pycharmnotebook.py)        | Creates empty Jupyter Notebook in `$PWD` and opens in PyCharm.                | ✅           | not tested       |
| [`vscodenotebook`](src/vscodenotebook.py)          | Creates empty Jupyter Notebook in `$PWD` and opens in Visual Studio Code.     | ✅           | not tested       |
