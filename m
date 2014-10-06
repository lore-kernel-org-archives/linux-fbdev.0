From: Davor Joja <davorjoja@logicbricks.com>
Date: Mon, 06 Oct 2014 13:32:58 +0000
Subject: [RFC 08/10] video: fbdev: Xylon framebuffer driver to fbdev Kconfig and Makefile
Message-Id: <23661948-190d-4114-988c-d8999f574365@mail.xylon.local>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Adding Xylon framebuffer driver to video/fbdev Kconfig and Makefile.

Signed-off-by: Davor Joja <davorjoja@logicbricks.com>
---
 drivers/video/fbdev/Kconfig  | 1 +
 drivers/video/fbdev/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e911b9c..cb066f3 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2469,6 +2469,7 @@ source "drivers/video/fbdev/omap/Kconfig"
 source "drivers/video/fbdev/omap2/Kconfig"
 source "drivers/video/fbdev/exynos/Kconfig"
 source "drivers/video/fbdev/mmp/Kconfig"
+source "drivers/video/fbdev/xylon/Kconfig"
 
 config FB_SH_MOBILE_MERAM
 	tristate "SuperH Mobile MERAM read ahead support"
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 1979aff..537fcb2 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_FB_JZ4740)		  += jz4740_fb.o
 obj-$(CONFIG_FB_PUV3_UNIGFX)      += fb-puv3.o
 obj-$(CONFIG_FB_HYPERV)		  += hyperv_fb.o
 obj-$(CONFIG_FB_OPENCORES)	  += ocfb.o
+obj-y                             += xylon/
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
-- 
1.9.1

