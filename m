From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sun, 23 May 2010 19:56:05 +0000
Subject: [PATCH 037/199] Documentation/fb/tgafb.txt: Checkpatch cleanup
Message-Id: <1274644605-25181-9-git-send-email-andrea.gelmini@gelma.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Documentation/fb/tgafb.txt:21: ERROR: trailing whitespace
Documentation/fb/tgafb.txt:47: ERROR: trailing whitespace
Documentation/fb/tgafb.txt:51: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/fb/tgafb.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/fb/tgafb.txt b/Documentation/fb/tgafb.txt
index 250083a..1328385 100644
--- a/Documentation/fb/tgafb.txt
+++ b/Documentation/fb/tgafb.txt
@@ -18,7 +18,7 @@ Jay Estabrook.
 Major new features since Linux 2.0.x:
 
  * Support for multiple resolutions
- * Support for fixed-frequency and other oddball monitors 
+ * Support for fixed-frequency and other oddball monitors
    (by allowing the video mode to be set at boot time)
 
 User-visible changes since Linux 2.2.x:
@@ -44,11 +44,11 @@ font:X    - default font to use. All fonts are supported, including the
             SUN12x22 font which is very nice at high resolutions.
 
 mode:X    - default video mode. The following video modes are supported:
-            640x480-60, 800x600-56, 640x480-72, 800x600-60, 800x600-72, 
+            640x480-60, 800x600-56, 640x480-72, 800x600-60, 800x600-72,
 	    1024x768-60, 1152x864-60, 1024x768-70, 1024x768-76,
 	    1152x864-70, 1280x1024-61, 1024x768-85, 1280x1024-70,
 	    1152x864-84, 1280x1024-76, 1280x1024-85
- 
+
 
 Known Issues
 ======
-- 
1.7.1.251.gf80a2

