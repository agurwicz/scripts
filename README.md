# Scripts

Bash and batch scripts used in my day to day.

Add the source directory ([`src/linux`](src/linux) or [`src/windows`](src/windows)) to `$PATH` for access from anywhere.

> [!IMPORTANT]
> Variables in `variables.txt` need to be defined before use.
> 
> On macOS and Linux, the variables must be defined with quotes.
  On Windows, they must be defined without.
>
> Example on macOS and Linux:
> ```
> python_environments_path="path/to/environments"
> ```
>
>Example on Windows:
> ```
> python_environments_path=path\to\environments
> ```

Each script contains a *help* option that explains its usage. Run it with:
```bash
<script>.sh {-h | --help}

<script>.bat -h
```

## List of Scripts

| Script            | Purpose                                                                       | macOS/Linux? | Windows? |
|-------------------|-------------------------------------------------------------------------------|:------------:|:--------:|
| `createenv`       | Creates a Python environment.                                                 | ✅           | ✅       |
| `activateenv`     | Activates a Python environment.                                               | ✅           | ✅       |
| `deleteenv`       | Deletes a Python environment.                                                 | ✅           | ✅       |
| `listenvs`        | Lists all Python environments.                                                | ✅           | ✅       |
| `pythonversions`  | Lists all Python versions available.                                          | ✅           | ✅       |
| `listscripts`     | Lists the scripts available.                                                  | ✅           | ✅       |
| `catscript`       | Prints the content of a script in `$PATH`.                                    | ✅           | ✅       |
| `openscript`      | Opens a script in `$PATH`.                                                    | ✅           | ✅       |
| `launchjson`      | Creates "launch.json" file for Visual Studio Code with default configuration. | ✅           | ✅       |
| `createnotebook`  | Creates empty Jupyter Notebook in `$PWD`.                                     | ✅           | ✅       |
| `pycharmnotebook` | Creates empty Jupyter Notebook in `$PWD` and opens in PyCharm.                | ✅           | ✅       |
| `vscodenotebook`  | Creates empty Jupyter Notebook in `$PWD` and opens in Visual Studio Code.     | ✅           | ✅       |
