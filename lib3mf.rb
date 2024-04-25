class Lib3mf < Formula
  desc "Lib3MF - C++ implementation of the 3D Manufacturing Format file standard"
  homepage "https://github.com/3MFConsortium/lib3mf/"
  url "https://github.com/3MFConsortium/lib3mf/archive/refs/tags/v2.3.1.tar.gz"
  version "2.3.1"
  sha256 "cdf6669f2aa0b7f3053cdf635b71f2cf34d98f9edb9b65432dde0d85c646ec71"

  depends_on "cmake" => :build
  depends_on "libzip"

  def install
    mkdir "build" do
      system "cmake", "-G", "Unix Makefiles", "-DLIB3MF_TESTS=false", "-DUSE_INCLUDED_ZLIB=OFF", "-DUSE_INCLUDED_LIBZIP=OFF", "-DUSE_PLATFORM_UUID=ON", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end
end
