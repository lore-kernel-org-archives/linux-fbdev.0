From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Thu, 15 Jul 2010 09:10:36 +0000
Subject: [PATCH 05/10 v2] s3c-fb: Add v4l2 subdevice to support framebuffer
Message-Id: <1279185041-6004-6-git-send-email-s.nawrocki@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
In-Reply-To: <1279185041-6004-1-git-send-email-s.nawrocki@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Selected multimedia devices in Samsung S3C/S5P SoC series are capable of
transferring data directly between each other, bypassing the main system
bus. Such a datapath exists between the camera interface/video
postprocessor and the lcd controller. To control the data flow from the
fimc driver level v4l2-subdevice driver is added to the framebuffer.
It enables to configure the lcd controller into FIFO or DMA input mode.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/plat-samsung/include/plat/fb.h |    6 +
 drivers/video/s3c-fb.c                  |  487 +++++++++++++++++++++++++++++--
 2 files changed, 472 insertions(+), 21 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/fb.h b/arch/arm/plat-samsung/include/plat/fb.h
index cb3ca3a..7dc6110 100644
--- a/arch/arm/plat-samsung/include/plat/fb.h
+++ b/arch/arm/plat-samsung/include/plat/fb.h
@@ -22,6 +22,10 @@
  */
 #define S3C_FB_MAX_WIN	(5)
 
+#define S3C_FB_MAX_WIN_SOURCES	(2)
+
+struct s3c_fifo_link;
+
 /**
  * struct s3c_fb_pd_win - per window setup data
  * @win_mode: The display parameters to initialise (not for window 0)
@@ -35,6 +39,8 @@ struct s3c_fb_pd_win {
 	unsigned short		max_bpp;
 	unsigned short		virtual_x;
 	unsigned short		virtual_y;
+
+	struct s3c_fifo_link	*fifo_sources[S3C_FB_MAX_WIN_SOURCES];
 };
 
 /**
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 8ea974d..5a453cf 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -24,9 +24,14 @@
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
 
+#include <linux/videodev2.h>
+#include <media/v4l2-device.h>
+#include <media/v4l2-subdev.h>
+
 #include <mach/map.h>
 #include <plat/regs-fb-v4.h>
 #include <plat/fb.h>
+#include <plat/fifo.h>
 
 /* This driver will export a number of framebuffer interfaces depending
  * on the configuration passed in via the platform data. Each fb instance
@@ -56,6 +61,18 @@
 #define VSYNC_TIMEOUT_MSEC 50
 
 struct s3c_fb;
+struct s3c_fb_win;
+
+struct s3c_fb_win_sd {
+	struct v4l2_subdev	sd;
+	unsigned int		index;
+	struct s3c_fb_win	*win;
+	struct s3c_fifo_link	*link;
+	struct v4l2_format	fmt;
+	int			streaming;
+	struct v4l2_rect	default_osd_win;
+	struct v4l2_rect	curr_osd_win;
+};
 
 #define VALID_BPP(x) (1 << ((x) - 1))
 
@@ -65,6 +82,9 @@ struct s3c_fb;
 #define VIDOSD_C(win, variant) (OSD_BASE(win, variant) + 0x08)
 #define VIDOSD_D(win, variant) (OSD_BASE(win, variant) + 0x0C)
 
+#define s3c_fb_get_line_count(sfb) \
+	VIDCON1_LINECNT_GET(readl((sfb)->regs + VIDCON1))
+
 /**
  * struct s3c_fb_variant - fb variant information
  * @is_2443: Set if S3C2443/S3C2416 style hardware.
@@ -156,6 +176,9 @@ struct s3c_fb_palette {
  * @pseudo_palette: For use in TRUECOLOUR modes for entries 0..15/
  * @index: The window number of this window.
  * @palette: The bitfields for changing r/g/b into a hardware palette entry.
+ * @sources: The fifo mode data sources for this window
+ * @local_path: The flag indicating the lcd controller input mode:
+ *		0 - local path from other SoC subsystem, 1 - DMA
  */
 struct s3c_fb_win {
 	struct s3c_fb_pd_win	*windata;
@@ -167,6 +190,8 @@ struct s3c_fb_win {
 	u32			*palette_buffer;
 	u32			 pseudo_palette[16];
 	unsigned int		 index;
+	struct s3c_fb_win_sd	*sources[S3C_FB_MAX_WIN_SOURCES];
+	bool			local_path;
 };
 
 /**
@@ -360,13 +385,10 @@ static int s3c_fb_calc_pixclk(struct s3c_fb *sfb, unsigned int pixclk)
  */
 static int s3c_fb_align_word(unsigned int bpp, unsigned int pix)
 {
-	int pix_per_word;
-
 	if (bpp > 16)
 		return pix;
 
-	pix_per_word = (8 * 32) / bpp;
-	return ALIGN(pix, pix_per_word);
+	return ALIGN(pix, (bpp > 8) ? 2 : 4);
 }
 
 /**
@@ -430,6 +452,84 @@ static void shadow_protect_win(struct s3c_fb_win *win, bool protect)
 }
 
 /**
+ * s3c_fb_set_osd() - set position and size of the framebuffer window
+ *
+ * @win: framebuffer window to get data for
+ * @cr: pixel cropping reactangle
+ *
+ * Set framebuffer window position and size. cr rectangle will be modified
+ * if it does not meet the hardware alignment requirements.
+ */
+int s3c_fb_set_osd(struct s3c_fb_win *win, struct v4l2_rect *cr, int bpp)
+{
+	u32 data, width;
+	struct s3c_fb *sfb = win->parent;
+	void __iomem *regs = sfb->regs;
+
+	if (win->index >= S3C_FB_MAX_WIN)
+		return -EINVAL;
+
+	shadow_protect_win(win, 1);
+
+	cr->left = s3c_fb_align_word(bpp, cr->left);
+	data = VIDOSDxA_TOPLEFT_X(cr->left) | VIDOSDxA_TOPLEFT_Y(cr->top);
+	writel(data, regs + VIDOSD_A(win->index, sfb->variant));
+
+	width = s3c_fb_align_word(bpp, cr->width - 1);
+	data = VIDOSDxB_BOTRIGHT_X(cr->left + width)
+	     | VIDOSDxB_BOTRIGHT_Y(cr->top + cr->height - 1);
+	cr->width = ++width;
+
+	writel(data, regs + VIDOSD_B(win->index, sfb->variant));
+
+	data = cr->width * cr->height;
+	vidosd_set_size(win, data);
+
+	shadow_protect_win(win, 0);
+
+	dev_dbg(sfb->dev, "%s(): l:%d t:%d w:%d h:%d", __func__,
+		cr->left, cr->top, cr->width, cr->height);
+
+	return 0;
+}
+
+/**
+ * s3c_fb_gegt_osd() - get position and size of the frame buffer window
+ *
+ * @win: framebuffer window to get data for
+ * @cr: current cropping rectangle
+ */
+int s3c_fb_get_osd(struct s3c_fb_win *win, struct v4l2_rect *cr)
+{
+	u32 reg, ltx, lty;
+	struct s3c_fb *sfb = win->parent;
+	void __iomem *regs = sfb->regs;
+
+	if (!cr || win->index >= S3C_FB_MAX_WIN)
+		return -EINVAL;
+
+	reg = readl(regs + VIDOSD_A(win->index, sfb->variant));
+
+	ltx = (reg >> VIDOSDxA_TOPLEFT_X_SHIFT) & VIDOSDxA_TOPLEFT_X_LIMIT;
+	lty = (reg >> VIDOSDxA_TOPLEFT_Y_SHIFT) & VIDOSDxA_TOPLEFT_Y_LIMIT;
+
+	reg = readl(regs + VIDOSD_B(win->index, sfb->variant));
+
+	cr->width = ((reg >> VIDOSDxB_BOTRIGHT_X_SHIFT)
+		  & VIDOSDxB_BOTRIGHT_X_LIMIT) - ltx + 1;
+
+	cr->height = ((reg >> VIDOSDxB_BOTRIGHT_Y_SHIFT)
+			& VIDOSDxB_BOTRIGHT_Y_LIMIT) - lty + 1;
+	cr->left = ltx;
+	cr->top = lty;
+
+	dev_dbg(sfb->dev, "%s(): l:%d t:%d w:%d h:%d", __func__,
+		cr->left, cr->top, cr->width, cr->height);
+
+	return 0;
+}
+
+/**
  * s3c_fb_set_par() - framebuffer request to set new framebuffer state.
  * @info: The framebuffer to change.
  *
@@ -444,10 +544,14 @@ static int s3c_fb_set_par(struct fb_info *info)
 	void __iomem *buf = regs;
 	int win_no = win->index;
 	u32 alpha = 0;
+	struct v4l2_rect osd_win;
 	u32 data;
 	u32 pagewidth;
 	int clkdiv;
 
+	if (win->local_path)
+		return -EBUSY;
+
 	dev_dbg(sfb->dev, "setting framebuffer parameters\n");
 
 	shadow_protect_win(win, 1);
@@ -517,7 +621,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 
 		data = VIDTCON2_LINEVAL(var->yres - 1) |
 		       VIDTCON2_HOZVAL(var->xres - 1);
-		writel(data, regs +sfb->variant.vidtcon + 8 );
+		writel(data, regs + sfb->variant.vidtcon + 8);
 	}
 
 	/* write the buffer address */
@@ -536,24 +640,17 @@ static int s3c_fb_set_par(struct fb_info *info)
 	writel(data, regs + sfb->variant.buf_size + (win_no * 4));
 
 	/* write 'OSD' registers to control position of framebuffer */
-
-	data = VIDOSDxA_TOPLEFT_X(0) | VIDOSDxA_TOPLEFT_Y(0);
-	writel(data, regs + VIDOSD_A(win_no, sfb->variant));
-
-	data = VIDOSDxB_BOTRIGHT_X(s3c_fb_align_word(var->bits_per_pixel,
-						     var->xres - 1)) |
-	       VIDOSDxB_BOTRIGHT_Y(var->yres - 1);
-
-	writel(data, regs + VIDOSD_B(win_no, sfb->variant));
-
-	data = var->xres * var->yres;
+	osd_win.left = 0;
+	osd_win.top = 0;
+	osd_win.width = var->xres;
+	osd_win.height = var->yres;
+	s3c_fb_set_osd(win, &osd_win, var->bits_per_pixel);
 
 	alpha = VIDISD14C_ALPHA1_R(0xf) |
 		VIDISD14C_ALPHA1_G(0xf) |
 		VIDISD14C_ALPHA1_B(0xf);
 
 	vidosd_set_alpha(win, alpha);
-	vidosd_set_size(win, data);
 
 	data = WINCONx_ENWIN;
 
@@ -714,6 +811,9 @@ static int s3c_fb_setcolreg(unsigned regno,
 	dev_dbg(sfb->dev, "%s: win %d: %d => rgb=%d/%d/%d\n",
 		__func__, win->index, regno, red, green, blue);
 
+	if (win->local_path)
+		return -EBUSY;
+
 	switch (info->fix.visual) {
 	case FB_VISUAL_TRUECOLOR:
 		/* true-colour, use pseudo-palette */
@@ -789,6 +889,9 @@ static int s3c_fb_blank(int blank_mode, struct fb_info *info)
 
 	dev_dbg(sfb->dev, "blank mode %d\n", blank_mode);
 
+	if (win->local_path)
+		return -EBUSY;
+
 	wincon = readl(sfb->regs + sfb->variant.wincon + (index * 4));
 
 	switch (blank_mode) {
@@ -896,6 +999,101 @@ static int s3c_fb_pan_display(struct fb_var_screeninfo *var,
 }
 
 /**
+ * s3c_fb_enable_local() - switch window between input DMA and fifo modes
+ *
+ * @fb_sd: window subdevice for fifo input
+ * @en:    1 - switch from input DMA to fifo mode and apply
+ *	       window size and position set by the window's subdevice
+ *         0 - restore from fifo to DMA mode
+ */
+static int s3c_fb_enable_local_in(struct s3c_fb_win_sd *fb_sd, int en)
+{
+	struct s3c_fb_win *win = fb_sd->win;
+	struct s3c_fb *sfb = win->parent;
+	static u32 wincon;
+	u32 reg, data;
+	int ret = 0, bpp = 32;
+
+	/* disable video output and the window logic */
+	reg = readl(sfb->regs + WINCON(win->index));
+	writel(reg & ~WINCONx_ENWIN, sfb->regs + WINCON(win->index));
+
+	shadow_protect_win(win, 1);
+
+	if (en = 1) {
+		if (fb_sd->streaming)
+			return 0;
+
+		wincon = reg;
+
+		switch (fb_sd->fmt.fmt.pix.pixelformat) {
+		case V4L2_PIX_FMT_YUYV: /* YCbCr 4:4:4 */
+			reg |= WINCONx_YCbCr | WINCONx_ENLOCAL;
+			bpp = 16;
+			break;
+
+		case V4L2_PIX_FMT_RGB24:
+		default:
+			reg &= ~(WINCONx_YCbCr | WINCONx_WSWP | WINCONx_HAWSWP |
+				 WINCONx_BYTSWP | WINCONx_BITSWP |
+				 WINCON0_BPPMODE_MASK | WINCONx_BURSTLEN_MASK);
+
+			reg |=	WINCON0_BPPMODE_24BPP_888 |
+				WINCONx_BURSTLEN_4WORD;
+			bpp = 24;
+			break;
+		}
+
+		fb_sd->streaming = 1;
+		writel(reg, sfb->regs + WINCON(win->index));
+
+		s3c_fb_set_osd(fb_sd->win, &fb_sd->curr_osd_win, bpp);
+
+		writel(reg | WINCONx_ENLOCAL, sfb->regs + WINCON(win->index));
+
+		shadow_protect_win(win, 0);
+
+		reg = readl(sfb->regs + WINCON(win->index));
+		writel(reg | WINCONx_ENWIN, sfb->regs + WINCON(win->index));
+
+		if (sfb->variant.has_shadowcon)	{
+			data = readl(sfb->regs + SHADOWCON);
+			data |=	SHADOWCON_CHx_LOCAL_ENABLE(win->index);
+			writel(data, sfb->regs + SHADOWCON);
+		}
+
+	} else if (en = 0) {
+		if (!fb_sd->streaming)
+			return 0;
+
+		fb_sd->streaming = 0;
+
+		/* need to be aligned with VSYNC interrupt */
+		writel(wincon & ~WINCONx_ENLOCAL,
+		       sfb->regs + WINCON(win->index));
+
+		/* restore OSD values from before we enabled local mode */
+		bpp = win->fbinfo->var.bits_per_pixel;
+		s3c_fb_set_osd(fb_sd->win, &fb_sd->default_osd_win, bpp);
+
+		shadow_protect_win(win, 0);
+
+		if (sfb->variant.has_shadowcon)	{
+			data = readl(sfb->regs + SHADOWCON);
+			data &=	~SHADOWCON_CHx_LOCAL_ENABLE(win->index);
+			writel(data, sfb->regs + SHADOWCON);
+		}
+
+		reg = readl(sfb->regs + WINCON(win->index));
+		writel(reg | WINCONx_ENWIN, sfb->regs + WINCON(win->index));
+	} else {
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+/**
  * s3c_fb_enable_irq() - enable framebuffer interrupts
  * @sfb: main hardware state
  */
@@ -912,7 +1110,7 @@ static void s3c_fb_enable_irq(struct s3c_fb *sfb)
 		irq_ctrl_reg |= VIDINTCON0_INT_FRAME;
 
 		irq_ctrl_reg &= ~VIDINTCON0_FRAMESEL0_MASK;
-		irq_ctrl_reg |= VIDINTCON0_FRAMESEL0_VSYNC;
+		irq_ctrl_reg |= VIDINTCON0_FRAMESEL0_FRONTPORCH;
 		irq_ctrl_reg &= ~VIDINTCON0_FRAMESEL1_MASK;
 		irq_ctrl_reg |= VIDINTCON0_FRAMESEL1_NONE;
 
@@ -952,7 +1150,6 @@ static irqreturn_t s3c_fb_irq(int irq, void *dev_id)
 
 		/* VSYNC interrupt, accept it */
 		writel(VIDINTCON1_INT_FRAME, regs + VIDINTCON1);
-
 		sfb->vsync_info.count++;
 		wake_up_interruptible(&sfb->vsync_info.wait);
 	}
@@ -1089,6 +1286,246 @@ static void s3c_fb_free_memory(struct s3c_fb *sfb, struct s3c_fb_win *win)
 			      fbi->screen_base, fbi->fix.smem_start);
 }
 
+
+static struct s3c_fb_win_sd *to_fb_win_sd(struct v4l2_subdev *s)
+{
+	return container_of(s, struct s3c_fb_win_sd, sd);
+}
+
+/**
+ * v4l2_sd_fb_s_stream() - switch between DMA on local path mode
+ *
+ * @win: window to change operation mode for.
+ * @sd:
+ * @en: 1 - apply cropping rectangle and switch to local path,
+ *	0 - restore cropping rectangle and switch to input DMA mode.
+ */
+static int v4l2_sd_fb_s_stream(struct v4l2_subdev *sd, int en)
+{
+	unsigned long flags;
+	struct s3c_fb_win_sd *w_sd = to_fb_win_sd(sd);
+	struct s3c_fb_win *win = w_sd->win;
+	struct s3c_fb *sfb = win->parent;
+	int ret = 0;
+
+	if (win->index > 2)
+		return -EINVAL;
+
+	mutex_lock(&win->fbinfo->lock);
+
+	if (en = 1) {
+		ret = s3c_fb_enable_local_in(w_sd, en);
+		win->local_path = 1;
+	} else if (en = 0) {
+		/*
+		 * The fmc-frambuffer fifo need to be stopped shortly after
+		 * VSYNC, for this reason horizontal line count is additionally
+		 * examined after waking up by an interrupt. If it is 0 we are
+		 * still at VSYNC and therefore are save to disable fifo.
+		 */
+		ret = s3c_fb_wait_for_vsync(sfb, 0);
+
+		if (ret = -ETIMEDOUT)
+			goto ss_out;
+
+		local_irq_save(flags);
+
+		while (s3c_fb_get_line_count(sfb) != 0)
+			cpu_relax();
+
+		/* Stop FIFO at FIMC side */
+		v4l2_subdev_notify(&w_sd->sd, 0, NULL);
+
+		s3c_fb_enable_local_in(w_sd, 0);
+		local_irq_restore(flags);
+
+		win->local_path = 0;
+		ret = 0;
+	}
+ss_out:
+	mutex_unlock(&win->fbinfo->lock);
+	return ret;
+}
+
+/**
+ * v4l2_sd_fb_s_fmt() - set format for local input path mode
+ *
+ * @sd: pointer to v4l2 subdevice
+ * @fmt: pixel format to set
+ */
+static int v4l2_sd_fb_s_fmt(struct v4l2_subdev *sd, struct v4l2_format *fmt)
+{
+	struct s3c_fb_win_sd *fb_sd = to_fb_win_sd(sd);
+	int fourcc = fmt->fmt.pix.pixelformat;
+
+	if (!fmt || (fourcc != V4L2_PIX_FMT_YUYV
+		&& fourcc != V4L2_PIX_FMT_RGB24))
+		return -EINVAL;
+	fb_sd->fmt.fmt.pix.pixelformat = fmt->fmt.pix.pixelformat;
+	return 0;
+}
+
+/**
+ * v4l2_sd_fb_cropcap() - get cropping capabilities for local fifo input mode
+ *
+ * @sd: pointer to v4l2 subdevice
+ * @cc:
+ */
+static int v4l2_sd_fb_cropcap(struct v4l2_subdev *sd, struct v4l2_cropcap *cc)
+{
+	struct s3c_fb_win *win = to_fb_win_sd(sd)->win;
+	struct s3c_fb_pd_win *windata = win->windata;
+
+	if (!windata)
+		return -ENODEV;
+
+	mutex_lock(&win->fbinfo->lock);
+
+	cc->defrect.width = windata->win_mode.xres;
+	cc->defrect.height = windata->win_mode.yres;
+	cc->defrect.left = 0;
+	cc->defrect.top = 0;
+	cc->bounds = cc->defrect;
+
+	mutex_unlock(&win->fbinfo->lock);
+
+	return 0;
+}
+
+/**
+ * v4l2_sd_fb_s_crop() - set window position and size
+ *
+ * @sd: pointer to v4l2 subdevice
+ * @cr: cropping rectangle to set for local path mode
+ */
+static int v4l2_sd_fb_s_crop(struct v4l2_subdev *sd, struct v4l2_crop *cr)
+{
+	struct v4l2_rect *r;
+	struct s3c_fb_win_sd *fb_sd = to_fb_win_sd(sd);
+	u32 fourcc = fb_sd->fmt.fmt.pix.pixelformat;
+
+	fb_sd->curr_osd_win = cr->c;
+
+	if (fourcc = V4L2_PIX_FMT_YUYV) {
+		r = &cr->c;
+		r->left = round_down(r->left, 8);
+		r->top = round_down(r->top, 8);
+		r->width = round_down(r->width, 8);
+		r->height = round_down(r->height, 8);
+	}
+
+	return 0;
+}
+
+/**
+ * v4l2_sd_fb_g_crop() - set window position and size
+ *
+ * @sd: pointer to v4l2 subdevice
+ * @cr: rectangle to return current cropping parameters to
+ *
+ * Implements g_crop operation for camera interface driver.
+ */
+static int v4l2_sd_fb_g_crop(struct v4l2_subdev *sd, struct v4l2_crop *cr)
+{
+	struct s3c_fb_win_sd *fb_sd = to_fb_win_sd(sd);
+
+	cr->c = fb_sd->curr_osd_win;
+
+	return 0;
+}
+
+
+static struct v4l2_subdev_core_ops v4l2_sd_core_fb_ops = { NULL };
+
+static struct v4l2_subdev_video_ops v4l2_sd_video_fb_ops = {
+	.s_stream = v4l2_sd_fb_s_stream,
+	.s_fmt = v4l2_sd_fb_s_fmt,
+	.cropcap = v4l2_sd_fb_cropcap,
+	.s_crop = v4l2_sd_fb_s_crop,
+	.g_crop = v4l2_sd_fb_g_crop,
+};
+
+static struct v4l2_subdev_ops v4l2_sd_fb_ops = {
+	.core = &v4l2_sd_core_fb_ops,
+	.video = &v4l2_sd_video_fb_ops,
+};
+
+static int s3c_fb_unregister_subdevices(struct s3c_fb_win *win)
+{
+	int i;
+	struct s3c_fb *sfb = win->parent;
+
+	if (win->index >= S3C_FB_MAX_WIN)
+		return -ENODEV;
+
+	for (i = 0; i < S3C_FB_MAX_WIN_SOURCES; i++) {
+		if (win->sources[i]) {
+			/* remove sub_dev pointer from link */
+			win->sources[i]->link->sub_dev = NULL;
+			kfree(win->sources[i]);
+			dev_dbg(sfb->dev,
+				"s3c-fb subdevice %d removed from window %d\n",
+				i, win->index);
+		}
+	}
+
+	return 0;
+}
+
+/* Create the subdevice per each data source of the framebuffer window.
+   Locking: The caller holds win->parent->dev->mutex. */
+static int s3c_fb_register_subdevices(struct s3c_fb_win *win)
+{
+	int i;
+	struct s3c_fb *sfb = win->parent;
+	struct s3c_fb_pd_win *windata = win->windata;
+	struct s3c_fb_win_sd *win_sd;
+	struct v4l2_rect *r;
+
+
+	if (win->index >= S3C_FB_MAX_WIN)
+		return -ENODEV;
+
+	for (i = 0; i < S3C_FB_MAX_WIN_SOURCES; i++) {
+		if (!windata->fifo_sources[i])
+			continue;
+		win_sd = kzalloc(sizeof(struct s3c_fb_win_sd), GFP_KERNEL);
+		if (win_sd = NULL)
+			return -ENOMEM;
+
+		win_sd->index = i;
+		win_sd->win = win;
+		win_sd->link = windata->fifo_sources[i];
+		win_sd->streaming = 0;
+		v4l2_subdev_init(&win_sd->sd, &v4l2_sd_fb_ops);
+		snprintf(win_sd->sd.name, sizeof(win_sd->sd.name),
+			 "s3cfb-local");
+
+		/* hook up pointer to slave device */
+		win_sd->link->sub_dev = &win_sd->sd;
+		win->sources[i] = win_sd;
+
+		/* set default rectangle to current window */
+		s3c_fb_get_osd(win, &win_sd->default_osd_win);
+
+		/* set fimc fifo output rectangle to current window */
+		r = &win_sd->curr_osd_win;
+		r->width = windata->win_mode.xres;
+		r->height = windata->win_mode.yres;
+		r->left = 0;
+		r->top = 0;
+
+		win_sd->fmt.fmt.pix.pixelformat = V4L2_PIX_FMT_RGB24;
+
+		dev_dbg(sfb->dev, "%s(): l:%d t:%d w:%d h:%d",
+			__func__, r->left, r->top, r->width, r->height);
+
+		dev_dbg(sfb->dev, "subdevice %d registered at window %d\n",
+			i, win->index);
+	}
+	return 0;
+}
+
 /**
  * s3c_fb_release_win() - release resources for a framebuffer window.
  * @win: The window to cleanup the resources for.
@@ -1107,6 +1544,7 @@ static void s3c_fb_release_win(struct s3c_fb *sfb, struct s3c_fb_win *win)
 			data &= ~SHADOWCON_CHx_LOCAL_ENABLE(win->index);
 			writel(data, sfb->regs + SHADOWCON);
 		}
+		s3c_fb_unregister_subdevices(win);
 		unregister_framebuffer(win->fbinfo);
 		if (win->fbinfo->cmap.len)
 			fb_dealloc_cmap(&win->fbinfo->cmap);
@@ -1165,6 +1603,7 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	win->windata = windata;
 	win->index = win_no;
 	win->palette_buffer = (u32 *)(win + 1);
+	win->local_path = 0;
 
 	ret = s3c_fb_alloc_memory(sfb, win);
 	if (ret) {
@@ -1220,11 +1659,16 @@ static int __devinit s3c_fb_probe_win(struct s3c_fb *sfb, unsigned int win_no,
 	else
 		dev_err(sfb->dev, "failed to allocate fb cmap\n");
 
+	/* run the check_var and set_par on our configuration. */
 	s3c_fb_set_par(fbinfo);
 
-	dev_dbg(sfb->dev, "about to register framebuffer\n");
+	ret =  s3c_fb_register_subdevices(win);
+	if (ret < 0) {
+		dev_err(sfb->dev, "failed to register s3c-fb subdevices\n");
+		return ret;
+	}
 
-	/* run the check_var and set_par on our configuration. */
+	dev_dbg(sfb->dev, "about to register framebuffer\n");
 
 	ret = register_framebuffer(fbinfo);
 	if (ret < 0) {
@@ -1328,6 +1772,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 		ret = -ENOENT;
 		goto err_ioremap;
 	}
+
 	sfb->irq_no = res->start;
 	ret = request_irq(sfb->irq_no, s3c_fb_irq,
 			  0, "s3c_fb", sfb);
-- 
1.7.0.4

