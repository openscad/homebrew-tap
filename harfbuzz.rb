require 'formula'

class Harfbuzz < Formula
  homepage 'http://www.freedesktop.org/wiki/Software/HarfBuzz'
  url 'http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.25.tar.bz2'
  sha256 'dc6e5997a569526cd28147a80a0f65466e87ae617753b38704a60184bc6d6bee'

  option "macosx-deployment-target=", "Mac OS X deployment target"

  depends_on 'pkg-config' => :build
  depends_on 'openscad/tap/glib'
  depends_on 'cairo' => :optional
  depends_on 'icu4c' => :optional
  depends_on 'openscad/tap/freetype' 

  def install
    macosx_deployment_target = ARGV.value('macosx-deployment-target') || MacOS.version
    args = %W[--disable-dependency-tracking --prefix=#{prefix} --with-freetype=yes]
    args << "--with-icu" if build.with? 'icu4c'
    args << "--with-cairo=no" if build.without? 'cairo'      
    args << "CFLAGS=-mmacosx-version-min=#{macosx_deployment_target}"
    args << "LDFLAGS=-mmacosx-version-min=#{macosx_deployment_target}"
    system "./configure", *args
    system "make install"
  end
end
