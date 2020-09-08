require 'formula'

class Sparkle < Formula
  homepage 'http://sparkle.andymatuschak.org'
  head 'https://github.com/Cocoanetics/Sparkle.git', :revision => '1e7dcb1a48b96d1a8c62100b5864bd50211cbae1'

  def install
    system "xcodebuild"
    lib.install "build/Release/Sparkle.framework"
  end

  patch do
    url "https://raw.githubusercontent.com/openscad/homebrew-tap/master/sparkle-constants.patch"
    sha256 "a4bbf9a070135d718f89c5f4c0ae2ccc0b1d51e98e61be6b90f08aade06185c9"
  end

end
