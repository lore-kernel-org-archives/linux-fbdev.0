From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 04/05] video: sh_mobile_lcdcfb deferred io support
Date: Fri, 19 Dec 2008 15:34:41 +0900
Message-ID: <20081219063441.2703.27320.sendpatchset@rx1.opensource.se>
References: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, adaplas@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds sh_mobile_lcdcfb deferred io support for SYS panels.

The LCDC hardware block managed by the sh_mobile_lcdcfb driver supports
RGB or SYS panel configurations. SYS panels come with an external display
controller that is resposible for refreshing the actual LCD panel. RGB
panels are controlled directly by the LCDC and they need to be refreshed
by the LCDC hardware.

In the case of SYS panels we can save some power by configuring the LCDC
hardware block in one-shot mode. In this one-shot mode panel refresh is
managed by software. This works well together with deferred io since it
allows us to stop clocks for most of the time and only enable clocks when
we actually want to trigger an update. When there is no fbdev activity
the clocks are kept stopped which allows us to deep sleep.

The refresh rate in deferred io mode is set using platform data. The same
platform data can also be used to disable deferred io mode.

As with other deferred io frame buffers user space code should use fsync()
on the frame buffer device to trigger an update.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/Kconfig            |    1 
 drivers/video/sh_mobile_lcdcfb.c |  170 +++++++++++++++++++++++++++++++++-----
 include/video/sh_mobile_lcdc.h   |    1 
 3 files changed, 150 insertions(+), 22 deletions(-)

--- 0001/drivers/video/Kconfig
+++ work/drivers/video/Kconfig	2008-12-19 14:17:44.000000000 +0900
@@ -1893,6 +1893,7 @@ config FB_SH_MOBILE_LCDC
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
 	select FB_SYS_FOPS
+	select FB_DEFERRED_IO
 	---help---
 	  Frame buffer driver for the on-chip SH-Mobile LCD controller.
 
--- 0001/drivers/video/sh_mobile_lcdcfb.c
+++ work/drivers/video/sh_mobile_lcdcfb.c	2008-12-19 14:17:59.000000000 +0900
@@ -16,7 +16,9 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
 #include <video/sh_mobile_lcdc.h>
+#include <asm/atomic.h>
 
 #define PALETTE_NR 16
 
@@ -30,11 +32,14 @@ struct sh_mobile_lcdc_chan {
 	u32 pseudo_palette[PALETTE_NR];
 	struct fb_info info;
 	dma_addr_t dma_handle;
+	struct fb_deferred_io defio;
 };
 
 struct sh_mobile_lcdc_priv {
 	void __iomem *base;
+	int irq;
 #ifdef CONFIG_HAVE_CLK
+	atomic_t clk_usecnt;
 	struct clk *dot_clk;
 	struct clk *clk;
 #endif
@@ -57,7 +62,7 @@ struct sh_mobile_lcdc_priv {
 
 /* per-channel registers */
 enum { LDDCKPAT1R, LDDCKPAT2R, LDMT1R, LDMT2R, LDMT3R, LDDFR, LDSM1R,
-       LDSA1R, LDMLSR, LDHCNR, LDHSYNR, LDVLNR, LDVSYNR, LDPMR };
+       LDSM2R, LDSA1R, LDMLSR, LDHCNR, LDHSYNR, LDVLNR, LDVSYNR, LDPMR };
 
 static unsigned long lcdc_offs_mainlcd[] = {
 	[LDDCKPAT1R] = 0x400,
@@ -67,6 +72,7 @@ static unsigned long lcdc_offs_mainlcd[]
 	[LDMT3R] = 0x420,
 	[LDDFR] = 0x424,
 	[LDSM1R] = 0x428,
+	[LDSM2R] = 0x42c,
 	[LDSA1R] = 0x430,
 	[LDMLSR] = 0x438,
 	[LDHCNR] = 0x448,
@@ -84,6 +90,7 @@ static unsigned long lcdc_offs_sublcd[] 
 	[LDMT3R] = 0x608,
 	[LDDFR] = 0x60c,
 	[LDSM1R] = 0x610,
+	[LDSM2R] = 0x614,
 	[LDSA1R] = 0x618,
 	[LDMLSR] = 0x620,
 	[LDHCNR] = 0x624,
@@ -97,6 +104,8 @@ static unsigned long lcdc_offs_sublcd[] 
 #define LCDC_RESET	0x00000100
 #define DISPLAY_BEU	0x00000008
 #define LCDC_ENABLE	0x00000001
+#define LDINTR_FE	0x00000400
+#define LDINTR_FS	0x00000004
 
 static void lcdc_write_chan(struct sh_mobile_lcdc_chan *chan,
 			    int reg_nr, unsigned long data)
@@ -171,6 +180,65 @@ struct sh_mobile_lcdc_sys_bus_ops sh_mob
 	lcdc_sys_read_data,
 };
 
+#ifdef CONFIG_HAVE_CLK
+static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
+{
+	if (atomic_inc_and_test(&priv->clk_usecnt)) {
+		clk_enable(priv->clk);
+		if (priv->dot_clk)
+			clk_enable(priv->dot_clk);
+	}
+}
+
+static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
+{
+	if (atomic_sub_return(1, &priv->clk_usecnt) == -1) {
+		if (priv->dot_clk)
+			clk_disable(priv->dot_clk);
+		clk_disable(priv->clk);
+	}
+}
+#else
+static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv) {}
+static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv) {}
+#endif
+
+static void sh_mobile_lcdc_deferred_io(struct fb_info *info,
+				       struct list_head *pagelist)
+{
+	struct sh_mobile_lcdc_chan *ch = info->par;
+
+	/* enable clocks before accessing hardware */
+	sh_mobile_lcdc_clk_on(ch->lcdc);
+
+	/* trigger panel update */
+	lcdc_write_chan(ch, LDSM2R, 1);
+}
+
+static void sh_mobile_lcdc_deferred_io_touch(struct fb_info *info)
+{
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
+	if (fbdefio)
+		schedule_delayed_work(&info->deferred_work, fbdefio->delay);
+}
+
+static irqreturn_t sh_mobile_lcdc_irq(int irq, void *data)
+{
+	struct sh_mobile_lcdc_priv *priv = data;
+	unsigned long tmp;
+
+	/* acknowledge interrupt */
+	tmp = lcdc_read(priv, _LDINTR);
+	tmp &= 0xffffff00; /* mask in high 24 bits */
+	tmp |= 0x000000ff ^ LDINTR_FS; /* status in low 8 */
+	lcdc_write(priv, _LDINTR, tmp);
+
+	/* disable clocks */
+	sh_mobile_lcdc_clk_off(priv);
+	return IRQ_HANDLED;
+}
+
 static void sh_mobile_lcdc_start_stop(struct sh_mobile_lcdc_priv *priv,
 				      int start)
 {
@@ -208,11 +276,11 @@ static int sh_mobile_lcdc_start(struct s
 	int k, m;
 	int ret = 0;
 
-#ifdef CONFIG_HAVE_CLK
-	clk_enable(priv->clk);
-	if (priv->dot_clk)
-		clk_enable(priv->dot_clk);
-#endif
+	/* enable clocks before accessing the hardware */
+	for (k = 0; k < ARRAY_SIZE(priv->ch); k++)
+		if (priv->ch[k].enabled)
+			sh_mobile_lcdc_clk_on(priv);
+
 	/* reset */
 	lcdc_write(priv, _LDCNT2R, lcdc_read(priv, _LDCNT2R) | LCDC_RESET);
 	lcdc_wait_bit(priv, _LDCNT2R, LCDC_RESET, 0);
@@ -255,7 +323,7 @@ static int sh_mobile_lcdc_start(struct s
 	lcdc_write(priv, _LDDCKSTPR, 0);
 	lcdc_wait_bit(priv, _LDDCKSTPR, ~0, 0);
 
-	/* interrupts are disabled */
+	/* interrupts are disabled to begin with */
 	lcdc_write(priv, _LDINTR, 0);
 
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
@@ -316,9 +384,6 @@ static int sh_mobile_lcdc_start(struct s
 			return ret;
 	}
 
-	/* --- display_lcdc_data() --- */
-	lcdc_write(priv, _LDINTR, 0x00000f00);
-
 	/* word and long word swap */
 	lcdc_write(priv, _LDDDSR, lcdc_read(priv, _LDDDSR) | 6);
 
@@ -340,8 +405,24 @@ static int sh_mobile_lcdc_start(struct s
 		/* set line size */
 		lcdc_write_chan(ch, LDMLSR, ch->info.fix.line_length);
 
-		/* continuous read mode */
-		lcdc_write_chan(ch, LDSM1R, 0);
+		/* setup deferred io if SYS bus */
+		tmp = ch->cfg.sys_bus_cfg.deferred_io_msec;
+		if (ch->ldmt1r_value & (1 << 12) && tmp) {
+			ch->defio.deferred_io = sh_mobile_lcdc_deferred_io;
+			ch->defio.delay = msecs_to_jiffies(tmp);
+			ch->info.fbdefio = &ch->defio;
+			fb_deferred_io_init(&ch->info);
+
+			/* one-shot mode */
+			lcdc_write_chan(ch, LDSM1R, 1);
+
+			/* enable "Frame End Interrupt Enable" bit */
+			lcdc_write(priv, _LDINTR, LDINTR_FE);
+
+		} else {
+			/* continuous read mode */
+			lcdc_write_chan(ch, LDSM1R, 0);
+		}
 	}
 
 	/* display output */
@@ -365,6 +446,7 @@ static void sh_mobile_lcdc_stop(struct s
 {
 	struct sh_mobile_lcdc_chan *ch;
 	struct sh_mobile_lcdc_board_cfg	*board_cfg;
+	unsigned long tmp;
 	int k;
 
 	/* tell the board code to disable the panel */
@@ -373,16 +455,22 @@ static void sh_mobile_lcdc_stop(struct s
 		board_cfg = &ch->cfg.board_cfg;
 		if (board_cfg->display_off)
 			board_cfg->display_off(board_cfg->board_data);
+
+		/* cleanup deferred io if SYS bus */
+		tmp = ch->cfg.sys_bus_cfg.deferred_io_msec;
+		if (ch->ldmt1r_value & (1 << 12) && tmp) {
+			fb_deferred_io_cleanup(&ch->info);
+			ch->info.fbdefio = NULL;
+		}
 	}
 
 	/* stop the lcdc */
 	sh_mobile_lcdc_start_stop(priv, 0);
 
-#ifdef CONFIG_HAVE_CLK
-	if (priv->dot_clk)
-		clk_disable(priv->dot_clk);
-	clk_disable(priv->clk);
-#endif
+	/* stop clocks */
+	for (k = 0; k < ARRAY_SIZE(priv->ch); k++)
+		if (priv->ch[k].enabled)
+			sh_mobile_lcdc_clk_off(priv);
 }
 
 static int sh_mobile_lcdc_check_interface(struct sh_mobile_lcdc_chan *ch)
@@ -446,6 +534,7 @@ static int sh_mobile_lcdc_setup_clocks(s
 	priv->lddckr = icksel << 16;
 
 #ifdef CONFIG_HAVE_CLK
+	atomic_set(&priv->clk_usecnt, -1);
 	snprintf(clk_name, sizeof(clk_name), "lcdc%d", pdev->id);
 	priv->clk = clk_get(&pdev->dev, clk_name);
 	if (IS_ERR(priv->clk)) {
@@ -497,13 +586,34 @@ static struct fb_fix_screeninfo sh_mobil
 	.accel =	FB_ACCEL_NONE,
 };
 
+static void sh_mobile_lcdc_fillrect(struct fb_info *info,
+				    const struct fb_fillrect *rect)
+{
+	sys_fillrect(info, rect);
+	sh_mobile_lcdc_deferred_io_touch(info);
+}
+
+static void sh_mobile_lcdc_copyarea(struct fb_info *info,
+				    const struct fb_copyarea *area)
+{
+	sys_copyarea(info, area);
+	sh_mobile_lcdc_deferred_io_touch(info);
+}
+
+static void sh_mobile_lcdc_imageblit(struct fb_info *info,
+				     const struct fb_image *image)
+{
+	sys_imageblit(info, image);
+	sh_mobile_lcdc_deferred_io_touch(info);
+}
+
 static struct fb_ops sh_mobile_lcdc_ops = {
 	.fb_setcolreg	= sh_mobile_lcdc_setcolreg,
 	.fb_read        = fb_sys_read,
 	.fb_write       = fb_sys_write,
-	.fb_fillrect	= sys_fillrect,
-	.fb_copyarea	= sys_copyarea,
-	.fb_imageblit	= sys_imageblit,
+	.fb_fillrect	= sh_mobile_lcdc_fillrect,
+	.fb_copyarea	= sh_mobile_lcdc_copyarea,
+	.fb_imageblit	= sh_mobile_lcdc_imageblit,
 };
 
 static int sh_mobile_lcdc_set_bpp(struct fb_var_screeninfo *var, int bpp)
@@ -564,8 +674,9 @@ static int __init sh_mobile_lcdc_probe(s
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "cannot find IO resource\n");
+	i = platform_get_irq(pdev, 0);
+	if (!res || i < 0) {
+		dev_err(&pdev->dev, "cannot get platform resources\n");
 		error = -ENOENT;
 		goto err0;
 	}
@@ -577,6 +688,14 @@ static int __init sh_mobile_lcdc_probe(s
 		goto err0;
 	}
 
+	error = request_irq(i, sh_mobile_lcdc_irq, IRQF_DISABLED,
+			    pdev->dev.bus_id, priv);
+	if (error) {
+		dev_err(&pdev->dev, "unable to request irq\n");
+		goto err1;
+	}
+
+	priv->irq = i;
 	platform_set_drvdata(pdev, priv);
 	pdata = pdev->dev.platform_data;
 
@@ -660,6 +779,7 @@ static int __init sh_mobile_lcdc_probe(s
 		info->fix.smem_start = priv->ch[i].dma_handle;
 		info->screen_base = buf;
 		info->device = &pdev->dev;
+		info->par = &priv->ch[i];
 	}
 
 	if (error)
@@ -687,6 +807,10 @@ static int __init sh_mobile_lcdc_probe(s
 			 (int) priv->ch[i].cfg.lcd_cfg.xres,
 			 (int) priv->ch[i].cfg.lcd_cfg.yres,
 			 priv->ch[i].cfg.bpp);
+
+		/* deferred io mode: disable clock to save power */
+		if (info->fbdefio)
+			sh_mobile_lcdc_clk_off(priv);
 	}
 
 	return 0;
@@ -728,6 +852,8 @@ static int sh_mobile_lcdc_remove(struct 
 	if (priv->base)
 		iounmap(priv->base);
 
+	if (priv->irq)
+		free_irq(priv->irq, priv);
 	kfree(priv);
 	return 0;
 }
--- 0001/include/video/sh_mobile_lcdc.h
+++ work/include/video/sh_mobile_lcdc.h	2008-12-19 14:17:44.000000000 +0900
@@ -37,6 +37,7 @@ enum { LCDC_CLK_BUS, LCDC_CLK_PERIPHERAL
 struct sh_mobile_lcdc_sys_bus_cfg {
 	unsigned long ldmt2r;
 	unsigned long ldmt3r;
+	unsigned long deferred_io_msec;
 };
 
 struct sh_mobile_lcdc_sys_bus_ops {
