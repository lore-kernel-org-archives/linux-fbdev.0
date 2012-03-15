From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 15 Mar 2012 17:43:52 +0000
Subject: [RFC/PATCH 4/6] fbdev: sh_mobile_lcdc: Fix pan offset computation in YUV mode
Message-Id: <1331833434-11934-5-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The chroma plane offset in memory is equal to the luma plane maximum
size. Fix offset computations.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   57 ++++++++++++++++++--------------------
 drivers/video/sh_mobile_lcdcfb.h |    5 ++-
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index cf80194..2009432 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -846,7 +846,8 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			continue;
 
 		ch->base_addr_y = ch->dma_handle;
-		ch->base_addr_c = ch->base_addr_y + ch->xres * ch->yres_virtual;
+		ch->base_addr_c = ch->dma_handle
+				+ ch->xres_virtual * ch->yres_virtual;
 
 		/* Enable MERAM if possible. */
 		if (mdev = NULL || ch->cfg->meram_cfg = NULL)
@@ -1035,35 +1036,30 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	struct sh_mobile_lcdc_priv *priv = ch->lcdc;
 	unsigned long ldrcntr;
-	unsigned long new_pan_offset;
 	unsigned long base_addr_y, base_addr_c = 0;
+	unsigned long y_offset;
 	unsigned long c_offset;
 
-	if (!ch->format->yuv)
-		new_pan_offset = var->yoffset * ch->pitch
-			       + var->xoffset * (ch->format->bpp / 8);
-	else
-		new_pan_offset = var->yoffset * ch->pitch + var->xoffset;
-
-	if (new_pan_offset = ch->pan_offset)
-		return 0;	/* No change, do nothing */
+	if (!ch->format->yuv) {
+		y_offset = (var->yoffset * ch->xres_virtual + var->xoffset)
+			 * ch->format->bpp / 8;
+		c_offset = 0;
+	} else {
+		y_offset = var->yoffset * ch->xres_virtual + var->xoffset;
+		c_offset = (var->yoffset * ch->xres_virtual + var->xoffset)
+			 * (ch->format->bpp - 8) / 8;
+	}
 
-	ldrcntr = lcdc_read(priv, _LDRCNTR);
+	/* If the Y offset hasn't changed, the C offset hasn't either. There's
+	 * nothing to do in that case.
+	 */
+	if (y_offset = ch->pan_y_offset)
+		return 0;
 
 	/* Set the source address for the next refresh */
-	base_addr_y = ch->dma_handle + new_pan_offset;
-	if (ch->format->yuv) {
-		/* Set y offset */
-		c_offset = var->yoffset * ch->pitch
-			 * (ch->format->bpp - 8) / 8;
-		base_addr_c = ch->dma_handle + ch->xres * ch->yres_virtual
-			    + c_offset;
-		/* Set x offset */
-		if (ch->format->fourcc = V4L2_PIX_FMT_NV24)
-			base_addr_c += 2 * var->xoffset;
-		else
-			base_addr_c += var->xoffset;
-	}
+	base_addr_y = ch->dma_handle + y_offset;
+	base_addr_c = ch->dma_handle + ch->xres_virtual * ch->yres_virtual
+		    + c_offset;
 
 	if (ch->cache)
 		sh_mobile_meram_cache_update(priv->meram_dev, ch->cache,
@@ -1072,17 +1068,19 @@ static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
 
 	ch->base_addr_y = base_addr_y;
 	ch->base_addr_c = base_addr_c;
+	ch->pan_y_offset = y_offset;
+	ch->pan_c_offset = c_offset;
 
 	lcdc_write_chan_mirror(ch, LDSA1R, base_addr_y);
 	if (ch->format->yuv)
 		lcdc_write_chan_mirror(ch, LDSA2R, base_addr_c);
 
+	ldrcntr = lcdc_read(priv, _LDRCNTR);
 	if (lcdc_chan_is_sublcd(ch))
 		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_SRS);
 	else
 		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_MRS);
 
-	ch->pan_offset = new_pan_offset;
 
 	sh_mobile_lcdc_deferred_io_touch(info);
 
@@ -1319,9 +1317,9 @@ static int sh_mobile_set_par(struct fb_info *info)
 	ch->yres_virtual = info->var.yres_virtual;
 
 	if (ch->format->yuv)
-		ch->pitch = info->var.xres;
+		ch->pitch = info->var.xres_virtual;
 	else
-		ch->pitch = info->var.xres * ch->format->bpp / 8;
+		ch->pitch = info->var.xres_virtual * ch->format->bpp / 8;
 
 	ret = sh_mobile_lcdc_start(ch->lcdc);
 	if (ret < 0)
@@ -1853,10 +1851,10 @@ sh_mobile_lcdc_channel_init(struct sh_mobile_lcdc_priv *priv,
 
 	if (!format->yuv) {
 		ch->colorspace = V4L2_COLORSPACE_SRGB;
-		ch->pitch = ch->xres * format->bpp / 8;
+		ch->pitch = ch->xres_virtual * format->bpp / 8;
 	} else {
 		ch->colorspace = V4L2_COLORSPACE_REC709;
-		ch->pitch = ch->xres;
+		ch->pitch = ch->xres_virtual;
 	}
 
 	ch->display.width = cfg->panel_cfg.width;
@@ -1942,7 +1940,6 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		}
 		init_waitqueue_head(&ch->frame_end_wait);
 		init_completion(&ch->vsync_completion);
-		ch->pan_offset = 0;
 
 		/* probe the backlight is there is one defined */
 		if (ch->cfg->bl_info.max_brightness)
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index 698fb20..5320ad4 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -47,6 +47,8 @@ struct sh_mobile_lcdc_entity {
 /*
  * struct sh_mobile_lcdc_chan - LCDC display channel
  *
+ * @pan_y_offset: Panning linear offset in bytes (luma component)
+ * @pan_c_offset: Panning linear offset in bytes (chroma component)
  * @base_addr_y: Frame buffer viewport base address (luma component)
  * @base_addr_c: Frame buffer viewport base address (chroma component)
  * @pitch: Frame buffer line pitch
@@ -68,7 +70,8 @@ struct sh_mobile_lcdc_chan {
 	unsigned long fb_size;
 
 	dma_addr_t dma_handle;
-	unsigned long pan_offset;
+	unsigned long pan_y_offset;
+	unsigned long pan_c_offset;
 
 	unsigned long frame_end;
 	wait_queue_head_t frame_end_wait;
-- 
1.7.3.4

