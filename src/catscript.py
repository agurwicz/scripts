#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

from _basescript import BaseScript


class CatScript(BaseScript):

    @property
    def _description(self):
        return 'Prints the content of script in $PATH.'

    @property
    def _variables_to_check(self):
        return []

    def parse_arguments(self):

        self._argument_parser.add_argument(
            'script_name',
            help='name of the script to print',
            type=str
        )

        return super().parse_arguments()

    def run(self):
        
        script_path = self.get_script_in_path(script_name=self._arguments.script_name)

        with open(file=script_path, mode='r') as script_file:
            script_content = script_file.read()

        print(script_content)


if __name__ == '__main__':
    CatScript()
