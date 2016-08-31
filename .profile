# PATH
PATH=${HOME}/.homebrew/bin:${PATH}
brew_prefix=$(brew --prefix 2>/dev/null)
if [ -n "${brew_prefix}" ]; then
    PATH=${brew_prefix}/opt/coreutils/libexec/gnubin:${PATH}
    PATH=${brew_prefix}/opt/gnu-sed/libexec/gnubin:${PATH}
    PATH=${brew_prefix}/opt/gnu-tar/libexec/gnubin:${PATH}
    PATH=${brew_prefix}/opt/qt5/bin:${PATH}
fi

PATH=${HOME}/.nodebrew/current/bin:${PATH}
PATH=/opt/local/bin:/opt/local/sbin:${PATH}
PATH=${HOME}/local/bin:${HOME}/local/scripts:${PATH}
export PATH

# Language
export LANG=C
export LC_CTYPE=en_US.UTF-8
