From: Pete Popov <pete_popov@yahoo.com>
Subject: PATCH
Date: 21 Feb 2004 16:44:37 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1077410677.9577.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AuhpU-0001Hf-MN
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Feb 2004 16:50:44 -0800
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1Auhii-00033O-Nl
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Feb 2004 16:43:44 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: pete_popov@yahoo.com


This is a 2.4 patch for the SMI 501 chip. I don't know if anyone is
interested in applying it and/or using it, but I thought I'd send it.
The driver has been tested on the AMD Mirage platform. The I2C portion
of the driver has been sent to the I2C maintainer. 

Pete

diff -Naur --exclude=CVS linux-2.4-orig/drivers/video/Config.in linux-2.4-dev/drivers/video/Config.in
--- linux-2.4-orig/drivers/video/Config.in	2004-01-13 21:51:28.000000000 -0800
+++ linux-2.4-dev/drivers/video/Config.in	2004-02-21 16:19:24.000000000 -0800
@@ -159,6 +159,7 @@
 	    bool '    SIS 300 series support' CONFIG_FB_SIS_300
 	    bool '    SIS 315/330 series support' CONFIG_FB_SIS_315
 	 fi
+	 bool '  SiliconMotion 501 Driver' CONFIG_FB_SMI501
 	 tristate '  NeoMagic display support (EXPERIMENTAL)' CONFIG_FB_NEOMAGIC
 	 tristate '  3Dfx Banshee/Voodoo3 display support (EXPERIMENTAL)' CONFIG_FB_3DFX
 	 tristate '  3Dfx Voodoo Graphics (sst1) support (EXPERIMENTAL)' CONFIG_FB_VOODOO1
diff -Naur --exclude=CVS linux-2.4-orig/drivers/video/fbmem.c linux-2.4-dev/drivers/video/fbmem.c
--- linux-2.4-orig/drivers/video/fbmem.c	2004-01-13 21:51:28.000000000 -0800
+++ linux-2.4-dev/drivers/video/fbmem.c	2004-02-21 16:19:24.000000000 -0800
@@ -145,6 +145,8 @@
 extern int sstfb_setup(char*);
 extern int it8181fb_init(void);
 extern int it8181fb_setup(char*);
+extern int smi501fb_init(void);
+extern int smi501fb_setup(char*);
 
 static struct {
 	const char *name;
@@ -254,6 +256,9 @@
 #ifdef CONFIG_FB_VESA
 	{ "vesa", vesafb_init, vesafb_setup },
 #endif 
+#ifdef CONFIG_FB_SMI501
+	{ "smi501fb", smi501fb_init, smi501fb_setup },
+#endif
 
 	/*
 	 * Chipset specific drivers that don't use resource management (yet)
diff -Naur --exclude=CVS linux-2.4-orig/drivers/video/Makefile linux-2.4-dev/drivers/video/Makefile
--- linux-2.4-orig/drivers/video/Makefile	2004-01-13 21:51:28.000000000 -0800
+++ linux-2.4-dev/drivers/video/Makefile	2004-02-21 16:19:24.000000000 -0800
@@ -88,6 +88,7 @@
 obj-$(CONFIG_FB_TX3912)           += tx3912fb.o
 obj-$(CONFIG_FB_AU1100)		  += au1100fb.o fbgen.o
 obj-$(CONFIG_FB_IT8181)		  += it8181fb.o fbgen.o
+obj-$(CONFIG_FB_SMI501)           += smi501fb.o fbgen.o
 
 subdir-$(CONFIG_STI_CONSOLE)      += sti
 ifeq ($(CONFIG_STI_CONSOLE),y)
diff -Naur --exclude=CVS linux-2.4-orig/drivers/video/smi501fb.c linux-2.4-dev/drivers/video/smi501fb.c
--- linux-2.4-orig/drivers/video/smi501fb.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.4-dev/drivers/video/smi501fb.c	2004-02-21 16:29:07.000000000 -0800
@@ -0,0 +1,801 @@
+/***************************************************************************
+        smifb.c  -  Silicon Motion, Inc. LynxEM+ frame buffer device
+                             -------------------
+    begin                : Thu Aug 9 2001
+    copyright            : (C) 2001 by Szu-Tao Huang
+    email                : johuang@siliconmotion.com
+    
+    Updated to SM501 by Eric.Devolder@amd.com and dan@embeddededge.com
+    for the AMD Mirage Portable Tablet.  20 Oct 2003
+ ***************************************************************************/
+
+/***************************************************************************
+ *                                                                         *
+ *   This program is free software; you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation; either version 2 of the License, or     *
+ *   (at your option) any later version.                                   *
+ *                                                                         *
+ ***************************************************************************/
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/tty.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/fb.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+#include <video/fbcon.h>
+#include <video/fbcon-cfb8.h>
+#include <video/fbcon-cfb16.h>
+#include <video/fbcon-cfb24.h>
+
+static char *SMIRegs;		// point to virtual Memory Map IO starting address
+static char *SMILFB;		// point to virtual video memory starting address
+static struct smifb_info fb_info;
+static struct smifb_par current_par;	// used to record hardware information
+static struct display disp;
+
+#include "smi501fb.h"
+
+static int initdone = 0;
+
+static int
+smifb_ioctl(struct inode *inode, struct file *file, u_int cmd,
+              u_long arg, int con, struct fb_info *info)
+{
+	unsigned char	bcmd, status;
+	unsigned int	bval;
+	struct	smireg_op	sreg;
+	int	retval;
+
+	retval = 0;
+	if (cmd == 1) {
+		/* Send command to battery charger.
+		*/
+		bcmd = (unsigned char)arg;
+
+		/* 0x22 is the slave address.
+		*/
+		smi_mmiowb(0x22, I2C_SLAVE_ADDRESS);
+		wmb();
+		smi_mmiowb(bcmd, I2C_DATA);
+		wmb();
+		smi_mmiowb(0, I2C_BYTE_COUNT);	/* byte count - 1 */
+		wmb();
+		smi_mmiowb(0x05, I2C_CONTROL);	/* enable, 100kHz, start */
+		wmb();
+		do {
+			status = smi_mmiorb(I2C_STATUS_RESET);
+			wmb();
+		} while (status == 0);
+		smi_mmiowb(0x00, I2C_CONTROL);	/* enable, 100kHz, stop */
+		if (status & 0x40)
+			smi_mmiowb(0x00, I2C_STATUS_RESET);
+	}
+	else if (cmd == 2) {
+		/* Read results of command.
+		*/
+		smi_mmiowb(0x23, I2C_SLAVE_ADDRESS);
+		wmb();
+		smi_mmiowb(1, I2C_BYTE_COUNT);	/* byte count - 1 */
+		wmb();
+		smi_mmiowb(0x05, I2C_CONTROL);	/* enable, 100kHz, start */
+		wmb();
+		do {
+			status = smi_mmiorb(I2C_STATUS_RESET);
+			wmb();
+		} while (status == 0);
+		bval = smi_mmiorl(I2C_DATA);
+		wmb();
+		smi_mmiowb(0x00, I2C_CONTROL);	/* enable, 100kHz, stop */
+		wmb();
+		if (copy_to_user((char *)arg, &bval, 4))
+			retval = -EFAULT;
+		if (status & 0x40)
+			smi_mmiowb(0x00, I2C_STATUS_RESET);
+	}
+	else if (cmd == 3) {	/* Debug test */
+		bval = smi_mmiorl(GPIO_DATA_HI);
+		bval ^= 0x0000c000;
+		smi_mmiowl(bval, GPIO_DATA_HI);
+
+	}
+	else if (cmd == 4) {	/* Register operation */
+		if (copy_from_user(&sreg, (void *)arg, sizeof(struct smireg_op))) {
+			return -EFAULT;
+		}
+
+		/* Just 32-bit access for now.
+		*/
+		if (sreg.sr_op == SMI_LOAD_REG) {
+			sreg.sr_val = smi_mmiorl(sreg.sr_reg);
+		}
+		else if (sreg.sr_op == SMI_STORE_REG) {
+			smi_mmiowl(sreg.sr_val, sreg.sr_reg);
+		}
+		else if (sreg.sr_op == SMI_AND_REG) {
+			bval = smi_mmiorl(sreg.sr_reg);
+			smi_mmiowl((bval & sreg.sr_val), sreg.sr_reg);
+			sreg.sr_val = bval;
+		}
+		else if (sreg.sr_op == SMI_OR_REG) {
+			bval = smi_mmiorl(sreg.sr_reg);
+			smi_mmiowl((bval | sreg.sr_val), sreg.sr_reg);
+			sreg.sr_val = bval;
+		}
+		else {
+			retval = -EINVAL;
+		}
+		if (copy_to_user((void *)arg, &sreg, sizeof(struct smireg_op))) {
+			retval = -EFAULT;
+		}
+	}
+	else {
+		retval = -EINVAL;
+	}
+
+	return retval;
+}
+
+static int
+smifb_mmap(struct fb_info *_fb,
+         struct file *file,
+         struct vm_area_struct *vma)
+{
+	unsigned int len;
+	unsigned long start=0, off;
+	struct smifb_info *fb = (struct smifb_info *)_fb;
+
+	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
+		return -EINVAL;
+	}
+
+	start = fb->fb_phys & PAGE_MASK;
+	len = PAGE_ALIGN((start & ~PAGE_MASK) + fb->fb_size);
+
+	off = vma->vm_pgoff << PAGE_SHIFT;
+
+	if ((vma->vm_end - vma->vm_start + off) > len) {
+		return -EINVAL;
+	}
+	off += start;
+	vma->vm_pgoff = off >> PAGE_SHIFT;
+
+	pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
+	pgprot_val(vma->vm_page_prot) |= _CACHE_UNCACHED;
+
+	/* This is an IO map - tell maydump to skip this VMA */
+	vma->vm_flags |= VM_IO;
+
+	if (io_remap_page_range(vma->vm_start, off,
+                vma->vm_end - vma->vm_start,
+                vma->vm_page_prot)) {
+		return -EAGAIN;
+	}
+
+	fb->mmaped = 1;
+	return 0;
+}
+
+static struct fb_ops smifb_ops = {
+	owner:			THIS_MODULE,
+	fb_get_fix:		fbgen_get_fix,
+	fb_get_var:		fbgen_get_var,
+	fb_set_var:		fbgen_set_var,
+	fb_get_cmap:		fbgen_get_cmap,
+	fb_set_cmap:		fbgen_set_cmap,
+	fb_pan_display:		fbgen_pan_display,
+	fb_ioctl:		smifb_ioctl,
+	fb_mmap:		smifb_mmap,
+};
+
+static void smi_nocursor(struct display *p, int mode, int xx, int yy){};
+
+static void
+smi_detect (void)
+{
+	/*
+	 *  This function should detect the current video mode settings
+	 *  and store it as the default video mode
+	 */
+
+	/*
+	 * Yeh, well, we're not going to change any settings so we're
+	 * always stuck with the default ...
+	 */
+}
+
+static int
+smi_encode_fix(struct fb_fix_screeninfo *fix,
+        const void *_par, struct fb_info_gen *_info)
+{
+	struct smifb_info *info = (struct smifb_info *) _info;
+	struct smifb_par *par = (struct smifb_par *) _par;
+	struct fb_var_screeninfo *var = &par->var;
+
+	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
+
+	fix->smem_start = info->fb_phys;
+	fix->smem_len = info->fb_size;
+	fix->type = FB_TYPE_PACKED_PIXELS;
+	fix->type_aux = 0;
+	fix->visual = (var->bits_per_pixel == 8) ?
+            FB_VISUAL_PSEUDOCOLOR   : FB_VISUAL_TRUECOLOR;
+	fix->ywrapstep = 0;
+	fix->xpanstep = 1;
+	fix->ypanstep = 1;
+	fix->line_length = current_par.line_length;
+	return 0;
+}
+
+static void
+set_color_bitfields(struct fb_var_screeninfo *var)
+{
+	switch (var->bits_per_pixel) {
+	case 8:
+		var->red.offset = 0;
+		var->red.length = 8;
+		var->green.offset = 0;
+		var->green.length = 8;
+		var->blue.offset = 0;
+		var->blue.length = 8;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	case 16:    /* RGB 565 */
+		var->red.offset = 11;
+		var->red.length = 5;
+		var->green.offset = 5;
+		var->green.length = 6;
+		var->blue.offset = 0;
+		var->blue.length = 5;
+		var->transp.offset = 0;
+		var->transp.length = 0;
+		break;
+	}
+
+	var->red.msb_right = 0;
+	var->green.msb_right = 0;
+	var->blue.msb_right = 0;
+	var->transp.msb_right = 0;
+}
+
+static int
+smi_decode_var(const struct fb_var_screeninfo *var,
+        void *_par, struct fb_info_gen *_info)
+{
+
+	struct smifb_par *par = (struct smifb_par *)_par;
+
+	/*
+	 * Don't allow setting any of these yet: xres and yres don't
+	 * make sense for LCD panels.
+	 */
+/*
+	if (var->xres != p_lcd->xres || var->yres != p_lcd->yres ||
+			var->xres != p_lcd->xres || var->yres != p_lcd->yres) {
+		return -EINVAL;
+	}
+	if(var->bits_per_pixel != p_lcd->bpp) {
+		return -EINVAL;
+	} */
+
+	memset(par, 0, sizeof(struct smifb_par));
+	par->var = *var;
+
+	/* FIXME */
+	switch (var->bits_per_pixel) {
+	case 8:
+		par->var.bits_per_pixel = 8;
+		break;
+	case 16:
+		par->var.bits_per_pixel = 16;
+		break;
+	default:
+		printk("color depth %d bpp not supported\n",
+						var->bits_per_pixel);
+		return -EINVAL;
+
+	}
+	set_color_bitfields(&par->var);
+	par->cmap_len = (par->var.bits_per_pixel == 8) ? 256 : 16;
+	return 0;
+}
+
+static int
+smi_encode_var(struct fb_var_screeninfo *var,
+        const void *par, struct fb_info_gen *_info)
+{
+	*var = ((struct smifb_par *)par)->var;
+	return 0;
+}
+
+static void
+smi_get_par(void *_par, struct fb_info_gen *_info)
+{
+	*(struct smifb_par *)_par = current_par;
+}
+
+static void
+smi_set_par(const void *par, struct fb_info_gen *info)
+{
+	/* nothing to do: we don't change any settings */
+}
+
+static int
+smi_getcolreg(unsigned regno, unsigned *red, unsigned *green,
+             unsigned *blue, unsigned *transp,
+             struct fb_info *info)
+{
+	struct smifb_info* i = (struct smifb_info*)info;
+
+	if (regno > 255)
+		return 1;
+
+	*red    = i->palette[regno].red;
+	*green  = i->palette[regno].green;
+	*blue   = i->palette[regno].blue;
+	*transp = 0;
+
+	return 0;
+}
+
+static int
+smi_setcolreg(unsigned regno, unsigned red, unsigned green,
+	unsigned blue, unsigned transp,
+	struct fb_info *info)
+{
+	struct smifb_info* i = (struct smifb_info *)info;
+
+	if (regno > 255)
+		return 1;
+
+	i->palette[regno].red    = red;
+	i->palette[regno].green  = green;
+	i->palette[regno].blue   = blue;
+
+	switch(current_par.var.bits_per_pixel) {
+#ifdef FBCON_HAS_CFB8
+	case 8:
+		red >>= 10;
+		green >>= 10;
+		blue >>= 10;
+			// FIX!!! fill palette
+		break;
+#endif
+#ifdef FBCON_HAS_CFB16
+	case 16:
+		i->fbcon_cmap16[regno] =
+		    ((red & 0xf800) >> 0) |
+		    ((green & 0xfc00) >> 5) |
+		    ((blue & 0xf800) >> 11);
+		break;
+#endif
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int
+smi_blank(int blank_mode, struct fb_info_gen *_info)
+{
+	switch (blank_mode) {
+	case VESA_NO_BLANKING:
+		/* turn on panel */
+		break;
+	case VESA_VSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
+	case VESA_POWERDOWN:
+		/* turn off panel */
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static void
+smi_set_disp(const void *unused, struct display *disp,
+             struct fb_info_gen *info)
+{
+	disp->screen_base = (char *)fb_info.fb_virt_start;
+
+	switch (disp->var.bits_per_pixel) {
+#ifdef FBCON_HAS_CFB8
+	case 8:
+		disp->dispsw = &fbcon_cfb8;
+		//fbcon_cfb8.cursor = smi_nocursor;
+		break;
+#endif
+#ifdef FBCON_HAS_CFB16
+	case 16:
+		disp->dispsw = &fbcon_cfb16;
+		disp->dispsw_data = fb_info.fbcon_cmap16;
+		//fbcon_cfb16.cursor = smi_nocursor;
+		break;
+#endif
+	default:
+		disp->dispsw = &fbcon_dummy;
+		disp->dispsw_data = NULL;
+		break;
+    }
+}
+
+static int
+smi_pan_display(const struct fb_var_screeninfo *var,
+               struct fb_info_gen *info)
+{
+	return 0;
+}
+
+static struct fbgen_hwswitch smi_switch = {
+	detect:		smi_detect,
+	encode_fix:	smi_encode_fix,
+	decode_var:	smi_decode_var,
+	encode_var:	smi_encode_var,
+	get_par:	smi_get_par,
+	set_par:	smi_set_par,
+	getcolreg:	smi_getcolreg,
+	setcolreg:	smi_setcolreg,
+	pan_display:	smi_pan_display,
+	blank:		smi_blank,
+	set_disp:	smi_set_disp
+};
+
+/* GPIO functions to set/clear bits and direction for the bit-bang
+ * I2C algorithm.  Someday, these will need to be protected with
+ * spinlocks/irq.  Right now, I2C is the only one to modify GPIOs.
+ */
+void
+smi501_set_gpio_hi_data(unsigned int val)
+{
+	unsigned int reg;
+
+	reg = smi_mmiorl(GPIO_DATA_HI);
+	wmb();
+	reg |= val;
+	smi_mmiowl(reg, GPIO_DATA_HI);
+	wmb();
+}
+
+void
+smi501_clr_gpio_hi_data(unsigned int val)
+{
+	unsigned int new;
+
+	new = smi_mmiorl(GPIO_DATA_HI);
+	wmb();
+	new &= ~val;
+	smi_mmiowl(new, GPIO_DATA_HI);
+	wmb();
+}
+
+unsigned int
+smi501_get_gpio_hi_data(unsigned int mask)
+{
+	unsigned int new;
+
+	new = smi_mmiorl(GPIO_DATA_HI);
+	wmb();
+
+	return (new & mask);
+}
+
+void
+smi501_set_gpio_hi_direction(unsigned int mask, unsigned int val)
+{
+	unsigned int new;
+
+	new = smi_mmiorl(GPIO_DATA_DIR_HI);
+	wmb();
+	new &= ~mask;
+	new |= val;
+	smi_mmiowl(new, GPIO_DATA_DIR_HI);
+	wmb();
+}
+
+
+/* This function still needs lots of work to generically support
+ * different output devices (CRT or LCD) and resolutions.
+ * Currently hard-coded for Mirage 1024x768 LCD panel.
+ */
+static void
+smi_setmode(struct smifb_info *sfb,struct smifb_par *hw)
+{
+	uint	reg;
+
+	if (initdone)
+		return;
+
+	initdone = 1;
+
+	/* Just blast in some control values based upon the chip
+	 * documentation.  We use the internal memory, I don't know
+	 * how to determine the amount available yet.
+	 */
+	smi_mmiowl(0x07F127C2, DRAM_CTRL);
+	smi_mmiowl(0x02000020, PANEL_HWC_ADDRESS);
+	smi_mmiowl(0x007FF800, PANEL_HWC_ADDRESS);
+	smi_mmiowl(0x00021827, POWER_MODE1_GATE);
+	smi_mmiowl(0x011A0A09, POWER_MODE1_CLOCK);
+	smi_mmiowl(0x00000001, POWER_MODE_CTRL);
+	smi_mmiowl(0x80000000, PANEL_FB_ADDRESS);
+	smi_mmiowl(0x08000800, PANEL_FB_WIDTH);
+	smi_mmiowl(0x04000000, PANEL_WINDOW_WIDTH);
+	smi_mmiowl(0x03000000, PANEL_WINDOW_HEIGHT);
+	smi_mmiowl(0x00000000, PANEL_PLANE_TL);
+	smi_mmiowl(0x02FF03FF, PANEL_PLANE_BR);
+	smi_mmiowl(0x05D003FF, PANEL_HORIZONTAL_TOTAL);
+	smi_mmiowl(0x00C80424, PANEL_HORIZONTAL_SYNC);
+	smi_mmiowl(0x032502FF, PANEL_VERTICAL_TOTAL);
+	smi_mmiowl(0x00060302, PANEL_VERTICAL_SYNC);
+	smi_mmiowl(0x00013905, PANEL_DISPLAY_CTRL);
+	smi_mmiowl(0x01013105, PANEL_DISPLAY_CTRL);
+	waitforvsync();
+	smi_mmiowl(0x03013905, PANEL_DISPLAY_CTRL);
+	waitforvsync();
+	smi_mmiowl(0x07013905, PANEL_DISPLAY_CTRL);
+	waitforvsync();
+	smi_mmiowl(0x0F013905, PANEL_DISPLAY_CTRL);
+	smi_mmiowl(0x0002187F, POWER_MODE1_GATE);
+	smi_mmiowl(0x01011801, POWER_MODE1_CLOCK);
+	smi_mmiowl(0x00000001, POWER_MODE_CTRL);
+
+	smi_mmiowl(0x80000000, PANEL_FB_ADDRESS);
+	smi_mmiowl(0x00000000, PANEL_PAN_CTRL);
+	smi_mmiowl(0x00000000, PANEL_COLOR_KEY);
+
+	/* Enable I2C in GPIO.
+	*/
+#if 0
+	reg = smi_mmiorl(GPIO_HI_CTRL);
+	wmb();
+	reg |= 0x0000c000;		/* Enable bits 46, 47 */
+	smi_mmiowl(reg, GPIO_HI_CTRL);
+	wmb();
+	smi_mmiowb(0x00, I2C_CONTROL);	/* enable, 100kHz, stop */
+	wmb();
+	smi_mmiowb(0x00, I2C_STATUS_RESET);
+#else
+	/* Enable GPIO pins and make them inputs.
+	*/
+	reg = smi_mmiorl(GPIO_DATA_DIR_HI);
+	wmb();
+	reg &= ~0x0000c000;		/* Enable bits 46, 47 */
+	smi_mmiowl(reg, GPIO_DATA_DIR_HI);
+	reg = smi_mmiorl(GPIO_HI_CTRL);
+	wmb();
+	reg &= ~0x0000c000;		/* Enable bits 46, 47 */
+	smi_mmiowl(reg, GPIO_HI_CTRL);
+	wmb();
+	reg = smi_mmiorl(GPIO_DATA_HI);
+	wmb();
+	reg |= 0x0000c000;		/* Let 'em float */
+	smi_mmiowl(reg, GPIO_DATA_HI);
+#endif
+
+	/* Enable 8-bit ZV Port.
+	*/
+	reg = smi_mmiorl(GPIO_LO_CTRL);
+	wmb();
+	reg |= 0x00ff0000;		/* Enable bits 16-23 */
+	smi_mmiowl(reg, GPIO_LO_CTRL);
+	wmb();
+}
+
+/* Set up the zv port to be displayed on the screen.  Currently
+ * coded to expect CCIR 656, YUV 4:2:2 cosited from the PNX1302.
+ */
+static void
+set_videoport(int loc_x, int loc_y, int size_x, int size_y)
+{
+	int nbytes;
+	int top, left, bot, right;
+
+	/* Initialize registers, most power up undefined.
+	*/
+	smi_mmiowl(0x0014008a, ZV_CAPTURE_CLIP);
+	smi_mmiowl(((size_y << 16) | size_x), ZV_CAPTURE_SIZE);
+
+	/* Magic buffer addresses.  Just ensure they don't
+	 * collide with something else in memory.
+	 */
+	smi_mmiowl(0x00200000, ZV_CAPTURE_BUF0);
+	smi_mmiowl(0x00400000, ZV_CAPTURE_BUF1);
+	smi_mmiowl(0x00000000, ZV_CAPTURE_OFFSET);
+	smi_mmiowl(0x00000004, ZV_FIFO_CTRL);
+
+#if 0
+	smi_mmiowl(0x00016007, VIDEO_DISPLAY_CTRL);
+#else
+	smi_mmiowl(0x00010005, VIDEO_DISPLAY_CTRL);
+#endif
+	smi_mmiowl(0x00400000, VIDEO_DISPLAY_FB0);
+	smi_mmiowl(0x00400000, VIDEO_DISPLAY_FB1);
+	smi_mmiowl(((size_x * 2) << 16), VIDEO_DISPLAY_FBWIDTH);
+	nbytes = (size_x * 2) * size_y;
+	nbytes += 127;
+	nbytes &= ~127;
+	smi_mmiowl(0x00400000 + nbytes, VIDEO_DISPLAY_FB0LAST);
+	smi_mmiowl(0x00400000 + nbytes, VIDEO_DISPLAY_FB1LAST);
+
+
+	top = loc_y;
+	left = loc_x;
+	smi_mmiowl(((top << 16) | left), VIDEO_DISPLAY_TL);
+
+	/* Use max ntsc.
+	*/
+	bot = top + size_y;
+	right = left + size_x;
+	smi_mmiowl(((bot << 16) | right), VIDEO_DISPLAY_BR);
+
+	smi_mmiowl(0x00000000, VIDEO_SCALE);
+	smi_mmiowl(0x00000000, VIDEO_INITIAL_SCALE);
+
+	smi_mmiowl(0x00ededed, VIDEO_YUV_CONSTANTS);
+
+	smi_mmiowl(0x17010000, VIDEO_ALPHA_CTRL);
+
+	/* Enable
+	*/
+#if 0
+	smi_mmiowl(0x00000211, ZV_CAPTURE_CTRL);
+#endif
+
+}
+
+/*
+ * Unmap in the memory mapped IO registers
+ *
+ */
+
+static void __devinit
+smi_unmap_mmio(struct smifb_info *sfb)
+{
+	if (sfb && SMIRegs) {
+		iounmap(SMIRegs);
+		SMIRegs = NULL;
+	}
+}
+
+
+/*
+ * Unmap in the screen memory
+ *
+ */
+static void __devinit
+smi_unmap_smem(struct smifb_info *sfb)
+{
+	if (sfb && sfb->fb_virt_start) {
+		iounmap(sfb->fb_virt_start);
+		sfb->fb_virt_start = NULL;
+	}
+}
+
+void
+smi501fb_setup (char *options, int *ints)
+{
+	return;
+}
+
+int __init smi501fb_init(void)
+{
+	struct smifb_info *sfb;
+	char name[16];
+	int err;
+
+	struct pci_dev *pdev = NULL;
+	int i = 0;
+
+	/* Find and enable Voyager
+	 * Rev. AA is 0x501, Rev. B is 0x510.
+	 */
+	pdev = pci_find_device(0x126f,0x510, pdev);
+	if (pdev == NULL)
+		pdev = pci_find_device(0x126f,0x501, pdev);
+	if (pdev == NULL)
+		return -ENODEV;
+	
+	/* Enable the chip.
+	*/
+	err = pci_enable_device(pdev);
+	if (err)
+		return err;
+	current_par.chipID = 0x510;
+
+	err = -ENOMEM;
+	sprintf(name, "smifb");
+	sfb = &fb_info;
+	memset(sfb, 0, sizeof(struct smifb_info));
+	memset(&disp, 0, sizeof(struct display));
+
+	sfb->currcon = -1;
+	sfb->dev = pdev;
+
+
+	/* Set up MMIO space.
+	*/
+	sfb->mmio_phys = pci_resource_start(pdev,1);
+	sfb->mmio_size = 0x00200000;
+	sfb->mmio_virt_start = ioremap(sfb->mmio_phys, sfb->mmio_size);
+	SMIRegs = sfb->mmio_virt_start;
+
+	/* Set up framebuffer.  It's a 64M space, various amount of
+	 * internal memory.  I don't know how to determine the real
+	 * amount of memory (yet).
+	 */
+	sfb->fb_phys = pci_resource_start(pdev,0);
+	sfb->fb_size = 0x00800000;
+	sfb->fb_virt_start = ioremap(sfb->fb_phys, sfb->fb_size);
+	SMILFB = sfb->fb_virt_start;
+
+	 memset((void *)fb_info.fb_virt_start, 0, fb_info.fb_size);
+
+	current_par.var.xres =
+   	current_par.var.xres_virtual = 1024; //sfb->fb.var.xres;
+	current_par.var.yres =
+	current_par.var.yres_virtual = 768; //sfb->fb.var.yres;
+	current_par.var.bits_per_pixel = 16; //sfb->fb.var.bits_per_pixel;
+	current_par.line_length = (current_par.var.bits_per_pixel * current_par.var.xres) / 8;
+
+	smi_setmode(sfb, &current_par);
+
+	fb_info.gen.parsize = sizeof(struct smifb_par);
+	fb_info.gen.fbhw = &smi_switch;
+
+	strcpy(fb_info.gen.info.modename, "SMI Voyager");
+	fb_info.gen.info.changevar = NULL;
+	fb_info.gen.info.node = -1;
+
+	fb_info.gen.info.fbops = &smifb_ops;
+	fb_info.gen.info.disp = &disp;
+	fb_info.gen.info.switch_con = &fbgen_switch;
+	fb_info.gen.info.updatevar = &fbgen_update_var;
+	fb_info.gen.info.blank = &fbgen_blank;
+	fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
+
+	/* This should give a reasonable default video mode
+	*/
+	fbgen_get_var(&disp.var, -1, &fb_info.gen.info);
+	fbgen_do_set_var(&disp.var, 1, &fb_info.gen);
+	fbgen_set_disp(-1, &fb_info.gen);
+	fbgen_install_cmap(0, &fb_info.gen);
+
+	if (register_framebuffer(&fb_info.gen.info) < 0)
+		goto failed;
+
+#if 0
+	/* This is for videoport testing.  The Mirage uses an 8-bit
+	 * video port, which is now known to not work properly
+	 * on the SMI501 part.
+	 */
+	set_videoport(150, 150, 768, 576);
+#endif
+
+	MOD_INC_USE_COUNT;
+	printk("Silicon Motion Inc. VOYAGER Init complete.\n");
+
+	return 0;
+
+failed:
+	smi_unmap_smem(sfb);
+	smi_unmap_mmio(sfb);
+
+	return err;
+}
diff -Naur --exclude=CVS linux-2.4-orig/drivers/video/smi501fb.h linux-2.4-dev/drivers/video/smi501fb.h
--- linux-2.4-orig/drivers/video/smi501fb.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.4-dev/drivers/video/smi501fb.h	2004-02-21 16:19:24.000000000 -0800
@@ -0,0 +1,171 @@
+/***************************************************************************
+			smifb.h  -  SiliconMotion LynxEM+ frame buffer device
+                             -------------------
+    begin                : Thu Aug 9 2001
+    copyright            : (C) 2001 by Szu-Tao Huang
+    email                : johuang@siliconmotion.com
+    
+    Updated to SM501 by Eric.Devolder@amd.com and dan@embeddededge.com
+    for the AMD Mirage Portable Tablet.  20 Oct 2003
+ ***************************************************************************/
+
+/***************************************************************************
+ *                                                                         *
+ *   This program is free software; you can redistribute it and/or modify  *
+ *   it under the terms of the GNU General Public License as published by  *
+ *   the Free Software Foundation; either version 2 of the License, or     *
+ *   (at your option) any later version.                                   *
+ *                                                                         *
+ ***************************************************************************/
+#include <linux/config.h>
+
+#define smi_mmiowb(dat,reg)	writeb(dat, (unsigned int)(SMIRegs + reg))
+#define smi_mmioww(dat,reg)	writew(dat, (unsigned int)(SMIRegs + reg))
+#define smi_mmiowl(dat,reg)	writel(dat, (unsigned int)(SMIRegs + reg))
+
+#define smi_mmiorb(reg)	        readb(SMIRegs + reg)
+#define smi_mmiorw(reg)	        readw(SMIRegs + reg)
+#define smi_mmiorl(reg)	        readl(SMIRegs + reg)
+
+#define NR_PALETTE      256
+
+/* Address space offsets for various control/status registers.
+*/
+#define MISC_CTRL			0x000004
+#define GPIO_LO_CTRL			0x000008
+#define GPIO_HI_CTRL			0x00000c
+#define DRAM_CTRL			0x000010
+#define CURRENT_POWER_GATE		0x000038
+#define CURRENT_POWER_CLOCK		0x00003C
+#define POWER_MODE1_GATE                0x000048
+#define POWER_MODE1_CLOCK               0x00004C
+#define POWER_MODE_CTRL			0x000054
+
+#define GPIO_DATA_LO			0x010000
+#define GPIO_DATA_HI			0x010004
+#define GPIO_DATA_DIR_LO		0x010008
+#define GPIO_DATA_DIR_HI		0x01000c
+#define I2C_BYTE_COUNT			0x010040
+#define I2C_CONTROL			0x010041
+#define I2C_STATUS_RESET		0x010042
+#define I2C_SLAVE_ADDRESS		0x010043
+#define I2C_DATA			0x010044
+
+#define DE_COLOR_COMPARE		0x100020
+#define DE_COLOR_COMPARE_MASK		0x100024
+#define DE_MASKS			0x100028
+#define DE_WRAP				0x10004C
+
+#define PANEL_DISPLAY_CTRL              0x080000
+#define PANEL_PAN_CTRL                  0x080004
+#define PANEL_COLOR_KEY                 0x080008
+#define PANEL_FB_ADDRESS                0x08000C
+#define PANEL_FB_WIDTH                  0x080010
+#define PANEL_WINDOW_WIDTH              0x080014
+#define PANEL_WINDOW_HEIGHT             0x080018
+#define PANEL_PLANE_TL                  0x08001C
+#define PANEL_PLANE_BR                  0x080020
+#define PANEL_HORIZONTAL_TOTAL          0x080024
+#define PANEL_HORIZONTAL_SYNC           0x080028
+#define PANEL_VERTICAL_TOTAL            0x08002C
+#define PANEL_VERTICAL_SYNC             0x080030
+#define PANEL_CURRENT_LINE              0x080034
+#define VIDEO_DISPLAY_CTRL		0x080040
+#define VIDEO_DISPLAY_FB0		0x080044
+#define VIDEO_DISPLAY_FBWIDTH		0x080048
+#define VIDEO_DISPLAY_FB0LAST		0x08004C
+#define VIDEO_DISPLAY_TL		0x080050
+#define VIDEO_DISPLAY_BR		0x080054
+#define VIDEO_SCALE			0x080058
+#define VIDEO_INITIAL_SCALE		0x08005C
+#define VIDEO_YUV_CONSTANTS		0x080060
+#define VIDEO_DISPLAY_FB1		0x080064
+#define VIDEO_DISPLAY_FB1LAST		0x080068
+#define VIDEO_ALPHA_CTRL		0x080080
+#define PANEL_HWC_ADDRESS		0x0800F0
+#define CRT_DISPLAY_CTRL		0x080200
+
+#define ZV_CAPTURE_CTRL			0x090000
+#define ZV_CAPTURE_CLIP			0x090004
+#define ZV_CAPTURE_SIZE			0x090008
+#define ZV_CAPTURE_BUF0			0x09000c
+#define ZV_CAPTURE_BUF1			0x090010
+#define ZV_CAPTURE_OFFSET		0x090014
+#define ZV_FIFO_CTRL			0x090018
+
+#define waitforvsync() udelay(100); udelay(100); udelay(100); udelay(100);
+
+/*
+ * Minimum X and Y resolutions
+ */
+#define MIN_XRES	640
+#define MIN_YRES	480
+
+/*
+* Private structure
+*/
+struct smifb_info
+{
+        /*
+        * The following is a pointer to be passed into the
+        * functions below.  The modules outside the main
+        * smifb.c driver have no knowledge as to what
+        * is within this structure.
+        */
+        struct fb_info_gen          gen;
+        struct display_switch   *dispsw;
+        struct pci_dev	        *dev;
+        signed int              currcon;
+
+        struct {
+                u8 red, green, blue;
+        } palette[NR_PALETTE];
+
+        u_int                   palette_size;
+
+		int mmaped;
+		u32 mmio_phys;
+		u32 mmio_size;
+		char *mmio_virt_start;
+
+		u32 fb_phys;
+		u32 fb_size;
+		char *fb_virt_start;
+
+#if defined(FBCON_HAS_CFB16)
+		u16 fbcon_cmap16[16];
+#endif
+
+		/* smi_alloc_fb_info has struct display + 16*sizeof(u32)
+		*/
+		u32 yyy[16];
+};
+
+struct smifb_par
+{
+	struct fb_var_screeninfo var;
+	int line_length;	/* in bytes */
+	int cmap_len;		/* color-map length */
+
+	/*
+	 * Hardware
+	 */
+	u16		chipID;
+
+	u_int	width;
+	u_int	height;
+	u_int	hz;
+};
+
+/* User access to registers for debug and development.
+*/
+struct smireg_op {
+	uint	sr_op;
+	uint	sr_reg;
+	uint	sr_val;
+};
+
+#define SMI_LOAD_REG	1
+#define SMI_STORE_REG	2
+#define SMI_AND_REG	3
+#define SMI_OR_REG	4





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
