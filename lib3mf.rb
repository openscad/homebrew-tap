class Lib3mf < Formula
  desc "Lib3MF - C++ implementation of the 3D Manufacturing Format file standard"
  homepage "https://github.com/3MFConsortium/lib3mf/"
  url "https://github.com/3MFConsortium/lib3mf/archive/refs/tags/v2.4.1.tar.gz"
  version "2.4.1"
  sha256 "081dea66ddd1b958644bfac0fe9a580e63726061459efce5190a10161082f8f7"

  depends_on "cmake" => :build
  depends_on "libzip"

  patch :DATA

  def install
    mkdir "build" do
      system "cmake", "-G", "Unix Makefiles", "-DLIB3MF_TESTS=false", "-DUSE_INCLUDED_ZLIB=OFF", "-DUSE_INCLUDED_LIBZIP=OFF", "-DUSE_PLATFORM_UUID=ON", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end
end
__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c6a3179..00ae52d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -1,4 +1,4 @@
-cmake_minimum_required (VERSION 3.0)
+cmake_minimum_required (VERSION 3.5)
 
 cmake_policy(SET CMP0054 NEW)
 cmake_policy(SET CMP0048 NEW)

