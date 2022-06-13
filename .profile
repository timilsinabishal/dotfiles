# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# custom settings
# map caps as ctrl in long press and esc in short press

#set caps as esc long cap as control
#setxkbmap -option 'caps:ctrl_modifier'
#xcape -e 'Caps_Lock=Escape' -t 100

# config alias for dotfiles versioning
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# alias
alias ssh="sshrc"
alias copy="xclip -selection c"

#android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$HOME/miniconda3/bin

export ANDROID_NDK=$HOME/Library/Android/ndk
export ANDROID_SDK=$HOME/Library/Android/sdk

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=~/.local/bin:$PATH
export PATH=~/.composer/vendor/bin/:$PATH
# added by Anaconda3 5.0.1 installer
# export PATH="/Users/bishal/anaconda3/bin:$PATH"
alias composer="php /usr/local/bin/composer.phar"

export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
PATH=$PATH:/opt/metasploit-framework/bin
export PATH=$PATH:/opt/metasploit-framework/bin

export GOPATH="${HOME}/go"
export GOROOT="$(brew --prefix golang)/libexec"

export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PYTHON_CONFIGURE_OPTS="--enable-framework"

export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/php@7.3/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-11.0.15.jdk/Contents/Home
export PATH=$JAVA_HOME/bin:$PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
