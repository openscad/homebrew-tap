require 'formula'

class Openscad < Formula
  homepage 'http://www.openscad.org'
  version '2013.06'
  url 'http://files.openscad.org/openscad-#{version}.src.tar.gz'
  sha1 '8730cbea304ba178a6819dc2acc4bf41135b684a'

  head do
    url 'https://github.com/openscad/openscad.git', :using => :git
    version 'FIXME: YYYY.MM.DD'
  end

  depends_on 'openscad/tap/qt'
  depends_on 'openscad/tap/eigen'
  depends_on 'openscad/tap/boost'
  depends_on 'openscad/tap/cgal'
  depends_on 'openscad/tap/glew'
  depends_on 'openscad/tap/glib'
  depends_on 'openscad/tap/opencsg'

  def install
    system "qmake", "VERSION=#{version}", "PREFIX=#{prefix}", 
      "OPENSCAD_LIBRARIES=#{HOMEBREW_PREFIX}", "CONFIG--debug", "CONFIG+=deploy"
    system "make"
    system "make install"
  end
end
