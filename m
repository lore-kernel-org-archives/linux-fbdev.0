From: Thomas Abraham <thomas.abraham@linaro.org>
Date: Sat, 03 Mar 2012 15:46:19 +0000
Subject: [PATCH 1/3] video: s3c-fb: move video interface timing out of window setup data
Message-Id: <1330789808-8253-2-git-send-email-thomas.abraham@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1330789808-8253-1-git-send-email-thomas.abraham@linaro.org>
In-Reply-To: <1330789808-8253-1-git-send-email-thomas.abraham@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: FlorianSchandinat@gmx.de, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, jg1.han@samsung.com, ben-linux@fluff.org, patches@linaro.org

The video interface timing is independent of the window setup data.
The resolution of the window can be smaller than that of the lcd
panel to which the video data is output.

So move the video timing data from the per-window setup data to the
platform specific section in the platform data. This also removes
the restriction that atleast one window should have the same
resolution as that of the panel attached.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Jingoo Han <jg1.han@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/plat-samsung/include/plat/fb.h |    9 ++-
 drivers/video/s3c-fb.c                  |  106 +++++++++++++++++--------------
 2 files changed, 63 insertions(+), 52 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index 0fedf47..39d6bd7 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -24,15 +24,16 @@
 
 /**
  * struct s3c_fb_pd_win - per window setup data
- * @win_mode: The display parameters to initialise (not for window 0)
+ * @xres     : The window X size.
+ * @yres     : The window Y size.
  * @virtual_x: The virtual X size.
  * @virtual_y: The virtual Y size.
  */
 struct s3c_fb_pd_win {
-	struct fb_videomode	win_mode;
-
 	unsigned short		default_bpp;
 	unsigned short		max_bpp;
+	unsigned short		xres;
+	unsigned short		yres;
 	unsigned short		virtual_x;
 	unsigned short		virtual_y;
 };
@@ -45,6 +46,7 @@ struct s3c_fb_pd_win {
  * @default_win: default window layer number to be used for UI layer.
  * @vidcon0: The base vidcon0 values to control the panel data format.
  * @vidcon1: The base vidcon1 values to control the panel data output.
+ * @vtiming: Video timing when connected to a RGB type panel.
  * @win: The setup data for each hardware window, or NULL for unused.
  * @display_mode: The LCD output display mode.
  *
@@ -58,6 +60,7 @@ struct s3c_fb_platdata {
 	void	(*setup_gpio)(void);
 
 	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
+	struct fb_videomode     *vtiming;
 
 	u32			 default_win;
 
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 1fb7ddf..8e05d4d 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -495,7 +495,6 @@ static int s3c_fb_set_par(struct fb_info *info)
 	u32 alpha = 0;
 	u32 data;
 	u32 pagewidth;
-	int clkdiv;
 
 	dev_dbg(sfb->dev, "setting framebuffer parameters\n");
 
@@ -532,46 +531,9 @@ static int s3c_fb_set_par(struct fb_info *info)
 	/* disable the window whilst we update it */
 	writel(0, regs + WINCON(win_no));
 
-	/* use platform specified window as the basis for the lcd timings */
-
-	if (win_no = sfb->pdata->default_win) {
-		clkdiv = s3c_fb_calc_pixclk(sfb, var->pixclock);
-
-		data = sfb->pdata->vidcon0;
-		data &= ~(VIDCON0_CLKVAL_F_MASK | VIDCON0_CLKDIR);
-
-		if (clkdiv > 1)
-			data |= VIDCON0_CLKVAL_F(clkdiv-1) | VIDCON0_CLKDIR;
-		else
-			data &= ~VIDCON0_CLKDIR;	/* 1:1 clock */
-
-		/* write the timing data to the panel */
-
-		if (sfb->variant.is_2443)
-			data |= (1 << 5);
-
-		writel(data, regs + VIDCON0);
-
+	if (win_no = sfb->pdata->default_win)
 		s3c_fb_enable(sfb, 1);
 
-		data = VIDTCON0_VBPD(var->upper_margin - 1) |
-		       VIDTCON0_VFPD(var->lower_margin - 1) |
-		       VIDTCON0_VSPW(var->vsync_len - 1);
-
-		writel(data, regs + sfb->variant.vidtcon);
-
-		data = VIDTCON1_HBPD(var->left_margin - 1) |
-		       VIDTCON1_HFPD(var->right_margin - 1) |
-		       VIDTCON1_HSPW(var->hsync_len - 1);
-
-		/* VIDTCON1 */
-		writel(data, regs + sfb->variant.vidtcon + 4);
-
-		data = VIDTCON2_LINEVAL(var->yres - 1) |
-		       VIDTCON2_HOZVAL(var->xres - 1);
-		writel(data, regs + sfb->variant.vidtcon + 8);
-	}
-
 	/* write the buffer address */
 
 	/* start and end registers stride is 8 */
@@ -1136,11 +1098,11 @@ static int __devinit s3c_fb_alloc_memory(struct s3c_fb *sfb,
 
 	dev_dbg(sfb->dev, "allocating memory for display\n");
 
-	real_size = windata->win_mode.xres * windata->win_mode.yres;
+	real_size = windata->xres * windata->yres;
 	virt_size = windata->virtual_x * windata->virtual_y;
 
 	dev_dbg(sfb->dev, "real_size=%u (%u.%u), virt_size=%u (%u.%u)\n",
-		real_size, windata->win_mode.xres, windata->win_mode.yres,
+		real_size, windata->xres, windata->yres,
 		virt_size, windata->virtual_x, windata->virtual_y);
 
 	size = (real_size > virt_size) ? real_size : virt_size;
@@ -1222,7 +1184,7 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 				      struct s3c_fb_win **res)
 {
 	struct fb_var_screeninfo *var;
-	struct fb_videomode *initmode;
+	struct fb_videomode initmode;
 	struct s3c_fb_pd_win *windata;
 	struct s3c_fb_win *win;
 	struct fb_info *fbinfo;
@@ -1243,11 +1205,11 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	}
 
 	windata = sfb->pdata->win[win_no];
-	initmode = &windata->win_mode;
+	initmode = *sfb->pdata->vtiming;
 
 	WARN_ON(windata->max_bpp = 0);
-	WARN_ON(windata->win_mode.xres = 0);
-	WARN_ON(windata->win_mode.yres = 0);
+	WARN_ON(windata->xres = 0);
+	WARN_ON(windata->yres = 0);
 
 	win = fbinfo->par;
 	*res = win;
@@ -1286,7 +1248,9 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	}
 
 	/* setup the initial video mode from the window */
-	fb_videomode_to_var(&fbinfo->var, initmode);
+	initmode.xres = windata->xres;
+	initmode.yres = windata->yres;
+	fb_videomode_to_var(&fbinfo->var, &initmode);
 
 	fbinfo->fix.type	= FB_TYPE_PACKED_PIXELS;
 	fbinfo->fix.accel	= FB_ACCEL_NONE;
@@ -1331,6 +1295,51 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 }
 
 /**
+ * s3c_fb_set_rgb_timing() - set video timing for rgb interface.
+ * @sfb: The base resources for the hardware.
+ *
+ * Set horizontal and vertical lcd rgb interface timing.
+ */
+static void s3c_fb_set_rgb_timing(struct s3c_fb *sfb)
+{
+	struct fb_videomode *vmode = sfb->pdata->vtiming;
+	void __iomem *regs = sfb->regs;
+	int clkdiv;
+	u32 data;
+
+	if (!vmode->pixclock)
+		s3c_fb_missing_pixclock(vmode);
+
+	clkdiv = s3c_fb_calc_pixclk(sfb, vmode->pixclock);
+
+	data = sfb->pdata->vidcon0;
+	data &= ~(VIDCON0_CLKVAL_F_MASK | VIDCON0_CLKDIR);
+
+	if (clkdiv > 1)
+		data |= VIDCON0_CLKVAL_F(clkdiv-1) | VIDCON0_CLKDIR;
+	else
+		data &= ~VIDCON0_CLKDIR;	/* 1:1 clock */
+
+	if (sfb->variant.is_2443)
+		data |= (1 << 5);
+	writel(data, regs + VIDCON0);
+
+	data = VIDTCON0_VBPD(vmode->upper_margin - 1) |
+	       VIDTCON0_VFPD(vmode->lower_margin - 1) |
+	       VIDTCON0_VSPW(vmode->vsync_len - 1);
+	writel(data, regs + sfb->variant.vidtcon);
+
+	data = VIDTCON1_HBPD(vmode->left_margin - 1) |
+	       VIDTCON1_HFPD(vmode->right_margin - 1) |
+	       VIDTCON1_HSPW(vmode->hsync_len - 1);
+	writel(data, regs + sfb->variant.vidtcon + 4);
+
+	data = VIDTCON2_LINEVAL(vmode->yres - 1) |
+	       VIDTCON2_HOZVAL(vmode->xres - 1);
+	writel(data, regs + sfb->variant.vidtcon + 8);
+}
+
+/**
  * s3c_fb_clear_win() - clear hardware window registers.
  * @sfb: The base resources for the hardware.
  * @win: The window to process.
@@ -1473,15 +1482,14 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		writel(0xffffff, regs + WKEYCON1);
 	}
 
+	s3c_fb_set_rgb_timing(sfb);
+
 	/* we have the register setup, start allocating framebuffers */
 
 	for (win = 0; win < fbdrv->variant.nr_windows; win++) {
 		if (!pd->win[win])
 			continue;
 
-		if (!pd->win[win]->win_mode.pixclock)
-			s3c_fb_missing_pixclock(&pd->win[win]->win_mode);
-
 		ret = s3c_fb_probe_win(sfb, win, fbdrv->win[win],
 				       &sfb->windows[win]);
 		if (ret < 0) {
-- 
1.6.6.rc2

