#!/usr/bin/env bash

# Path to the bash it configuration
export BASH_IT="/Users/vladi/dotfiles/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Load Bash It
source "$BASH_IT"/bash_it.sh

# Load rbenv
if which rbenv > /dev/null; then
  eval "$(rbenv init -)";
fi

if which jenv > /dev/null; then
  eval "$(jenv init -)";
fi  

# set alias for Typora
alias typora="open -a typora"

# add PostgresSQL to the PATH:
export PATH="/usr/local/Cellar/postgresql@9.4/9.4.16/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"

# add Python (pip3) packages to the PATH:
export PATH="~/Library/Python/3.7/bin:$PATH"

# enable the C system headers:
# export CPATH=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/
# the default option above to 10.15 doesn't work when making the binutils
export CPATH=/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/

# set locale explicitly after upgrading to OS X High Sierra:
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# set NVM directory:
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/vladi/google-cloud-sdk/path.bash.inc' ]; then source '/Users/vladi/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/vladi/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/vladi/google-cloud-sdk/completion.bash.inc'; fi
