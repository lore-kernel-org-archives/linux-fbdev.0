From: Davor Joja <davorjoja@logicbricks.com>
Date: Wed, 11 Mar 2015 15:27:09 +0000
Subject: [PATCH 08/10] fbdev: Xylon framebuffer driver to fbdev Kconfig and Makefile
Message-Id: <83805b50-9171-479c-8028-ee8e685309de@mail.xylon.local>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426087631-9952-1-git-send-email-davorjoja@logicbricks.com>
In-Reply-To: <1426087631-9952-1-git-send-email-davorjoja@logicbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, geert@linux-m68k.org
Cc: Davor Joja <davorjoja@logicbricks.com>

Adding Xylon framebuffer driver to fbdev Kconfig and Makefile.

Signed-off-by: Davor Joja <davorjoja@logicbricks.com>
---
 drivers/video/fbdev/Kconfig  | 1 +
 drivers/video/fbdev/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index b3dd417..3bd0693 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2454,6 +2454,7 @@ source "drivers/video/fbdev/omap/Kconfig"
 source "drivers/video/fbdev/omap2/Kconfig"
 source "drivers/video/fbdev/exynos/Kconfig"
 source "drivers/video/fbdev/mmp/Kconfig"
+source "drivers/video/fbdev/xylon/Kconfig"
 
 config FB_SH_MOBILE_MERAM
 	tristate "SuperH Mobile MERAM read ahead support"
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 1979aff..57cb259 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_FB_JZ4740)		  += jz4740_fb.o
 obj-$(CONFIG_FB_PUV3_UNIGFX)      += fb-puv3.o
 obj-$(CONFIG_FB_HYPERV)		  += hyperv_fb.o
 obj-$(CONFIG_FB_OPENCORES)	  += ocfb.o
+obj-$(CONFIG_FB_XYLON)		  += xylon/
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_UVESA)            += uvesafb.o
-- 
1.9.1

