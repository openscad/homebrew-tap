require 'formula'

class Opencsg < Formula
  homepage 'http://www.opencsg.org'
  url 'http://www.opencsg.org/OpenCSG-1.3.2.tar.gz'
  sha1 'e2b4abf169ae3e319eb5f6d9ae6136fa96710a05'

  option "macosx-deployment-target=", "Mac OS X deployment target"

  depends_on 'openscad/tap/qt' => :build
  depends_on 'openscad/tap/glew'

  def install
    system "qmake", "-r", "PREFIX=#{prefix}",
      "INCLUDEPATH+=#{HOMEBREW_PREFIX}/include", 
      "LIBS+=-L#{HOMEBREW_PREFIX}/lib -lGLEW"

    system "make", "install"
  end

  def patches
    # Patch to make the library install correctly
    DATA
  end
end

__END__
diff --git a/src/src.pro b/src/src.pro
index 45aa1ea..71d201b 100644
--- a/src/src.pro
+++ b/src/src.pro
@@ -43,3 +43,16 @@ SOURCES		= area.cpp \
 		  settings.cpp \
 		  stencilManager.cpp \
 		  ../RenderTexture/RenderTexture.cpp
+
+isEmpty(PREFIX) {
+  PREFIX = /usr/local
+}
+
+INCLUDEPATH += $$PREFIX/include
+LIBS += -L$$PREFIX/lib -lGLEW
+CONFIG += absolute_library_soname
+
+target.path = $$PREFIX/lib
+headers.files = ../include/opencsg.h
+headers.path = $$PREFIX/include
+INSTALLS += target headers
diff --git a/src/src.pro b/src/src.pro
index 71d201b..67c6f20 100644
--- a/src/src.pro
+++ b/src/src.pro
@@ -4,7 +4,8 @@ VERSION     = 1.3.2
 DESTDIR     = ../lib
 
 CONFIG		+= opengl warn_on release
-INCLUDEPATH += ../include ../glew/include ../
+INCLUDEPATH += ../include ../
+CONFIG -= qt
 
 HEADERS		= ../include/opencsg.h \
 		  opencsgConfig.h \
