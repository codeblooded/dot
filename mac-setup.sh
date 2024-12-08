#!/bin/bash

export NAME="Ben Reed"
export EMAIL="benvreed@gmail.com"

echo "> Installing Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "> Installing command line tools"
brew install \
    cloc \
    fzf \
    gh \
    git \
    go \
    pyenv \
    sqlite \
    tmux \
    tree \
    vim \
    zsh

echo "> Configuring vim"
ln -s ~/dot/.vimrc ~/.vimrc

echo "> Configuring latest zsh"
sudo echo "/opt/homebrew/bin/zsh" >> /etc/shells
chsh -s /opt/homebrew/bin/zsh

echo "> Installing Docker, expect Rosetta prompt"
brew install docker

echo "> Installing Rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "> Setting up zsh"
ln -s ~/dot/.zprofile ~/.zprofile
ln -s ~/dot/.zshenv ~/.zshenv
ln -s ~/dot/.zshrc ~/.zshrc

echo "> Setting up Applications"
brew install --cask \
    alfred \
    chatgpt \
    google-chrome \
    google-cloud-sdk \
    iterm2 \
    spotify \
    visual-studio-code

echo "> Setting up SSH keys"
ssh-keygen -t ed25519 -C "$EMAIL"
cat <<EOF >> ~/.ssh/config
Host github.com
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_ed25519
EOF

eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

echo "> Configuring git"
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global gpg.format ssh
git config --global user.signingkey ~/.ssh/id_ed25519
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global pull.rebase true
git config --global init.defaultBranch main
git config --global url.git@github.com:.insteadOf https://github.com/

echo "> Setting up GitHub, expect browser prompt"
gh auth login
gh auth refresh -h github.com -s admin:ssh_signing_key
gh ssh-key add ~/.ssh/id_ed25519.pub --type signing --title "$(hostname -s) $(date +'%Y-%m-%d') sign"

echo "> Setting up Python"
LATEST_PYTHON="$(pyenv latest -k 3)"
pyenv install "$LATEST_PYTHON"
pyenv global "$LATEST_PYTHON"

echo "> Adding preferred fonts"
brew install --cask \
  font-fira-code \
  font-jetbrains-mono
