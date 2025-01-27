export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="af-magic"

zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 14

PYTHON_AUTO_VRUN=true  # auto-activate Python venvs

plugins=(fzf git docker brew golang python gcloud gh kubectl macos zsh-autosuggestions zsh-syntax-highlighting)

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi
alias vi=$EDITOR

# Compilation flags
export ARCHFLAGS="-arch $(uname -m)"

# Terminal flags
unsetopt BEEP

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# File management
alias ll="ls -al"
function mkcd { mkdir -p "$1" && cd "$1" }

# Process management
alias ports="lsof -i -P -n"
alias iplocal="ipconfig getifaddr en0"

# PostgreSQL
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# Session management
alias tx="tmux"
alias txs="$tx new-session -A -t ${1:-"b"}"
alias xx="clear"

# iTerm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
