#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

from pathlib import Path

from _basescript import BaseScript


class CreateNotebook(BaseScript):

    @property
    def _description(self):
        return 'Creates empty Jupyter Notebook in $PWD.'

    @property
    def _variables_to_check(self):
        return []

    def parse_arguments(self):

        self._argument_parser.add_argument(
            'notebook_name',
            help='nname of the notebook to be created',
            type=str
        )

        return super().parse_arguments()

    def run(self):
        
        notebook_path = Path.cwd().joinpath(self._arguments.notebook_name).with_suffix('.ipynb')

        notebook_content = (
            '{\"cells\": [], '
            '\"metadata\": {'
            '\"kernelspec\": {'
            '\"display_name\": \"Python 3 (ipykernel)\", '
            '\"language\": \"python\", '
            '\"name\": \"python3\"}}, '
            '\"nbformat\": 4, '
            '\"nbformat_minor\": 5}'
        )

        with open(file=notebook_path, mode='w') as notebook_file:
            notebook_file.write(notebook_content)


if __name__ == '__main__':
    CreateNotebook()
