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
  brew install awscli bash bash-completion coreutils ctags direnv ffmpeg findutils fzf gcc git git-lfs gnu-sed gnutls gpg grep htop hub hugo imagemagick jq lazydocker nodejs openssl p7zip packer pango pipenv pyenv pyenv-virtualenv rbenv rename ripgrep stow tmux urlview vim z zlib

  echo "Changing default shell to latest bash"
  echo "/usr/local/bin/bash" | sudo tee -a /etc/shells
  chsh -s /usr/local/bin/bash

  echo "Tap some casks"
  brew tap homebrew/cask-cask
  brew tap homebrew/cask-drivers
  brew tap homebrew/cask-fonts
  brew tap homebrew/cask-versions

  echo "Installing casks"
  brew cask install appcleaner docker sequel-pro-nightly flycut font-fira-mono font-open-sans google-backup-and-sync google-chrome iterm2 karabiner-elements keepingyouawake logitech-options nightowl slack zoomus

  echo "Installing global python tools"
  MY_PYTHON_VERSION=3.8.5
  pyenv install $MY_PYTHON_VERSION
  pyenv global $MY_PYTHON_VERSION
  echo $MY_PYTHON_VERSION >> $HOME/.python-version
  pip install --upgrade pip
  pip install flake8
  pip install vim-vint

  echo "Installing global npms"
  npm install -g firebase-tools prettier jsonlint markdownlint-cli

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
