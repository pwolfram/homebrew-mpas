#!/usr/bin/env bash

if [[ "$unamestr" == "Darwin" ]]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install)"
  echo 'Must add "$HOME/.linuxbrew/bin:$PATH" to $PATH'
  export PATH=$HOME/.linuxbrew/bin:$PATH
fi

brew tap pwolfram/mpas
brew tap brewsci/science

echo 'May need a proxy for this to work...'
# may need to use `export https_proxy=http://proxyout.lanl.gov:8080`
# note presumes only mpich is in use
brew install mpich
brew install netcdf
brew install brewsci/science/parallel-netcdf
brew install pwolfram/mpas/pio

#brew reinstall nco --build-from-source

# needed for mesh generation tools
brew install llvm
brew install metis

# needed for compass
brew install wget
