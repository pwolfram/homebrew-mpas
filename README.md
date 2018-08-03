# homebrew-mpas

Brew recipies for installation of mpas-dependencies, particularly on OS X.

Note, at present only mpich is supported, not open-mpi.

## Installation
Run `./install.sh` to install brew and taps needed for this installation.
 * netcdf bindings for MPAS-Tools: `brew install pwolfram/mpas/netcdf --enable-fortran --enable-cxx-compat`
   - netcdf 4.6.1
   - netcdf-cxx 4.3
   - netcdf-fortran 4.4.4
 * parallel-netcdf 1.7.0: `brew install pwolfram/mpas/parallel-netcdf --build-from-source`
 * pio 1.7.2: `brew install pwolfram/mpas/pio --build-from-source`

Compile MPAS, e.g.,
```
export NETCDF=/usr/local/Cellar/netcdf/4.6.1_2/
export PNETCDF=/usr/local/Cellar/parallel-netcdf/1.7.0_2/
export PIO=/usr/local/Cellar/pio/1.7.2
make clean gfotran CORE=ocean
```

## Notes
See http://brew.sh/ and http://linuxbrew.sh/

Note requires `brew tap brewsci/science` and `brew tap pwolfram/mpas` as prerequisites.

