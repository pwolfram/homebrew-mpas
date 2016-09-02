require "formula"

class ParallelNetcdf < Formula
  homepage "https://trac.mcs.anl.gov/projects/parallel-netcdf"
  url "http://cucis.ece.northwestern.edu/projects/PnetCDF/Release/parallel-netcdf-1.4.1.tar.bz2"
  sha1 "0839b9789266f8c2be3656d7287f0776b797626f"

  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on "netcdf" => "enable-fortran"

  def install
    ENV.deparallelize  # if your formula fails when building in parallel
    #puts ENV['FC']
    #ENV['FC'] = "ifort"
    ENV['FC'] = "/usr/local/bin/gfortran"
    ENV['CC'] = "/usr/bin/gcc"
    ENV['MPIF77'] = "/usr/local/bin/mpif77"
    ENV['MPIF90'] = "/usr/local/bin/mpif90"
    ENV['MPICC'] = "/usr/local/bin/mpicc"
    puts ENV['CC']
    puts ENV['FC']
    puts ENV['MPICC']
    puts ENV['MPIF77']
    puts ENV['MPIF90']
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"

    ## test libraries
    #Dir.chdir('test') do
    #  system "make check testing"
    #end

  end
end
