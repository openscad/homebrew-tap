class Osmesa < Formula
  include Language::Python::Virtualenv

  desc "Mesa Off-Screen Rendering library (OSMesa) with LLVMpipe"
  homepage "https://www.mesa3d.org/"
  url "https://archive.mesa3d.org/mesa-24.3.4.tar.xz"
  sha256 "e641ae27191d387599219694560d221b7feaa91c900bcec46bf444218ed66025"
  license "MIT"
  head "https://gitlab.freedesktop.org/mesa/mesa.git", branch: "main"

  depends_on "bison" => :build
  depends_on "meson" => :build
  depends_on "ninja" => :build
  depends_on "pkgconf" => [:build, :test]
  depends_on "python@3.12" => :build

  depends_on "llvm"
  depends_on "zstd"

  resource "mako" do
    url "https://files.pythonhosted.org/packages/9e/38/bd5b78a920a64d708fe6bc8e0a2c075e1389d53bef8413725c63ba041535/mako-1.3.10.tar.gz"
    sha256 "99579a6f39583fa7e5630a28c3c1f440e4e97a414b80372649c0ce338da2ea28"
  end

  resource "markupsafe" do
    url "https://files.pythonhosted.org/packages/7e/99/7690b6d4034fffd95959cbe0c02de8deb3098cc577c67bb6a24fe5d7caa7/markupsafe-3.0.3.tar.gz"
    sha256 "722695808f4b6457b320fdc131280796bdceb04ab50fe1795cd540799ebe1698"
  end

  resource "packaging" do
    url "https://files.pythonhosted.org/packages/a1/d4/1fc4078c65507b51b96ca8f8c3ba19e6a61c8253c72794544580a7b6c24d/packaging-25.0.tar.gz"
    sha256 "d443872c98d677bf60f6a1f2f8c1cb748e8fe762d2bf9d3148b5599295b0fc4f"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/05/8e/961c0007c59b8dd7729d542c61a4d537767a59645b82a0b521206e1e25c2/pyyaml-6.0.3.tar.gz"
    sha256 "d76623373421df22fb4cf8817020cbb7ef15c725b9d5e45f17e189bfc384190f"
  end

  def python3
    "python3.12"
  end

  def install
    venv = virtualenv_create(buildpath/"venv", python3)
    venv.pip_install resources
    ENV.prepend_path "PYTHONPATH", venv.site_packages
    ENV.prepend_path "PATH", venv.root/"bin"

    ENV["SDKROOT"] = MacOS.sdk_for_formula(self).path if OS.mac?

    llvm = Formula["llvm"]
    zstd = Formula["zstd"]

    ENV.prepend_path "PATH", llvm.opt_bin
    ENV.append "LDFLAGS", "-L#{llvm.opt_lib}"
    ENV.append "LDFLAGS", "-L#{zstd.opt_lib}"
    ENV.append_path "LIBRARY_PATH", llvm.opt_lib
    ENV.append_path "LIBRARY_PATH", zstd.opt_lib

    args = %w[
      -Db_ndebug=true
      -Dosmesa=true
      -Dgallium-drivers=llvmpipe
      -Dvulkan-drivers=[]
      -Dopengl=true
      -Dgles1=disabled
      -Dgles2=disabled
      -Degl=disabled
      -Dglx=disabled
      -Dxlib-lease=disabled
      -Dxmlconfig=disabled
      -Dexpat=disabled
      -Dplatforms=[]
      -Dshared-glapi=disabled
      -Dllvm=enabled
      -Dshared-llvm=disabled
    ]

    system "meson", "setup", "build", *args, *std_meson_args
    system "meson", "compile", "-C", "build", "--verbose"
    system "meson", "install", "-C", "build"
  end

  test do
    (testpath/"test.c").write <<~C
      #ifndef GLAPI
      #define GLAPI extern
      #endif
      #ifndef GLAPIENTRY
      #define GLAPIENTRY
      #endif
      #ifndef APIENTRY
      #define APIENTRY GLAPIENTRY
      #endif
      #include <GL/osmesa.h>
      #include <stdlib.h>

      int main() {
        OSMesaContext ctx = OSMesaCreateContext(OSMESA_RGBA, NULL);
        if (!ctx) return 1;
        OSMesaDestroyContext(ctx);
        return 0;
      }
    C
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lOSMesa", "-o", "test"
    system "./test"
  end
end
