require 'formula'

class Glew < Formula
  homepage 'http://glew.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/glew/glew/1.10.0/glew-1.10.0.tgz'
  sha1 'f41b45ca4a630ad1d00b8b87c5f493781a380300'

  option "macosx-deployment-target=", "Mac OS X deployment target"

  def install
    macosx_deployment_target = ARGV.value('macosx-deployment-target') || MacOS.version
    inreplace "glew.pc.in", "Requires: glu", ""
    system "make", "GLEW_DEST=#{prefix}", "CFLAGS.EXTRA=\"-mmacosx-version-min=#{macosx_deployment_target}\"", "LDFLAGS.EXTRA=\"-mmacosx-version-min=#{macosx_deployment_target}\"", "all"
    system "make", "GLEW_DEST=#{prefix}", "install.all"
  end
end