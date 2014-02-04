require 'formula'

class Cgal < Formula
  homepage 'http://www.cgal.org/'
  url 'https://gforge.inria.fr/frs/download.php/32994/CGAL-4.3.tar.gz'
  sha1 '035d5fd7657e9eeccfc46ff0ebf84f137e63b03a'

  option :cxx11

  option 'imaging', "Build ImageIO and QT compoments of CGAL"
  option 'with-eigen3', "Build with Eigen3 support"
  option 'with-lapack', "Build with LAPACK support"
  option "macosx-deployment-target=", "Mac OS X deployment target"

  depends_on 'cmake' => :build
  if build.cxx11?
    depends_on 'boost' => 'c++11'
    depends_on 'gmp'   => 'c++11'
  else
    depends_on 'openscad/tap/boost'
    depends_on 'openscad/tap/gmp'
  end
  depends_on 'openscad/tap/mpfr'

  depends_on 'openscad/tap/qt' if build.include? 'imaging'
  depends_on 'openscad/tap/eigen' if build.include? 'with-eigen3'

  def install
    ENV.cxx11 if build.cxx11?
    macosx_deployment_target = ARGV.value('macosx-deployment-target') || MacOS.version
    args = ["-DCMAKE_INSTALL_PREFIX=#{prefix}",
            "-DCMAKE_BUILD_TYPE=Release",
            "-DCMAKE_BUILD_WITH_INSTALL_RPATH=ON",
            "-DCMAKE_INSTALL_NAME_DIR=#{HOMEBREW_PREFIX}/lib",
            "-DCMAKE_OSX_DEPLOYMENT_TARGET=#{macosx_deployment_target}"]
    unless build.include? 'imaging'
      args << "-DWITH_CGAL_Qt3=OFF" << "-DWITH_CGAL_Qt4=OFF" << "-DWITH_CGAL_ImageIO=OFF"
    end
    if build.include? 'with-eigen3'
      args << "-DWITH_Eigen3=ON"
    end
    if build.include? 'with-lapack'
      args << "-DWITH_LAPACK=ON"
    end
    args << '.'
    system "cmake", *args
    system "make install"
  end
end
