class Lib3mf < Formula
  desc "Lib3MF - C++ implementation of the 3D Manufacturing Format file standard"
  homepage "https://github.com/3MFConsortium/lib3mf/"
  url "https://github.com/3MFConsortium/lib3mf/archive/a466df47231c02298dde295adb6075b0fc649eba.tar.gz"
  version "20160218T183543.gita466df4"
  sha256 "28703467797e39e590d8fbdcc43b726286603c8862649b814d11c043e7b6dce1"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    system "make", "-C", "Project/Lib3MFGCC"
    system "make", "-C", "Project/Lib3MFGCC", "install", "INSTALL_ROOT=#{prefix}"
  end
end
