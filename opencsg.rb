require 'formula'

class Opencsg < Formula
  homepage 'http://www.opencsg.org'
  url 'http://www.opencsg.org/OpenCSG-1.4.0.tar.gz'
  sha1 '2c2592a9f625ec1c7a3d208403ea2ac1cae2f972'

  option "macosx-deployment-target=", "Mac OS X deployment target"

  depends_on 'qt5' => :build
  depends_on 'glew'

  def install
    system "qmake", "-r", "PREFIX=#{prefix}",
      "INCLUDEPATH+=#{HOMEBREW_PREFIX}/include", 
      "LIBS+=-L#{HOMEBREW_PREFIX}/lib -lGLEW"

    system "make", "install"
  end
end
