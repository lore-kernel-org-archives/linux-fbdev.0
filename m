From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: PATCH - Add accelerated bitblt functions to
	s1d13xxxfb
Date: Sat, 6 Jun 2009 14:10:37 +0200
Message-ID: <20090606141037.7debdb08.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Sat__6_Jun_2009_14_10_37_+0200_Cvtg4LcHeQ2lHWK/"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1MCue2-0005NF-3g
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Jun 2009 12:05:06 +0000
Received: from mail-fx0-f225.google.com ([209.85.220.225])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MCudx-0007z0-BN for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 06 Jun 2009 12:05:06 +0000
Received: by fxm25 with SMTP id 25so1999763fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 06 Jun 2009 05:04:59 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--Multipart=_Sat__6_Jun_2009_14_10_37_+0200_Cvtg4LcHeQ2lHWK/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This patch adds accelerated bitblt functions to s1d13xxx based 
video chipsets, more specificly functions copyarea and fillrect. 
It has only been tested and activated for 13506 chipsets
but is expected to work for the majority of s1d13xxx based chips.
This patch also cleans up the driver with respect of whitespaces
and other formatting issues. We update the current status
comments.

Signed-off-by: Kristoffer Ericson <kristoffer.ericson@gmail.com>

diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index 0726aec..a2a893f 100644
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -2,6 +2,7 @@
  *
  * (c) 2004 Simtec Electronics
  * (c) 2005 Thibaut VARENE <varenet@parisc-linux.org>
+ * (c) 2009 Kristoffer Ericson <kristoffer.ericson@gmail.com>
  *
  * Driver for Epson S1D13xxx series framebuffer chips
  *
@@ -10,18 +11,10 @@
  *  linux/drivers/video/epson1355fb.c
  *  linux/drivers/video/epson/s1d13xxxfb.c (2.4 driver by Epson)
  *
- * Note, currently only tested on S1D13806 with 16bit CRT.
- * As such, this driver might still contain some hardcoded bits relating to
- * S1D13806.
- * Making it work on other S1D13XXX chips should merely be a matter of adding
- * a few switch()s, some missing glue here and there maybe, and split header
- * files.
- *
  * TODO: - handle dual screen display (CRT and LCD at the same time).
  *	 - check_var(), mode change, etc.
- *	 - PM untested.
- *	 - Accelerated interfaces.
- *	 - Probably not SMP safe :)
+ *	 - probably not SMP safe :)
+ *       - support all bitblt operations on all cards
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License. See the file COPYING in the main directory of this archive for
@@ -31,19 +24,24 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
-
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/fb.h>
+#include <linux/spinlock_types.h>
+#include <linux/spinlock.h>
 
 #include <asm/io.h>
 
 #include <video/s1d13xxxfb.h>
 
-#define PFX "s1d13xxxfb: "
+#define PFX	"s1d13xxxfb: "
+#define BLIT	"s1d13xxxfb_bitblt: "
 
+/*
+ * set this to enable debugging on general functions
+ */
 #if 0
 #define dbg(fmt, args...) do { printk(KERN_INFO fmt, ## args); } while(0)
 #else
@@ -51,7 +49,21 @@
 #endif
 
 /*
- * List of card production ids
+ * set this to enable debugging on 2D acceleration
+ */
+#if 0
+#define dbg_blit(fmt, args...) do {printk(KERN_INFO BLIT fmt, ## args); } while(0)
+#else
+#define dbg_blit(fmt, args...) do { } while (0)
+#endif
+
+/*
+ * we make sure only one bitblt operation is running
+ */
+static DEFINE_SPINLOCK(s1d13xxxfb_bitblt_lock);
+
+/*
+ * list of card production ids
  */
 static const int s1d13xxxfb_prod_ids[] = {
 	S1D13505_PROD_ID,
@@ -69,7 +81,7 @@ static const char *s1d13xxxfb_prod_names[] = {
 };
 
 /*
- * Here we define the default struct fb_fix_screeninfo
+ * here we define the default struct fb_fix_screeninfo
  */
 static struct fb_fix_screeninfo __devinitdata s1d13xxxfb_fix = {
 	.id		= S1D_FBID,
@@ -145,8 +157,10 @@ crt_enable(struct s1d13xxxfb_par *par, int enable)
 	s1d13xxxfb_writereg(par, S1DREG_COM_DISP_MODE, mode);
 }
 
-/* framebuffer control routines */
 
+/*************************************************************
+ framebuffer control functions
+ *************************************************************/
 static inline void
 s1d13xxxfb_setup_pseudocolour(struct fb_info *info)
 {
@@ -242,13 +256,13 @@ s1d13xxxfb_set_par(struct fb_info *info)
 }
 
 /**
- *  	s1d13xxxfb_setcolreg - sets a color register.
- *      @regno: Which register in the CLUT we are programming
- *      @red: The red value which can be up to 16 bits wide
+ *	s1d13xxxfb_setcolreg - sets a color register.
+ *	@regno: Which register in the CLUT we are programming
+ *	@red: The red value which can be up to 16 bits wide
  *	@green: The green value which can be up to 16 bits wide
  *	@blue:  The blue value which can be up to 16 bits wide.
  *	@transp: If supported the alpha value which can be up to 16 bits wide.
- *      @info: frame buffer info structure
+ *	@info: frame buffer info structure
  *
  *	Returns negative errno on error, or zero on success.
  */
@@ -351,15 +365,15 @@ s1d13xxxfb_blank(int blank_mode, struct fb_info *info)
 }
 
 /**
- *      s1d13xxxfb_pan_display - Pans the display.
- *      @var: frame buffer variable screen structure
- *      @info: frame buffer structure that represents a single frame buffer
+ *	s1d13xxxfb_pan_display - Pans the display.
+ *	@var: frame buffer variable screen structure
+ *	@info: frame buffer structure that represents a single frame buffer
  *
  *	Pan (or wrap, depending on the `vmode' field) the display using the
- *  	`yoffset' field of the `var' structure (`xoffset'  not yet supported).
- *  	If the values don't fit, return -EINVAL.
+ *	`yoffset' field of the `var' structure (`xoffset'  not yet supported).
+ *	If the values don't fit, return -EINVAL.
  *
- *      Returns negative errno on error, or zero on success.
+ *	Returns negative errno on error, or zero on success.
  */
 static int
 s1d13xxxfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
@@ -390,8 +404,259 @@ s1d13xxxfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 	return 0;
 }
 
-/* framebuffer information structures */
+/************************************************************
+ functions to handle bitblt acceleration
+ ************************************************************/
+
+/**
+ *	bltbit_wait_bitset - waits for change in register value
+ *	@info : framebuffer structure
+ *	@bit  : value expected in register
+ *	@timeout : ...
+ *
+ *	waits until value changes INTO bit
+ */
+static u8
+bltbit_wait_bitset(struct fb_info *info, u8 bit, int timeout)
+{
+	while (!(s1d13xxxfb_readreg(info->par, S1DREG_BBLT_CTL0) & bit)) {
+		udelay(10);
+		if (!--timeout) {
+			dbg_blit("wait_bitset timeout\n");
+			break;
+		}
+	}
+
+	return timeout;
+}
+
+/**
+ *	bltbit_wait_bitclear - waits for change in register value
+ *	@info : frambuffer structure
+ *	@bit  : value currently in register
+ *	@timeout : ...
+ *
+ *	waits until value changes FROM bit
+ *
+ */
+static u8
+bltbit_wait_bitclear(struct fb_info *info, u8 bit, int timeout)
+{
+	while (s1d13xxxfb_readreg(info->par, S1DREG_BBLT_CTL0) & bit) {
+		udelay(10);
+		if (!--timeout) {
+			dbg_blit("wait_bitclear timeout\n");
+			break;
+		}
+	}
+
+	return timeout;
+}
+
+/**
+ *	bltbit_fifo_status - checks the current status of the fifo
+ *	@info : framebuffer structure
+ *
+ *	returns number of free words in buffer
+ */
+static u8
+bltbit_fifo_status(struct fb_info *info)
+{
+	u8 status;
 
+	status = s1d13xxxfb_readreg(info->par, S1DREG_BBLT_CTL0);
+
+	/* its empty so room for 16 words */
+	if (status & BBLT_FIFO_EMPTY)
+		return 16;
+
+	/* its full so we dont want to add */
+	if (status & BBLT_FIFO_FULL)
+		return 0;
+
+	/* its atleast half full but we can add one atleast */
+	if (status & BBLT_FIFO_NOT_FULL)
+		return 1;
+
+	return 0;
+}
+
+/*
+ *	s1d13xxxfb_bitblt_copyarea - accelerated copyarea function
+ *	@info : framebuffer structure
+ *	@area : fb_copyarea structure
+ *
+ *	supports (atleast) S1D13506
+ *
+ */
+static void
+s1d13xxxfb_bitblt_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+{
+	u32 dst, src;
+	u32 stride;
+	u16 reverse = 0;
+	u16 sx = area->sx, sy = area->sy;
+	u16 dx = area->dx, dy = area->dy;
+	u16 width = area->width, height = area->height;
+	u16 bpp;
+
+	spin_lock(&s1d13xxxfb_bitblt_lock);
+
+	/* bytes per xres line */
+	bpp = (info->var.bits_per_pixel >> 3);
+	stride = bpp * info->var.xres;
+
+	/* reverse, calculate the last pixel in rectangle */
+	if ((dy > sy) || ((dy == sy) && (dx >= sx))) {
+		dst = (((dy + height - 1) * stride) + (bpp * (dx + width - 1)));
+		src = (((sy + height - 1) * stride) + (bpp * (sx + width - 1)));
+		reverse = 1;
+	/* not reverse, calculate the first pixel in rectangle */
+	} else { /* (y * xres) + (bpp * x) */
+		dst = (dy * stride) + (bpp * dx);
+		src = (sy * stride) + (bpp * sx);
+	}
+
+	/* set source adress */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_SRC_START0, (src & 0xff));
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_SRC_START1, (src >> 8) & 0x00ff);
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_SRC_START2, (src >> 16) & 0x00ff);
+
+	/* set destination adress */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_DST_START0, (dst & 0xff));
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_DST_START1, (dst >> 8) & 0x00ff);
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_DST_START2, (dst >> 16) & 0x00ff);
+
+	/* program height and width */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_WIDTH0, (width & 0xff) - 1);
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_WIDTH1, (width >> 8));
+
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_HEIGHT0, (height & 0xff) - 1);
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_HEIGHT1, (height >> 8));
+
+	/* negative direction ROP */
+	if (reverse == 1) {
+		dbg_blit("(copyarea) negative rop\n");
+		s1d13xxxfb_writereg(info->par, S1DREG_BBLT_OP, 0x03);
+	} else /* positive direction ROP */ {
+		s1d13xxxfb_writereg(info->par, S1DREG_BBLT_OP, 0x02);
+		dbg_blit("(copyarea) positive rop\n");
+	}
+
+	/* set for rectangel mode and not linear */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_CTL0, 0x0);
+
+	/* setup the bpp 1 = 16bpp, 0 = 8bpp*/
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_CTL1, (bpp >> 1));
+
+	/* set words per xres */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_MEM_OFF0, (stride >> 1) & 0xff);
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_MEM_OFF1, (stride >> 9));
+
+	dbg_blit("(copyarea) dx=%d, dy=%d\n", dx, dy);
+	dbg_blit("(copyarea) sx=%d, sy=%d\n", sx, sy);
+	dbg_blit("(copyarea) width=%d, height=%d\n", width - 1, height - 1);
+	dbg_blit("(copyarea) stride=%d\n", stride);
+	dbg_blit("(copyarea) bpp=%d=0x0%d, mem_offset1=%d, mem_offset2=%d\n", bpp, (bpp >> 1),
+		(stride >> 1) & 0xff, stride >> 9);
+
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_CC_EXP, 0x0c);
+
+	/* initialize the engine */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_CTL0, 0x80);
+
+	/* wait to complete */
+	bltbit_wait_bitclear(info, 0x80, 8000);
+
+	spin_unlock(&s1d13xxxfb_bitblt_lock);
+}
+
+/**
+ *
+ *	s1d13xxxfb_bitblt_solidfill - accelerated solidfill function
+ *	@info : framebuffer structure
+ *	@rect : fb_fillrect structure
+ *
+ *	supports (atleast 13506)
+ *
+ **/
+static void
+s1d13xxxfb_bitblt_solidfill(struct fb_info *info, const struct fb_fillrect *rect)
+{
+	u32 screen_stride, dest;
+	u32 fg;
+	u16 bpp = (info->var.bits_per_pixel >> 3);
+
+	/* grab spinlock */
+	spin_lock(&s1d13xxxfb_bitblt_lock);
+
+	/* bytes per x width */
+	screen_stride = (bpp * info->var.xres);
+
+	/* bytes to starting point */
+	dest = ((rect->dy * screen_stride) + (bpp * rect->dx));
+
+	dbg_blit("(solidfill) dx=%d, dy=%d, stride=%d, dest=%d\n"
+		 "(solidfill) : rect_width=%d, rect_height=%d\n",
+				rect->dx, rect->dy, screen_stride, dest,
+				rect->width - 1, rect->height - 1);
+
+	dbg_blit("(solidfill) : xres=%d, yres=%d, bpp=%d\n",
+				info->var.xres, info->var.yres,
+				info->var.bits_per_pixel);
+	dbg_blit("(solidfill) : rop=%d\n", rect->rop);
+
+	/* We split the destination into the three registers */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_DST_START0, (dest & 0x00ff));
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_DST_START1, ((dest >> 8) & 0x00ff));
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_DST_START2, ((dest >> 16) & 0x00ff));
+
+	/* give information regarding rectangel width */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_WIDTH0, ((rect->width) & 0x00ff) - 1);
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_WIDTH1, (rect->width >> 8));
+
+	/* give information regarding rectangel height */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_HEIGHT0, ((rect->height) & 0x00ff) - 1);
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_HEIGHT1, (rect->height >> 8));
+
+	if (info->fix.visual == FB_VISUAL_TRUECOLOR ||
+		info->fix.visual == FB_VISUAL_DIRECTCOLOR) {
+		fg = ((u32 *)info->pseudo_palette)[rect->color];
+		dbg_blit("(solidfill) truecolor/directcolor\n");
+		dbg_blit("(solidfill) pseudo_palette[%d] = %d\n", rect->color, fg);
+	} else {
+		fg = rect->color;
+		dbg_blit("(solidfill) color = %d\n", rect->color);
+	}
+
+	/* set foreground color */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_FGC0, (fg & 0xff));
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_FGC1, (fg >> 8) & 0xff);
+
+	/* set rectangual region of memory (rectangle and not linear) */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_CTL0, 0x0);
+
+	/* set operation mode SOLID_FILL */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_OP, BBLT_SOLID_FILL);
+
+	/* set bits per pixel (1 = 16bpp, 0 = 8bpp) */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_CTL1, (info->var.bits_per_pixel >> 4));
+
+	/* set the memory offset for the bblt in word sizes */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_MEM_OFF0, (screen_stride >> 1) & 0x00ff);
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_MEM_OFF1, (screen_stride >> 9));
+
+	/* and away we go.... */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_CTL0, 0x80);
+
+	/* wait until its done */
+	bltbit_wait_bitclear(info, 0x80, 8000);
+
+	/* let others play */
+	spin_unlock(&s1d13xxxfb_bitblt_lock);
+}
+
+/* framebuffer information structures */
 static struct fb_ops s1d13xxxfb_fbops = {
 	.owner		= THIS_MODULE,
 	.fb_set_par	= s1d13xxxfb_set_par,
@@ -400,7 +665,7 @@ static struct fb_ops s1d13xxxfb_fbops = {
 
 	.fb_pan_display	= s1d13xxxfb_pan_display,
 
-	/* to be replaced by any acceleration we can */
+	/* gets replaced at chip detection time */
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
@@ -412,9 +677,9 @@ static int s1d13xxxfb_width_tab[2][4] __devinitdata = {
 };
 
 /**
- *      s1d13xxxfb_fetch_hw_state - Configure the framebuffer according to
+ *	s1d13xxxfb_fetch_hw_state - Configure the framebuffer according to
  *	hardware setup.
- *      @info: frame buffer structure
+ *	@info: frame buffer structure
  *
  *	We setup the framebuffer structures according to the current
  *	hardware setup. On some machines, the BIOS will have filled
@@ -569,7 +834,6 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 	if (pdata && pdata->platform_init_video)
 		pdata->platform_init_video();
 
-
 	if (pdev->num_resources != 2) {
 		dev_err(&pdev->dev, "invalid num_resources: %i\n",
 		       pdev->num_resources);
@@ -655,16 +919,27 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 
 	info->fix = s1d13xxxfb_fix;
 	info->fix.mmio_start = pdev->resource[1].start;
-	info->fix.mmio_len = pdev->resource[1].end - pdev->resource[1].start +1;
+	info->fix.mmio_len = pdev->resource[1].end - pdev->resource[1].start + 1;
 	info->fix.smem_start = pdev->resource[0].start;
-	info->fix.smem_len = pdev->resource[0].end - pdev->resource[0].start +1;
+	info->fix.smem_len = pdev->resource[0].end - pdev->resource[0].start + 1;
 
 	printk(KERN_INFO PFX "regs mapped at 0x%p, fb %d KiB mapped at 0x%p\n",
 	       default_par->regs, info->fix.smem_len / 1024, info->screen_base);
 
 	info->par = default_par;
-	info->fbops = &s1d13xxxfb_fbops;
 	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	info->fbops = &s1d13xxxfb_fbops;
+
+	switch(prod_id) {
+	    case S1D13506_PROD_ID : /* activate acceleration */
+		s1d13xxxfb_fbops.fb_fillrect = s1d13xxxfb_bitblt_solidfill;
+		s1d13xxxfb_fbops.fb_copyarea = s1d13xxxfb_bitblt_copyarea;
+		info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
+			FBINFO_HWACCEL_FILLRECT | FBINFO_HWACCEL_COPYAREA;
+		break;
+	    default :
+		break;
+	}
 
 	/* perform "manual" chip initialization, if needed */
 	if (pdata && pdata->initregs)



-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Multipart=_Sat__6_Jun_2009_14_10_37_+0200_Cvtg4LcHeQ2lHWK/
Content-Type: application/octet-stream;
 name="s1d13xxxfb.patch"
Content-Disposition: attachment;
 filename="s1d13xxxfb.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vczFkMTN4eHhmYi5jIGIvZHJpdmVycy92aWRlby9z
MWQxM3h4eGZiLmMKaW5kZXggMDcyNmFlYy4uYTJhODkzZiAxMDA2NDQKLS0tIGEvZHJpdmVycy92
aWRlby9zMWQxM3h4eGZiLmMKKysrIGIvZHJpdmVycy92aWRlby9zMWQxM3h4eGZiLmMKQEAgLTIs
NiArMiw3IEBACiAgKgogICogKGMpIDIwMDQgU2ltdGVjIEVsZWN0cm9uaWNzCiAgKiAoYykgMjAw
NSBUaGliYXV0IFZBUkVORSA8dmFyZW5ldEBwYXJpc2MtbGludXgub3JnPgorICogKGMpIDIwMDkg
S3Jpc3RvZmZlciBFcmljc29uIDxrcmlzdG9mZmVyLmVyaWNzb25AZ21haWwuY29tPgogICoKICAq
IERyaXZlciBmb3IgRXBzb24gUzFEMTN4eHggc2VyaWVzIGZyYW1lYnVmZmVyIGNoaXBzCiAgKgpA
QCAtMTAsMTggKzExLDEwIEBACiAgKiAgbGludXgvZHJpdmVycy92aWRlby9lcHNvbjEzNTVmYi5j
CiAgKiAgbGludXgvZHJpdmVycy92aWRlby9lcHNvbi9zMWQxM3h4eGZiLmMgKDIuNCBkcml2ZXIg
YnkgRXBzb24pCiAgKgotICogTm90ZSwgY3VycmVudGx5IG9ubHkgdGVzdGVkIG9uIFMxRDEzODA2
IHdpdGggMTZiaXQgQ1JULgotICogQXMgc3VjaCwgdGhpcyBkcml2ZXIgbWlnaHQgc3RpbGwgY29u
dGFpbiBzb21lIGhhcmRjb2RlZCBiaXRzIHJlbGF0aW5nIHRvCi0gKiBTMUQxMzgwNi4KLSAqIE1h
a2luZyBpdCB3b3JrIG9uIG90aGVyIFMxRDEzWFhYIGNoaXBzIHNob3VsZCBtZXJlbHkgYmUgYSBt
YXR0ZXIgb2YgYWRkaW5nCi0gKiBhIGZldyBzd2l0Y2goKXMsIHNvbWUgbWlzc2luZyBnbHVlIGhl
cmUgYW5kIHRoZXJlIG1heWJlLCBhbmQgc3BsaXQgaGVhZGVyCi0gKiBmaWxlcy4KLSAqCiAgKiBU
T0RPOiAtIGhhbmRsZSBkdWFsIHNjcmVlbiBkaXNwbGF5IChDUlQgYW5kIExDRCBhdCB0aGUgc2Ft
ZSB0aW1lKS4KICAqCSAtIGNoZWNrX3ZhcigpLCBtb2RlIGNoYW5nZSwgZXRjLgotICoJIC0gUE0g
dW50ZXN0ZWQuCi0gKgkgLSBBY2NlbGVyYXRlZCBpbnRlcmZhY2VzLgotICoJIC0gUHJvYmFibHkg
bm90IFNNUCBzYWZlIDopCisgKgkgLSBwcm9iYWJseSBub3QgU01QIHNhZmUgOikKKyAqICAgICAg
IC0gc3VwcG9ydCBhbGwgYml0Ymx0IG9wZXJhdGlvbnMgb24gYWxsIGNhcmRzCiAgKgogICogVGhp
cyBmaWxlIGlzIHN1YmplY3QgdG8gdGhlIHRlcm1zIGFuZCBjb25kaXRpb25zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMKICAqIExpY2Vuc2UuIFNlZSB0aGUgZmlsZSBDT1BZSU5HIGluIHRoZSBt
YWluIGRpcmVjdG9yeSBvZiB0aGlzIGFyY2hpdmUgZm9yCkBAIC0zMSwxOSArMjQsMjQgQEAKICNp
bmNsdWRlIDxsaW51eC9tb2R1bGUuaD4KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4KICNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgotCiAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4K
ICNpbmNsdWRlIDxsaW51eC9lcnJuby5oPgogI2luY2x1ZGUgPGxpbnV4L21tLmg+CiAjaW5jbHVk
ZSA8bGludXgvbW1hbi5oPgogI2luY2x1ZGUgPGxpbnV4L2ZiLmg+CisjaW5jbHVkZSA8bGludXgv
c3BpbmxvY2tfdHlwZXMuaD4KKyNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPgogCiAjaW5jbHVk
ZSA8YXNtL2lvLmg+CiAKICNpbmNsdWRlIDx2aWRlby9zMWQxM3h4eGZiLmg+CiAKLSNkZWZpbmUg
UEZYICJzMWQxM3h4eGZiOiAiCisjZGVmaW5lIFBGWAkiczFkMTN4eHhmYjogIgorI2RlZmluZSBC
TElUCSJzMWQxM3h4eGZiX2JpdGJsdDogIgogCisvKgorICogc2V0IHRoaXMgdG8gZW5hYmxlIGRl
YnVnZ2luZyBvbiBnZW5lcmFsIGZ1bmN0aW9ucworICovCiAjaWYgMAogI2RlZmluZSBkYmcoZm10
LCBhcmdzLi4uKSBkbyB7IHByaW50ayhLRVJOX0lORk8gZm10LCAjIyBhcmdzKTsgfSB3aGlsZSgw
KQogI2Vsc2UKQEAgLTUxLDcgKzQ5LDIxIEBACiAjZW5kaWYKIAogLyoKLSAqIExpc3Qgb2YgY2Fy
ZCBwcm9kdWN0aW9uIGlkcworICogc2V0IHRoaXMgdG8gZW5hYmxlIGRlYnVnZ2luZyBvbiAyRCBh
Y2NlbGVyYXRpb24KKyAqLworI2lmIDAKKyNkZWZpbmUgZGJnX2JsaXQoZm10LCBhcmdzLi4uKSBk
byB7cHJpbnRrKEtFUk5fSU5GTyBCTElUIGZtdCwgIyMgYXJncyk7IH0gd2hpbGUoMCkKKyNlbHNl
CisjZGVmaW5lIGRiZ19ibGl0KGZtdCwgYXJncy4uLikgZG8geyB9IHdoaWxlICgwKQorI2VuZGlm
CisKKy8qCisgKiB3ZSBtYWtlIHN1cmUgb25seSBvbmUgYml0Ymx0IG9wZXJhdGlvbiBpcyBydW5u
aW5nCisgKi8KK3N0YXRpYyBERUZJTkVfU1BJTkxPQ0soczFkMTN4eHhmYl9iaXRibHRfbG9jayk7
CisKKy8qCisgKiBsaXN0IG9mIGNhcmQgcHJvZHVjdGlvbiBpZHMKICAqLwogc3RhdGljIGNvbnN0
IGludCBzMWQxM3h4eGZiX3Byb2RfaWRzW10gPSB7CiAJUzFEMTM1MDVfUFJPRF9JRCwKQEAgLTY5
LDcgKzgxLDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKnMxZDEzeHh4ZmJfcHJvZF9uYW1lc1tdID0g
ewogfTsKIAogLyoKLSAqIEhlcmUgd2UgZGVmaW5lIHRoZSBkZWZhdWx0IHN0cnVjdCBmYl9maXhf
c2NyZWVuaW5mbworICogaGVyZSB3ZSBkZWZpbmUgdGhlIGRlZmF1bHQgc3RydWN0IGZiX2ZpeF9z
Y3JlZW5pbmZvCiAgKi8KIHN0YXRpYyBzdHJ1Y3QgZmJfZml4X3NjcmVlbmluZm8gX19kZXZpbml0
ZGF0YSBzMWQxM3h4eGZiX2ZpeCA9IHsKIAkuaWQJCT0gUzFEX0ZCSUQsCkBAIC0xNDUsOCArMTU3
LDEwIEBAIGNydF9lbmFibGUoc3RydWN0IHMxZDEzeHh4ZmJfcGFyICpwYXIsIGludCBlbmFibGUp
CiAJczFkMTN4eHhmYl93cml0ZXJlZyhwYXIsIFMxRFJFR19DT01fRElTUF9NT0RFLCBtb2RlKTsK
IH0KIAotLyogZnJhbWVidWZmZXIgY29udHJvbCByb3V0aW5lcyAqLwogCisvKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgorIGZyYW1l
YnVmZmVyIGNvbnRyb2wgZnVuY3Rpb25zCisgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKi8KIHN0YXRpYyBpbmxpbmUgdm9pZAogczFk
MTN4eHhmYl9zZXR1cF9wc2V1ZG9jb2xvdXIoc3RydWN0IGZiX2luZm8gKmluZm8pCiB7CkBAIC0y
NDIsMTMgKzI1NiwxMyBAQCBzMWQxM3h4eGZiX3NldF9wYXIoc3RydWN0IGZiX2luZm8gKmluZm8p
CiB9CiAKIC8qKgotICogIAlzMWQxM3h4eGZiX3NldGNvbHJlZyAtIHNldHMgYSBjb2xvciByZWdp
c3Rlci4KLSAqICAgICAgQHJlZ25vOiBXaGljaCByZWdpc3RlciBpbiB0aGUgQ0xVVCB3ZSBhcmUg
cHJvZ3JhbW1pbmcKLSAqICAgICAgQHJlZDogVGhlIHJlZCB2YWx1ZSB3aGljaCBjYW4gYmUgdXAg
dG8gMTYgYml0cyB3aWRlCisgKglzMWQxM3h4eGZiX3NldGNvbHJlZyAtIHNldHMgYSBjb2xvciBy
ZWdpc3Rlci4KKyAqCUByZWdubzogV2hpY2ggcmVnaXN0ZXIgaW4gdGhlIENMVVQgd2UgYXJlIHBy
b2dyYW1taW5nCisgKglAcmVkOiBUaGUgcmVkIHZhbHVlIHdoaWNoIGNhbiBiZSB1cCB0byAxNiBi
aXRzIHdpZGUKICAqCUBncmVlbjogVGhlIGdyZWVuIHZhbHVlIHdoaWNoIGNhbiBiZSB1cCB0byAx
NiBiaXRzIHdpZGUKICAqCUBibHVlOiAgVGhlIGJsdWUgdmFsdWUgd2hpY2ggY2FuIGJlIHVwIHRv
IDE2IGJpdHMgd2lkZS4KICAqCUB0cmFuc3A6IElmIHN1cHBvcnRlZCB0aGUgYWxwaGEgdmFsdWUg
d2hpY2ggY2FuIGJlIHVwIHRvIDE2IGJpdHMgd2lkZS4KLSAqICAgICAgQGluZm86IGZyYW1lIGJ1
ZmZlciBpbmZvIHN0cnVjdHVyZQorICoJQGluZm86IGZyYW1lIGJ1ZmZlciBpbmZvIHN0cnVjdHVy
ZQogICoKICAqCVJldHVybnMgbmVnYXRpdmUgZXJybm8gb24gZXJyb3IsIG9yIHplcm8gb24gc3Vj
Y2Vzcy4KICAqLwpAQCAtMzUxLDE1ICszNjUsMTUgQEAgczFkMTN4eHhmYl9ibGFuayhpbnQgYmxh
bmtfbW9kZSwgc3RydWN0IGZiX2luZm8gKmluZm8pCiB9CiAKIC8qKgotICogICAgICBzMWQxM3h4
eGZiX3Bhbl9kaXNwbGF5IC0gUGFucyB0aGUgZGlzcGxheS4KLSAqICAgICAgQHZhcjogZnJhbWUg
YnVmZmVyIHZhcmlhYmxlIHNjcmVlbiBzdHJ1Y3R1cmUKLSAqICAgICAgQGluZm86IGZyYW1lIGJ1
ZmZlciBzdHJ1Y3R1cmUgdGhhdCByZXByZXNlbnRzIGEgc2luZ2xlIGZyYW1lIGJ1ZmZlcgorICoJ
czFkMTN4eHhmYl9wYW5fZGlzcGxheSAtIFBhbnMgdGhlIGRpc3BsYXkuCisgKglAdmFyOiBmcmFt
ZSBidWZmZXIgdmFyaWFibGUgc2NyZWVuIHN0cnVjdHVyZQorICoJQGluZm86IGZyYW1lIGJ1ZmZl
ciBzdHJ1Y3R1cmUgdGhhdCByZXByZXNlbnRzIGEgc2luZ2xlIGZyYW1lIGJ1ZmZlcgogICoKICAq
CVBhbiAob3Igd3JhcCwgZGVwZW5kaW5nIG9uIHRoZSBgdm1vZGUnIGZpZWxkKSB0aGUgZGlzcGxh
eSB1c2luZyB0aGUKLSAqICAJYHlvZmZzZXQnIGZpZWxkIG9mIHRoZSBgdmFyJyBzdHJ1Y3R1cmUg
KGB4b2Zmc2V0JyAgbm90IHlldCBzdXBwb3J0ZWQpLgotICogIAlJZiB0aGUgdmFsdWVzIGRvbid0
IGZpdCwgcmV0dXJuIC1FSU5WQUwuCisgKglgeW9mZnNldCcgZmllbGQgb2YgdGhlIGB2YXInIHN0
cnVjdHVyZSAoYHhvZmZzZXQnICBub3QgeWV0IHN1cHBvcnRlZCkuCisgKglJZiB0aGUgdmFsdWVz
IGRvbid0IGZpdCwgcmV0dXJuIC1FSU5WQUwuCiAgKgotICogICAgICBSZXR1cm5zIG5lZ2F0aXZl
IGVycm5vIG9uIGVycm9yLCBvciB6ZXJvIG9uIHN1Y2Nlc3MuCisgKglSZXR1cm5zIG5lZ2F0aXZl
IGVycm5vIG9uIGVycm9yLCBvciB6ZXJvIG9uIHN1Y2Nlc3MuCiAgKi8KIHN0YXRpYyBpbnQKIHMx
ZDEzeHh4ZmJfcGFuX2Rpc3BsYXkoc3RydWN0IGZiX3Zhcl9zY3JlZW5pbmZvICp2YXIsIHN0cnVj
dCBmYl9pbmZvICppbmZvKQpAQCAtMzkwLDggKzQwNCwyNTkgQEAgczFkMTN4eHhmYl9wYW5fZGlz
cGxheShzdHJ1Y3QgZmJfdmFyX3NjcmVlbmluZm8gKnZhciwgc3RydWN0IGZiX2luZm8gKmluZm8p
CiAJcmV0dXJuIDA7CiB9CiAKLS8qIGZyYW1lYnVmZmVyIGluZm9ybWF0aW9uIHN0cnVjdHVyZXMg
Ki8KKy8qKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioKKyBmdW5jdGlvbnMgdG8gaGFuZGxlIGJpdGJsdCBhY2NlbGVyYXRpb24KKyAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiov
CisKKy8qKgorICoJYmx0Yml0X3dhaXRfYml0c2V0IC0gd2FpdHMgZm9yIGNoYW5nZSBpbiByZWdp
c3RlciB2YWx1ZQorICoJQGluZm8gOiBmcmFtZWJ1ZmZlciBzdHJ1Y3R1cmUKKyAqCUBiaXQgIDog
dmFsdWUgZXhwZWN0ZWQgaW4gcmVnaXN0ZXIKKyAqCUB0aW1lb3V0IDogLi4uCisgKgorICoJd2Fp
dHMgdW50aWwgdmFsdWUgY2hhbmdlcyBJTlRPIGJpdAorICovCitzdGF0aWMgdTgKK2JsdGJpdF93
YWl0X2JpdHNldChzdHJ1Y3QgZmJfaW5mbyAqaW5mbywgdTggYml0LCBpbnQgdGltZW91dCkKK3sK
Kwl3aGlsZSAoIShzMWQxM3h4eGZiX3JlYWRyZWcoaW5mby0+cGFyLCBTMURSRUdfQkJMVF9DVEww
KSAmIGJpdCkpIHsKKwkJdWRlbGF5KDEwKTsKKwkJaWYgKCEtLXRpbWVvdXQpIHsKKwkJCWRiZ19i
bGl0KCJ3YWl0X2JpdHNldCB0aW1lb3V0XG4iKTsKKwkJCWJyZWFrOworCQl9CisJfQorCisJcmV0
dXJuIHRpbWVvdXQ7Cit9CisKKy8qKgorICoJYmx0Yml0X3dhaXRfYml0Y2xlYXIgLSB3YWl0cyBm
b3IgY2hhbmdlIGluIHJlZ2lzdGVyIHZhbHVlCisgKglAaW5mbyA6IGZyYW1idWZmZXIgc3RydWN0
dXJlCisgKglAYml0ICA6IHZhbHVlIGN1cnJlbnRseSBpbiByZWdpc3RlcgorICoJQHRpbWVvdXQg
OiAuLi4KKyAqCisgKgl3YWl0cyB1bnRpbCB2YWx1ZSBjaGFuZ2VzIEZST00gYml0CisgKgorICov
CitzdGF0aWMgdTgKK2JsdGJpdF93YWl0X2JpdGNsZWFyKHN0cnVjdCBmYl9pbmZvICppbmZvLCB1
OCBiaXQsIGludCB0aW1lb3V0KQoreworCXdoaWxlIChzMWQxM3h4eGZiX3JlYWRyZWcoaW5mby0+
cGFyLCBTMURSRUdfQkJMVF9DVEwwKSAmIGJpdCkgeworCQl1ZGVsYXkoMTApOworCQlpZiAoIS0t
dGltZW91dCkgeworCQkJZGJnX2JsaXQoIndhaXRfYml0Y2xlYXIgdGltZW91dFxuIik7CisJCQli
cmVhazsKKwkJfQorCX0KKworCXJldHVybiB0aW1lb3V0OworfQorCisvKioKKyAqCWJsdGJpdF9m
aWZvX3N0YXR1cyAtIGNoZWNrcyB0aGUgY3VycmVudCBzdGF0dXMgb2YgdGhlIGZpZm8KKyAqCUBp
bmZvIDogZnJhbWVidWZmZXIgc3RydWN0dXJlCisgKgorICoJcmV0dXJucyBudW1iZXIgb2YgZnJl
ZSB3b3JkcyBpbiBidWZmZXIKKyAqLworc3RhdGljIHU4CitibHRiaXRfZmlmb19zdGF0dXMoc3Ry
dWN0IGZiX2luZm8gKmluZm8pCit7CisJdTggc3RhdHVzOwogCisJc3RhdHVzID0gczFkMTN4eHhm
Yl9yZWFkcmVnKGluZm8tPnBhciwgUzFEUkVHX0JCTFRfQ1RMMCk7CisKKwkvKiBpdHMgZW1wdHkg
c28gcm9vbSBmb3IgMTYgd29yZHMgKi8KKwlpZiAoc3RhdHVzICYgQkJMVF9GSUZPX0VNUFRZKQor
CQlyZXR1cm4gMTY7CisKKwkvKiBpdHMgZnVsbCBzbyB3ZSBkb250IHdhbnQgdG8gYWRkICovCisJ
aWYgKHN0YXR1cyAmIEJCTFRfRklGT19GVUxMKQorCQlyZXR1cm4gMDsKKworCS8qIGl0cyBhdGxl
YXN0IGhhbGYgZnVsbCBidXQgd2UgY2FuIGFkZCBvbmUgYXRsZWFzdCAqLworCWlmIChzdGF0dXMg
JiBCQkxUX0ZJRk9fTk9UX0ZVTEwpCisJCXJldHVybiAxOworCisJcmV0dXJuIDA7Cit9CisKKy8q
CisgKglzMWQxM3h4eGZiX2JpdGJsdF9jb3B5YXJlYSAtIGFjY2VsZXJhdGVkIGNvcHlhcmVhIGZ1
bmN0aW9uCisgKglAaW5mbyA6IGZyYW1lYnVmZmVyIHN0cnVjdHVyZQorICoJQGFyZWEgOiBmYl9j
b3B5YXJlYSBzdHJ1Y3R1cmUKKyAqCisgKglzdXBwb3J0cyAoYXRsZWFzdCkgUzFEMTM1MDYKKyAq
CisgKi8KK3N0YXRpYyB2b2lkCitzMWQxM3h4eGZiX2JpdGJsdF9jb3B5YXJlYShzdHJ1Y3QgZmJf
aW5mbyAqaW5mbywgY29uc3Qgc3RydWN0IGZiX2NvcHlhcmVhICphcmVhKQoreworCXUzMiBkc3Qs
IHNyYzsKKwl1MzIgc3RyaWRlOworCXUxNiByZXZlcnNlID0gMDsKKwl1MTYgc3ggPSBhcmVhLT5z
eCwgc3kgPSBhcmVhLT5zeTsKKwl1MTYgZHggPSBhcmVhLT5keCwgZHkgPSBhcmVhLT5keTsKKwl1
MTYgd2lkdGggPSBhcmVhLT53aWR0aCwgaGVpZ2h0ID0gYXJlYS0+aGVpZ2h0OworCXUxNiBicHA7
CisKKwlzcGluX2xvY2soJnMxZDEzeHh4ZmJfYml0Ymx0X2xvY2spOworCisJLyogYnl0ZXMgcGVy
IHhyZXMgbGluZSAqLworCWJwcCA9IChpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwgPj4gMyk7CisJ
c3RyaWRlID0gYnBwICogaW5mby0+dmFyLnhyZXM7CisKKwkvKiByZXZlcnNlLCBjYWxjdWxhdGUg
dGhlIGxhc3QgcGl4ZWwgaW4gcmVjdGFuZ2xlICovCisJaWYgKChkeSA+IHN5KSB8fCAoKGR5ID09
IHN5KSAmJiAoZHggPj0gc3gpKSkgeworCQlkc3QgPSAoKChkeSArIGhlaWdodCAtIDEpICogc3Ry
aWRlKSArIChicHAgKiAoZHggKyB3aWR0aCAtIDEpKSk7CisJCXNyYyA9ICgoKHN5ICsgaGVpZ2h0
IC0gMSkgKiBzdHJpZGUpICsgKGJwcCAqIChzeCArIHdpZHRoIC0gMSkpKTsKKwkJcmV2ZXJzZSA9
IDE7CisJLyogbm90IHJldmVyc2UsIGNhbGN1bGF0ZSB0aGUgZmlyc3QgcGl4ZWwgaW4gcmVjdGFu
Z2xlICovCisJfSBlbHNlIHsgLyogKHkgKiB4cmVzKSArIChicHAgKiB4KSAqLworCQlkc3QgPSAo
ZHkgKiBzdHJpZGUpICsgKGJwcCAqIGR4KTsKKwkJc3JjID0gKHN5ICogc3RyaWRlKSArIChicHAg
KiBzeCk7CisJfQorCisJLyogc2V0IHNvdXJjZSBhZHJlc3MgKi8KKwlzMWQxM3h4eGZiX3dyaXRl
cmVnKGluZm8tPnBhciwgUzFEUkVHX0JCTFRfU1JDX1NUQVJUMCwgKHNyYyAmIDB4ZmYpKTsKKwlz
MWQxM3h4eGZiX3dyaXRlcmVnKGluZm8tPnBhciwgUzFEUkVHX0JCTFRfU1JDX1NUQVJUMSwgKHNy
YyA+PiA4KSAmIDB4MDBmZik7CisJczFkMTN4eHhmYl93cml0ZXJlZyhpbmZvLT5wYXIsIFMxRFJF
R19CQkxUX1NSQ19TVEFSVDIsIChzcmMgPj4gMTYpICYgMHgwMGZmKTsKKworCS8qIHNldCBkZXN0
aW5hdGlvbiBhZHJlc3MgKi8KKwlzMWQxM3h4eGZiX3dyaXRlcmVnKGluZm8tPnBhciwgUzFEUkVH
X0JCTFRfRFNUX1NUQVJUMCwgKGRzdCAmIDB4ZmYpKTsKKwlzMWQxM3h4eGZiX3dyaXRlcmVnKGlu
Zm8tPnBhciwgUzFEUkVHX0JCTFRfRFNUX1NUQVJUMSwgKGRzdCA+PiA4KSAmIDB4MDBmZik7CisJ
czFkMTN4eHhmYl93cml0ZXJlZyhpbmZvLT5wYXIsIFMxRFJFR19CQkxUX0RTVF9TVEFSVDIsIChk
c3QgPj4gMTYpICYgMHgwMGZmKTsKKworCS8qIHByb2dyYW0gaGVpZ2h0IGFuZCB3aWR0aCAqLwor
CXMxZDEzeHh4ZmJfd3JpdGVyZWcoaW5mby0+cGFyLCBTMURSRUdfQkJMVF9XSURUSDAsICh3aWR0
aCAmIDB4ZmYpIC0gMSk7CisJczFkMTN4eHhmYl93cml0ZXJlZyhpbmZvLT5wYXIsIFMxRFJFR19C
QkxUX1dJRFRIMSwgKHdpZHRoID4+IDgpKTsKKworCXMxZDEzeHh4ZmJfd3JpdGVyZWcoaW5mby0+
cGFyLCBTMURSRUdfQkJMVF9IRUlHSFQwLCAoaGVpZ2h0ICYgMHhmZikgLSAxKTsKKwlzMWQxM3h4
eGZiX3dyaXRlcmVnKGluZm8tPnBhciwgUzFEUkVHX0JCTFRfSEVJR0hUMSwgKGhlaWdodCA+PiA4
KSk7CisKKwkvKiBuZWdhdGl2ZSBkaXJlY3Rpb24gUk9QICovCisJaWYgKHJldmVyc2UgPT0gMSkg
eworCQlkYmdfYmxpdCgiKGNvcHlhcmVhKSBuZWdhdGl2ZSByb3BcbiIpOworCQlzMWQxM3h4eGZi
X3dyaXRlcmVnKGluZm8tPnBhciwgUzFEUkVHX0JCTFRfT1AsIDB4MDMpOworCX0gZWxzZSAvKiBw
b3NpdGl2ZSBkaXJlY3Rpb24gUk9QICovIHsKKwkJczFkMTN4eHhmYl93cml0ZXJlZyhpbmZvLT5w
YXIsIFMxRFJFR19CQkxUX09QLCAweDAyKTsKKwkJZGJnX2JsaXQoIihjb3B5YXJlYSkgcG9zaXRp
dmUgcm9wXG4iKTsKKwl9CisKKwkvKiBzZXQgZm9yIHJlY3RhbmdlbCBtb2RlIGFuZCBub3QgbGlu
ZWFyICovCisJczFkMTN4eHhmYl93cml0ZXJlZyhpbmZvLT5wYXIsIFMxRFJFR19CQkxUX0NUTDAs
IDB4MCk7CisKKwkvKiBzZXR1cCB0aGUgYnBwIDEgPSAxNmJwcCwgMCA9IDhicHAqLworCXMxZDEz
eHh4ZmJfd3JpdGVyZWcoaW5mby0+cGFyLCBTMURSRUdfQkJMVF9DVEwxLCAoYnBwID4+IDEpKTsK
KworCS8qIHNldCB3b3JkcyBwZXIgeHJlcyAqLworCXMxZDEzeHh4ZmJfd3JpdGVyZWcoaW5mby0+
cGFyLCBTMURSRUdfQkJMVF9NRU1fT0ZGMCwgKHN0cmlkZSA+PiAxKSAmIDB4ZmYpOworCXMxZDEz
eHh4ZmJfd3JpdGVyZWcoaW5mby0+cGFyLCBTMURSRUdfQkJMVF9NRU1fT0ZGMSwgKHN0cmlkZSA+
PiA5KSk7CisKKwlkYmdfYmxpdCgiKGNvcHlhcmVhKSBkeD0lZCwgZHk9JWRcbiIsIGR4LCBkeSk7
CisJZGJnX2JsaXQoIihjb3B5YXJlYSkgc3g9JWQsIHN5PSVkXG4iLCBzeCwgc3kpOworCWRiZ19i
bGl0KCIoY29weWFyZWEpIHdpZHRoPSVkLCBoZWlnaHQ9JWRcbiIsIHdpZHRoIC0gMSwgaGVpZ2h0
IC0gMSk7CisJZGJnX2JsaXQoIihjb3B5YXJlYSkgc3RyaWRlPSVkXG4iLCBzdHJpZGUpOworCWRi
Z19ibGl0KCIoY29weWFyZWEpIGJwcD0lZD0weDAlZCwgbWVtX29mZnNldDE9JWQsIG1lbV9vZmZz
ZXQyPSVkXG4iLCBicHAsIChicHAgPj4gMSksCisJCShzdHJpZGUgPj4gMSkgJiAweGZmLCBzdHJp
ZGUgPj4gOSk7CisKKwlzMWQxM3h4eGZiX3dyaXRlcmVnKGluZm8tPnBhciwgUzFEUkVHX0JCTFRf
Q0NfRVhQLCAweDBjKTsKKworCS8qIGluaXRpYWxpemUgdGhlIGVuZ2luZSAqLworCXMxZDEzeHh4
ZmJfd3JpdGVyZWcoaW5mby0+cGFyLCBTMURSRUdfQkJMVF9DVEwwLCAweDgwKTsKKworCS8qIHdh
aXQgdG8gY29tcGxldGUgKi8KKwlibHRiaXRfd2FpdF9iaXRjbGVhcihpbmZvLCAweDgwLCA4MDAw
KTsKKworCXNwaW5fdW5sb2NrKCZzMWQxM3h4eGZiX2JpdGJsdF9sb2NrKTsKK30KKworLyoqCisg
KgorICoJczFkMTN4eHhmYl9iaXRibHRfc29saWRmaWxsIC0gYWNjZWxlcmF0ZWQgc29saWRmaWxs
IGZ1bmN0aW9uCisgKglAaW5mbyA6IGZyYW1lYnVmZmVyIHN0cnVjdHVyZQorICoJQHJlY3QgOiBm
Yl9maWxscmVjdCBzdHJ1Y3R1cmUKKyAqCisgKglzdXBwb3J0cyAoYXRsZWFzdCAxMzUwNikKKyAq
CisgKiovCitzdGF0aWMgdm9pZAorczFkMTN4eHhmYl9iaXRibHRfc29saWRmaWxsKHN0cnVjdCBm
Yl9pbmZvICppbmZvLCBjb25zdCBzdHJ1Y3QgZmJfZmlsbHJlY3QgKnJlY3QpCit7CisJdTMyIHNj
cmVlbl9zdHJpZGUsIGRlc3Q7CisJdTMyIGZnOworCXUxNiBicHAgPSAoaW5mby0+dmFyLmJpdHNf
cGVyX3BpeGVsID4+IDMpOworCisJLyogZ3JhYiBzcGlubG9jayAqLworCXNwaW5fbG9jaygmczFk
MTN4eHhmYl9iaXRibHRfbG9jayk7CisKKwkvKiBieXRlcyBwZXIgeCB3aWR0aCAqLworCXNjcmVl
bl9zdHJpZGUgPSAoYnBwICogaW5mby0+dmFyLnhyZXMpOworCisJLyogYnl0ZXMgdG8gc3RhcnRp
bmcgcG9pbnQgKi8KKwlkZXN0ID0gKChyZWN0LT5keSAqIHNjcmVlbl9zdHJpZGUpICsgKGJwcCAq
IHJlY3QtPmR4KSk7CisKKwlkYmdfYmxpdCgiKHNvbGlkZmlsbCkgZHg9JWQsIGR5PSVkLCBzdHJp
ZGU9JWQsIGRlc3Q9JWRcbiIKKwkJICIoc29saWRmaWxsKSA6IHJlY3Rfd2lkdGg9JWQsIHJlY3Rf
aGVpZ2h0PSVkXG4iLAorCQkJCXJlY3QtPmR4LCByZWN0LT5keSwgc2NyZWVuX3N0cmlkZSwgZGVz
dCwKKwkJCQlyZWN0LT53aWR0aCAtIDEsIHJlY3QtPmhlaWdodCAtIDEpOworCisJZGJnX2JsaXQo
Iihzb2xpZGZpbGwpIDogeHJlcz0lZCwgeXJlcz0lZCwgYnBwPSVkXG4iLAorCQkJCWluZm8tPnZh
ci54cmVzLCBpbmZvLT52YXIueXJlcywKKwkJCQlpbmZvLT52YXIuYml0c19wZXJfcGl4ZWwpOwor
CWRiZ19ibGl0KCIoc29saWRmaWxsKSA6IHJvcD0lZFxuIiwgcmVjdC0+cm9wKTsKKworCS8qIFdl
IHNwbGl0IHRoZSBkZXN0aW5hdGlvbiBpbnRvIHRoZSB0aHJlZSByZWdpc3RlcnMgKi8KKwlzMWQx
M3h4eGZiX3dyaXRlcmVnKGluZm8tPnBhciwgUzFEUkVHX0JCTFRfRFNUX1NUQVJUMCwgKGRlc3Qg
JiAweDAwZmYpKTsKKwlzMWQxM3h4eGZiX3dyaXRlcmVnKGluZm8tPnBhciwgUzFEUkVHX0JCTFRf
RFNUX1NUQVJUMSwgKChkZXN0ID4+IDgpICYgMHgwMGZmKSk7CisJczFkMTN4eHhmYl93cml0ZXJl
ZyhpbmZvLT5wYXIsIFMxRFJFR19CQkxUX0RTVF9TVEFSVDIsICgoZGVzdCA+PiAxNikgJiAweDAw
ZmYpKTsKKworCS8qIGdpdmUgaW5mb3JtYXRpb24gcmVnYXJkaW5nIHJlY3RhbmdlbCB3aWR0aCAq
LworCXMxZDEzeHh4ZmJfd3JpdGVyZWcoaW5mby0+cGFyLCBTMURSRUdfQkJMVF9XSURUSDAsICgo
cmVjdC0+d2lkdGgpICYgMHgwMGZmKSAtIDEpOworCXMxZDEzeHh4ZmJfd3JpdGVyZWcoaW5mby0+
cGFyLCBTMURSRUdfQkJMVF9XSURUSDEsIChyZWN0LT53aWR0aCA+PiA4KSk7CisKKwkvKiBnaXZl
IGluZm9ybWF0aW9uIHJlZ2FyZGluZyByZWN0YW5nZWwgaGVpZ2h0ICovCisJczFkMTN4eHhmYl93
cml0ZXJlZyhpbmZvLT5wYXIsIFMxRFJFR19CQkxUX0hFSUdIVDAsICgocmVjdC0+aGVpZ2h0KSAm
IDB4MDBmZikgLSAxKTsKKwlzMWQxM3h4eGZiX3dyaXRlcmVnKGluZm8tPnBhciwgUzFEUkVHX0JC
TFRfSEVJR0hUMSwgKHJlY3QtPmhlaWdodCA+PiA4KSk7CisKKwlpZiAoaW5mby0+Zml4LnZpc3Vh
bCA9PSBGQl9WSVNVQUxfVFJVRUNPTE9SIHx8CisJCWluZm8tPmZpeC52aXN1YWwgPT0gRkJfVklT
VUFMX0RJUkVDVENPTE9SKSB7CisJCWZnID0gKCh1MzIgKilpbmZvLT5wc2V1ZG9fcGFsZXR0ZSlb
cmVjdC0+Y29sb3JdOworCQlkYmdfYmxpdCgiKHNvbGlkZmlsbCkgdHJ1ZWNvbG9yL2RpcmVjdGNv
bG9yXG4iKTsKKwkJZGJnX2JsaXQoIihzb2xpZGZpbGwpIHBzZXVkb19wYWxldHRlWyVkXSA9ICVk
XG4iLCByZWN0LT5jb2xvciwgZmcpOworCX0gZWxzZSB7CisJCWZnID0gcmVjdC0+Y29sb3I7CisJ
CWRiZ19ibGl0KCIoc29saWRmaWxsKSBjb2xvciA9ICVkXG4iLCByZWN0LT5jb2xvcik7CisJfQor
CisJLyogc2V0IGZvcmVncm91bmQgY29sb3IgKi8KKwlzMWQxM3h4eGZiX3dyaXRlcmVnKGluZm8t
PnBhciwgUzFEUkVHX0JCTFRfRkdDMCwgKGZnICYgMHhmZikpOworCXMxZDEzeHh4ZmJfd3JpdGVy
ZWcoaW5mby0+cGFyLCBTMURSRUdfQkJMVF9GR0MxLCAoZmcgPj4gOCkgJiAweGZmKTsKKworCS8q
IHNldCByZWN0YW5ndWFsIHJlZ2lvbiBvZiBtZW1vcnkgKHJlY3RhbmdsZSBhbmQgbm90IGxpbmVh
cikgKi8KKwlzMWQxM3h4eGZiX3dyaXRlcmVnKGluZm8tPnBhciwgUzFEUkVHX0JCTFRfQ1RMMCwg
MHgwKTsKKworCS8qIHNldCBvcGVyYXRpb24gbW9kZSBTT0xJRF9GSUxMICovCisJczFkMTN4eHhm
Yl93cml0ZXJlZyhpbmZvLT5wYXIsIFMxRFJFR19CQkxUX09QLCBCQkxUX1NPTElEX0ZJTEwpOwor
CisJLyogc2V0IGJpdHMgcGVyIHBpeGVsICgxID0gMTZicHAsIDAgPSA4YnBwKSAqLworCXMxZDEz
eHh4ZmJfd3JpdGVyZWcoaW5mby0+cGFyLCBTMURSRUdfQkJMVF9DVEwxLCAoaW5mby0+dmFyLmJp
dHNfcGVyX3BpeGVsID4+IDQpKTsKKworCS8qIHNldCB0aGUgbWVtb3J5IG9mZnNldCBmb3IgdGhl
IGJibHQgaW4gd29yZCBzaXplcyAqLworCXMxZDEzeHh4ZmJfd3JpdGVyZWcoaW5mby0+cGFyLCBT
MURSRUdfQkJMVF9NRU1fT0ZGMCwgKHNjcmVlbl9zdHJpZGUgPj4gMSkgJiAweDAwZmYpOworCXMx
ZDEzeHh4ZmJfd3JpdGVyZWcoaW5mby0+cGFyLCBTMURSRUdfQkJMVF9NRU1fT0ZGMSwgKHNjcmVl
bl9zdHJpZGUgPj4gOSkpOworCisJLyogYW5kIGF3YXkgd2UgZ28uLi4uICovCisJczFkMTN4eHhm
Yl93cml0ZXJlZyhpbmZvLT5wYXIsIFMxRFJFR19CQkxUX0NUTDAsIDB4ODApOworCisJLyogd2Fp
dCB1bnRpbCBpdHMgZG9uZSAqLworCWJsdGJpdF93YWl0X2JpdGNsZWFyKGluZm8sIDB4ODAsIDgw
MDApOworCisJLyogbGV0IG90aGVycyBwbGF5ICovCisJc3Bpbl91bmxvY2soJnMxZDEzeHh4ZmJf
Yml0Ymx0X2xvY2spOworfQorCisvKiBmcmFtZWJ1ZmZlciBpbmZvcm1hdGlvbiBzdHJ1Y3R1cmVz
ICovCiBzdGF0aWMgc3RydWN0IGZiX29wcyBzMWQxM3h4eGZiX2Zib3BzID0gewogCS5vd25lcgkJ
PSBUSElTX01PRFVMRSwKIAkuZmJfc2V0X3Bhcgk9IHMxZDEzeHh4ZmJfc2V0X3BhciwKQEAgLTQw
MCw3ICs2NjUsNyBAQCBzdGF0aWMgc3RydWN0IGZiX29wcyBzMWQxM3h4eGZiX2Zib3BzID0gewog
CiAJLmZiX3Bhbl9kaXNwbGF5CT0gczFkMTN4eHhmYl9wYW5fZGlzcGxheSwKIAotCS8qIHRvIGJl
IHJlcGxhY2VkIGJ5IGFueSBhY2NlbGVyYXRpb24gd2UgY2FuICovCisJLyogZ2V0cyByZXBsYWNl
ZCBhdCBjaGlwIGRldGVjdGlvbiB0aW1lICovCiAJLmZiX2ZpbGxyZWN0CT0gY2ZiX2ZpbGxyZWN0
LAogCS5mYl9jb3B5YXJlYQk9IGNmYl9jb3B5YXJlYSwKIAkuZmJfaW1hZ2VibGl0CT0gY2ZiX2lt
YWdlYmxpdCwKQEAgLTQxMiw5ICs2NzcsOSBAQCBzdGF0aWMgaW50IHMxZDEzeHh4ZmJfd2lkdGhf
dGFiWzJdWzRdIF9fZGV2aW5pdGRhdGEgPSB7CiB9OwogCiAvKioKLSAqICAgICAgczFkMTN4eHhm
Yl9mZXRjaF9od19zdGF0ZSAtIENvbmZpZ3VyZSB0aGUgZnJhbWVidWZmZXIgYWNjb3JkaW5nIHRv
CisgKglzMWQxM3h4eGZiX2ZldGNoX2h3X3N0YXRlIC0gQ29uZmlndXJlIHRoZSBmcmFtZWJ1ZmZl
ciBhY2NvcmRpbmcgdG8KICAqCWhhcmR3YXJlIHNldHVwLgotICogICAgICBAaW5mbzogZnJhbWUg
YnVmZmVyIHN0cnVjdHVyZQorICoJQGluZm86IGZyYW1lIGJ1ZmZlciBzdHJ1Y3R1cmUKICAqCiAg
KglXZSBzZXR1cCB0aGUgZnJhbWVidWZmZXIgc3RydWN0dXJlcyBhY2NvcmRpbmcgdG8gdGhlIGN1
cnJlbnQKICAqCWhhcmR3YXJlIHNldHVwLiBPbiBzb21lIG1hY2hpbmVzLCB0aGUgQklPUyB3aWxs
IGhhdmUgZmlsbGVkCkBAIC01NjksNyArODM0LDYgQEAgczFkMTN4eHhmYl9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCWlmIChwZGF0YSAmJiBwZGF0YS0+cGxhdGZvcm1faW5p
dF92aWRlbykKIAkJcGRhdGEtPnBsYXRmb3JtX2luaXRfdmlkZW8oKTsKIAotCiAJaWYgKHBkZXYt
Pm51bV9yZXNvdXJjZXMgIT0gMikgewogCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJpbnZhbGlkIG51
bV9yZXNvdXJjZXM6ICVpXG4iLAogCQkgICAgICAgcGRldi0+bnVtX3Jlc291cmNlcyk7CkBAIC02
NTUsMTYgKzkxOSwyNyBAQCBzMWQxM3h4eGZiX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCiAKIAlpbmZvLT5maXggPSBzMWQxM3h4eGZiX2ZpeDsKIAlpbmZvLT5maXgubW1pb19z
dGFydCA9IHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0OwotCWluZm8tPmZpeC5tbWlvX2xlbiA9IHBk
ZXYtPnJlc291cmNlWzFdLmVuZCAtIHBkZXYtPnJlc291cmNlWzFdLnN0YXJ0ICsxOworCWluZm8t
PmZpeC5tbWlvX2xlbiA9IHBkZXYtPnJlc291cmNlWzFdLmVuZCAtIHBkZXYtPnJlc291cmNlWzFd
LnN0YXJ0ICsgMTsKIAlpbmZvLT5maXguc21lbV9zdGFydCA9IHBkZXYtPnJlc291cmNlWzBdLnN0
YXJ0OwotCWluZm8tPmZpeC5zbWVtX2xlbiA9IHBkZXYtPnJlc291cmNlWzBdLmVuZCAtIHBkZXYt
PnJlc291cmNlWzBdLnN0YXJ0ICsxOworCWluZm8tPmZpeC5zbWVtX2xlbiA9IHBkZXYtPnJlc291
cmNlWzBdLmVuZCAtIHBkZXYtPnJlc291cmNlWzBdLnN0YXJ0ICsgMTsKIAogCXByaW50ayhLRVJO
X0lORk8gUEZYICJyZWdzIG1hcHBlZCBhdCAweCVwLCBmYiAlZCBLaUIgbWFwcGVkIGF0IDB4JXBc
biIsCiAJICAgICAgIGRlZmF1bHRfcGFyLT5yZWdzLCBpbmZvLT5maXguc21lbV9sZW4gLyAxMDI0
LCBpbmZvLT5zY3JlZW5fYmFzZSk7CiAKIAlpbmZvLT5wYXIgPSBkZWZhdWx0X3BhcjsKLQlpbmZv
LT5mYm9wcyA9ICZzMWQxM3h4eGZiX2Zib3BzOwogCWluZm8tPmZsYWdzID0gRkJJTkZPX0RFRkFV
TFQgfCBGQklORk9fSFdBQ0NFTF9ZUEFOOworCWluZm8tPmZib3BzID0gJnMxZDEzeHh4ZmJfZmJv
cHM7CisKKwlzd2l0Y2gocHJvZF9pZCkgeworCSAgICBjYXNlIFMxRDEzNTA2X1BST0RfSUQgOiAv
KiBhY3RpdmF0ZSBhY2NlbGVyYXRpb24gKi8KKwkJczFkMTN4eHhmYl9mYm9wcy5mYl9maWxscmVj
dCA9IHMxZDEzeHh4ZmJfYml0Ymx0X3NvbGlkZmlsbDsKKwkJczFkMTN4eHhmYl9mYm9wcy5mYl9j
b3B5YXJlYSA9IHMxZDEzeHh4ZmJfYml0Ymx0X2NvcHlhcmVhOworCQlpbmZvLT5mbGFncyA9IEZC
SU5GT19ERUZBVUxUIHwgRkJJTkZPX0hXQUNDRUxfWVBBTiB8CisJCQlGQklORk9fSFdBQ0NFTF9G
SUxMUkVDVCB8IEZCSU5GT19IV0FDQ0VMX0NPUFlBUkVBOworCQlicmVhazsKKwkgICAgZGVmYXVs
dCA6CisJCWJyZWFrOworCX0KIAogCS8qIHBlcmZvcm0gIm1hbnVhbCIgY2hpcCBpbml0aWFsaXph
dGlvbiwgaWYgbmVlZGVkICovCiAJaWYgKHBkYXRhICYmIHBkYXRhLT5pbml0cmVncykK

--Multipart=_Sat__6_Jun_2009_14_10_37_+0200_Cvtg4LcHeQ2lHWK/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
--Multipart=_Sat__6_Jun_2009_14_10_37_+0200_Cvtg4LcHeQ2lHWK/
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--Multipart=_Sat__6_Jun_2009_14_10_37_+0200_Cvtg4LcHeQ2lHWK/--
