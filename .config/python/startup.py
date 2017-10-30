import sys

if sys.version_info < (3, 4):
    import rlcompleter
    import readline
    rlcompleter.__name__  # suppress F401
    if 'libedit' in readline.__doc__:
        readline.parse_and_bind("bind ^I rl_complete")
    else:
        readline.parse_and_bind("tab: complete")
    del readline, rlcompleter
    print([x for x in dir() if not x.startswith("__")])
else:
    del sys
