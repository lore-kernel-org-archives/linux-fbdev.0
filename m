From: Richard Purdie <rpurdie@rpsys.net>
Subject: [patch resend] w100fb: Rewrite for platform independence
Date: Sun, 07 Aug 2005 13:32:09 +0100
Message-ID: <1123417929.7800.11.camel@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E1kKL-00025t-1u
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 05:32:29 -0700
Received: from tim.rpsys.net ([194.106.48.114] ident=0)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E1kKD-0000U2-VL
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 07 Aug 2005 05:32:29 -0700
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
To: akpm@osdl.org
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net

The code w100fb was based on was horribly Sharp SL-C7x0 specific
and there was little else that could be done as I had no access to
anything else with a w100 in it. There is no real documentation 
about this chipset available.

Ian Molton has access to other platforms with the w100 (Toshiba
e-series) and so between us, we've improved w100fb and made it 
platform independent. Ian Molton also added support for the 
very similar w3220 and w3200 chipsets.

There are a lot of changes here and it nearly amounts to a rewrite 
of the driver but it has been extensively tested and is being used 
in preference to the original driver in the Zaurus community. I'd
therefore like to update the mainline code to reflect this. 

[Comments from Antonino Daplas taken on board, thanks.]

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: linux-2.6.12/drivers/video/w100fb.c
===================================================================
--- linux-2.6.12.orig/drivers/video/w100fb.c	2005-08-05 17:31:39.000000000 +0100
+++ linux-2.6.12/drivers/video/w100fb.c	2005-08-07 11:11:03.000000000 +0100
@@ -5,9 +5,15 @@
  *
  * Copyright (C) 2002, ATI Corp.
  * Copyright (C) 2004-2005 Richard Purdie
+ * Copyright (c) 2005 Ian Molton
  *
  * Rewritten for 2.6 by Richard Purdie <rpurdie@rpsys.net>
  *
+ * Generic platform support by Ian Molton <spyro@f2s.com>
+ * and Richard Purdie <rpurdie@rpsys.net>
+ *
+ * w32xx support by Ian Molton
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -21,7 +27,7 @@
 #include <linux/mm.h>
 #include <linux/device.h>
 #include <linux/string.h>
-#include <linux/proc_fs.h>
+#include <linux/vmalloc.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <video/w100fb.h>
@@ -30,114 +36,78 @@
 /*
  * Prototypes
  */
-static void w100fb_save_buffer(void);
-static void w100fb_clear_buffer(void);
-static void w100fb_restore_buffer(void);
-static void w100fb_clear_screen(u32 mode, long int offset);
-static void w100_resume(void);
 static void w100_suspend(u32 mode);
-static void w100_init_qvga_rotation(u16 deg);
-static void w100_init_vga_rotation(u16 deg);
 static void w100_vsync(void);
-static void w100_init_sharp_lcd(u32 mode);
-static void w100_pwm_setup(void);
-static void w100_InitExtMem(u32 mode);
-static void w100_hw_init(void);
-static u16 w100_set_fastsysclk(u16 Freq);
-
-static void lcdtg_hw_init(u32 mode);
-static void lcdtg_lcd_change(u32 mode);
-static void lcdtg_resume(void);
-static void lcdtg_suspend(void);
-
-
-/* Register offsets & lengths */
-#define REMAPPED_FB_LEN   0x15ffff
-
-#define BITS_PER_PIXEL    16
+static void w100_hw_init(struct w100fb_par*);
+static void w100_pwm_setup(struct w100fb_par*);
+static void w100_init_clocks(struct w100fb_par*);
+static void w100_setup_memory(struct w100fb_par*);
+static void w100_init_lcd(struct w100fb_par*);
+static void w100_set_dispregs(struct w100fb_par*);
+static void w100_update_enable(void);
+static void w100_update_disable(void);
+static void calc_hsync(struct w100fb_par *par);
+struct w100_pll_info *w100_get_xtal_table(unsigned int freq);
 
 /* Pseudo palette size */
 #define MAX_PALETTES      16
 
-/* for resolution change */
-#define LCD_MODE_INIT (-1)
-#define LCD_MODE_480    0
-#define LCD_MODE_320    1
-#define LCD_MODE_240    2
-#define LCD_MODE_640    3
-
-#define LCD_SHARP_QVGA 0
-#define LCD_SHARP_VGA  1
-
-#define LCD_MODE_PORTRAIT	0
-#define LCD_MODE_LANDSCAPE	1
-
 #define W100_SUSPEND_EXTMEM 0
 #define W100_SUSPEND_ALL    1
 
-/* General frame buffer data structures */
-struct w100fb_par {
-	u32 xres;
-	u32 yres;
-	int fastsysclk_mode;
-	int lcdMode;
-	int rotation_flag;
-	int blanking_flag;
-	int comadj;
-	int phadadj;
-};
-
-static struct w100fb_par *current_par;
+#define BITS_PER_PIXEL    16
 
 /* Remapped addresses for base cfg, memmapped regs and the frame buffer itself */
 static void *remapped_base;
 static void *remapped_regs;
 static void *remapped_fbuf;
 
-/* External Function */
-static void(*w100fb_ssp_send)(u8 adrs, u8 data);
+#define REMAPPED_FB_LEN   0x15ffff
+
+/* This is the offset in the w100's address space we map the current
+   framebuffer memory to. We use the position of external memory as
+   we can remap internal memory to there if external isn't present. */
+#define W100_FB_BASE MEM_EXT_BASE_VALUE
+
 
 /*
  * Sysfs functions
  */
-
-static ssize_t rotation_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t flip_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
 
-	return sprintf(buf, "%d\n",par->rotation_flag);
+	return sprintf(buf, "%d\n",par->flip);
 }
 
-static ssize_t rotation_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t flip_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	unsigned int rotate;
+	unsigned int flip;
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
 
-	rotate = simple_strtoul(buf, NULL, 10);
+	flip = simple_strtoul(buf, NULL, 10);
 
-	if (rotate > 0) par->rotation_flag = 1;
-	else par->rotation_flag = 0;
+	if (flip > 0)
+		par->flip = 1;
+	else
+		par->flip = 0;
+
+	w100_update_disable();
+	w100_set_dispregs(par);
+	w100_update_enable();
 
-	if (par->lcdMode == LCD_MODE_320)
-		w100_init_qvga_rotation(par->rotation_flag ? 270 : 90);
-	else if (par->lcdMode == LCD_MODE_240)
-		w100_init_qvga_rotation(par->rotation_flag ? 180 : 0);
-	else if (par->lcdMode == LCD_MODE_640)
-		w100_init_vga_rotation(par->rotation_flag ? 270 : 90);
-	else if (par->lcdMode == LCD_MODE_480)
-		w100_init_vga_rotation(par->rotation_flag ? 180 : 0);
+	calc_hsync(par);
 
 	return count;
 }
 
-static DEVICE_ATTR(rotation, 0644, rotation_show, rotation_store);
+static DEVICE_ATTR(flip, 0644, flip_show, flip_store);
 
 static ssize_t w100fb_reg_read(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	unsigned long param;
-	unsigned long regs;
+	unsigned long regs, param;
 	regs = simple_strtoul(buf, NULL, 16);
 	param = readl(remapped_regs + regs);
 	printk("Read Register 0x%08lX: 0x%08lX\n", regs, param);
@@ -148,8 +118,7 @@
 
 static ssize_t w100fb_reg_write(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	unsigned long regs;
-	unsigned long param;
+	unsigned long regs, param;
 	sscanf(buf, "%lx %lx", &regs, &param);
 
 	if (regs <= 0x2000) {
@@ -163,54 +132,56 @@
 static DEVICE_ATTR(reg_write, 0200, NULL, w100fb_reg_write);
 
 
-static ssize_t fastsysclk_show(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t fastpllclk_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
 
-	return sprintf(buf, "%d\n",par->fastsysclk_mode);
+	return sprintf(buf, "%d\n",par->fastpll_mode);
 }
 
-static ssize_t fastsysclk_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+static ssize_t fastpllclk_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
 {
-	int param;
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct w100fb_par *par=info->par;
 
-	param = simple_strtoul(buf, NULL, 10);
-
-	if (param == 75) {
-		printk("Set fastsysclk %d\n", param);
-		par->fastsysclk_mode = param;
-		w100_set_fastsysclk(par->fastsysclk_mode);
-	} else if (param == 100) {
-		printk("Set fastsysclk %d\n", param);
-		par->fastsysclk_mode = param;
-		w100_set_fastsysclk(par->fastsysclk_mode);
+	if (simple_strtoul(buf, NULL, 10) > 0) {
+		par->fastpll_mode=1;
+		printk("w100fb: Using fast system clock (if possible)\n");
+	} else {
+		par->fastpll_mode=0;
+		printk("w100fb: Using normal system clock\n");
 	}
+
+	w100_init_clocks(par);
+	calc_hsync(par);
+
 	return count;
 }
 
-static DEVICE_ATTR(fastsysclk, 0644, fastsysclk_show, fastsysclk_store);
+static DEVICE_ATTR(fastpllclk, 0644, fastpllclk_show, fastpllclk_store);
 
 /*
- * The touchscreen on this device needs certain information
- * from the video driver to function correctly. We export it here.
+ * Some touchscreens need hsync information from the video driver to
+ * function correctly. We export it here.
  */
-int w100fb_get_xres(void) {
-	return current_par->xres;
-}
+unsigned long w100fb_get_hsynclen(struct device *dev)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct w100fb_par *par=info->par;
 
-int w100fb_get_blanking(void) {
-	return current_par->blanking_flag;
+	/* If display is blanked/suspended, hsync isn't active */
+	if (par->blanked)
+		return 0;
+	else
+		return par->hsync_len;
 }
+EXPORT_SYMBOL(w100fb_get_hsynclen);
 
-int w100fb_get_fastsysclk(void) {
-	return current_par->fastsysclk_mode;
+static void w100fb_clear_screen(struct w100fb_par *par)
+{
+	memset_io(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), 0, (par->xres * par->yres * BITS_PER_PIXEL/8));
 }
-EXPORT_SYMBOL(w100fb_get_xres);
-EXPORT_SYMBOL(w100fb_get_blanking);
-EXPORT_SYMBOL(w100fb_get_fastsysclk);
 
 
 /*
@@ -234,7 +205,6 @@
 	 * according to the RGB bitfield information.
 	 */
 	if (regno < MAX_PALETTES) {
-
 		u32 *pal = info->pseudo_palette;
 
 		val = (red & 0xf800) | ((green & 0xfc00) >> 5) | ((blue & 0xf800) >> 11);
@@ -250,115 +220,90 @@
  */
 static int w100fb_blank(int blank_mode, struct fb_info *info)
 {
-	struct w100fb_par *par;
-	par=info->par;
+	struct w100fb_par *par = info->par;
+	struct w100_tg_info *tg = par->mach->tg;
 
 	switch(blank_mode) {
 
- 	case FB_BLANK_NORMAL: /* Normal blanking */
-	case FB_BLANK_VSYNC_SUSPEND: /* VESA blank (vsync off) */
-	case FB_BLANK_HSYNC_SUSPEND: /* VESA blank (hsync off) */
- 	case FB_BLANK_POWERDOWN: /* Poweroff */
-  		if (par->blanking_flag == 0) {
-			w100fb_save_buffer();
-			lcdtg_suspend();
-			par->blanking_flag = 1;
+ 	case FB_BLANK_NORMAL:         /* Normal blanking */
+	case FB_BLANK_VSYNC_SUSPEND:  /* VESA blank (vsync off) */
+	case FB_BLANK_HSYNC_SUSPEND:  /* VESA blank (hsync off) */
+ 	case FB_BLANK_POWERDOWN:      /* Poweroff */
+  		if (par->blanked == 0) {
+			if(tg && tg->suspend)
+				tg->suspend(par);
+			par->blanked = 1;
   		}
   		break;
 
  	case FB_BLANK_UNBLANK: /* Unblanking */
-  		if (par->blanking_flag != 0) {
-			w100fb_restore_buffer();
-			lcdtg_resume();
-			par->blanking_flag = 0;
+  		if (par->blanked != 0) {
+			if(tg && tg->resume)
+				tg->resume(par);
+			par->blanked = 0;
   		}
   		break;
  	}
 	return 0;
 }
 
+
 /*
  *  Change the resolution by calling the appropriate hardware functions
  */
-static void w100fb_changeres(int rotate_mode, u32 mode)
+static void w100fb_activate_var(struct w100fb_par *par)
 {
-	u16 rotation=0;
+	struct w100_tg_info *tg = par->mach->tg;
 
-	switch(rotate_mode) {
-	case LCD_MODE_LANDSCAPE:
-		rotation=(current_par->rotation_flag ? 270 : 90);
-		break;
-	case LCD_MODE_PORTRAIT:
-		rotation=(current_par->rotation_flag ? 180 : 0);
-		break;
-	}
-
-	w100_pwm_setup();
-	switch(mode) {
-	case LCD_SHARP_QVGA:
-		w100_vsync();
-		w100_suspend(W100_SUSPEND_EXTMEM);
-		w100_init_sharp_lcd(LCD_SHARP_QVGA);
-		w100_init_qvga_rotation(rotation);
-		w100_InitExtMem(LCD_SHARP_QVGA);
-		w100fb_clear_screen(LCD_SHARP_QVGA, 0);
-		lcdtg_lcd_change(LCD_SHARP_QVGA);
-		break;
-	case LCD_SHARP_VGA:
-		w100fb_clear_screen(LCD_SHARP_QVGA, 0);
-		writel(0xBFFFA000, remapped_regs + mmMC_EXT_MEM_LOCATION);
-		w100_InitExtMem(LCD_SHARP_VGA);
-		w100fb_clear_screen(LCD_SHARP_VGA, 0x200000);
-		w100_vsync();
-		w100_init_sharp_lcd(LCD_SHARP_VGA);
-		if (rotation != 0)
-			w100_init_vga_rotation(rotation);
-		lcdtg_lcd_change(LCD_SHARP_VGA);
-		break;
-	}
+	w100_pwm_setup(par);
+	w100_setup_memory(par);
+	w100_init_clocks(par);
+	w100fb_clear_screen(par);
+	w100_vsync();
+
+	w100_update_disable();
+	w100_init_lcd(par);
+	w100_set_dispregs(par);
+	w100_update_enable();
+
+	calc_hsync(par);
+
+	if (!par->blanked && tg && tg->change)
+		tg->change(par);
 }
 
-/*
- * Set up the display for the fb subsystem
+
+/* Select the smallest mode that allows the desired resolution to be
+ * displayed. If desired, the x and y parameters can be rounded up to
+ * match the selected mode.
  */
-static void w100fb_activate_var(struct fb_info *info)
+static struct w100_mode *w100fb_get_mode(struct w100fb_par *par, unsigned int *x, unsigned int *y, int saveval)
 {
-	u32 temp32;
-	struct w100fb_par *par=info->par;
-	struct fb_var_screeninfo *var = &info->var;
+	struct w100_mode *mode = NULL;
+	struct w100_mode *modelist = par->mach->modelist;
+	unsigned int best_x = 0xffffffff, best_y = 0xffffffff;
+	unsigned int i;
+
+	for (i = 0 ; i < par->mach->num_modes ; i++) {
+		if (modelist[i].xres >= *x && modelist[i].yres >= *y &&
+				modelist[i].xres < best_x && modelist[i].yres < best_y) {
+			best_x = modelist[i].xres;
+			best_y = modelist[i].yres;
+			mode = &modelist[i];
+		} else if(modelist[i].xres >= *y && modelist[i].yres >= *x &&
+		        modelist[i].xres < best_y && modelist[i].yres < best_x) {
+			best_x = modelist[i].yres;
+			best_y = modelist[i].xres;
+			mode = &modelist[i];
+		}
+	}
 
-	/* Set the hardware to 565 */
-	temp32 = readl(remapped_regs + mmDISP_DEBUG2);
-	temp32 &= 0xff7fffff;
-	temp32 |= 0x00800000;
-	writel(temp32, remapped_regs + mmDISP_DEBUG2);
+	if (mode && saveval) {
+		*x = best_x;
+		*y = best_y;
+	}
 
-	if (par->lcdMode == LCD_MODE_INIT) {
-		w100_init_sharp_lcd(LCD_SHARP_VGA);
-		w100_init_vga_rotation(par->rotation_flag ? 270 : 90);
-		par->lcdMode = LCD_MODE_640;
-		lcdtg_hw_init(LCD_SHARP_VGA);
-	} else if (var->xres == 320 && var->yres == 240) {
-		if (par->lcdMode != LCD_MODE_320) {
-			w100fb_changeres(LCD_MODE_LANDSCAPE, LCD_SHARP_QVGA);
-			par->lcdMode = LCD_MODE_320;
-		}
-	} else if (var->xres == 240 && var->yres == 320) {
-		if (par->lcdMode != LCD_MODE_240) {
-			w100fb_changeres(LCD_MODE_PORTRAIT, LCD_SHARP_QVGA);
-			par->lcdMode = LCD_MODE_240;
-		}
-	} else if (var->xres == 640 && var->yres == 480) {
-		if (par->lcdMode != LCD_MODE_640) {
-			w100fb_changeres(LCD_MODE_LANDSCAPE, LCD_SHARP_VGA);
-			par->lcdMode = LCD_MODE_640;
-		}
-	} else if (var->xres == 480 && var->yres == 640) {
-		if (par->lcdMode != LCD_MODE_480) {
-			w100fb_changeres(LCD_MODE_PORTRAIT, LCD_SHARP_VGA);
-			par->lcdMode = LCD_MODE_480;
-		}
-	} else printk(KERN_ERR "W100FB: Resolution error!\n");
+	return mode;
 }
 
 
@@ -366,31 +311,19 @@
  *  w100fb_check_var():
  *  Get the video params out of 'var'. If a value doesn't fit, round it up,
  *  if it's too big, return -EINVAL.
- *
  */
 static int w100fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	if (var->xres < var->yres) { /* Portrait mode */
-		if ((var->xres > 480) || (var->yres > 640)) {
-			return -EINVAL;
-		} else if ((var->xres > 240) || (var->yres > 320)) {
-			var->xres = 480;
-			var->yres = 640;
-		} else {
-			var->xres = 240;
-			var->yres = 320;
-		}
-	} else { /* Landscape mode */
-		if ((var->xres > 640) || (var->yres > 480)) {
-			return -EINVAL;
-		} else if ((var->xres > 320) || (var->yres > 240)) {
-			var->xres = 640;
-			var->yres = 480;
-		} else {
-			var->xres = 320;
-			var->yres = 240;
-		}
-	}
+	struct w100fb_par *par=info->par;
+
+	if(!w100fb_get_mode(par, &var->xres, &var->yres, 1))
+		return -EINVAL;
+
+	if (par->mach->mem && ((var->xres*var->yres*BITS_PER_PIXEL/8) > (par->mach->mem->size+1)))
+		return -EINVAL;
+
+	if (!par->mach->mem && ((var->xres*var->yres*BITS_PER_PIXEL/8) > (MEM_INT_SIZE+1)))
+		return -EINVAL;
 
 	var->xres_virtual = max(var->xres_virtual, var->xres);
 	var->yres_virtual = max(var->yres_virtual, var->yres);
@@ -409,13 +342,11 @@
 	var->transp.offset = var->transp.length = 0;
 
 	var->nonstd = 0;
-
 	var->height = -1;
 	var->width = -1;
 	var->vmode = FB_VMODE_NONINTERLACED;
-
 	var->sync = 0;
-	var->pixclock = 0x04;	/* 171521; */
+	var->pixclock = 0x04;  /* 171521; */
 
 	return 0;
 }
@@ -430,274 +361,286 @@
 {
 	struct w100fb_par *par=info->par;
 
-	par->xres = info->var.xres;
-	par->yres = info->var.yres;
-
-	info->fix.visual = FB_VISUAL_TRUECOLOR;
-
-	info->fix.ypanstep = 0;
-	info->fix.ywrapstep = 0;
+	if (par->xres != info->var.xres || par->yres != info->var.yres)	{
+		par->xres = info->var.xres;
+		par->yres = info->var.yres;
+		par->mode = w100fb_get_mode(par, &par->xres, &par->yres, 0);
+
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+		info->fix.ypanstep = 0;
+		info->fix.ywrapstep = 0;
+		info->fix.line_length = par->xres * BITS_PER_PIXEL / 8;
+
+		if ((par->xres*par->yres*BITS_PER_PIXEL/8) > (MEM_INT_SIZE+1)) {
+			par->extmem_active = 1;
+			info->fix.smem_len = par->mach->mem->size+1;
+		} else {
+			par->extmem_active = 0;
+			info->fix.smem_len = MEM_INT_SIZE+1;
+		}
 
-	if (par->blanking_flag)
-		w100fb_clear_buffer();
-
-	w100fb_activate_var(info);
-
-	if (par->lcdMode == LCD_MODE_480) {
-		info->fix.line_length = (480 * BITS_PER_PIXEL) / 8;
-		info->fix.smem_len = 0x200000;
-	} else if (par->lcdMode == LCD_MODE_320) {
-		info->fix.line_length = (320 * BITS_PER_PIXEL) / 8;
-		info->fix.smem_len = 0x60000;
-	} else if (par->lcdMode == LCD_MODE_240) {
-		info->fix.line_length = (240 * BITS_PER_PIXEL) / 8;
-		info->fix.smem_len = 0x60000;
-	} else if (par->lcdMode == LCD_MODE_INIT || par->lcdMode == LCD_MODE_640) {
-		info->fix.line_length = (640 * BITS_PER_PIXEL) / 8;
-		info->fix.smem_len = 0x200000;
+		w100fb_activate_var(par);
 	}
-
 	return 0;
 }
 
 
 /*
- *      Frame buffer operations
+ *  Frame buffer operations
  */
 static struct fb_ops w100fb_ops = {
-	.owner = THIS_MODULE,
+	.owner        = THIS_MODULE,
 	.fb_check_var = w100fb_check_var,
-	.fb_set_par = w100fb_set_par,
+	.fb_set_par   = w100fb_set_par,
 	.fb_setcolreg = w100fb_setcolreg,
-	.fb_blank = w100fb_blank,
-	.fb_fillrect = cfb_fillrect,
-	.fb_copyarea = cfb_copyarea,
+	.fb_blank     = w100fb_blank,
+	.fb_fillrect  = cfb_fillrect,
+	.fb_copyarea  = cfb_copyarea,
 	.fb_imageblit = cfb_imageblit,
-	.fb_cursor = soft_cursor,
+	.fb_cursor    = soft_cursor,
 };
 
-
-static void w100fb_clear_screen(u32 mode, long int offset)
-{
-	int i, numPix = 0;
-
-	if (mode == LCD_SHARP_VGA)
-		numPix = 640 * 480;
-	else if (mode == LCD_SHARP_QVGA)
-		numPix = 320 * 240;
-
-	for (i = 0; i < numPix; i++)
-		writew(0xffff, remapped_fbuf + offset + (2*i));
-}
-
-
-/* Need to split up the buffers to stay within the limits of kmalloc */
-#define W100_BUF_NUM	6
-static uint32_t *gSaveImagePtr[W100_BUF_NUM] = { NULL };
-
-static void w100fb_save_buffer(void)
+#ifdef CONFIG_PM
+static void w100fb_save_vidmem(struct w100fb_par *par)
 {
-	int i, j, bufsize;
+	int memsize;
 
-	bufsize=(current_par->xres * current_par->yres * BITS_PER_PIXEL / 8) / W100_BUF_NUM;
-	for (i = 0; i < W100_BUF_NUM; i++) {
-		if (gSaveImagePtr[i] == NULL)
-			gSaveImagePtr[i] = kmalloc(bufsize, GFP_KERNEL);
-		if (gSaveImagePtr[i] == NULL) {
-			w100fb_clear_buffer();
-			printk(KERN_WARNING "can't alloc pre-off image buffer %d\n", i);
-			break;
-		}
-		for (j = 0; j < bufsize/4; j++)
-			*(gSaveImagePtr[i] + j) = readl(remapped_fbuf + (bufsize*i) + j*4);
+	if (par->extmem_active) {
+		memsize=par->mach->mem->size;
+		par->saved_extmem = vmalloc(memsize);
+		if (par->saved_extmem)
+			memcpy_fromio(par->saved_extmem, remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), memsize);
 	}
+	memsize=MEM_INT_SIZE;
+	par->saved_intmem = vmalloc(memsize);
+	if (par->saved_intmem && par->extmem_active)
+		memcpy_fromio(par->saved_intmem, remapped_fbuf + (W100_FB_BASE-MEM_INT_BASE_VALUE), memsize);
+	else if (par->saved_intmem)
+		memcpy_fromio(par->saved_intmem, remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), memsize);
 }
 
-
-static void w100fb_restore_buffer(void)
+static void w100fb_restore_vidmem(struct w100fb_par *par)
 {
-	int i, j, bufsize;
+	int memsize;
 
-	bufsize=(current_par->xres * current_par->yres * BITS_PER_PIXEL / 8) / W100_BUF_NUM;
-	for (i = 0; i < W100_BUF_NUM; i++) {
-		if (gSaveImagePtr[i] == NULL) {
-			printk(KERN_WARNING "can't find pre-off image buffer %d\n", i);
-			w100fb_clear_buffer();
-			break;
-		}
-		for (j = 0; j < (bufsize/4); j++)
-			writel(*(gSaveImagePtr[i] + j),remapped_fbuf + (bufsize*i) + (j*4));
-		kfree(gSaveImagePtr[i]);
-		gSaveImagePtr[i] = NULL;
+	if (par->extmem_active && par->saved_extmem) {
+		memsize=par->mach->mem->size;
+		memcpy(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_extmem, memsize);
+		vfree(par->saved_extmem);
 	}
-}
-
-
-static void w100fb_clear_buffer(void)
-{
-	int i;
-	for (i = 0; i < W100_BUF_NUM; i++) {
-		kfree(gSaveImagePtr[i]);
-		gSaveImagePtr[i] = NULL;
+	if (par->saved_intmem) {
+		memsize=MEM_INT_SIZE;
+		if (par->extmem_active)
+			memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_INT_BASE_VALUE), par->saved_intmem, memsize);
+		else
+			memcpy_toio(remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE), par->saved_intmem, memsize);
+		vfree(par->saved_intmem);
 	}
 }
 
-
-#ifdef CONFIG_PM
-static int w100fb_suspend(struct device *dev, pm_message_t state, u32 level)
+static int w100fb_suspend(struct device *dev, pm_message_t state, uint32_t level)
 {
 	if (level == SUSPEND_POWER_DOWN) {
 		struct fb_info *info = dev_get_drvdata(dev);
 		struct w100fb_par *par=info->par;
+		struct w100_tg_info *tg = par->mach->tg;
 
-		w100fb_save_buffer();
-		lcdtg_suspend();
+		w100fb_save_vidmem(par);
+		if(tg && tg->suspend)
+			tg->suspend(par);
 		w100_suspend(W100_SUSPEND_ALL);
-		par->blanking_flag = 1;
+		par->blanked = 1;
 	}
 	return 0;
 }
 
-static int w100fb_resume(struct device *dev, u32 level)
+static int w100fb_resume(struct device *dev, uint32_t level)
 {
 	if (level == RESUME_POWER_ON) {
 		struct fb_info *info = dev_get_drvdata(dev);
 		struct w100fb_par *par=info->par;
+		struct w100_tg_info *tg = par->mach->tg;
 
-		w100_resume();
-		w100fb_restore_buffer();
-		lcdtg_resume();
-		par->blanking_flag = 0;
+		w100_hw_init(par);
+		w100fb_activate_var(par);
+		w100fb_restore_vidmem(par);
+		if(tg && tg->resume)
+			tg->resume(par);
+		par->blanked = 0;
 	}
 	return 0;
 }
 #else
-#define w100fb_suspend	NULL
-#define w100fb_resume	NULL
+#define w100fb_suspend  NULL
+#define w100fb_resume   NULL
 #endif
 
 
 int __init w100fb_probe(struct device *dev)
 {
+	int err = -EIO;
 	struct w100fb_mach_info *inf;
-	struct fb_info *info;
+	struct fb_info *info = NULL;
 	struct w100fb_par *par;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct resource *mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	unsigned int chip_id;
 
 	if (!mem)
 		return -EINVAL;
 
-	/* remap the areas we're going to use */
+	/* Remap the chip base address */
 	remapped_base = ioremap_nocache(mem->start+W100_CFG_BASE, W100_CFG_LEN);
 	if (remapped_base == NULL)
-		return -EIO;
+		goto out;
 
+	/* Map the register space */
 	remapped_regs = ioremap_nocache(mem->start+W100_REG_BASE, W100_REG_LEN);
-	if (remapped_regs == NULL) {
-		iounmap(remapped_base);
-		return -EIO;
-	}
+	if (remapped_regs == NULL)
+		goto out;
 
-	remapped_fbuf = ioremap_nocache(mem->start+MEM_EXT_BASE_VALUE, REMAPPED_FB_LEN);
-	if (remapped_fbuf == NULL) {
-		iounmap(remapped_base);
-		iounmap(remapped_regs);
-		return -EIO;
-	}
+	/* Identify the chip */
+	printk("Found ");
+	chip_id = readl(remapped_regs + mmCHIP_ID);
+	switch(chip_id) {
+		case CHIP_ID_W100:  printk("w100");  break;
+		case CHIP_ID_W3200: printk("w3200"); break;
+		case CHIP_ID_W3220: printk("w3220"); break;
+		default:
+			printk("Unknown imageon chip ID\n");
+			err = -ENODEV;
+			goto out;
+	}
+	printk(" at 0x%08lx.\n", mem->start+W100_CFG_BASE);
+
+	/* Remap the framebuffer */
+	remapped_fbuf = ioremap_nocache(mem->start+MEM_WINDOW_BASE, MEM_WINDOW_SIZE);
+	if (remapped_fbuf == NULL)
+		goto out;
 
 	info=framebuffer_alloc(sizeof(struct w100fb_par), dev);
 	if (!info) {
-		iounmap(remapped_base);
-		iounmap(remapped_regs);
-		iounmap(remapped_fbuf);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out;
 	}
 
-	info->device=dev;
 	par = info->par;
-	current_par=info->par;
 	dev_set_drvdata(dev, info);
 
 	inf = dev->platform_data;
-	par->phadadj = inf->phadadj;
-	par->comadj = inf->comadj;
-	par->fastsysclk_mode = 75;
-	par->lcdMode = LCD_MODE_INIT;
-	par->rotation_flag=0;
-	par->blanking_flag=0;
-	w100fb_ssp_send = inf->w100fb_ssp_send;
-
-	w100_hw_init();
-	w100_pwm_setup();
+	par->chip_id = chip_id;
+	par->mach = inf;
+	par->fastpll_mode = 0;
+	par->blanked = 0;
+
+	par->pll_table=w100_get_xtal_table(inf->xtal_freq);
+	if (!par->pll_table) {
+		printk(KERN_ERR "No matching Xtal definition found\n");
+		err = -EINVAL;
+		goto out;
+	}
 
 	info->pseudo_palette = kmalloc(sizeof (u32) * MAX_PALETTES, GFP_KERNEL);
 	if (!info->pseudo_palette) {
-		iounmap(remapped_base);
-		iounmap(remapped_regs);
-		iounmap(remapped_fbuf);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto out;
 	}
 
 	info->fbops = &w100fb_ops;
 	info->flags = FBINFO_DEFAULT;
 	info->node = -1;
-	info->screen_base = remapped_fbuf;
+	info->screen_base = remapped_fbuf + (W100_FB_BASE-MEM_WINDOW_BASE);
 	info->screen_size = REMAPPED_FB_LEN;
 
-	info->var.xres = 640;
+	strcpy(info->fix.id, "w100fb");
+	info->fix.type = FB_TYPE_PACKED_PIXELS;
+	info->fix.type_aux = 0;
+	info->fix.accel = FB_ACCEL_NONE;
+	info->fix.smem_start = mem->start+W100_FB_BASE;
+	info->fix.mmio_start = mem->start+W100_REG_BASE;
+	info->fix.mmio_len = W100_REG_LEN;
+
+	if (fb_alloc_cmap(&info->cmap, 256, 0) < 0) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	par->mode = &inf->modelist[0];
+	if(inf->init_mode & INIT_MODE_ROTATED) {
+		info->var.xres = par->mode->yres;
+		info->var.yres = par->mode->xres;
+	}
+	else {
+		info->var.xres = par->mode->xres;
+		info->var.yres = par->mode->yres;
+	}
+
+	if(inf->init_mode &= INIT_MODE_FLIPPED)
+		par->flip = 1;
+	else
+		par->flip = 0;
+
 	info->var.xres_virtual = info->var.xres;
-	info->var.yres = 480;
 	info->var.yres_virtual = info->var.yres;
-	info->var.pixclock = 0x04;	/* 171521; */
+	info->var.pixclock = 0x04;  /* 171521; */
 	info->var.sync = 0;
 	info->var.grayscale = 0;
 	info->var.xoffset = info->var.yoffset = 0;
 	info->var.accel_flags = 0;
 	info->var.activate = FB_ACTIVATE_NOW;
 
-	strcpy(info->fix.id, "w100fb");
-	info->fix.type = FB_TYPE_PACKED_PIXELS;
-	info->fix.type_aux = 0;
-	info->fix.accel = FB_ACCEL_NONE;
-	info->fix.smem_start = mem->start+MEM_EXT_BASE_VALUE;
-	info->fix.mmio_start = mem->start+W100_REG_BASE;
-	info->fix.mmio_len = W100_REG_LEN;
+	w100_hw_init(par);
+
+	if (w100fb_check_var(&info->var, info) < 0) {
+		err = -EINVAL;
+		goto out;
+	}
 
-	w100fb_check_var(&info->var, info);
 	w100fb_set_par(info);
 
 	if (register_framebuffer(info) < 0) {
-		kfree(info->pseudo_palette);
-		iounmap(remapped_base);
-		iounmap(remapped_regs);
-		iounmap(remapped_fbuf);
-		return -EINVAL;
+		err = -EINVAL;
+		goto out;
 	}
 
-	device_create_file(dev, &dev_attr_fastsysclk);
+	device_create_file(dev, &dev_attr_fastpllclk);
 	device_create_file(dev, &dev_attr_reg_read);
 	device_create_file(dev, &dev_attr_reg_write);
-	device_create_file(dev, &dev_attr_rotation);
+	device_create_file(dev, &dev_attr_flip);
 
 	printk(KERN_INFO "fb%d: %s frame buffer device\n", info->node, info->fix.id);
 	return 0;
+out:
+	fb_dealloc_cmap(&info->cmap);
+	kfree(info->pseudo_palette);
+	if (remapped_fbuf != NULL)
+		iounmap(remapped_fbuf);
+	if (remapped_regs != NULL)
+		iounmap(remapped_regs);
+	if (remapped_base != NULL)
+		iounmap(remapped_base);
+	if (info)
+		framebuffer_release(info);
+	return err;
 }
 
 
 static int w100fb_remove(struct device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
+	struct w100fb_par *par=info->par;
 
-	device_remove_file(dev, &dev_attr_fastsysclk);
+	device_remove_file(dev, &dev_attr_fastpllclk);
 	device_remove_file(dev, &dev_attr_reg_read);
 	device_remove_file(dev, &dev_attr_reg_write);
-	device_remove_file(dev, &dev_attr_rotation);
+	device_remove_file(dev, &dev_attr_flip);
 
 	unregister_framebuffer(info);
 
-	w100fb_clear_buffer();
+	vfree(par->saved_intmem);
+	vfree(par->saved_extmem);
 	kfree(info->pseudo_palette);
+	fb_dealloc_cmap(&info->cmap);
 
 	iounmap(remapped_base);
 	iounmap(remapped_regs);
@@ -721,10 +664,54 @@
 	udelay(100);
 }
 
+static void w100_update_disable(void)
+{
+	union disp_db_buf_cntl_wr_u disp_db_buf_wr_cntl;
+
+	/* Prevent display updates */
+	disp_db_buf_wr_cntl.f.db_buf_cntl = 0x1e;
+	disp_db_buf_wr_cntl.f.update_db_buf = 0;
+	disp_db_buf_wr_cntl.f.en_db_buf = 0;
+	writel((u32) (disp_db_buf_wr_cntl.val), remapped_regs + mmDISP_DB_BUF_CNTL);
+}
+
+static void w100_update_enable(void)
+{
+	union disp_db_buf_cntl_wr_u disp_db_buf_wr_cntl;
+
+	/* Enable display updates */
+	disp_db_buf_wr_cntl.f.db_buf_cntl = 0x1e;
+	disp_db_buf_wr_cntl.f.update_db_buf = 1;
+	disp_db_buf_wr_cntl.f.en_db_buf = 1;
+	writel((u32) (disp_db_buf_wr_cntl.val), remapped_regs + mmDISP_DB_BUF_CNTL);
+}
+
+unsigned long w100fb_gpio_read(int port)
+{
+	unsigned long value;
+
+	if (port==W100_GPIO_PORT_A)
+		value = readl(remapped_regs + mmGPIO_DATA);
+	else
+		value = readl(remapped_regs + mmGPIO_DATA2);
+
+	return value;
+}
+
+void w100fb_gpio_write(int port, unsigned long value)
+{
+	if (port==W100_GPIO_PORT_A)
+		value = writel(value, remapped_regs + mmGPIO_DATA);
+	else
+		value = writel(value, remapped_regs + mmGPIO_DATA2);
+}
+EXPORT_SYMBOL(w100fb_gpio_read);
+EXPORT_SYMBOL(w100fb_gpio_write);
+
 /*
  * Initialization of critical w100 hardware
  */
-static void w100_hw_init(void)
+static void w100_hw_init(struct w100fb_par *par)
 {
 	u32 temp32;
 	union cif_cntl_u cif_cntl;
@@ -735,8 +722,8 @@
 	union cpu_defaults_u cpu_default;
 	union cif_write_dbg_u cif_write_dbg;
 	union wrap_start_dir_u wrap_start_dir;
-	union mc_ext_mem_location_u mc_ext_mem_loc;
 	union cif_io_u cif_io;
+	struct w100_gpio_regs *gpio = par->mach->gpio;
 
 	w100_soft_reset();
 
@@ -791,19 +778,6 @@
 	cfgreg_base.f.cfgreg_base = W100_CFG_BASE;
 	writel((u32) (cfgreg_base.val), remapped_regs + mmCFGREG_BASE);
 
-	/* This location is relative to internal w100 addresses */
-	writel(0x15FF1000, remapped_regs + mmMC_FB_LOCATION);
-
-	mc_ext_mem_loc.val = defMC_EXT_MEM_LOCATION;
-	mc_ext_mem_loc.f.mc_ext_mem_start = MEM_EXT_BASE_VALUE >> 8;
-	mc_ext_mem_loc.f.mc_ext_mem_top = MEM_EXT_TOP_VALUE >> 8;
-	writel((u32) (mc_ext_mem_loc.val), remapped_regs + mmMC_EXT_MEM_LOCATION);
-
-	if ((current_par->lcdMode == LCD_MODE_240) || (current_par->lcdMode == LCD_MODE_320))
-		w100_InitExtMem(LCD_SHARP_QVGA);
-	else
-		w100_InitExtMem(LCD_SHARP_VGA);
-
 	wrap_start_dir.val = defWRAP_START_DIR;
 	wrap_start_dir.f.start_addr = WRAP_BUF_BASE_VALUE >> 1;
 	writel((u32) (wrap_start_dir.val), remapped_regs + mmWRAP_START_DIR);
@@ -813,21 +787,24 @@
 	writel((u32) (wrap_top_dir.val), remapped_regs + mmWRAP_TOP_DIR);
 
 	writel((u32) 0x2440, remapped_regs + mmRBBM_CNTL);
-}
 
+	/* Set the hardware to 565 colour */
+	temp32 = readl(remapped_regs + mmDISP_DEBUG2);
+	temp32 &= 0xff7fffff;
+	temp32 |= 0x00800000;
+	writel(temp32, remapped_regs + mmDISP_DEBUG2);
 
-/*
- * Types
- */
+	/* Initialise the GPIO lines */
+	if (gpio) {
+		writel(gpio->init_data1, remapped_regs + mmGPIO_DATA);
+		writel(gpio->init_data2, remapped_regs + mmGPIO_DATA2);
+		writel(gpio->gpio_dir1,  remapped_regs + mmGPIO_CNTL1);
+		writel(gpio->gpio_oe1,   remapped_regs + mmGPIO_CNTL2);
+		writel(gpio->gpio_dir2,  remapped_regs + mmGPIO_CNTL3);
+		writel(gpio->gpio_oe2,   remapped_regs + mmGPIO_CNTL4);
+	}
+}
 
-struct pll_parm {
-	u16 freq;		/* desired Fout for PLL */
-	u8 M;
-	u8 N_int;
-	u8 N_fac;
-	u8 tfgoal;
-	u8 lock_time;
-};
 
 struct power_state {
 	union clk_pin_cntl_u clk_pin_cntl;
@@ -835,317 +812,275 @@
 	union pll_cntl_u pll_cntl;
 	union sclk_cntl_u sclk_cntl;
 	union pclk_cntl_u pclk_cntl;
-	union clk_test_cntl_u clk_test_cntl;
 	union pwrmgt_cntl_u pwrmgt_cntl;
-	u32 freq;		/* Fout for PLL calibration */
-	u8 tf100;		/* for pll calibration */
-	u8 tf80;		/* for pll calibration */
-	u8 tf20;		/* for pll calibration */
-	u8 M;			/* for pll calibration */
-	u8 N_int;		/* for pll calibration */
-	u8 N_fac;		/* for pll calibration */
-	u8 lock_time;	/* for pll calibration */
-	u8 tfgoal;		/* for pll calibration */
-	u8 auto_mode;	/* hardware auto switch? */
-	u8 pwm_mode;		/* 0 fast, 1 normal/slow */
-	u16 fast_sclk;	/* fast clk freq */
-	u16 norm_sclk;	/* slow clk freq */
+	int auto_mode;  /* system clock auto changing? */
 };
 
 
-/*
- * Global state variables
- */
-
 static struct power_state w100_pwr_state;
 
-/* This table is specific for 12.5MHz ref crystal.  */
-static struct pll_parm gPLLTable[] = {
-    /*freq     M   N_int    N_fac  tfgoal  lock_time */
-    { 50,      0,   1,       0,     0xE0,        56}, /*  50.00 MHz */
-    { 75,      0,   5,       0,     0xDE,	     37}, /*  75.00 MHz */
-    {100,      0,   7,       0,     0xE0,        28}, /* 100.00 MHz */
-    {125,      0,   9,       0,     0xE0,        22}, /* 125.00 MHz */
-    {150,      0,   11,      0,     0xE0,        17}, /* 150.00 MHz */
-    {  0,      0,   0,       0,        0,         0}  /* Terminator */
+/* The PLL Fout is determined by (XtalFreq/(M+1)) * ((N_int+1) + (N_fac/8)) */
+
+/* 12.5MHz Crystal PLL Table */
+static struct w100_pll_info xtal_12500000[] = {
+	/*freq     M   N_int    N_fac  tfgoal  lock_time */
+	{ 50,      0,   1,       0,     0xe0,        56},  /*  50.00 MHz */
+	{ 75,      0,   5,       0,     0xde,        37},  /*  75.00 MHz */
+	{100,      0,   7,       0,     0xe0,        28},  /* 100.00 MHz */
+	{125,      0,   9,       0,     0xe0,        22},  /* 125.00 MHz */
+	{150,      0,   11,      0,     0xe0,        17},  /* 150.00 MHz */
+	{  0,      0,   0,       0,        0,         0},  /* Terminator */
 };
 
+/* 14.318MHz Crystal PLL Table */
+static struct w100_pll_info xtal_14318000[] = {
+	/*freq     M   N_int    N_fac  tfgoal  lock_time */
+	{ 40,      4,   13,      0,     0xe0,        80}, /* tfgoal guessed */
+	{ 50,      1,   6,       0,     0xe0,	     64}, /*  50.05 MHz */
+	{ 57,      2,   11,      0,     0xe0,        53}, /* tfgoal guessed */
+	{ 75,      0,   4,       3,     0xe0,	     43}, /*  75.08 MHz */
+	{100,      0,   6,       0,     0xe0,        32}, /* 100.10 MHz */
+	{  0,      0,   0,       0,        0,         0},
+};
+
+/* 16MHz Crystal PLL Table */
+static struct w100_pll_info xtal_16000000[] = {
+	/*freq     M   N_int    N_fac  tfgoal  lock_time */
+	{ 72,      1,   8,       0,     0xe0,        48}, /* tfgoal guessed */
+	{ 95,      1,   10,      7,     0xe0,        38}, /* tfgoal guessed */
+	{ 96,      1,   11,      0,     0xe0,        36}, /* tfgoal guessed */
+	{  0,      0,   0,       0,        0,         0},
+};
 
-static u8 w100_pll_get_testcount(u8 testclk_sel)
+static struct pll_entries {
+	int xtal_freq;
+	struct w100_pll_info *pll_table;
+} w100_pll_tables[] = {
+	{ 12500000, &xtal_12500000[0] },
+	{ 14318000, &xtal_14318000[0] },
+	{ 16000000, &xtal_16000000[0] },
+	{ 0 },
+};
+
+struct w100_pll_info *w100_get_xtal_table(unsigned int freq)
 {
-	udelay(5);
+	struct pll_entries *pll_entry = w100_pll_tables;
 
-	w100_pwr_state.clk_test_cntl.f.start_check_freq = 0x0;
-	w100_pwr_state.clk_test_cntl.f.testclk_sel = testclk_sel;
-	w100_pwr_state.clk_test_cntl.f.tstcount_rst = 0x1;	/*reset test count */
-	writel((u32) (w100_pwr_state.clk_test_cntl.val), remapped_regs + mmCLK_TEST_CNTL);
-	w100_pwr_state.clk_test_cntl.f.tstcount_rst = 0x0;
-	writel((u32) (w100_pwr_state.clk_test_cntl.val), remapped_regs + mmCLK_TEST_CNTL);
+	do {
+		if (freq == pll_entry->xtal_freq)
+			return pll_entry->pll_table;
+		pll_entry++;
+	} while (pll_entry->xtal_freq);
+	return 0;
+}
+
+
+static unsigned int w100_get_testcount(unsigned int testclk_sel)
+{
+	union clk_test_cntl_u clk_test_cntl;
+
+	udelay(5);
 
-	w100_pwr_state.clk_test_cntl.f.start_check_freq = 0x1;
-	writel((u32) (w100_pwr_state.clk_test_cntl.val), remapped_regs + mmCLK_TEST_CNTL);
+	/* Select the test clock source and reset */
+	clk_test_cntl.f.start_check_freq = 0x0;
+	clk_test_cntl.f.testclk_sel = testclk_sel;
+	clk_test_cntl.f.tstcount_rst = 0x1; /* set reset */
+	writel((u32) (clk_test_cntl.val), remapped_regs + mmCLK_TEST_CNTL);
+
+	clk_test_cntl.f.tstcount_rst = 0x0; /* clear reset */
+	writel((u32) (clk_test_cntl.val), remapped_regs + mmCLK_TEST_CNTL);
+
+	/* Run clock test */
+	clk_test_cntl.f.start_check_freq = 0x1;
+	writel((u32) (clk_test_cntl.val), remapped_regs + mmCLK_TEST_CNTL);
 
+	/* Give the test time to complete */
 	udelay(20);
 
-	w100_pwr_state.clk_test_cntl.val = readl(remapped_regs + mmCLK_TEST_CNTL);
-	w100_pwr_state.clk_test_cntl.f.start_check_freq = 0x0;
-	writel((u32) (w100_pwr_state.clk_test_cntl.val), remapped_regs + mmCLK_TEST_CNTL);
+	/* Return the result */
+	clk_test_cntl.val = readl(remapped_regs + mmCLK_TEST_CNTL);
+	clk_test_cntl.f.start_check_freq = 0x0;
+	writel((u32) (clk_test_cntl.val), remapped_regs + mmCLK_TEST_CNTL);
 
-	return w100_pwr_state.clk_test_cntl.f.test_count;
+	return clk_test_cntl.f.test_count;
 }
 
 
-static u8 w100_pll_adjust(void)
+static int w100_pll_adjust(struct w100_pll_info *pll)
 {
+	unsigned int tf80;
+	unsigned int tf20;
+
+	/* Initial Settings */
+	w100_pwr_state.pll_cntl.f.pll_pwdn = 0x0;     /* power down */
+	w100_pwr_state.pll_cntl.f.pll_reset = 0x0;    /* not reset */
+	w100_pwr_state.pll_cntl.f.pll_tcpoff = 0x1;   /* Hi-Z */
+	w100_pwr_state.pll_cntl.f.pll_pvg = 0x0;      /* VCO gain = 0 */
+	w100_pwr_state.pll_cntl.f.pll_vcofr = 0x0;    /* VCO frequency range control = off */
+	w100_pwr_state.pll_cntl.f.pll_ioffset = 0x0;  /* current offset inside VCO = 0 */
+	w100_pwr_state.pll_cntl.f.pll_ring_off = 0x0;
+
+	/* Wai Ming 80 percent of VDD 1.3V gives 1.04V, minimum operating voltage is 1.08V
+	 * therefore, commented out the following lines
+	 * tf80 meant tf100
+	 */
 	do {
-		/* Wai Ming 80 percent of VDD 1.3V gives 1.04V, minimum operating voltage is 1.08V
-		 * therefore, commented out the following lines
-		 * tf80 meant tf100
-		 * set VCO input = 0.8 * VDD
-		 */
+		/* set VCO input = 0.8 * VDD */
 		w100_pwr_state.pll_cntl.f.pll_dactal = 0xd;
 		writel((u32) (w100_pwr_state.pll_cntl.val), remapped_regs + mmPLL_CNTL);
 
-		w100_pwr_state.tf80 = w100_pll_get_testcount(0x1);	/* PLLCLK */
-		if (w100_pwr_state.tf80 >= (w100_pwr_state.tfgoal)) {
+		tf80 = w100_get_testcount(TESTCLK_SRC_PLL);
+		if (tf80 >= (pll->tfgoal)) {
 			/* set VCO input = 0.2 * VDD */
 			w100_pwr_state.pll_cntl.f.pll_dactal = 0x7;
 			writel((u32) (w100_pwr_state.pll_cntl.val), remapped_regs + mmPLL_CNTL);
 
-			w100_pwr_state.tf20 = w100_pll_get_testcount(0x1);	/* PLLCLK */
-			if (w100_pwr_state.tf20 <= (w100_pwr_state.tfgoal))
-				return 1; // Success
+			tf20 = w100_get_testcount(TESTCLK_SRC_PLL);
+			if (tf20 <= (pll->tfgoal))
+				return 1;  /* Success */
 
 			if ((w100_pwr_state.pll_cntl.f.pll_vcofr == 0x0) &&
-			    ((w100_pwr_state.pll_cntl.f.pll_pvg == 0x7) ||
-			     (w100_pwr_state.pll_cntl.f.pll_ioffset == 0x0))) {
+				((w100_pwr_state.pll_cntl.f.pll_pvg == 0x7) ||
+				(w100_pwr_state.pll_cntl.f.pll_ioffset == 0x0))) {
 				/* slow VCO config */
 				w100_pwr_state.pll_cntl.f.pll_vcofr = 0x1;
 				w100_pwr_state.pll_cntl.f.pll_pvg = 0x0;
 				w100_pwr_state.pll_cntl.f.pll_ioffset = 0x0;
-				writel((u32) (w100_pwr_state.pll_cntl.val),
-					remapped_regs + mmPLL_CNTL);
 				continue;
 			}
 		}
 		if ((w100_pwr_state.pll_cntl.f.pll_ioffset) < 0x3) {
 			w100_pwr_state.pll_cntl.f.pll_ioffset += 0x1;
-			writel((u32) (w100_pwr_state.pll_cntl.val), remapped_regs + mmPLL_CNTL);
-			continue;
-		}
-		if ((w100_pwr_state.pll_cntl.f.pll_pvg) < 0x7) {
+		} else if ((w100_pwr_state.pll_cntl.f.pll_pvg) < 0x7) {
 			w100_pwr_state.pll_cntl.f.pll_ioffset = 0x0;
 			w100_pwr_state.pll_cntl.f.pll_pvg += 0x1;
-			writel((u32) (w100_pwr_state.pll_cntl.val), remapped_regs + mmPLL_CNTL);
-			continue;
+		} else {
+			return 0;  /* Error */
 		}
-		return 0; // error
 	} while(1);
 }
 
 
 /*
  * w100_pll_calibration
- *                freq = target frequency of the PLL
- *                (note: crystal = 14.3MHz)
  */
-static u8 w100_pll_calibration(u32 freq)
+static int w100_pll_calibration(struct w100_pll_info *pll)
 {
-	u8 status;
+	int status;
 
-	/* initial setting */
-	w100_pwr_state.pll_cntl.f.pll_pwdn = 0x0;		/* power down */
-	w100_pwr_state.pll_cntl.f.pll_reset = 0x0;		/* not reset */
-	w100_pwr_state.pll_cntl.f.pll_tcpoff = 0x1;	/* Hi-Z */
-	w100_pwr_state.pll_cntl.f.pll_pvg = 0x0;		/* VCO gain = 0 */
-	w100_pwr_state.pll_cntl.f.pll_vcofr = 0x0;		/* VCO frequency range control = off */
-	w100_pwr_state.pll_cntl.f.pll_ioffset = 0x0;	/* current offset inside VCO = 0 */
-	w100_pwr_state.pll_cntl.f.pll_ring_off = 0x0;
-	writel((u32) (w100_pwr_state.pll_cntl.val), remapped_regs + mmPLL_CNTL);
+	status = w100_pll_adjust(pll);
 
-	/* check for (tf80 >= tfgoal) && (tf20 =< tfgoal) */
-	if ((w100_pwr_state.tf80 < w100_pwr_state.tfgoal) || (w100_pwr_state.tf20 > w100_pwr_state.tfgoal)) {
-		status=w100_pll_adjust();
-	}
 	/* PLL Reset And Lock */
-
 	/* set VCO input = 0.5 * VDD */
 	w100_pwr_state.pll_cntl.f.pll_dactal = 0xa;
 	writel((u32) (w100_pwr_state.pll_cntl.val), remapped_regs + mmPLL_CNTL);
 
-	/* reset time */
-	udelay(1);
+	udelay(1);  /* reset time */
 
 	/* enable charge pump */
-	w100_pwr_state.pll_cntl.f.pll_tcpoff = 0x0;	/* normal */
+	w100_pwr_state.pll_cntl.f.pll_tcpoff = 0x0;  /* normal */
 	writel((u32) (w100_pwr_state.pll_cntl.val), remapped_regs + mmPLL_CNTL);
 
-	/* set VCO input = Hi-Z */
-	/* disable DAC */
+	/* set VCO input = Hi-Z, disable DAC */
 	w100_pwr_state.pll_cntl.f.pll_dactal = 0x0;
 	writel((u32) (w100_pwr_state.pll_cntl.val), remapped_regs + mmPLL_CNTL);
 
-	/* lock time */
-	udelay(400);	/* delay 400 us */
+	udelay(400);  /* lock time */
 
 	/* PLL locked */
 
-	w100_pwr_state.sclk_cntl.f.sclk_src_sel = 0x1;	/* PLL clock */
-	writel((u32) (w100_pwr_state.sclk_cntl.val), remapped_regs + mmSCLK_CNTL);
-
-	w100_pwr_state.tf100 = w100_pll_get_testcount(0x1);	/* PLLCLK */
-
 	return status;
 }
 
 
-static u8 w100_pll_set_clk(void)
+static int w100_pll_set_clk(struct w100_pll_info *pll)
 {
-	u8 status;
+	int status;
 
-	if (w100_pwr_state.auto_mode == 1)	/* auto mode */
+	if (w100_pwr_state.auto_mode == 1)  /* auto mode */
 	{
-		w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_hw_en = 0x0;	/* disable fast to normal */
-		w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_hw_en = 0x0;	/* disable normal to fast */
+		w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_hw_en = 0x0;  /* disable fast to normal */
+		w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_hw_en = 0x0;  /* disable normal to fast */
 		writel((u32) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + mmPWRMGT_CNTL);
 	}
 
-	w100_pwr_state.sclk_cntl.f.sclk_src_sel = 0x0;	/* crystal clock */
+	/* Set system clock source to XTAL whilst adjusting the PLL! */
+	w100_pwr_state.sclk_cntl.f.sclk_src_sel = CLK_SRC_XTAL;
 	writel((u32) (w100_pwr_state.sclk_cntl.val), remapped_regs + mmSCLK_CNTL);
 
-	w100_pwr_state.pll_ref_fb_div.f.pll_ref_div = w100_pwr_state.M;
-	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_int = w100_pwr_state.N_int;
-	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_frac = w100_pwr_state.N_fac;
-	w100_pwr_state.pll_ref_fb_div.f.pll_lock_time = w100_pwr_state.lock_time;
+	w100_pwr_state.pll_ref_fb_div.f.pll_ref_div = pll->M;
+	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_int = pll->N_int;
+	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_frac = pll->N_fac;
+	w100_pwr_state.pll_ref_fb_div.f.pll_lock_time = pll->lock_time;
 	writel((u32) (w100_pwr_state.pll_ref_fb_div.val), remapped_regs + mmPLL_REF_FB_DIV);
 
 	w100_pwr_state.pwrmgt_cntl.f.pwm_mode_req = 0;
 	writel((u32) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + mmPWRMGT_CNTL);
 
-	status = w100_pll_calibration (w100_pwr_state.freq);
+	status = w100_pll_calibration(pll);
 
-	if (w100_pwr_state.auto_mode == 1)	/* auto mode */
+	if (w100_pwr_state.auto_mode == 1)  /* auto mode */
 	{
-		w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_hw_en = 0x1;	/* reenable fast to normal */
-		w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_hw_en = 0x1;	/* reenable normal to fast  */
+		w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_hw_en = 0x1;  /* reenable fast to normal */
+		w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_hw_en = 0x1;  /* reenable normal to fast  */
 		writel((u32) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + mmPWRMGT_CNTL);
 	}
 	return status;
 }
 
-
-/* assume reference crystal clk is 12.5MHz,
- * and that doubling is not enabled.
- *
- * Freq = 12 == 12.5MHz.
- */
-static u16 w100_set_slowsysclk(u16 freq)
+/* freq = target frequency of the PLL */
+static int w100_set_pll_freq(struct w100fb_par *par, unsigned int freq)
 {
-	if (w100_pwr_state.norm_sclk == freq)
-		return freq;
-
-	if (w100_pwr_state.auto_mode == 1)	/* auto mode */
-		return 0;
-
-	if (freq == 12) {
-		w100_pwr_state.norm_sclk = freq;
-		w100_pwr_state.sclk_cntl.f.sclk_post_div_slow = 0x0;	/* Pslow = 1 */
-		w100_pwr_state.sclk_cntl.f.sclk_src_sel = 0x0;	/* crystal src */
-
-		writel((u32) (w100_pwr_state.sclk_cntl.val), remapped_regs + mmSCLK_CNTL);
-
-		w100_pwr_state.clk_pin_cntl.f.xtalin_pm_en = 0x1;
-		writel((u32) (w100_pwr_state.clk_pin_cntl.val), remapped_regs + mmCLK_PIN_CNTL);
+	struct w100_pll_info *pll = par->pll_table;
 
-		w100_pwr_state.pwrmgt_cntl.f.pwm_enable = 0x1;
-		w100_pwr_state.pwrmgt_cntl.f.pwm_mode_req = 0x1;
-		writel((u32) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + mmPWRMGT_CNTL);
-		w100_pwr_state.pwm_mode = 1;	/* normal mode */
-		return freq;
-	} else
-		return 0;
-}
-
-
-static u16 w100_set_fastsysclk(u16 freq)
-{
-	u16 pll_freq;
-	int i;
-
-	while(1) {
-		pll_freq = (u16) (freq * (w100_pwr_state.sclk_cntl.f.sclk_post_div_fast + 1));
-		i = 0;
-		do {
-			if (pll_freq == gPLLTable[i].freq) {
-				w100_pwr_state.freq = gPLLTable[i].freq * 1000000;
-				w100_pwr_state.M = gPLLTable[i].M;
-				w100_pwr_state.N_int = gPLLTable[i].N_int;
-				w100_pwr_state.N_fac = gPLLTable[i].N_fac;
-				w100_pwr_state.tfgoal = gPLLTable[i].tfgoal;
-				w100_pwr_state.lock_time = gPLLTable[i].lock_time;
-				w100_pwr_state.tf20 = 0xff;	/* set highest */
-				w100_pwr_state.tf80 = 0x00;	/* set lowest */
-
-				w100_pll_set_clk();
-				w100_pwr_state.pwm_mode = 0;	/* fast mode */
-				w100_pwr_state.fast_sclk = freq;
-				return freq;
-			}
-			i++;
-		} while(gPLLTable[i].freq);
-
-		if (w100_pwr_state.auto_mode == 1)
-			break;
-
-		if (w100_pwr_state.sclk_cntl.f.sclk_post_div_fast == 0)
-			break;
-
-		w100_pwr_state.sclk_cntl.f.sclk_post_div_fast -= 1;
-		writel((u32) (w100_pwr_state.sclk_cntl.val), remapped_regs + mmSCLK_CNTL);
-	}
+	do {
+		if (freq == pll->freq) {
+			return w100_pll_set_clk(pll);
+		}
+		pll++;
+	} while(pll->freq);
 	return 0;
 }
 
-
 /* Set up an initial state.  Some values/fields set
    here will be overwritten. */
-static void w100_pwm_setup(void)
+static void w100_pwm_setup(struct w100fb_par *par)
 {
 	w100_pwr_state.clk_pin_cntl.f.osc_en = 0x1;
 	w100_pwr_state.clk_pin_cntl.f.osc_gain = 0x1f;
 	w100_pwr_state.clk_pin_cntl.f.dont_use_xtalin = 0x0;
 	w100_pwr_state.clk_pin_cntl.f.xtalin_pm_en = 0x0;
-	w100_pwr_state.clk_pin_cntl.f.xtalin_dbl_en = 0x0;	/* no freq doubling */
+	w100_pwr_state.clk_pin_cntl.f.xtalin_dbl_en = par->mach->xtal_dbl ? 1 : 0;
 	w100_pwr_state.clk_pin_cntl.f.cg_debug = 0x0;
 	writel((u32) (w100_pwr_state.clk_pin_cntl.val), remapped_regs + mmCLK_PIN_CNTL);
 
-	w100_pwr_state.sclk_cntl.f.sclk_src_sel = 0x0;	/* Crystal Clk */
-	w100_pwr_state.sclk_cntl.f.sclk_post_div_fast = 0x0;	/* Pfast = 1 */
+	w100_pwr_state.sclk_cntl.f.sclk_src_sel = CLK_SRC_XTAL;
+	w100_pwr_state.sclk_cntl.f.sclk_post_div_fast = 0x0;  /* Pfast = 1 */
 	w100_pwr_state.sclk_cntl.f.sclk_clkon_hys = 0x3;
-	w100_pwr_state.sclk_cntl.f.sclk_post_div_slow = 0x0;	/* Pslow = 1 */
+	w100_pwr_state.sclk_cntl.f.sclk_post_div_slow = 0x0;  /* Pslow = 1 */
 	w100_pwr_state.sclk_cntl.f.disp_cg_ok2switch_en = 0x0;
-	w100_pwr_state.sclk_cntl.f.sclk_force_reg = 0x0;	/* Dynamic */
-	w100_pwr_state.sclk_cntl.f.sclk_force_disp = 0x0;	/* Dynamic */
-	w100_pwr_state.sclk_cntl.f.sclk_force_mc = 0x0;	/* Dynamic */
-	w100_pwr_state.sclk_cntl.f.sclk_force_extmc = 0x0;	/* Dynamic */
-	w100_pwr_state.sclk_cntl.f.sclk_force_cp = 0x0;	/* Dynamic */
-	w100_pwr_state.sclk_cntl.f.sclk_force_e2 = 0x0;	/* Dynamic */
-	w100_pwr_state.sclk_cntl.f.sclk_force_e3 = 0x0;	/* Dynamic */
-	w100_pwr_state.sclk_cntl.f.sclk_force_idct = 0x0;	/* Dynamic */
-	w100_pwr_state.sclk_cntl.f.sclk_force_bist = 0x0;	/* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_reg = 0x0;    /* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_disp = 0x0;   /* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_mc = 0x0;     /* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_extmc = 0x0;  /* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_cp = 0x0;     /* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_e2 = 0x0;     /* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_e3 = 0x0;     /* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_idct = 0x0;   /* Dynamic */
+	w100_pwr_state.sclk_cntl.f.sclk_force_bist = 0x0;   /* Dynamic */
 	w100_pwr_state.sclk_cntl.f.busy_extend_cp = 0x0;
 	w100_pwr_state.sclk_cntl.f.busy_extend_e2 = 0x0;
 	w100_pwr_state.sclk_cntl.f.busy_extend_e3 = 0x0;
 	w100_pwr_state.sclk_cntl.f.busy_extend_idct = 0x0;
 	writel((u32) (w100_pwr_state.sclk_cntl.val), remapped_regs + mmSCLK_CNTL);
 
-	w100_pwr_state.pclk_cntl.f.pclk_src_sel = 0x0;	/* Crystal Clk */
-	w100_pwr_state.pclk_cntl.f.pclk_post_div = 0x1;	/* P = 2 */
-	w100_pwr_state.pclk_cntl.f.pclk_force_disp = 0x0;	/* Dynamic */
+	w100_pwr_state.pclk_cntl.f.pclk_src_sel = CLK_SRC_XTAL;
+	w100_pwr_state.pclk_cntl.f.pclk_post_div = 0x1;    /* P = 2 */
+	w100_pwr_state.pclk_cntl.f.pclk_force_disp = 0x0;  /* Dynamic */
 	writel((u32) (w100_pwr_state.pclk_cntl.val), remapped_regs + mmPCLK_CNTL);
 
-	w100_pwr_state.pll_ref_fb_div.f.pll_ref_div = 0x0;	/* M = 1 */
-	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_int = 0x0;	/* N = 1.0 */
+	w100_pwr_state.pll_ref_fb_div.f.pll_ref_div = 0x0;     /* M = 1 */
+	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_int = 0x0;  /* N = 1.0 */
 	w100_pwr_state.pll_ref_fb_div.f.pll_fb_div_frac = 0x0;
 	w100_pwr_state.pll_ref_fb_div.f.pll_reset_time = 0x5;
 	w100_pwr_state.pll_ref_fb_div.f.pll_lock_time = 0xff;
@@ -1154,7 +1089,7 @@
 	w100_pwr_state.pll_cntl.f.pll_pwdn = 0x1;
 	w100_pwr_state.pll_cntl.f.pll_reset = 0x1;
 	w100_pwr_state.pll_cntl.f.pll_pm_en = 0x0;
-	w100_pwr_state.pll_cntl.f.pll_mode = 0x0;	/* uses VCO clock */
+	w100_pwr_state.pll_cntl.f.pll_mode = 0x0;  /* uses VCO clock */
 	w100_pwr_state.pll_cntl.f.pll_refclk_sel = 0x0;
 	w100_pwr_state.pll_cntl.f.pll_fbclk_sel = 0x0;
 	w100_pwr_state.pll_cntl.f.pll_tcpoff = 0x0;
@@ -1164,221 +1099,276 @@
 	w100_pwr_state.pll_cntl.f.pll_ioffset = 0x0;
 	w100_pwr_state.pll_cntl.f.pll_pecc_mode = 0x0;
 	w100_pwr_state.pll_cntl.f.pll_pecc_scon = 0x0;
-	w100_pwr_state.pll_cntl.f.pll_dactal = 0x0;	/* Hi-Z */
+	w100_pwr_state.pll_cntl.f.pll_dactal = 0x0;  /* Hi-Z */
 	w100_pwr_state.pll_cntl.f.pll_cp_clip = 0x3;
 	w100_pwr_state.pll_cntl.f.pll_conf = 0x2;
 	w100_pwr_state.pll_cntl.f.pll_mbctrl = 0x2;
 	w100_pwr_state.pll_cntl.f.pll_ring_off = 0x0;
 	writel((u32) (w100_pwr_state.pll_cntl.val), remapped_regs + mmPLL_CNTL);
 
-	w100_pwr_state.clk_test_cntl.f.testclk_sel = 0x1;	/* PLLCLK (for testing) */
-	w100_pwr_state.clk_test_cntl.f.start_check_freq = 0x0;
-	w100_pwr_state.clk_test_cntl.f.tstcount_rst = 0x0;
-	writel((u32) (w100_pwr_state.clk_test_cntl.val), remapped_regs + mmCLK_TEST_CNTL);
-
 	w100_pwr_state.pwrmgt_cntl.f.pwm_enable = 0x0;
-	w100_pwr_state.pwrmgt_cntl.f.pwm_mode_req = 0x1;	/* normal mode (0, 1, 3) */
+	w100_pwr_state.pwrmgt_cntl.f.pwm_mode_req = 0x1;  /* normal mode (0, 1, 3) */
 	w100_pwr_state.pwrmgt_cntl.f.pwm_wakeup_cond = 0x0;
 	w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_hw_en = 0x0;
 	w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_hw_en = 0x0;
-	w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_cond = 0x1;	/* PM4,ENG */
-	w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_cond = 0x1;	/* PM4,ENG */
+	w100_pwr_state.pwrmgt_cntl.f.pwm_fast_noml_cond = 0x1;  /* PM4,ENG */
+	w100_pwr_state.pwrmgt_cntl.f.pwm_noml_fast_cond = 0x1;  /* PM4,ENG */
 	w100_pwr_state.pwrmgt_cntl.f.pwm_idle_timer = 0xFF;
 	w100_pwr_state.pwrmgt_cntl.f.pwm_busy_timer = 0xFF;
 	writel((u32) (w100_pwr_state.pwrmgt_cntl.val), remapped_regs + mmPWRMGT_CNTL);
 
-	w100_pwr_state.auto_mode = 0;	/* manual mode */
-	w100_pwr_state.pwm_mode = 1;	/* normal mode (0, 1, 2) */
-	w100_pwr_state.freq = 50000000;	/* 50 MHz */
-	w100_pwr_state.M = 3;	/* M = 4 */
-	w100_pwr_state.N_int = 6;	/* N = 7.0 */
-	w100_pwr_state.N_fac = 0;
-	w100_pwr_state.tfgoal = 0xE0;
-	w100_pwr_state.lock_time = 56;
-	w100_pwr_state.tf20 = 0xff;	/* set highest */
-	w100_pwr_state.tf80 = 0x00;	/* set lowest */
-	w100_pwr_state.tf100 = 0x00;	/* set lowest */
-	w100_pwr_state.fast_sclk = 50;	/* 50.0 MHz */
-	w100_pwr_state.norm_sclk = 12;	/* 12.5 MHz */
+	w100_pwr_state.auto_mode = 0;  /* manual mode */
 }
 
 
-static void w100_init_sharp_lcd(u32 mode)
+/*
+ * Setup the w100 clocks for the specified mode
+ */
+static void w100_init_clocks(struct w100fb_par *par)
 {
-	u32 temp32;
-	union disp_db_buf_cntl_wr_u disp_db_buf_wr_cntl;
+	struct w100_mode *mode = par->mode;
 
-	/* Prevent display updates */
-	disp_db_buf_wr_cntl.f.db_buf_cntl = 0x1e;
-	disp_db_buf_wr_cntl.f.update_db_buf = 0;
-	disp_db_buf_wr_cntl.f.en_db_buf = 0;
-	writel((u32) (disp_db_buf_wr_cntl.val), remapped_regs + mmDISP_DB_BUF_CNTL);
+	if (mode->pixclk_src == CLK_SRC_PLL || mode->sysclk_src == CLK_SRC_PLL)
+		w100_set_pll_freq(par, (par->fastpll_mode && mode->fast_pll_freq) ? mode->fast_pll_freq : mode->pll_freq);
 
-	switch(mode) {
-	case LCD_SHARP_QVGA:
-		w100_set_slowsysclk(12);	/* use crystal -- 12.5MHz */
-		/* not use PLL */
-
-		writel(0x7FFF8000, remapped_regs + mmMC_EXT_MEM_LOCATION);
-		writel(0x85FF8000, remapped_regs + mmMC_FB_LOCATION);
-		writel(0x00000003, remapped_regs + mmLCD_FORMAT);
-		writel(0x00CF1C06, remapped_regs + mmGRAPHIC_CTRL);
-		writel(0x01410145, remapped_regs + mmCRTC_TOTAL);
-		writel(0x01170027, remapped_regs + mmACTIVE_H_DISP);
-		writel(0x01410001, remapped_regs + mmACTIVE_V_DISP);
-		writel(0x01170027, remapped_regs + mmGRAPHIC_H_DISP);
-		writel(0x01410001, remapped_regs + mmGRAPHIC_V_DISP);
-		writel(0x81170027, remapped_regs + mmCRTC_SS);
-		writel(0xA0140000, remapped_regs + mmCRTC_LS);
-		writel(0x00400008, remapped_regs + mmCRTC_REV);
-		writel(0xA0000000, remapped_regs + mmCRTC_DCLK);
-		writel(0xC0140014, remapped_regs + mmCRTC_GS);
-		writel(0x00010141, remapped_regs + mmCRTC_VPOS_GS);
-		writel(0x8015010F, remapped_regs + mmCRTC_GCLK);
-		writel(0x80100110, remapped_regs + mmCRTC_GOE);
-		writel(0x00000000, remapped_regs + mmCRTC_FRAME);
-		writel(0x00000000, remapped_regs + mmCRTC_FRAME_VPOS);
-		writel(0x01CC0000, remapped_regs + mmLCDD_CNTL1);
-		writel(0x0003FFFF, remapped_regs + mmLCDD_CNTL2);
-		writel(0x00FFFF0D, remapped_regs + mmGENLCD_CNTL1);
-		writel(0x003F3003, remapped_regs + mmGENLCD_CNTL2);
-		writel(0x00000000, remapped_regs + mmCRTC_DEFAULT_COUNT);
-		writel(0x0000FF00, remapped_regs + mmLCD_BACKGROUND_COLOR);
-		writel(0x000102aa, remapped_regs + mmGENLCD_CNTL3);
-		writel(0x00800000, remapped_regs + mmGRAPHIC_OFFSET);
-		writel(0x000001e0, remapped_regs + mmGRAPHIC_PITCH);
-		writel(0x000000bf, remapped_regs + mmGPIO_DATA);
-		writel(0x03c0feff, remapped_regs + mmGPIO_CNTL2);
-		writel(0x00000000, remapped_regs + mmGPIO_CNTL1);
-		writel(0x41060010, remapped_regs + mmCRTC_PS1_ACTIVE);
-		break;
-	case LCD_SHARP_VGA:
-		w100_set_slowsysclk(12);	/* use crystal -- 12.5MHz */
-		w100_set_fastsysclk(current_par->fastsysclk_mode);	/* use PLL -- 75.0MHz */
-		w100_pwr_state.pclk_cntl.f.pclk_src_sel = 0x1;
-		w100_pwr_state.pclk_cntl.f.pclk_post_div = 0x2;
-		writel((u32) (w100_pwr_state.pclk_cntl.val), remapped_regs + mmPCLK_CNTL);
-		writel(0x15FF1000, remapped_regs + mmMC_FB_LOCATION);
-		writel(0x9FFF8000, remapped_regs + mmMC_EXT_MEM_LOCATION);
-		writel(0x00000003, remapped_regs + mmLCD_FORMAT);
-		writel(0x00DE1D66, remapped_regs + mmGRAPHIC_CTRL);
-
-		writel(0x0283028B, remapped_regs + mmCRTC_TOTAL);
-		writel(0x02360056, remapped_regs + mmACTIVE_H_DISP);
-		writel(0x02830003, remapped_regs + mmACTIVE_V_DISP);
-		writel(0x02360056, remapped_regs + mmGRAPHIC_H_DISP);
-		writel(0x02830003, remapped_regs + mmGRAPHIC_V_DISP);
-		writel(0x82360056, remapped_regs + mmCRTC_SS);
-		writel(0xA0280000, remapped_regs + mmCRTC_LS);
-		writel(0x00400008, remapped_regs + mmCRTC_REV);
-		writel(0xA0000000, remapped_regs + mmCRTC_DCLK);
-		writel(0x80280028, remapped_regs + mmCRTC_GS);
-		writel(0x02830002, remapped_regs + mmCRTC_VPOS_GS);
-		writel(0x8015010F, remapped_regs + mmCRTC_GCLK);
-		writel(0x80100110, remapped_regs + mmCRTC_GOE);
-		writel(0x00000000, remapped_regs + mmCRTC_FRAME);
-		writel(0x00000000, remapped_regs + mmCRTC_FRAME_VPOS);
-		writel(0x01CC0000, remapped_regs + mmLCDD_CNTL1);
-		writel(0x0003FFFF, remapped_regs + mmLCDD_CNTL2);
-		writel(0x00FFFF0D, remapped_regs + mmGENLCD_CNTL1);
-		writel(0x003F3003, remapped_regs + mmGENLCD_CNTL2);
-		writel(0x00000000, remapped_regs + mmCRTC_DEFAULT_COUNT);
-		writel(0x0000FF00, remapped_regs + mmLCD_BACKGROUND_COLOR);
-		writel(0x000102aa, remapped_regs + mmGENLCD_CNTL3);
-		writel(0x00800000, remapped_regs + mmGRAPHIC_OFFSET);
-		writel(0x000003C0, remapped_regs + mmGRAPHIC_PITCH);
-		writel(0x000000bf, remapped_regs + mmGPIO_DATA);
-		writel(0x03c0feff, remapped_regs + mmGPIO_CNTL2);
-		writel(0x00000000, remapped_regs + mmGPIO_CNTL1);
-		writel(0x41060010, remapped_regs + mmCRTC_PS1_ACTIVE);
-		break;
-	default:
-		break;
-	}
+	w100_pwr_state.sclk_cntl.f.sclk_src_sel = mode->sysclk_src;
+	w100_pwr_state.sclk_cntl.f.sclk_post_div_fast = mode->sysclk_divider;
+	w100_pwr_state.sclk_cntl.f.sclk_post_div_slow = mode->sysclk_divider;
+	writel((u32) (w100_pwr_state.sclk_cntl.val), remapped_regs + mmSCLK_CNTL);
+}
+
+static void w100_init_lcd(struct w100fb_par *par)
+{
+	u32 temp32;
+	struct w100_mode *mode = par->mode;
+	struct w100_gen_regs *regs = par->mach->regs;
+	union active_h_disp_u active_h_disp;
+	union active_v_disp_u active_v_disp;
+	union graphic_h_disp_u graphic_h_disp;
+	union graphic_v_disp_u graphic_v_disp;
+	union crtc_total_u crtc_total;
+
+	/* w3200 doesnt like undefined bits being set so zero register values first */
+
+	active_h_disp.val = 0;
+	active_h_disp.f.active_h_start=mode->left_margin;
+	active_h_disp.f.active_h_end=mode->left_margin + mode->xres;
+	writel(active_h_disp.val, remapped_regs + mmACTIVE_H_DISP);
+
+	active_v_disp.val = 0;
+	active_v_disp.f.active_v_start=mode->upper_margin;
+	active_v_disp.f.active_v_end=mode->upper_margin + mode->yres;
+	writel(active_v_disp.val, remapped_regs + mmACTIVE_V_DISP);
+
+	graphic_h_disp.val = 0;
+	graphic_h_disp.f.graphic_h_start=mode->left_margin;
+	graphic_h_disp.f.graphic_h_end=mode->left_margin + mode->xres;
+	writel(graphic_h_disp.val, remapped_regs + mmGRAPHIC_H_DISP);
+
+	graphic_v_disp.val = 0;
+	graphic_v_disp.f.graphic_v_start=mode->upper_margin;
+	graphic_v_disp.f.graphic_v_end=mode->upper_margin + mode->yres;
+	writel(graphic_v_disp.val, remapped_regs + mmGRAPHIC_V_DISP);
+
+	crtc_total.val = 0;
+	crtc_total.f.crtc_h_total=mode->left_margin  + mode->xres + mode->right_margin;
+	crtc_total.f.crtc_v_total=mode->upper_margin + mode->yres + mode->lower_margin;
+	writel(crtc_total.val, remapped_regs + mmCRTC_TOTAL);
+
+	writel(mode->crtc_ss, remapped_regs + mmCRTC_SS);
+	writel(mode->crtc_ls, remapped_regs + mmCRTC_LS);
+	writel(mode->crtc_gs, remapped_regs + mmCRTC_GS);
+	writel(mode->crtc_vpos_gs, remapped_regs + mmCRTC_VPOS_GS);
+	writel(mode->crtc_rev, remapped_regs + mmCRTC_REV);
+	writel(mode->crtc_dclk, remapped_regs + mmCRTC_DCLK);
+	writel(mode->crtc_gclk, remapped_regs + mmCRTC_GCLK);
+	writel(mode->crtc_goe, remapped_regs + mmCRTC_GOE);
+	writel(mode->crtc_ps1_active, remapped_regs + mmCRTC_PS1_ACTIVE);
+
+	writel(regs->lcd_format, remapped_regs + mmLCD_FORMAT);
+	writel(regs->lcdd_cntl1, remapped_regs + mmLCDD_CNTL1);
+	writel(regs->lcdd_cntl2, remapped_regs + mmLCDD_CNTL2);
+	writel(regs->genlcd_cntl1, remapped_regs + mmGENLCD_CNTL1);
+	writel(regs->genlcd_cntl2, remapped_regs + mmGENLCD_CNTL2);
+	writel(regs->genlcd_cntl3, remapped_regs + mmGENLCD_CNTL3);
+
+	writel(0x00000000, remapped_regs + mmCRTC_FRAME);
+	writel(0x00000000, remapped_regs + mmCRTC_FRAME_VPOS);
+	writel(0x00000000, remapped_regs + mmCRTC_DEFAULT_COUNT);
+	writel(0x0000FF00, remapped_regs + mmLCD_BACKGROUND_COLOR);
 
 	/* Hack for overlay in ext memory */
 	temp32 = readl(remapped_regs + mmDISP_DEBUG2);
 	temp32 |= 0xc0000000;
 	writel(temp32, remapped_regs + mmDISP_DEBUG2);
-
-	/* Re-enable display updates */
-	disp_db_buf_wr_cntl.f.db_buf_cntl = 0x1e;
-	disp_db_buf_wr_cntl.f.update_db_buf = 1;
-	disp_db_buf_wr_cntl.f.en_db_buf = 1;
-	writel((u32) (disp_db_buf_wr_cntl.val), remapped_regs + mmDISP_DB_BUF_CNTL);
 }
 
 
-static void w100_set_vga_rotation_regs(u16 divider, unsigned long ctrl, unsigned long offset, unsigned long pitch)
+static void w100_setup_memory(struct w100fb_par *par)
 {
-	w100_pwr_state.pclk_cntl.f.pclk_src_sel = 0x1;
-	w100_pwr_state.pclk_cntl.f.pclk_post_div = divider;
-	writel((u32) (w100_pwr_state.pclk_cntl.val), remapped_regs + mmPCLK_CNTL);
+	union mc_ext_mem_location_u extmem_location;
+	union mc_fb_location_u intmem_location;
+	struct w100_mem_info *mem = par->mach->mem;
+	struct w100_bm_mem_info *bm_mem = par->mach->bm_mem;
 
-	writel(ctrl, remapped_regs + mmGRAPHIC_CTRL);
-	writel(offset, remapped_regs + mmGRAPHIC_OFFSET);
-	writel(pitch, remapped_regs + mmGRAPHIC_PITCH);
-
-	/* Re-enable display updates */
-	writel(0x0000007b, remapped_regs + mmDISP_DB_BUF_CNTL);
-}
+	if (!par->extmem_active) {
+		w100_suspend(W100_SUSPEND_EXTMEM);
 
+		/* Map Internal Memory at FB Base */
+		intmem_location.f.mc_fb_start = W100_FB_BASE >> 8;
+		intmem_location.f.mc_fb_top = (W100_FB_BASE+MEM_INT_SIZE) >> 8;
+		writel((u32) (intmem_location.val), remapped_regs + mmMC_FB_LOCATION);
+
+		/* Unmap External Memory - value is *probably* irrelevant but may have meaning
+		   to acceleration libraries */
+		extmem_location.f.mc_ext_mem_start = MEM_EXT_BASE_VALUE >> 8;
+		extmem_location.f.mc_ext_mem_top = (MEM_EXT_BASE_VALUE-1) >> 8;
+		writel((u32) (extmem_location.val), remapped_regs + mmMC_EXT_MEM_LOCATION);
+	} else {
+		/* Map Internal Memory to its default location */
+		intmem_location.f.mc_fb_start = MEM_INT_BASE_VALUE >> 8;
+		intmem_location.f.mc_fb_top = (MEM_INT_BASE_VALUE+MEM_INT_SIZE) >> 8;
+		writel((u32) (intmem_location.val), remapped_regs + mmMC_FB_LOCATION);
+
+		/* Map External Memory at FB Base */
+		extmem_location.f.mc_ext_mem_start = W100_FB_BASE >> 8;
+		extmem_location.f.mc_ext_mem_top = (W100_FB_BASE+par->mach->mem->size) >> 8;
+		writel((u32) (extmem_location.val), remapped_regs + mmMC_EXT_MEM_LOCATION);
 
-static void w100_init_vga_rotation(u16 deg)
-{
-	switch(deg) {
-	case 0:
-		w100_set_vga_rotation_regs(0x02, 0x00DE1D66, 0x00800000, 0x000003c0);
-		break;
-	case 90:
-		w100_set_vga_rotation_regs(0x06, 0x00DE1D0e, 0x00895b00, 0x00000500);
-		break;
-	case 180:
-		w100_set_vga_rotation_regs(0x02, 0x00DE1D7e, 0x00895ffc, 0x000003c0);
-		break;
-	case 270:
-		w100_set_vga_rotation_regs(0x06, 0x00DE1D16, 0x008004fc, 0x00000500);
-		break;
-	default:
-		/* not-support */
-		break;
+		writel(0x00007800, remapped_regs + mmMC_BIST_CTRL);
+		writel(mem->ext_cntl, remapped_regs + mmMEM_EXT_CNTL);
+		writel(0x00200021, remapped_regs + mmMEM_SDRAM_MODE_REG);
+		udelay(100);
+		writel(0x80200021, remapped_regs + mmMEM_SDRAM_MODE_REG);
+		udelay(100);
+		writel(mem->sdram_mode_reg, remapped_regs + mmMEM_SDRAM_MODE_REG);
+		udelay(100);
+		writel(mem->ext_timing_cntl, remapped_regs + mmMEM_EXT_TIMING_CNTL);
+		writel(mem->io_cntl, remapped_regs + mmMEM_IO_CNTL);
+		if (bm_mem) {
+			writel(bm_mem->ext_mem_bw, remapped_regs + mmBM_EXT_MEM_BANDWIDTH);
+			writel(bm_mem->offset, remapped_regs + mmBM_OFFSET);
+			writel(bm_mem->ext_timing_ctl, remapped_regs + mmBM_MEM_EXT_TIMING_CNTL);
+			writel(bm_mem->ext_cntl, remapped_regs + mmBM_MEM_EXT_CNTL);
+			writel(bm_mem->mode_reg, remapped_regs + mmBM_MEM_MODE_REG);
+			writel(bm_mem->io_cntl, remapped_regs + mmBM_MEM_IO_CNTL);
+			writel(bm_mem->config, remapped_regs + mmBM_CONFIG);
+		}
 	}
 }
 
+static void w100_set_dispregs(struct w100fb_par *par)
+{
+	unsigned long rot=0, divider, offset=0;
+	union graphic_ctrl_u graphic_ctrl;
 
-static void w100_set_qvga_rotation_regs(unsigned long ctrl, unsigned long offset, unsigned long pitch)
-{
-	writel(ctrl, remapped_regs + mmGRAPHIC_CTRL);
-	writel(offset, remapped_regs + mmGRAPHIC_OFFSET);
-	writel(pitch, remapped_regs + mmGRAPHIC_PITCH);
-
-	/* Re-enable display updates */
-	writel(0x0000007b, remapped_regs + mmDISP_DB_BUF_CNTL);
-}
-
+	/* See if the mode has been rotated */
+	if (par->xres == par->mode->xres) {
+		if (par->flip) {
+			rot=3; /* 180 degree */
+			offset=(par->xres * par->yres) - 1;
+		} /* else 0 degree */
+		divider = par->mode->pixclk_divider;		
+	} else {
+		if (par->flip) {
+			rot=2; /* 270 degree */
+			offset=par->xres - 1;
+		} else {
+			rot=1; /* 90 degree */
+			offset=par->xres * (par->yres - 1);
+		}
+		divider = par->mode->pixclk_divider_rotated;
+	}
 
-static void w100_init_qvga_rotation(u16 deg)
-{
-	switch(deg) {
-	case 0:
-		w100_set_qvga_rotation_regs(0x00d41c06, 0x00800000, 0x000001e0);
-		break;
-	case 90:
-		w100_set_qvga_rotation_regs(0x00d41c0E, 0x00825580, 0x00000280);
-		break;
-	case 180:
-		w100_set_qvga_rotation_regs(0x00d41c1e, 0x008257fc, 0x000001e0);
-		break;
-	case 270:
-		w100_set_qvga_rotation_regs(0x00d41c16, 0x0080027c, 0x00000280);
-		break;
-	default:
-		/* not-support */
-		break;
+	graphic_ctrl.val = 0; /* w32xx doesn't like undefined bits */
+	switch (par->chip_id) {
+		case CHIP_ID_W100:
+			graphic_ctrl.f_w100.color_depth=6;
+			graphic_ctrl.f_w100.en_crtc=1;
+			graphic_ctrl.f_w100.en_graphic_req=1;
+			graphic_ctrl.f_w100.en_graphic_crtc=1;
+			graphic_ctrl.f_w100.lcd_pclk_on=1;
+			graphic_ctrl.f_w100.lcd_sclk_on=1;
+			graphic_ctrl.f_w100.low_power_on=0;
+			graphic_ctrl.f_w100.req_freq=0;
+			graphic_ctrl.f_w100.portrait_mode=rot;
+
+			/* Zaurus needs this */
+			switch(par->xres) {
+				case 240:
+				case 320:
+				default:
+					graphic_ctrl.f_w100.total_req_graphic=0xa0;
+					break;
+				case 480:
+				case 640:
+					switch(rot) {
+						case 0:  /* 0 */
+						case 3:  /* 180 */
+							graphic_ctrl.f_w100.low_power_on=1;
+							graphic_ctrl.f_w100.req_freq=5;
+						break;
+						case 1:  /* 90 */
+						case 2:  /* 270 */
+							graphic_ctrl.f_w100.req_freq=4;
+							break;
+						default:
+							break;	
+					}
+					graphic_ctrl.f_w100.total_req_graphic=0xf0;
+					break;
+			}
+			break;
+		case CHIP_ID_W3200:
+		case CHIP_ID_W3220:
+			graphic_ctrl.f_w32xx.color_depth=6;
+			graphic_ctrl.f_w32xx.en_crtc=1;
+			graphic_ctrl.f_w32xx.en_graphic_req=1;
+			graphic_ctrl.f_w32xx.en_graphic_crtc=1;
+			graphic_ctrl.f_w32xx.lcd_pclk_on=1;
+			graphic_ctrl.f_w32xx.lcd_sclk_on=1;
+			graphic_ctrl.f_w32xx.low_power_on=0;
+			graphic_ctrl.f_w32xx.req_freq=0;
+			graphic_ctrl.f_w32xx.total_req_graphic=par->mode->xres >> 1; /* panel xres, not mode */
+			graphic_ctrl.f_w32xx.portrait_mode=rot;
+			break;
 	}
+
+	/* Set the pixel clock source and divider */
+	w100_pwr_state.pclk_cntl.f.pclk_src_sel = par->mode->pixclk_src;
+	w100_pwr_state.pclk_cntl.f.pclk_post_div = divider;
+	writel((u32) (w100_pwr_state.pclk_cntl.val), remapped_regs + mmPCLK_CNTL);
+
+	writel(graphic_ctrl.val, remapped_regs + mmGRAPHIC_CTRL);
+	writel(W100_FB_BASE + ((offset * BITS_PER_PIXEL/8)&~0x03UL), remapped_regs + mmGRAPHIC_OFFSET);
+	writel((par->xres*BITS_PER_PIXEL/8), remapped_regs + mmGRAPHIC_PITCH);
 }
 
 
+/*
+ * Work out how long the sync pulse lasts
+ * Value is 1/(time in seconds)
+ */
+static void calc_hsync(struct w100fb_par *par)
+{
+	unsigned long hsync;
+	struct w100_mode *mode = par->mode;
+	union crtc_ss_u crtc_ss;
+
+	if (mode->pixclk_src == CLK_SRC_XTAL)
+		hsync=par->mach->xtal_freq;
+	else
+		hsync=((par->fastpll_mode && mode->fast_pll_freq) ? mode->fast_pll_freq : mode->pll_freq)*100000;
+
+	hsync /= (w100_pwr_state.pclk_cntl.f.pclk_post_div + 1);
+
+	crtc_ss.val = readl(remapped_regs + mmCRTC_SS);
+	if (crtc_ss.val)
+		par->hsync_len = hsync / (crtc_ss.f.ss_end-crtc_ss.f.ss_start);
+	else
+		par->hsync_len = 0;
+}
+
 static void w100_suspend(u32 mode)
 {
 	u32 val;
@@ -1387,30 +1377,28 @@
 	writel(0x00FF0000, remapped_regs + mmMC_PERF_MON_CNTL);
 
 	val = readl(remapped_regs + mmMEM_EXT_TIMING_CNTL);
-	val &= ~(0x00100000);	/* bit20=0 */
-	val |= 0xFF000000;	/* bit31:24=0xff */
+	val &= ~(0x00100000);  /* bit20=0 */
+	val |= 0xFF000000;     /* bit31:24=0xff */
 	writel(val, remapped_regs + mmMEM_EXT_TIMING_CNTL);
 
 	val = readl(remapped_regs + mmMEM_EXT_CNTL);
-	val &= ~(0x00040000);	/* bit18=0 */
-	val |= 0x00080000;	/* bit19=1 */
+	val &= ~(0x00040000);  /* bit18=0 */
+	val |= 0x00080000;     /* bit19=1 */
 	writel(val, remapped_regs + mmMEM_EXT_CNTL);
 
-	udelay(1);		/* wait 1us */
+	udelay(1);  /* wait 1us */
 
 	if (mode == W100_SUSPEND_EXTMEM) {
-
 		/* CKE: Tri-State */
 		val = readl(remapped_regs + mmMEM_EXT_CNTL);
-		val |= 0x40000000;	/* bit30=1 */
+		val |= 0x40000000;  /* bit30=1 */
 		writel(val, remapped_regs + mmMEM_EXT_CNTL);
 
 		/* CLK: Stop */
 		val = readl(remapped_regs + mmMEM_EXT_CNTL);
-		val &= ~(0x00000001);	/* bit0=0 */
+		val &= ~(0x00000001);  /* bit0=0 */
 		writel(val, remapped_regs + mmMEM_EXT_CNTL);
 	} else {
-
 		writel(0x00000000, remapped_regs + mmSCLK_CNTL);
 		writel(0x000000BF, remapped_regs + mmCLK_PIN_CNTL);
 		writel(0x00000015, remapped_regs + mmPWRMGT_CNTL);
@@ -1418,43 +1406,16 @@
 		udelay(5);
 
 		val = readl(remapped_regs + mmPLL_CNTL);
-		val |= 0x00000004;	/* bit2=1 */
+		val |= 0x00000004;  /* bit2=1 */
 		writel(val, remapped_regs + mmPLL_CNTL);
 		writel(0x0000001d, remapped_regs + mmPWRMGT_CNTL);
 	}
 }
 
-
-static void w100_resume(void)
-{
-	u32 temp32;
-
-	w100_hw_init();
-	w100_pwm_setup();
-
-	temp32 = readl(remapped_regs + mmDISP_DEBUG2);
-	temp32 &= 0xff7fffff;
-	temp32 |= 0x00800000;
-	writel(temp32, remapped_regs + mmDISP_DEBUG2);
-
-	if (current_par->lcdMode == LCD_MODE_480 || current_par->lcdMode == LCD_MODE_640) {
-		w100_init_sharp_lcd(LCD_SHARP_VGA);
-		if (current_par->lcdMode == LCD_MODE_640) {
-			w100_init_vga_rotation(current_par->rotation_flag ? 270 : 90);
-		}
-	} else {
-		w100_init_sharp_lcd(LCD_SHARP_QVGA);
-		if (current_par->lcdMode == LCD_MODE_320) {
-			w100_init_qvga_rotation(current_par->rotation_flag ? 270 : 90);
-		}
-	}
-}
-
-
 static void w100_vsync(void)
 {
 	u32 tmp;
-	int timeout = 30000; /* VSync timeout = 30[ms] > 16.8[ms] */
+	int timeout = 30000;  /* VSync timeout = 30[ms] > 16.8[ms] */
 
 	tmp = readl(remapped_regs + mmACTIVE_V_DISP);
 
@@ -1490,363 +1451,6 @@
 	writel(0x00000002, remapped_regs + mmGEN_INT_STATUS);
 }
 
-
-static void w100_InitExtMem(u32 mode)
-{
-	switch(mode) {
-	case LCD_SHARP_QVGA:
-		/* QVGA doesn't use external memory
-		   nothing to do, really. */
-		break;
-	case LCD_SHARP_VGA:
-		writel(0x00007800, remapped_regs + mmMC_BIST_CTRL);
-		writel(0x00040003, remapped_regs + mmMEM_EXT_CNTL);
-		writel(0x00200021, remapped_regs + mmMEM_SDRAM_MODE_REG);
-		udelay(100);
-		writel(0x80200021, remapped_regs + mmMEM_SDRAM_MODE_REG);
-		udelay(100);
-		writel(0x00650021, remapped_regs + mmMEM_SDRAM_MODE_REG);
-		udelay(100);
-		writel(0x10002a4a, remapped_regs + mmMEM_EXT_TIMING_CNTL);
-		writel(0x7ff87012, remapped_regs + mmMEM_IO_CNTL);
-		break;
-	default:
-		break;
-	}
-}
-
-
-#define RESCTL_ADRS     0x00
-#define PHACTRL_ADRS	0x01
-#define DUTYCTRL_ADRS	0x02
-#define POWERREG0_ADRS	0x03
-#define POWERREG1_ADRS	0x04
-#define GPOR3_ADRS		0x05
-#define PICTRL_ADRS     0x06
-#define POLCTRL_ADRS    0x07
-
-#define RESCTL_QVGA     0x01
-#define RESCTL_VGA      0x00
-
-#define POWER1_VW_ON	0x01	/* VW Supply FET ON */
-#define POWER1_GVSS_ON	0x02	/* GVSS(-8V) Power Supply ON */
-#define POWER1_VDD_ON	0x04	/* VDD(8V),SVSS(-4V) Power Supply ON */
-
-#define POWER1_VW_OFF	0x00	/* VW Supply FET OFF */
-#define POWER1_GVSS_OFF	0x00	/* GVSS(-8V) Power Supply OFF */
-#define POWER1_VDD_OFF	0x00	/* VDD(8V),SVSS(-4V) Power Supply OFF */
-
-#define POWER0_COM_DCLK	0x01	/* COM Voltage DC Bias DAC Serial Data Clock */
-#define POWER0_COM_DOUT	0x02	/* COM Voltage DC Bias DAC Serial Data Out */
-#define POWER0_DAC_ON	0x04	/* DAC Power Supply ON */
-#define POWER0_COM_ON	0x08	/* COM Powewr Supply ON */
-#define POWER0_VCC5_ON	0x10	/* VCC5 Power Supply ON */
-
-#define POWER0_DAC_OFF	0x00	/* DAC Power Supply OFF */
-#define POWER0_COM_OFF	0x00	/* COM Powewr Supply OFF */
-#define POWER0_VCC5_OFF	0x00	/* VCC5 Power Supply OFF */
-
-#define PICTRL_INIT_STATE	0x01
-#define PICTRL_INIOFF		0x02
-#define PICTRL_POWER_DOWN	0x04
-#define PICTRL_COM_SIGNAL_OFF	0x08
-#define PICTRL_DAC_SIGNAL_OFF	0x10
-
-#define PICTRL_POWER_ACTIVE	(0)
-
-#define POLCTRL_SYNC_POL_FALL	0x01
-#define POLCTRL_EN_POL_FALL	0x02
-#define POLCTRL_DATA_POL_FALL	0x04
-#define POLCTRL_SYNC_ACT_H	0x08
-#define POLCTRL_EN_ACT_L	0x10
-
-#define POLCTRL_SYNC_POL_RISE	0x00
-#define POLCTRL_EN_POL_RISE	0x00
-#define POLCTRL_DATA_POL_RISE	0x00
-#define POLCTRL_SYNC_ACT_L	0x00
-#define POLCTRL_EN_ACT_H	0x00
-
-#define PHACTRL_PHASE_MANUAL	0x01
-
-#define PHAD_QVGA_DEFAULT_VAL (9)
-#define COMADJ_DEFAULT        (125)
-
-static void lcdtg_ssp_send(u8 adrs, u8 data)
-{
-	w100fb_ssp_send(adrs,data);
-}
-
-/*
- * This is only a psuedo I2C interface. We can't use the standard kernel
- * routines as the interface is write only. We just assume the data is acked...
- */
-static void lcdtg_ssp_i2c_send(u8 data)
-{
-	lcdtg_ssp_send(POWERREG0_ADRS, data);
-	udelay(10);
-}
-
-static void lcdtg_i2c_send_bit(u8 data)
-{
-	lcdtg_ssp_i2c_send(data);
-	lcdtg_ssp_i2c_send(data | POWER0_COM_DCLK);
-	lcdtg_ssp_i2c_send(data);
-}
-
-static void lcdtg_i2c_send_start(u8 base)
-{
-	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK | POWER0_COM_DOUT);
-	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK);
-	lcdtg_ssp_i2c_send(base);
-}
-
-static void lcdtg_i2c_send_stop(u8 base)
-{
-	lcdtg_ssp_i2c_send(base);
-	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK);
-	lcdtg_ssp_i2c_send(base | POWER0_COM_DCLK | POWER0_COM_DOUT);
-}
-
-static void lcdtg_i2c_send_byte(u8 base, u8 data)
-{
-	int i;
-	for (i = 0; i < 8; i++) {
-		if (data & 0x80)
-			lcdtg_i2c_send_bit(base | POWER0_COM_DOUT);
-		else
-			lcdtg_i2c_send_bit(base);
-		data <<= 1;
-	}
-}
-
-static void lcdtg_i2c_wait_ack(u8 base)
-{
-	lcdtg_i2c_send_bit(base);
-}
-
-static void lcdtg_set_common_voltage(u8 base_data, u8 data)
-{
-	/* Set Common Voltage to M62332FP via I2C */
-	lcdtg_i2c_send_start(base_data);
-	lcdtg_i2c_send_byte(base_data, 0x9c);
-	lcdtg_i2c_wait_ack(base_data);
-	lcdtg_i2c_send_byte(base_data, 0x00);
-	lcdtg_i2c_wait_ack(base_data);
-	lcdtg_i2c_send_byte(base_data, data);
-	lcdtg_i2c_wait_ack(base_data);
-	lcdtg_i2c_send_stop(base_data);
-}
-
-static struct lcdtg_register_setting {
-	u8 adrs;
-	u8 data;
-	u32 wait;
-} lcdtg_power_on_table[] = {
-
-    /* Initialize Internal Logic & Port */
-    { PICTRL_ADRS,
-      PICTRL_POWER_DOWN | PICTRL_INIOFF | PICTRL_INIT_STATE |
-      PICTRL_COM_SIGNAL_OFF | PICTRL_DAC_SIGNAL_OFF,
-      0 },
-
-    { POWERREG0_ADRS,
-      POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_OFF | POWER0_COM_OFF |
-      POWER0_VCC5_OFF,
-      0 },
-
-    { POWERREG1_ADRS,
-      POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_OFF,
-      0 },
-
-    /* VDD(+8V),SVSS(-4V) ON */
-    { POWERREG1_ADRS,
-      POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_ON /* VDD ON */,
-      3000 },
-
-    /* DAC ON */
-    { POWERREG0_ADRS,
-      POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON /* DAC ON */ |
-      POWER0_COM_OFF | POWER0_VCC5_OFF,
-      0 },
-
-    /* INIB = H, INI = L  */
-    { PICTRL_ADRS,
-      /* PICTL[0] = H , PICTL[1] = PICTL[2] = PICTL[4] = L */
-      PICTRL_INIT_STATE | PICTRL_COM_SIGNAL_OFF,
-      0 },
-
-    /* Set Common Voltage */
-    { 0xfe, 0, 0 },
-
-    /* VCC5 ON */
-    { POWERREG0_ADRS,
-      POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON /* DAC ON */ |
-      POWER0_COM_OFF | POWER0_VCC5_ON /* VCC5 ON */,
-      0 },
-
-    /* GVSS(-8V) ON */
-    { POWERREG1_ADRS,
-      POWER1_VW_OFF | POWER1_GVSS_ON /* GVSS ON */ |
-      POWER1_VDD_ON /* VDD ON */,
-      2000 },
-
-    /* COM SIGNAL ON (PICTL[3] = L) */
-    { PICTRL_ADRS,
-      PICTRL_INIT_STATE,
-      0 },
-
-    /* COM ON */
-    { POWERREG0_ADRS,
-      POWER0_COM_DCLK | POWER0_COM_DOUT | POWER0_DAC_ON /* DAC ON */ |
-      POWER0_COM_ON /* COM ON */ | POWER0_VCC5_ON /* VCC5_ON */,
-      0 },
-
-    /* VW ON */
-    { POWERREG1_ADRS,
-      POWER1_VW_ON /* VW ON */ | POWER1_GVSS_ON /* GVSS ON */ |
-      POWER1_VDD_ON /* VDD ON */,
-      0 /* Wait 100ms */ },
-
-    /* Signals output enable */
-    { PICTRL_ADRS,
-      0 /* Signals output enable */,
-      0 },
-
-    { PHACTRL_ADRS,
-      PHACTRL_PHASE_MANUAL,
-      0 },
-
-    /* Initialize for Input Signals from ATI */
-    { POLCTRL_ADRS,
-      POLCTRL_SYNC_POL_RISE | POLCTRL_EN_POL_RISE | POLCTRL_DATA_POL_RISE |
-      POLCTRL_SYNC_ACT_L | POLCTRL_EN_ACT_H,
-      1000 /*100000*/ /* Wait 100ms */ },
-
-    /* end mark */
-    { 0xff, 0, 0 }
-};
-
-static void lcdtg_resume(void)
-{
-	if (current_par->lcdMode == LCD_MODE_480 || current_par->lcdMode == LCD_MODE_640) {
-		lcdtg_hw_init(LCD_SHARP_VGA);
-	} else {
-		lcdtg_hw_init(LCD_SHARP_QVGA);
-	}
-}
-
-static void lcdtg_suspend(void)
-{
-	int i;
-
-	for (i = 0; i < (current_par->xres * current_par->yres); i++) {
-		writew(0xffff, remapped_fbuf + (2*i));
-	}
-
-	/* 60Hz x 2 frame = 16.7msec x 2 = 33.4 msec */
-	mdelay(34);
-
-	/* (1)VW OFF */
-	lcdtg_ssp_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_ON | POWER1_VDD_ON);
-
-	/* (2)COM OFF */
-	lcdtg_ssp_send(PICTRL_ADRS, PICTRL_COM_SIGNAL_OFF);
-	lcdtg_ssp_send(POWERREG0_ADRS, POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_ON);
-
-	/* (3)Set Common Voltage Bias 0V */
-	lcdtg_set_common_voltage(POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_ON, 0);
-
-	/* (4)GVSS OFF */
-	lcdtg_ssp_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_ON);
-
-	/* (5)VCC5 OFF */
-	lcdtg_ssp_send(POWERREG0_ADRS, POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_OFF);
-
-	/* (6)Set PDWN, INIOFF, DACOFF */
-	lcdtg_ssp_send(PICTRL_ADRS, PICTRL_INIOFF | PICTRL_DAC_SIGNAL_OFF |
-			PICTRL_POWER_DOWN | PICTRL_COM_SIGNAL_OFF);
-
-	/* (7)DAC OFF */
-	lcdtg_ssp_send(POWERREG0_ADRS, POWER0_DAC_OFF | POWER0_COM_OFF | POWER0_VCC5_OFF);
-
-	/* (8)VDD OFF */
-	lcdtg_ssp_send(POWERREG1_ADRS, POWER1_VW_OFF | POWER1_GVSS_OFF | POWER1_VDD_OFF);
-
-}
-
-static void lcdtg_set_phadadj(u32 mode)
-{
-	int adj;
-
-	if (mode == LCD_SHARP_VGA) {
-		/* Setting for VGA */
-		adj = current_par->phadadj;
-		if (adj < 0) {
-			adj = PHACTRL_PHASE_MANUAL;
-		} else {
-			adj = ((adj & 0x0f) << 1) | PHACTRL_PHASE_MANUAL;
-		}
-	} else {
-		/* Setting for QVGA */
-		adj = (PHAD_QVGA_DEFAULT_VAL << 1) | PHACTRL_PHASE_MANUAL;
-	}
-	lcdtg_ssp_send(PHACTRL_ADRS, adj);
-}
-
-static void lcdtg_hw_init(u32 mode)
-{
-	int i;
-	int comadj;
-
-	i = 0;
-	while(lcdtg_power_on_table[i].adrs != 0xff) {
-		if (lcdtg_power_on_table[i].adrs == 0xfe) {
-			/* Set Common Voltage */
-			comadj = current_par->comadj;
-			if (comadj < 0) {
-				comadj = COMADJ_DEFAULT;
-			}
-			lcdtg_set_common_voltage((POWER0_DAC_ON | POWER0_COM_OFF | POWER0_VCC5_OFF), comadj);
-		} else if (lcdtg_power_on_table[i].adrs == PHACTRL_ADRS) {
-			/* Set Phase Adjuct */
-			lcdtg_set_phadadj(mode);
-		} else {
-			/* Other */
-			lcdtg_ssp_send(lcdtg_power_on_table[i].adrs, lcdtg_power_on_table[i].data);
-		}
-		if (lcdtg_power_on_table[i].wait != 0)
-			udelay(lcdtg_power_on_table[i].wait);
-		i++;
-	}
-
-	switch(mode) {
-	case LCD_SHARP_QVGA:
-		/* Set Lcd Resolution (QVGA) */
-		lcdtg_ssp_send(RESCTL_ADRS, RESCTL_QVGA);
-		break;
-	case LCD_SHARP_VGA:
-		/* Set Lcd Resolution (VGA) */
-		lcdtg_ssp_send(RESCTL_ADRS, RESCTL_VGA);
-		break;
-	default:
-		break;
-	}
-}
-
-static void lcdtg_lcd_change(u32 mode)
-{
-	/* Set Phase Adjuct */
-	lcdtg_set_phadadj(mode);
-
-	if (mode == LCD_SHARP_VGA)
-		/* Set Lcd Resolution (VGA) */
-		lcdtg_ssp_send(RESCTL_ADRS, RESCTL_VGA);
-	else if (mode == LCD_SHARP_QVGA)
-		/* Set Lcd Resolution (QVGA) */
-		lcdtg_ssp_send(RESCTL_ADRS, RESCTL_QVGA);
-}
-
-
 static struct device_driver w100fb_driver = {
 	.name		= "w100fb",
 	.bus		= &platform_bus_type,
@@ -1870,4 +1474,4 @@
 module_exit(w100fb_cleanup);
 
 MODULE_DESCRIPTION("ATI Imageon w100 framebuffer driver");
-MODULE_LICENSE("GPLv2");
+MODULE_LICENSE("GPL");
Index: linux-2.6.12/drivers/video/w100fb.h
===================================================================
--- linux-2.6.12.orig/drivers/video/w100fb.h	2005-08-05 17:31:39.000000000 +0100
+++ linux-2.6.12/drivers/video/w100fb.h	2005-08-05 17:31:44.000000000 +0100
@@ -5,9 +5,12 @@
  *
  * Copyright (C) 2002, ATI Corp.
  * Copyright (C) 2004-2005 Richard Purdie
+ * Copyright (c) 2005 Ian Molton <spyro@f2s.com>
  *
  * Modified to work with 2.6 by Richard Purdie <rpurdie@rpsys.net>
  *
+ * w32xx support by Ian Molton
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -19,7 +22,7 @@
 
 /* Block CIF Start: */
 #define mmCHIP_ID           0x0000
-#define mmREVISION_ID		0x0004
+#define mmREVISION_ID       0x0004
 #define mmWRAP_BUF_A        0x0008
 #define mmWRAP_BUF_B        0x000C
 #define mmWRAP_TOP_DIR      0x0010
@@ -88,7 +91,7 @@
 #define mmDISP_DEBUG        0x04D4
 #define mmDISP_DB_BUF_CNTL  0x04D8
 #define mmDISP_CRC_SIG      0x04DC
-#define mmCRTC_DEFAULT_COUNT 	0x04E0
+#define mmCRTC_DEFAULT_COUNT    0x04E0
 #define mmLCD_BACKGROUND_COLOR  0x04E4
 #define mmCRTC_PS2          0x04E8
 #define mmCRTC_PS2_VPOS     0x04EC
@@ -119,17 +122,17 @@
 /* Block DISPLAY End: */
 
 /* Block GFX Start: */
-#define mmBRUSH_OFFSET      0x108C
-#define mmBRUSH_Y_X         0x1074
-#define mmDEFAULT_PITCH_OFFSET		0x10A0
-#define mmDEFAULT_SC_BOTTOM_RIGHT	0x10A8
-#define mmDEFAULT2_SC_BOTTOM_RIGHT	0x10AC
-#define mmGLOBAL_ALPHA      0x1210
-#define mmFILTER_COEF       0x1214
-#define mmMVC_CNTL_START    0x11E0
-#define mmE2_ARITHMETIC_CNTL	0x1220
-#define mmENG_CNTL          0x13E8
-#define mmENG_PERF_CNT      0x13F0
+#define mmBRUSH_OFFSET        0x108C
+#define mmBRUSH_Y_X           0x1074
+#define mmDEFAULT_PITCH_OFFSET      0x10A0
+#define mmDEFAULT_SC_BOTTOM_RIGHT   0x10A8
+#define mmDEFAULT2_SC_BOTTOM_RIGHT  0x10AC
+#define mmGLOBAL_ALPHA        0x1210
+#define mmFILTER_COEF         0x1214
+#define mmMVC_CNTL_START      0x11E0
+#define mmE2_ARITHMETIC_CNTL  0x1220
+#define mmENG_CNTL            0x13E8
+#define mmENG_PERF_CNT        0x13F0
 /* Block GFX End: */
 
 /* Block IDCT Start: */
@@ -141,22 +144,38 @@
 /* Block IDCT End: */
 
 /* Block MC Start: */
-#define mmMEM_CNTL          0x0180
-#define mmMEM_ARB           0x0184
-#define mmMC_FB_LOCATION    0x0188
-#define mmMEM_EXT_CNTL      0x018C
-#define mmMC_EXT_MEM_LOCATION   0x0190
-#define mmMEM_EXT_TIMING_CNTL   0x0194
-#define mmMEM_SDRAM_MODE_REG	0x0198
-#define mmMEM_IO_CNTL       0x019C
-#define mmMC_DEBUG          0x01A0
-#define mmMC_BIST_CTRL      0x01A4
-#define mmMC_BIST_COLLAR_READ  	0x01A8
-#define mmTC_MISMATCH       0x01AC
-#define mmMC_PERF_MON_CNTL  0x01B0
-#define mmMC_PERF_COUNTERS  0x01B4
+#define mmMEM_CNTL             0x0180
+#define mmMEM_ARB              0x0184
+#define mmMC_FB_LOCATION       0x0188
+#define mmMEM_EXT_CNTL         0x018C
+#define mmMC_EXT_MEM_LOCATION  0x0190
+#define mmMEM_EXT_TIMING_CNTL  0x0194
+#define mmMEM_SDRAM_MODE_REG   0x0198
+#define mmMEM_IO_CNTL          0x019C
+#define mmMC_DEBUG             0x01A0
+#define mmMC_BIST_CTRL         0x01A4
+#define mmMC_BIST_COLLAR_READ  0x01A8
+#define mmTC_MISMATCH          0x01AC
+#define mmMC_PERF_MON_CNTL     0x01B0
+#define mmMC_PERF_COUNTERS     0x01B4
 /* Block MC End: */
 
+/* Block BM Start: */
+#define mmBM_EXT_MEM_BANDWIDTH    0x0A00
+#define mmBM_OFFSET               0x0A04
+#define mmBM_MEM_EXT_TIMING_CNTL  0x0A08
+#define mmBM_MEM_EXT_CNTL         0x0A0C
+#define mmBM_MEM_MODE_REG         0x0A10
+#define mmBM_MEM_IO_CNTL          0x0A18
+#define mmBM_CONFIG               0x0A1C
+#define mmBM_STATUS               0x0A20
+#define mmBM_DEBUG                0x0A24
+#define mmBM_PERF_MON_CNTL        0x0A28
+#define mmBM_PERF_COUNTERS        0x0A2C
+#define mmBM_PERF2_MON_CNTL       0x0A30
+#define mmBM_PERF2_COUNTERS       0x0A34
+/* Block BM End: */
+
 /* Block RBBM Start: */
 #define mmWAIT_UNTIL        0x1400
 #define mmISYNC_CNTL        0x1404
@@ -176,439 +195,575 @@
 /* Block CG End: */
 
 /* default value definitions */
-#define defWRAP_TOP_DIR     0x00000000
-#define defWRAP_START_DIR	0x00000000
-#define defCFGREG_BASE      0x00000000
-#define defCIF_IO           0x000C0902
-#define defINTF_CNTL        0x00000011
-#define defCPU_DEFAULTS     0x00000006
-#define defHW_INT           0x00000000
-#define defMC_EXT_MEM_LOCATION            0x07ff0000
-#define defTC_MISMATCH      0x00000000
+#define defWRAP_TOP_DIR        0x00000000
+#define defWRAP_START_DIR      0x00000000
+#define defCFGREG_BASE         0x00000000
+#define defCIF_IO              0x000C0902
+#define defINTF_CNTL           0x00000011
+#define defCPU_DEFAULTS        0x00000006
+#define defHW_INT              0x00000000
+#define defMC_EXT_MEM_LOCATION 0x07ff0000
+#define defTC_MISMATCH         0x00000000
 
 #define W100_CFG_BASE          0x0
 #define W100_CFG_LEN           0x10
 #define W100_REG_BASE          0x10000
 #define W100_REG_LEN           0x2000
 #define MEM_INT_BASE_VALUE     0x100000
-#define MEM_INT_TOP_VALUE_W100 0x15ffff
 #define MEM_EXT_BASE_VALUE     0x800000
-#define MEM_EXT_TOP_VALUE      0x9fffff
+#define MEM_INT_SIZE           0x05ffff
+#define MEM_WINDOW_BASE        0x100000
+#define MEM_WINDOW_SIZE        0xf00000
+
 #define WRAP_BUF_BASE_VALUE    0x80000
 #define WRAP_BUF_TOP_VALUE     0xbffff
 
+#define CHIP_ID_W100           0x57411002
+#define CHIP_ID_W3200          0x56441002
+#define CHIP_ID_W3220          0x57441002
 
-/* data structure definitions */
+/* Register structure definitions */
 
 struct wrap_top_dir_t {
-     unsigned long top_addr         : 23;
-     unsigned long    				: 9;
+	unsigned long top_addr  : 23;
+	unsigned long           : 9;
 } __attribute__((packed));
 
 union wrap_top_dir_u {
-     unsigned long val : 32;
-     struct wrap_top_dir_t f;
+	unsigned long val : 32;
+	struct wrap_top_dir_t f;
 } __attribute__((packed));
 
 struct wrap_start_dir_t {
-     unsigned long start_addr       : 23;
-     unsigned long    				: 9;
+	unsigned long start_addr : 23;
+	unsigned long            : 9;
 } __attribute__((packed));
 
 union wrap_start_dir_u {
-     unsigned long val : 32;
-     struct wrap_start_dir_t f;
+	unsigned long val : 32;
+	struct wrap_start_dir_t f;
 } __attribute__((packed));
 
 struct cif_cntl_t {
-     unsigned long swap_reg         		: 2;
-     unsigned long swap_fbuf_1      		: 2;
-     unsigned long swap_fbuf_2      		: 2;
-     unsigned long swap_fbuf_3      		: 2;
-     unsigned long pmi_int_disable  		: 1;
-     unsigned long pmi_schmen_disable       : 1;
-     unsigned long intb_oe          		: 1;
-     unsigned long en_wait_to_compensate_dq_prop_dly : 1;
-     unsigned long compensate_wait_rd_size  : 2;
-     unsigned long wait_asserted_timeout_val      : 2;
-     unsigned long wait_masked_val  		: 2;
-     unsigned long en_wait_timeout  		: 1;
-     unsigned long en_one_clk_setup_before_wait   : 1;
-     unsigned long interrupt_active_high    : 1;
-     unsigned long en_overwrite_straps      : 1;
-     unsigned long strap_wait_active_hi     : 1;
-     unsigned long lat_busy_count   		: 2;
-     unsigned long lat_rd_pm4_sclk_busy     : 1;
-     unsigned long dis_system_bits  		: 1;
-     unsigned long dis_mr           		: 1;
-     unsigned long cif_spare_1      		: 4;
+	unsigned long swap_reg                 : 2;
+	unsigned long swap_fbuf_1              : 2;
+	unsigned long swap_fbuf_2              : 2;
+	unsigned long swap_fbuf_3              : 2;
+	unsigned long pmi_int_disable          : 1;
+	unsigned long pmi_schmen_disable       : 1;
+	unsigned long intb_oe                  : 1;
+	unsigned long en_wait_to_compensate_dq_prop_dly  : 1;
+	unsigned long compensate_wait_rd_size  : 2;
+	unsigned long wait_asserted_timeout_val  : 2;
+	unsigned long wait_masked_val          : 2;
+	unsigned long en_wait_timeout          : 1;
+	unsigned long en_one_clk_setup_before_wait  : 1;
+	unsigned long interrupt_active_high    : 1;
+	unsigned long en_overwrite_straps      : 1;
+	unsigned long strap_wait_active_hi     : 1;
+	unsigned long lat_busy_count           : 2;
+	unsigned long lat_rd_pm4_sclk_busy     : 1;
+	unsigned long dis_system_bits          : 1;
+	unsigned long dis_mr                   : 1;
+	unsigned long cif_spare_1              : 4;
 } __attribute__((packed));
 
 union cif_cntl_u {
-     unsigned long val : 32;
-     struct cif_cntl_t f;
+	unsigned long val : 32;
+	struct cif_cntl_t f;
 } __attribute__((packed));
 
 struct cfgreg_base_t {
-     unsigned long cfgreg_base      : 24;
-     unsigned long    				: 8;
+	unsigned long cfgreg_base  : 24;
+	unsigned long              : 8;
 } __attribute__((packed));
 
 union cfgreg_base_u {
-     unsigned long val : 32;
-     struct cfgreg_base_t f;
+	unsigned long val : 32;
+	struct cfgreg_base_t f;
 } __attribute__((packed));
 
 struct cif_io_t {
-     unsigned long dq_srp           : 1;
-     unsigned long dq_srn           : 1;
-     unsigned long dq_sp            : 4;
-     unsigned long dq_sn            : 4;
-     unsigned long waitb_srp        : 1;
-     unsigned long waitb_srn        : 1;
-     unsigned long waitb_sp         : 4;
-     unsigned long waitb_sn         : 4;
-     unsigned long intb_srp         : 1;
-     unsigned long intb_srn         : 1;
-     unsigned long intb_sp          : 4;
-     unsigned long intb_sn          : 4;
-     unsigned long    				: 2;
+	unsigned long dq_srp     : 1;
+	unsigned long dq_srn     : 1;
+	unsigned long dq_sp      : 4;
+	unsigned long dq_sn      : 4;
+	unsigned long waitb_srp  : 1;
+	unsigned long waitb_srn  : 1;
+	unsigned long waitb_sp   : 4;
+	unsigned long waitb_sn   : 4;
+	unsigned long intb_srp   : 1;
+	unsigned long intb_srn   : 1;
+	unsigned long intb_sp    : 4;
+	unsigned long intb_sn    : 4;
+	unsigned long            : 2;
 } __attribute__((packed));
 
 union cif_io_u {
-     unsigned long val : 32;
-     struct cif_io_t f;
+	unsigned long val : 32;
+	struct cif_io_t f;
 } __attribute__((packed));
 
 struct cif_read_dbg_t {
-     unsigned long unpacker_pre_fetch_trig_gen  : 2;
-     unsigned long dly_second_rd_fetch_trig     : 1;
-     unsigned long rst_rd_burst_id  			: 1;
-     unsigned long dis_rd_burst_id  			: 1;
-     unsigned long en_block_rd_when_packer_is_not_emp : 1;
-     unsigned long dis_pre_fetch_cntl_sm        : 1;
-     unsigned long rbbm_chrncy_dis  			: 1;
-     unsigned long rbbm_rd_after_wr_lat         : 2;
-     unsigned long dis_be_during_rd 			: 1;
-     unsigned long one_clk_invalidate_pulse     : 1;
-     unsigned long dis_chnl_priority			: 1;
-     unsigned long rst_read_path_a_pls          : 1;
-     unsigned long rst_read_path_b_pls          : 1;
-     unsigned long dis_reg_rd_fetch_trig        : 1;
-     unsigned long dis_rd_fetch_trig_from_ind_addr : 1;
-     unsigned long dis_rd_same_byte_to_trig_fetch : 1;
-     unsigned long dis_dir_wrap     			: 1;
-     unsigned long dis_ring_buf_to_force_dec    : 1;
-     unsigned long dis_addr_comp_in_16bit       : 1;
-     unsigned long clr_w            			: 1;
-     unsigned long err_rd_tag_is_3  			: 1;
-     unsigned long err_load_when_ful_a          : 1;
-     unsigned long err_load_when_ful_b          : 1;
-     unsigned long    							: 7;
+	unsigned long unpacker_pre_fetch_trig_gen  : 2;
+	unsigned long dly_second_rd_fetch_trig     : 1;
+	unsigned long rst_rd_burst_id              : 1;
+	unsigned long dis_rd_burst_id              : 1;
+	unsigned long en_block_rd_when_packer_is_not_emp : 1;
+	unsigned long dis_pre_fetch_cntl_sm        : 1;
+	unsigned long rbbm_chrncy_dis              : 1;
+	unsigned long rbbm_rd_after_wr_lat         : 2;
+	unsigned long dis_be_during_rd             : 1;
+	unsigned long one_clk_invalidate_pulse     : 1;
+	unsigned long dis_chnl_priority            : 1;
+	unsigned long rst_read_path_a_pls          : 1;
+	unsigned long rst_read_path_b_pls          : 1;
+	unsigned long dis_reg_rd_fetch_trig        : 1;
+	unsigned long dis_rd_fetch_trig_from_ind_addr : 1;
+	unsigned long dis_rd_same_byte_to_trig_fetch : 1;
+	unsigned long dis_dir_wrap                 : 1;
+	unsigned long dis_ring_buf_to_force_dec    : 1;
+	unsigned long dis_addr_comp_in_16bit       : 1;
+	unsigned long clr_w                        : 1;
+	unsigned long err_rd_tag_is_3              : 1;
+	unsigned long err_load_when_ful_a          : 1;
+	unsigned long err_load_when_ful_b          : 1;
+	unsigned long                              : 7;
 } __attribute__((packed));
 
 union cif_read_dbg_u {
-     unsigned long val : 32;
-     struct cif_read_dbg_t f;
+	unsigned long val : 32;
+	struct cif_read_dbg_t f;
 } __attribute__((packed));
 
 struct cif_write_dbg_t {
-     unsigned long packer_timeout_count           : 2;
-     unsigned long en_upper_load_cond             : 1;
-     unsigned long en_chnl_change_cond            : 1;
-     unsigned long dis_addr_comp_cond             : 1;
-     unsigned long dis_load_same_byte_addr_cond   : 1;
-     unsigned long dis_timeout_cond 			  : 1;
-     unsigned long dis_timeout_during_rbbm        : 1;
-     unsigned long dis_packer_ful_during_rbbm_timeout : 1;
-     unsigned long en_dword_split_to_rbbm         : 1;
-     unsigned long en_dummy_val     			  : 1;
-     unsigned long dummy_val_sel    			  : 1;
-     unsigned long mask_pm4_wrptr_dec             : 1;
-     unsigned long dis_mc_clean_cond			  : 1;
-     unsigned long err_two_reqi_during_ful        : 1;
-     unsigned long err_reqi_during_idle_clk       : 1;
-     unsigned long err_global       			  : 1;
-     unsigned long en_wr_buf_dbg_load             : 1;
-     unsigned long en_wr_buf_dbg_path             : 1;
-     unsigned long sel_wr_buf_byte  			  : 3;
-     unsigned long dis_rd_flush_wr  			  : 1;
-     unsigned long dis_packer_ful_cond            : 1;
-     unsigned long dis_invalidate_by_ops_chnl     : 1;
-     unsigned long en_halt_when_reqi_err          : 1;
-     unsigned long cif_spare_2      			  : 5;
-     unsigned long    							  : 1;
+	unsigned long packer_timeout_count          : 2;
+	unsigned long en_upper_load_cond            : 1;
+	unsigned long en_chnl_change_cond           : 1;
+	unsigned long dis_addr_comp_cond            : 1;
+	unsigned long dis_load_same_byte_addr_cond  : 1;
+	unsigned long dis_timeout_cond              : 1;
+	unsigned long dis_timeout_during_rbbm       : 1;
+	unsigned long dis_packer_ful_during_rbbm_timeout : 1;
+	unsigned long en_dword_split_to_rbbm        : 1;
+	unsigned long en_dummy_val                  : 1;
+	unsigned long dummy_val_sel                 : 1;
+	unsigned long mask_pm4_wrptr_dec            : 1;
+	unsigned long dis_mc_clean_cond             : 1;
+	unsigned long err_two_reqi_during_ful       : 1;
+	unsigned long err_reqi_during_idle_clk      : 1;
+	unsigned long err_global                    : 1;
+	unsigned long en_wr_buf_dbg_load            : 1;
+	unsigned long en_wr_buf_dbg_path            : 1;
+	unsigned long sel_wr_buf_byte               : 3;
+	unsigned long dis_rd_flush_wr               : 1;
+	unsigned long dis_packer_ful_cond           : 1;
+	unsigned long dis_invalidate_by_ops_chnl    : 1;
+	unsigned long en_halt_when_reqi_err         : 1;
+	unsigned long cif_spare_2                   : 5;
+	unsigned long                               : 1;
 } __attribute__((packed));
 
 union cif_write_dbg_u {
-     unsigned long val : 32;
-     struct cif_write_dbg_t f;
+	unsigned long val : 32;
+	struct cif_write_dbg_t f;
 } __attribute__((packed));
 
 
 struct intf_cntl_t {
-     unsigned char ad_inc_a            : 1;
-     unsigned char ring_buf_a          : 1;
-     unsigned char rd_fetch_trigger_a  : 1;
-     unsigned char rd_data_rdy_a       : 1;
-     unsigned char ad_inc_b            : 1;
-     unsigned char ring_buf_b          : 1;
-     unsigned char rd_fetch_trigger_b  : 1;
-     unsigned char rd_data_rdy_b       : 1;
+	unsigned char ad_inc_a            : 1;
+	unsigned char ring_buf_a          : 1;
+	unsigned char rd_fetch_trigger_a  : 1;
+	unsigned char rd_data_rdy_a       : 1;
+	unsigned char ad_inc_b            : 1;
+	unsigned char ring_buf_b          : 1;
+	unsigned char rd_fetch_trigger_b  : 1;
+	unsigned char rd_data_rdy_b       : 1;
 } __attribute__((packed));
 
 union intf_cntl_u {
-     unsigned char val : 8;
-     struct intf_cntl_t f;
+	unsigned char val : 8;
+	struct intf_cntl_t f;
 } __attribute__((packed));
 
 struct cpu_defaults_t {
-     unsigned char unpack_rd_data   : 1;
-     unsigned char access_ind_addr_a: 1;
-     unsigned char access_ind_addr_b: 1;
-     unsigned char access_scratch_reg             : 1;
-     unsigned char pack_wr_data     : 1;
-     unsigned char transition_size  : 1;
-     unsigned char en_read_buf_mode : 1;
-     unsigned char rd_fetch_scratch : 1;
+	unsigned char unpack_rd_data     : 1;
+	unsigned char access_ind_addr_a  : 1;
+	unsigned char access_ind_addr_b  : 1;
+	unsigned char access_scratch_reg : 1;
+	unsigned char pack_wr_data       : 1;
+	unsigned char transition_size    : 1;
+	unsigned char en_read_buf_mode   : 1;
+	unsigned char rd_fetch_scratch   : 1;
 } __attribute__((packed));
 
 union cpu_defaults_u {
-     unsigned char val : 8;
-     struct cpu_defaults_t f;
+	unsigned char val : 8;
+	struct cpu_defaults_t f;
+} __attribute__((packed));
+
+struct crtc_total_t {
+	unsigned long crtc_h_total : 10;
+	unsigned long              : 6;
+	unsigned long crtc_v_total : 10;
+	unsigned long              : 6;
+} __attribute__((packed));
+
+union crtc_total_u {
+	unsigned long val : 32;
+	struct crtc_total_t f;
+} __attribute__((packed));
+
+struct crtc_ss_t {
+	unsigned long ss_start    : 10;
+	unsigned long             : 6;
+	unsigned long ss_end      : 10;
+	unsigned long             : 2;
+	unsigned long ss_align    : 1;
+	unsigned long ss_pol      : 1;
+	unsigned long ss_run_mode : 1;
+	unsigned long ss_en       : 1;
+} __attribute__((packed));
+
+union crtc_ss_u {
+	unsigned long val : 32;
+	struct crtc_ss_t f;
+} __attribute__((packed));
+
+struct active_h_disp_t {
+	unsigned long active_h_start  : 10;
+	unsigned long                 : 6;
+	unsigned long active_h_end    : 10;
+	unsigned long                 : 6;
+} __attribute__((packed));
+
+union active_h_disp_u {
+	unsigned long val : 32;
+	struct active_h_disp_t f;
+} __attribute__((packed));
+
+struct active_v_disp_t {
+	unsigned long active_v_start  : 10;
+	unsigned long                 : 6;
+	unsigned long active_v_end    : 10;
+	unsigned long                 : 6;
+} __attribute__((packed));
+
+union active_v_disp_u {
+	unsigned long val : 32;
+	struct active_v_disp_t f;
+} __attribute__((packed));
+
+struct graphic_h_disp_t {
+	unsigned long graphic_h_start : 10;
+	unsigned long                 : 6;
+	unsigned long graphic_h_end   : 10;
+	unsigned long                 : 6;
+} __attribute__((packed));
+
+union graphic_h_disp_u {
+	unsigned long val : 32;
+	struct graphic_h_disp_t f;
+} __attribute__((packed));
+
+struct graphic_v_disp_t {
+	unsigned long graphic_v_start : 10;
+	unsigned long                 : 6;
+	unsigned long graphic_v_end   : 10;
+	unsigned long                 : 6;
+} __attribute__((packed));
+
+union graphic_v_disp_u{
+	unsigned long val : 32;
+	struct graphic_v_disp_t f;
+} __attribute__((packed));
+
+struct graphic_ctrl_t_w100 {
+	unsigned long color_depth       : 3;
+	unsigned long portrait_mode     : 2;
+	unsigned long low_power_on      : 1;
+	unsigned long req_freq          : 4;
+	unsigned long en_crtc           : 1;
+	unsigned long en_graphic_req    : 1;
+	unsigned long en_graphic_crtc   : 1;
+	unsigned long total_req_graphic : 9;
+	unsigned long lcd_pclk_on       : 1;
+	unsigned long lcd_sclk_on       : 1;
+	unsigned long pclk_running      : 1;
+	unsigned long sclk_running      : 1;
+	unsigned long                   : 6;
+} __attribute__((packed));
+
+struct graphic_ctrl_t_w32xx {
+	unsigned long color_depth       : 3;
+	unsigned long portrait_mode     : 2;
+	unsigned long low_power_on      : 1;
+	unsigned long req_freq          : 4;
+	unsigned long en_crtc           : 1;
+	unsigned long en_graphic_req    : 1;
+	unsigned long en_graphic_crtc   : 1;
+	unsigned long total_req_graphic : 10;
+	unsigned long lcd_pclk_on       : 1;
+	unsigned long lcd_sclk_on       : 1;
+	unsigned long pclk_running      : 1;
+	unsigned long sclk_running      : 1;
+	unsigned long                   : 5;
+} __attribute__((packed));
+
+union graphic_ctrl_u {
+	unsigned long val : 32;
+	struct graphic_ctrl_t_w100 f_w100;
+	struct graphic_ctrl_t_w32xx f_w32xx;
 } __attribute__((packed));
 
 struct video_ctrl_t {
-     unsigned long video_mode       : 1;
-     unsigned long keyer_en         : 1;
-     unsigned long en_video_req     : 1;
-     unsigned long en_graphic_req_video           : 1;
-     unsigned long en_video_crtc    : 1;
-     unsigned long video_hor_exp    : 2;
-     unsigned long video_ver_exp    : 2;
-     unsigned long uv_combine       : 1;
-     unsigned long total_req_video  : 9;
-     unsigned long video_ch_sel     : 1;
-     unsigned long video_portrait   : 2;
-     unsigned long yuv2rgb_en       : 1;
-     unsigned long yuv2rgb_option   : 1;
-     unsigned long video_inv_hor    : 1;
-     unsigned long video_inv_ver    : 1;
-     unsigned long gamma_sel        : 2;
-     unsigned long dis_limit        : 1;
-     unsigned long en_uv_hblend     : 1;
-     unsigned long rgb_gamma_sel    : 2;
+	unsigned long video_mode       : 1;
+	unsigned long keyer_en         : 1;
+	unsigned long en_video_req     : 1;
+	unsigned long en_graphic_req_video  : 1;
+	unsigned long en_video_crtc    : 1;
+	unsigned long video_hor_exp    : 2;
+	unsigned long video_ver_exp    : 2;
+	unsigned long uv_combine       : 1;
+	unsigned long total_req_video  : 9;
+	unsigned long video_ch_sel     : 1;
+	unsigned long video_portrait   : 2;
+	unsigned long yuv2rgb_en       : 1;
+	unsigned long yuv2rgb_option   : 1;
+	unsigned long video_inv_hor    : 1;
+	unsigned long video_inv_ver    : 1;
+	unsigned long gamma_sel        : 2;
+	unsigned long dis_limit        : 1;
+	unsigned long en_uv_hblend     : 1;
+	unsigned long rgb_gamma_sel    : 2;
 } __attribute__((packed));
 
 union video_ctrl_u {
-     unsigned long val : 32;
-     struct video_ctrl_t f;
+	unsigned long val : 32;
+	struct video_ctrl_t f;
 } __attribute__((packed));
 
 struct disp_db_buf_cntl_rd_t {
-     unsigned long en_db_buf        	: 1;
-     unsigned long update_db_buf_done   : 1;
-     unsigned long db_buf_cntl      	: 6;
-     unsigned long    					: 24;
+	unsigned long en_db_buf           : 1;
+	unsigned long update_db_buf_done  : 1;
+	unsigned long db_buf_cntl         : 6;
+	unsigned long                     : 24;
 } __attribute__((packed));
 
 union disp_db_buf_cntl_rd_u {
-     unsigned long val : 32;
-     struct disp_db_buf_cntl_rd_t f;
+	unsigned long val : 32;
+	struct disp_db_buf_cntl_rd_t f;
 } __attribute__((packed));
 
 struct disp_db_buf_cntl_wr_t {
-     unsigned long en_db_buf        : 1;
-     unsigned long update_db_buf    : 1;
-     unsigned long db_buf_cntl      : 6;
-     unsigned long    : 24;
+	unsigned long en_db_buf      : 1;
+	unsigned long update_db_buf  : 1;
+	unsigned long db_buf_cntl    : 6;
+	unsigned long                : 24;
 } __attribute__((packed));
 
 union disp_db_buf_cntl_wr_u {
-     unsigned long val : 32;
-     struct disp_db_buf_cntl_wr_t f;
+	unsigned long val : 32;
+	struct disp_db_buf_cntl_wr_t f;
 } __attribute__((packed));
 
 struct gamma_value1_t {
-     unsigned long gamma1           : 8;
-     unsigned long gamma2           : 8;
-     unsigned long gamma3           : 8;
-     unsigned long gamma4           : 8;
+	unsigned long gamma1   : 8;
+	unsigned long gamma2   : 8;
+	unsigned long gamma3   : 8;
+	unsigned long gamma4   : 8;
 } __attribute__((packed));
 
 union gamma_value1_u {
-     unsigned long val : 32;
-     struct gamma_value1_t f;
+	unsigned long val : 32;
+	struct gamma_value1_t f;
 } __attribute__((packed));
 
 struct gamma_value2_t {
-     unsigned long gamma5           : 8;
-     unsigned long gamma6           : 8;
-     unsigned long gamma7           : 8;
-     unsigned long gamma8           : 8;
+	unsigned long gamma5   : 8;
+	unsigned long gamma6   : 8;
+	unsigned long gamma7   : 8;
+	unsigned long gamma8   : 8;
 } __attribute__((packed));
 
 union gamma_value2_u {
-     unsigned long val : 32;
-     struct gamma_value2_t f;
+	unsigned long val : 32;
+	struct gamma_value2_t f;
 } __attribute__((packed));
 
 struct gamma_slope_t {
-     unsigned long slope1           : 3;
-     unsigned long slope2           : 3;
-     unsigned long slope3           : 3;
-     unsigned long slope4           : 3;
-     unsigned long slope5           : 3;
-     unsigned long slope6           : 3;
-     unsigned long slope7           : 3;
-     unsigned long slope8           : 3;
-     unsigned long    				: 8;
+	unsigned long slope1   : 3;
+	unsigned long slope2   : 3;
+	unsigned long slope3   : 3;
+	unsigned long slope4   : 3;
+	unsigned long slope5   : 3;
+	unsigned long slope6   : 3;
+	unsigned long slope7   : 3;
+	unsigned long slope8   : 3;
+	unsigned long          : 8;
 } __attribute__((packed));
 
 union gamma_slope_u {
-     unsigned long val : 32;
-     struct gamma_slope_t f;
+	unsigned long val : 32;
+	struct gamma_slope_t f;
 } __attribute__((packed));
 
 struct mc_ext_mem_location_t {
-     unsigned long mc_ext_mem_start : 16;
-     unsigned long mc_ext_mem_top   : 16;
+	unsigned long mc_ext_mem_start : 16;
+	unsigned long mc_ext_mem_top   : 16;
 } __attribute__((packed));
 
 union mc_ext_mem_location_u {
-     unsigned long val : 32;
-     struct mc_ext_mem_location_t f;
+	unsigned long val : 32;
+	struct mc_ext_mem_location_t f;
+} __attribute__((packed));
+
+struct mc_fb_location_t {
+	unsigned long mc_fb_start      : 16;
+	unsigned long mc_fb_top        : 16;
+} __attribute__((packed));
+
+union mc_fb_location_u {
+	unsigned long val : 32;
+	struct mc_fb_location_t f;
 } __attribute__((packed));
 
 struct clk_pin_cntl_t {
-     unsigned long osc_en           : 1;
-     unsigned long osc_gain         : 5;
-     unsigned long dont_use_xtalin  : 1;
-     unsigned long xtalin_pm_en     : 1;
-     unsigned long xtalin_dbl_en    : 1;
-     unsigned long    				: 7;
-     unsigned long cg_debug         : 16;
+	unsigned long osc_en           : 1;
+	unsigned long osc_gain         : 5;
+	unsigned long dont_use_xtalin  : 1;
+	unsigned long xtalin_pm_en     : 1;
+	unsigned long xtalin_dbl_en    : 1;
+	unsigned long                  : 7;
+	unsigned long cg_debug         : 16;
 } __attribute__((packed));
 
 union clk_pin_cntl_u {
-     unsigned long val : 32;
-     struct clk_pin_cntl_t f;
+	unsigned long val : 32;
+	struct clk_pin_cntl_t f;
 } __attribute__((packed));
 
 struct pll_ref_fb_div_t {
-     unsigned long pll_ref_div      : 4;
-     unsigned long    				: 4;
-     unsigned long pll_fb_div_int   : 6;
-     unsigned long    				: 2;
-     unsigned long pll_fb_div_frac  : 3;
-     unsigned long    				: 1;
-     unsigned long pll_reset_time   : 4;
-     unsigned long pll_lock_time    : 8;
+	unsigned long pll_ref_div      : 4;
+	unsigned long                  : 4;
+	unsigned long pll_fb_div_int   : 6;
+	unsigned long                  : 2;
+	unsigned long pll_fb_div_frac  : 3;
+	unsigned long                  : 1;
+	unsigned long pll_reset_time   : 4;
+	unsigned long pll_lock_time    : 8;
 } __attribute__((packed));
 
 union pll_ref_fb_div_u {
-     unsigned long val : 32;
-     struct pll_ref_fb_div_t f;
+	unsigned long val : 32;
+	struct pll_ref_fb_div_t f;
 } __attribute__((packed));
 
 struct pll_cntl_t {
-     unsigned long pll_pwdn         : 1;
-     unsigned long pll_reset        : 1;
-     unsigned long pll_pm_en        : 1;
-     unsigned long pll_mode         : 1;
-     unsigned long pll_refclk_sel   : 1;
-     unsigned long pll_fbclk_sel    : 1;
-     unsigned long pll_tcpoff       : 1;
-     unsigned long pll_pcp          : 3;
-     unsigned long pll_pvg          : 3;
-     unsigned long pll_vcofr        : 1;
-     unsigned long pll_ioffset      : 2;
-     unsigned long pll_pecc_mode    : 2;
-     unsigned long pll_pecc_scon    : 2;
-     unsigned long pll_dactal       : 4;
-     unsigned long pll_cp_clip      : 2;
-     unsigned long pll_conf         : 3;
-     unsigned long pll_mbctrl       : 2;
-     unsigned long pll_ring_off     : 1;
+	unsigned long pll_pwdn        : 1;
+	unsigned long pll_reset       : 1;
+	unsigned long pll_pm_en       : 1;
+	unsigned long pll_mode        : 1;
+	unsigned long pll_refclk_sel  : 1;
+	unsigned long pll_fbclk_sel   : 1;
+	unsigned long pll_tcpoff      : 1;
+	unsigned long pll_pcp         : 3;
+	unsigned long pll_pvg         : 3;
+	unsigned long pll_vcofr       : 1;
+	unsigned long pll_ioffset     : 2;
+	unsigned long pll_pecc_mode   : 2;
+	unsigned long pll_pecc_scon   : 2;
+	unsigned long pll_dactal      : 4;
+	unsigned long pll_cp_clip     : 2;
+	unsigned long pll_conf        : 3;
+	unsigned long pll_mbctrl      : 2;
+	unsigned long pll_ring_off    : 1;
 } __attribute__((packed));
 
 union pll_cntl_u {
-     unsigned long val : 32;
-     struct pll_cntl_t f;
+	unsigned long val : 32;
+	struct pll_cntl_t f;
 } __attribute__((packed));
 
 struct sclk_cntl_t {
-     unsigned long sclk_src_sel     	: 2;
-     unsigned long    					: 2;
-     unsigned long sclk_post_div_fast   : 4;
-     unsigned long sclk_clkon_hys   	: 3;
-     unsigned long sclk_post_div_slow   : 4;
-     unsigned long disp_cg_ok2switch_en : 1;
-     unsigned long sclk_force_reg   	: 1;
-     unsigned long sclk_force_disp  	: 1;
-     unsigned long sclk_force_mc    	: 1;
-     unsigned long sclk_force_extmc 	: 1;
-     unsigned long sclk_force_cp    	: 1;
-     unsigned long sclk_force_e2    	: 1;
-     unsigned long sclk_force_e3    	: 1;
-     unsigned long sclk_force_idct  	: 1;
-     unsigned long sclk_force_bist  	: 1;
-     unsigned long busy_extend_cp   	: 1;
-     unsigned long busy_extend_e2   	: 1;
-     unsigned long busy_extend_e3   	: 1;
-     unsigned long busy_extend_idct 	: 1;
-     unsigned long    					: 3;
+	unsigned long sclk_src_sel         : 2;
+	unsigned long                      : 2;
+	unsigned long sclk_post_div_fast   : 4;
+	unsigned long sclk_clkon_hys       : 3;
+	unsigned long sclk_post_div_slow   : 4;
+	unsigned long disp_cg_ok2switch_en : 1;
+	unsigned long sclk_force_reg       : 1;
+	unsigned long sclk_force_disp      : 1;
+	unsigned long sclk_force_mc        : 1;
+	unsigned long sclk_force_extmc     : 1;
+	unsigned long sclk_force_cp        : 1;
+	unsigned long sclk_force_e2        : 1;
+	unsigned long sclk_force_e3        : 1;
+	unsigned long sclk_force_idct      : 1;
+	unsigned long sclk_force_bist      : 1;
+	unsigned long busy_extend_cp       : 1;
+	unsigned long busy_extend_e2       : 1;
+	unsigned long busy_extend_e3       : 1;
+	unsigned long busy_extend_idct     : 1;
+	unsigned long                      : 3;
 } __attribute__((packed));
 
 union sclk_cntl_u {
-     unsigned long val : 32;
-     struct sclk_cntl_t f;
+	unsigned long val : 32;
+	struct sclk_cntl_t f;
 } __attribute__((packed));
 
 struct pclk_cntl_t {
-     unsigned long pclk_src_sel     : 2;
-     unsigned long    				: 2;
-     unsigned long pclk_post_div    : 4;
-     unsigned long    				: 8;
-     unsigned long pclk_force_disp  : 1;
-     unsigned long    				: 15;
+	unsigned long pclk_src_sel     : 2;
+	unsigned long                  : 2;
+	unsigned long pclk_post_div    : 4;
+	unsigned long                  : 8;
+	unsigned long pclk_force_disp  : 1;
+	unsigned long                  : 15;
 } __attribute__((packed));
 
 union pclk_cntl_u {
-     unsigned long val : 32;
-     struct pclk_cntl_t f;
+	unsigned long val : 32;
+	struct pclk_cntl_t f;
 } __attribute__((packed));
 
+
+#define TESTCLK_SRC_PLL   0x01
+#define TESTCLK_SRC_SCLK  0x02
+#define TESTCLK_SRC_PCLK  0x03
+/* 4 and 5 seem to by XTAL/M */
+#define TESTCLK_SRC_XTAL  0x06
+
 struct clk_test_cntl_t {
-     unsigned long testclk_sel      : 4;
-     unsigned long    				: 3;
-     unsigned long start_check_freq : 1;
-     unsigned long tstcount_rst     : 1;
-     unsigned long    				: 15;
-     unsigned long test_count       : 8;
+	unsigned long testclk_sel      : 4;
+	unsigned long                  : 3;
+	unsigned long start_check_freq : 1;
+	unsigned long tstcount_rst     : 1;
+	unsigned long                  : 15;
+	unsigned long test_count       : 8;
 } __attribute__((packed));
 
 union clk_test_cntl_u {
-     unsigned long val : 32;
-     struct clk_test_cntl_t f;
+	unsigned long val : 32;
+	struct clk_test_cntl_t f;
 } __attribute__((packed));
 
 struct pwrmgt_cntl_t {
-     unsigned long pwm_enable       	: 1;
-     unsigned long    					: 1;
-     unsigned long pwm_mode_req         : 2;
-     unsigned long pwm_wakeup_cond      : 2;
-     unsigned long pwm_fast_noml_hw_en  : 1;
-     unsigned long pwm_noml_fast_hw_en  : 1;
-     unsigned long pwm_fast_noml_cond   : 4;
-     unsigned long pwm_noml_fast_cond   : 4;
-     unsigned long pwm_idle_timer   	: 8;
-     unsigned long pwm_busy_timer   	: 8;
+	unsigned long pwm_enable           : 1;
+	unsigned long                      : 1;
+	unsigned long pwm_mode_req         : 2;
+	unsigned long pwm_wakeup_cond      : 2;
+	unsigned long pwm_fast_noml_hw_en  : 1;
+	unsigned long pwm_noml_fast_hw_en  : 1;
+	unsigned long pwm_fast_noml_cond   : 4;
+	unsigned long pwm_noml_fast_cond   : 4;
+	unsigned long pwm_idle_timer       : 8;
+	unsigned long pwm_busy_timer       : 8;
 } __attribute__((packed));
 
 union pwrmgt_cntl_u {
-     unsigned long val : 32;
-     struct pwrmgt_cntl_t f;
+	unsigned long val : 32;
+	struct pwrmgt_cntl_t f;
 } __attribute__((packed));
 
 #endif
Index: linux-2.6.12/include/video/w100fb.h
===================================================================
--- linux-2.6.12.orig/include/video/w100fb.h	2005-08-05 17:31:39.000000000 +0100
+++ linux-2.6.12/include/video/w100fb.h	2005-08-07 11:11:33.000000000 +0100
@@ -1,21 +1,149 @@
 /*
  *  Support for the w100 frame buffer.
  *
- *  Copyright (c) 2004 Richard Purdie
+ *  Copyright (c) 2004-2005 Richard Purdie
+ *  Copyright (c) 2005 Ian Molton
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2 as
  *  published by the Free Software Foundation.
  */
 
+#define W100_GPIO_PORT_A	0
+#define W100_GPIO_PORT_B	1
+
+#define CLK_SRC_XTAL  0
+#define CLK_SRC_PLL   1
+
+struct w100fb_par;
+
+unsigned long w100fb_gpio_read(int port);
+void w100fb_gpio_write(int port, unsigned long value);
+
+/* LCD Specific Routines and Config */
+struct w100_tg_info {
+	void (*change)(struct w100fb_par*);
+	void (*suspend)(struct w100fb_par*);
+	void (*resume)(struct w100fb_par*);
+};
+
+/* General Platform Specific w100 Register Values */
+struct w100_gen_regs {
+	unsigned long lcd_format;
+	unsigned long lcdd_cntl1;
+	unsigned long lcdd_cntl2;
+	unsigned long genlcd_cntl1;
+	unsigned long genlcd_cntl2;
+	unsigned long genlcd_cntl3;
+};
+
+struct w100_gpio_regs {
+	unsigned long init_data1;
+	unsigned long init_data2;
+	unsigned long gpio_dir1;
+	unsigned long gpio_oe1;
+	unsigned long gpio_dir2;
+	unsigned long gpio_oe2;
+};
+
+/* Optional External Memory Configuration */
+struct w100_mem_info {
+	unsigned long ext_cntl;
+	unsigned long sdram_mode_reg;
+	unsigned long ext_timing_cntl;
+	unsigned long io_cntl;
+	unsigned int size;
+};
+
+struct w100_bm_mem_info {
+	unsigned long ext_mem_bw;
+	unsigned long offset;
+	unsigned long ext_timing_ctl;
+	unsigned long ext_cntl;
+	unsigned long mode_reg;
+	unsigned long io_cntl;
+	unsigned long config;
+};
+
+/* LCD Mode definition */
+struct w100_mode {
+	unsigned int xres;
+	unsigned int yres;
+	unsigned short left_margin;
+	unsigned short right_margin;
+	unsigned short upper_margin;
+	unsigned short lower_margin;
+	unsigned long crtc_ss;
+	unsigned long crtc_ls;
+	unsigned long crtc_gs;
+	unsigned long crtc_vpos_gs;
+	unsigned long crtc_rev;
+	unsigned long crtc_dclk;
+	unsigned long crtc_gclk;
+	unsigned long crtc_goe;
+	unsigned long crtc_ps1_active;
+	char pll_freq;
+	char fast_pll_freq;
+	int sysclk_src;	
+	int sysclk_divider;	
+	int pixclk_src;
+	int pixclk_divider;
+	int pixclk_divider_rotated;
+};
+
+struct w100_pll_info {
+	uint16_t freq;  /* desired Fout for PLL (Mhz) */
+	uint8_t M;      /* input divider */
+	uint8_t N_int;  /* VCO multiplier */
+	uint8_t N_fac;  /* VCO multiplier fractional part */
+	uint8_t tfgoal;
+	uint8_t lock_time;
+};
+
+/* Initial Video mode orientation flags */
+#define INIT_MODE_ROTATED  0x1
+#define INIT_MODE_FLIPPED  0x2
+
 /*
  * This structure describes the machine which we are running on.
  * It is set by machine specific code and used in the probe routine
  * of drivers/video/w100fb.c
  */
-
 struct w100fb_mach_info {
-	void (*w100fb_ssp_send)(u8 adrs, u8 data);
-	int comadj;
-	int phadadj;
+	/* General Platform Specific Registers */
+	struct w100_gen_regs *regs;
+	/* Table of modes the LCD is capable of */
+	struct w100_mode *modelist;
+	unsigned int num_modes;
+	/* Hooks for any platform specific tg/lcd code (optional) */
+	struct w100_tg_info *tg;
+	/* External memory definition (if present) */
+	struct w100_mem_info *mem;
+	/* Additional External memory definition (if present) */
+	struct w100_bm_mem_info *bm_mem;
+	/* GPIO definitions (optional) */
+	struct w100_gpio_regs *gpio;
+	/* Initial Mode flags */
+	unsigned int init_mode;
+	/* Xtal Frequency */
+	unsigned int xtal_freq;
+	/* Enable Xtal input doubler (1 == enable) */
+	unsigned int xtal_dbl;
+};
+
+/* General frame buffer data structure */
+struct w100fb_par {
+	unsigned int chip_id;
+	unsigned int xres;
+	unsigned int yres;
+	unsigned int extmem_active;
+	unsigned int flip;
+	unsigned int blanked;
+	unsigned int fastpll_mode;
+	unsigned long hsync_len;
+	struct w100_mode *mode;
+	struct w100_pll_info *pll_table;
+	struct w100fb_mach_info *mach;
+	uint32_t *saved_intmem;
+	uint32_t *saved_extmem;
 };




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
