"""Symlink dotfiles to home."""
from pathlib import Path

ignore = [".DS_Store", ".git", ".gitignore", ".vscode"]


def _ln_s(target: Path, link: Path):
    if link.exists():
        print(f"{link}: File exists")
    elif link.is_symlink():
        print(f"Warning: {link}: Broken link")
    else:
        print(f"ln -s {target} {link}")
        link.symlink_to(target)


for x in Path(__file__).parent.iterdir():
    if x.name in ignore or not x.name.startswith("."):
        print(f"{x.name}: Ignored")
    else:
        target = x.relative_to(Path.home())
        link = Path.home() / x.name
        _ln_s(target, link)


app_support = Path("~/Library/Application Support").expanduser()
if app_support.exists():
    xdg_config_home = Path("../../.config")
    for x in ["Code", "ruff"]:
        target = xdg_config_home / x
        link = app_support / x
        _ln_s(target, link)

cspell_json = Path("~/.cspell.json").expanduser()
if cspell_json.exists():
    print(f"{cspell_json}: File exists")
else:
    print(f"{cspell_json}")
    with cspell_json.open("w") as fout:
        fout.write('{ "import": [ "~/.config/cspell/cspell.yaml" ] }\n')
