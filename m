From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/2] fbdev: implement display panning for SH LCDC framebuffer
 driver
Date: Tue, 15 Sep 2009 14:00:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0909151357220.4640@axis700.grange>
References: <Pine.LNX.4.64.0909151354340.4640@axis700.grange>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0909151354340.4640@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, linux-fbdev-devel@lists.sourceforge.net

From: Phil Edworthy <phil.edworthy@renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |   76 +++++++++++++++++++++++++++++++++-----
 1 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 1cb5213..7f30cb3 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -31,6 +31,7 @@
 #define _LDSR 0x46c
 #define _LDCNT1R 0x470
 #define _LDCNT2R 0x474
+#define _LDRCNTR 0x478
 #define _LDDDSR 0x47c
 #define _LDDWD0R 0x800
 #define _LDDRDR 0x840
@@ -94,7 +95,11 @@ static unsigned long lcdc_offs_sublcd[NR_CH_REGS] = {
 #define DISPLAY_BEU	0x00000008
 #define LCDC_ENABLE	0x00000001
 #define LDINTR_FE	0x00000400
+#define LDINTR_VSE	0x00000200
+#define LDINTR_VEE	0x00000100
 #define LDINTR_FS	0x00000004
+#define LDINTR_VSS	0x00000002
+#define LDINTR_VES	0x00000001
 
 struct sh_mobile_lcdc_priv;
 struct sh_mobile_lcdc_chan {
@@ -110,6 +115,8 @@ struct sh_mobile_lcdc_chan {
 	struct fb_deferred_io defio;
 	struct scatterlist *sglist;
 	unsigned long frame_end;
+	unsigned long pan_offset;
+	unsigned long new_pan_offset;
 	wait_queue_head_t frame_end_wait;
 };
 
@@ -266,30 +273,46 @@ static irqreturn_t sh_mobile_lcdc_irq(int irq, void *data)
 	struct sh_mobile_lcdc_priv *priv = data;
 	struct sh_mobile_lcdc_chan *ch;
 	unsigned long tmp;
+	unsigned long ldintr;
 	int is_sub;
 	int k;
 
 	/* acknowledge interrupt */
-	tmp = lcdc_read(priv, _LDINTR);
-	tmp &= 0xffffff00; /* mask in high 24 bits */
-	tmp |= 0x000000ff ^ LDINTR_FS; /* status in low 8 */
+	ldintr = tmp = lcdc_read(priv, _LDINTR);
+	/*
+	 * disable further VSYNC End IRQs, preserve all other enabled IRQs,
+	 * write 0 to bits 0-6 to ack all triggered IRQs.
+	 */
+	tmp &= 0xffffff00 & ~LDINTR_VEE;
 	lcdc_write(priv, _LDINTR, tmp);
 
 	/* figure out if this interrupt is for main or sub lcd */
 	is_sub = (lcdc_read(priv, _LDSR) & (1 << 10)) ? 1 : 0;
 
-	/* wake up channel and disable clocks*/
+	/* wake up channel and disable clocks */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
 		ch = &priv->ch[k];
 
 		if (!ch->enabled)
 			continue;
 
-		if (is_sub == lcdc_chan_is_sublcd(ch)) {
-			ch->frame_end = 1;
-			wake_up(&ch->frame_end_wait);
+		/* Frame Start */
+		if (ldintr & LDINTR_FS) {
+			if (is_sub == lcdc_chan_is_sublcd(ch)) {
+				ch->frame_end = 1;
+				wake_up(&ch->frame_end_wait);
 
-			sh_mobile_lcdc_clk_off(priv);
+				sh_mobile_lcdc_clk_off(priv);
+			}
+		}
+
+		/* VSYNC End */
+		if (ldintr & LDINTR_VES) {
+			/* Set the source address for the next refresh */
+			lcdc_write_chan(ch, LDSA1R, ch->dma_handle +
+					ch->new_pan_offset);
+			lcdc_write(ch->lcdc, _LDRCNTR, 0);
+			ch->pan_offset = ch->new_pan_offset;
 		}
 	}
 
@@ -649,6 +672,9 @@ static struct fb_fix_screeninfo sh_mobile_lcdc_fix  = {
 	.type =		FB_TYPE_PACKED_PIXELS,
 	.visual =	FB_VISUAL_TRUECOLOR,
 	.accel =	FB_ACCEL_NONE,
+	.xpanstep =	0,
+	.ypanstep =	1,
+	.ywrapstep =	0,
 };
 
 static void sh_mobile_lcdc_fillrect(struct fb_info *info,
@@ -672,13 +698,38 @@ static void sh_mobile_lcdc_imageblit(struct fb_info *info,
 	sh_mobile_lcdc_deferred_io_touch(info);
 }
 
+static int sh_mobile_fb_pan_display(struct fb_var_screeninfo *var,
+				     struct fb_info *info)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+
+	if (info->var.xoffset == var->xoffset &&
+	    info->var.yoffset == var->yoffset)
+		return 0;	/* No change, do nothing */
+
+	ch->new_pan_offset = (var->yoffset * info->fix.line_length) +
+		(var->xoffset * (info->var.bits_per_pixel / 8));
+
+	if (ch->new_pan_offset != ch->pan_offset) {
+		unsigned long ldintr;
+		ldintr = lcdc_read(ch->lcdc, _LDINTR);
+		ldintr |= LDINTR_VEE;
+		lcdc_write(ch->lcdc, _LDINTR, ldintr);
+		sh_mobile_lcdc_deferred_io_touch(info);
+	}
+
+	return 0;
+}
+
 static struct fb_ops sh_mobile_lcdc_ops = {
+	.owner          = THIS_MODULE,
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
 	.fb_read        = fb_sys_read,
 	.fb_write       = fb_sys_write,
 	.fb_fillrect	= sh_mobile_lcdc_fillrect,
 	.fb_copyarea	= sh_mobile_lcdc_copyarea,
 	.fb_imageblit	= sh_mobile_lcdc_imageblit,
+	.fb_pan_display = sh_mobile_fb_pan_display,
 };
 
 static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp)
@@ -846,6 +897,8 @@ static int __init sh_mobile_lcdc_probe(struct platform_device *pdev)
 			goto err1;
 		}
 		init_waitqueue_head(&priv->ch[i].frame_end_wait);
+		priv->ch[j].pan_offset = 0;
+		priv->ch[j].new_pan_offset = 0;
 
 		switch (pdata->ch[i].chan) {
 		case LCDC_CHAN_MAINLCD:
@@ -888,7 +941,9 @@ static int __init sh_mobile_lcdc_probe(struct platform_device *pdev)
 		info = priv->ch[i].info;
 		info->fbops = &sh_mobile_lcdc_ops;
 		info->var.xres = info->var.xres_virtual = cfg->lcd_cfg.xres;
-		info->var.yres = info->var.yres_virtual = cfg->lcd_cfg.yres;
+		info->var.yres = cfg->lcd_cfg.yres;
+		/* Default Y virtual resolution is 2x panel size */
+		info->var.yres_virtual = info->var.yres * 2;
 		info->var.width = cfg->lcd_size_cfg.width;
 		info->var.height = cfg->lcd_size_cfg.height;
 		info->var.activate = FB_ACTIVATE_NOW;
@@ -898,7 +953,8 @@ static int __init sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 		info->fix = sh_mobile_lcdc_fix;
 		info->fix.line_length = cfg->lcd_cfg.xres * (cfg->bpp / 8);
-		info->fix.smem_len = info->fix.line_length * cfg->lcd_cfg.yres;
+		info->fix.smem_len = info->fix.line_length *
+			info->var.yres_virtual;
 
 		buf = dma_alloc_coherent(&pdev->dev, info->fix.smem_len,
 					 &priv->ch[i].dma_handle, GFP_KERNEL);
-- 
1.6.2.4

