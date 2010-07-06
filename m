From: James Simmons <jsimmons@infradead.org>
Date: Tue, 06 Jul 2010 15:36:14 +0000
Subject: [PATCH 2/3] S5PV210: FB: Add MIPI-DSI and CPU Interface features.
Message-Id: <alpine.LFD.2.00.1007061635530.3285@casper.infradead.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1985284609-453043563-1278430594=:3285"
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LFD.2.00.1007061631210.3285@casper.infradead.org>
In-Reply-To: <alpine.LFD.2.00.1007061631210.3285@casper.infradead.org>
To: linux-fbdev@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-453043563-1278430594=:3285
Content-Type: TEXT/PLAIN; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable


this patch adds features for supportting MIPI Interface and CPU mode to s3c=
-fb.c

for this, I added following features.
. add struct fb_cmdmode
=A0 - this structure would be used for cpu interface.
. add interface_mode to struct s3c_fb_platdata.
=A0 - this variable would be used to distinguishe whether CPU or RGB mode.
. add two functions for cpu interface.
=A0 - s3c_fb_set_trigger would be used for to send trigger signal to FIMD.
=A0 - s3c_fb_is_i80_frame_done would be used to check framedone status.
. add a function for setting timing.
=A0 - I added this function because it have to distinguishe interfaces.
=A0=A0=A0 (CPU or RGB mode)
. add register definitions for using MIPI-DSI mode.

Signed-off-by: InKi Dae <inki.dae@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsun=
g/inc
lude/plat/fb.h
index 27d3b49..193f6ea 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -22,6 +22,11 @@
  */
 #define S3C_FB_MAX_WIN	(5)
=20
+enum {
+	FIMD_VIDEO_MODE =3D 0,
+	FIMD_COMMAND_MODE
+};
+
 /**
  * struct s3c_fb_pd_win - per window setup data
  * @win_mode: The display parameters to initialise (not for window 0)
@@ -30,6 +35,7 @@
  */
 struct s3c_fb_pd_win {
 	struct fb_videomode	win_mode;
+	struct fb_cmdmode	cmd_mode;
=20
 	unsigned short		default_bpp;
 	unsigned short		max_bpp;
@@ -42,6 +48,7 @@ struct s3c_fb_pd_win {
  * @setup_gpio: Setup the external GPIO pins to the right state to transfer
  *		the data from the display system to the connected display
  *		device.
+ * @interface_mode: cpu mode or rgb mode.
  * @vidcon0: The base vidcon0 values to control the panel data format.
  * @vidcon1: The base vidcon1 values to control the panel data output.
  * @win: The setup data for each hardware window, or NULL for unused.
@@ -57,6 +64,7 @@ struct s3c_fb_platdata {
 	void	(*setup_gpio)(void);
=20
 	struct s3c_fb_pd_win	*win[S3C_FB_MAX_WIN];
+	u32			interface_mode;
=20
 	u32			 vidcon0;
 	u32			 vidcon1;
@@ -91,4 +99,10 @@ extern void s5pc100_fb_gpio_setup_24bpp(void);
  */
 extern void s5pv210_fb_gpio_setup_24bpp(void);
=20
+struct fb_info;
+
+extern void s3c_fb_set_trigger(struct fb_info *info);
+
+extern int s3c_fb_is_i80_frame_done(struct fb_info *info);
+
 #endif /* __PLAT_S3C_FB_H */
diff --git a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h b/arch/arm/pla=
t-sam
sung/include/plat/regs-fb-v4.h
index 0f43599..4d5954b 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb-v4.h
@@ -135,6 +135,22 @@
=20
 #define WPALCON					(0x1A0)
=20
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
 /* Note for S5PC100: you can still use those macros on WPALCON (aka WPALCO=
N_L),
  * but make sure that WPALCON_H W2PAL-W4PAL entries are zeroed out */
diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-s=
amsun
g/include/plat/regs-fb.h
index 0ef806e..70342aa 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -38,6 +38,7 @@
 #define VIDCON0_VIDOUT_TV			(0x1 << 26)
 #define VIDCON0_VIDOUT_I80_LDI0			(0x2 << 26)
 #define VIDCON0_VIDOUT_I80_LDI1			(0x3 << 26)
+#define VIDCON0_DSI_EN_ENABLE			(1 << 30)
=20
 #define VIDCON0_L1_DATA_MASK			(0x7 << 23)
 #define VIDCON0_L1_DATA_SHIFT			(23)
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 9682ecc..8063427 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -135,6 +135,18 @@ static int s3c_fb_check_var(struct fb_var_screeninfo *=
var,
 	var->transp.offset =3D 0;
 	var->transp.length =3D 0;
=20
+	/* ensure input timing values are same as machine setting ones. */
+	if (sfb->pdata->interface_mode =3D=3D FIMD_COMMAND_MODE) {
+		if (var->cs_setup !=3D info->var.cs_setup)
+			var->cs_setup =3D info->var.cs_setup;
+		if (var->wr_setup !=3D info->var.wr_setup)
+			var->wr_setup =3D info->var.wr_setup;
+		if (var->wr_act !=3D info->var.wr_act)
+			var->wr_act =3D info->var.wr_act;
+		if (var->wr_hold !=3D info->var.wr_hold)
+			var->wr_hold =3D info->var.wr_hold;
+	}
+
 	switch (var->bits_per_pixel) {
 	case 1:
 	case 2:
@@ -255,6 +267,70 @@ static int s3c_fb_align_word(unsigned int bpp, unsigne=
d int
 pix)
 }
=20
 /**
+ * s3c_fb_set_trigger - fimd trigger based on cpu interface.
+ */
+void s3c_fb_set_trigger(struct fb_info *info)
+{
+	struct s3c_fb_win *win =3D info->par;
+	struct s3c_fb *sfb =3D win->parent;
+	void __iomem *regs =3D sfb->regs;
+	u32 reg =3D 0;
+
+	reg =3D readl(regs + TRIGCON);
+
+	reg |=3D TRGMODE_I80_ENABLE | SWTRGCMD_I80_TRIGGER;
+
+	writel(reg, regs + TRIGCON);
+}
+
+/**
+ * s3c_fb_is_i80_frame_done - get i80 frame done status.
+ */
+int s3c_fb_is_i80_frame_done(struct fb_info *info)
+{
+	struct s3c_fb_win *win =3D info->par;
+	struct s3c_fb *sfb =3D win->parent;
+	void __iomem *regs =3D sfb->regs;
+	u32 reg =3D 0;
+
+	reg =3D  readl(regs + TRIGCON);
+
+	return (((reg & SWFRSTATUS_I80) =3D=3D SWFRSTATUS_I80) ? 1 : 0);
+}
+
+/**
+ * s3c_fb_set_cpu_timing - set cpu timing.
+ */
+static void s3c_fb_set_timing(struct s3c_fb *sfb, struct fb_var_screeninfo=
 *var
)
+{
+	void __iomem *regs =3D sfb->regs;
+	u32 reg =3D 0;
+
+	if (sfb->pdata->interface_mode =3D=3D FIMD_VIDEO_MODE) {
+		reg =3D VIDTCON0_VBPD(var->upper_margin - 1) |
+		       VIDTCON0_VFPD(var->lower_margin - 1) |
+		       VIDTCON0_VSPW(var->vsync_len - 1);
+
+		writel(reg, regs + VIDTCON0);
+
+		reg =3D VIDTCON1_HBPD(var->left_margin - 1) |
+		       VIDTCON1_HFPD(var->right_margin - 1) |
+		       VIDTCON1_HSPW(var->hsync_len - 1);
+
+		writel(reg, regs + VIDTCON1);
+	} else if (sfb->pdata->interface_mode =3D=3D FIMD_COMMAND_MODE) {
+		reg =3D LCD_CS_SETUP(var->cs_setup) |
+			LCD_WR_SETUP(var->wr_setup) |
+			LCD_WR_ACT(var->wr_act) |
+			LCD_WR_HOLD(var->wr_hold) |
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
@@ -318,17 +394,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 		data |=3D VIDCON0_ENVID | VIDCON0_ENVID_F;
 		writel(data, regs + VIDCON0);
=20
-		data =3D VIDTCON0_VBPD(var->upper_margin - 1) |
-		       VIDTCON0_VFPD(var->lower_margin - 1) |
-		       VIDTCON0_VSPW(var->vsync_len - 1);
-
-		writel(data, regs + VIDTCON0);
-
-		data =3D VIDTCON1_HBPD(var->left_margin - 1) |
-		       VIDTCON1_HFPD(var->right_margin - 1) |
-		       VIDTCON1_HSPW(var->hsync_len - 1);
-
-		writel(data, regs + VIDTCON1);
+		s3c_fb_set_timing(sfb, var);
=20
 		data =3D VIDTCON2_LINEVAL(var->yres - 1) |
 		       VIDTCON2_HOZVAL(var->xres - 1);
@@ -744,7 +810,8 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sf=
b, un
signed int win_no,
 				      struct s3c_fb_win **res)
 {
 	struct fb_var_screeninfo *var;
-	struct fb_videomode *initmode;
+	struct fb_videomode *videomode;
+	struct fb_cmdmode *cmdmode;
 	struct s3c_fb_pd_win *windata;
 	struct s3c_fb_win *win;
 	struct fb_info *fbinfo;
@@ -763,11 +830,20 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *=
sfb,=20
unsigned int win_no,
 	}
=20
 	windata =3D sfb->pdata->win[win_no];
-	initmode =3D &windata->win_mode;
=20
 	WARN_ON(windata->max_bpp =3D=3D 0);
-	WARN_ON(windata->win_mode.xres =3D=3D 0);
-	WARN_ON(windata->win_mode.yres =3D=3D 0);
+
+	if (sfb->pdata->interface_mode =3D=3D FIMD_VIDEO_MODE) {
+		WARN_ON(windata->win_mode.xres =3D=3D 0);
+		WARN_ON(windata->win_mode.yres =3D=3D 0);
+
+		videomode =3D &windata->win_mode;
+	} else {
+		WARN_ON(windata->cmd_mode.xres =3D=3D 0);
+		WARN_ON(windata->cmd_mode.yres =3D=3D 0);
+
+		cmdmode =3D &windata->cmd_mode;
+	}
=20
 	win =3D fbinfo->par;
 	var =3D &fbinfo->var;
@@ -777,18 +853,24 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *=
sfb,=20
unsigned int win_no,
 	win->index =3D win_no;
 	win->palette_buffer =3D (u32 *)(win + 1);
=20
-	ret =3D s3c_fb_alloc_memory(sfb, win);
-	if (ret) {
-		dev_err(sfb->dev, "failed to allocate display memory\n");
-		return ret;
+	/* setup the initial video or cpu modefrom the window */
+	if (sfb->pdata->interface_mode =3D=3D FIMD_VIDEO_MODE)
+		fb_videomode_to_var(&fbinfo->var, videomode);
+	else {
+		var->xres =3D cmdmode->xres;
+		var->yres =3D cmdmode->yres;
+		var->xres_virtual =3D cmdmode->xres;
+		var->yres_virtual =3D cmdmode->yres;
+		var->xoffset =3D 0;
+		var->yoffset =3D 0;
+		var->pixclock =3D cmdmode->pixclock;
+
+		var->cs_setup =3D cmdmode->cs_setup;
+		var->wr_setup =3D cmdmode->wr_setup;
+		var->wr_act =3D cmdmode->wr_act;
+		var->wr_hold =3D cmdmode->wr_hold;
 	}
=20
-	/* setup the r/b/g positions for the window's palette */
-	s3c_fb_init_palette(win_no, &win->palette);
-
-	/* setup the initial video mode from the window */
-	fb_videomode_to_var(&fbinfo->var, initmode);
-
 	fbinfo->fix.type	=3D FB_TYPE_PACKED_PIXELS;
 	fbinfo->fix.accel	=3D FB_ACCEL_NONE;
 	fbinfo->var.activate	=3D FB_ACTIVATE_NOW;
@@ -798,6 +880,15 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *s=
fb, u
nsigned int win_no,
 	fbinfo->flags		=3D FBINFO_FLAG_DEFAULT;
 	fbinfo->pseudo_palette  =3D &win->pseudo_palette;
=20
+	ret =3D s3c_fb_alloc_memory(sfb, win);
+	if (ret) {
+		dev_err(sfb->dev, "failed to allocate display memory\n");
+		return ret;
+	}
+
+	/* setup the r/b/g positions for the window's palette */
+	s3c_fb_init_palette(win_no, &win->palette);
+
 	/* prepare to actually start the framebuffer */
=20
 	ret =3D s3c_fb_check_var(&fbinfo->var, fbinfo);


--1985284609-453043563-1278430594=:3285--
