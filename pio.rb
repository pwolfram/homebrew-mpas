require "formula"

class Pio < Formula
  homepage "https://code.google.com/p/parallelio/"
  #url "https://parallelio.googlecode.com/files/pio1_6_3.tgz"
  #sha1 "44285d4b15cbd88d57f76c71fb38565b0cbc40a0"
  url 'http://parallelio.googlecode.com/svn/trunk_tags/pio1_7_2/', :using => :svn

  depends_on :x11 # if your formula requires any X11/XQuartz components
  depends_on "open-mpi"
  depends_on "parallel-netcdf"

  def install
    ENV.deparallelize  # if your formula fails when building in parallel
    #puts ENV['NETCDF_PATH']
    #ENV['NETCDF_PATH'] = "/usr/local"
    #puts ENV['PNETCDF_PATH']
    #ENV['PNETCDF_PATH'] = "/usr/local"
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
