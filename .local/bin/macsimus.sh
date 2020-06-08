#!/bin/bash

# Set script directory DIR
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

if [[ ! $(brew --version) ]]; then
  echo "Install core utils from Xcode"
  xcode-select --install

  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  echo "Installing brew packages"
  brew install awscli bash bash-completion coreutils ctags direnv ffmpeg findutils fzf gcc git gnu-sed gnutls gpg grep htop httpie hub hugo imagemagick jq mysql nodejs openssl p7zip packer pango pyenv pyenv-virtualenv rbenv rename ripgrep stow tmux urlview vim z zlib

  echo "Starting local mysql"
  brew services start mysql

  echo "Changing default shell to latest bash"
  echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash

  echo "Tap some casks"
  brew tap homebrew/cask-cask
  brew tap homebrew/cask-drivers
  brew tap homebrew/cask-fonts

  echo "Installing casks"
  brew cask install appcleaner docker flycut font-fira-mono google-backup-and-sync google-chrome iterm2 karabiner-elements keepingyouawake logitech-options macvim nightowl sequel-pro slack zoomus

  echo "Installing global python tools"
  /usr/local/bin/pip install vim-vint

  echo "Installing global npms"
  npm install -g firebase-tools prettier tern jsonlint markdownlint-cli

  echo "Stowing files"
  stow -t ~ .

  echo "Enable keyrepeat"
  defaults write -g ApplePressAndHoldEnabled -bool false
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 12

else
  brew update
  brew upgrade
  brew cleanup -s
  brew doctor
  brew cleanup
fi

# vim:set ft=sh et sw=2:
