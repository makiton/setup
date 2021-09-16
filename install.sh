#!/usr/bin/env bash

set -uex

# Installing homebrew
echo "Installing homebrew"
if type brew > /dev/null; then
  echo "homebrew is already installed";
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install brews 
brew bundle

# Install dotfiles 
if [ ! -e ../dotfiles ]; then
  gh repo clone makiton/dotfiles ../dotfiles
  $(cd ../dotfiles && ./install.sh)
fi

# Install dein.vim
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/dein-installer.sh
sh /tmp/dein-installer.sh ~/.cache/dein/
