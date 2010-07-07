From: InKi Dae <inki.dae@samsung.com>
Date: Wed, 07 Jul 2010 06:39:35 +0000
Subject: [PATCH v2 1/2] S5PV210: FB: Add MIPI-DSI and CPU Interface features.
Message-Id: <4C342127.9000900@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4C341FFD.6010405@samsung.com>
In-Reply-To: <4C341FFD.6010405@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

this patch adds features for supportting MIPI Interface and CPU mode to
s3c-fb.c

for this, I added following features.
. add struct fb_cmdmode
- this structure would be used for cpu interface.
. add interface_mode to struct s3c_fb_platdata.
- this variable would be used to distinguishe whether CPU or RGB mode.
. add two functions for cpu interface.
- s3c_fb_set_trigger would be used for to send trigger signal to FIMD.
- s3c_fb_is_i80_frame_done would be used to check framedone status.
. add a function for setting timing.
- I added this function because it have to distinguishe interfaces.
(CPU or RGB mode)
. add register definitions for using MIPI-DSI mode.

Signed-off-by: InKi Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index 27d3b49..b0204f8 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -22,6 +22,23 @@
  */
 #define S3C_FB_MAX_WIN	(5)
 
+enum {
+	FIMD_VIDEO_MODE = 0,
+	FIMD_COMMAND_MODE
+};
+
+struct fb_cmdmode {
+	const char *name;	/* optional */
+	u32 refresh;		/* optional */
+	u32 xres;
+	u32 yres;
+	u32 pixclock;
+	u32 cs_setup;
+	u32 wr_setup;
+	u32 wr_act;
+	u32 wr_hold;
+};
+
 /**
  * struct s3c_fb_pd_win - per window setup data
  * @win_mode: The display parameters to initialise (not for window 0)
@@ -30,6 +47,7 @@
  */
 struct s3c_fb_pd_win {
 	struct fb_videomode	win_mode;
+	struct fb_cmdmode	cmd_mode;
 
 	unsigned short		default_bpp;
 	unsigned short		max_bpp;
@@ -42,6 +60,7 @@ struct s3c_fb_pd_win {
  * @setup_gpio: Setup the external GPIO pins to the right state to transfer
  *		the data from the display system to the connected display
  *		device.
+ * @interface_mode: cpu mode or rgb mode.
  * @vidcon0: The base vidcon0 values to control the panel data format.
  * @vidcon1: The base vidcon1 values to control the panel data output.
  * @win: The setup data for each hardware window, or NULL for unused.
@@ -57,6 +76,7 @@ struct s3c_fb_platdata {
 	void	(*setup_gpio)(void);
 
 	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
+	u32			interface_mode;
 
 	u32			 vidcon0;
 	u32			 vidcon1;
@@ -91,4 +111,10 @@ extern void s5pc100_fb_gpio_setup_24bpp(void);
  */
 extern void s5pv210_fb_gpio_setup_24bpp(void);
 
+struct fb_info;
+
+extern void s3c_fb_set_trigger(struct fb_info *info);
+
+extern int s3c_fb_is_i80_frame_done(struct fb_info *info);
+
 #endif /* __PLAT_S3C_FB_H */
diff --git a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
index 0f43599..4d5954b 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
@@ -135,6 +135,22 @@
 
 #define WPALCON					(0x1A0)
 
+/* For CPU interface. */
+#define TRIGCON						(0x1a4)
+#define TRGMODE_I80_ENABLE				(1 << 0)
+#define SWTRGCMD_I80_TRIGGER				(1 << 1)
+#define SWFRSTATUS_I80					(1 << 2)
+
+#define I80IFCONA0					(0x1b0)
+#define I80IFEN_ENABLE					(1 << 0)
+#define RSPOL_HIGH					(1 << 2)
+#define LCD_WR_HOLD(x)					(((x) & 0xf) << 4)
+#define LCD_WR_ACT(x)					(((x) & 0xf) << 8)
+#define LCD_WR_SETUP(x)					(((x) & 0xf) << 12)
+#define LCD_CS_SETUP(x)					(((x) & 0xf) << 16)
+
+#define I80IFCONB0					(0x1b8)
+
 /* Palette control */
 /* Note for S5PC100: you can still use those macros on WPALCON (aka WPALCON_L),
  * but make sure that WPALCON_H W2PAL-W4PAL entries are zeroed out */
diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
index 0ef806e..70342aa 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -38,6 +38,7 @@
 #define VIDCON0_VIDOUT_TV			(0x1 << 26)
 #define VIDCON0_VIDOUT_I80_LDI0			(0x2 << 26)
 #define VIDCON0_VIDOUT_I80_LDI1			(0x3 << 26)
+#define VIDCON0_DSI_EN_ENABLE			(1 << 30)
 
 #define VIDCON0_L1_DATA_MASK			(0x7 << 23)
 #define VIDCON0_L1_DATA_SHIFT			(23)
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 9682ecc..28d34ef 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -255,6 +255,73 @@ static int s3c_fb_align_word(unsigned int bpp, unsigned int pix)
 }
 
 /**
+ * s3c_fb_set_trigger - fimd trigger based on cpu interface.
+ */
+void s3c_fb_set_trigger(struct fb_info *info)
+{
+	struct s3c_fb_win *win = info->par;
+	struct s3c_fb *sfb = win->parent;
+	void __iomem *regs = sfb->regs;
+	u32 reg = 0;
+
+	reg = readl(regs + TRIGCON);
+
+	reg |= TRGMODE_I80_ENABLE | SWTRGCMD_I80_TRIGGER;
+
+	writel(reg, regs + TRIGCON);
+}
+
+/**
+ * s3c_fb_is_i80_frame_done - get i80 frame done status.
+ */
+int s3c_fb_is_i80_frame_done(struct fb_info *info)
+{
+	struct s3c_fb_win *win = info->par;
+	struct s3c_fb *sfb = win->parent;
+	void __iomem *regs = sfb->regs;
+	u32 reg = 0;
+
+	reg =  readl(regs + TRIGCON);
+
+	return (((reg & SWFRSTATUS_I80) = SWFRSTATUS_I80) ? 1 : 0);
+}
+
+/**
+ * s3c_fb_set_cpu_timing - set cpu timing.
+ */
+static void s3c_fb_set_timing(struct s3c_fb *sfb, struct fb_info *info)
+{
+	struct s3c_fb_win *win = info->par;
+	struct s3c_fb_pd_win *windata = win->windata;
+	struct fb_var_screeninfo *var = &info->var;
+	void __iomem *regs = sfb->regs;
+	u32 reg = 0;
+
+	if (sfb->pdata->interface_mode = FIMD_VIDEO_MODE) {
+		reg = VIDTCON0_VBPD(var->upper_margin - 1) |
+		       VIDTCON0_VFPD(var->lower_margin - 1) |
+		       VIDTCON0_VSPW(var->vsync_len - 1);
+
+		writel(reg, regs + VIDTCON0);
+
+		reg = VIDTCON1_HBPD(var->left_margin - 1) |
+		       VIDTCON1_HFPD(var->right_margin - 1) |
+		       VIDTCON1_HSPW(var->hsync_len - 1);
+
+		writel(reg, regs + VIDTCON1);
+	} else if (sfb->pdata->interface_mode = FIMD_COMMAND_MODE) {
+		reg = LCD_CS_SETUP(windata->cmd_mode.cs_setup) |
+			LCD_WR_SETUP(windata->cmd_mode.wr_setup) |
+			LCD_WR_ACT(windata->cmd_mode.wr_act) |
+			LCD_WR_HOLD(windata->cmd_mode.wr_hold) |
+			I80IFEN_ENABLE;
+
+		writel(reg, regs + I80IFCONA0);
+	} else
+		dev_warn(sfb->dev, "wrong interface type.\n");
+}
+
+/**
  * s3c_fb_set_par() - framebuffer request to set new framebuffer state.
  * @info: The framebuffer to change.
  *
@@ -318,17 +385,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 		data |= VIDCON0_ENVID | VIDCON0_ENVID_F;
 		writel(data, regs + VIDCON0);
 
-		data = VIDTCON0_VBPD(var->upper_margin - 1) |
-		       VIDTCON0_VFPD(var->lower_margin - 1) |
-		       VIDTCON0_VSPW(var->vsync_len - 1);
-
-		writel(data, regs + VIDTCON0);
-
-		data = VIDTCON1_HBPD(var->left_margin - 1) |
-		       VIDTCON1_HFPD(var->right_margin - 1) |
-		       VIDTCON1_HSPW(var->hsync_len - 1);
-
-		writel(data, regs + VIDTCON1);
+		s3c_fb_set_timing(sfb, info);
 
 		data = VIDTCON2_LINEVAL(var->yres - 1) |
 		       VIDTCON2_HOZVAL(var->xres - 1);
@@ -744,7 +801,8 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 				      struct s3c_fb_win **res)
 {
 	struct fb_var_screeninfo *var;
-	struct fb_videomode *initmode;
+	struct fb_videomode *videomode;
+	struct fb_cmdmode *cmdmode;
 	struct s3c_fb_pd_win *windata;
 	struct s3c_fb_win *win;
 	struct fb_info *fbinfo;
@@ -763,11 +821,20 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	}
 
 	windata = sfb->pdata->win[win_no];
-	initmode = &windata->win_mode;
 
 	WARN_ON(windata->max_bpp = 0);
-	WARN_ON(windata->win_mode.xres = 0);
-	WARN_ON(windata->win_mode.yres = 0);
+
+	if (sfb->pdata->interface_mode = FIMD_VIDEO_MODE) {
+		WARN_ON(windata->win_mode.xres = 0);
+		WARN_ON(windata->win_mode.yres = 0);
+
+		videomode = &windata->win_mode;
+	} else {
+		WARN_ON(windata->cmd_mode.xres = 0);
+		WARN_ON(windata->cmd_mode.yres = 0);
+
+		cmdmode = &windata->cmd_mode;
+	}
 
 	win = fbinfo->par;
 	var = &fbinfo->var;
@@ -777,18 +844,19 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	win->index = win_no;
 	win->palette_buffer = (u32 *)(win + 1);
 
-	ret = s3c_fb_alloc_memory(sfb, win);
-	if (ret) {
-		dev_err(sfb->dev, "failed to allocate display memory\n");
-		return ret;
+	/* setup the initial video or cpu mode from the window */
+	if (sfb->pdata->interface_mode = FIMD_VIDEO_MODE)
+		fb_videomode_to_var(&fbinfo->var, videomode);
+	else {
+		var->xres = cmdmode->xres;
+		var->yres = cmdmode->yres;
+		var->xres_virtual = cmdmode->xres;
+		var->yres_virtual = cmdmode->yres;
+		var->xoffset = 0;
+		var->yoffset = 0;
+		var->pixclock = cmdmode->pixclock;
 	}
 
-	/* setup the r/b/g positions for the window's palette */
-	s3c_fb_init_palette(win_no, &win->palette);
-
-	/* setup the initial video mode from the window */
-	fb_videomode_to_var(&fbinfo->var, initmode);
-
 	fbinfo->fix.type	= FB_TYPE_PACKED_PIXELS;
 	fbinfo->fix.accel	= FB_ACCEL_NONE;
 	fbinfo->var.activate	= FB_ACTIVATE_NOW;
@@ -798,6 +866,15 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	fbinfo->flags		= FBINFO_FLAG_DEFAULT;
 	fbinfo->pseudo_palette  = &win->pseudo_palette;
 
+	ret = s3c_fb_alloc_memory(sfb, win);
+	if (ret) {
+		dev_err(sfb->dev, "failed to allocate display memory\n");
+		return ret;
+	}
+
+	/* setup the r/b/g positions for the window's palette */
+	s3c_fb_init_palette(win_no, &win->palette);
+
 	/* prepare to actually start the framebuffer */
 
 	ret = s3c_fb_check_var(&fbinfo->var, fbinfo);


