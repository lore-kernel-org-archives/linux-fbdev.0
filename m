From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: cleanup the CONFIG_VIDEO_SELECT mess
Date: Sat, 22 Apr 2006 11:20:32 +0800
Message-ID: <4449A100.4080703@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX8hg-0006jp-EU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 20:22:36 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FX8hg-0005UR-CG
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 20:22:36 -0700
Received: from pproxy.gmail.com ([64.233.166.176])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FX8he-0006Zz-Ej
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 20:22:36 -0700
Received: by pproxy.gmail.com with SMTP id i49so649963pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Apr 2006 20:22:23 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>

From: Adrian Bunk <bunk@stusta.de>

We had three (sic) VIDEO_SELECT options:
- two in drivers/video/Kconfig
- one in drivers/video/console/Kconfig

This patch removes the two options in drivers/video/Kconfig and also
removes the unneeded usage in drivers/video/sis/sis_main.c .

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/Kconfig        |   11 -----------
 drivers/video/sis/sis_main.c |    2 +-
 2 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 5641498..1d1381b 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -483,11 +483,6 @@ config FB_VESA
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
@@ -510,12 +505,6 @@ config FB_HGA_ACCEL
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
diff --git a/drivers/video/sis/sis_main.c b/drivers/video/sis/sis_main.c
index 8adf5bf..c63c0e7 100644
--- a/drivers/video/sis/sis_main.c
+++ b/drivers/video/sis/sis_main.c
@@ -275,7 +275,7 @@ sisfb_search_mode(char *name, BOOLEAN qu
 static void __devinit
 sisfb_get_vga_mode_from_kernel(void)
 {
-#if (defined(__i386__) || defined(__x86_64__)) && defined(CONFIG_VIDEO_SELECT)
+#ifdef CONFIG_X86
 	char mymode[32];
 	int  mydepth = screen_info.lfb_depth;
 



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
