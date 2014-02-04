require 'formula'

class Freetype < Formula
  homepage 'http://www.freetype.org'
  url 'http://downloads.sf.net/project/freetype/freetype2/2.5.2/freetype-2.5.2.tar.bz2'
  sha1 '72731cf405b9f7c0b56d144130a8daafa262b729'

  bottle do
    cellar :any
    sha1 '0165d6c3c81c986b82605206f8afc5f1ce23e5b7' => :mavericks
    sha1 '46f1a1b6f323a951982345452bd262907c7d9429' => :mountain_lion
    sha1 '4d87eee4bfc2052951fe948d5483869c0923a3e3' => :lion
  end

  keg_only :provided_pre_mountain_lion

  option :universal
  option "macosx-deployment-target=", "Mac OS X deployment target"

  depends_on :libpng => :optional

  def install
    macosx_deployment_target = ARGV.value('macosx-deployment-target') || MacOS.version
    ENV.universal_binary if build.universal?
    system "./configure", "--prefix=#{prefix}",
      "--without-png" if build.without? 'libpng',
      "CFLAGS=-mmacosx-version-min=#{macosx_deployment_target}",
      "LDFLAGS=-mmacosx-version-min=#{macosx_deployment_target}"

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/freetype-config", '--cflags', '--libs', '--ftversion',
      '--exec-prefix', '--prefix'
  end
end
