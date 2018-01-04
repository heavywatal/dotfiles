if [ $(uname) = Darwin ]; then
    export CC=clang
    export CXX=clang++
    export MACOSX_DEPLOYMENT_TARGET=$(sw_vers -productVersion | cut -d. -f-2)
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    # Resource Fork reduction for 'tar'
    export COPYFILE_DISABLE=true
    export COPY_EXTENDED_ATTRIBUTES_DISABLE=true
    if [ -x /usr/libexec/path_helper ]; then
        PATH=''
        eval $(/usr/libexec/path_helper -s)
    fi
elif [ $(uname) = Linux ]; then
    PATH=/usr/bin:/bin
    . /etc/environment
    . /etc/profile
fi

# PATH
[[ $PATH =~ /usr/local/sbin ]] || PATH=/usr/local/sbin:$PATH
[[ $PATH =~ /usr/local/bin ]] || PATH=/usr/local/bin:$PATH
if [ $(uname) = Linux ]; then
    PATH=${HOME}/.linuxbrew/bin:${HOME}/.linuxbrew/sbin:$PATH
else
    PATH=${HOME}/.homebrew/bin:${HOME}/.homebrew/sbin:$PATH
fi
brew_prefix=$(brew --prefix 2>/dev/null)
if [ -n "${brew_prefix}" ]; then
    PATH=${brew_prefix}/opt/coreutils/libexec/gnubin:$PATH
    PATH=${brew_prefix}/opt/gnu-sed/libexec/gnubin:$PATH
    PATH=${brew_prefix}/opt/gnu-tar/libexec/gnubin:$PATH
    PATH=${brew_prefix}/opt/qt5/bin:$PATH
fi

if which pyenv >/dev/null; then eval "$(pyenv init -)"; fi
PATH=$(python -m site --user-base)/bin:$PATH

PATH=/opt/local/bin:/opt/local/sbin:$PATH
PATH=${HOME}/local/bin:${HOME}/local/scripts:$PATH
export PATH

# Language
export LANG=C
export LC_CTYPE=en_US.UTF-8
