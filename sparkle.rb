require 'formula'

class Sparkle < Formula
  homepage 'http://sparkle.andymatuschak.org'
  head 'https://github.com/Cocoanetics/Sparkle.git', :revision => '1e7dcb1a48b96d1a8c62100b5864bd50211cbae1'

  def install
    system "xcodebuild"
    lib.install "build/Release/Sparkle.framework"
  end

  def patches
    DATA
  end
end

__END__
diff --git a/SUConstants.h b/SUConstants.h
index 0dcc6cf..25dbe6d 100644
--- a/SUConstants.h
+++ b/SUConstants.h
@@ -24,7 +24,7 @@
 // If your app file on disk is named "MyApp 1.1b4", Sparkle usually updates it
 //	in place, giving you an app named 1.1b4 that is actually 1.2. Turn the
 //	following on to always reset the name back to "MyApp":
-#define NORMALIZE_INSTALLED_APP_NAME				0
+#define NORMALIZE_INSTALLED_APP_NAME				1
 
 
 #define TRY_TO_APPEND_VERSION_NUMBER				1
