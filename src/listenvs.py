#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

from pathlib import Path

from _basescript import BaseScript


class ListEnvs(BaseScript):

    @property
    def _description(self):
        return 'Lists all Python environments.'

    @property
    def _variables_to_check(self):
        return ['python_environments_path', 'python_relative_path']

    def parse_arguments(self):
        return super().parse_arguments()

    def run(self):

        for environment_path in Path(self._variables.python_environments_path).iterdir():
            
            if environment_path.is_dir() and not environment_path.name.startswith('.'):
                
                python_path = environment_path.joinpath(self._variables.python_relative_path)
                if python_path.is_file():

                    print(
                        '{environment}: {version}'.format(
                            environment=environment_path.name, 
                            version=self.get_python_version(python_path=python_path)
                        )
                    )


if __name__ == '__main__':
    ListEnvs()
