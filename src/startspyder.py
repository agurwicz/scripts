#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

import os
import sys
from pathlib import Path
import subprocess

from _basescript import BaseScript


class StartSpyder(BaseScript):

    @property
    def _description(self):
        return 'Starts Spyder within the given environment.'

    @property
    def _variables_to_check(self):
        return ['python_environments_path']

    def parse_arguments(self):
        
        # Redirecting argparse's help to stderr to work with `eval` and `call`.
        help_function = self._argument_parser.print_help
        self._argument_parser.print_help = lambda: help_function(sys.stderr)

        self._argument_parser.add_argument(
            'environment_name',
            help='name of the environment to be activated',
            type=self.existing_environment
        )

        return super().parse_arguments()
    
    def launch_spyder(self, python_path: str, spyder_args: list[str] | None=None) -> int:
        parameters = ["-m", "spyder.app.start"]
        if spyder_args:
            parameters.extend(spyder_args)
        
        self.open_command(
            command=python_path,
            parameters=parameters
        )


    def run(self):
        if self._arguments.environment_name is None:
            raise Exception("Must pass environment to activate.")

        python_path = os.path.join(
            self._variables.python_environments_path, 
            self._arguments.environment_name, 
            self._variables.python_relative_path
        ) if self._arguments.environment_name is not None else 'python'
        
        self.launch_spyder(python_path)


if __name__ == '__main__':
    StartSpyder()
