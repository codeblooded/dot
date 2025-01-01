# ============================================================================== #
#                                Ben Reed's ZSHRC                                #
# ============================================================================== #

# Keybindings
bindkey -e

# History
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY

# Disable beeps
unsetopt BEEP

# Prompt
autoload -U promptinit && promptinit
prompt adam1

# Editor
export EDITOR=$(which nvim)
export VISUAL=$EDITOR
alias vi='nvim'
alias vim='nvim'

# fzf integration
source <(fzf --zsh)

# zsh completions
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Python
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Python venv auto-activation
function auto_activate_venv() {
  if [[ -f "./.venv/bin/activate" ]]; then
    RPROMPT="%F{green}(venv)%f"
    source ./.venv/bin/activate
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    deactivate
  fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd auto_activate_venv
auto_activate_venv

# File management
alias ll="ls -al"
mkcd() { mkdir -p "$1" && cd "$1" }

# Session management
alias tx="tmux"
alias txs="$tx new-session -A -t ${1:-"b"}"
alias xx="clear"

# Process management
alias ports="lsof -i -P -n"
alias iplocal="ipconfig getifaddr en0"

# Bazel
if command -v bazel &> /dev/null; then
  alias b="bazel"
  alias bb="$b build"
  alias bt="$b test"
  alias br="$b run"
  alias bcl="$b clean"
  alias bqq="$b query"
fi
