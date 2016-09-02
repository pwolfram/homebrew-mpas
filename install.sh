#!/usr/bin/env bash

if [[ "$unamestr" == "Darwin" ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  echo 'Must add "$HOME/.linuxbrew/bin:$PATH" to $PATH'
fi
