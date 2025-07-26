#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

import os

from basescript import BaseScript


class CreateEnv(BaseScript):

    @property
    def _description(self):
        return 'Creates Python environment.'

    @property
    def _variables_to_check(self):
        return ['python_environments_path', 'python_relative_path', 'activate_relative_path']

    def parse_arguments(self):

        self._argument_parser.add_argument(
            'environment_name',
            help='name of the environment to be created',
            type=self.nonexistent_environment
        )

        self._argument_parser.add_argument(
            'python_version',
            help='python version of the environment e.g. 3.9, 3.12',
            type=self.__existing_python_version
        )

        self._argument_parser.add_argument(
            '-p', '--packages',
            help='extra packages to install in environment',
            type=lambda packages: packages.split(',')
        )

        self._argument_parser.add_argument(
            '-a', '--activate',
            help='activate the environment after creation',
            action='store_true'
        )

        return super().parse_arguments()

    def run(self):

        packages_to_install = ['pip', 'setuptools']
        if self._arguments.packages is not None:
            packages_to_install += self._arguments.packages
        environment_path = os.path.join(self._variables.python_environments_path, self._arguments.environment_name)

        self.run_command(
            command=os.path.join(
                self._variables.python_versions_path, 
                self._arguments.python_version, 
                self._variables.python_version_relative_path
            ),
            parameters=('-m', 'venv', environment_path)
        )

        parameters = [','.join(packages_to_install), '--environment', self._arguments.environment_name]
        if self._arguments.activate:
            parameters += ['--activate']
        self.run_script(script_name='installpackages', parameters=parameters, show_output=True)

    def __existing_python_version(self, python_version):
        
        python_versions = [
            python_version.split(' (')[0]
            for python_version in self.run_script(script_name='listpythonversions').split('\n')
        ]

        if python_version not in python_versions and python_version.replace('.', '') not in python_versions:
            raise Exception('Python version not found. Options are: {}'.format(python_versions))

        return python_version


if __name__ == '__main__':
    CreateEnv()
