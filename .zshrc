bindkey -e
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
unsetopt BEEP

autoload -U promptinit && promptinit
prompt adam1

export EDITOR=$(which vim)
export VISUAL=$EDITOR

source <(fzf --zsh)
function mkcd { mkdir -p "$1" && cd "$1" }
alias ll='ls -al'

# Python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

