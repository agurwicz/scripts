#!/usr/bin/env python3
"""
launch_spyder_venv.py

Start Spyder using a specific Python environment *without* conda/mamba.
You can point to:
  - a venv/virtualenv directory (preferred), or
  - a direct Python interpreter path.

Examples:
  # Using a venv folder
  python launch_spyder_venv.py --venv ".venv"

  # Using a direct interpreter path
  python launch_spyder_venv.py --python "C:/Users/you/Envs/py310/Scripts/python.exe"

  # Ensure Spyder is installed in the environment if missing
  python launch_spyder_venv.py --venv ".venv" --ensure-spyder

  # Pass args to Spyder after "--"
  python launch_spyder_venv.py --venv ".venv" -- --new-instance
"""

import argparse
import platform
import subprocess
import sys
from pathlib import Path

def BuildParser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="Start Spyder inside a venv/virtualenv (no conda).")
    envGroup = parser.add_mutually_exclusive_group(required=True)
    envGroup.add_argument("--venv", type=str, help="Path to a virtualenv/venv directory.")
    envGroup.add_argument("--python", type=str, help="Path to a Python interpreter inside an environment.")
    parser.add_argument(
        "--ensure-spyder",
        action="store_true",
        help="If Spyder is not installed in the environment, install it via pip."
    )
    parser.add_argument(
        "--upgrade",
        action="store_true",
        help="When used with --ensure-spyder, upgrade Spyder to the latest version."
    )
    parser.add_argument(
        "--spyder-args",
        nargs=argparse.REMAINDER,
        help='Arguments to pass to Spyder after "--", e.g. -- --new-instance'
    )
    return parser

def IsWindows() -> bool:
    return platform.system().lower().startswith("win")

def ResolveVenvPython(venvPath: str) -> Path:
    venv = Path(venvPath).expanduser().resolve()
    candidate = venv / ("Scripts/python.exe" if IsWindows() else "bin/python")
    return candidate

def CheckSpyderInstalled(pythonExecutable: Path) -> bool:
    try:
        subprocess.run(
            [str(pythonExecutable), "-c", "import spyder"],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
        return True
    except subprocess.CalledProcessError:
        return False

def EnsureSpyder(pythonExecutable: Path, doUpgrade: bool) -> None:
    pipCmd = [str(pythonExecutable), "-m", "pip", "install"]
    if doUpgrade:
        pipCmd.append("--upgrade")
    pipCmd.append("spyder")
    print(f"Installing Spyder into environment using: {' '.join(pipCmd)}")
    subprocess.run(pipCmd, check=True)

def LaunchSpyder(pythonExecutable: Path, spyderArgs: list[str] | None) -> int:
    cmd = [str(pythonExecutable), "-m", "spyder"]
    if spyderArgs:
        cmd.extend(spyderArgs)
    return subprocess.call(cmd)

def Main() -> int:
    parser = BuildParser()
    args = parser.parse_args()

    spyderArgs = args.spyder_args or []

    if args.venv:
        pythonExecutable = ResolveVenvPython(args.venv)
        if not pythonExecutable.exists():
            print(f"Error: Python executable not found in venv: {pythonExecutable}", file=sys.stderr)
            return 1
    else:
        pythonExecutable = Path(args.python).expanduser().resolve()
        if not pythonExecutable.exists():
            print(f"Error: Python interpreter not found: {pythonExecutable}", file=sys.stderr)
            return 1

    if not CheckSpyderInstalled(pythonExecutable):
        if args.ensure_spyder:
            try:
                EnsureSpyder(pythonExecutable, args.upgrade)
            except subprocess.CalledProcessError as error:
                print(f"Error installing Spyder: {error}", file=sys.stderr)
                return 1
        else:
            print(
                "Error: Spyder is not installed in the selected environment.\n"
                "Install it with:\n"
                f'  "{pythonExecutable}" -m pip install spyder',
                file=sys.stderr,
            )
            return 1

    return LaunchSpyder(pythonExecutable, spyderArgs)

if __name__ == "__main__":
    sys.exit(Main())
