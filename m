From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 12 Apr 2014 06:53:03 +0000
Subject: [PATCH v2 2/3] video: clps711x: Switch CLPS711X boards to use new FB driver
Message-Id: <1397285583-15187-2-git-send-email-shc_work@mail.ru>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch removes old implementation of Cirrus Logic CLPS711X FB
driver and switch current users to use new one.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-clps711x/board-autcpu12.c |   2 +-
 arch/arm/mach-clps711x/board-edb7211.c  |   2 +-
 arch/arm/mach-clps711x/board-p720t.c    |   2 +-
 arch/arm/mach-clps711x/devices.c        |  22 +++
 arch/arm/mach-clps711x/devices.h        |   1 +
 drivers/video/fbdev/Kconfig             |  18 +-
 drivers/video/fbdev/Makefile            |   2 +-
 drivers/video/fbdev/clps711xfb.c        | 315 --------------------------------
 8 files changed, 38 insertions(+), 326 deletions(-)
 delete mode 100644 drivers/video/fbdev/clps711xfb.c

diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
index d62ca16..ed8369d 100644
--- a/arch/arm/mach-clps711x/board-autcpu12.c
+++ b/arch/arm/mach-clps711x/board-autcpu12.c
@@ -249,7 +249,7 @@ static void __init autcpu12_init(void)
 {
 	clps711x_devices_init();
 	platform_device_register(&autcpu12_flash_pdev);
-	platform_device_register_simple("video-clps711x", 0, NULL, 0);
+	clps711x_add_fb(CLPS711X_SRAM_BASE, CLPS711X_SRAM_SIZE, false);
 	platform_device_register_simple("cs89x0", 0, autcpu12_cs8900_resource,
 					ARRAY_SIZE(autcpu12_cs8900_resource));
 	platform_device_register(&autcpu12_mmgpio_pdev);
diff --git a/arch/arm/mach-clps711x/board-edb7211.c b/arch/arm/mach-clps711x/board-edb7211.c
index 0776098..973900c 100644
--- a/arch/arm/mach-clps711x/board-edb7211.c
+++ b/arch/arm/mach-clps711x/board-edb7211.c
@@ -166,7 +166,7 @@ static void __init edb7211_init_late(void)
 	platform_device_register_data(&platform_bus, "generic-bl", 0,
 				      &edb7211_lcd_backlight_pdata,
 				      sizeof(edb7211_lcd_backlight_pdata));
-	platform_device_register_simple("video-clps711x", 0, NULL, 0);
+	clps711x_add_fb(CLPS711X_SDRAM0_BASE, VIDEORAM_SIZE, true);
 	platform_device_register_simple("cs89x0", 0, edb7211_cs8900_resource,
 					ARRAY_SIZE(edb7211_cs8900_resource));
 	platform_device_register_data(&platform_bus, "i2c-gpio", 0,
diff --git a/arch/arm/mach-clps711x/board-p720t.c b/arch/arm/mach-clps711x/board-p720t.c
index 67b7337..af35aa8 100644
--- a/arch/arm/mach-clps711x/board-p720t.c
+++ b/arch/arm/mach-clps711x/board-p720t.c
@@ -354,7 +354,7 @@ static void __init p720t_init_late(void)
 	platform_device_register_data(&platform_bus, "generic-bl", 0,
 				      &p720t_lcd_backlight_pdata,
 				      sizeof(p720t_lcd_backlight_pdata));
-	platform_device_register_simple("video-clps711x", 0, NULL, 0);
+	clps711x_add_fb(CLPS711X_SRAM_BASE, CLPS711X_SRAM_SIZE, false);
 	platform_device_register_data(&platform_bus, "leds-gpio", 0,
 				      &p720t_gpio_led_pdata,
 				      sizeof(p720t_gpio_led_pdata));
diff --git a/arch/arm/mach-clps711x/devices.c b/arch/arm/mach-clps711x/devices.c
index 2001488..d32c73f 100644
--- a/arch/arm/mach-clps711x/devices.c
+++ b/arch/arm/mach-clps711x/devices.c
@@ -14,6 +14,28 @@
 
 #include <mach/hardware.h>
 
+static bool fb_invert __initdata;
+
+void __init clps711x_add_fb(phys_addr_t base, resource_size_t size, bool invert)
+{
+	struct resource res[2];
+
+	memset(res, 0, sizeof(res));
+
+	res[0].flags = IORESOURCE_MEM;
+	res[0].start = CLPS711X_PHYS_BASE + LCDCON;
+	res[0].end = CLPS711X_PHYS_BASE + FBADDR + 3;
+	res[1].flags = IORESOURCE_MEM;
+	res[1].start = base;
+	res[1].end = base + size - 1;
+	fb_invert = invert;
+
+	platform_device_register_resndata(NULL, "clps711x-fb",
+					  PLATFORM_DEVID_NONE,
+					  res, ARRAY_SIZE(res),
+					  &fb_invert, sizeof(fb_invert));
+}
+
 static const phys_addr_t clps711x_gpios[][2] __initconst = {
 	{ PADR, PADDR },
 	{ PBDR, PBDDR },
diff --git a/arch/arm/mach-clps711x/devices.h b/arch/arm/mach-clps711x/devices.h
index a5efc17..3a44153 100644
--- a/arch/arm/mach-clps711x/devices.h
+++ b/arch/arm/mach-clps711x/devices.h
@@ -9,4 +9,5 @@
  * (at your option) any later version.
  */
 
+void clps711x_add_fb(phys_addr_t, resource_size_t, bool);
 void clps711x_devices_init(void);
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 45fd7f3..d1f6dca 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -302,14 +302,18 @@ config FB_ACORN
 	  unsure, say N.
 
 config FB_CLPS711X
-	bool "CLPS711X LCD support"
-	depends on (FB = y) && ARM && ARCH_CLPS711X
-	select FB_CFB_FILLRECT
-	select FB_CFB_COPYAREA
-	select FB_CFB_IMAGEBLIT
+	tristate "CLPS711X LCD support"
+	depends on FB && (ARCH_CLPS711X || COMPILE_TEST)
+	select BACKLIGHT_LCD_SUPPORT
+	select FB_MODE_HELPERS
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select LCD_CLASS_DEVICE
+	select VIDEOMODE_HELPERS
 	help
-	  Say Y to enable the Framebuffer driver for the CLPS7111 and
-	  EP7212 processors.
+	  Say Y to enable the Framebuffer driver for the Cirrus Logic
+	  CLPS711X CPUs.
 
 config FB_SA1100
 	bool "SA-1100 LCD support"
diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
index 0284f2a..0164bb1 100644
--- a/drivers/video/fbdev/Makefile
+++ b/drivers/video/fbdev/Makefile
@@ -14,7 +14,7 @@ obj-$(CONFIG_FB_WMT_GE_ROPS)   += wmt_ge_rops.o
 # Hardware specific drivers go first
 obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p_planar.o
 obj-$(CONFIG_FB_ARC)              += arcfb.o
-obj-$(CONFIG_FB_CLPS711X)         += clps711xfb.o
+obj-$(CONFIG_FB_CLPS711X)	  += clps711x-fb.o
 obj-$(CONFIG_FB_CYBER2000)        += cyber2000fb.o
 obj-$(CONFIG_FB_GRVGA)            += grvga.o
 obj-$(CONFIG_FB_PM2)              += pm2fb.o
diff --git a/drivers/video/fbdev/clps711xfb.c b/drivers/video/fbdev/clps711xfb.c
deleted file mode 100644
index f009806..0000000
--- a/drivers/video/fbdev/clps711xfb.c
+++ /dev/null
@@ -1,315 +0,0 @@
-/*
- *  linux/drivers/video/clps711xfb.c
- *
- *  Copyright (C) 2000-2001 Deep Blue Solutions Ltd.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
- *  Framebuffer driver for the CLPS7111 and EP7212 processors.
- */
-#include <linux/mm.h>
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/fb.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <linux/uaccess.h>
-
-struct fb_info	*cfb;
-
-#define CMAP_MAX_SIZE	16
-
-/*
- * LCD AC Prescale.  This comes from the LCD panel manufacturers specifications.
- * This determines how many clocks + 1 of CL1 before the M signal toggles.
- * The number of lines on the display must not be divisible by this number.
- */
-static unsigned int lcd_ac_prescale = 13;
-
-/*
- *    Set a single color register. Return != 0 for invalid regno.
- */
-static int
-clps7111fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-		     u_int transp, struct fb_info *info)
-{
-	unsigned int level, mask, shift, pal;
-
-	if (regno >= (1 << info->var.bits_per_pixel))
-		return 1;
-
-	/* gray = 0.30*R + 0.58*G + 0.11*B */
-	level = (red * 77 + green * 151 + blue * 28) >> 20;
-
-	/*
-	 * On an LCD, a high value is dark, while a low value is light. 
-	 * So we invert the level.
-	 *
-	 * This isn't true on all machines, so we only do it on EDB7211.
-	 *  --rmk
-	 */
-	if (machine_is_edb7211()) {
-		level = 15 - level;
-	}
-
-	shift = 4 * (regno & 7);
-	level <<= shift;
-	mask  = 15 << shift;
-	level &= mask;
-
-	regno = regno < 8 ? PALLSW : PALMSW;
-
-	pal = clps_readl(regno);
-	pal = (pal & ~mask) | level;
-	clps_writel(pal, regno);
-
-	return 0;
-}
-
-/*
- * Validate the purposed mode.
- */	
-static int
-clps7111fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
-{
-	var->transp.msb_right	= 0;
-	var->transp.offset	= 0;
-	var->transp.length	= 0;
-	var->red.msb_right	= 0;
-	var->red.offset		= 0;
-	var->red.length		= var->bits_per_pixel;
-	var->green		= var->red;
-	var->blue		= var->red;
-
-	if (var->bits_per_pixel > 4) 
-		return -EINVAL;
-
-	return 0;
-}
-
-/*
- * Set the hardware state.
- */ 
-static int 
-clps7111fb_set_par(struct fb_info *info)
-{
-	unsigned int lcdcon, syscon, pixclock;
-
-	switch (info->var.bits_per_pixel) {
-	case 1:
-		info->fix.visual = FB_VISUAL_MONO01;
-		break;
-	case 2:
-		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		break;
-	case 4:
-		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		break;
-	}
-
-	info->fix.line_length = info->var.xres_virtual * info->var.bits_per_pixel / 8;
-
-	lcdcon = (info->var.xres_virtual * info->var.yres_virtual * info->var.bits_per_pixel) / 128 - 1;
-	lcdcon |= ((info->var.xres_virtual / 16) - 1) << 13;
-	lcdcon |= lcd_ac_prescale << 25;
-
-	/*
-	 * Calculate pixel prescale value from the pixclock.  This is:
-	 *  36.864MHz / pixclock_mhz - 1.
-	 * However, pixclock is in picoseconds, so this ends up being:
-	 *  36864000 * pixclock_ps / 10^12 - 1
-	 * and this will overflow the 32-bit math.  We perform this as
-	 * (9 * 4096000 = 36864000):
-	 *  pixclock_ps * 9 * (4096000 / 10^12) - 1
-	 */
-	pixclock = 9 * info->var.pixclock / 244140 - 1;
-	lcdcon |= pixclock << 19;
-
-	if (info->var.bits_per_pixel = 4)
-		lcdcon |= LCDCON_GSMD;
-	if (info->var.bits_per_pixel >= 2)
-		lcdcon |= LCDCON_GSEN;
-
-	/*
-	 * LCDCON must only be changed while the LCD is disabled
-	 */
-	syscon = clps_readl(SYSCON1);
-	clps_writel(syscon & ~SYSCON1_LCDEN, SYSCON1);
-	clps_writel(lcdcon, LCDCON);
-	clps_writel(syscon | SYSCON1_LCDEN, SYSCON1);
-	return 0;
-}
-
-static int clps7111fb_blank(int blank, struct fb_info *info)
-{
-	/* Enable/Disable LCD controller. */
-	if (blank)
-		clps_writel(clps_readl(SYSCON1) & ~SYSCON1_LCDEN, SYSCON1);
-	else
-		clps_writel(clps_readl(SYSCON1) | SYSCON1_LCDEN, SYSCON1);
-
-	return 0;
-}
-
-static struct fb_ops clps7111fb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_check_var	= clps7111fb_check_var,
-	.fb_set_par	= clps7111fb_set_par,
-	.fb_setcolreg	= clps7111fb_setcolreg,
-	.fb_blank	= clps7111fb_blank,
-	.fb_fillrect	= cfb_fillrect,
-	.fb_copyarea	= cfb_copyarea,
-	.fb_imageblit	= cfb_imageblit,
-};
-
-static void clps711x_guess_lcd_params(struct fb_info *info)
-{
-	unsigned int lcdcon, syscon, size;
-	unsigned long phys_base = PAGE_OFFSET;
-	void *virt_base = (void *)PAGE_OFFSET;
-
-	info->var.xres_virtual	 = 640;
-	info->var.yres_virtual	 = 240;
-	info->var.bits_per_pixel = 4;
-	info->var.activate	 = FB_ACTIVATE_NOW;
-	info->var.height	 = -1;
-	info->var.width		 = -1;
-	info->var.pixclock	 = 93006; /* 10.752MHz pixel clock */
-
-	/*
-	 * If the LCD controller is already running, decode the values
-	 * in LCDCON to xres/yres/bpp/pixclock/acprescale
-	 */
-	syscon = clps_readl(SYSCON1);
-	if (syscon & SYSCON1_LCDEN) {
-		lcdcon = clps_readl(LCDCON);
-
-		/*
-		 * Decode GSMD and GSEN bits to bits per pixel
-		 */
-		switch (lcdcon & (LCDCON_GSMD | LCDCON_GSEN)) {
-		case LCDCON_GSMD | LCDCON_GSEN:
-			info->var.bits_per_pixel = 4;
-			break;
-
-		case LCDCON_GSEN:
-			info->var.bits_per_pixel = 2;
-			break;
-
-		default:
-			info->var.bits_per_pixel = 1;
-			break;
-		}
-
-		/*
-		 * Decode xres/yres
-		 */
-		info->var.xres_virtual = (((lcdcon >> 13) & 0x3f) + 1) * 16;
-		info->var.yres_virtual = (((lcdcon & 0x1fff) + 1) * 128) /
-					  (info->var.xres_virtual *
-					   info->var.bits_per_pixel);
-
-		/*
-		 * Calculate pixclock
-		 */
-		info->var.pixclock = (((lcdcon >> 19) & 0x3f) + 1) * 244140 / 9;
-
-		/*
-		 * Grab AC prescale
-		 */
-		lcd_ac_prescale = (lcdcon >> 25) & 0x1f;
-	}
-
-	info->var.xres = info->var.xres_virtual;
-	info->var.yres = info->var.yres_virtual;
-	info->var.grayscale = info->var.bits_per_pixel > 1;
-
-	size = info->var.xres * info->var.yres * info->var.bits_per_pixel / 8;
-
-	/*
-	 * Might be worth checking to see if we can use the on-board
-	 * RAM if size here...
-	 * CLPS7110 - no on-board SRAM
-	 * EP7212   - 38400 bytes
-	 */
-	if (size <= 38400) {
-		printk(KERN_INFO "CLPS711xFB: could use on-board SRAM?\n");
-	}
-
-	if ((syscon & SYSCON1_LCDEN) = 0) {
-		/*
-		 * The display isn't running.  Ensure that
-		 * the display memory is empty.
-		 */
-		memset(virt_base, 0, size);
-	}
-
-	info->screen_base    = virt_base;
-	info->fix.smem_start = phys_base;
-	info->fix.smem_len   = PAGE_ALIGN(size);
-	info->fix.type       = FB_TYPE_PACKED_PIXELS;
-}
-
-static int clps711x_fb_probe(struct platform_device *pdev)
-{
-	int err = -ENOMEM;
-
-	if (fb_get_options("clps711xfb", NULL))
-		return -ENODEV;
-
-	cfb = kzalloc(sizeof(*cfb), GFP_KERNEL);
-	if (!cfb)
-		goto out;
-
-	strcpy(cfb->fix.id, "clps711x");
-
-	cfb->fbops		= &clps7111fb_ops;
-	cfb->flags		= FBINFO_DEFAULT;
-
-	clps711x_guess_lcd_params(cfb);
-
-	fb_alloc_cmap(&cfb->cmap, CMAP_MAX_SIZE, 0);
-
-	err = register_framebuffer(cfb);
-
-out:	return err;
-}
-
-static int clps711x_fb_remove(struct platform_device *pdev)
-{
-	unregister_framebuffer(cfb);
-	kfree(cfb);
-
-	return 0;
-}
-
-static struct platform_driver clps711x_fb_driver = {
-	.driver	= {
-		.name	= "video-clps711x",
-		.owner	= THIS_MODULE,
-	},
-	.probe	= clps711x_fb_probe,
-	.remove	= clps711x_fb_remove,
-};
-module_platform_driver(clps711x_fb_driver);
-
-MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
-MODULE_DESCRIPTION("CLPS711X framebuffer driver");
-MODULE_LICENSE("GPL");
-- 
1.8.3.2

