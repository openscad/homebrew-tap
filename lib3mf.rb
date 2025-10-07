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
index c6a3179..67a4b0f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -1,4 +1,4 @@
-cmake_minimum_required (VERSION 3.0)
+cmake_minimum_required (VERSION 3.10)
 
 cmake_policy(SET CMP0054 NEW)
 cmake_policy(SET CMP0048 NEW)
@@ -6,8 +6,6 @@ cmake_policy(SET CMP0048 NEW)
 
 set_property(GLOBAL PROPERTY USE_FOLDERS ON)
 
-include(GNUInstallDirs)
-
 # Define Version
 set(LIB3MF_VERSION_MAJOR 2)        # increase on every backward-compatibility breaking change of the API
 set(LIB3MF_VERSION_MINOR 4)        # increase on every backward compatible change of the API
@@ -19,15 +17,13 @@ project(lib3mf
   DESCRIPTION "An implementation of the 3D Manufacturing Format file standard"
 )
 
+include(GNUInstallDirs)
+
 find_program(buildcache_program buildcache)
 if(buildcache_program)
   set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE "${buildcache_program}")
 endif()
 
-set(CMAKE_INSTALL_BINDIR bin CACHE PATH "directory for installing binary files")
-set(CMAKE_INSTALL_LIBDIR lib CACHE PATH "directory for installing library files")
-set(CMAKE_INSTALL_INCLUDEDIR include/lib3mf CACHE PATH "directory for installing header files")
-
 option(USE_INCLUDED_ZLIB "Use included zlib" ON)
 option(USE_INCLUDED_LIBZIP "Use included libzip" ON)
 option(USE_INCLUDED_SSL "Use included libressl" ON)
@@ -201,7 +197,8 @@ if (USE_INCLUDED_LIBZIP)
 else()
     find_package(PkgConfig REQUIRED)
     pkg_check_modules(LIBZIP REQUIRED libzip)
-    target_link_libraries(${PROJECT_NAME} ${LIBZIP_LIBRARIES})
+    target_link_libraries(${PROJECT_NAME} ${LIBZIP_LINK_LIBRARIES})
+    target_include_directories(${PROJECT_NAME} PRIVATE ${LIBZIP_INCLUDE_DIRS})
 endif()
 
 
