"""Symlink dotfiles to home
"""
import os
import subprocess

ignore = [".DS_Store", ".git", ".gitignore", ".hg", ".hgignore", ".vscode"]
home = os.path.expanduser("~")
here = os.path.dirname(__file__)

for x in os.listdir(here):
    if x in ignore or not x.startswith("."):
        print(x + ": Ignored")
        continue
    destination = os.path.join(home, x)
    if os.path.exists(destination):
        print(x + ": File exists")
    elif os.path.lexists(destination):
        print(x + ": Broken link")
    else:
        cmd = ["ln", "-s", os.path.join(here, x), destination]
        print(" ".join(cmd))
        subprocess.call(cmd)
