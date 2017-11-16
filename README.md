# homebrew-mpas

Brew recipies for installation of mpas-dependencies, particularly on OS X.

## Installation
Run `./install.sh` to install brew and taps needed for this installation.
 * netcdf bindings for MPAS-Tools: `brew install pwolfram/mpas/netcdf --enable-fortran --enable-cxx-compat`
   - netcdf 4.3.3.1
   - netcdf-cxx 4.2
   - netcdf-fortran 4.4.2
 * parallel-netcdf 1.4.1: `brew install pwolfram/mpas/parallel-netcdf`
 * pio 1.7.2: `brew install pwolfram/mpas/pio`

Compile MPAS, e.g.,
```
export NETCDF=/usr/local/Cellar/netcdf/4.3.3.1/
export PNETCDF=/usr/local/Cellar/parallel-netcdf/1.4.1/
export PIO=/usr/local/Cellar/pio/1.7.2/
make clean gfotran CORE=ocean
```

## Notes
See http://brew.sh/ and http://linuxbrew.sh/

Note requires `brew tap homebrew/science` as a prerequisite.
