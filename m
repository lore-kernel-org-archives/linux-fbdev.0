From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: s1d13xxxfb accelerated fillrect with wrong color
Date: Sun, 19 Apr 2009 12:55:52 +0200
Message-ID: <20090419125552.879f7deb.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1LvUeI-0003cE-1A
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 19 Apr 2009 10:53:22 +0000
Received: from mail-fx0-f177.google.com ([209.85.220.177])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LvUe3-0005po-Lg for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 19 Apr 2009 10:53:17 +0000
Received: by fxm25 with SMTP id 25so1576593fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 19 Apr 2009 03:53:05 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, linux-arm <linux-arm-kernel@lists.arm.linux.org.uk>

Greetings,

Working on adding accelerated fillrect and copyarea for the s1d13xxx chips. 
Currently its mostly working aside from an color issue with fillrect. For
example when using mc it always sets the empty space colors into
black while it really should be blue.

Im assuming theres something Im missing about what information
is gotten from rect->color.

Im setting it here (fg = color)
+	/* set foreground color */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_FGC0, (fg && 0xff));
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_FGC1, (fg >> 8) & 0xff);

Best wishes
Kristoffer


Included full patch below just for reference.

diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index 0726aec..6e0c5f7 100644
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -2,6 +2,7 @@
  *
  * (c) 2004 Simtec Electronics
  * (c) 2005 Thibaut VARENE <varenet@parisc-linux.org>
+ * (c) 2009 Kristoffer Ericson <kristoffer.ericson@gmail.com
  *
  * Driver for Epson S1D13xxx series framebuffer chips
  *
@@ -10,17 +11,8 @@
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
  *	 - Probably not SMP safe :)
  *
  * This file is subject to the terms and conditions of the GNU General Public
@@ -37,11 +29,16 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/fb.h>
+#include <linux/spinlock_types.h>
+#include <linux/spinlock.h>
 
 #include <asm/io.h>
 
 #include <video/s1d13xxxfb.h>
 
+#include "fb_draw.h"
+
+
 #define PFX "s1d13xxxfb: "
 
 #if 0
@@ -50,6 +47,17 @@
 #define dbg(fmt, args...) do { } while (0)
 #endif
 
+/* to somewhat limit the output we use this for 
+   bitblit bugtracking */
+
+#if 0
+#define dbg_bitblt(fmt, args...) do {printk(KERN_ERR fmt, ## args); } while(0)
+#else
+#define dbg_bitblt(fmt, args...) do { } while (0)
+#endif
+
+static DEFINE_SPINLOCK(s1d13xxxfb_bitblt_lock);
+
 /*
  * List of card production ids
  */
@@ -390,8 +398,234 @@ s1d13xxxfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 	return 0;
 }
 
-/* framebuffer information structures */
+/*
+ *
+ * waits until register changes INTO bit
+ *
+ */
+u8 bltbit_wait_bitset(struct fb_info *info, u8 bit, int timeout)
+{
+	while (!(s1d13xxxfb_readreg(info->par, S1DREG_BBLT_CTL0) & bit)) {
+		udelay(10);
+		if (!--timeout) {
+			printk(KERN_ERR "s1d13xxxfb_bitblt : wait_bitset timeout\n");
+			break;
+		}
+	}
+
+	return timeout;
+}
+
+/**
+ * bltbit_wait_bitclear - waits for change in register value
+ * @info : frambuffer structure
+ * @bit  : value currently in register
+ * @timeout : ...
+ *
+ * waits until value changes FROM bit
+ *
+ */
+u8 bltbit_wait_bitclear(struct fb_info *info, u8 bit, int timeout)
+{
+	while (s1d13xxxfb_readreg(info->par, S1DREG_BBLT_CTL0) & bit) {
+		udelay(10);
+		if (!--timeout) {
+			printk(KERN_ERR "s1d13xxxfb_bitblt : wait_bitclear timeout\n");
+			break;
+		}
+	}
 
+	return timeout;
+}
+
+/**
+ * bltbit_fifo_status - checks the current status of the fifo
+ * @info : framebuffer structure
+ *
+ * returns number of free words in buffer
+ */
+u8 bltbit_fifo_status(struct fb_info *info)
+{
+	u8 status;
+
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
+//	/* for some reason we can get requests
+//	   that are larger than the actual screen */
+//	if ((sy + height) >= info->var.yres) 
+//	    height = (info->var.yres - area->sy);
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
+		printk(KERN_ERR "s1d13xxxfb_bitblt_copyarea : negative ROP\n");
+		s1d13xxxfb_writereg(info->par, S1DREG_BBLT_OP, 0x03);
+	} else /* positive direction ROP */ {
+		s1d13xxxfb_writereg(info->par, S1DREG_BBLT_OP, 0x02);
+		printk(KERN_ERR "s1d13xxxfb_bitblt_copyarea : positive ROP\n");
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
+	dbg_bitblt("s1d13xxxfb_bitblt_copyarea : dx=%d, dy=%d\n", dx, dy);
+	dbg_bitblt("s1d13xxxfb_bitblt_copyarea : sx=%d, sy=%d\n", sx, sy);
+	dbg_bitblt("s1d13xxxfb_bitblt_copyarea : width=%d, height=%d\n", width - 1, height - 1);
+	dbg_bitblt("s1d13xxxfb_bitblt_copyarea : stride=%d\n", stride);
+	dbg_bitblt("s1d13xxxfb_bitblt_copyarea : bpp=%d=0x0%d, mem_offset1=%d, mem_offset2=%d\n", bpp, (bpp >> 1), (stride >> 1) & 0xff, stride >> 9);
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
+ * @info pointer to fb_info structure
+ * @rect pointer to fb_fillrect structure
+ *
+ * Supported for : 13506, 13806 (and probably more)
+ * Not supported : 13505,
+ *
+ * Accelerated function for fb_fillrect through
+ * bitblt soldfill.
+ *
+ **/
+void s1d13xxxfb_bitblt_solidfill(struct fb_info *info, const struct fb_fillrect *rect)
+{
+	u32 screen_stride, dest;
+	u32 fg, pat;
+	u32 bpp = (info->var.bits_per_pixel >> 3);
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
+	printk(KERN_ERR "s1d13xxxfb_bitblt_solidfill : dx=%d, dy=%d, stride=%d, dest=%d\n"
+	                "s1d13xxxfb_bitblt_solidfill : rect_width=%d, rect_height=%d\n",
+				rect->dx, rect->dy, screen_stride, dest,
+				rect->width - 1, rect->height - 1);
+
+	printk(KERN_ERR "s1d13xxxfb_bitblt_solidfill : xres=%d, yres=%d, bpp=%d\n",
+				info->var.xres, info->var.yres,
+				info->var.bits_per_pixel);
+	printk(KERN_ERR "s1d13xxxfb_bitblt_solidfill : ROP=%d\n", rect->rop);
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
+	/* set foreground color */
+	s1d13xxxfb_writereg(info->par, S1DREG_BBLT_FGC0, (fg && 0xff));
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
+	spin_unlock(&s1d13xxxfb_bitblt_lock);
+}
+
+/* framebuffer information structures */
 static struct fb_ops s1d13xxxfb_fbops = {
 	.owner		= THIS_MODULE,
 	.fb_set_par	= s1d13xxxfb_set_par,
@@ -400,7 +634,7 @@ static struct fb_ops s1d13xxxfb_fbops = {
 
 	.fb_pan_display	= s1d13xxxfb_pan_display,
 
-	/* to be replaced by any acceleration we can */
+	/* gets replaced at chip detection time */
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
@@ -662,10 +896,25 @@ s1d13xxxfb_probe(struct platform_device *pdev)
 	printk(KERN_INFO PFX "regs mapped at 0x%p, fb %d KiB mapped at 0x%p\n",
 	       default_par->regs, info->fix.smem_len / 1024, info->screen_base);
 
+	/* set default and if needed change it */
 	info->par = default_par;
-	info->fbops = &s1d13xxxfb_fbops;
 	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
+	info->fbops = &s1d13xxxfb_fbops;
 
+	/* S1D13506 flags and accels */
+	if (prod_id == S1D13506_PROD_ID) {
+	    info->fbops->fb_fillrect = s1d13xxxfb_bitblt_solidfill;
+	    info->fbops->fb_copyarea = s1d13xxxfb_bitblt_copyarea;
+	    info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN | FBINFO_HWACCEL_FILLRECT | FBINFO_HWACCEL_COPYAREA;
+	}	    
+	
+	/* S1D13806 flags and accels */
+	if (prod_id == S1D13806_PROD_ID) {
+	    info->fbops->fb_fillrect = s1d13xxxfb_bitblt_solidfill;
+	    info->fbops->fb_copyarea = s1d13xxxfb_bitblt_copyarea;
+	    info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN | FBINFO_HWACCEL_FILLRECT | FBINFO_HWACCEL_COPYAREA;
+	}
+	
 	/* perform "manual" chip initialization, if needed */
 	if (pdata && pdata->initregs)
 		s1d13xxxfb_runinit(info->par, pdata->initregs, pdata->initregssize);


-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
