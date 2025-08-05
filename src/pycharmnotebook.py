#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

from pathlib import Path

from _basescript import BaseScript


class PycharmNotebook(BaseScript):

    @property
    def _description(self):
        return 'Creates empty Jupyter Notebook in $PWD and opens in PyCharm.'

    @property
    def _variables_to_check(self):
        return ['pycharm_path']

    def parse_arguments(self):

        self._argument_parser.add_argument(
            'notebook_name',
            help='nname of the notebook to be created',
            type=str
        )

        return super().parse_arguments()

    def run(self):
        
        notebook_path = Path.cwd().joinpath(self._arguments.notebook_name).with_suffix('.ipynb')

        self.run_script(script_name='createnotebook', parameters=self._arguments.notebook_name)

        self.run_command(command=self._variables.pycharm_path, parameters=notebook_path)


if __name__ == '__main__':
    PycharmNotebook()
