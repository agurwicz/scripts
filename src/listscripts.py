#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

from pathlib import Path

from basescript import BaseScript


class ListScripts(BaseScript):

    @property
    def _description(self):
        return 'Lists scripts available.'

    @property
    def _variables_to_check(self):
        return []

    def parse_arguments(self):
        return super().parse_arguments()

    def run(self):
        
        ignore = ['basescript.py']

        for script_path in Path(__file__).parent.iterdir():
            
            if script_path.is_file() and script_path.suffix == '.py' and script_path.name not in ignore:

                print(script_path.name)


if __name__ == '__main__':
    ListScripts()
