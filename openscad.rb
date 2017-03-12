require 'formula'

class Openscad < Formula
  homepage 'http://www.openscad.org'
  version '2015.03-3'
  url 'http://files.openscad.org/openscad-2015.03-3.src.tar.gz'
  sha256 '5d2a7d83c32f4201ee0d17445a36baccaebc0bc7facd009fc8dd86ee537c5a36'

  head do
    url 'https://github.com/openscad/openscad.git', :using => :git
    version 'FIXME: YYYY.MM.DD'
  end

  depends_on "eigen"
  depends_on "boost"
  depends_on "cgal"
  depends_on "glew"
  depends_on "glib"
  depends_on "opencsg"
  depends_on "freetype"
  depends_on "libzip"
  depends_on "libxml2"
  depends_on "fontconfig"
  depends_on "harfbuzz"
  depends_on "qt5"
  depends_on "qscintilla2"

  def install
    system "qmake", "VERSION=#{version}", "PREFIX=#{prefix}", 
      "OPENSCAD_LIBRARIES=#{HOMEBREW_PREFIX}", "CONFIG-=debug", "CONFIG+=deploy"
    system "make"
    system "make install"
  end
end
