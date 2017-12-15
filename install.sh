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
brew install open-mpi@1.6
brew link open-mpi@1.6 --force
# note that there is an incompatability with open-mpi 3.0 and parallel-netcdf
brew install pwolfram/mpas/parallel-netcdf
brew install pwolfram/mpas/pio
brew reinstall nco --build-from-source

# needed for mesh generation tools
brew install llvm
brew install metis

# needed for compass
brew install wget
