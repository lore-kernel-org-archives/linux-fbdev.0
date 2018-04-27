From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 27 Apr 2018 11:21:43 +0000
Subject: [PATCH 1/3] video: fbdev: sh_mobile_lcdcfb: remove unused MERAM support
Message-Id: <1524828105-26585-2-git-send-email-b.zolnierkie@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180427112227epcas2p4ea3a93a5680d69a62f12cac627ebafbc@epcas2p4.samsung.com>
In-Reply-To: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, b.zolnierkie@samsung.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org

Since commit a521422ea4ae  ("ARM: shmobile: mackerel: Remove Legacy C
board code") MERAM functionality is unused. Remove it.

Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig            |  1 -
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 63 +---------------------------------
 drivers/video/fbdev/sh_mobile_lcdcfb.h |  1 -
 include/video/sh_mobile_lcdc.h         |  3 --
 4 files changed, 1 insertion(+), 67 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 434e95b..1e0b9515 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1888,7 +1888,6 @@ config FB_W100
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
 	depends on FB && (SUPERH || ARCH_RENESAS) && HAVE_CLK
-	depends on FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 929b1c5..dc46be3 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -29,7 +29,6 @@
 #include <linux/vmalloc.h>
 
 #include <video/sh_mobile_lcdc.h>
-#include <video/sh_mobile_meram.h>
 
 #include "sh_mobile_lcdcfb.h"
 
@@ -217,7 +216,6 @@ struct sh_mobile_lcdc_priv {
 	struct notifier_block notifier;
 	int started;
 	int forced_fourcc; /* 2 channel LCDC must share fourcc setting */
-	struct sh_mobile_meram_info *meram_dev;
 };
 
 /* -----------------------------------------------------------------------------
@@ -346,16 +344,12 @@ static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 		if (priv->dot_clk)
 			clk_prepare_enable(priv->dot_clk);
 		pm_runtime_get_sync(priv->dev);
-		if (priv->meram_dev && priv->meram_dev->pdev)
-			pm_runtime_get_sync(&priv->meram_dev->pdev->dev);
 	}
 }
 
 static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 {
 	if (atomic_sub_return(1, &priv->hw_usecnt) = -1) {
-		if (priv->meram_dev && priv->meram_dev->pdev)
-			pm_runtime_put_sync(&priv->meram_dev->pdev->dev);
 		pm_runtime_put(priv->dev);
 		if (priv->dot_clk)
 			clk_disable_unprepare(priv->dot_clk);
@@ -1073,7 +1067,6 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 {
-	struct sh_mobile_meram_info *mdev = priv->meram_dev;
 	struct sh_mobile_lcdc_chan *ch;
 	unsigned long tmp;
 	int ret;
@@ -1106,9 +1099,6 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 	/* Compute frame buffer base address and pitch for each channel. */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
-		int pixelformat;
-		void *cache;
-
 		ch = &priv->ch[k];
 		if (!ch->enabled)
 			continue;
@@ -1117,45 +1107,6 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		ch->base_addr_c = ch->dma_handle
 				+ ch->xres_virtual * ch->yres_virtual;
 		ch->line_size = ch->pitch;
-
-		/* Enable MERAM if possible. */
-		if (mdev = NULL || ch->cfg->meram_cfg = NULL)
-			continue;
-
-		/* Free the allocated MERAM cache. */
-		if (ch->cache) {
-			sh_mobile_meram_cache_free(mdev, ch->cache);
-			ch->cache = NULL;
-		}
-
-		switch (ch->format->fourcc) {
-		case V4L2_PIX_FMT_NV12:
-		case V4L2_PIX_FMT_NV21:
-		case V4L2_PIX_FMT_NV16:
-		case V4L2_PIX_FMT_NV61:
-			pixelformat = SH_MOBILE_MERAM_PF_NV;
-			break;
-		case V4L2_PIX_FMT_NV24:
-		case V4L2_PIX_FMT_NV42:
-			pixelformat = SH_MOBILE_MERAM_PF_NV24;
-			break;
-		case V4L2_PIX_FMT_RGB565:
-		case V4L2_PIX_FMT_BGR24:
-		case V4L2_PIX_FMT_BGR32:
-		default:
-			pixelformat = SH_MOBILE_MERAM_PF_RGB;
-			break;
-		}
-
-		cache = sh_mobile_meram_cache_alloc(mdev, ch->cfg->meram_cfg,
-					ch->pitch, ch->yres, pixelformat,
-					&ch->line_size);
-		if (!IS_ERR(cache)) {
-			sh_mobile_meram_cache_update(mdev, cache,
-					ch->base_addr_y, ch->base_addr_c,
-					&ch->base_addr_y, &ch->base_addr_c);
-			ch->cache = cache;
-		}
 	}
 
 	for (k = 0; k < ARRAY_SIZE(priv->overlays); ++k) {
@@ -1223,13 +1174,6 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 		}
 
 		sh_mobile_lcdc_display_off(ch);
-
-		/* Free the MERAM cache. */
-		if (ch->cache) {
-			sh_mobile_meram_cache_free(priv->meram_dev, ch->cache);
-			ch->cache = NULL;
-		}
-
 	}
 
 	/* stop the lcdc */
@@ -1851,11 +1795,6 @@ static int sh_mobile_lcdc_pan(struct fb_var_screeninfo *var,
 	base_addr_c = ch->dma_handle + ch->xres_virtual * ch->yres_virtual
 		    + c_offset;
 
-	if (ch->cache)
-		sh_mobile_meram_cache_update(priv->meram_dev, ch->cache,
-					     base_addr_y, base_addr_c,
-					     &base_addr_y, &base_addr_c);
-
 	ch->base_addr_y = base_addr_y;
 	ch->base_addr_c = base_addr_c;
 	ch->pan_y_offset = y_offset;
@@ -2718,7 +2657,7 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = &pdev->dev;
-	priv->meram_dev = pdata->meram_dev;
+
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
 		mutex_init(&priv->ch[i].open_lock);
 	platform_set_drvdata(pdev, priv);
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.h b/drivers/video/fbdev/sh_mobile_lcdcfb.h
index cc52c74..b8e47a8 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.h
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.h
@@ -61,7 +61,6 @@ struct sh_mobile_lcdc_chan {
 	unsigned long *reg_offs;
 	unsigned long ldmt1r_value;
 	unsigned long enabled; /* ME and SE in LDCNT2R */
-	void *cache;
 
 	struct mutex open_lock;		/* protects the use counter */
 	int use_count;
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index f706b0fe..84aa976 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -3,7 +3,6 @@
 #define __ASM_SH_MOBILE_LCDC_H__
 
 #include <linux/fb.h>
-#include <video/sh_mobile_meram.h>
 
 /* Register definitions */
 #define _LDDCKR			0x410
@@ -184,7 +183,6 @@ struct sh_mobile_lcdc_chan_cfg {
 	struct sh_mobile_lcdc_panel_cfg panel_cfg;
 	struct sh_mobile_lcdc_bl_info bl_info;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
-	const struct sh_mobile_meram_cfg *meram_cfg;
 
 	struct platform_device *tx_dev;	/* HDMI/DSI transmitter device */
 };
@@ -193,7 +191,6 @@ struct sh_mobile_lcdc_info {
 	int clock_source;
 	struct sh_mobile_lcdc_chan_cfg ch[2];
 	struct sh_mobile_lcdc_overlay_cfg overlays[4];
-	struct sh_mobile_meram_info *meram_dev;
 };
 
 #endif /* __ASM_SH_MOBILE_LCDC_H__ */
-- 
1.9.1

