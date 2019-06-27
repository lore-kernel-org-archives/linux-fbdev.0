From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 27 Jun 2019 14:08:43 +0000
Subject: [PATCH 3/3] video: fbdev: mmp: fix sparse warnings about using incorrect types
Message-Id: <ee796b43-f200-d41a-b18c-ae3d6bcaaa67@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190627140844eucas1p1fac4e639a3445c6ae1a51b0743289f1c@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Use ->screen_buffer instead of ->screen_base in mmpfb driver.

[ Please see commit 17a7b0b4d974 ("fb.h: Provide alternate screen_base
  pointer") for details. ]

Also fix all other sparse warnings about using incorrect types in
mmp display subsystem.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/mmp/fb/mmpfb.c    |    2 -
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c |   55 +++++++++++++++++++---------------
 drivers/video/fbdev/mmp/hw/mmp_ctrl.h |   10 +++---
 drivers/video/fbdev/mmp/hw/mmp_spi.c  |    6 +--
 4 files changed, 41 insertions(+), 32 deletions(-)

Index: b/drivers/video/fbdev/mmp/fb/mmpfb.c
=================================--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@ -522,7 +522,7 @@ static int fb_info_setup(struct fb_info
 		info->var.bits_per_pixel / 8;
 	info->fbops = &mmpfb_ops;
 	info->pseudo_palette = fbi->pseudo_palette;
-	info->screen_base = fbi->fb_start;
+	info->screen_buffer = fbi->fb_start;
 	info->screen_size = fbi->fb_size;
 
 	/* For FB framework: Allocate color map and Register framebuffer*/
Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
=================================--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.c
@@ -136,19 +136,26 @@ static void overlay_set_win(struct mmp_o
 	mutex_lock(&overlay->access_ok);
 
 	if (overlay_is_vid(overlay)) {
-		writel_relaxed(win->pitch[0], &regs->v_pitch_yc);
-		writel_relaxed(win->pitch[2] << 16 |
-				win->pitch[1], &regs->v_pitch_uv);
-
-		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->v_size);
-		writel_relaxed((win->ydst << 16) | win->xdst, &regs->v_size_z);
-		writel_relaxed(win->ypos << 16 | win->xpos, &regs->v_start);
+		writel_relaxed(win->pitch[0],
+				(void __iomem *)&regs->v_pitch_yc);
+		writel_relaxed(win->pitch[2] << 16 | win->pitch[1],
+				(void __iomem *)&regs->v_pitch_uv);
+
+		writel_relaxed((win->ysrc << 16) | win->xsrc,
+				(void __iomem *)&regs->v_size);
+		writel_relaxed((win->ydst << 16) | win->xdst,
+				(void __iomem *)&regs->v_size_z);
+		writel_relaxed(win->ypos << 16 | win->xpos,
+				(void __iomem *)&regs->v_start);
 	} else {
-		writel_relaxed(win->pitch[0], &regs->g_pitch);
+		writel_relaxed(win->pitch[0], (void __iomem *)&regs->g_pitch);
 
-		writel_relaxed((win->ysrc << 16) | win->xsrc, &regs->g_size);
-		writel_relaxed((win->ydst << 16) | win->xdst, &regs->g_size_z);
-		writel_relaxed(win->ypos << 16 | win->xpos, &regs->g_start);
+		writel_relaxed((win->ysrc << 16) | win->xsrc,
+				(void __iomem *)&regs->g_size);
+		writel_relaxed((win->ydst << 16) | win->xdst,
+				(void __iomem *)&regs->g_size_z);
+		writel_relaxed(win->ypos << 16 | win->xpos,
+				(void __iomem *)&regs->g_start);
 	}
 
 	dmafetch_set_fmt(overlay);
@@ -233,11 +240,11 @@ static int overlay_set_addr(struct mmp_o
 	memcpy(&overlay->addr, addr, sizeof(struct mmp_addr));
 
 	if (overlay_is_vid(overlay)) {
-		writel_relaxed(addr->phys[0], &regs->v_y0);
-		writel_relaxed(addr->phys[1], &regs->v_u0);
-		writel_relaxed(addr->phys[2], &regs->v_v0);
+		writel_relaxed(addr->phys[0], (void __iomem *)&regs->v_y0);
+		writel_relaxed(addr->phys[1], (void __iomem *)&regs->v_u0);
+		writel_relaxed(addr->phys[2], (void __iomem *)&regs->v_v0);
 	} else
-		writel_relaxed(addr->phys[0], &regs->g_0);
+		writel_relaxed(addr->phys[0], (void __iomem *)&regs->g_0);
 
 	return overlay->addr.phys[0];
 }
@@ -268,16 +275,18 @@ static void path_set_mode(struct mmp_pat
 	tmp |= dsi_rbswap & CFG_INTFRBSWAP_MASK;
 	writel_relaxed(tmp, ctrl_regs(path) + intf_rbswap_ctrl(path->id));
 
-	writel_relaxed((mode->yres << 16) | mode->xres, &regs->screen_active);
+	writel_relaxed((mode->yres << 16) | mode->xres,
+		(void __iomem *)&regs->screen_active);
 	writel_relaxed((mode->left_margin << 16) | mode->right_margin,
-		&regs->screen_h_porch);
+		(void __iomem *)&regs->screen_h_porch);
 	writel_relaxed((mode->upper_margin << 16) | mode->lower_margin,
-		&regs->screen_v_porch);
+		(void __iomem *)&regs->screen_v_porch);
 	total_x = mode->xres + mode->left_margin + mode->right_margin +
 		mode->hsync_len;
 	total_y = mode->yres + mode->upper_margin + mode->lower_margin +
 		mode->vsync_len;
-	writel_relaxed((total_y << 16) | total_x, &regs->screen_size);
+	writel_relaxed((total_y << 16) | total_x,
+		(void __iomem *)&regs->screen_size);
 
 	/* vsync ctrl */
 	if (path->output_type = PATH_OUT_DSI)
@@ -285,7 +294,7 @@ static void path_set_mode(struct mmp_pat
 	else
 		vsync_ctrl = ((mode->xres + mode->right_margin) << 16)
 					| (mode->xres + mode->right_margin);
-	writel_relaxed(vsync_ctrl, &regs->vsync_ctrl);
+	writel_relaxed(vsync_ctrl, (void __iomem *)&regs->vsync_ctrl);
 
 	/* set pixclock div */
 	sclk_src = clk_get_rate(path_to_ctrl(path)->clk);
@@ -366,9 +375,9 @@ static void path_set_default(struct mmp_
 	writel_relaxed(dma_ctrl1, ctrl_regs(path) + dma_ctrl(1, path->id));
 
 	/* Configure default register values */
-	writel_relaxed(0x00000000, &regs->blank_color);
-	writel_relaxed(0x00000000, &regs->g_1);
-	writel_relaxed(0x00000000, &regs->g_start);
+	writel_relaxed(0x00000000, (void __iomem *)&regs->blank_color);
+	writel_relaxed(0x00000000, (void __iomem *)&regs->g_1);
+	writel_relaxed(0x00000000, (void __iomem *)&regs->g_start);
 
 	/*
 	 * 1.enable multiple burst request in DMA AXI
Index: b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
=================================--- a/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
+++ b/drivers/video/fbdev/mmp/hw/mmp_ctrl.h
@@ -1393,7 +1393,7 @@ struct mmphw_ctrl {
 	/* platform related, get from config */
 	const char *name;
 	int irq;
-	void *reg_base;
+	void __iomem *reg_base;
 	struct clk *clk;
 
 	/* sys info */
@@ -1429,7 +1429,7 @@ static inline struct mmphw_ctrl *overlay
 	return path_to_ctrl(overlay->path);
 }
 
-static inline void *ctrl_regs(struct mmp_path *path)
+static inline void __iomem *ctrl_regs(struct mmp_path *path)
 {
 	return path_to_ctrl(path)->reg_base;
 }
@@ -1438,11 +1438,11 @@ static inline void *ctrl_regs(struct mmp
 static inline struct lcd_regs *path_regs(struct mmp_path *path)
 {
 	if (path->id = PATH_PN)
-		return (struct lcd_regs *)(ctrl_regs(path) + 0xc0);
+		return (struct lcd_regs __force *)(ctrl_regs(path) + 0xc0);
 	else if (path->id = PATH_TV)
-		return (struct lcd_regs *)ctrl_regs(path);
+		return (struct lcd_regs __force  *)ctrl_regs(path);
 	else if (path->id = PATH_P2)
-		return (struct lcd_regs *)(ctrl_regs(path) + 0x200);
+		return (struct lcd_regs __force *)(ctrl_regs(path) + 0x200);
 	else {
 		dev_err(path->dev, "path id %d invalid\n", path->id);
 		BUG_ON(1);
Index: b/drivers/video/fbdev/mmp/hw/mmp_spi.c
=================================--- a/drivers/video/fbdev/mmp/hw/mmp_spi.c
+++ b/drivers/video/fbdev/mmp/hw/mmp_spi.c
@@ -31,7 +31,7 @@ static inline int lcd_spi_write(struct s
 {
 	int timeout = 100000, isr, ret = 0;
 	u32 tmp;
-	void *reg_base +	void __iomem *reg_base = (void __iomem *)
 		*(void **)spi_master_get_devdata(spi->master);
 
 	/* clear ISR */
@@ -80,7 +80,7 @@ static inline int lcd_spi_write(struct s
 
 static int lcd_spi_setup(struct spi_device *spi)
 {
-	void *reg_base +	void __iomem *reg_base = (void __iomem *)
 		*(void **)spi_master_get_devdata(spi->master);
 	u32 tmp;
 
@@ -146,7 +146,7 @@ int lcd_spi_register(struct mmphw_ctrl *
 		return -ENOMEM;
 	}
 	p_regbase = spi_master_get_devdata(master);
-	*p_regbase = ctrl->reg_base;
+	*p_regbase = (void __force *)ctrl->reg_base;
 
 	/* set bus num to 5 to avoid conflict with other spi hosts */
 	master->bus_num = 5;
