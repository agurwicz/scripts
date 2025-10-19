#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

import os
import sys

from _basescript import BaseScript
from listenvs import ListEnvs


class StartSpyder(BaseScript):

    @property
    def _description(self):
        return 'Starts Spyder within the given environment.'

    @property
    def _variables_to_check(self):
        return ['python_environments_path']

    def parse_arguments(self):

        self._argument_parser.add_argument(
            'environment_name',
            help='name of the environment to run Spyder in',
            type=self.existing_environment
        )

        return super().parse_arguments()

    def run(self):
        self.activate_env()
        
        
        
        
    def activate_env(self):
        print(self._arguments.environment_name)
        
        activate_path = os.path.join(
            self._variables.python_environments_path,
            self._arguments.environment_name,
            self._variables.activate_relative_path
        )

        if self._is_windows:
            # Calling `activate.bat` from subprocess doesn't propagate environment to the terminal.

            if not self._arguments.spawn_shell:
                # Solving by printing to stdout, to be captured by a `call` from a batch script.
                print(activate_path, file=sys.stdout)

            else:
                # Solving by spawning a new shell that starts running `activate.bat`.
                # Exit with `exit` instead of usual `deactivate`.
                self.run_command(command='cmd', parameters=('/k', activate_path), show_output=True)

        else:
            # Can't `source` from within Python.

            if not self._arguments.spawn_shell:
                # Solving by printing to stdout, to be captured by an `eval` call from a bash script.
                print('source {}'.format(activate_path), file=sys.stdout)

            else:
                # Solving by setting `rcfile` to the activation script, but this spawns a new shell.
                # Exit with `exit` instead of usual `deactivate`.
                self.run_command(
                    command='/usr/bin/env',
                    parameters=('bash', '--rcfile', activate_path),
                    show_output=True
                )

if __name__ == '__main__':
    StartSpyder()
