class Lib3mf < Formula
  desc "Lib3MF - C++ implementation of the 3D Manufacturing Format file standard"
  homepage "https://github.com/3MFConsortium/lib3mf/"
  url "https://github.com/3MFConsortium/lib3mf/archive/v1.8.1.tar.gz"
  version "1.8.1"
  sha256 "207dd142c9ca86a4fb1a4b2baadbdf579f35e03f9b8bf5c02dae027da5ae9d17"

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
