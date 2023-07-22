#!/usr/bin/env bash

set -uex

if [ "$(uname)" == 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

# Installing homebrew
echo "Installing homebrew"
if type brew >/dev/null; then
  echo "homebrew is already installed"
else
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# install brews
brew bundle || true
if [ OS = "Mac"]; then
  brew autoupdate start --upgrade --cleanup --enable-notification
fi

# Install dotfiles
chezmoi init makiton && chezmoi apply -v

