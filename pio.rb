require "formula"

class Pio < Formula
  homepage "https://code.google.com/p/parallelio/"
  url "https://github.com/NCAR/ParallelIO/archive/pio1_7_2.tar.gz"
  sha256 "ecc9b50e2c75f0189c76917a555aee3b6dc3cc5e38232007577c51bb2c977e39"

  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on "open-mpi"
  depends_on "pwolfram/mpas/parallel-netcdf"

  def install
    ENV.deparallelize  # if your formula fails when building in parallel
    puts ENV['NETCDF_PATH']
    ENV['NETCDF_PATH'] = "/usr/local/"
    puts ENV['PNETCDF_PATH']
    ENV['PNETCDF_PATH'] = "/usr/local/"
    #puts ENV['FC']
    #ENV['FC'] = "ifort"
    #puts ENV['CC']
    #ENV['CC'] = #{ENV.cc}
    #puts ENV['MPIF77']
    #ENV['MPIF77'] = "/usr/local/bin/mpif77"
    #puts ENV['MPIF90']
    #ENV['MPIF90'] = "/usr/local/bin/mpif90"
    #puts ENV['MPICC']
    #ENV['MPICC'] = "/usr/local/bin/mpicc"
    Dir.chdir("pio") do
      system "./configure", "--disable-debug",
        "--prefix=#{prefix}"
      system "make"
      system "make install"
    end
    Dir.chdir("testpio") do
      system "make"
    end
  end

end
