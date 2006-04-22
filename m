From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Remove duplicate #include's
Date: Sat, 22 Apr 2006 11:21:36 +0800
Message-ID: <4449A140.7080104@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX8hk-0006jz-QI
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 20:22:40 -0700
Received: from pproxy.gmail.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FX8hj-0000Hl-Tp
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 21 Apr 2006 20:22:40 -0700
Received: by pproxy.gmail.com with SMTP id i49so649973pye
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 21 Apr 2006 20:22:29 -0700 (PDT)
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

This patch removes unneeded duplicate #include's of the same header
file.

In the case of fbmon.c linux/pci.h is now #include'd unconditional, but
this should be safe.

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/fbmem.c |    2 --
 drivers/video/fbmon.c |    3 +--
 drivers/video/tgafb.c |    1 -
 3 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 372aa17..9bb6763 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -34,7 +34,6 @@
 #endif
 #include <linux/devfs_fs_kernel.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/efi.h>
 
@@ -162,7 +161,6 @@ char* fb_get_buffer_offset(struct fb_inf
 }
 
 #ifdef CONFIG_LOGO
-#include <linux/linux_logo.h>
 
 static inline unsigned safe_shift(unsigned d, int n)
 {
diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 53beeb4..fbbcb71 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -29,9 +29,9 @@
 #include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <video/edid.h>
 #ifdef CONFIG_PPC_OF
-#include <linux/pci.h>
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
 #endif
@@ -1282,7 +1282,6 @@ int fb_validate_mode(const struct fb_var
 }
 
 #if defined(CONFIG_FB_FIRMWARE_EDID) && defined(__i386__)
-#include <linux/pci.h>
 
 /*
  * We need to ensure that the EDID block is only returned for
diff --git a/drivers/video/tgafb.c b/drivers/video/tgafb.c
index 7398bd4..6c2c78a 100644
--- a/drivers/video/tgafb.c
+++ b/drivers/video/tgafb.c
@@ -26,7 +26,6 @@
 #include <linux/selection.h>
 #include <asm/io.h>
 #include <video/tgafb.h>
-#include <linux/selection.h>
 
 /*
  * Local functions.



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
