"""Symlink dotfiles to home."""
from pathlib import Path

ignore = [".DS_Store", ".git", ".gitignore", ".vscode"]


def _ln_s(source: Path, link: Path) -> None:
    if link.exists():
        if link.is_symlink():
            print("OK:", link.relative_to(Path.home()))
        else:
            print("WARNING: Not symlink:", link)
    elif link.is_symlink():
        print("WARNING: Broken link:", link)
    else:
        print("ln -s", source, link)
        link.symlink_to(source)


for x in sorted(Path(__file__).resolve().parent.iterdir()):
    if x.name in ignore or not x.name.startswith("."):
        print("# :", x.name)
    else:
        source = x.relative_to(Path.home().resolve())
        link = Path.home() / x.name
        _ln_s(source, link)


app_support = Path("~/Library/Application Support").expanduser()
if app_support.exists():
    xdg_config_home = Path("../../.config")
    for x in ["Code", "ruff"]:
        source = xdg_config_home / x
        link = app_support / x
        _ln_s(source, link)
