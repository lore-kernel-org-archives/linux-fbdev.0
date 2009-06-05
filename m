From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: patch - bitblt 2D acceleration for s1d13xxxfb
Date: Fri, 5 Jun 2009 19:38:53 +0200
Message-ID: <20090605193853.d235e679.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1MCdI6-0000Ad-37
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 17:33:18 +0000
Received: from mail-fx0-f225.google.com ([209.85.220.225])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MCdI4-00030L-HF for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Jun 2009 17:33:18 +0000
Received: by fxm25 with SMTP id 25so1643108fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 05 Jun 2009 10:33:14 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

Greetings,

Just wanted some feedback since this patch is quite large. Any comments are
appreciated. It patches, compiles and runs like a fox on fire.

This patch:
enables 2D rectfill and copyarea acceleration for 13506, need to look
at hardware sheets before I can say it works on other version but at minimal
13806.

Also some cleans up the code.

Will give a more detailed patchlog once the comments die down :)

diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index 0726aec..49c96d2 100644
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
@@ -31,27 +24,46 @@
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
 
+/**
+ * set this to enable debugging on general functions
+ */
 #if 0
 #define dbg(fmt, args...) do { printk(KERN_INFO fmt, ## args); } while(0)
 #else
 #define dbg(fmt, args...) do { } while (0)
 #endif
 
-/*
- * List of card production ids
+/**
+ * set this to enable debugging on 2D acceleration
+ */
+#if 0
+#define dbg_blit(fmt, args...) do {printk(KERN_INFO BLIT fmt, ## args); } while(0)
+#else
+#define dbg_blit(fmt, args...) do { } while (0)
+#endif
+
+/**
+ * we make sure only one bitblt operation is running
+ */
+static DEFINE_SPINLOCK(s1d13xxxfb_bitblt_lock);
+
+/**
+ * list of card production ids
  */
 static const int s1d13xxxfb_prod_ids[] = {
 	S1D13505_PROD_ID,
@@ -59,7 +71,7 @@ static const int s1d13xxxfb_prod_ids[] = {
 	S1D13806_PROD_ID,
 };
 
-/*
+/**
  * List of card strings
  */
 static const char *s1d13xxxfb_prod_names[] = {
@@ -68,8 +80,8 @@ static const char *s1d13xxxfb_prod_names[] = {
 	"S1D13806",
 };
 
-/*
- * Here we define the default struct fb_fix_screeninfo
+/**
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
@@ -390,8 +404,254 @@ s1d13xxxfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
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
+u8 bltbit_wait_bitset(struct fb_info *info, u8 bit, int timeout)
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
+u8 bltbit_wait_bitclear(struct fb_info *info, u8 bit, int timeout)
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
+u8 bltbit_fifo_status(struct fb_info *info)
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
+void s1d13xxxfb_bitblt_copyarea(struct fb_info *info, const struct fb_copyarea *area)
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
+void s1d13xxxfb_bitblt_solidfill(struct fb_info *info, const struct fb_fillrect *rect)
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
@@ -400,7 +660,7 @@ static struct fb_ops s1d13xxxfb_fbops = {
 
 	.fb_pan_display	= s1d13xxxfb_pan_display,
 
-	/* to be replaced by any acceleration we can */
+	/* gets replaced at chip detection time */
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
@@ -412,9 +672,9 @@ static int s1d13xxxfb_width_tab[2][4] __devinitdata = {
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
@@ -569,7 +829,6 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 	if (pdata && pdata->platform_init_video)
 		pdata->platform_init_video();
 
-
 	if (pdev->num_resources != 2) {
 		dev_err(&pdev->dev, "invalid num_resources: %i\n",
 		       pdev->num_resources);
@@ -655,16 +914,27 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 
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


Best wishes
Kristoffer Ericson

-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

------------------------------------------------------------------------------
OpenSolaris 2009.06 is a cutting edge operating system for enterprises 
looking to deploy the next generation of Solaris that includes the latest 
innovations from Sun and the OpenSource community. Download a copy and 
enjoy capabilities such as Networking, Storage and Virtualization. 
Go to: http://p.sf.net/sfu/opensolaris-get
