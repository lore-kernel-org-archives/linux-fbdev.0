From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 15 Oct 2010 07:53:52 +0000
Subject: [PATCH 1/4] fbdev: sh_mobile_lcdc: make platform videomode table
Message-Id: <Pine.LNX.4.64.1010150950200.3945@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add a default 720p mode to the sh_mobile_lcdc driver to be used, when no
videomode is specified in the platform data. This can be used, e.g., with HDMI.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c   |    3 +-
 drivers/video/sh_mobile_lcdcfb.c |   73 +++++++++++++++++++++++++------------
 2 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index e782983..3b2e893 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1129,7 +1129,8 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		goto egetclk;
 	}
 
-	rate = sh_hdmi_clk_configure(hdmi, pdata->lcd_chan->lcd_cfg[0].pixclock);
+	/* Some arbitrary relaxed pixclock just to get things started */
+	rate = sh_hdmi_clk_configure(hdmi, 37037);
 	if (rate < 0) {
 		ret = rate;
 		goto erate;
diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index d6e9ff5..d931382 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -54,6 +54,9 @@ static int lcdc_shared_regs[] = {
 };
 #define NR_SHARED_REGS ARRAY_SIZE(lcdc_shared_regs)
 
+#define DEFAULT_XRES 1280
+#define DEFAULT_YRES 1024
+
 static unsigned long lcdc_offs_mainlcd[NR_CH_REGS] = {
 	[LDDCKPAT1R] = 0x400,
 	[LDDCKPAT2R] = 0x404,
@@ -107,6 +110,23 @@ static unsigned long lcdc_offs_sublcd[NR_CH_REGS] = {
 #define LDRCNTR_MRC	0x00000001
 #define LDSR_MRS	0x00000100
 
+static const struct fb_videomode default_720p = {
+	.name = "HDMI 720p",
+	.xres = 1280,
+	.yres = 720,
+
+	.left_margin = 200,
+	.right_margin = 88,
+	.hsync_len = 48,
+
+	.upper_margin = 20,
+	.lower_margin = 5,
+	.vsync_len = 5,
+
+	.pixclock = 13468,
+	.sync = FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
+};
+
 struct sh_mobile_lcdc_priv {
 	void __iomem *base;
 	int irq;
@@ -1045,7 +1065,6 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 	struct fb_info *info = event->info;
 	struct sh_mobile_lcdc_chan *ch = info->par;
 	struct sh_mobile_lcdc_board_cfg	*board_cfg = &ch->cfg.board_cfg;
-	struct fb_var_screeninfo *var;
 	int ret;
 
 	if (&ch->lcdc->notifier != nb)
@@ -1064,8 +1083,6 @@ static int sh_mobile_lcdc_notify(struct notifier_block *nb,
 		sh_mobile_lcdc_stop(ch->lcdc);
 		break;
 	case FB_EVENT_RESUME:
-		var = &info->var;
-
 		mutex_lock(&ch->open_lock);
 		sh_mobile_fb_reconfig(info);
 		mutex_unlock(&ch->open_lock);
@@ -1091,7 +1108,6 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 	struct fb_info *info;
 	struct sh_mobile_lcdc_priv *priv;
 	struct sh_mobile_lcdc_info *pdata = pdev->dev.platform_data;
-	struct sh_mobile_lcdc_chan_cfg *cfg;
 	struct resource *res;
 	int error;
 	void *buf;
@@ -1177,11 +1193,11 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		struct fb_var_screeninfo *var;
 		const struct fb_videomode *lcd_cfg, *max_cfg = NULL;
 		struct sh_mobile_lcdc_chan *ch = priv->ch + i;
+		struct sh_mobile_lcdc_chan_cfg *cfg = &ch->cfg;
+		const struct fb_videomode *mode = cfg->lcd_cfg;
 		unsigned long max_size = 0;
 		int k;
 
-		cfg = &ch->cfg;
-
 		ch->info = framebuffer_alloc(0, &pdev->dev);
 		if (!ch->info) {
 			dev_err(&pdev->dev, "unable to allocate fb_info\n");
@@ -1192,20 +1208,12 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		info = ch->info;
 		var = &info->var;
 		info->fbops = &sh_mobile_lcdc_ops;
+		info->par = ch;
 
 		mutex_init(&ch->open_lock);
 
-		fb_videomode_to_var(var, &cfg->lcd_cfg[0]);
-		/* Default Y virtual resolution is 2x panel size */
-		var->yres_virtual = var->yres * 2;
-		var->activate = FB_ACTIVATE_NOW;
-
-		error = sh_mobile_lcdc_set_bpp(var, cfg->bpp);
-		if (error)
-			break;
-
-		for (k = 0, lcd_cfg = cfg->lcd_cfg;
-		     k < cfg->num_cfg;
+		for (k = 0, lcd_cfg = mode;
+		     k < cfg->num_cfg && lcd_cfg;
 		     k++, lcd_cfg++) {
 			unsigned long size = lcd_cfg->yres * lcd_cfg->xres;
 
@@ -1215,13 +1223,27 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			}
 		}
 
-		dev_dbg(&pdev->dev, "Found largest videomode %ux%u\n",
-			max_cfg->xres, max_cfg->yres);
+		if (!mode)
+			max_size = DEFAULT_XRES * DEFAULT_YRES;
+		else if (max_cfg)
+			dev_dbg(&pdev->dev, "Found largest videomode %ux%u\n",
+				max_cfg->xres, max_cfg->yres);
 
 		info->fix = sh_mobile_lcdc_fix;
-		info->fix.line_length = cfg->lcd_cfg[0].xres * (cfg->bpp / 8);
 		info->fix.smem_len = max_size * (cfg->bpp / 8) * 2;
 
+		if (!mode)
+			mode = &default_720p;
+
+		fb_videomode_to_var(var, mode);
+		/* Default Y virtual resolution is 2x panel size */
+		var->yres_virtual = var->yres * 2;
+		var->activate = FB_ACTIVATE_NOW;
+
+		error = sh_mobile_lcdc_set_bpp(var, cfg->bpp);
+		if (error)
+			break;
+
 		buf = dma_alloc_coherent(&pdev->dev, info->fix.smem_len,
 					 &ch->dma_handle, GFP_KERNEL);
 		if (!buf) {
@@ -1242,9 +1264,9 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 		}
 
 		info->fix.smem_start = ch->dma_handle;
+		info->fix.line_length = var->xres * (cfg->bpp / 8);
 		info->screen_base = buf;
 		info->device = &pdev->dev;
-		info->par = ch;
 		ch->display_var = *var;
 	}
 
@@ -1259,6 +1281,10 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 
 	for (i = 0; i < j; i++) {
 		struct sh_mobile_lcdc_chan *ch = priv->ch + i;
+		const struct fb_videomode *mode = ch->cfg.lcd_cfg;
+
+		if (!mode)
+			mode = &default_720p;
 
 		info = ch->info;
 
@@ -1271,7 +1297,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			}
 		}
 
-		fb_videomode_to_modelist(ch->cfg.lcd_cfg, ch->cfg.num_cfg, &info->modelist);
+		fb_videomode_to_modelist(mode, ch->cfg.num_cfg, &info->modelist);
 		error = register_framebuffer(info);
 		if (error < 0)
 			goto err1;
@@ -1281,8 +1307,7 @@ static int __devinit sh_mobile_lcdc_probe(struct platform_device *pdev)
 			 pdev->name,
 			 (ch->cfg.chan = LCDC_CHAN_MAINLCD) ?
 			 "mainlcd" : "sublcd",
-			 (int) ch->cfg.lcd_cfg[0].xres,
-			 (int) ch->cfg.lcd_cfg[0].yres,
+			 info->var.xres, info->var.yres,
 			 ch->cfg.bpp);
 
 		/* deferred io mode: disable clock to save power */
-- 
1.7.1

