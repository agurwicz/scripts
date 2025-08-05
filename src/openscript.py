#!/usr/bin/env python3
# Obtained from https://github.com/agurwicz/scripts.

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

        if not self._is_windows:
            self.run_command(command='open', parameters=script_path)

        else:
            # Opening the script in the default editor for text files, ignoring file associations.
            import winreg

            def __reg_query(key, sub_key, value):

                key = winreg.OpenKey(key=key, sub_key=sub_key)
                value, _ = winreg.QueryValueEx(key, value)
                winreg.CloseKey(key)

                return value

            txt_extension = '.txt'
            try:
                program_key = __reg_query(
                    key=winreg.HKEY_CURRENT_USER,
                    sub_key=r'Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\{}\UserChoice'.format(
                        txt_extension
                    ),
                    value='ProgId'
                )

            except FileNotFoundError:
                program_key = self.run_command(command='assoc', parameters=txt_extension).split('=')[-1]

            try:
                txt_open_command = __reg_query(
                    key=winreg.HKEY_CLASSES_ROOT,
                    sub_key=r'{}\shell\open\command'.format(program_key),
                    value=''
                ).split('\"')[1]

            except FileNotFoundError:
                txt_open_command = 'notepad.exe'  # Falling back to Notepad if default program not found.

            self.open_command(command=txt_open_command, parameters=script_path)



if __name__ == '__main__':
    OpenScript()
