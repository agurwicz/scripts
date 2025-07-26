#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

import os

from basescript import BaseScript


class OpenScript(BaseScript):

    @property
    def _description(self):
        return 'Opens script in $PATH.'

    @property
    def _variables_to_check(self):
        return []

    def parse_arguments(self):

        self._argument_parser.add_argument(
            'script_name',
            help='name of the script to open',
            type=str
        )

        return super().parse_arguments()

    def run(self):
        
        script_path = self.get_script_in_path(script_name=self._arguments.script_name)

        if self._is_windows:
            os.startfile(script_path)
        else:
            self.run_command(command='open', parameters=script_path)


if __name__ == '__main__':
    OpenScript()
