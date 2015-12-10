From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 10 Dec 2015 14:25:32 +0000
Subject: [PATCH RFC 6/9] omapfb: take omapfb's prive omapdss into use
Message-Id: <1449757535-5674-7-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

omapfb's private copy of omapdss is now ready to be used.

This patch makes omapfb use its private omapdss and display drivers, and
also makes omap_vout (which uses omapfb) to depend on omapfb.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/media/platform/omap/Kconfig       | 2 +-
 drivers/video/fbdev/omap2/Makefile        | 2 +-
 drivers/video/fbdev/omap2/omapfb/Kconfig  | 8 ++++++++
 drivers/video/fbdev/omap2/omapfb/Makefile | 2 ++
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/omap/Kconfig b/drivers/media/platform/omap/Kconfig
index 217d613b0fe7..e8e2db181a7a 100644
--- a/drivers/media/platform/omap/Kconfig
+++ b/drivers/media/platform/omap/Kconfig
@@ -5,9 +5,9 @@ config VIDEO_OMAP2_VOUT
 	tristate "OMAP2/OMAP3 V4L2-Display driver"
 	depends on MMU
 	depends on ARCH_OMAP2 || ARCH_OMAP3
+	depends on FB_OMAP2
 	select VIDEOBUF_GEN
 	select VIDEOBUF_DMA_CONTIG
-	select OMAP2_DSS if HAS_IOMEM && ARCH_OMAP2PLUS
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
 	select VIDEO_OMAP2_VOUT_VRFB if VIDEO_OMAP2_VOUT && OMAP2_VRFB
 	select FRAME_VECTOR
diff --git a/drivers/video/fbdev/omap2/Makefile b/drivers/video/fbdev/omap2/Makefile
index f8745ec369cc..c73a1e864ae8 100644
--- a/drivers/video/fbdev/omap2/Makefile
+++ b/drivers/video/fbdev/omap2/Makefile
@@ -2,4 +2,4 @@ obj-$(CONFIG_OMAP2_VRFB) += vrfb.o
 
 obj-y += dss/
 obj-y += displays-new/
-obj-$(CONFIG_FB_OMAP2) += omapfb/
+obj-y += omapfb/
diff --git a/drivers/video/fbdev/omap2/omapfb/Kconfig b/drivers/video/fbdev/omap2/omapfb/Kconfig
index 7ba1a22199b8..13d99a9e6198 100644
--- a/drivers/video/fbdev/omap2/omapfb/Kconfig
+++ b/drivers/video/fbdev/omap2/omapfb/Kconfig
@@ -3,6 +3,7 @@ menuconfig FB_OMAP2
         depends on FB
         depends on DRM_OMAP = n
 
+        select FB_OMAP2_DSS
 	select OMAP2_VRFB if ARCH_OMAP2 || ARCH_OMAP3
         select FB_CFB_FILLRECT
         select FB_CFB_COPYAREA
@@ -10,6 +11,8 @@ menuconfig FB_OMAP2
         help
 	  Frame buffer driver for OMAP2+ based boards.
 
+if FB_OMAP2
+
 config FB_OMAP2_DEBUG_SUPPORT
         bool "Debug support for OMAP2+ FB"
 	default y
@@ -26,3 +29,8 @@ config FB_OMAP2_NUM_FBS
 	help
 	  Select the number of framebuffers created. OMAP2/3 has 3 overlays
 	  so normally this would be 3.
+
+source "drivers/video/fbdev/omap2/omapfb/dss/Kconfig"
+source "drivers/video/fbdev/omap2/omapfb/displays/Kconfig"
+
+endif
diff --git a/drivers/video/fbdev/omap2/omapfb/Makefile b/drivers/video/fbdev/omap2/omapfb/Makefile
index 51c2e00d9bf8..0490951f95b3 100644
--- a/drivers/video/fbdev/omap2/omapfb/Makefile
+++ b/drivers/video/fbdev/omap2/omapfb/Makefile
@@ -1,2 +1,4 @@
+obj-y += dss/
+obj-y += displays/
 obj-$(CONFIG_FB_OMAP2) += omapfb.o
 omapfb-y := omapfb-main.o omapfb-sysfs.o omapfb-ioctl.o
-- 
2.5.0

