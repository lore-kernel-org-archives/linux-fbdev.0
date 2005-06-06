From: akpm@osdl.org
Subject: framebuffer-driver-for-arc-lcd-board.patch added to -mm tree
Date: Sun, 05 Jun 2005 22:16:29 -0700
Message-ID: <200506060516.j565GWrr008241@shell0.pdx.osdl.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Df9yn-0001iO-Il
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Jun 2005 22:16:53 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Df9yl-0005t7-90
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 05 Jun 2005 22:16:53 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jayalk@intworks.biz, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, mm-commits@vger.kernel.org


The patch titled

     Framebuffer driver for Arc LCD board

has been added to the -mm tree.  Its filename is

     framebuffer-driver-for-arc-lcd-board.patch

Patches currently in -mm which might be from jayalk@intworks.biz are

framebuffer-driver-for-arc-lcd-board.patch



From: Jaya Kumar <jayalk@intworks.biz>

Add support for the Arc monochrome LCD board.

The board uses KS108 controllers to drive individual 64x64 LCD matrices. 
The board can be paneled in a variety of setups such as 2x1=128x64,
4x4=256x256 and so on.  The board/host interface is through GPIO.

Signed-off-by: Jaya Kumar <jayalk@intworks.biz>
Cc: "Antonino A. Daplas" <adaplas@pol.net>
Cc: <linux-fbdev-devel@lists.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/video/Kconfig  |   16 +
 drivers/video/Makefile |    1 
 drivers/video/arcfb.c  |  628 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 645 insertions(+)

diff -puN /dev/null drivers/video/arcfb.c
--- /dev/null	2003-09-15 06:40:47.000000000 -0700
+++ 25-akpm/drivers/video/arcfb.c	2005-06-05 22:15:58.000000000 -0700
@@ -0,0 +1,628 @@
+/*
+ * linux/drivers/video/arcfb.c -- FB driver for Arc monochrome LCD board
+ *
+ * Copyright (C) 2005, Jaya Kumar <jayalk@intworks.biz>
+ * http://www.intworks.biz/arclcd
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ * Layout is based on skeletonfb.c by James Simmons and Geert Uytterhoeven.
+ *
+ * This driver was written to be used with the Arc LCD board. Arc uses a
+ * set of KS108 chips that control individual 64x64 LCD matrices. The board
+ * can be paneled in a variety of setups such as 2x1=128x64, 4x4=256x256 and
+ * so on. The interface between the board and the host is TTL based GPIO. The
+ * GPIO requirements are 8 writable data lines and 4+n lines for control. On a
+ * GPIO-less system, the board can be tested by connecting the respective sigs
+ * up to a parallel port connector. The driver requires the IO addresses for
+ * data and control GPIO at load time. It is unable to probe for the
+ * existence of the LCD so it must be told at load time whether it should
+ * be enabled or not.
+ *
+ * Todo:
+ * - support for wakeup on irq for button input
+ * - testing with 4x4
+ *
+ * General notes:
+ * - User must set tuhold. It's in microseconds. According to the 108 spec,
+ *   the hold time is supposed to be at least 1 microsecond.
+ * - User must set arcfb_num_cols=x arcfb_num_rows=y, eg: x=2 means 128
+ * - User must set arcfb_enable=1 to enable it
+ * - User must set data_io_addr=0xIOADDR ctl_io_addr=0xIOADDR
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <asm/uaccess.h>
+#include <linux/fb.h>
+#include <linux/init.h>
+
+#define ceil64(a) (a|0x3F)
+#define floor8(a) (a&(~0x07))
+#define floorXres(a,info) (a&(~(xres - 1)))
+#define ceilXres(a,info) (a|(xres - 1))
+#define iceil8(a) ((int)((a+7)/8)*8)
+
+struct arcfb_par {
+	unsigned long data_io_addr;
+	unsigned long ctl_io_addr;
+	atomic_t ref_count;
+	unsigned char cslut[9];
+	struct fb_info *info;
+};
+
+static struct fb_fix_screeninfo arcfb_fix __initdata = {
+	.id =		"arcfb",
+	.type =		FB_TYPE_PACKED_PIXELS,
+	.visual =	FB_VISUAL_MONO01,
+	.xpanstep =	0,
+	.ypanstep =	1,
+	.ywrapstep =	0,
+	.accel =	FB_ACCEL_NONE,
+};
+
+static struct fb_var_screeninfo arcfb_var __initdata = {
+	.xres		= 128,
+	.yres		= 64,
+	.xres_virtual	= 128,
+	.yres_virtual	= 64,
+	.bits_per_pixel	= 1,
+	.nonstd		= 1,
+};
+
+unsigned long arcfb_num_cols;
+unsigned long arcfb_num_rows;
+unsigned long data_io_addr;
+unsigned long ctl_io_addr;
+unsigned long splashvalue;
+unsigned long tuhold;
+unsigned int nosplash;
+unsigned int arcfb_enable;
+
+int arcfb_init(void);
+int arcfb_setup(char*);
+
+/* ks108 chipset specific defines and code */
+
+#define KS_SET_DPY_START_LINE 0xC0
+#define KS_SET_PAGE_NUM 0xB8
+#define KS_SET_X 0x40
+#define KS_CEHI 0x01
+#define KS_CELO 0x00
+#define KS_SEL_CMD 0x08
+#define KS_SEL_DATA 0x00
+#define KS_DPY_ON 0x3F
+#define KS_DPY_OFF 0x3E
+
+static void ks108_writeb_ctl(struct arcfb_par *par,
+				unsigned int chipindex, unsigned char value)
+{
+	unsigned char chipselval = par->cslut[chipindex];
+
+	outb(chipselval|KS_CEHI|KS_SEL_CMD, par->ctl_io_addr);
+	outb(value, par->data_io_addr);
+	udelay(tuhold);
+	outb(chipselval|KS_CELO|KS_SEL_CMD, par->ctl_io_addr);
+}
+
+static void ks108_writeb_data(struct arcfb_par *par,
+				unsigned int chipindex, unsigned char value)
+{
+	unsigned char chipselval = par->cslut[chipindex];
+
+	outb(chipselval|KS_CEHI|KS_SEL_DATA, par->ctl_io_addr);
+	outb(value, par->data_io_addr);
+	udelay(tuhold);
+	outb(chipselval|KS_CELO|KS_SEL_DATA, par->ctl_io_addr);
+}
+
+static void ks108_set_start_line(struct arcfb_par *par,
+				unsigned int chipindex, unsigned char y)
+{
+	ks108_writeb_ctl(par, chipindex, KS_SET_DPY_START_LINE|y);
+}
+
+static void ks108_set_yaddr(struct arcfb_par *par,
+				unsigned int chipindex, unsigned char y)
+{
+	ks108_writeb_ctl(par, chipindex, KS_SET_PAGE_NUM|y);
+}
+
+static void ks108_set_xaddr(struct arcfb_par *par,
+				unsigned int chipindex, unsigned char x)
+{
+	ks108_writeb_ctl(par, chipindex, KS_SET_X|x);
+}
+
+static void ks108_clear_lcd(struct arcfb_par *par, unsigned int chipindex)
+{
+	int i,j;
+
+	for (i=0; i <= 8; i++) {
+		ks108_set_yaddr(par, chipindex, i);
+		ks108_set_xaddr(par, chipindex, 0);
+		for (j=0; j < 64; j++) {
+			ks108_writeb_data(par, chipindex,
+				(unsigned char) splashvalue);
+		}
+	}
+}
+
+/* main arcfb functions */
+
+static int arcfb_open(struct fb_info *info, int user)
+{
+	struct arcfb_par *par = (struct arcfb_par *) info->par;
+	atomic_inc(&par->ref_count);
+	return 0;
+}
+
+static int arcfb_release(struct fb_info *info, int user)
+{
+	struct arcfb_par *par = (struct arcfb_par *) info->par;
+	int count = atomic_read(&par->ref_count);
+	if (!count)
+		return -EINVAL;
+	atomic_dec(&par->ref_count);
+	return 0;
+}
+
+static int arcfb_pan_display(struct fb_var_screeninfo *var,
+				struct fb_info *info)
+{
+	int i;
+	struct arcfb_par *par = (struct arcfb_par *) info->par;
+
+	if ((var->vmode & FB_VMODE_YWRAP) && (var->yoffset < 64)
+		&& (info->var.yres <= 64)) {
+		for (i=0; i < arcfb_num_cols; i++) {
+			ks108_set_start_line(par, i, var->yoffset);
+		}
+		info->var.yoffset = var->yoffset;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * here we handle a specific page on the lcd. the complexity comes from
+ * the fact that the fb is laidout in 8xX vertical columns. we extract
+ * each write of 8 vertical pixels. then we shift out as we move along
+ * X. That's what rightshift does. bitmask selects the desired input bit.
+ */
+static void arcfb_lcd_update_page(struct arcfb_par *par, unsigned int upper,
+		unsigned int left, unsigned int right, unsigned int distance)
+{
+	unsigned char *src;
+	unsigned int xindex, yindex, chipindex, linesize;
+	int i, count;
+	unsigned char val;
+	unsigned char bitmask, rightshift;
+
+	xindex = left >> 6;
+	yindex = upper >> 6;
+	chipindex = (xindex + (yindex*arcfb_num_cols));
+
+	ks108_set_yaddr(par, chipindex, upper/8);
+
+	linesize = par->info->var.xres/8;
+	src = par->info->screen_base + (left/8) + (upper * linesize);
+	ks108_set_xaddr(par, chipindex, left);
+
+	bitmask=1;
+	rightshift=0;
+	while (left <= right) {
+		val = 0; i=0;
+		for (i=0; i < 8; i++) {
+			if ( i > rightshift) {
+				val |= (*(src + (i*linesize)) & bitmask)
+						<< (i - rightshift);
+			} else {
+				val |= (*(src + (i*linesize)) & bitmask)
+						 >> (rightshift - i);
+			}
+		}
+		ks108_writeb_data(par, chipindex, val);
+		left++;
+		count++;
+		if (bitmask == 0x80) {
+			bitmask = 1;
+			src++;
+			rightshift=0;
+		} else {
+			bitmask <<= 1;
+			rightshift++;
+		}
+	}
+}
+
+/*
+ * here we handle the entire vertical page of the update. we write across
+ * lcd chips. update_page uses the upper/left values to decide which
+ * chip to select for the right. upper is needed for setting the page
+ * desired for the write.
+ */
+static void arcfb_lcd_update_vert(struct arcfb_par *par, unsigned int top,
+		unsigned int bottom, unsigned int left, unsigned int right)
+{
+	unsigned int distance, upper, lower;
+
+	distance = (bottom - top) + 1;
+	upper = top;
+	lower = top + 7;
+
+	while (distance > 0) {
+		distance -= 8;
+		arcfb_lcd_update_page(par, upper, left, right, 8);
+		upper = lower + 1;
+		lower = upper + 7;
+	}
+}
+
+/*
+ * here we handle horizontal blocks for the update. update_vert will
+ * handle spaning multiple pages. we break out each horizontal
+ * block in to individual blocks no taller than 64 pixels.
+ */
+static void arcfb_lcd_update_horiz(struct arcfb_par *par, unsigned int left,
+			unsigned int right, unsigned int top, unsigned int h)
+{
+	unsigned int distance, upper, lower;
+
+	distance = h;
+	upper = floor8(top);
+	lower = min( (upper + distance - 1), ceil64(upper) );
+
+	while (distance > 0) {
+		distance -= ( (lower - upper) + 1 );
+		arcfb_lcd_update_vert(par, upper, lower, left, right);
+		upper = lower + 1;
+		lower = min( (upper + distance - 1), ceil64(upper) );
+	}
+}
+
+/*
+ * here we start the process of spliting out the fb update into
+ * individual blocks of pixels. we end up spliting into 64x64 blocks
+ * and finally down to 64x8 pages.
+ */
+static void arcfb_lcd_update(struct arcfb_par *par, unsigned int dx,
+			unsigned int dy, unsigned int w, unsigned int h)
+{
+	unsigned int left, right, distance;
+	distance = w;
+	left = dx;
+	right = min( (left + w - 1), ceil64(left) );
+
+	while (distance > 0) {
+		arcfb_lcd_update_horiz(par,left,right,dy,h);
+		distance -= ((right - left) + 1);
+		left = right + 1;
+		right = min((left + distance - 1), ceil64(left));
+	}
+}
+
+void arcfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
+{
+	struct arcfb_par *par = (struct arcfb_par *) info->par;
+	int y, h;
+
+	cfb_fillrect(info, rect);
+
+	/* this aligns the write to the lcd vertical page alignment */
+	y = floor8(rect->dy);
+	h = rect->height + (rect->dy - y);
+	h = iceil8(h);
+	/* update the physical lcd */
+	arcfb_lcd_update(par, rect->dx, y, rect->width, h);
+}
+
+void arcfb_copyarea(struct fb_info *info, const struct fb_copyarea *area)
+{
+	unsigned int y, h;
+	struct arcfb_par *par = (struct arcfb_par *) info->par;
+
+	cfb_copyarea(info, area);
+
+	/* this aligns the write to the lcd vertical page alignment */
+	y = floor8(area->dy);
+	h = area->height + (area->dy - y);
+	h = iceil8(h);
+	/* update the physical lcd */
+	arcfb_lcd_update(par, area->dx, y, area->width, h);
+}
+
+void arcfb_imageblit(struct fb_info *info, const struct fb_image *image)
+{
+	unsigned int y, h;
+	struct arcfb_par *par = (struct arcfb_par *) info->par;
+
+	cfb_imageblit(info, image);
+
+	/* this aligns the write to the lcd vertical page alignment */
+	y = floor8(image->dy);
+	h = image->height + (image->dy - y);
+	h = iceil8(h);
+	/* update the physical lcd */
+	arcfb_lcd_update(par, image->dx, y, image->width, h);
+}
+
+/*
+ * this is the access path from userspace. they can seek and write to
+ * the fb. it's inefficient for them to do anything less than 64*8
+ * writes since we update the lcd in each write() anyway.
+ */
+static ssize_t arcfb_write(struct file *file, const char *buf, size_t count,
+				loff_t *ppos)
+{
+	/* modded from epson 1355 */
+
+	struct inode *inode;
+	int fbidx;
+	struct fb_info *info;
+	unsigned long p;
+	int err=-EINVAL;
+	unsigned int fbmemlength,x,y,w,h, bitppos, startpos, endpos, bitcount;
+	struct arcfb_par *par;
+	unsigned int xres;
+
+
+	p = *ppos;
+	inode = file->f_dentry->d_inode;
+	fbidx = iminor(inode);
+	info = registered_fb[fbidx];
+	par = (struct arcfb_par *) info->par;
+
+
+	if (!info || !info->screen_base)
+		return -ENODEV;
+
+	xres = info->var.xres;
+	fbmemlength = ( xres * info->var.yres)/8;
+
+	if (p > fbmemlength)
+		return -ENOSPC;
+
+	err = 0;
+	if ((count + p) > fbmemlength) {
+		count = fbmemlength - p;
+		err = -ENOSPC;
+	}
+
+	if (count) {
+		char *base_addr;
+
+		base_addr = info->screen_base;
+		count -= copy_from_user(base_addr + p, buf, count);
+		*ppos += count;
+		err = -EFAULT;
+	}
+
+
+	bitppos = p*8;
+	startpos = floorXres(bitppos, xres);
+	endpos = ceilXres((bitppos + (count*8)), xres);
+	bitcount = endpos - startpos;
+
+	x = startpos % xres;
+	y = startpos / xres;
+	w = xres;
+	h = bitcount / xres;
+	h = iceil8(h);
+	arcfb_lcd_update(par, x, y, w, h);
+
+	if (count)
+		return count;
+	return err;
+}
+
+int __init arcfb_setup(char *options)
+{
+	char *this_opt;
+
+	if (!options || !*options)
+		return 0;
+
+	while ((this_opt = strsep(&options, ",")) != NULL) {
+		if (!*this_opt)
+			continue;
+		if (!strncmp(this_opt, "nosplash", 8))
+			nosplash = 1;
+		else if (!strncmp(this_opt, "arcfb_enable", 8))
+			arcfb_enable = 1;
+		else if (!strncmp(this_opt, "arcfb_num_cols", 14))
+			arcfb_num_cols = simple_strtoul((this_opt + 14),
+								NULL, 0);
+		else if (!strncmp(this_opt, "arcfb_num_rows", 14))
+			arcfb_num_rows = simple_strtoul((this_opt + 14),
+								NULL, 0);
+		else if (!strncmp(this_opt, "data_io_addr", 12))
+			data_io_addr = simple_strtoul((this_opt + 12),
+								NULL, 0);
+		else if (!strncmp(this_opt, "ctl_io_addr", 11))
+			ctl_io_addr = simple_strtoul((this_opt + 11),
+								NULL, 0);
+		else if (!strncmp(this_opt, "splashvalue", 11))
+			splashvalue = simple_strtoul((this_opt + 11),
+								NULL, 0);
+		else if (!strncmp(this_opt, "tuhold", 6))
+			tuhold = simple_strtoul((this_opt + 6), NULL, 0);
+	}
+	return 0;
+}
+
+static void arcfb_platform_release(struct device *device)
+{
+}
+
+static struct fb_ops arcfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_open	= arcfb_open,
+	.fb_write	= arcfb_write,
+	.fb_release	= arcfb_release,
+	.fb_pan_display	= arcfb_pan_display,
+	.fb_fillrect	= arcfb_fillrect,
+	.fb_copyarea	= arcfb_copyarea,
+	.fb_imageblit	= arcfb_imageblit,
+	.fb_cursor	= soft_cursor,
+};
+
+static int __init arcfb_probe(struct device *device)
+{
+	struct platform_device *dev = to_platform_device(device);
+	struct fb_info *info;
+	int retval = -ENOMEM;
+	int videomemorysize;
+	unsigned char *videomemory;
+	struct arcfb_par *par;
+	int i;
+
+	videomemorysize = (((64*64)*arcfb_num_cols)*arcfb_num_rows)/8;
+
+	/* We need a flat backing store for the Arc's
+	   less-flat actual paged framebuffer */
+	if (!(videomemory = vmalloc(videomemorysize)))
+		return retval;
+
+	memset(videomemory, 0, videomemorysize);
+
+	info = framebuffer_alloc(sizeof(struct arcfb_par), &dev->dev);
+	if (!info)
+		goto err;
+
+	info->screen_base = (char __iomem *)videomemory;
+	info->fbops = &arcfb_ops;
+
+	info->var = arcfb_var;
+	info->fix = arcfb_fix;
+	par = (struct arcfb_par *) info->par;
+	par->info = info;
+	par->data_io_addr = data_io_addr;
+	par->ctl_io_addr = ctl_io_addr;
+	par->cslut[0] = 0x00;
+	par->cslut[1] = 0x06;
+	info->flags = FBINFO_FLAG_DEFAULT;
+
+	retval = register_framebuffer(info);
+	if (retval < 0)
+		goto err1;
+	dev_set_drvdata(&dev->dev, info);
+
+	printk(KERN_INFO
+	       "fb%d: Arc frame buffer device, using %dK of video memory\n",
+	       info->node, videomemorysize >> 10);
+
+	/* this inits the lcd but doesn't clear dirty pixels */
+	for (i=0; i < (arcfb_num_cols*arcfb_num_rows); i++) {
+		ks108_writeb_ctl(par, i, KS_DPY_OFF);
+		ks108_set_start_line(par, i, 0);
+		ks108_set_yaddr(par, i, 0);
+		ks108_set_xaddr(par, i, 0);
+		ks108_writeb_ctl(par, i, KS_DPY_ON);
+	}
+
+	/* if we were told to splash the screen, we just clear it */
+	if (!nosplash) {
+		for (i=0; i < (arcfb_num_cols*arcfb_num_rows); i++) {
+			printk(KERN_INFO "fb%d: splashing lcd %d\n",
+				info->node, i);
+			ks108_set_start_line(par, i, 0);
+			ks108_clear_lcd(par, i);
+		}
+	}
+
+	return 0;
+err1:
+	framebuffer_release(info);
+err:
+	vfree(videomemory);
+	return retval;
+}
+
+static int arcfb_remove(struct device *device)
+{
+	struct fb_info *info = dev_get_drvdata(device);
+
+	if (info) {
+		unregister_framebuffer(info);
+		vfree(info->screen_base);
+		framebuffer_release(info);
+	}
+	return 0;
+}
+
+static struct device_driver arcfb_driver = {
+	.name	= "arcfb",
+	.bus	= &platform_bus_type,
+	.probe	= arcfb_probe,
+	.remove = arcfb_remove,
+};
+
+static struct platform_device arcfb_device = {
+	.name	= "arcfb",
+	.id	= 0,
+	.dev	= {
+		.release = arcfb_platform_release,
+	}
+};
+
+int __init arcfb_init(void)
+{
+	int ret;
+
+#ifndef MODULE
+	char *option = NULL;
+
+	if (fb_get_options("arcfb", &option))
+		return -ENODEV;
+
+	arcfb_setup(option);
+#endif
+
+	if (!arcfb_enable)
+		return -ENXIO;
+
+	ret = driver_register(&arcfb_driver);
+	if (!ret) {
+		ret = platform_device_register(&arcfb_device);
+		if (ret)
+			driver_unregister(&arcfb_driver);
+	}
+	return ret;
+
+}
+
+static void __exit arcfb_exit(void)
+{
+	platform_device_unregister(&arcfb_device);
+	driver_unregister(&arcfb_driver);
+}
+
+module_param(arcfb_num_cols, ulong, 0);
+module_param(arcfb_num_rows, ulong, 0);
+module_param(nosplash, uint, 0);
+module_param(arcfb_enable, uint, 0);
+module_param(data_io_addr, ulong, 0);
+module_param(ctl_io_addr, ulong, 0);
+module_param(splashvalue, ulong, 0);
+module_param(tuhold, ulong, 0);
+
+module_init(arcfb_init);
+module_exit(arcfb_exit);
+
+MODULE_DESCRIPTION("fbdev driver for Arc monochrome LCD board");
+MODULE_AUTHOR("Jaya Kumar");
+MODULE_LICENSE("GPL");
+
diff -puN drivers/video/Kconfig~framebuffer-driver-for-arc-lcd-board drivers/video/Kconfig
--- 25/drivers/video/Kconfig~framebuffer-driver-for-arc-lcd-board	2005-06-05 22:15:58.000000000 -0700
+++ 25-akpm/drivers/video/Kconfig	2005-06-05 22:15:58.000000000 -0700
@@ -322,6 +322,22 @@ config FB_FM2
 	  This is the frame buffer device driver for the Amiga FrameMaster
 	  card from BSC (exhibited 1992 but not shipped as a CBM product).
 
+config FB_ARC
+	tristate "Arc Monochrome LCD board support"
+	depends on FB && X86
+	select FB_CFB_FILLRECT
+	select FB_CFB_COPYAREA
+	select FB_CFB_IMAGEBLIT
+	select FB_SOFT_CURSOR
+	help
+	  This enables support for the Arc Monochrome LCD board. The board
+	  is based on the KS-108 lcd controller and is typically a matrix
+	  of 2*n chips. This driver was tested with a 128x64 panel. This
+	  driver supports it for use with x86 SBCs through a 16 bit GPIO
+	  interface (8 bit data, 8 bit control). If you anticpate using
+	  this driver, say Y or M; otherwise say N. You must specify the
+	  GPIO IO address to be used for setting control and data.
+
 config FB_ATARI
 	bool "Atari native chipset support"
 	depends on (FB = y) && ATARI && BROKEN
diff -puN drivers/video/Makefile~framebuffer-driver-for-arc-lcd-board drivers/video/Makefile
--- 25/drivers/video/Makefile~framebuffer-driver-for-arc-lcd-board	2005-06-05 22:15:58.000000000 -0700
+++ 25-akpm/drivers/video/Makefile	2005-06-05 22:15:58.000000000 -0700
@@ -21,6 +21,7 @@ obj-$(CONFIG_FB_MACMODES)      += macmod
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_RETINAZ3)         += retz3fb.o
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p.o
+obj-$(CONFIG_FB_ARC)              += arcfb.o
 obj-$(CONFIG_FB_CLPS711X)         += clps711xfb.o
 obj-$(CONFIG_FB_CYBER)            += cyberfb.o
 obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o
_


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
