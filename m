From: "Phil Edworthy" <Phil.Edworthy@renesas.com>
Date: Thu, 11 Feb 2010 10:24:25 +0000
Subject: [PATCH 02/02] sh: Fix panning
Message-Id: <AB12B32E73474741A2C5361C433A44DE01783685@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Fixed SH-Mobile panning. Previously the address of the frame to be displayed
was updated in the VSync end interrupt. This meant there was a minimum of 1
frame bewteen calling FBIOPAN_DISPLAY ioctl and the pan occuring. This meant
that apps were not able to use the FBIO_WAITFORVSYNC ioctl to wait for the
pan to complete. This patch moves the write to LDSA1R mirror reg into the
pan
ioctl.
Tested on MS7724 board against 2.6.33-rc7

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -128,7 +128,6 @@ struct sh_mobile_lcdc_chan {
 	struct scatterlist *sglist;
 	unsigned long frame_end;
 	unsigned long pan_offset;
-	unsigned long new_pan_offset;
 	wait_queue_head_t frame_end_wait;
 	struct completion vsync_completion;
 };
@@ -373,21 +372,6 @@ static irqreturn_t sh_mobile_lcdc_irq(in
 		}
 
 		/* VSYNC End */
-		if ((ldintr & LDINTR_VES) &&
-		    (ch->pan_offset != ch->new_pan_offset)) {
-			unsigned long ldrcntr = lcdc_read(priv, _LDRCNTR);
-			/* Set the source address for the next refresh */
-			lcdc_write_chan_mirror(ch, LDSA1R, ch->dma_handle +
-					       ch->new_pan_offset);
-			if (lcdc_chan_is_sublcd(ch))
-				lcdc_write(ch->lcdc, _LDRCNTR,
-					   ldrcntr ^ LDRCNTR_SRS);
-			else
-				lcdc_write(ch->lcdc, _LDRCNTR,
-					   ldrcntr ^ LDRCNTR_MRS);
-			ch->pan_offset = ch->new_pan_offset;
-		}
-
 		if (ldintr & LDINTR_VES)
 			complete(&ch->vsync_completion);
 	}
@@ -778,21 +762,28 @@ static int sh_mobile_fb_pan_display(stru
 				     struct fb_info *info)
 {
 	struct sh_mobile_lcdc_chan *ch = info->par;
+	struct sh_mobile_lcdc_priv *priv = ch->lcdc;
+	unsigned long ldrcntr;
+	unsigned long new_pan_offset;
+
+	new_pan_offset = (var->yoffset * info->fix.line_length) +
+		(var->xoffset * (info->var.bits_per_pixel / 8));
 
-	if (info->var.xoffset = var->xoffset &&
-	    info->var.yoffset = var->yoffset)
+	if (new_pan_offset = ch->pan_offset)
 		return 0;	/* No change, do nothing */
 
-	ch->new_pan_offset = (var->yoffset * info->fix.line_length) +
-		(var->xoffset * (info->var.bits_per_pixel / 8));
+	ldrcntr = lcdc_read(priv, _LDRCNTR);
 
-	if (ch->new_pan_offset != ch->pan_offset) {
-		unsigned long ldintr;
-		ldintr = lcdc_read(ch->lcdc, _LDINTR);
-		ldintr |= LDINTR_VEE;
-		lcdc_write(ch->lcdc, _LDINTR, ldintr);
-		sh_mobile_lcdc_deferred_io_touch(info);
-	}
+	/* Set the source address for the next refresh */
+	lcdc_write_chan_mirror(ch, LDSA1R, ch->dma_handle + new_pan_offset);
+	if (lcdc_chan_is_sublcd(ch))
+		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_SRS);
+	else
+		lcdc_write(ch->lcdc, _LDRCNTR, ldrcntr ^ LDRCNTR_MRS);
+
+	ch->pan_offset = new_pan_offset;
+
+	sh_mobile_lcdc_deferred_io_touch(info);
 
 	return 0;
 }
@@ -1015,7 +1006,6 @@ static int __init sh_mobile_lcdc_probe(s
 		init_waitqueue_head(&priv->ch[i].frame_end_wait);
 		init_completion(&priv->ch[i].vsync_completion);
 		priv->ch[j].pan_offset = 0;
-		priv->ch[j].new_pan_offset = 0;
 
 		switch (pdata->ch[i].chan) {
 		case LCDC_CHAN_MAINLCD:
