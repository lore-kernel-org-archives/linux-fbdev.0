From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Sat, 04 Feb 2012 09:41:28 +0000
Subject: [PATCH 10/13] FB: sa1100: use inf members directly
Message-Id: <E1Rtc7c-0000ay-Hn@rmk-PC.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20120204093744.GQ889@n2100.arm.linux.org.uk>
In-Reply-To: <20120204093744.GQ889@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Now that the LCD information is available while the driver is loaded,
we don't need to cache that information into our driver private data
structure.  Get rid of it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/video/sa1100fb.c |   31 ++++++++++++-------------------
 drivers/video/sa1100fb.h |   10 ----------
 2 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index f6e27f4..d1d97ca 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -298,7 +298,7 @@ sa1100fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 	 * is what you poke into the framebuffer to produce the
 	 * colour you requested.
 	 */
-	if (fbi->cmap_inverse) {
+	if (fbi->inf->cmap_inverse) {
 		red   = 0xffff - red;
 		green = 0xffff - green;
 		blue  = 0xffff - blue;
@@ -372,10 +372,10 @@ sa1100fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		var->xres = MIN_XRES;
 	if (var->yres < MIN_YRES)
 		var->yres = MIN_YRES;
-	if (var->xres > fbi->max_xres)
-		var->xres = fbi->max_xres;
-	if (var->yres > fbi->max_yres)
-		var->yres = fbi->max_yres;
+	if (var->xres > fbi->inf->xres)
+		var->xres = fbi->inf->xres;
+	if (var->yres > fbi->inf->yres)
+		var->yres = fbi->inf->yres;
 	var->xres_virtual = max(var->xres_virtual, var->xres);
 	var->yres_virtual = max(var->yres_virtual, var->yres);
 
@@ -440,7 +440,7 @@ static int sa1100fb_set_par(struct fb_info *info)
 
 	if (var->bits_per_pixel = 16)
 		fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
-	else if (!fbi->cmap_static)
+	else if (!fbi->inf->cmap_static)
 		fbi->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
 	else {
 		/*
@@ -481,7 +481,7 @@ sa1100fb_set_cmap(struct fb_cmap *cmap, int kspc, int con,
 	/*
 	 * Make sure the user isn't doing something stupid.
 	 */
-	if (!kspc && (fbi->fb.var.bits_per_pixel = 16 || fbi->cmap_static))
+	if (!kspc && (fbi->fb.var.bits_per_pixel = 16 || fbi->inf->cmap_static))
 		return -EINVAL;
 
 	return gen_set_cmap(cmap, kspc, con, info);
@@ -652,7 +652,7 @@ static int sa1100fb_activate_var(struct fb_var_screeninfo *var, struct sa1100fb_
 			fbi->fb.fix.id, var->lower_margin);
 #endif
 
-	new_regs.lccr0 = fbi->lccr0 |
+	new_regs.lccr0 = fbi->inf->lccr0 |
 		LCCR0_LEN | LCCR0_LDM | LCCR0_BAM |
 		LCCR0_ERM | LCCR0_LtlEnd | LCCR0_DMADel(0);
 
@@ -667,7 +667,7 @@ static int sa1100fb_activate_var(struct fb_var_screeninfo *var, struct sa1100fb_
 	 * the YRES parameter.
 	 */
 	yres = var->yres;
-	if (fbi->lccr0 & LCCR0_Dual)
+	if (fbi->inf->lccr0 & LCCR0_Dual)
 		yres /= 2;
 
 	new_regs.lccr2 @@ -677,7 +677,7 @@ static int sa1100fb_activate_var(struct fb_var_screeninfo *var, struct sa1100fb_
 		LCCR2_EndFrmDel(var->lower_margin);
 
 	pcd = get_pcd(var->pixclock, cpufreq_get(0));
-	new_regs.lccr3 = LCCR3_PixClkDiv(pcd) | fbi->lccr3 |
+	new_regs.lccr3 = LCCR3_PixClkDiv(pcd) | fbi->inf->lccr3 |
 		(var->sync & FB_SYNC_HOR_HIGH_ACT ? LCCR3_HorSnchH : LCCR3_HorSnchL) |
 		(var->sync & FB_SYNC_VERT_HIGH_ACT ? LCCR3_VrtSnchH : LCCR3_VrtSnchL);
 
@@ -1154,13 +1154,10 @@ static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 		panic("sa1100fb error: invalid LCCR3 fields set or zero "
 			"pixclock.");
 
-	fbi->max_xres			= inf->xres;
 	fbi->fb.var.xres		= inf->xres;
 	fbi->fb.var.xres_virtual	= inf->xres;
-	fbi->max_yres			= inf->yres;
 	fbi->fb.var.yres		= inf->yres;
 	fbi->fb.var.yres_virtual	= inf->yres;
-	fbi->max_bpp			= inf->bpp;
 	fbi->fb.var.bits_per_pixel	= inf->bpp;
 	fbi->fb.var.pixclock		= inf->pixclock;
 	fbi->fb.var.hsync_len		= inf->hsync_len;
@@ -1171,14 +1168,10 @@ static struct sa1100fb_info * __devinit sa1100fb_init_fbinfo(struct device *dev)
 	fbi->fb.var.lower_margin	= inf->lower_margin;
 	fbi->fb.var.sync		= inf->sync;
 	fbi->fb.var.grayscale		= inf->cmap_greyscale;
-	fbi->cmap_inverse		= inf->cmap_inverse;
-	fbi->cmap_static		= inf->cmap_static;
-	fbi->lccr0			= inf->lccr0;
-	fbi->lccr3			= inf->lccr3;
 	fbi->state			= C_STARTUP;
 	fbi->task_state			= (u_char)-1;
-	fbi->fb.fix.smem_len		= fbi->max_xres * fbi->max_yres *
-					  fbi->max_bpp / 8;
+	fbi->fb.fix.smem_len		= inf->xres * inf->yres *
+					  inf->bpp / 8;
 	fbi->inf			= inf;
 
 	/* Copy the RGB bitfield overrides */
diff --git a/drivers/video/sa1100fb.h b/drivers/video/sa1100fb.h
index 3a634ab..e968e1d 100644
--- a/drivers/video/sa1100fb.h
+++ b/drivers/video/sa1100fb.h
@@ -23,10 +23,6 @@ struct sa1100fb_info {
 	struct device		*dev;
 	const struct sa1100fb_rgb *rgb[NR_RGB];
 
-	u_int			max_bpp;
-	u_int			max_xres;
-	u_int			max_yres;
-
 	/*
 	 * These are the addresses we mapped
 	 * the framebuffer memory region to.
@@ -44,12 +40,6 @@ struct sa1100fb_info {
 	dma_addr_t		dbar1;
 	dma_addr_t		dbar2;
 
-	u_int			lccr0;
-	u_int			lccr3;
-	u_int			cmap_inverse:1,
-				cmap_static:1,
-				unused:30;
-
 	u_int			reg_lccr0;
 	u_int			reg_lccr1;
 	u_int			reg_lccr2;
-- 
1.7.4.4

