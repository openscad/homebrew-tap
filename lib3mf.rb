class Lib3mf < Formula
  desc "Lib3MF - C++ implementation of the 3D Manufacturing Format file standard"
  homepage "https://github.com/3MFConsortium/lib3mf/"
  url "https://github.com/t-paul/lib3mf/archive/openscad-build.zip"
  version "20181018T131926.git828d049"
  sha256 "82a55d3124e849d97762b657444e476b20624ec3da4b02480337adb8d14b28a0"

  depends_on "cmake" => :build
  depends_on "ossp-uuid"

  def install
    mkdir "build" do
      system "cmake", "-G", "Unix Makefiles", "-DLIB3MF_TESTS=false", "..", *std_cmake_args
      system "make"
      system "make", "install"
    end
  end
end
