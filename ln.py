#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
Symlink dotfiles to home
"""
import os
import subprocess

ignore = ['.DS_Store', '.git', '.gitignore', '.hg', '.hgignore']
home = os.path.expanduser('~')
here = os.path.abspath(os.path.dirname(__file__))
here_from_home = os.path.dirname(os.path.relpath(__file__, home))

for x in os.listdir(here):
    if x in ignore or not x.startswith('.'):
        print(x + ": Ignored")
        continue
    if os.path.exists(os.path.join(home, x)):
        print(x + ": File exists")
        continue
    if os.path.lexists(os.path.join(home, x)):
        print(x + ": Broken link")
        continue
    cmd = ["ln", "-s", os.path.join(here_from_home, x), os.path.join(home, x)]
    print(' '.join(cmd))
    subprocess.call(cmd)
