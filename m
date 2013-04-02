From: Tony Prisk <linux@prisktech.co.nz>
Date: Tue, 02 Apr 2013 18:20:33 +0000
Subject: [PATCHv3 1/6] video: vt8500: Make wmt_ge_rops optional
Message-Id: <1364926838-6721-2-git-send-email-linux@prisktech.co.nz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1364926838-6721-1-git-send-email-linux@prisktech.co.nz>
In-Reply-To: <1364926838-6721-1-git-send-email-linux@prisktech.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

wmt_ge_rops is a seperate driver to vt8500/wm8505 framebuffer
driver but is currently a required option. This patch makes
accelerated raster ops optional.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
Reviewed-by: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 drivers/video/Kconfig       |   22 ++++++++++++----------
 drivers/video/wmt_ge_rops.h |   23 +++++++++++++++++++++++
 2 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 4c1546f..661aa54 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -212,14 +212,6 @@ config FB_SYS_FOPS
        depends on FB
        default n
 
-config FB_WMT_GE_ROPS
-	tristate
-	depends on FB
-	default n
-	---help---
-	  Include functions for accelerated rectangle filling and area
-	  copying using WonderMedia Graphics Engine operations.
-
 config FB_DEFERRED_IO
 	bool
 	depends on FB
@@ -1799,7 +1791,8 @@ config FB_AU1200
 config FB_VT8500
 	bool "VT8500 LCD Driver"
 	depends on (FB = y) && ARM && ARCH_VT8500
-	select FB_WMT_GE_ROPS
+	select FB_SYS_FILLRECT if (!FB_WMT_GE_ROPS)
+	select FB_SYS_COPYAREA if (!FB_WMT_GE_ROPS)
 	select FB_SYS_IMAGEBLIT
 	help
 	  This is the framebuffer driver for VIA VT8500 integrated LCD
@@ -1808,12 +1801,21 @@ config FB_VT8500
 config FB_WM8505
 	bool "WM8505 frame buffer support"
 	depends on (FB = y) && ARM && ARCH_VT8500
-	select FB_WMT_GE_ROPS
+	select FB_SYS_FILLRECT if (!FB_WMT_GE_ROPS)
+	select FB_SYS_COPYAREA if (!FB_WMT_GE_ROPS)
 	select FB_SYS_IMAGEBLIT
 	help
 	  This is the framebuffer driver for WonderMedia WM8505/WM8650
 	  integrated LCD controller.
 
+config FB_WMT_GE_ROPS
+	bool "VT8500/WM85xx accelerated raster ops support"
+	depends on (FB = y) && (FB_VT8500 || FB_WM8505)
+	default n
+	help
+	  This adds support for accelerated raster operations on the
+	  VIA VT8500 and Wondermedia 85xx series SoCs.
+
 source "drivers/video/geode/Kconfig"
 
 config FB_HIT
diff --git a/drivers/video/wmt_ge_rops.h b/drivers/video/wmt_ge_rops.h
index 8738075..f73ec63 100644
--- a/drivers/video/wmt_ge_rops.h
+++ b/drivers/video/wmt_ge_rops.h
@@ -1,5 +1,28 @@
+#ifdef CONFIG_FB_WMT_GE_ROPS
+
 extern void wmt_ge_fillrect(struct fb_info *info,
 			    const struct fb_fillrect *rect);
 extern void wmt_ge_copyarea(struct fb_info *info,
 			    const struct fb_copyarea *area);
 extern int wmt_ge_sync(struct fb_info *info);
+
+#else
+
+static inline int wmt_ge_sync(struct fb_info *p)
+{
+	return 0;
+}
+
+static inline void wmt_ge_fillrect(struct fb_info *p,
+				    const struct fb_fillrect *rect)
+{
+	sys_fillrect(p, rect);
+}
+
+static inline void wmt_ge_copyarea(struct fb_info *p,
+				     const struct fb_copyarea *area)
+{
+	sys_copyarea(p, area);
+}
+
+#endif
-- 
1.7.9.5

