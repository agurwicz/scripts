#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

from pathlib import Path

from basescript import BaseScript


class ListPythonVersions(BaseScript):

    @property
    def _description(self):
        return 'Lists all Python versions available.'

    @property
    def _variables_to_check(self):
        return ['python_versions_path', 'python_version_relative_path']

    def parse_arguments(self):
        return super().parse_arguments()

    def run(self):

        for version_path in Path(self._variables.python_versions_path).iterdir():

            try:
                version = self.get_python_version(
                    python_path=version_path.joinpath(self._variables.python_version_relative_path)
                )
                if not version:
                    raise FileNotFoundError

            except FileNotFoundError:
                continue

            print('{name} (Python {version})'.format(name=version_path.name, version=version))

if __name__ == '__main__':
    ListPythonVersions()
