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

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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

export PATH=~/.local/bin:$PATH
export PATH=~/.composer/vendor/bin/:$PATH
# added by Anaconda3 5.0.1 installer
# export PATH="/Users/bishal/anaconda3/bin:$PATH"
alias composer="php /usr/local/bin/composer.phar"

export FZF_DEFAULT_OPTS='--height 40% --reverse --border'
