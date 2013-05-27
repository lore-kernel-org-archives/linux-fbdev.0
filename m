From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 May 2013 08:36:16 +0000
Subject: [PATCH] console/dummy: Move screen size selection from CPP to Kconfig
Message-Id: <1369643776-20516-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

PA-RISC already handled the dummy console screen size selection in Kconfig,
so generalize this to other platforms.

ARM keeps on using screen_info, which is filled in by platform-specific
code, or from ATAGS.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/console/Kconfig    |   16 ++++++++++------
 drivers/video/console/dummycon.c |    5 +----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 8af6ad3..7bfe7e1 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -76,18 +76,22 @@ config DUMMY_CONSOLE
 
 config DUMMY_CONSOLE_COLUMNS
         int "Initial number of console screen columns"
-        depends on PARISC && DUMMY_CONSOLE
-        default "160"
+        depends on DUMMY_CONSOLE && !ARM
+        default 160 if PARISC
+        default 80
         help
-          The default value is 160, which should fit a 1280x1024 monitor.
+          On PA-RISC, the default value is 160, which should fit a 1280x1024
+          monitor.
           Select 80 if you use a 640x480 resolution by default.
 
 config DUMMY_CONSOLE_ROWS
         int "Initial number of console screen rows"
-        depends on PARISC && DUMMY_CONSOLE
-        default "64"
+        depends on DUMMY_CONSOLE && !ARM
+        default 64 if PARISC
+        default 25
         help
-          The default value is 64, which should fit a 1280x1024 monitor.
+          On PA-RISC, the default value is 64, which should fit a 1280x1024
+          monitor.
           Select 25 if you use a 640x480 resolution by default.
 
 config FRAMEBUFFER_CONSOLE
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index b63860f..6b1a5d1 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -20,13 +20,10 @@
 #if defined(__arm__)
 #define DUMMY_COLUMNS	screen_info.orig_video_cols
 #define DUMMY_ROWS	screen_info.orig_video_lines
-#elif defined(__hppa__)
+#else
 /* set by Kconfig. Use 80x25 for 640x480 and 160x64 for 1280x1024 */
 #define DUMMY_COLUMNS	CONFIG_DUMMY_CONSOLE_COLUMNS
 #define DUMMY_ROWS	CONFIG_DUMMY_CONSOLE_ROWS
-#else
-#define DUMMY_COLUMNS	80
-#define DUMMY_ROWS	25
 #endif
 
 static const char *dummycon_startup(void)
-- 
1.7.0.4

