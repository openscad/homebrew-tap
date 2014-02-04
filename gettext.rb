require 'formula'

class Gettext < Formula
  homepage 'http://www.gnu.org/software/gettext/'
  url 'http://ftpmirror.gnu.org/gettext/gettext-0.18.3.2.tar.gz'
  mirror 'http://ftp.gnu.org/gnu/gettext/gettext-0.18.3.2.tar.gz'
  sha256 'd1a4e452d60eb407ab0305976529a45c18124bd518d976971ac6dc7aa8b4c5d7'

  keg_only "OS X provides the BSD gettext library and some software gets confused if both are in the library path."

  option :universal
  option 'with-examples', 'Keep example files'
  option "macosx-deployment-target=", "Mac OS X deployment target"

  def patches
    unless build.include? 'with-examples'
      # Use a MacPorts patch to disable building examples at all,
      # rather than build them and remove them afterwards.
      {:p0 => ['https://trac.macports.org/export/102008/trunk/dports/devel/gettext/files/patch-gettext-tools-Makefile.in']}
    end
  end

  def install
    macosx_deployment_target = ARGV.value('macosx-deployment-target') || MacOS.version
    ENV.libxml2
    ENV.universal_binary if build.universal?

    system "./configure", "--disable-dependency-tracking",
                          "--disable-debug",
                          "--prefix=#{prefix}",
                          "--disable-java",
                          "--disable-csharp",
                          # Don't use VCS systems to create these archives
                          "--without-git",
                          "--without-cvs",
                          "CFLAGS=-mmacosx-version-min=#{macosx_deployment_target}",
                          "LDFLAGS=-mmacosx-version-min=#{macosx_deployment_target}"

    system "make"
    ENV.deparallelize # install doesn't support multiple make jobs
    system "make install"
  end
end
