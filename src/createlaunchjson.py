#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

import os
from pathlib import Path
from textwrap import dedent

from basescript import BaseScript


class CreateLaunchJson(BaseScript):

    @property
    def _description(self):
        return 'Creates \"launch.json\" file for Visual Studio Code with default configuration.'

    @property
    def _variables_to_check(self):
        return ['python_environments_path', 'python_relative_path']

    def parse_arguments(self):

        self._argument_parser.add_argument(
            '-e', '--environment',
            help='name of the environment to run Python in',
            default='general',
            type=self.existing_environment
        )

        self._argument_parser.add_argument(
            '-m', '--main_relative_path',
            help='path of the main file relative to $PWD',
            default='main.py',
            type=str
        )

        return super().parse_arguments()

    def run(self):
        
        vscode_directory = Path.cwd().joinpath('.vscode')
        launch_file_path = vscode_directory.joinpath('launch.json')

        launch_file_content = dedent("""
            {{
                "version": "0.2.0",
                "configurations": [
                    {{
                        "name": "main",
                        "program": "{main_path}",
                        "python": "{python_path}",
                        "type": "debugpy",
                        "request": "launch",
                        "console": "internalConsole",
                        "internalConsoleOptions": "openOnSessionStart"
                    }}
                ]
            }}
        """).format(
            main_path=os.path.join(
                '${workspaceFolder}', 
                self._arguments.main_relative_path
            ),
            python_path=os.path.join(
                self._variables.python_environments_path, 
                self._arguments.environment,
                self._variables.python_relative_path
            )
        )

        os.makedirs(vscode_directory, exist_ok=True)

        with open(file=launch_file_path, mode='w') as launch_file:
            launch_file.write(launch_file_content)


if __name__ == '__main__':
    CreateLaunchJson()
