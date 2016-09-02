require 'formula'

class Netcdf < Formula
  homepage 'http://www.unidata.ucar.edu/software/netcdf'
  url 'http://www.gfd-dennou.org/library/netcdf/unidata-mirror/netcdf-4.3.3.1.tar.gz'
  sha256 'bdde3d8b0e48eed2948ead65f82c5cfb7590313bc32c4cf6c6546e4cea47ba19'

  depends_on :fortran if build.include? 'enable-fortran'
  depends_on 'hdf5'

  option 'enable-fortran', 'Compile Fortran bindings'
  option 'disable-cxx-compat', "Don't compile C++ bindings"
  option 'enable-cxx-compat', 'Compile C++ bindings for compatibility'
  option 'without-check', 'Disable checks (not recommended)'

  resource 'cxx-compat' do
    url 'http://www.gfd-dennou.org/library/netcdf/unidata-mirror/netcdf-cxx-4.2.tar.gz'
    sha256 '95ed6ab49a0ee001255eac4e44aacb5ca4ea96ba850c08337a3e4c9a0872ccd1'
  end

  resource 'fortran' do
    url 'http://www.gfd-dennou.org/library/netcdf/unidata-mirror/netcdf-fortran-4.4.2.tar.gz'
    sha256 'ad6249b6062df6f62f81d1cb2a072e3a4c595f27f11fe0c5a79726d1dad3143b'
  end

  def install
    if build.include? 'enable-fortran'
      # fix for ifort not accepting the --force-load argument, causing
      # the library libnetcdff.dylib to be missing all the f90 symbols.
      # http://www.unidata.ucar.edu/software/netcdf/docs/known_problems.html#intel-fortran-macosx
      # https://github.com/mxcl/homebrew/issues/13050
      ENV['lt_cv_ld_force_load'] = 'no' if ENV.fc == 'ifort'
    end

    # Intermittent availability of the DAP endpoints tested means that sometimes
    # a perfectly working build fails. This has been documented
    # [by others](http://www.unidata.ucar.edu/support/help/MailArchives/netcdf/msg12090.html),
    # and distributions like PLD linux
    # [also disable these tests](http://lists.pld-linux.org/mailman/pipermail/pld-cvs-commit/Week-of-Mon-20110627/314985.html)
    # because of this issue.

    common_args = %W[
      --disable-dependency-tracking
      --disable-dap
      --disable-dap-remote-tests
      --prefix=#{prefix}
      --enable-static
      --enable-shared
    ]

    args = common_args.clone
    #args.concat %w[--enable-netcdf4 --disable-doxygen]
    args.concat %w[--disable-netcdf4 --disable-doxygen]

    system './configure', *args
    system 'make'
    ENV.deparallelize if build.with? 'check' # Required for `make check`.
    system 'make check' if build.with? 'check'
    system 'make install'

    # Add newly created installation to paths so that binding libraries can
    # find the core libs.
    ENV.prepend_path 'PATH', bin
    ENV.prepend 'CPPFLAGS', "-I#{include}"
    ENV.prepend 'LDFLAGS', "-L#{lib}"

    resource('cxx-compat').stage do
      system './configure', *common_args
      system 'make'
      system 'make check' if build.with? 'check'
      system 'make install'
    end if build.include? 'enable-cxx-compat'

    resource('fortran').stage do
      system './configure', *common_args
      system 'make'
      system 'make check' if build.with? 'check'
      system 'make install'
    end if build.include? 'enable-fortran'
  end
end
