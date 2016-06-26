require 'formula'

class Opencsg < Formula
  homepage 'http://www.opencsg.org'
  url 'http://www.opencsg.org/OpenCSG-1.4.0.tar.gz'
  sha256 'ecb46be54cfb8a338d2a9b62dec90ec8da6c769078c076f58147d4a6ba1c878d'

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
