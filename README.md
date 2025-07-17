# Scripts

Scripts used in my day to day.

Variables in [`variables.txt`](src/variables.txt) need to be defined by the user.
Add the [`src`](src) directory to `$PATH` for access from anywhere.

Each script contains a *help* option that explains its usage. Run it with:
```bash
<script>.sh {-h | --help}

<script>.bat -h
```

> [!IMPORTANT]
> On macOS and Linux, the variables in [`variables.txt`](src/variables.txt) must be defined with quotes.
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
