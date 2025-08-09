#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

import os

from _basescript import BaseScript


class OpenFile(BaseScript):

    @property
    def _description(self):
        return 'Opens file in $PATH or $HOME.'

    @property
    def _variables_to_check(self):
        return []

    def parse_arguments(self):

        self._argument_parser.add_argument(
            'file_name',
            help='name of the file to open',
            type=str
        )

        return super().parse_arguments()

    def run(self):

        file_path = self.__find_file_in_path(file_name=self._arguments.file_name)

        self.open_text_file(file_path=file_path)

    def __find_file_in_path(self, file_name):

        # Searching in $PATH and $HOME.
        file_paths = [
            os.path.join(file_path, file_name)
            for file_path in os.environ['PATH'].split(os.pathsep) + [os.path.expanduser('~')]
            if os.path.isfile(os.path.join(file_path, file_name))
        ]

        if len(file_paths) == 0:
            return None

        elif len(file_paths) == 1:
            return file_paths[0]

        else:
            return self.__choose_file(file_paths=file_paths)

    @staticmethod
    def __choose_file(file_paths):

        files = {
            index + 1: file_path
            for index, file_path in enumerate(file_paths)
        }

        for index, file_path in files.items():
            print('\033[92m{index}:\033[0m {file_path}'.format(index=index, file_path=file_path))

        file_index = input('Choose a file index: ')

        try:
            return files[int(file_index)]

        except (ValueError, KeyError):
            raise Exception('Invalid choice.')


if __name__ == '__main__':
    OpenFile()
