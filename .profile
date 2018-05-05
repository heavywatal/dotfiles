if [ $(uname) = Darwin ]; then
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
PATH=/usr/local/sbin:$PATH
PATH=${PATH//:\/usr\/local\/sbin/}
PATH=/usr/local/bin:$PATH
PATH=${PATH//:\/usr\/local\/bin/}
[ -d /opt/local ]  && PATH=/opt/local/bin:/opt/local/sbin:$PATH
[ -d ~/.linuxbrew ] && PATH=${HOME}/.linuxbrew/bin:${HOME}/.linuxbrew/sbin:$PATH
[ -d ~/.homebrew ] && PATH=${HOME}/.homebrew/bin:${HOME}/.homebrew/sbin:$PATH
brew_prefix=$(brew --prefix 2>/dev/null)
if [ -n "${brew_prefix}" ]; then
    PATH=${brew_prefix}/opt/coreutils/libexec/gnubin:$PATH
    PATH=${brew_prefix}/opt/gnu-sed/libexec/gnubin:$PATH
    PATH=${brew_prefix}/opt/gnu-tar/libexec/gnubin:$PATH
    PATH=${brew_prefix}/opt/qt5/bin:$PATH
    MANPATH=${brew_prefix}/share/man:${MANPATH}
    MANPATH=${brew_prefix}/opt/coreutils/libexec/gnuman:${MANPATH}
    export HOMEBREW_NO_ANALYTICS=1
fi
unset brew_prefix

PATH=${HOME}/.nodebrew/current/bin:${PATH}

export GOPATH=${HOME}/.go
PATH=${GOPATH}/bin:${PATH}

export PYENV_ROOT=${HOME}/.pyenv
[ -d $PYENV_ROOT ] && PATH=${PYENV_ROOT}/versions/3.6.5/bin:$PATH
PATH=$(python -m site --user-base)/bin:$PATH

PATH=${HOME}/local/bin:${HOME}/.config/bin:$PATH
export PATH

# Language
export LANG=C
export LC_CTYPE=en_US.UTF-8
