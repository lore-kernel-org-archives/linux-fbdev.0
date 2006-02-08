From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] fbdev: Framebuffer driver for Geode GX
Date: Wed, 08 Feb 2006 09:01:49 +0800
Message-ID: <43E942FD.40604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6diz-0007Fl-Ov
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Feb 2006 17:02:25 -0800
Received: from pproxy.gmail.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F6diz-0004wR-87
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Feb 2006 17:02:25 -0800
Received: by pproxy.gmail.com with SMTP id z59so745612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 07 Feb 2006 17:02:24 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, David Vrabel <dvrabel@arcom.com>

From: David Vrabel <dvrabel@arcom.com>

A framebuffer driver for the display controller in AMD Geode GX
processors (Geode GX533, Geode GX500 etc.).  Tested at 640x480, 800x600,
1024x768 and 1280x1024 at 8, 16, and 24 bpp with both CRT and TFT.  No
accelerated features currently implemented and compression remains disabled.

This driver requires that the BIOS (or the SoftVG/Firmbase code in the
BIOS) has created an appropriate virtual PCI header.

Signed-off-by: David Vrabel <dvrabel@arcom.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/geode/Kconfig  |   15 +++++++++++++++
 drivers/video/geode/Makefile |    4 +++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/video/geode/Kconfig b/drivers/video/geode/Kconfig
index 42fb9a8..690844c 100644
--- a/drivers/video/geode/Kconfig
+++ b/drivers/video/geode/Kconfig
@@ -8,6 +8,21 @@ config FB_GEODE
 	  Say 'Y' here to allow you to select framebuffer drivers for
 	  the AMD Geode family of processors.
 
+config FB_GEODE_GX
+	tristate "AMD Geode GX framebuffer support (EXPERIMENTAL)"
+	depends on FB_GEODE && EXPERIMENTAL
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	---help---
+	  Framebuffer driver for the display controller integrated into the
+	  AMD Geode GX processors.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called gxfb.
+
+	  If unsure, say N.
+
 config FB_GEODE_GX1
 	tristate "AMD Geode GX1 framebuffer support (EXPERIMENTAL)"
 	depends on FB_GEODE && EXPERIMENTAL
diff --git a/drivers/video/geode/Makefile b/drivers/video/geode/Makefile
index 13ad501..f896565 100644
--- a/drivers/video/geode/Makefile
+++ b/drivers/video/geode/Makefile
@@ -1,5 +1,7 @@
 # Makefile for the Geode family framebuffer drivers
 
 obj-$(CONFIG_FB_GEODE_GX1) += gx1fb.o
+obj-$(CONFIG_FB_GEODE_GX)  += gxfb.o
 
-gx1fb-objs   		:= gx1fb_core.o display_gx1.o video_cs5530.o
+gx1fb-objs := gx1fb_core.o display_gx1.o video_cs5530.o
+gxfb-objs  := gxfb_core.o display_gx.o video_gx.o




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
