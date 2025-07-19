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
