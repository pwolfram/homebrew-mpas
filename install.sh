#!/usr/bin/env bash

if [[ "$unamestr" == "Darwin" ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  echo 'Must add "$HOME/.linuxbrew/bin:$PATH" to $PATH'
  export PATH=$HOME/.linuxbrew/bin:$PATH
fi

brew tap homebrew/science
brew tap pwolfram/mpas

brew install pwolfram/mpas/netcdf --enable-fortran --enable-cxx-compat
brew install pwolfram/mpas/parallel-netcdf
brew install pwolfram/mpas/pio
