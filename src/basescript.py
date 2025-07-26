# Obtained from https://github.com/agurwicz/scripts.

import json
import platform
import subprocess
import sys
from abc import ABC, abstractmethod
from argparse import ArgumentDefaultsHelpFormatter, ArgumentParser, Namespace
from pathlib import Path
from shutil import which


class BaseScript(ABC):

    def __init__(self):

        self.__filter_exceptions()
        self._argument_parser = ArgumentParser(
            description=self._description, 
            formatter_class=ArgumentDefaultsHelpFormatter
        )
        
        self._variables = self.__get_and_check_variables(variables_to_check=self._variables_to_check)
        self._arguments = self.parse_arguments()

        self.run()

    @property
    @abstractmethod
    def _description(self):
        pass

    @property
    @abstractmethod
    def _variables_to_check(self):
        pass

    @abstractmethod
    def parse_arguments(self):
        return self._argument_parser.parse_args()

    @abstractmethod
    def run(self):
        pass
    
    @property
    def _is_windows(self):
        return 'windows' in platform.system().lower()

    @staticmethod
    def run_command(command, parameters=(), show_output=False):
        
        if not isinstance(parameters, (list, tuple)):
            parameters = [parameters]

        result = subprocess.run(
            args=[command]+list(parameters),
            capture_output=not show_output, 
            text=True
        )
        
        if not show_output:
            return result.stdout.strip()
        return None
    
    def run_script(self, script_name, parameters=(), show_output=False):

        return self.run_command(
            command=Path(__file__).parent.joinpath(script_name+'.py'), 
            parameters=parameters,
            show_output=show_output
        )

    def get_python_version(self, python_path):
        
        return self.run_command(
            command=python_path, 
            parameters=('-c', 'import platform; print(platform.python_version())')
        )
    
    @staticmethod
    def get_script_in_path(script_name):

        script_name = Path(script_name)

        if script_name.suffix:
            extensions = [script_name.suffix]
        else:
            extensions = ['', '.sh', '.py']

        script_path = None
        for extension in extensions:

            found_path = which(
                cmd='{name}{extension}'.format(name=script_name.with_suffix(''), extension=extension)
            )

            if found_path is not None:
                script_path = found_path
                break

        if script_path is None:
            raise Exception('Script not found.')
        
        return script_path

    def existing_environment(self, environment_name):
        
        def __check_file(relative_path):
            return Path(self._variables.python_environments_path).joinpath(
                environment_name, 
                relative_path
            ).is_file()

        if (
            not __check_file(relative_path=self._variables.python_relative_path) 
            or not __check_file(relative_path=self._variables.activate_relative_path)
        ):
            raise Exception('Environment \"{}\" does not exist.'.format(environment_name))
        
        return environment_name
        
    def nonexistent_environment(self, environment_name):
    
        def __check_file(relative_path):
            return Path(self._variables.python_environments_path).joinpath(
                environment_name, 
                relative_path
            ).is_file()

        if (
            __check_file(relative_path=self._variables.python_relative_path) 
            or __check_file(relative_path=self._variables.activate_relative_path)
        ):
            raise Exception('Environment \"{}\" already exists.'.format(environment_name))
        
        return environment_name
    
    @staticmethod
    def __filter_exceptions():

        sys.excepthook = lambda exception_type, value, _: print(
            '{color}{type}:{reset_color} {message}'.format(
                type=exception_type.__name__,
                message=value,
                color='\033[91m',  # red
                reset_color='\033[0m'
            )
        ) 

    def __get_and_check_variables(self, variables_to_check):
        
        variables_file_name = 'variables.json'

        with open(file=Path(__file__).parent.joinpath(variables_file_name), mode='r') as json_variables:
            variables = Namespace(**json.load(fp=json_variables))

        if self._is_windows:
            variables.python_relative_path = r'Scripts\python.exe'
            variables.python_version_relative_path = r'python.exe'
            variables.activate_relative_path = r'Scripts\activate.bat'
        else:
            variables.python_relative_path = r'bin/python'
            variables.python_version_relative_path = r'bin/python3'
            variables.activate_relative_path = r'bin/activate'

        for variable_to_check in variables_to_check:
            
            try:
                variable = getattr(variables, variable_to_check)
                if not variable:
                    raise AttributeError

            except AttributeError:
                raise Exception(
                    'Variable \"{}\" is not defined in \"{}\".'.format(variable_to_check, variables_file_name)
                )

        return variables
