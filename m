From: Richard Purdie <rpurdie@rpsys.net>
Subject: [patch][revision #2] Add w100 framebuffer driver
Date: Sat, 8 Jan 2005 18:37:08 +0000
Message-ID: <200501081837.08883.rpurdie@rpsys.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnLSk-0003QQ-8G
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Jan 2005 10:37:22 -0800
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CnLSg-0003SY-VR
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 08 Jan 2005 10:37:22 -0800
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: "adaplas@hotpop.com" <adaplas@hotpop.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, kronos@people.it

Add a framebuffer driver for the ATI w100 as found on several Sharp PDAs

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

--- linux-2.6.10/drivers/video/Kconfig~w100-r7.patch
+++ linux-2.6.10/drivers/video/Kconfig
@@ -1051,6 +1051,19 @@
 	  say M here and read <file:Documentation/modules.txt>.
 
 	  If unsure, say N.
+	  
+config FB_W100
+	tristate "W100 frame buffer support"
+	depends on FB && PXA_SHARPSL
+	---help---
+	  Frame buffer driver for the w100 as found on the Sharp SL-Cxx series. 
+
+	  This driver is also available as a module ( = code which can be
+	  inserted and removed from the running kernel whenever you want). The
+	  module will be called vfb. If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  If unsure, say N.
 
 config FB_PXA_PARAMETERS
 	bool "PXA LCD command line parameters"
--- linux-2.6.10/drivers/video/Makefile~w100-r7.patch
+++ linux-2.6.10/drivers/video/Makefile
@@ -94,6 +94,7 @@
 obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o cfbfillrect.o cfbimgblt.o 
cfbcopyarea.o
 obj-$(CONFIG_FB_ASILIANT)	  += asiliantfb.o cfbfillrect.o cfbcopyarea.o 
cfbimgblt.o
 obj-$(CONFIG_FB_PXA)		  += pxafb.o cfbimgblt.o cfbcopyarea.o cfbfillrect.o
+obj-$(CONFIG_FB_W100)		   += w100fb.o cfbimgblt.o cfbcopyarea.o cfbfillrect.o 
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o 
cfbimgblt.o
--- /dev/null
+++ linux-2.6.10/drivers/video/w100fb.c
@@ -0,0 +1,1864 @@
+/*
+ * linux/drivers/video/w100fb.c
+ *
+ * Frame Buffer Device for ATI Imageon w100 (Wallaby)
+ *
+ * Copyright (C) 2002, ATI Corp.
+ * Copyright (C) 2004-2005 Richard Purdie
+ *
+ * Rewritten for 2.6 by Richard Purdie <rpurdie@rpsys.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/delay.h> 
+#include <linux/fb.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/device.h>
+#include <linux/string.h>
+#include <linux/proc_fs.h>
+#include <linux/vmalloc.h>
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <video/w100fb.h>
+#include "w100fb.h"
+
+/*
+ * Prototypes
+ */
+static void w100fb_save_buffer(void);
+static void w100fb_clear_buffer(void);
+static void w100fb_restore_buffer(void);
+static void w100fb_clear_screen(uint32_t mode, long int offset);
+static void w100_resume(void);
+static void w100_suspend(uint32_t mode);
+static void w100_init_qvga_rotation(uint16_t deg);
+static void w100_init_vga_rotation(uint16_t deg);
+static void w100_vsync(void);
+static void w100_init_sharp_lcd(uint32_t mode);
+static void w100_pwm_setup(void);
+static void w100_InitExtMem(uint32_t mode);
+static void w100_hw_init(void);
+static uint16_t w100_set_fastsysclk(uint16_t Freq);
+
+static void lcdtg_hw_init(uint32_t mode);
+static void lcdtg_lcd_change(uint32_t mode);
+static void lcdtg_resume(void);
+static void lcdtg_suspend(void);
+
+
+/* Register offsets & lengths */
+#define REMAPPED_FB_LEN   0x15ffff
+
+#define BITS_PER_PIXEL    16
+
+/* Pseudo palette size */
+#define MAX_PALETTES      16
+
+/* for resolution change */
+#define LCD_MODE_INIT (-1)
+#define LCD_MODE_480    0
+#define LCD_MODE_320    1
+#define LCD_MODE_240    2
+#define LCD_MODE_640    3
+
+#define LCD_SHARP_QVGA 0
+#define LCD_SHARP_VGA  1
+
+#define LCD_MODE_PORTRAIT	0
+#define LCD_MODE_LANDSCAPE	1
+
+#define W100_SUSPEND_EXTMEM 0
+#define W100_SUSPEND_ALL    1
+
+/* General frame buffer data structures */
+struct w100fb_par {
+	uint32_t xres;
+	uint32_t yres;
+	int fastsysclk_mode;
+	int lcdMode;
+	int rotation_flag;
+	int blanking_flag;
+	int comadj;
+	int phadadj;	
+};
+
+static struct w100fb_par *current_par;
+
+static uint16_t *gSaveImagePtr = NULL;
+
+/* Remapped addresses for base cfg, memmapped regs and the frame buffer 
itself */
+static void *remapped_base;
+static void *remapped_regs;
+static void *remapped_fbuf;
+
+/* External Function */
+static void(*w100fb_ssp_send)(uint8_t adrs, uint8_t data);
+
+/* 
+ * Sysfs functions 
+ */
+
+static ssize_t rotation_show(struct device *dev, char *buf)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct w100fb_par *par=info->par;
+
+	return sprintf(buf, "%d\n",par->rotation_flag);
+}
+
+static ssize_t rotation_store(struct device *dev, const char *buf, size_t 
count)
+{
+	unsigned int rotate;
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct w100fb_par *par=info->par;
+
+	rotate = simple_strtoul(buf, NULL, 10);
+
+	if (rotate > 0) par->rotation_flag = 1;
+	else par->rotation_flag = 0;
+
+	if (par->lcdMode == LCD_MODE_320)
+		w100_init_qvga_rotation(par->rotation_flag ? 270 : 90);
+	else if (par->lcdMode == LCD_MODE_240)
+		w100_init_qvga_rotation(par->rotation_flag ? 180 : 0);
+	else if (par->lcdMode == LCD_MODE_640)
+		w100_init_vga_rotation(par->rotation_flag ? 270 : 90);
+	else if (par->lcdMode == LCD_MODE_480)
+		w100_init_vga_rotation(par->rotation_flag ? 180 : 0);
+
+	return count;
+}
+
+static DEVICE_ATTR(rotation, 0644, rotation_show, rotation_store);
+
+static ssize_t w100fb_reg_read(struct device *dev, const char *buf, size_t 
count)
+{
+	unsigned long param;
+	unsigned long regs;
+	regs = simple_strtoul(buf, NULL, 16);
+	param = readl(remapped_regs + regs);
+	printk("Read Register 0x%08lX: 0x%08lX\n", regs, param);
+	return count;
+}
+
+static DEVICE_ATTR(reg_read, 0200, NULL, w100fb_reg_read);
+
+static ssize_t w100fb_reg_write(struct device *dev, const char *buf, size_t 
count)
+{
+	unsigned long regs;
+	unsigned long param;
+	sscanf(buf, "%lx %lx", &regs, &param);
+
+	if (regs <= 0x2000) {
+		printk("Write Register 0x%08lX: 0x%08lX\n", regs, param);
+		writel(param, remapped_regs + regs);
+	}
+
+	return count;
+}
+
+static DEVICE_ATTR(reg_write, 0200, NULL, w100fb_reg_write);
+
+
+static ssize_t fastsysclk_show(struct device *dev, char *buf)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct w100fb_par *par=info->par;
+
+	return sprintf(buf, "%d\n",par->fastsysclk_mode);
+}
+
+static ssize_t fastsysclk_store(struct device *dev, const char *buf, size_t 
count)
+{
+	int param;
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct w100fb_par *par=info->par;
+
+	param = simple_strtoul(buf, NULL, 10);
+
+	if (param == 75) {
+		printk("Set fastsysclk %d\n", param);
+		par->fastsysclk_mode = param;
+		w100_set_fastsysclk(par->fastsysclk_mode);
+	} else if (param == 100) {
+		printk("Set fastsysclk %d\n", param);
+		par->fastsysclk_mode = param;
+		w100_set_fastsysclk(par->fastsysclk_mode);
+	}
+	return count;
+}
+
+static DEVICE_ATTR(fastsysclk, 0644, fastsysclk_show, fastsysclk_store);
+
+/*
+ * The touchscreen on this device needs certain information 
+ * from the video driver to function correctly. We export it here.
+ */
+int w100fb_get_xres(void) {
+	return current_par->xres;
+}
+
+int w100fb_get_blanking(void) {
+	return current_par->blanking_flag;
+}
+
+int w100fb_get_fastsysclk(void) {
+	return current_par->fastsysclk_mode;
+}
+EXPORT_SYMBOL(w100fb_get_xres);
+EXPORT_SYMBOL(w100fb_get_blanking);
+EXPORT_SYMBOL(w100fb_get_fastsysclk);
+
+
+/*
+ * Set a palette value from rgb components
+ */
+static int w100fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+			     u_int trans, struct fb_info *info)
+{
+	unsigned int val;
+	int ret = 1;
+
+	/*
+	 * If greyscale is true, then we convert the RGB value
+	 * to greyscale no matter what visual we are using.
+	 */
+	if (info->var.grayscale)
+		red = green = blue = (19595 * red + 38470 * green + 7471 * blue) >> 16;
+
+	/*
+	 * 16-bit True Colour.  We encode the RGB value
+	 * according to the RGB bitfield information.
+	 */
+	if (regno < MAX_PALETTES) {
+
+		uint32_t *pal = info->pseudo_palette;
+
+		val = (red & 0xf800) | ((green & 0xfc00) >> 5) | ((blue & 0xf800) >> 11);
+		pal[regno] = val;
+		ret = 0;
+	}
+	return ret;
+}
+
+
+/*
+ * Blank the display based on value in blank_mode
+ */
+static int w100fb_blank(int blank_mode, struct fb_info *info)
+{
+	struct w100fb_par *par;
+	par=info->par;
+	
+	switch(blank_mode) {
+
+ 	case FB_BLANK_NORMAL: /* Normal blanking */
+	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
+	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
+ 	case FB_BLANK_POWERDOWN: /* Poweroff */  
+  		if (par->blanking_flag == 0) {
+			w100fb_save_buffer();
+			lcdtg_suspend();
+			par->blanking_flag = 1;
+  		}
+  		break;
+ 	
+ 	case FB_BLANK_UNBLANK: /* Unblanking */
+  		if (par->blanking_flag != 0) {
+			w100fb_restore_buffer();
+			lcdtg_resume();
+			par->blanking_flag = 0;		
+  		}
+  		break;
+ 	}
+	return 0;
+}
+
+/*
+ *  Change the resolution by calling the appropriate hardware functions
+ */
+static void w100fb_changeres(int rotate_mode, uint32_t mode) 
+{
+	uint16_t rotation=0;
+
+	switch(rotate_mode) {
+	case LCD_MODE_LANDSCAPE:
+		rotation=(current_par->rotation_flag ? 270 : 90);
+		break;
+	case LCD_MODE_PORTRAIT:
+		rotation=(current_par->rotation_flag ? 180 : 0);	
+		break;
+	}
+		
+	w100_pwm_setup();
+	switch(mode) {
+	case LCD_SHARP_QVGA:
+		w100_vsync();
+		w100_suspend(W100_SUSPEND_EXTMEM);
+		w100_init_sharp_lcd(LCD_SHARP_QVGA);
+		w100_init_qvga_rotation(rotation);
+		w100_InitExtMem(LCD_SHARP_QVGA);
+		w100fb_clear_screen(LCD_SHARP_QVGA, 0);
+		lcdtg_lcd_change(LCD_SHARP_QVGA);
+		break;
+	case LCD_SHARP_VGA:
+		w100fb_clear_screen(LCD_SHARP_QVGA, 0);
+		writel(0xBFFFA000, remapped_regs + mmMC_EXT_MEM_LOCATION);
+		w100_InitExtMem(LCD_SHARP_VGA);
+		w100fb_clear_screen(LCD_SHARP_VGA, 0x200000);
+		w100_vsync();
+		w100_init_sharp_lcd(LCD_SHARP_VGA);
+		if (rotation != 0)
+			w100_init_vga_rotation(rotation);
+		lcdtg_lcd_change(LCD_SHARP_VGA);
+		break;
+	}
+}
+
+/*
+ * Set up the display for the fb subsystem
+ */
+static void w100fb_activate_var(struct fb_info *info)
+{
+	uint32_t temp32;
+	struct w100fb_par *par=info->par;
+	struct fb_var_screeninfo *var = &info->var;
+
+	/* Set the hardware to 565 */
+	temp32 = readl(remapped_regs + mmDISP_DEBUG2);
+	temp32 &= 0xff7fffff;
+	temp32 |= 0x00800000;
+	writel(temp32, remapped_regs + mmDISP_DEBUG2);
+
+	if (par->lcdMode == LCD_MODE_INIT) {
+		w100_init_sharp_lcd(LCD_SHARP_VGA);
+		w100_init_vga_rotation(par->rotation_flag ? 270 : 90);
+		par->lcdMode = LCD_MODE_640;
+		lcdtg_hw_init(LCD_SHARP_VGA);
+	} else if (var->xres == 320 && var->yres == 240) {
+		if (par->lcdMode != LCD_MODE_320) {
+			w100fb_changeres(LCD_MODE_LANDSCAPE, LCD_SHARP_QVGA);
+			par->lcdMode = LCD_MODE_320;
+		}
+	} else if (var->xres == 240 && var->yres == 320) {
+		if (par->lcdMode != LCD_MODE_240) {
+			w100fb_changeres(LCD_MODE_PORTRAIT, LCD_SHARP_QVGA);
+			par->lcdMode = LCD_MODE_240;
+		}
+	} else if (var->xres == 640 && var->yres == 480) {
+		if (par->lcdMode != LCD_MODE_640) {
+			w100fb_changeres(LCD_MODE_LANDSCAPE, LCD_SHARP_VGA);
+			par->lcdMode = LCD_MODE_640;
+		}
+	} else if (var->xres == 480 && var->yres == 640) {
+		if (par->lcdMode != LCD_MODE_480) {
+			w100fb_changeres(LCD_MODE_PORTRAIT, LCD_SHARP_VGA);
+			par->lcdMode = LCD_MODE_480;
+		}
+	} else printk(KERN_ERR "W100FB: Resolution error!\n");
+}
+
+
+/*
+ *  w100fb_check_var():
+ *  Get the video params out of 'var'. If a value doesn't fit, round it up,
+ *  if it's too big, return -EINVAL.
+ *
+ */
+static int w100fb_check_var(struct fb_var_screeninfo *var, struct fb_info 
*info)
+{
+	if (var->xres < var->yres) { /* Portrait mode */
+		if ((var->xres > 480) || (var->yres > 640)) {
+			return -EINVAL;
+		} else if ((var->xres > 240) || (var->yres > 320)) {
+			var->xres = 480;
+			var->yres = 640;
+		} else {
+			var->xres = 240;
+			var->yres = 320;
+		}	
+	} else { /* Landscape mode */
+		if ((var->xres > 640) || (var->yres > 480)) {
+			return -EINVAL;
+		} else if ((var->xres > 320) || (var->yres > 240)) {
+			var->xres = 640;
+			var->yres = 480;
+		} else {
+			var->xres = 320;
+			var->yres = 240;
+		}	
+	} 
+
+	var->xres_virtual = max(var->xres_virtual, var->xres);
+	var->yres_virtual = max(var->yres_virtual, var->yres);
+
+	if (var->bits_per_pixel > BITS_PER_PIXEL) 
+		return -EINVAL;
+	else 
+		var->bits_per_pixel = BITS_PER_PIXEL;
+
+	var->red.offset = 11;
+	var->red.length = 5;
+	var->green.offset = 5;
+	var->green.length = 6;
+	var->blue.offset = 0;
+	var->blue.length = 5;
+	var->transp.offset = var->transp.length = 0;
+
+	var->nonstd = 0;
+
+	var->height = -1;
+	var->width = -1;
+	var->vmode = FB_VMODE_NONINTERLACED;
+
+	var->sync = 0;
+	var->pixclock = 0x04;	/* 171521; */
+
+	return 0;
+}
+
+
+/*
+ * w100fb_set_par():
+ *	Set the user defined part of the display for the specified console
+ *  by looking at the values in info.var
+ */
+static int w100fb_set_par(struct fb_info *info)
+{
+	struct w100fb_par *par=info->par;
+	
+	par->xres = info->var.xres;
+	par->yres = info->var.yres;
+
+	info->fix.visual = FB_VISUAL_TRUECOLOR;
+
+	info->fix.ypanstep = 0;
+	info->fix.ywrapstep = 0;
+	
+	if (par->blanking_flag) 
+		w100fb_clear_buffer();
+
+	w100fb_activate_var(info);
+
+	if (par->lcdMode == LCD_MODE_480) {
+		info->fix.line_length = (480 * BITS_PER_PIXEL) / 8;
+		info->fix.smem_len = 0x200000;
+	} else if (par->lcdMode == LCD_MODE_320) {
+		info->fix.line_length = (320 * BITS_PER_PIXEL) / 8;
+		info->fix.smem_len = 0x60000;
+	} else if (par->lcdMode == LCD_MODE_240) {
+		info->fix.line_length = (240 * BITS_PER_PIXEL) / 8;
+		info->fix.smem_len = 0x60000;
+	} else if (par->lcdMode == LCD_MODE_INIT || par->lcdMode == LCD_MODE_640) {
+		info->fix.line_length = (640 * BITS_PER_PIXEL) / 8;
+		info->fix.smem_len = 0x200000;
+	}
+
+	return 0;
+}
+
+
+/*
+ *      Frame buffer operations
+ */
+static struct fb_ops w100fb_ops = {
+	.owner = THIS_MODULE,
+	.fb_check_var = w100fb_check_var,
+	.fb_set_par = w100fb_set_par,
+	.fb_setcolreg = w100fb_setcolreg,
+	.fb_blank = w100fb_blank,
+	.fb_fillrect = cfb_fillrect,
+	.fb_copyarea = cfb_copyarea,
+	.fb_imageblit = cfb_imageblit,
+	.fb_cursor = soft_cursor,
+};
+
+
+static void w100fb_clear_screen(uint32_t mode, long int offset)
+{
+	int i, numPix = 0;
+
+	if (mode == LCD_SHARP_VGA) 
+		numPix = 640 * 480;
+	else if (mode == LCD_SHARP_QVGA) 
+		numPix = 320 * 240;
+	
+	for (i = 0; i < numPix; i++)
+		writew(0xffff, remapped_fbuf + offset + (2*i));
+}
+
+
+static void w100fb_save_buffer(void)
+{
+	int i;
+
+	if (gSaveImagePtr != NULL) {
+		vfree(gSaveImagePtr);
+		gSaveImagePtr = NULL;
+	}
+	gSaveImagePtr = vmalloc(current_par->xres * current_par->yres * 
BITS_PER_PIXEL / 8);
+	if (gSaveImagePtr != NULL) {
+		for (i = 0; i < (current_par->xres * current_par->yres); i++)
+			*(gSaveImagePtr + i) = readw(remapped_fbuf + (2*i));
+	} else {
+		printk(KERN_WARNING "can't alloc pre-off image buffer\n");
+	}
+}
+
+
+static void w100fb_restore_buffer(void)
+{
+	int i;
+
+	if (gSaveImagePtr != NULL) {
+		for (i = 0; i < (current_par->xres * current_par->yres); i++) {
+				writew(*(gSaveImagePtr + i),remapped_fbuf + (2*i));
+			}
+		vfree(gSaveImagePtr);
+		gSaveImagePtr = NULL;
+	}
+}
+
+static void w100fb_clear_buffer(void)
+{
+	if (gSaveImagePtr != NULL) {
+		vfree(gSaveImagePtr);
+		gSaveImagePtr = NULL;
+	}
+}
+
+
+#ifdef CONFIG_PM
+static int w100fb_suspend(struct device *dev, uint32_t state, uint32_t level)
+{
+	if (level == SUSPEND_POWER_DOWN) {	
+		struct fb_info *info = dev_get_drvdata(dev);
+		struct w100fb_par *par=info->par;
+		
+		w100fb_save_buffer();
+		lcdtg_suspend();
+		w100_suspend(W100_SUSPEND_ALL);
+		par->blanking_flag = 1;
+	}
+	return 0;
+}
+
+static int w100fb_resume(struct device *dev, uint32_t level)
+{
+	if (level == RESUME_POWER_ON) {
+		struct fb_info *info = dev_get_drvdata(dev);
+		struct w100fb_par *par=info->par;
+		
+		w100_resume();
+		w100fb_restore_buffer();
+		lcdtg_resume();
+		par->blanking_flag = 0;
+	}
+	return 0;
+}
+#else
+#define w100fb_suspend	NULL
+#define w100fb_resume	NULL
+#endif
+
+
+int __init w100fb_probe(struct device *dev)
+{
+	struct w100fb_mach_info *inf;
+	struct fb_info *info;
+	struct w100fb_par *par;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	
+	if (!mem) 
+		return -EINVAL;
+
+	/* remap the areas we're going to use */
+	remapped_base = ioremap_nocache(mem->start+W100_CFG_BASE, W100_CFG_LEN);
+	if (remapped_base == NULL) 
+		return -EIO;
+
+	remapped_regs = ioremap_nocache(mem->start+W100_REG_BASE, W100_REG_LEN);
+	if (remapped_regs == NULL) {
+		iounmap(remapped_base);
+		return -EIO;
+	}
+
+	remapped_fbuf = ioremap_nocache(mem->start+MEM_EXT_BASE_VALUE, 
REMAPPED_FB_LEN);
+	if (remapped_fbuf == NULL) {
+		iounmap(remapped_base);			
+		iounmap(remapped_regs);
+		return -EIO;
+	}
+	
+	info=framebuffer_alloc(sizeof(struct w100fb_par), dev);
+	if (!info) {
+		iounmap(remapped_base);			
+		iounmap(remapped_regs);		
+		iounmap(remapped_fbuf);
+		return -ENOMEM;
+	}
+
+	info->device=dev;
+	par = info->par;
+	current_par=info->par;
+	dev_set_drvdata(dev, info);
+	
+	inf = dev->platform_data;
+	par->phadadj = inf->phadadj;
+	par->comadj = inf->comadj;
+	par->fastsysclk_mode = 75;
+	par->lcdMode = LCD_MODE_INIT;
+	par->rotation_flag=0;
+	par->blanking_flag=0;
+	w100fb_ssp_send = inf->w100fb_ssp_send;	
+
+	w100_hw_init();
+	w100_pwm_setup();
+	
+	info->pseudo_palette = kmalloc(sizeof (uint32_t) * MAX_PALETTES, 
GFP_KERNEL);
+	if (!info->pseudo_palette) {
+		iounmap(remapped_base);			
+		iounmap(remapped_regs);		
+		iounmap(remapped_fbuf);
+		return -ENOMEM;
+	}
+
+	info->fbops = &w100fb_ops;
+	info->flags = FBINFO_DEFAULT;
+	info->node = -1;
+	info->screen_base = remapped_fbuf;
+	info->screen_size = REMAPPED_FB_LEN;
+
+	info->var.xres = 640;
+	info->var.xres_virtual = info->var.xres;
+	info->var.yres = 480;
+	info->var.yres_virtual = info->var.yres;
+	info->var.pixclock = 0x04;	/* 171521; */
+	info->var.sync = 0;
+	info->var.grayscale = 0;
+	info->var.xoffset = info->var.yoffset = 0;
+	info->var.accel_flags = 0;
+	info->var.activate = FB_ACTIVATE_NOW;
+
+	strcpy(info->fix.id, "w100fb");
+	info->fix.type = FB_TYPE_PACKED_PIXELS;
+	info->fix.type_aux = 0;
+	info->fix.accel = FB_ACCEL_NONE;
+	info->fix.smem_start = mem->start+MEM_EXT_BASE_VALUE;
+	info->fix.mmio_start = mem->start+W100_REG_BASE;
+	info->fix.mmio_len = W100_REG_LEN;
+
+	w100fb_check_var(&info->var, info);
+	w100fb_set_par(info);
+
+	if (register_framebuffer(info) < 0) {
+		kfree(info->pseudo_palette);		
+		iounmap(remapped_base);			
+		iounmap(remapped_regs);		
+		iounmap(remapped_fbuf);
+		return -EINVAL;
+	}
+
+	device_create_file(dev, &dev_attr_fastsysclk);
+	device_create_file(dev, &dev_attr_reg_read);
+	device_create_file(dev, &dev_attr_reg_write);
+	device_create_file(dev, &dev_attr_rotation);
+
+	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node, 
info->fix.id);
+	return 0;
+}
+
+
+static int w100fb_remove(struct device *dev)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+
+	device_remove_file(dev, &dev_attr_fastsysclk);
+	device_remove_file(dev, &dev_attr_reg_read);
+	device_remove_file(dev, &dev_attr_reg_write);
+	device_remove_file(dev, &dev_attr_rotation);
+	
+	unregister_framebuffer(info);
+	
+	w100fb_clear_buffer();
+	kfree(info->pseudo_palette);
+
+	iounmap(remapped_base);
+	iounmap(remapped_regs);
+	iounmap(remapped_fbuf);
+	
+	framebuffer_release(info);
+
+	return 0;
+}
+
+
+/* ------------------- chipset specific functions -------------------------- 
*/
+
+
+static void w100_soft_reset(void)
+{
+	uint16_t val = readw((uint16_t *) remapped_base + cfgSTATUS);
+	writew(val | 0x08, (uint16_t *) remapped_base + cfgSTATUS);
+	udelay(100);
+	writew(0x00, (uint16_t *) remapped_base + cfgSTATUS);
+	udelay(100);
+}
+
+/*
+ * Initialization of critical w100 hardware
+ */
+static void w100_hw_init(void)
+{
+	uint32_t temp32;
+	union cif_cntl_u cif_cntl;
+	union intf_cntl_u intf_cntl;
+	union cfgreg_base_u cfgreg_base;
+	union wrap_top_dir_u wrap_top_dir;
+	union cif_read_dbg_u cif_read_dbg;
+	union cpu_defaults_u cpu_default;
+	union cif_write_dbg_u cif_write_dbg;
+	union wrap_start_dir_u wrap_start_dir;
+	union mc_ext_mem_location_u mc_ext_mem_loc;
+	union cif_io_u cif_io;
+
+	w100_soft_reset();
+
+	/* This is what the fpga_init code does on reset. May be wrong
+	   but there is little info available */
+	writel(0x31, remapped_regs + mmSCRATCH_UMSK);
+	for (temp32 = 0; temp32 < 10000; temp32++)
+		readl(remapped_regs + mmSCRATCH_UMSK);
+	writel(0x30, remapped_regs + mmSCRATCH_UMSK);
+
+	/* Set up CIF */
+	cif_io.val = defCIF_IO;
+	writel((uint32_t)(cif_io.val), remapped_regs + mmCIF_IO);
+
+	cif_write_dbg.val = readl(remapped_regs + mmCIF_WRITE_DBG);
+	cif_write_dbg.f.dis_packer_ful_during_rbbm_timeout = 0;
+	cif_write_dbg.f.en_dword_split_to_rbbm = 1;
+	cif_write_dbg.f.dis_timeout_during_rbbm = 1;
+	writel((uint32_t) (cif_write_dbg.val), remapped_regs + mmCIF_WRITE_DBG);
+
+	cif_read_dbg.val = readl(remapped_regs + mmCIF_READ_DBG);
+	cif_read_dbg.f.dis_rd_same_byte_to_trig_fetch = 1;
+	writel((uint32_t) (cif_read_dbg.val), remapped_regs + mmCIF_READ_DBG);
+
+	cif_cntl.val = readl(remapped_regs + mmCIF_CNTL);
+	cif_cntl.f.dis_system_bits = 1;
+	cif_cntl.f.dis_mr = 1;
+	cif_cntl.f.en_wait_to_compensate_dq_prop_dly = 0;
+	cif_cntl.f.intb_oe = 1;
+	cif_cntl.f.interrupt_active_high = 1;
+	writel((uint32_t) (cif_cntl.val), remapped_regs + mmCIF_CNTL);
+
+	/* Setup cfgINTF_CNTL and cfgCPU defaults */
+	intf_cntl.val = defINTF_CNTL;
+	intf_cntl.f.ad_inc_a = 1;
+	intf_cntl.f.ad_inc_b = 1;
+	intf_cntl.f.rd_data_rdy_a = 0;
+	intf_cntl.f.rd_data_rdy_b = 0;
+	writeb((uint8_t) (intf_cntl.val), remapped_base + cfgINTF_CNTL);
+
+	cpu_default.val = defCPU_DEFAULTS;
+	cpu_default.f.access_ind_addr_a = 1;
+	cpu_default.f.access_ind_addr_b = 1;
+	cpu_default.f.access_scratch_reg = 1;
+	cpu_default.f.transition_size = 0;
+	writeb((uint8_t) (cpu_default.val), remapped_base + cfgCPU_DEFAULTS);
+
+	/* set up the apertures */
+	writeb((uint8_t) (W100_REG_BASE >> 16), remapped_base + cfgREG_BASE);
+
+	cfgreg_base.val = defCFGREG_BASE;
+	cfgreg_base.f.cfgreg_base = W100_CFG_BASE;
+	writel((uint32_t) (cfgreg_base.val), remapped_regs + mmCFGREG_BASE);
+
+	/* This location is relative to internal w100 addresses */
+	writel(0x15FF1000, remapped_regs + mmMC_FB_LOCATION);
+
+	mc_ext_mem_loc.val = defMC_EXT_MEM_LOCATION;
+	mc_ext_mem_loc.f.mc_ext_mem_start = MEM_EXT_BASE_VALUE >> 8;
+	mc_ext_mem_loc.f.mc_ext_mem_top = MEM_EXT_TOP_VALUE >> 8;
+	writel((uint32_t) (mc_ext_mem_loc.val), remapped_regs + 
mmMC_EXT_MEM_LOCATION);
+
+	if ((current_par->lcdMode == LCD_MODE_240) || (current_par->lcdMode == 
LCD_MODE_320)) 
+		w100_InitExtMem(LCD_SHARP_QVGA);
+	else 
+		w100_InitExtMem(LCD_SHARP_VGA);
+	
+	wrap_start_dir.val = defWRAP_START_DIR;
+	wrap_start_dir.f.start_addr = WRAP_BUF_BASE_VALUE >> 1;
+	writel((uint32_t) (wrap_start_dir.val), remapped_regs + mmWRAP_START_DIR);
+
+	wrap_top_dir.val = defWRAP_TOP_DIR;
+	wrap_top_dir.f.top_addr = WRAP_BUF_TOP_VALUE >> 1;
+	writel((uint32_t) (wrap_top_dir.val), remapped_regs + mmWRAP_TOP_DIR);
+
+	writel((uint32_t) 0x2440, remapped_regs + mmRBBM_CNTL);
+}
+
+
+/*
+ * Types
+ */
+
+struct pll_parm {
+	uint16_t freq;		/* desired Fout for PLL */
+	uint8_t M;
+	uint8_t N_int;
+	uint8_t N_fac;
+	uint8_t tfgoal;
+	uint8_t lock_time;
+};
+
+struct power_state {
+	union clk_pin_cntl_u clk_pin_cntl;
+	union pll_ref_fb_div_u pll_ref_fb_div;
+	union pll_cntl_u pll_cntl;
+	union sclk_cntl_u sclk_cntl;
+	union pclk_cntl_u pclk_cntl;
+	union clk_test_cntl_u clk_test_cntl;
+	union pwrmgt_cntl_u pwrmgt_cntl;
+	uint32_t freq;		/* Fout for PLL calibration */
+	uint8_t tf100;		/* for pll calibration */
+	uint8_t tf80;		/* for pll calibration */
+	uint8_t tf20;		/* for pll calibration */
+	uint8_t M;			/* for pll calibration */
+	uint8_t N_int;		/* for pll calibration */
+	uint8_t N_fac;		/* for pll calibration */
+	uint8_t lock_time;	/* for pll calibration */
+	uint8_t tfgoal;		/* for pll calibration */
+	uint8_t auto_mode;	/* hardware auto switch? */
+	uint8_t pwm_mode;		/* 0 fast, 1 normal/slow */
+	uint16_t fast_sclk;	/* fast clk freq */
+	uint16_t norm_sclk;	/* slow clk freq */
+};
+
+
+/*
+ * Global state variables
+ */
+
+static struct power_state w100_pwr_state;
+
+/* This table is specific for 12.5MHz ref crystal.  */
+static struct pll_parm gPLLTable[] = {
+    /*freq     M   N_int    N_fac  tfgoal  lock_time */
+    { 50,      0,   1,       0,     0xE0,        56}, /*  50.00 MHz */
+    { 75,      0,   5,       0,     0xDE,	     37}, /*  75.00 MHz */
+    {100,      0,   7,       0,     0xE0,        28}, /* 100.00 MHz */
+    {125,      0,   9,       0,     0xE0,        22}, /* 125.00 MHz */
+    {150,      0,   11,      0,     0xE0,        17}, /* 150.00 MHz */ 
+    {  0,      0,   0,       0,        0,         0}  /* Terminator */
+};
+
+
+static uint8_t w100_pll_get_testcount(uint8_t testclk_sel)
+{
+	udelay(5);
+
+	w100_pwr_state.clk_test_cntl.f.start_check_freq = 0x0;
+	w100_pwr_state.clk_test_cntl.f.testclk_sel = testclk_sel;
+	w100_pwr_state.clk_test_cntl.f.tstcount_rst = 0x1;	/*reset test count */
+	writel((uint32_t) (w100_pwr_state.clk_test_cntl.val), remapped_regs + 
mmCLK_TEST_CNTL);
+	w100_pwr_state.clk_test_cntl.f.tstcount_rst = 0x0;
+	writel((uint32_t) (w100_pwr_state.clk_test_cntl.val), remapped_regs + 
mmCLK_TEST_CNTL);
+
+	w100_pwr_state.clk_test_cntl.f.start_check_freq = 0x1;
+	writel((uint32_t) (w100_pwr_state.clk_test_cntl.val), remapped_regs + 
mmCLK_TEST_CNTL);
+
+	udelay(20);	
+
+	w100_pwr_state.clk_test_cntl.val = readl(remapped_regs + mmCLK_TEST_CNTL);
+	w100_pwr_state.clk_test_cntl.f.start_check_freq = 0x0;
+	writel((uint32_t) (w100_pwr_state.clk_test_cntl.val), remapped_regs + 
mmCLK_TEST_CNTL);
+
+	return w100_pwr_state.clk_test_cntl.f.test_count;
+}
+
+
+static uint8_t w100_pll_adjust(void)
+{
+	do {
+		/* Wai Ming 80 percent of VDD 1.3V gives 1.04V, minimum operating voltage 
is 1.08V
+		 * therefore, commented out the following lines
+		 * tf80 meant tf100
+		 * set VCO input = 0.8 * VDD
+		 */
+		w100_pwr_state.pll_cntl.f.pll_dactal = 0xd;
+		writel((uint32_t) (w100_pwr_state.pll_cntl.val), remapped_regs + 
mmPLL_CNTL);
+
+		w100_pwr_state.tf80 = w100_pll_get_testcount(0x1);	/* PLLCLK */
+		if (w100_pwr_state.tf80 >= (w100_pwr_state.tfgoal)) {
+			/* set VCO input = 0.2 * VDD */
+			w100_pwr_state.pll_cntl.f.pll_dactal = 0x7;
+			writel((uint32_t) (w100_pwr_state.pll_cntl.val), remapped_regs + 
mmPLL_CNTL);
+
+			w100_pwr_state.tf20 = w100_pll_get_testcount(0x1);	/* PLLCLK */
+			if (w100_pwr_state.tf20 <= (w100_pwr_state.tfgoal))
+				return 1; // Success
+
+			if ((w100_pwr_state.pll_cntl.f.pll_vcofr == 0x0) &&
+			    ((w100_pwr_state.pll_cntl.f.pll_pvg == 0x7) ||
+			     (w100_pwr_state.pll_cntl.f.pll_ioffset == 0x0))) {
+				/* slow VCO config */
+				w100_pwr_state.pll_cntl.f.pll_vcofr = 0x1;
+				w100_pwr_state.pll_cntl.f.pll_pvg = 0x0;
+				w100_pwr_state.pll_cntl.f.pll_ioffset = 0x0;
+				writel((uint32_t) (w100_pwr_state.pll_cntl.val),
+					remapped_regs + mmPLL_CNTL);
+				continue;
+			}
+		}
+		if ((w100_pwr_state.pll_cntl.f.pll_ioffset) < 0x3) {
+			w100_pwr_state.pll_cntl.f.pll_ioffset += 0x1;
+			writel((uint32_t) (w100_pwr_state.pll_cntl.val), remapped_regs + 
mmPLL_CNTL);
+			continue;
+		}
+		if ((w100_pwr_state.pll_cntl.f.pll_pvg) < 0x7) {
+			w100_pwr_state.pll_cntl.f.pll_ioffset = 0x0;
+			w100_pwr_state.pll_cntl.f.pll_pvg += 0x1;
+			writel((uint32_t) (w100_pwr_state.pll_cntl.val), remapped_regs + 
mmPLL_CNTL);
+			continue;
+		}
+		return 0; // error
+	} while(1);
+}
+
+
+/*
+ * w100_pll_calibration
+ *                freq = target frequency of the PLL
+ *                (note: crystal = 14.3MHz)
+ */
+static uint8_t w100_pll_calibration(uint32_t freq)
+{
+	uint8_t status;
+
+	/* initial setting */
+	w100_pwr_state.pll_cntl.f.pll_pwdn = 0x0;		/* power down */
+	w100_pwr_state.pll_cntl.f.pll_reset = 0x0;		/* not reset */
+	w100_pwr_state.pll_cntl.f.pll_tcpoff = 0x1;	/* Hi-Z */
+	w100_pwr_state.pll_cntl.f.pll_pvg = 0x0;		/* VCO gain = 0 */
+	w100_pwr_state.pll_cntl.f.pll_vcofr = 0x0;		/* VCO frequency range control = 
off */
+	w100_pwr_state.pll_cntl.f.pll_ioffset = 0x0;	/* current offset inside VCO = 
0 */
+	w100_pwr_state.pll_cntl.f.pll_ring_off = 0x0;	
+	writel((uint32_t) (w100_pwr_state.pll_cntl.val), remapped_regs + 
mmPLL_CNTL);
+
+	/* check for (tf80 >= tfgoal) && (tf20 =< tfgoal) */
+	if ((w100_pwr_state.tf80 < w100_pwr_state.tfgoal) || (w100_pwr_state.tf20 > 
w100_pwr_state.tfgoal)) {
+		status=w100_pll_adjust();
+	}
+	/* PLL Reset And Lock */
+
+	/* set VCO input = 0.5 * VDD */
+	w100_pwr_state.pll_cntl.f.pll_dactal = 0xa;
+	writel((uint32_t) (w100_pwr_state.pll_cntl.val), remapped_regs + 
mmPLL_CNTL);
+
+	/* reset time */
+	udelay(1);
+
+	/* enable charge pump */
+	w100_pwr_state.pll_cntl.f.pll_tcpoff = 0x0;	/* normal */
+	writel((uint32_t) (w100_pwr_state.pll_cntl.val), remapped_regs + 
mmPLL_CNTL);
+
+	/* set VCO input = Hi-Z */
+	/* disable DAC */
+	w100_pwr_state.pll_cntl.f.pll_dactal = 0x0;
+	writel((uint32_t) (w100_pwr_state.pll_cntl.val), remapped_regs + 
mmPLL_CNTL);
+
+	/* lock time */
+	udelay(400);	/* delay 400 us */
+
+	/* PLL locked */
+
+	w100_pwr_state.sclk_cntl.f.sclk_src_sel = 0x1;	/* PLL clock */
+	writel((uint32_t) (w100_pwr_state.sclk_cntl.val), remapped_regs + 
mmSCLK_CNTL);
+
+	w100_pwr_state.tf100 = w100_pll_get_testcount(0x1);	/* PLLCLK */
+
+	return status;
+}
+
+
+static uint8_t w100_pll_set_clk(void)
+{
+	uint8_t status;
+
+	if (w100_pwr_state.auto_mode == 1)	/* auto mode */
+	{
+		w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_hw_en = 0x0;	/* disable fast to 
normal */
+		w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_hw_en = 0x0;	/* disable normal 
to fast */
+		writel((uint32_t) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + 
mmPWRMGT_CNTL);
+	}
+
+	w100_pwr_state.sclk_cntl.f.sclk_src_sel = 0x0;	/* crystal clock */
+	writel((uint32_t) (w100_pwr_state.sclk_cntl.val), remapped_regs + 
mmSCLK_CNTL);
+
+	w100_pwr_state.pll_ref_fb_div.f.pll_ref_div = w100_pwr_state.M;
+	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_int = w100_pwr_state.N_int;
+	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_frac = w100_pwr_state.N_fac;
+	w100_pwr_state.pll_ref_fb_div.f.pll_lock_time = w100_pwr_state.lock_time;
+	writel((uint32_t) (w100_pwr_state.pll_ref_fb_div.val), remapped_regs + 
mmPLL_REF_FB_DIV);
+
+	w100_pwr_state.pwrmgt_cntl.f.pwm_mode_req = 0;
+	writel((uint32_t) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + 
mmPWRMGT_CNTL);
+
+	status = w100_pll_calibration (w100_pwr_state.freq);
+
+	if (w100_pwr_state.auto_mode == 1)	/* auto mode */
+	{
+		w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_hw_en = 0x1;	/* reenable fast to 
normal */
+		w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_hw_en = 0x1;	/* reenable normal 
to fast  */
+		writel((uint32_t) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + 
mmPWRMGT_CNTL);
+	}
+	return status;
+}
+
+
+/* assume reference crystal clk is 12.5MHz,
+ * and that doubling is not enabled.
+ *
+ * Freq = 12 == 12.5MHz.
+ */
+static uint16_t w100_set_slowsysclk(uint16_t freq)
+{
+	if (w100_pwr_state.norm_sclk == freq)
+		return freq;
+
+	if (w100_pwr_state.auto_mode == 1)	/* auto mode */
+		return 0;
+
+	if (freq == 12) {
+		w100_pwr_state.norm_sclk = freq;
+		w100_pwr_state.sclk_cntl.f.sclk_post_div_slow = 0x0;	/* Pslow = 1 */
+		w100_pwr_state.sclk_cntl.f.sclk_src_sel = 0x0;	/* crystal src */
+
+		writel((uint32_t) (w100_pwr_state.sclk_cntl.val), remapped_regs + 
mmSCLK_CNTL);
+
+		w100_pwr_state.clk_pin_cntl.f.xtalin_pm_en = 0x1;
+		writel((uint32_t) (w100_pwr_state.clk_pin_cntl.val), remapped_regs + 
mmCLK_PIN_CNTL);
+
+		w100_pwr_state.pwrmgt_cntl.f.pwm_enable = 0x1;
+		w100_pwr_state.pwrmgt_cntl.f.pwm_mode_req = 0x1;
+		writel((uint32_t) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + 
mmPWRMGT_CNTL);
+		w100_pwr_state.pwm_mode = 1;	/* normal mode */
+		return freq;
+	} else 
+		return 0;
+}
+
+
+static uint16_t w100_set_fastsysclk(uint16_t freq)
+{
+	uint16_t pll_freq;
+	int i;
+
+	while(1) {
+		pll_freq = (uint16_t) (freq * 
(w100_pwr_state.sclk_cntl.f.sclk_post_div_fast + 1));
+		i = 0;
+		do {
+			if (pll_freq == gPLLTable[i].freq) {
+				w100_pwr_state.freq = gPLLTable[i].freq * 1000000;
+				w100_pwr_state.M = gPLLTable[i].M;
+				w100_pwr_state.N_int = gPLLTable[i].N_int;
+				w100_pwr_state.N_fac = gPLLTable[i].N_fac;
+				w100_pwr_state.tfgoal = gPLLTable[i].tfgoal;
+				w100_pwr_state.lock_time = gPLLTable[i].lock_time;
+				w100_pwr_state.tf20 = 0xff;	/* set highest */
+				w100_pwr_state.tf80 = 0x00;	/* set lowest */
+
+				w100_pll_set_clk();
+				w100_pwr_state.pwm_mode = 0;	/* fast mode */
+				w100_pwr_state.fast_sclk = freq;
+				return freq;
+			}
+			i++;
+		} while(gPLLTable[i].freq);
+
+		if (w100_pwr_state.auto_mode == 1)
+			break;
+
+		if (w100_pwr_state.sclk_cntl.f.sclk_post_div_fast == 0)
+			break;
+
+		w100_pwr_state.sclk_cntl.f.sclk_post_div_fast -= 1;
+		writel((uint32_t) (w100_pwr_state.sclk_cntl.val), remapped_regs + 
mmSCLK_CNTL);
+	}
+	return 0;
+}
+
+
+/* Set up an initial state.  Some values/fields set
+   here will be overwritten. */
+static void w100_pwm_setup(void)
+{
+	w100_pwr_state.clk_pin_cntl.f.osc_en = 0x1;
+	w100_pwr_state.clk_pin_cntl.f.osc_gain = 0x1f;
+	w100_pwr_state.clk_pin_cntl.f.dont_use_xtalin = 0x0;
+	w100_pwr_state.clk_pin_cntl.f.xtalin_pm_en = 0x0;
+	w100_pwr_state.clk_pin_cntl.f.xtalin_dbl_en = 0x0;	/* no freq doubling */
+	w100_pwr_state.clk_pin_cntl.f.cg_debug = 0x0;
+	writel((uint32_t) (w100_pwr_state.clk_pin_cntl.val), remapped_regs + 
mmCLK_PIN_CNTL);
+
+	w100_pwr_state.sclk_cntl.f.sclk_src_sel = 0x0;	/* Crystal Clk */
+	w100_pwr_state.sclk_cntl.f.sclk_post_div_fast = 0x0;	/* Pfast = 1 */
+	w100_pwr_state.sclk_cntl.f.sclk_clkon_hys = 0x3;
+	w100_pwr_state.sclk_cntl.f.sclk_post_div_slow = 0x0;	/* Pslow = 1 */
+	w100_pwr_state.sclk_cntl.f.disp_cg_ok2switch_en = 0x0;
+	w100_pwr_state.sclk_cntl.f.sclk_force_reg = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_disp = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_mc = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_extmc = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_cp = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_e2 = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_e3 = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_idct = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_bist = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.busy_extend_cp = 0x0;
+	w100_pwr_state.sclk_cntl.f.busy_extend_e2 = 0x0;
+	w100_pwr_state.sclk_cntl.f.busy_extend_e3 = 0x0;
+	w100_pwr_state.sclk_cntl.f.busy_extend_idct = 0x0;
+	writel((uint32_t) (w100_pwr_state.sclk_cntl.val), remapped_regs + 
mmSCLK_CNTL);
+
+	w100_pwr_state.pclk_cntl.f.pclk_src_sel = 0x0;	/* Crystal Clk */
+	w100_pwr_state.pclk_cntl.f.pclk_post_div = 0x1;	/* P = 2 */
+	w100_pwr_state.pclk_cntl.f.pclk_force_disp = 0x0;	/* Dynamic */
+	writel((uint32_t) (w100_pwr_state.pclk_cntl.val), remapped_regs + 
mmPCLK_CNTL);
+
+	w100_pwr_state.pll_ref_fb_div.f.pll_ref_div = 0x0;	/* M = 1 */
+	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_int = 0x0;	/* N = 1.0 */
+	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_frac = 0x0;
+	w100_pwr_state.pll_ref_fb_div.f.pll_reset_time = 0x5;
+	w100_pwr_state.pll_ref_fb_div.f.pll_lock_time = 0xff;
+	writel((uint32_t) (w100_pwr_state.pll_ref_fb_div.val), remapped_regs + 
mmPLL_REF_FB_DIV);
+
+	w100_pwr_state.pll_cntl.f.pll_pwdn = 0x1;
+	w100_pwr_state.pll_cntl.f.pll_reset = 0x1;
+	w100_pwr_state.pll_cntl.f.pll_pm_en = 0x0;
+	w100_pwr_state.pll_cntl.f.pll_mode = 0x0;	/* uses VCO clock */
+	w100_pwr_state.pll_cntl.f.pll_refclk_sel = 0x0;
+	w100_pwr_state.pll_cntl.f.pll_fbclk_sel = 0x0;
+	w100_pwr_state.pll_cntl.f.pll_tcpoff = 0x0;
+	w100_pwr_state.pll_cntl.f.pll_pcp = 0x4;
+	w100_pwr_state.pll_cntl.f.pll_pvg = 0x0;
+	w100_pwr_state.pll_cntl.f.pll_vcofr = 0x0;
+	w100_pwr_state.pll_cntl.f.pll_ioffset = 0x0;
+	w100_pwr_state.pll_cntl.f.pll_pecc_mode = 0x0;
+	w100_pwr_state.pll_cntl.f.pll_pecc_scon = 0x0;
+	w100_pwr_state.pll_cntl.f.pll_dactal = 0x0;	/* Hi-Z */
+	w100_pwr_state.pll_cntl.f.pll_cp_clip = 0x3;
+	w100_pwr_state.pll_cntl.f.pll_conf = 0x2;
+	w100_pwr_state.pll_cntl.f.pll_mbctrl = 0x2;
+	w100_pwr_state.pll_cntl.f.pll_ring_off = 0x0;
+	writel((uint32_t) (w100_pwr_state.pll_cntl.val), remapped_regs + 
mmPLL_CNTL);
+
+	w100_pwr_state.clk_test_cntl.f.testclk_sel = 0x1;	/* PLLCLK (for testing) */
+	w100_pwr_state.clk_test_cntl.f.start_check_freq = 0x0;
+	w100_pwr_state.clk_test_cntl.f.tstcount_rst = 0x0;
+	writel((uint32_t) (w100_pwr_state.clk_test_cntl.val), remapped_regs + 
mmCLK_TEST_CNTL);
+
+	w100_pwr_state.pwrmgt_cntl.f.pwm_enable = 0x0;
+	w100_pwr_state.pwrmgt_cntl.f.pwm_mode_req = 0x1;	/* normal mode (0, 1, 3) */
+	w100_pwr_state.pwrmgt_cntl.f.pwm_wakeup_cond = 0x0;
+	w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_hw_en = 0x0;
+	w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_hw_en = 0x0;
+	w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_cond = 0x1;	/* PM4,ENG */
+	w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_cond = 0x1;	/* PM4,ENG */
+	w100_pwr_state.pwrmgt_cntl.f.pwm_idle_timer = 0xFF;
+	w100_pwr_state.pwrmgt_cntl.f.pwm_busy_timer = 0xFF;
+	writel((uint32_t) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + 
mmPWRMGT_CNTL);
+
+	w100_pwr_state.auto_mode = 0;	/* manual mode */
+	w100_pwr_state.pwm_mode = 1;	/* normal mode (0, 1, 2) */
+	w100_pwr_state.freq = 50000000;	/* 50 MHz */
+	w100_pwr_state.M = 3;	/* M = 4 */
+	w100_pwr_state.N_int = 6;	/* N = 7.0 */
+	w100_pwr_state.N_fac = 0;	
+	w100_pwr_state.tfgoal = 0xE0;
+	w100_pwr_state.lock_time = 56;
+	w100_pwr_state.tf20 = 0xff;	/* set highest */
+	w100_pwr_state.tf80 = 0x00;	/* set lowest */
+	w100_pwr_state.tf100 = 0x00;	/* set lowest */
+	w100_pwr_state.fast_sclk = 50;	/* 50.0 MHz */
+	w100_pwr_state.norm_sclk = 12;	/* 12.5 MHz */
+}
+
+
+static void w100_init_sharp_lcd(uint32_t mode)
+{
+	uint32_t temp32;
+	union disp_db_buf_cntl_wr_u disp_db_buf_wr_cntl;
+
+	/* Prevent display updates */
+	disp_db_buf_wr_cntl.f.db_buf_cntl = 0x1e;
+	disp_db_buf_wr_cntl.f.update_db_buf = 0;
+	disp_db_buf_wr_cntl.f.en_db_buf = 0;
+	writel((uint32_t) (disp_db_buf_wr_cntl.val), remapped_regs + 
mmDISP_DB_BUF_CNTL);
+
+	switch(mode) {
+	case LCD_SHARP_QVGA:
+		w100_set_slowsysclk(12);	/* use crystal -- 12.5MHz */
+		/* not use PLL */
+
+		writel(0x7FFF8000, remapped_regs + mmMC_EXT_MEM_LOCATION);
+		writel(0x85FF8000, remapped_regs + mmMC_FB_LOCATION);
+		writel(0x00000003, remapped_regs + mmLCD_FORMAT);
+		writel(0x00CF1C06, remapped_regs + mmGRAPHIC_CTRL);
+		writel(0x01410145, remapped_regs + mmCRTC_TOTAL);
+		writel(0x01170027, remapped_regs + mmACTIVE_H_DISP);
+		writel(0x01410001, remapped_regs + mmACTIVE_V_DISP);
+		writel(0x01170027, remapped_regs + mmGRAPHIC_H_DISP);
+		writel(0x01410001, remapped_regs + mmGRAPHIC_V_DISP);
+		writel(0x81170027, remapped_regs + mmCRTC_SS);
+		writel(0xA0140000, remapped_regs + mmCRTC_LS);
+		writel(0x00400008, remapped_regs + mmCRTC_REV);
+		writel(0xA0000000, remapped_regs + mmCRTC_DCLK);
+		writel(0xC0140014, remapped_regs + mmCRTC_GS);
+		writel(0x00010141, remapped_regs + mmCRTC_VPOS_GS);
+		writel(0x8015010F, remapped_regs + mmCRTC_GCLK);
+		writel(0x80100110, remapped_regs + mmCRTC_GOE);
+		writel(0x00000000, remapped_regs + mmCRTC_FRAME);
+		writel(0x00000000, remapped_regs + mmCRTC_FRAME_VPOS);
+		writel(0x01CC0000, remapped_regs + mmLCDD_CNTL1);
+		writel(0x0003FFFF, remapped_regs + mmLCDD_CNTL2);
+		writel(0x00FFFF0D, remapped_regs + mmGENLCD_CNTL1);
+		writel(0x003F3003, remapped_regs + mmGENLCD_CNTL2);
+		writel(0x00000000, remapped_regs + mmCRTC_DEFAULT_COUNT);
+		writel(0x0000FF00, remapped_regs + mmLCD_BACKGROUND_COLOR);
+		writel(0x000102aa, remapped_regs + mmGENLCD_CNTL3);
+		writel(0x00800000, remapped_regs + mmGRAPHIC_OFFSET);
+		writel(0x000001e0, remapped_regs + mmGRAPHIC_PITCH);
+		writel(0x000000bf, remapped_regs + mmGPIO_DATA);
+		writel(0x03c0feff, remapped_regs + mmGPIO_CNTL2);
+		writel(0x00000000, remapped_regs + mmGPIO_CNTL1);
+		writel(0x41060010, remapped_regs + mmCRTC_PS1_ACTIVE);
+		break;
+	case LCD_SHARP_VGA:
+		w100_set_slowsysclk(12);	/* use crystal -- 12.5MHz */
+		w100_set_fastsysclk(current_par->fastsysclk_mode);	/* use PLL -- 75.0MHz */
+		w100_pwr_state.pclk_cntl.f.pclk_src_sel = 0x1;
+		w100_pwr_state.pclk_cntl.f.pclk_post_div = 0x2;
+		writel((uint32_t) (w100_pwr_state.pclk_cntl.val), remapped_regs + 
mmPCLK_CNTL);
+		writel(0x15FF1000, remapped_regs + mmMC_FB_LOCATION);
+		writel(0x9FFF8000, remapped_regs + mmMC_EXT_MEM_LOCATION);
+		writel(0x00000003, remapped_regs + mmLCD_FORMAT);
+		writel(0x00DE1D66, remapped_regs + mmGRAPHIC_CTRL);
+
+		writel(0x0283028B, remapped_regs + mmCRTC_TOTAL);
+		writel(0x02360056, remapped_regs + mmACTIVE_H_DISP);
+		writel(0x02830003, remapped_regs + mmACTIVE_V_DISP);
+		writel(0x02360056, remapped_regs + mmGRAPHIC_H_DISP);
+		writel(0x02830003, remapped_regs + mmGRAPHIC_V_DISP);
+		writel(0x82360056, remapped_regs + mmCRTC_SS);
+		writel(0xA0280000, remapped_regs + mmCRTC_LS);
+		writel(0x00400008, remapped_regs + mmCRTC_REV);
+		writel(0xA0000000, remapped_regs + mmCRTC_DCLK);
+		writel(0x80280028, remapped_regs + mmCRTC_GS);
+		writel(0x02830002, remapped_regs + mmCRTC_VPOS_GS);
+		writel(0x8015010F, remapped_regs + mmCRTC_GCLK);
+		writel(0x80100110, remapped_regs + mmCRTC_GOE);
+		writel(0x00000000, remapped_regs + mmCRTC_FRAME);
+		writel(0x00000000, remapped_regs + mmCRTC_FRAME_VPOS);
+		writel(0x01CC0000, remapped_regs + mmLCDD_CNTL1);
+		writel(0x0003FFFF, remapped_regs + mmLCDD_CNTL2);
+		writel(0x00FFFF0D, remapped_regs + mmGENLCD_CNTL1);
+		writel(0x003F3003, remapped_regs + mmGENLCD_CNTL2);
+		writel(0x00000000, remapped_regs + mmCRTC_DEFAULT_COUNT);
+		writel(0x0000FF00, remapped_regs + mmLCD_BACKGROUND_COLOR);
+		writel(0x000102aa, remapped_regs + mmGENLCD_CNTL3);
+		writel(0x00800000, remapped_regs + mmGRAPHIC_OFFSET);
+		writel(0x000003C0, remapped_regs + mmGRAPHIC_PITCH);
+		writel(0x000000bf, remapped_regs + mmGPIO_DATA);
+		writel(0x03c0feff, remapped_regs + mmGPIO_CNTL2);
+		writel(0x00000000, remapped_regs + mmGPIO_CNTL1);
+		writel(0x41060010, remapped_regs + mmCRTC_PS1_ACTIVE);
+		break;
+	default:
+		break;
+	}
+
+	/* Hack for overlay in ext memory */
+	temp32 = readl(remapped_regs + mmDISP_DEBUG2);
+	temp32 |= 0xc0000000;
+	writel(temp32, remapped_regs + mmDISP_DEBUG2);
+
+	/* Re-enable display updates */
+	disp_db_buf_wr_cntl.f.db_buf_cntl = 0x1e;
+	disp_db_buf_wr_cntl.f.update_db_buf = 1;
+	disp_db_buf_wr_cntl.f.en_db_buf = 1;
+	writel((uint32_t) (disp_db_buf_wr_cntl.val), remapped_regs + 
mmDISP_DB_BUF_CNTL);
+}
+
+
+static void w100_set_vga_rotation_regs(uint16_t divider, unsigned long ctrl, 
unsigned long offset, unsigned long pitch)
+{
+	w100_pwr_state.pclk_cntl.f.pclk_src_sel = 0x1;
+	w100_pwr_state.pclk_cntl.f.pclk_post_div = divider;
+	writel((uint32_t) (w100_pwr_state.pclk_cntl.val), remapped_regs + 
mmPCLK_CNTL);
+
+	writel(ctrl, remapped_regs + mmGRAPHIC_CTRL);
+	writel(offset, remapped_regs + mmGRAPHIC_OFFSET);
+	writel(pitch, remapped_regs + mmGRAPHIC_PITCH);
+
+	/* Re-enable display updates */
+	writel(0x0000007b, remapped_regs + mmDISP_DB_BUF_CNTL);
+}
+
+
+static void w100_init_vga_rotation(uint16_t deg)
+{
+	switch(deg) {
+	case 0:
+		w100_set_vga_rotation_regs(0x02, 0x00DE1D66, 0x00800000, 0x000003c0);
+		break;
+	case 90:
+		w100_set_vga_rotation_regs(0x06, 0x00DE1D0e, 0x00895b00, 0x00000500);
+		break;
+	case 180:
+		w100_set_vga_rotation_regs(0x02, 0x00DE1D7e, 0x00895ffc, 0x000003c0);
+		break;
+	case 270:
+		w100_set_vga_rotation_regs(0x06, 0x00DE1D16, 0x008004fc, 0x00000500);
+		break;
+	default:
+		/* not-support */
+		break;
+	}
+}
+
+
+static void w100_set_qvga_rotation_regs(unsigned long ctrl, unsigned long 
offset, unsigned long pitch)
+{
+	writel(ctrl, remapped_regs + mmGRAPHIC_CTRL);
+	writel(offset, remapped_regs + mmGRAPHIC_OFFSET);
+	writel(pitch, remapped_regs + mmGRAPHIC_PITCH);
+
+	/* Re-enable display updates */
+	writel(0x0000007b, remapped_regs + mmDISP_DB_BUF_CNTL);
+}
+
+
+static void w100_init_qvga_rotation(uint16_t deg)
+{
+	switch(deg) {
+	case 0:
+		w100_set_qvga_rotation_regs(0x00d41c06, 0x00800000, 0x000001e0);		
+		break;
+	case 90:
+		w100_set_qvga_rotation_regs(0x00d41c0E, 0x00825580, 0x00000280);	
+		break;
+	case 180:
+		w100_set_qvga_rotation_regs(0x00d41c1e, 0x008257fc, 0x000001e0);
+		break;
+	case 270:
+		w100_set_qvga_rotation_regs(0x00d41c16, 0x0080027c, 0x00000280);
+		break;
+	default:
+		/* not-support */
+		break;
+	}
+}
+
+
+static void w100_suspend(uint32_t mode)
+{
+	uint32_t val;
+
+	writel(0x7FFF8000, remapped_regs + mmMC_EXT_MEM_LOCATION);
+	writel(0x00FF0000, remapped_regs + mmMC_PERF_MON_CNTL);
+
+	val = readl(remapped_regs + mmMEM_EXT_TIMING_CNTL);
+	val &= ~(0x00100000);	/* bit20=0 */
+	val |= 0xFF000000;	/* bit31:24=0xff */
+	writel(val, remapped_regs + mmMEM_EXT_TIMING_CNTL);
+
+	val = readl(remapped_regs + mmMEM_EXT_CNTL);
+	val &= ~(0x00040000);	/* bit18=0 */
+	val |= 0x00080000;	/* bit19=1 */
+	writel(val, remapped_regs + mmMEM_EXT_CNTL);
+
+	udelay(1);		/* wait 1us */
+
+	if (mode == W100_SUSPEND_EXTMEM) {
+
+		/* CKE: Tri-State */
+		val = readl(remapped_regs + mmMEM_EXT_CNTL);
+		val |= 0x40000000;	/* bit30=1 */
+		writel(val, remapped_regs + mmMEM_EXT_CNTL);
+
+		/* CLK: Stop */
+		val = readl(remapped_regs + mmMEM_EXT_CNTL);
+		val &= ~(0x00000001);	/* bit0=0 */
+		writel(val, remapped_regs + mmMEM_EXT_CNTL);
+	} else {
+
+		writel(0x00000000, remapped_regs + mmSCLK_CNTL);
+		writel(0x000000BF, remapped_regs + mmCLK_PIN_CNTL);
+		writel(0x00000015, remapped_regs + mmPWRMGT_CNTL);
+
+		udelay(5);	
+
+		val = readl(remapped_regs + mmPLL_CNTL);
+		val |= 0x00000004;	/* bit2=1 */
+		writel(val, remapped_regs + mmPLL_CNTL);
+		writel(0x0000001d, remapped_regs + mmPWRMGT_CNTL);
+	}
+}
+
+
+static void w100_resume(void)
+{
+	uint32_t temp32;
+
+	w100_hw_init();
+	w100_pwm_setup();
+
+	temp32 = readl(remapped_regs + mmDISP_DEBUG2);
+	temp32 &= 0xff7fffff;
+	temp32 |= 0x00800000;
+	writel(temp32, remapped_regs + mmDISP_DEBUG2);
+
+	if (current_par->lcdMode == LCD_MODE_480 || current_par->lcdMode == 
LCD_MODE_640) {
+		w100_init_sharp_lcd(LCD_SHARP_VGA);
+		if (current_par->lcdMode == LCD_MODE_640) {
+			w100_init_vga_rotation(current_par->rotation_flag ? 270 : 90);
+		}
+	} else {
+		w100_init_sharp_lcd(LCD_SHARP_QVGA);
+		if (current_par->lcdMode == LCD_MODE_320) {
+			w100_init_qvga_rotation(current_par->rotation_flag ? 270 : 90);
+		}
+	}
+}
+
+
+static void w100_vsync(void)
+{
+	uint32_t tmp;
+	int timeout = 30000; /* VSync timeout = 30[ms] > 16.8[ms] */
+
+	tmp = readl(remapped_regs + mmACTIVE_V_DISP);
+
+	/* set vline pos  */
+	writel((tmp >> 16) & 0x3ff, remapped_regs + mmDISP_INT_CNTL);
+
+	/* disable vline irq */
+	tmp = readl(remapped_regs + mmGEN_INT_CNTL);
+
+	tmp &= ~0x00000002;
+	writel(tmp, remapped_regs + mmGEN_INT_CNTL);
+
+	/* clear vline irq status */
+	writel(0x00000002, remapped_regs + mmGEN_INT_STATUS);
+
+	/* enable vline irq */
+	writel((tmp | 0x00000002), remapped_regs + mmGEN_INT_CNTL);
+
+	/* clear vline irq status */
+	writel(0x00000002, remapped_regs + mmGEN_INT_STATUS);
+
+	while(timeout > 0) {
+		if (readl(remapped_regs + mmGEN_INT_STATUS) & 0x00000002)
+			break;
+		udelay(1);
+		timeout--;
+	}
+
+	/* disable vline irq */
+	writel(tmp, remapped_regs + mmGEN_INT_CNTL);
+
+	/* clear vline irq status */
+	writel(0x00000002, remapped_regs + mmGEN_INT_STATUS);
+}
+
+
+static void w100_InitExtMem(uint32_t mode)
+{
+	switch(mode) {
+	case LCD_SHARP_QVGA:
+		/* QVGA doesn't use external memory
+		   nothing to do, really. */
+		break;
+	case LCD_SHARP_VGA:
+		writel(0x00007800, remapped_regs + mmMC_BIST_CTRL);
+		writel(0x00040003, remapped_regs + mmMEM_EXT_CNTL);
+		writel(0x00200021, remapped_regs + mmMEM_SDRAM_MODE_REG);
+		udelay(100);
+		writel(0x80200021, remapped_regs + mmMEM_SDRAM_MODE_REG);
+		udelay(100);
+		writel(0x00650021, remapped_regs + mmMEM_SDRAM_MODE_REG);
+		udelay(100);
+		writel(0x10002a4a, remapped_regs + mmMEM_EXT_TIMING_CNTL);
+		writel(0x7ff87012, remapped_regs + mmMEM_IO_CNTL);
+		break;
+	default:
+		break;
+	}
+}
+
+
+#define RESCTL_ADRS     0x00
+#define PHACTRL_ADRS	0x01
+#define DUTYCTRL_ADRS	0x02
+#define POWERREG0_ADRS	0x03
+#define POWERREG1_ADRS	0x04
+#define GPOR3_ADRS		0x05
+#define PICTRL_ADRS     0x06
+#define POLCTRL_ADRS    0x07
+
+#define RESCTL_QVGA     0x01
+#define RESCTL_VGA      0x00
+
+#define POWER1_VW_ON	0x01	/* VW Supply FET ON */
+#define POWER1_GVSS_ON	0x02	/* GVSS(-8V) Power Supply ON */
+#define POWER1_VDD_ON	0x04	/* VDD(8V),SVSS(-4V) Power Supply ON */
+
+#define POWER1_VW_OFF	0x00	/* VW Supply FET OFF */
+#define POWER1_GVSS_OFF	0x00	/* GVSS(-8V) Power Supply OFF */
+#define POWER1_VDD_OFF	0x00	/* VDD(8V),SVSS(-4V) Power Supply OFF */
+
+#define POWER0_COM_DCLK	0x01	/* COM Voltage DC Bias DAC Serial Data Clock */
+#define POWER0_COM_DOUT	0x02	/* COM Voltage DC Bias DAC Serial Data Out */
+#define POWER0_DAC_ON	0x04	/* DAC Power Supply ON */
+#define POWER0_COM_ON	0x08	/* COM Powewr Supply ON */
+#define POWER0_VCC5_ON	0x10	/* VCC5 Power Supply ON */
+
+#define POWER0_DAC_OFF	0x00	/* DAC Power Supply OFF */
+#define POWER0_COM_OFF	0x00	/* COM Powewr Supply OFF */
+#define POWER0_VCC5_OFF	0x00	/* VCC5 Power Supply OFF */
+
+#define PICTRL_INIT_STATE	0x01
+#define PICTRL_INIOFF		0x02
+#define PICTRL_POWER_DOWN	0x04
+#define PICTRL_COM_SIGNAL_OFF	0x08
+#define PICTRL_DAC_SIGNAL_OFF	0x10
+
+#define PICTRL_POWER_ACTIVE	(0)
+
+#define POLCTRL_SYNC_POL_FALL	0x01
+#define POLCTRL_EN_POL_FALL	0x02
+#define POLCTRL_DATA_POL_FALL	0x04
+#define POLCTRL_SYNC_ACT_H	0x08
+#define POLCTRL_EN_ACT_L	0x10
+
+#define POLCTRL_SYNC_POL_RISE	0x00
+#define POLCTRL_EN_POL_RISE	0x00
+#define POLCTRL_DATA_POL_RISE	0x00
+#define POLCTRL_SYNC_ACT_L	0x00
+#define POLCTRL_EN_ACT_H	0x00
+
+#define PHACTRL_PHASE_MANUAL	0x01
+
+#define PHAD_QVGA_DEFAULT_VAL (9)
+#define COMADJ_DEFAULT        (125)
+
+static void lcdtg_ssp_send(uint8_t adrs, uint8_t data)
+{
+	w100fb_ssp_send(adrs,data);
+}
+
+/*
+ * This is only a psuedo I2C interface. We can't use the standard kernel 
+ * routines as the interface is write only. We just assume the data is 
acked...
+ */
+static void lcdtg_ssp_i2c_send(uint8_t data)
+{
+	lcdtg_ssp_send(POWERREG0_ADRS, data);
+	udelay(10);
+}
+
+static void lcdtg_i2c_send_bit(uint8_t data)
+{
+	lcdtg_ssp_i2c_send(data);
+	lcdtg_ssp_i2c_send(data | POWER0_COM_DCLK);
+	lcdtg_ssp_i2c_send(data);
+}
+
+static void lcdtg_i2c_send_start(uint8_t base)
+{
+	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK | POWER0_COM_DOUT);
+	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK);
+	lcdtg_ssp_i2c_send(base);
+}
+
+static void lcdtg_i2c_send_stop(uint8_t base)
+{
+	lcdtg_ssp_i2c_send(base);
+	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK);
+	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK | POWER0_COM_DOUT);
+}
+
+static void lcdtg_i2c_send_byte(uint8_t base, uint8_t data)
+{
+	int i;
+	for (i = 0; i < 8; i++) {
+		if (data & 0x80) 
+			lcdtg_i2c_send_bit(base | POWER0_COM_DOUT);
+		else 
+			lcdtg_i2c_send_bit(base);
+		data <<= 1;
+	}
+}
+
+static void lcdtg_i2c_wait_ack(uint8_t base)
+{
+	lcdtg_i2c_send_bit(base);
+}
+
+static void lcdtg_set_common_voltage(uint8_t base_data, uint8_t data)
+{
+	/* Set Common Voltage to M62332FP via I2C */
+	lcdtg_i2c_send_start(base_data);
+	lcdtg_i2c_send_byte(base_data, 0x9c);
+	lcdtg_i2c_wait_ack(base_data);
+	lcdtg_i2c_send_byte(base_data, 0x00);
+	lcdtg_i2c_wait_ack(base_data);
+	lcdtg_i2c_send_byte(base_data, data);
+	lcdtg_i2c_wait_ack(base_data);
+	lcdtg_i2c_send_stop(base_data);
+}
+
+static struct lcdtg_register_setting {
+	uint8_t adrs;
+	uint8_t data;
+	uint32_t wait;
+} lcdtg_power_on_table[] = {
+
+    /* Initialize Internal Logic & Port */
+    { PICTRL_ADRS, 
+      PICTRL_POWER_DOWN | PICTRL_INIOFF | PICTRL_INIT_STATE |
+      PICTRL_COM_SIGNAL_OFF | PICTRL_DAC_SIGNAL_OFF,
+      0 }, 
+
+    { POWERREG0_ADRS,
+      POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_OFF | POWER0_COM_OFF | 
+      POWER0_VCC5_OFF,
+      0 },
+
+    { POWERREG1_ADRS,
+      POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_OFF,
+      0 },
+
+    /* VDD(+8V),SVSS(-4V) ON */
+    { POWERREG1_ADRS,
+      POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_ON /* VDD ON */,
+      3000 },
+
+    /* DAC ON */
+    { POWERREG0_ADRS,
+      POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON /* DAC ON */ | 
+      POWER0_COM_OFF | POWER0_VCC5_OFF,
+      0 },
+
+    /* INIB = H, INI = L  */
+    { PICTRL_ADRS, 
+      /* PICTL[0] = H , PICTL[1] = PICTL[2] = PICTL[4] = L */
+      PICTRL_INIT_STATE | PICTRL_COM_SIGNAL_OFF,
+      0 }, 
+
+    /* Set Common Voltage */
+    { 0xfe, 0, 0 },
+
+    /* VCC5 ON */
+    { POWERREG0_ADRS,
+      POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON /* DAC ON */ | 
+      POWER0_COM_OFF | POWER0_VCC5_ON /* VCC5 ON */,
+      0 },
+
+    /* GVSS(-8V) ON */
+    { POWERREG1_ADRS,
+      POWER1_VW_OFF | POWER1_GVSS_ON /* GVSS ON */ | 
+      POWER1_VDD_ON /* VDD ON */,
+      2000 },
+
+    /* COM SIGNAL ON (PICTL[3] = L) */
+    { PICTRL_ADRS, 
+      PICTRL_INIT_STATE,
+      0 },
+
+    /* COM ON */
+    { POWERREG0_ADRS,
+      POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON /* DAC ON */ | 
+      POWER0_COM_ON /* COM ON */ | POWER0_VCC5_ON /* VCC5_ON */,
+      0 },
+
+    /* VW ON */
+    { POWERREG1_ADRS,
+      POWER1_VW_ON /* VW ON */ | POWER1_GVSS_ON /* GVSS ON */ | 
+      POWER1_VDD_ON /* VDD ON */,
+      0 /* Wait 100ms */ },
+
+    /* Signals output enable */
+    { PICTRL_ADRS, 
+      0 /* Signals output enable */,
+      0 },
+
+    { PHACTRL_ADRS,
+      PHACTRL_PHASE_MANUAL,
+      0 },
+
+    /* Initialize for Input Signals from ATI */
+    { POLCTRL_ADRS,
+      POLCTRL_SYNC_POL_RISE | POLCTRL_EN_POL_RISE | POLCTRL_DATA_POL_RISE |
+      POLCTRL_SYNC_ACT_L | POLCTRL_EN_ACT_H,
+      1000 /*100000*/ /* Wait 100ms */ },
+
+    /* end mark */
+    { 0xff, 0, 0 }
+};
+
+static void lcdtg_resume(void)
+{
+	if (current_par->lcdMode == LCD_MODE_480 || current_par->lcdMode == 
LCD_MODE_640) {
+		lcdtg_hw_init(LCD_SHARP_VGA);
+	} else {
+		lcdtg_hw_init(LCD_SHARP_QVGA);
+	}
+}
+
+static void lcdtg_suspend(void)
+{
+	int i;
+
+	for (i = 0; i < (current_par->xres * current_par->yres); i++) {
+		writew(0xffff, remapped_fbuf + (2*i));
+	}
+
+	/* 60Hz x 2 frame = 16.7msec x 2 = 33.4 msec */
+	mdelay(34);
+
+	/* (1)VW OFF */  
+	lcdtg_ssp_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_ON | 
POWER1_VDD_ON);
+
+	/* (2)COM OFF */  
+	lcdtg_ssp_send(PICTRL_ADRS, PICTRL_COM_SIGNAL_OFF);
+	lcdtg_ssp_send(POWERREG0_ADRS, POWER0_DAC_ON | POWER0_COM_OFF | 
POWER0_VCC5_ON);
+
+	/* (3)Set Common Voltage Bias 0V */
+	lcdtg_set_common_voltage(POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_ON, 
0);
+
+	/* (4)GVSS OFF */
+	lcdtg_ssp_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | 
POWER1_VDD_ON);
+
+	/* (5)VCC5 OFF */
+	lcdtg_ssp_send(POWERREG0_ADRS, POWER0_DAC_ON | POWER0_COM_OFF | 
POWER0_VCC5_OFF);
+
+	/* (6)Set PDWN, INIOFF, DACOFF */
+	lcdtg_ssp_send(PICTRL_ADRS, PICTRL_INIOFF | PICTRL_DAC_SIGNAL_OFF |
+			PICTRL_POWER_DOWN | PICTRL_COM_SIGNAL_OFF);
+
+	/* (7)DAC OFF */
+	lcdtg_ssp_send(POWERREG0_ADRS, POWER0_DAC_OFF | POWER0_COM_OFF | 
POWER0_VCC5_OFF);
+
+	/* (8)VDD OFF */
+	lcdtg_ssp_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | 
POWER1_VDD_OFF);
+
+}
+
+static void lcdtg_set_phadadj(uint32_t mode)
+{
+	int adj;
+
+	if (mode == LCD_SHARP_VGA) {
+		/* Setting for VGA */
+		adj = current_par->phadadj;
+		if (adj < 0) {
+			adj = PHACTRL_PHASE_MANUAL;
+		} else {
+			adj = ((adj & 0x0f) << 1) | PHACTRL_PHASE_MANUAL;
+		}
+	} else {
+		/* Setting for QVGA */
+		adj = (PHAD_QVGA_DEFAULT_VAL << 1) | PHACTRL_PHASE_MANUAL;
+	}
+	lcdtg_ssp_send(PHACTRL_ADRS, adj);
+}
+
+static void lcdtg_hw_init(uint32_t mode)
+{
+	int i;
+	int comadj;
+
+	i = 0;
+	while(lcdtg_power_on_table[i].adrs != 0xff) {
+		if (lcdtg_power_on_table[i].adrs == 0xfe) {
+			/* Set Common Voltage */
+			comadj = current_par->comadj;
+			if (comadj < 0) {
+				comadj = COMADJ_DEFAULT;
+			}
+			lcdtg_set_common_voltage((POWER0_DAC_ON | POWER0_COM_OFF | 
POWER0_VCC5_OFF), comadj);
+		} else if (lcdtg_power_on_table[i].adrs == PHACTRL_ADRS) {
+			/* Set Phase Adjuct */
+			lcdtg_set_phadadj(mode);
+		} else {
+			/* Other */
+			lcdtg_ssp_send(lcdtg_power_on_table[i].adrs, 
lcdtg_power_on_table[i].data);
+		}
+		if (lcdtg_power_on_table[i].wait != 0)
+			udelay(lcdtg_power_on_table[i].wait);
+		i++;
+	}
+
+	switch(mode) {
+	case LCD_SHARP_QVGA:
+		/* Set Lcd Resolution (QVGA) */
+		lcdtg_ssp_send(RESCTL_ADRS, RESCTL_QVGA);
+		break;
+	case LCD_SHARP_VGA:
+		/* Set Lcd Resolution (VGA) */
+		lcdtg_ssp_send(RESCTL_ADRS, RESCTL_VGA);
+		break;
+	default:
+		break;
+	}
+}
+
+static void lcdtg_lcd_change(uint32_t mode)
+{
+	/* Set Phase Adjuct */
+	lcdtg_set_phadadj(mode);
+
+	if (mode == LCD_SHARP_VGA)
+		/* Set Lcd Resolution (VGA) */
+		lcdtg_ssp_send(RESCTL_ADRS, RESCTL_VGA);
+	else if (mode == LCD_SHARP_QVGA)
+		/* Set Lcd Resolution (QVGA) */
+		lcdtg_ssp_send(RESCTL_ADRS, RESCTL_QVGA);
+}
+
+
+static struct device_driver w100fb_driver = {
+	.name		= "w100fb",
+	.bus		= &platform_bus_type,
+	.probe		= w100fb_probe,
+	.remove		= w100fb_remove,
+	.suspend	= w100fb_suspend,
+	.resume		= w100fb_resume,
+};
+
+int __devinit w100fb_init(void)
+{
+	return driver_register(&w100fb_driver);
+}
+
+void __exit w100fb_cleanup(void)
+{
+ 	driver_unregister(&w100fb_driver);
+}
+
+module_init(w100fb_init);
+module_exit(w100fb_cleanup);
+
+MODULE_DESCRIPTION("ATI Imageon w100 framebuffer driver");
+MODULE_LICENSE("GPLv2");
--- /dev/null
+++ linux-2.6.10/drivers/video/w100fb.h
@@ -0,0 +1,615 @@
+/*
+ * linux/drivers/video/w100fb.h
+ *
+ * Frame Buffer Device for ATI w100 (Wallaby)
+ *
+ * Copyright (C) 2002, ATI Corp.
+ * Copyright (C) 2004-2005 Richard Purdie
+ * 
+ * Modified to work with 2.6 by Richard Purdie <rpurdie@rpsys.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#if !defined (_W100FB_H)
+#define _W100FB_H
+
+/* Block CIF Start: */
+#define mmCHIP_ID           0x0000
+#define mmREVISION_ID		0x0004
+#define mmWRAP_BUF_A        0x0008
+#define mmWRAP_BUF_B        0x000C
+#define mmWRAP_TOP_DIR      0x0010
+#define mmWRAP_START_DIR    0x0014
+#define mmCIF_CNTL          0x0018
+#define mmCFGREG_BASE       0x001C
+#define mmCIF_IO            0x0020
+#define mmCIF_READ_DBG      0x0024
+#define mmCIF_WRITE_DBG     0x0028
+#define cfgIND_ADDR_A_0     0x0000
+#define cfgIND_ADDR_A_1     0x0001
+#define cfgIND_ADDR_A_2     0x0002
+#define cfgIND_DATA_A       0x0003
+#define cfgREG_BASE         0x0004
+#define cfgINTF_CNTL        0x0005
+#define cfgSTATUS           0x0006
+#define cfgCPU_DEFAULTS     0x0007
+#define cfgIND_ADDR_B_0     0x0008
+#define cfgIND_ADDR_B_1     0x0009
+#define cfgIND_ADDR_B_2     0x000A
+#define cfgIND_DATA_B       0x000B
+#define cfgPM4_RPTR         0x000C
+#define cfgSCRATCH          0x000D
+#define cfgPM4_WRPTR_0      0x000E
+#define cfgPM4_WRPTR_1      0x000F
+/* Block CIF End: */
+
+/* Block CP Start: */
+#define mmSCRATCH_UMSK      0x0280
+#define mmSCRATCH_ADDR      0x0284
+#define mmGEN_INT_CNTL      0x0200
+#define mmGEN_INT_STATUS    0x0204
+/* Block CP End: */
+
+/* Block DISPLAY Start: */
+#define mmLCD_FORMAT        0x0410
+#define mmGRAPHIC_CTRL      0x0414
+#define mmGRAPHIC_OFFSET    0x0418
+#define mmGRAPHIC_PITCH     0x041C
+#define mmCRTC_TOTAL        0x0420
+#define mmACTIVE_H_DISP     0x0424
+#define mmACTIVE_V_DISP     0x0428
+#define mmGRAPHIC_H_DISP    0x042C
+#define mmGRAPHIC_V_DISP    0x0430
+#define mmVIDEO_CTRL        0x0434
+#define mmGRAPHIC_KEY       0x0438
+#define mmBRIGHTNESS_CNTL   0x045C
+#define mmDISP_INT_CNTL     0x0488
+#define mmCRTC_SS           0x048C
+#define mmCRTC_LS           0x0490
+#define mmCRTC_REV          0x0494
+#define mmCRTC_DCLK         0x049C
+#define mmCRTC_GS           0x04A0
+#define mmCRTC_VPOS_GS      0x04A4
+#define mmCRTC_GCLK         0x04A8
+#define mmCRTC_GOE          0x04AC
+#define mmCRTC_FRAME        0x04B0
+#define mmCRTC_FRAME_VPOS   0x04B4
+#define mmGPIO_DATA         0x04B8
+#define mmGPIO_CNTL1        0x04BC
+#define mmGPIO_CNTL2        0x04C0
+#define mmLCDD_CNTL1        0x04C4
+#define mmLCDD_CNTL2        0x04C8
+#define mmGENLCD_CNTL1      0x04CC
+#define mmGENLCD_CNTL2      0x04D0
+#define mmDISP_DEBUG        0x04D4
+#define mmDISP_DB_BUF_CNTL  0x04D8
+#define mmDISP_CRC_SIG      0x04DC
+#define mmCRTC_DEFAULT_COUNT 	0x04E0
+#define mmLCD_BACKGROUND_COLOR  0x04E4
+#define mmCRTC_PS2          0x04E8
+#define mmCRTC_PS2_VPOS     0x04EC
+#define mmCRTC_PS1_ACTIVE   0x04F0
+#define mmCRTC_PS1_NACTIVE  0x04F4
+#define mmCRTC_GCLK_EXT     0x04F8
+#define mmCRTC_ALW          0x04FC
+#define mmCRTC_ALW_VPOS     0x0500
+#define mmCRTC_PSK          0x0504
+#define mmCRTC_PSK_HPOS     0x0508
+#define mmCRTC_CV4_START    0x050C
+#define mmCRTC_CV4_END      0x0510
+#define mmCRTC_CV4_HPOS     0x0514
+#define mmCRTC_ECK          0x051C
+#define mmREFRESH_CNTL      0x0520
+#define mmGENLCD_CNTL3      0x0524
+#define mmGPIO_DATA2        0x0528
+#define mmGPIO_CNTL3        0x052C
+#define mmGPIO_CNTL4        0x0530
+#define mmCHIP_STRAP        0x0534
+#define mmDISP_DEBUG2       0x0538
+#define mmDEBUG_BUS_CNTL    0x053C
+#define mmGAMMA_VALUE1      0x0540
+#define mmGAMMA_VALUE2      0x0544
+#define mmGAMMA_SLOPE       0x0548
+#define mmGEN_STATUS        0x054C
+#define mmHW_INT            0x0550
+/* Block DISPLAY End: */
+
+/* Block GFX Start: */
+#define mmBRUSH_OFFSET      0x108C
+#define mmBRUSH_Y_X         0x1074
+#define mmDEFAULT_PITCH_OFFSET		0x10A0
+#define mmDEFAULT_SC_BOTTOM_RIGHT	0x10A8
+#define mmDEFAULT2_SC_BOTTOM_RIGHT	0x10AC
+#define mmGLOBAL_ALPHA      0x1210
+#define mmFILTER_COEF       0x1214
+#define mmMVC_CNTL_START    0x11E0
+#define mmE2_ARITHMETIC_CNTL	0x1220
+#define mmENG_CNTL          0x13E8
+#define mmENG_PERF_CNT      0x13F0
+/* Block GFX End: */
+
+/* Block IDCT Start: */
+#define mmIDCT_RUNS         0x0C00
+#define mmIDCT_LEVELS       0x0C04
+#define mmIDCT_CONTROL      0x0C3C
+#define mmIDCT_AUTH_CONTROL 0x0C08
+#define mmIDCT_AUTH         0x0C0C
+/* Block IDCT End: */
+
+/* Block MC Start: */
+#define mmMEM_CNTL          0x0180
+#define mmMEM_ARB           0x0184
+#define mmMC_FB_LOCATION    0x0188
+#define mmMEM_EXT_CNTL      0x018C
+#define mmMC_EXT_MEM_LOCATION   0x0190
+#define mmMEM_EXT_TIMING_CNTL   0x0194
+#define mmMEM_SDRAM_MODE_REG	0x0198
+#define mmMEM_IO_CNTL       0x019C
+#define mmMC_DEBUG          0x01A0
+#define mmMC_BIST_CTRL      0x01A4
+#define mmMC_BIST_COLLAR_READ  	0x01A8
+#define mmTC_MISMATCH       0x01AC
+#define mmMC_PERF_MON_CNTL  0x01B0
+#define mmMC_PERF_COUNTERS  0x01B4
+/* Block MC End: */
+
+/* Block RBBM Start: */
+#define mmWAIT_UNTIL        0x1400
+#define mmISYNC_CNTL        0x1404
+#define mmRBBM_CNTL         0x0144
+#define mmNQWAIT_UNTIL      0x0150
+/* Block RBBM End: */
+
+/* Block CG Start: */
+#define mmCLK_PIN_CNTL      0x0080
+#define mmPLL_REF_FB_DIV    0x0084
+#define mmPLL_CNTL          0x0088
+#define mmSCLK_CNTL         0x008C
+#define mmPCLK_CNTL         0x0090
+#define mmCLK_TEST_CNTL     0x0094
+#define mmPWRMGT_CNTL       0x0098
+#define mmPWRMGT_STATUS     0x009C
+/* Block CG End: */
+
+/* default value definitions */
+#define defWRAP_TOP_DIR     0x00000000
+#define defWRAP_START_DIR	0x00000000
+#define defCFGREG_BASE      0x00000000
+#define defCIF_IO           0x000C0902
+#define defINTF_CNTL        0x00000011
+#define defCPU_DEFAULTS     0x00000006
+#define defHW_INT           0x00000000
+#define defMC_EXT_MEM_LOCATION            0x07ff0000
+#define defTC_MISMATCH      0x00000000
+
+#define W100_CFG_BASE          0x0
+#define W100_CFG_LEN           0x10
+#define W100_REG_BASE          0x10000
+#define W100_REG_LEN           0x2000
+#define MEM_INT_BASE_VALUE     0x100000
+#define MEM_INT_TOP_VALUE_W100 0x15ffff
+#define MEM_EXT_BASE_VALUE     0x800000
+#define MEM_EXT_TOP_VALUE      0x9fffff
+#define WRAP_BUF_BASE_VALUE    0x80000
+#define WRAP_BUF_TOP_VALUE     0xbffff
+
+
+/* data structure definitions */
+
+struct wrap_top_dir_t {
+     unsigned long top_addr         : 23;
+     unsigned long    				: 9;
+} __attribute__((packed));
+
+union wrap_top_dir_u {
+     unsigned long val : 32;
+     struct wrap_top_dir_t f;
+} __attribute__((packed));
+
+struct wrap_start_dir_t {
+     unsigned long start_addr       : 23;
+     unsigned long    				: 9;
+} __attribute__((packed));
+
+union wrap_start_dir_u {
+     unsigned long val : 32;
+     struct wrap_start_dir_t f;
+} __attribute__((packed));
+
+struct cif_cntl_t {
+     unsigned long swap_reg         		: 2;
+     unsigned long swap_fbuf_1      		: 2;
+     unsigned long swap_fbuf_2      		: 2;
+     unsigned long swap_fbuf_3      		: 2;
+     unsigned long pmi_int_disable  		: 1;
+     unsigned long pmi_schmen_disable       : 1;
+     unsigned long intb_oe          		: 1;
+     unsigned long en_wait_to_compensate_dq_prop_dly : 1;
+     unsigned long compensate_wait_rd_size  : 2;
+     unsigned long wait_asserted_timeout_val      : 2;
+     unsigned long wait_masked_val  		: 2;
+     unsigned long en_wait_timeout  		: 1;
+     unsigned long en_one_clk_setup_before_wait   : 1;
+     unsigned long interrupt_active_high    : 1;
+     unsigned long en_overwrite_straps      : 1;
+     unsigned long strap_wait_active_hi     : 1;
+     unsigned long lat_busy_count   		: 2;
+     unsigned long lat_rd_pm4_sclk_busy     : 1;
+     unsigned long dis_system_bits  		: 1;
+     unsigned long dis_mr           		: 1;
+     unsigned long cif_spare_1      		: 4;
+} __attribute__((packed));
+
+union cif_cntl_u {
+     unsigned long val : 32;
+     struct cif_cntl_t f;
+} __attribute__((packed));
+
+struct cfgreg_base_t {
+     unsigned long cfgreg_base      : 24;
+     unsigned long    				: 8;
+} __attribute__((packed));
+
+union cfgreg_base_u {
+     unsigned long val : 32;
+     struct cfgreg_base_t f;
+} __attribute__((packed));
+
+struct cif_io_t {
+     unsigned long dq_srp           : 1;
+     unsigned long dq_srn           : 1;
+     unsigned long dq_sp            : 4;
+     unsigned long dq_sn            : 4;
+     unsigned long waitb_srp        : 1;
+     unsigned long waitb_srn        : 1;
+     unsigned long waitb_sp         : 4;
+     unsigned long waitb_sn         : 4;
+     unsigned long intb_srp         : 1;
+     unsigned long intb_srn         : 1;
+     unsigned long intb_sp          : 4;
+     unsigned long intb_sn          : 4;
+     unsigned long    				: 2;
+} __attribute__((packed));
+
+union cif_io_u {
+     unsigned long val : 32;
+     struct cif_io_t f;
+} __attribute__((packed));
+
+struct cif_read_dbg_t {
+     unsigned long unpacker_pre_fetch_trig_gen  : 2;
+     unsigned long dly_second_rd_fetch_trig     : 1;
+     unsigned long rst_rd_burst_id  			: 1;
+     unsigned long dis_rd_burst_id  			: 1;
+     unsigned long en_block_rd_when_packer_is_not_emp : 1;
+     unsigned long dis_pre_fetch_cntl_sm        : 1;
+     unsigned long rbbm_chrncy_dis  			: 1;
+     unsigned long rbbm_rd_after_wr_lat         : 2;
+     unsigned long dis_be_during_rd 			: 1;
+     unsigned long one_clk_invalidate_pulse     : 1;
+     unsigned long dis_chnl_priority			: 1;
+     unsigned long rst_read_path_a_pls          : 1;
+     unsigned long rst_read_path_b_pls          : 1;
+     unsigned long dis_reg_rd_fetch_trig        : 1;
+     unsigned long dis_rd_fetch_trig_from_ind_addr : 1;
+     unsigned long dis_rd_same_byte_to_trig_fetch : 1;
+     unsigned long dis_dir_wrap     			: 1;
+     unsigned long dis_ring_buf_to_force_dec    : 1;
+     unsigned long dis_addr_comp_in_16bit       : 1;
+     unsigned long clr_w            			: 1;
+     unsigned long err_rd_tag_is_3  			: 1;
+     unsigned long err_load_when_ful_a          : 1;
+     unsigned long err_load_when_ful_b          : 1;
+     unsigned long    							: 7;
+} __attribute__((packed));
+
+union cif_read_dbg_u {
+     unsigned long val : 32;
+     struct cif_read_dbg_t f;
+} __attribute__((packed));
+
+struct cif_write_dbg_t {
+     unsigned long packer_timeout_count           : 2;
+     unsigned long en_upper_load_cond             : 1;
+     unsigned long en_chnl_change_cond            : 1;
+     unsigned long dis_addr_comp_cond             : 1;
+     unsigned long dis_load_same_byte_addr_cond   : 1;
+     unsigned long dis_timeout_cond 			  : 1;
+     unsigned long dis_timeout_during_rbbm        : 1;
+     unsigned long dis_packer_ful_during_rbbm_timeout : 1;
+     unsigned long en_dword_split_to_rbbm         : 1;
+     unsigned long en_dummy_val     			  : 1;
+     unsigned long dummy_val_sel    			  : 1;
+     unsigned long mask_pm4_wrptr_dec             : 1;
+     unsigned long dis_mc_clean_cond			  : 1;
+     unsigned long err_two_reqi_during_ful        : 1;
+     unsigned long err_reqi_during_idle_clk       : 1;
+     unsigned long err_global       			  : 1;
+     unsigned long en_wr_buf_dbg_load             : 1;
+     unsigned long en_wr_buf_dbg_path             : 1;
+     unsigned long sel_wr_buf_byte  			  : 3;
+     unsigned long dis_rd_flush_wr  			  : 1;
+     unsigned long dis_packer_ful_cond            : 1;
+     unsigned long dis_invalidate_by_ops_chnl     : 1;
+     unsigned long en_halt_when_reqi_err          : 1;
+     unsigned long cif_spare_2      			  : 5;
+     unsigned long    							  : 1;
+} __attribute__((packed));
+
+union cif_write_dbg_u {
+     unsigned long val : 32;
+     struct cif_write_dbg_t f;
+} __attribute__((packed));
+
+
+struct intf_cntl_t {
+     unsigned char ad_inc_a            : 1;
+     unsigned char ring_buf_a          : 1;
+     unsigned char rd_fetch_trigger_a  : 1;
+     unsigned char rd_data_rdy_a       : 1;
+     unsigned char ad_inc_b            : 1;
+     unsigned char ring_buf_b          : 1;
+     unsigned char rd_fetch_trigger_b  : 1;
+     unsigned char rd_data_rdy_b       : 1;
+} __attribute__((packed));
+
+union intf_cntl_u {
+     unsigned char val : 8;
+     struct intf_cntl_t f;
+} __attribute__((packed));
+
+struct cpu_defaults_t {
+     unsigned char unpack_rd_data   : 1;
+     unsigned char access_ind_addr_a: 1;
+     unsigned char access_ind_addr_b: 1;
+     unsigned char access_scratch_reg             : 1;
+     unsigned char pack_wr_data     : 1;
+     unsigned char transition_size  : 1;
+     unsigned char en_read_buf_mode : 1;
+     unsigned char rd_fetch_scratch : 1;
+} __attribute__((packed));
+
+union cpu_defaults_u {
+     unsigned char val : 8;
+     struct cpu_defaults_t f;
+} __attribute__((packed));
+
+struct video_ctrl_t {
+     unsigned long video_mode       : 1;
+     unsigned long keyer_en         : 1;
+     unsigned long en_video_req     : 1;
+     unsigned long en_graphic_req_video           : 1;
+     unsigned long en_video_crtc    : 1;
+     unsigned long video_hor_exp    : 2;
+     unsigned long video_ver_exp    : 2;
+     unsigned long uv_combine       : 1;
+     unsigned long total_req_video  : 9;
+     unsigned long video_ch_sel     : 1;
+     unsigned long video_portrait   : 2;
+     unsigned long yuv2rgb_en       : 1;
+     unsigned long yuv2rgb_option   : 1;
+     unsigned long video_inv_hor    : 1;
+     unsigned long video_inv_ver    : 1;
+     unsigned long gamma_sel        : 2;
+     unsigned long dis_limit        : 1;
+     unsigned long en_uv_hblend     : 1;
+     unsigned long rgb_gamma_sel    : 2;
+} __attribute__((packed));
+
+union video_ctrl_u {
+     unsigned long val : 32;
+     struct video_ctrl_t f;
+} __attribute__((packed));
+
+struct disp_db_buf_cntl_rd_t {
+     unsigned long en_db_buf        	: 1;
+     unsigned long update_db_buf_done   : 1;
+     unsigned long db_buf_cntl      	: 6;
+     unsigned long    					: 24;
+} __attribute__((packed));
+
+union disp_db_buf_cntl_rd_u {
+     unsigned long val : 32;
+     struct disp_db_buf_cntl_rd_t f;
+} __attribute__((packed));
+
+struct disp_db_buf_cntl_wr_t {
+     unsigned long en_db_buf        : 1;
+     unsigned long update_db_buf    : 1;
+     unsigned long db_buf_cntl      : 6;
+     unsigned long    : 24;
+} __attribute__((packed));
+
+union disp_db_buf_cntl_wr_u {
+     unsigned long val : 32;
+     struct disp_db_buf_cntl_wr_t f;
+} __attribute__((packed));
+
+struct gamma_value1_t {
+     unsigned long gamma1           : 8;
+     unsigned long gamma2           : 8;
+     unsigned long gamma3           : 8;
+     unsigned long gamma4           : 8;
+} __attribute__((packed));
+
+union gamma_value1_u {
+     unsigned long val : 32;
+     struct gamma_value1_t f;
+} __attribute__((packed));
+
+struct gamma_value2_t {
+     unsigned long gamma5           : 8;
+     unsigned long gamma6           : 8;
+     unsigned long gamma7           : 8;
+     unsigned long gamma8           : 8;
+} __attribute__((packed));
+
+union gamma_value2_u {
+     unsigned long val : 32;
+     struct gamma_value2_t f;
+} __attribute__((packed));
+
+struct gamma_slope_t {
+     unsigned long slope1           : 3;
+     unsigned long slope2           : 3;
+     unsigned long slope3           : 3;
+     unsigned long slope4           : 3;
+     unsigned long slope5           : 3;
+     unsigned long slope6           : 3;
+     unsigned long slope7           : 3;
+     unsigned long slope8           : 3;
+     unsigned long    				: 8;
+} __attribute__((packed));
+
+union gamma_slope_u {
+     unsigned long val : 32;
+     struct gamma_slope_t f;
+} __attribute__((packed));
+
+struct mc_ext_mem_location_t {
+     unsigned long mc_ext_mem_start : 16;
+     unsigned long mc_ext_mem_top   : 16;
+} __attribute__((packed));
+
+union mc_ext_mem_location_u {
+     unsigned long val : 32;
+     struct mc_ext_mem_location_t f;
+} __attribute__((packed));
+
+struct clk_pin_cntl_t {
+     unsigned long osc_en           : 1;
+     unsigned long osc_gain         : 5;
+     unsigned long dont_use_xtalin  : 1;
+     unsigned long xtalin_pm_en     : 1;
+     unsigned long xtalin_dbl_en    : 1;
+     unsigned long    				: 7;
+     unsigned long cg_debug         : 16;
+} __attribute__((packed));
+
+union clk_pin_cntl_u {
+     unsigned long val : 32;
+     struct clk_pin_cntl_t f;
+} __attribute__((packed));
+
+struct pll_ref_fb_div_t {
+     unsigned long pll_ref_div      : 4;
+     unsigned long    				: 4;
+     unsigned long pll_fb_div_int   : 6;
+     unsigned long    				: 2;
+     unsigned long pll_fb_div_frac  : 3;
+     unsigned long    				: 1;
+     unsigned long pll_reset_time   : 4;
+     unsigned long pll_lock_time    : 8;
+} __attribute__((packed));
+
+union pll_ref_fb_div_u {
+     unsigned long val : 32;
+     struct pll_ref_fb_div_t f;
+} __attribute__((packed));
+
+struct pll_cntl_t {
+     unsigned long pll_pwdn         : 1;
+     unsigned long pll_reset        : 1;
+     unsigned long pll_pm_en        : 1;
+     unsigned long pll_mode         : 1;
+     unsigned long pll_refclk_sel   : 1;
+     unsigned long pll_fbclk_sel    : 1;
+     unsigned long pll_tcpoff       : 1;
+     unsigned long pll_pcp          : 3;
+     unsigned long pll_pvg          : 3;
+     unsigned long pll_vcofr        : 1;
+     unsigned long pll_ioffset      : 2;
+     unsigned long pll_pecc_mode    : 2;
+     unsigned long pll_pecc_scon    : 2;
+     unsigned long pll_dactal       : 4;
+     unsigned long pll_cp_clip      : 2;
+     unsigned long pll_conf         : 3;
+     unsigned long pll_mbctrl       : 2;
+     unsigned long pll_ring_off     : 1;
+} __attribute__((packed));
+
+union pll_cntl_u {
+     unsigned long val : 32;
+     struct pll_cntl_t f;
+} __attribute__((packed));
+
+struct sclk_cntl_t {
+     unsigned long sclk_src_sel     	: 2;
+     unsigned long    					: 2;
+     unsigned long sclk_post_div_fast   : 4;
+     unsigned long sclk_clkon_hys   	: 3;
+     unsigned long sclk_post_div_slow   : 4;
+     unsigned long disp_cg_ok2switch_en : 1;
+     unsigned long sclk_force_reg   	: 1;
+     unsigned long sclk_force_disp  	: 1;
+     unsigned long sclk_force_mc    	: 1;
+     unsigned long sclk_force_extmc 	: 1;
+     unsigned long sclk_force_cp    	: 1;
+     unsigned long sclk_force_e2    	: 1;
+     unsigned long sclk_force_e3    	: 1;
+     unsigned long sclk_force_idct  	: 1;
+     unsigned long sclk_force_bist  	: 1;
+     unsigned long busy_extend_cp   	: 1;
+     unsigned long busy_extend_e2   	: 1;
+     unsigned long busy_extend_e3   	: 1;
+     unsigned long busy_extend_idct 	: 1;
+     unsigned long    					: 3;
+} __attribute__((packed));
+
+union sclk_cntl_u {
+     unsigned long val : 32;
+     struct sclk_cntl_t f;
+} __attribute__((packed));
+
+struct pclk_cntl_t {
+     unsigned long pclk_src_sel     : 2;
+     unsigned long    				: 2;
+     unsigned long pclk_post_div    : 4;
+     unsigned long    				: 8;
+     unsigned long pclk_force_disp  : 1;
+     unsigned long    				: 15;
+} __attribute__((packed));
+
+union pclk_cntl_u {
+     unsigned long val : 32;
+     struct pclk_cntl_t f;
+} __attribute__((packed));
+
+struct clk_test_cntl_t {
+     unsigned long testclk_sel      : 4;
+     unsigned long    				: 3;
+     unsigned long start_check_freq : 1;
+     unsigned long tstcount_rst     : 1;
+     unsigned long    				: 15;
+     unsigned long test_count       : 8;
+} __attribute__((packed));
+
+union clk_test_cntl_u {
+     unsigned long val : 32;
+     struct clk_test_cntl_t f;
+} __attribute__((packed));
+
+struct pwrmgt_cntl_t {
+     unsigned long pwm_enable       	: 1;
+     unsigned long    					: 1;
+     unsigned long pwm_mode_req         : 2;
+     unsigned long pwm_wakeup_cond      : 2;
+     unsigned long pwm_fast_noml_hw_en  : 1;
+     unsigned long pwm_noml_fast_hw_en  : 1;
+     unsigned long pwm_fast_noml_cond   : 4;
+     unsigned long pwm_noml_fast_cond   : 4;
+     unsigned long pwm_idle_timer   	: 8;
+     unsigned long pwm_busy_timer   	: 8;
+} __attribute__((packed));
+
+union pwrmgt_cntl_u {
+     unsigned long val : 32;
+     struct pwrmgt_cntl_t f;
+} __attribute__((packed));
+
+#endif
+
--- /dev/null
+++ linux-2.6.10/include/video/w100fb.h
@@ -0,0 +1,21 @@
+/*
+ *  Support for the w100 frame buffer.
+ *
+ *  Copyright (c) 2004 Richard Purdie
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+/*
+ * This structure describes the machine which we are running on.
+ * It is set by machine specific code and used in the probe routine
+ * of drivers/video/w100fb.c
+ */
+
+struct w100fb_mach_info {
+	void (*w100fb_ssp_send)(u8 adrs, u8 data);
+	int comadj;
+	int phadadj;
+};




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
