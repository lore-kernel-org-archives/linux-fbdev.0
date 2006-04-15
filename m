From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] cleanup the CONFIG_VIDEO_SELECT mess
Date: Sat, 15 Apr 2006 13:56:16 +0200
Message-ID: <20060415115616.GE15022@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932497AbWDOL4S@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, ak@suse.de, discuss@x86-64.org, thomas@winischhofer.net

We had three (sic) VIDEO_SELECT options:
- two in drivers/video/Kconfig
- one in drivers/video/console/Kconfig

This patch removes the two options in drivers/video/Kconfig and also 
removes the unneeded usage in drivers/video/sis/sis_main.c .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/Kconfig        |   11 -----------
 drivers/video/sis/sis_main.c |    2 +-
 2 files changed, 1 insertion(+), 12 deletions(-)

--- linux-2.6.17-rc1-mm2-full/drivers/video/Kconfig.old	2006-04-15 13:37:49.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/video/Kconfig	2006-04-15 13:38:07.000000000 +0200
@@ -481,11 +481,6 @@
 	  You will get a boot time penguin logo at no additional cost. Please
 	  read <file:Documentation/fb/vesafb.txt>. If unsure, say Y.
 
-config VIDEO_SELECT
-	bool
-	depends on FB_VESA
-	default y
-
 config FB_HGA
 	tristate "Hercules mono graphics support"
 	depends on FB && X86
@@ -508,12 +503,6 @@
 	This will compile the Hercules mono graphics with
 	acceleration functions.
 
-
-config VIDEO_SELECT
-	bool
-	depends on (FB = y) && X86
-	default y
-
 config FB_SGIVW
 	tristate "SGI Visual Workstation framebuffer support"
 	depends on FB && X86_VISWS
--- linux-2.6.17-rc1-mm2-full/drivers/video/sis/sis_main.c.old	2006-04-15 13:38:41.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/video/sis/sis_main.c	2006-04-15 13:39:13.000000000 +0200
@@ -275,7 +275,7 @@
 static void __devinit
 sisfb_get_vga_mode_from_kernel(void)
 {
-#if (defined(__i386__) || defined(__x86_64__)) && defined(CONFIG_VIDEO_SELECT)
+#ifdef CONFIG_X86
 	char mymode[32];
 	int  mydepth = screen_info.lfb_depth;
 
