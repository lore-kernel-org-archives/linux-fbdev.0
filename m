From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/1] New Framebuffer for Intel based
	Macs [try #2] (fwd)
Date: Thu, 22 Jun 2006 10:38:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY=------------090309060503080300020709
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FtKiE-0007fx-Gf for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 01:38:54 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FtKiD-0001sq-Lz
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 01:38:54 -0700
Content-ID: <Pine.LNX.4.62.0606221038281.23155@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: Edgar Hucek <hostmaster@ed-soft.at>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--------------090309060503080300020709
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.62.0606221038282.23155@pademelon.sonytel.be>

---------- Forwarded message ----------
Date: Wed, 21 Jun 2006 14:40:24 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] New Framebuffer for Intel based Macs [try #2]

This patch add a new framebuffer driver for the Intel Based macs.
This framebuffer is needed when booting from EFI to get something
out the box  ;)
Removed unused and untested code in this version of the patch.

Signed-off-by: Edgar Hucek <hostmaster@ed-soft.at>

--------------090309060503080300020709
Content-Type: TEXT/X-PATCH; NAME=imacfb.patch
Content-ID: <Pine.LNX.4.62.0606221038283.23155@pademelon.sonytel.be>
Content-Description: 
Content-Disposition: INLINE; FILENAME=imacfb.patch

diff -uNr linux-2.6.17.orig/drivers/video/imacfb.c linux-2.6.17/drivers/video/imacfb.c
--- linux-2.6.17.orig/drivers/video/imacfb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.17/drivers/video/imacfb.c	2006-06-21 10:31:09.000000000 +0200
@@ -0,0 +1,343 @@
+/*
+ * framebuffer driver for Intel Based Mac's
+ *
+ * (c) 2006 Edgar Hucek <gimli@dark-green.com>
+ * Original imac driver written by Gerd Knorr <kraxel@goldbach.in-berlin.de>
+ *
+ */
+
+#include <asm/io.h>
+
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/fb.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/tty.h>
+
+#include <video/vga.h>
+
+typedef enum _MAC_TYPE {
+	M_I17,
+	M_I20,
+	M_MINI,
+	M_MACBOOK,
+	M_NEW
+} MAC_TYPE;
+
+/* --------------------------------------------------------------------- */
+
+static struct fb_var_screeninfo imacfb_defined __initdata = {
+      	.activate		= FB_ACTIVATE_NOW,
+	.height			= -1,
+	.width			= -1,
+	.right_margin		= 32,
+	.upper_margin		= 16,
+	.lower_margin		= 4,
+	.vsync_len		= 4,
+	.vmode			= FB_VMODE_NONINTERLACED,
+};
+
+static struct fb_fix_screeninfo imacfb_fix __initdata = {
+	.id			= "IMAC VGA",
+	.type			= FB_TYPE_PACKED_PIXELS,
+	.accel			= FB_ACCEL_NONE,
+	.visual			= FB_VISUAL_TRUECOLOR,
+};
+
+static int inverse		= 0;
+static int model		= M_NEW;
+static int manual_height	= 0;
+static int manual_width		= 0;
+
+#define	DEFAULT_FB_MEM	1024*1024*16
+
+/* --------------------------------------------------------------------- */
+
+static int imacfb_setcolreg(unsigned regno, unsigned red, unsigned green,
+			    unsigned blue, unsigned transp,
+			    struct fb_info *info)
+{
+	/*
+	 *  Set a single color register. The values supplied are
+	 *  already rounded down to the hardware's capabilities
+	 *  (according to the entries in the `var' structure). Return
+	 *  != 0 for invalid regno.
+	 */
+	
+	if (regno >= info->cmap.len)
+		return 1;
+
+	if (regno < 16) {
+		red   >>= 8;
+		green >>= 8;
+		blue  >>= 8;
+		((u32 *)(info->pseudo_palette))[regno] =
+			(red   << info->var.red.offset)   |
+			(green << info->var.green.offset) |
+			(blue  << info->var.blue.offset);
+	}
+	return 0;
+}
+
+static struct fb_ops imacfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_setcolreg	= imacfb_setcolreg,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+};
+
+static int __init imacfb_setup(char *options)
+{
+	char *this_opt;
+	
+	if (!options || !*options)
+		return 0;
+	
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt) continue;
+
+		if (! strcmp(this_opt, "inverse"))
+			inverse=1;
+		else if (! strcmp(this_opt, "i17"))
+			model = M_I17;
+		else if (! strcmp(this_opt, "i20"))
+			model = M_I20;
+		else if (! strcmp(this_opt, "mini"))
+			model = M_MINI;
+		else if (! strcmp(this_opt, "macbook"))
+			model = M_MACBOOK;
+		else if (! strncmp(this_opt, "height:", 7))
+			manual_height = simple_strtoul(this_opt+7, NULL, 0);
+		else if (! strncmp(this_opt, "width:", 6))
+			manual_width = simple_strtoul(this_opt+6, NULL, 0);
+	}
+	return 0;
+}
+
+static int __init imacfb_probe(struct platform_device *dev)
+{
+	struct fb_info *info;
+	int err;
+	unsigned int size_vmode;
+	unsigned int size_remap;
+	unsigned int size_total;
+
+	screen_info.lfb_depth = 32;
+	screen_info.lfb_size = DEFAULT_FB_MEM / 0x10000;
+	screen_info.pages=1;
+	screen_info.blue_size = 8;
+	screen_info.blue_pos = 0;
+	screen_info.green_size = 8;
+	screen_info.green_pos = 8;
+	screen_info.red_size = 8;
+	screen_info.red_pos = 16;
+	screen_info.rsvd_size = 8;
+	screen_info.rsvd_pos = 24;
+
+	switch(model) {
+		case M_I17:
+			screen_info.lfb_width = 1440;
+			screen_info.lfb_height = 900;
+			screen_info.lfb_linelength = 1472 * 4;
+			screen_info.lfb_base = 0x80010000;
+			break;
+		case M_NEW:
+		case M_I20:
+			screen_info.lfb_width = 1680;
+			screen_info.lfb_height = 1050;
+			screen_info.lfb_linelength = 1728 * 4;
+			screen_info.lfb_base = 0x80010000;
+			break;
+		case M_MINI:
+			screen_info.lfb_width = 1024;
+			screen_info.lfb_height = 768;
+			screen_info.lfb_linelength = 2048 * 4;
+			screen_info.lfb_base = 0x80000000;
+			break;
+		case M_MACBOOK:
+			screen_info.lfb_width = 1280;
+			screen_info.lfb_height = 800;
+			screen_info.lfb_linelength = 2048 * 4;
+			screen_info.lfb_base = 0x80000000;
+			break;
+ 	}
+
+	/* if the user wants to manually specify height/width,
+	   we will override the defaults */
+	/* TODO: eventually get auto-detection working */
+	if(manual_height > 0)
+		screen_info.lfb_height = manual_height;
+	if(manual_width > 0)
+		screen_info.lfb_width = manual_width;
+
+	imacfb_fix.smem_start = screen_info.lfb_base;
+	imacfb_defined.bits_per_pixel = screen_info.lfb_depth;
+	imacfb_defined.xres = screen_info.lfb_width;
+	imacfb_defined.yres = screen_info.lfb_height;
+	imacfb_fix.line_length = screen_info.lfb_linelength;
+
+	/*   size_vmode -- that is the amount of memory needed for the
+	 *                 used video mode, i.e. the minimum amount of
+	 *                 memory we need. */
+	size_vmode = imacfb_defined.yres * imacfb_fix.line_length;
+
+	/*   size_total -- all video memory we have. Used for
+	 *                 entries, ressource allocation and bounds
+	 *                 checking. */
+	size_total = screen_info.lfb_size * 65536;
+	if (size_total < size_vmode)
+		size_total = size_vmode;
+
+	/*   size_remap -- the amount of video memory we are going to
+	 *                 use for imacfb.  With modern cards it is no
+	 *                 option to simply use size_total as that
+	 *                 wastes plenty of kernel address space. */
+	size_remap  = size_vmode * 2;
+	if (size_remap < size_vmode)
+		size_remap = size_vmode;
+	if (size_remap > size_total)
+		size_remap = size_total;
+	imacfb_fix.smem_len = size_remap;
+
+#ifndef __i386__
+	screen_info.imacpm_seg = 0;
+#endif
+
+	if (!request_mem_region(imacfb_fix.smem_start, size_total, "imacfb")) {
+		printk(KERN_WARNING
+		       "imacfb: cannot reserve video memory at 0x%lx\n",
+			imacfb_fix.smem_start);
+		/* We cannot make this fatal. Sometimes this comes from magic
+		   spaces our resource handlers simply don't know about */
+	}
+
+	info = framebuffer_alloc(sizeof(u32) * 16, &dev->dev);
+	if (!info) {
+		err = -ENOMEM;
+		goto err_release_mem;
+	}
+	info->pseudo_palette = info->par;
+	info->par = NULL;
+
+	info->screen_base = ioremap(imacfb_fix.smem_start, imacfb_fix.smem_len);
+	if (!info->screen_base) {
+		printk(KERN_ERR
+		       "imacfb: abort, cannot ioremap video memory 0x%x @ 0x%lx\n",
+			imacfb_fix.smem_len, imacfb_fix.smem_start);
+		err = -EIO;
+		goto err_unmap;
+	}
+
+	printk(KERN_INFO "imacfb: framebuffer at 0x%lx, mapped to 0x%p, "
+	       "using %dk, total %dk\n",
+	       imacfb_fix.smem_start, info->screen_base,
+	       size_remap/1024, size_total/1024);
+	printk(KERN_INFO "imacfb: mode is %dx%dx%d, linelength=%d, pages=%d\n",
+	       imacfb_defined.xres, imacfb_defined.yres, imacfb_defined.bits_per_pixel, 
+	       imacfb_fix.line_length, screen_info.pages);
+
+	imacfb_defined.xres_virtual = imacfb_defined.xres;
+	imacfb_defined.yres_virtual = imacfb_fix.smem_len / imacfb_fix.line_length;
+	printk(KERN_INFO "imacfb: scrolling: redraw\n");
+	imacfb_defined.yres_virtual = imacfb_defined.yres;
+
+	/* some dummy values for timing to make fbset happy */
+	imacfb_defined.pixclock     = 10000000 / imacfb_defined.xres * 
+					1000 / imacfb_defined.yres;
+	imacfb_defined.left_margin  = (imacfb_defined.xres / 8) & 0xf8;
+	imacfb_defined.hsync_len    = (imacfb_defined.xres / 8) & 0xf8;
+	
+	imacfb_defined.red.offset    = screen_info.red_pos;
+	imacfb_defined.red.length    = screen_info.red_size;
+	imacfb_defined.green.offset  = screen_info.green_pos;
+	imacfb_defined.green.length  = screen_info.green_size;
+	imacfb_defined.blue.offset   = screen_info.blue_pos;
+	imacfb_defined.blue.length   = screen_info.blue_size;
+	imacfb_defined.transp.offset = screen_info.rsvd_pos;
+	imacfb_defined.transp.length = screen_info.rsvd_size;
+
+	printk(KERN_INFO "imacfb: %s: "
+	       "size=%d:%d:%d:%d, shift=%d:%d:%d:%d\n",
+	       "Truecolor",
+	       screen_info.rsvd_size,
+	       screen_info.red_size,
+	       screen_info.green_size,
+	       screen_info.blue_size,
+	       screen_info.rsvd_pos,
+	       screen_info.red_pos,
+	       screen_info.green_pos,
+	       screen_info.blue_pos);
+
+	imacfb_fix.ypanstep  = 0;
+	imacfb_fix.ywrapstep = 0;
+
+	/* request failure does not faze us, as vgacon probably has this
+	 * region already (FIXME) */
+	request_region(0x3c0, 32, "imacfb");
+
+	info->fbops = &imacfb_ops;
+	info->var = imacfb_defined;
+	info->fix = imacfb_fix;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		err = -ENOMEM;
+		goto err_unmap;
+	}
+	if (register_framebuffer(info)<0) {
+		err = -EINVAL;
+		goto err_fb_dealoc;
+	}
+	printk(KERN_INFO "fb%d: %s frame buffer device\n",
+	       info->node, info->fix.id);
+	return 0;
+
+err_fb_dealoc:
+	fb_dealloc_cmap(&info->cmap);
+err_unmap:
+	iounmap(info->screen_base);
+	framebuffer_release(info);
+err_release_mem:
+	release_mem_region(imacfb_fix.smem_start, size_total);
+	return err;
+}
+
+static struct platform_driver imacfb_driver = {
+	.probe	= imacfb_probe,
+	.driver	= {
+		.name	= "imacfb",
+	},
+};
+
+static struct platform_device imacfb_device = {
+	.name	= "imacfb",
+};
+
+static int __init imacfb_init(void)
+{
+	int ret;
+	char *option = NULL;
+
+	/* ignore error return of fb_get_options */
+	fb_get_options("imacfb", &option);
+	imacfb_setup(option);
+	ret = platform_driver_register(&imacfb_driver);
+
+	if (!ret) {
+		ret = platform_device_register(&imacfb_device);
+		if (ret)
+			platform_driver_unregister(&imacfb_driver);
+	}
+	return ret;
+}
+module_init(imacfb_init);
+
+MODULE_LICENSE("GPL");
diff -uNr linux-2.6.17.orig/drivers/video/Kconfig linux-2.6.17/drivers/video/Kconfig
--- linux-2.6.17.orig/drivers/video/Kconfig	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17/drivers/video/Kconfig	2006-06-21 10:05:04.000000000 +0200
@@ -483,6 +483,15 @@
 	  You will get a boot time penguin logo at no additional cost. Please
 	  read <file:Documentation/fb/vesafb.txt>. If unsure, say Y.
 
+config FB_IMAC
+	bool "Intel Based Macs FB"
+	depends on (FB = y) && X86
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	help
+	  This is the frame buffer device driver for the Inel Based Mac's
+
 config VIDEO_SELECT
 	bool
 	depends on FB_VESA
diff -uNr linux-2.6.17.orig/drivers/video/Makefile linux-2.6.17/drivers/video/Makefile
--- linux-2.6.17.orig/drivers/video/Makefile	2006-06-18 03:49:35.000000000 +0200
+++ linux-2.6.17/drivers/video/Makefile	2006-06-21 10:05:04.000000000 +0200
@@ -97,6 +97,7 @@
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             += vesafb.o
+obj-$(CONFIG_FB_IMAC)             += imacfb.o
 obj-$(CONFIG_FB_VGA16)            += vga16fb.o vgastate.o
 obj-$(CONFIG_FB_OF)               += offb.o
 

--------------090309060503080300020709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
--------------090309060503080300020709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------090309060503080300020709--
