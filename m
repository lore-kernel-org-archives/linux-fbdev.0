From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 1/2]Freescale i.MX framebuffer driver
Date: Thu, 17 Mar 2005 18:36:24 +0100
Message-ID: <20050317173624.GA29286@metis.extern.pengutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DByvG-0000gf-NG
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 09:36:38 -0800
Received: from metis.extern.pengutronix.de ([83.236.181.26])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DByvD-0007n2-Af
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 17 Mar 2005 09:36:38 -0800
Received: from sha by metis.extern.pengutronix.de with local (Exim 3.36 #1 (Debian))
	id 1DByv2-0007sy-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 17 Mar 2005 18:36:24 +0100
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
To: linux-fbdev-devel@lists.sourceforge.net


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

This Patch adds support for the framebuffer on the freescale i.MX SOC
architecture. The driver has been tested on the mx1ads board, the pimx1
board and another custom board with different displays.

The first patch is the driver itself along with Kconfig / Makefile, the
second patch is the architecture part which probably should go to
Russell Kings patch system, but I post it here for completeness.

 Kconfig  |    4 
 Makefile |    1 
 imxfb.c  |  851 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 imxfb.h  |   94 ++++++
 4 files changed, 950 insertions(+)

 arch/arm/mach-imx/generic.c      |   16 ++++++++++++++++
 include/asm-arm/arch-imx/imxfb.h |   35 +++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

Sascha Hauer, Pengutronix



--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.6.11-imxfb.patch"

--- linux-2.6.11/drivers/video/Kconfig	2005-03-02 08:37:45.000000000 +0100
+++ linux-2.6.11-work/drivers/video/Kconfig	2005-03-17 17:05:58.000000000 +0100
@@ -133,6 +133,10 @@
 	  If you plan to use the LCD display with your SA-1100 system, say
 	  Y here.
 
+config FB_IMX
+	tristate "Motorola i.MX LCD support"
+	depends on FB && ARM && ARCH_IMX
+
 config FB_CYBER2000
 	tristate "CyberPro 2000/2010/5000 support"
 	depends on FB && PCI && (BROKEN || !SPARC64)
--- linux-2.6.11/drivers/video/Makefile	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6.11-work/drivers/video/Makefile	2005-03-17 17:05:39.000000000 +0100
@@ -98,6 +98,7 @@
 obj-$(CONFIG_FB_PMAGB_B)	  += pmagb-b-fb.o  cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_MAXINE)		  += maxinefb.o  cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 obj-$(CONFIG_FB_TX3912)		  += tx3912fb.o  cfbfillrect.o cfbcopyarea.o cfbimgblt.o
+obj-$(CONFIG_FB_IMX)               += imxfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
 
 # Platform or fallback drivers go here
 obj-$(CONFIG_FB_VESA)             += vesafb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
--- linux-2.6.11/drivers/video/imxfb.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-work/drivers/video/imxfb.c	2005-03-17 17:04:38.000000000 +0100
@@ -0,0 +1,851 @@
+/*
+ *  linux/drivers/video/imxfb.c
+ *
+ *  Copyright (C) 2004 Sascha Hauer
+ *   Based on acornfb.c Copyright (C) Russell King.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive for
+ * more details.
+ *
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/fb.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/cpufreq.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/hardware.h>
+#include <asm/io.h>
+#include <asm/mach-types.h>
+#include <asm/uaccess.h>
+#include <asm/arch/imxfb.h>
+
+/*
+ * Complain if VAR is out of range.
+ */
+#define DEBUG_VAR 1
+
+// #define DEBUG 1
+
+#include "imxfb.h"
+
+static struct imxfb_rgb def_rgb_16 = {
+	.red	= { offset: 8,  length: 4, },
+	.green	= { offset: 4,  length: 4, },
+	.blue	= { offset: 0,  length: 4, },
+	.transp = { offset: 0,  length: 0, },
+};
+
+static struct imxfb_rgb def_rgb_8 = {
+	.red	= { offset: 0,  length: 8, },
+	.green	= { offset: 0,  length: 8, },
+	.blue	= { offset: 0,  length: 8, },
+	.transp = { offset: 0,  length: 0, },
+};
+
+static int imxfb_activate_var(struct fb_var_screeninfo *var, struct imxfb_info *);
+static void set_ctrlr_state(struct imxfb_info *fbi, u_int state);
+
+static inline void imxfb_schedule_work(struct imxfb_info *fbi, u_int state)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	/*
+	 * We need to handle two requests being made at the same time.
+	 * There are two important cases:
+	 *  1. When we are changing VT (C_REENABLE) while unblanking (C_ENABLE)
+	 *     We must perform the unblanking, which will do our REENABLE for us.
+	 *  2. When we are blanking, but immediately unblank before we have
+	 *     blanked.  We do the "REENABLE" thing here as well, just to be sure.
+	 */
+	if (fbi->task_state == C_ENABLE && state == C_REENABLE)
+		state = (u_int) -1;
+	if (fbi->task_state == C_DISABLE && state == C_ENABLE)
+		state = C_REENABLE;
+
+	if (state != (u_int)-1) {
+		fbi->task_state = state;
+		schedule_work(&fbi->task);
+	}
+	local_irq_restore(flags);
+}
+
+static inline u_int chan_to_field(u_int chan, struct fb_bitfield *bf)
+{
+	chan &= 0xffff;
+	chan >>= 16 - bf->length;
+	return chan << bf->offset;
+}
+
+#define LCDC_PALETTE(x) __REG2(IMX_LCDC_BASE+0x800, (x)<<2)
+static int
+imxfb_setpalettereg(u_int regno, u_int red, u_int green, u_int blue,
+		       u_int trans, struct fb_info *info)
+{
+	struct imxfb_info *fbi = (struct imxfb_info *)info;
+	u_int val, ret = 1;
+
+#define CNVT_TOHW(val,width) ((((val)<<(width))+0x7FFF-(val))>>16)
+	if (regno < fbi->palette_size) {
+		val = (CNVT_TOHW(red, 4) << 8) |
+		      (CNVT_TOHW(green,4) << 4) |
+		      CNVT_TOHW(blue,  4);
+
+		LCDC_PALETTE(regno) = val;
+		ret = 0;
+	}
+	return ret;
+}
+
+static int
+imxfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
+		   u_int trans, struct fb_info *info)
+{
+	struct imxfb_info *fbi = (struct imxfb_info *)info;
+	unsigned int val;
+	int ret = 1;
+
+	/*
+	 * If inverse mode was selected, invert all the colours
+	 * rather than the register number.  The register number
+	 * is what you poke into the framebuffer to produce the
+	 * colour you requested.
+	 */
+	if (fbi->cmap_inverse) {
+		red   = 0xffff - red;
+		green = 0xffff - green;
+		blue  = 0xffff - blue;
+	}
+
+	/*
+	 * If greyscale is true, then we convert the RGB value
+	 * to greyscale no mater what visual we are using.
+	 */
+	if (fbi->fb.var.grayscale)
+		red = green = blue = (19595 * red + 38470 * green +
+					7471 * blue) >> 16;
+
+	switch (fbi->fb.fix.visual) {
+	case FB_VISUAL_TRUECOLOR:
+		/*
+		 * 12 or 16-bit True Colour.  We encode the RGB value
+		 * according to the RGB bitfield information.
+		 */
+		if (regno < 16) {
+			u32 *pal = fbi->fb.pseudo_palette;
+
+			val  = chan_to_field(red, &fbi->fb.var.red);
+			val |= chan_to_field(green, &fbi->fb.var.green);
+			val |= chan_to_field(blue, &fbi->fb.var.blue);
+
+			pal[regno] = val;
+			ret = 0;
+		}
+		break;
+
+	case FB_VISUAL_STATIC_PSEUDOCOLOR:
+	case FB_VISUAL_PSEUDOCOLOR:
+		ret = imxfb_setpalettereg(regno, red, green, blue, trans, info);
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ *  imxfb_check_var():
+ *    Round up in the following order: bits_per_pixel, xres,
+ *    yres, xres_virtual, yres_virtual, xoffset, yoffset, grayscale,
+ *    bitfields, horizontal timing, vertical timing.
+ */
+static int
+imxfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
+{
+	struct imxfb_info *fbi = (struct imxfb_info *)info;
+	int rgbidx;
+
+	if (var->xres < MIN_XRES)
+		var->xres = MIN_XRES;
+	if (var->yres < MIN_YRES)
+		var->yres = MIN_YRES;
+	if (var->xres > fbi->max_xres)
+		var->xres = fbi->max_xres;
+	if (var->yres > fbi->max_yres)
+		var->yres = fbi->max_yres;
+	var->xres_virtual = max(var->xres_virtual, var->xres);
+	var->yres_virtual = max(var->yres_virtual, var->yres);
+
+	pr_debug("var->bits_per_pixel=%d\n", var->bits_per_pixel);
+	switch (var->bits_per_pixel) {
+	case 16:
+		rgbidx = RGB_16;
+		break;
+	case 8:
+		rgbidx = RGB_8;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * Copy the RGB parameters for this display
+	 * from the machine specific parameters.
+	 */
+	var->red    = fbi->rgb[rgbidx]->red;
+	var->green  = fbi->rgb[rgbidx]->green;
+	var->blue   = fbi->rgb[rgbidx]->blue;
+	var->transp = fbi->rgb[rgbidx]->transp;
+
+	pr_debug("RGBT length = %d:%d:%d:%d\n",
+		var->red.length, var->green.length, var->blue.length,
+		var->transp.length);
+
+	pr_debug("RGBT offset = %d:%d:%d:%d\n",
+		var->red.offset, var->green.offset, var->blue.offset,
+		var->transp.offset);
+
+	return 0;
+}
+
+/*
+ * imxfb_set_par():
+ *	Set the user defined part of the display for the specified console
+ */
+static int imxfb_set_par(struct fb_info *info)
+{
+	struct imxfb_info *fbi = (struct imxfb_info *)info;
+	struct fb_var_screeninfo *var = &info->var;
+
+	pr_debug("set_par\n");
+
+	if (var->bits_per_pixel == 16)
+		fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
+	else if (!fbi->cmap_static)
+		fbi->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
+	else {
+		/*
+		 * Some people have weird ideas about wanting static
+		 * pseudocolor maps.  I suspect their user space
+		 * applications are broken.
+		 */
+		fbi->fb.fix.visual = FB_VISUAL_STATIC_PSEUDOCOLOR;
+	}
+
+	fbi->fb.fix.line_length = var->xres_virtual *
+				  var->bits_per_pixel / 8;
+	fbi->palette_size = var->bits_per_pixel == 8 ? 256 : 16;
+
+	imxfb_activate_var(var, fbi);
+
+	return 0;
+}
+
+/*
+ * Formal definition of the VESA spec:
+ *  On
+ *  	This refers to the state of the display when it is in full operation
+ *  Stand-By
+ *  	This defines an optional operating state of minimal power reduction with
+ *  	the shortest recovery time
+ *  Suspend
+ *  	This refers to a level of power management in which substantial power
+ *  	reduction is achieved by the display.  The display can have a longer 
+ *  	recovery time from this state than from the Stand-by state
+ *  Off
+ *  	This indicates that the display is consuming the lowest level of power
+ *  	and is non-operational. Recovery from this state may optionally require
+ *  	the user to manually power on the monitor
+ *
+ *  Now, the fbdev driver adds an additional state, (blank), where they
+ *  turn off the video (maybe by colormap tricks), but don't mess with the
+ *  video itself: think of it semantically between on and Stand-By.
+ *
+ *  So here's what we should do in our fbdev blank routine:
+ *
+ *  	VESA_NO_BLANKING (mode 0)	Video on,  front/back light on
+ *  	VESA_VSYNC_SUSPEND (mode 1)  	Video on,  front/back light off
+ *  	VESA_HSYNC_SUSPEND (mode 2)  	Video on,  front/back light off
+ *  	VESA_POWERDOWN (mode 3)		Video off, front/back light off
+ *
+ *  This will match the matrox implementation.
+ */
+/*
+ * imxfb_blank():
+ *	Blank the display by setting all palette values to zero.  Note, the
+ * 	12 and 16 bpp modes don't really use the palette, so this will not
+ *      blank the display in all modes.  
+ */
+static int imxfb_blank(int blank, struct fb_info *info)
+{
+	struct imxfb_info *fbi = (struct imxfb_info *)info;
+	int i;
+
+	pr_debug("imxfb_blank: blank=%d\n", blank);
+
+	switch (blank) {
+	case VESA_POWERDOWN:
+	case VESA_VSYNC_SUSPEND:
+	case VESA_HSYNC_SUSPEND:
+		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
+		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
+			for (i = 0; i < fbi->palette_size; i++)
+				imxfb_setpalettereg(i, 0, 0, 0, 0, info);
+		imxfb_schedule_work(fbi, C_DISABLE);
+		break;
+
+	case VESA_NO_BLANKING:
+		if (fbi->fb.fix.visual == FB_VISUAL_PSEUDOCOLOR ||
+		    fbi->fb.fix.visual == FB_VISUAL_STATIC_PSEUDOCOLOR)
+			fb_set_cmap(&fbi->fb.cmap, info);
+		imxfb_schedule_work(fbi, C_ENABLE);
+	}
+	return 0;
+}
+
+static struct fb_ops imxfb_ops = {
+	.owner		= THIS_MODULE,
+	.fb_check_var	= imxfb_check_var,
+	.fb_set_par	= imxfb_set_par,
+	.fb_setcolreg	= imxfb_setcolreg,
+	.fb_fillrect	= cfb_fillrect,
+	.fb_copyarea	= cfb_copyarea,
+	.fb_imageblit	= cfb_imageblit,
+	.fb_blank	= imxfb_blank,
+	.fb_cursor	= soft_cursor, /* FIXME: i.MX can do hardware cursor */
+};
+
+/*
+ * imxfb_activate_var():
+ *	Configures LCD Controller based on entries in var parameter.  Settings are
+ *	only written to the controller if changes were made.
+ */
+static int imxfb_activate_var(struct fb_var_screeninfo *var, struct imxfb_info *fbi)
+{
+	pr_debug("var: xres=%d hslen=%d lm=%d rm=%d\n",
+		var->xres, var->hsync_len,
+		var->left_margin, var->right_margin);
+	pr_debug("var: yres=%d vslen=%d um=%d bm=%d\n",
+		var->yres, var->vsync_len,
+		var->upper_margin, var->lower_margin);
+
+#if DEBUG_VAR
+	if (var->xres < 16        || var->xres > 1024)
+		printk(KERN_ERR "%s: invalid xres %d\n",
+			fbi->fb.fix.id, var->xres);
+	if (var->hsync_len < 1    || var->hsync_len > 64)
+		printk(KERN_ERR "%s: invalid hsync_len %d\n",
+			fbi->fb.fix.id, var->hsync_len);
+	if (var->left_margin > 255)
+		printk(KERN_ERR "%s: invalid left_margin %d\n",
+			fbi->fb.fix.id, var->left_margin);
+	if (var->right_margin > 255)
+		printk(KERN_ERR "%s: invalid right_margin %d\n",
+			fbi->fb.fix.id, var->right_margin);
+	if (var->yres < 1 || var->yres > 511)
+		printk(KERN_ERR "%s: invalid yres %d\n",
+			fbi->fb.fix.id, var->yres);
+	if (var->vsync_len > 100)
+		printk(KERN_ERR "%s: invalid vsync_len %d\n",
+			fbi->fb.fix.id, var->vsync_len);
+	if (var->upper_margin > 63)
+		printk(KERN_ERR "%s: invalid upper_margin %d\n",
+			fbi->fb.fix.id, var->upper_margin);
+	if (var->lower_margin > 255)
+		printk(KERN_ERR "%s: invalid lower_margin %d\n",
+			fbi->fb.fix.id, var->lower_margin);
+#endif
+
+	LCDC_HCR	= HCR_H_WIDTH(var->hsync_len) |
+	                  HCR_H_WAIT_1(var->left_margin) |
+			  HCR_H_WAIT_2(var->right_margin);
+
+	LCDC_VCR	= VCR_V_WIDTH(var->vsync_len) |
+	                  VCR_V_WAIT_1(var->upper_margin) |
+			  VCR_V_WAIT_2(var->lower_margin);
+
+	LCDC_SIZE	= SIZE_XMAX(var->xres) | SIZE_YMAX(var->yres);
+	LCDC_PCR	= fbi->pcr;
+	LCDC_PWMR	= fbi->pwmr;
+	LCDC_LSCR1	= fbi->lscr1;
+
+	imxfb_schedule_work(fbi, C_REENABLE);
+
+	return 0;
+}
+
+static void imxfb_setup_gpio(struct imxfb_info *fbi)
+{
+	int width;
+
+	LCDC_RMCR	&= ~(RMCR_LCDC_EN | RMCR_SELF_REF);
+
+	if( fbi->pcr & PCR_TFT )
+		width = 16;
+	else
+		width = 1 << ((fbi->pcr >> 28) & 0x3);
+	
+	switch(width) {
+	case 16:
+		imx_gpio_mode(PD30_PF_LD15);
+		imx_gpio_mode(PD29_PF_LD14);
+		imx_gpio_mode(PD28_PF_LD13);
+		imx_gpio_mode(PD27_PF_LD12);
+		imx_gpio_mode(PD26_PF_LD11);
+		imx_gpio_mode(PD25_PF_LD10);
+		imx_gpio_mode(PD24_PF_LD9);
+		imx_gpio_mode(PD23_PF_LD8);
+	case 8:
+		imx_gpio_mode(PD22_PF_LD7);
+		imx_gpio_mode(PD21_PF_LD6);
+		imx_gpio_mode(PD20_PF_LD5);
+		imx_gpio_mode(PD19_PF_LD4);
+	case 4:
+		imx_gpio_mode(PD18_PF_LD3);
+		imx_gpio_mode(PD17_PF_LD2);
+	case 2:
+		imx_gpio_mode(PD16_PF_LD1);
+	case 1:
+		imx_gpio_mode(PD15_PF_LD0);
+	}
+
+	/* initialize GPIOs */
+	imx_gpio_mode(PD6_PF_LSCLK);
+	imx_gpio_mode(PD10_PF_SPL_SPR);
+	imx_gpio_mode(PD11_PF_CONTRAST);
+	imx_gpio_mode(PD14_PF_FLM_VSYNC);
+	imx_gpio_mode(PD13_PF_LP_HSYNC);
+	imx_gpio_mode(PD7_PF_REV);
+	imx_gpio_mode(PD8_PF_CLS);
+
+#ifndef CONFIG_MACH_PIMX1
+	/* on PiMX1 used as buffers enable signal
+	 */
+	imx_gpio_mode(PD9_PF_PS);
+#endif	
+
+#ifndef CONFIG_MACH_MX1FS2
+	/* on mx1fs2 this pin is used to (de)activate the display, so we need
+	 * it as a normal gpio
+	 */
+	imx_gpio_mode(PD12_PF_ACD_OE);
+#endif
+
+}
+
+static void imxfb_enable_controller(struct imxfb_info *fbi)
+{
+	pr_debug("Enabling LCD controller\n");
+
+	/* initialize LCDC */
+	LCDC_RMCR &= ~RMCR_LCDC_EN;		/* just to be safe... */
+
+	LCDC_SSA	= fbi->screen_dma;
+	/* physical screen start address	    */
+	LCDC_VPW	= VPW_VPW(fbi->max_xres * fbi->max_bpp / 8 / 4);
+
+	LCDC_POS	= 0x00000000;   /* panning offset 0 (0 pixel offset)        */
+
+	/* disable hardware cursor */
+	LCDC_CPOS	&= ~(CPOS_CC0 | CPOS_CC1);
+
+	/* fixed burst length (see erratum 11) */
+	LCDC_DMACR = DMACR_BURST | DMACR_HM(8) | DMACR_TM(2);
+
+	LCDC_RMCR = RMCR_LCDC_EN;
+}
+
+static void imxfb_disable_controller(struct imxfb_info *fbi)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	pr_debug("Disabling LCD controller\n");
+
+	add_wait_queue(&fbi->ctrlr_wait, &wait);
+	set_current_state(TASK_UNINTERRUPTIBLE);
+
+	/* LCD off */
+	if(fbi->lcd_power)
+		fbi->lcd_power(0);
+
+	LCDC_RMCR	=  0;
+
+	schedule_timeout(20 * HZ / 1000);
+	remove_wait_queue(&fbi->ctrlr_wait, &wait);
+}
+
+/*
+ * This function must be called from task context only, since it will
+ * sleep when disabling the LCD controller, or if we get two contending
+ * processes trying to alter state.
+ */
+static void set_ctrlr_state(struct imxfb_info *fbi, u_int state)
+{
+	u_int old_state;
+
+	down(&fbi->ctrlr_sem);
+
+	old_state = fbi->state;
+
+	/*
+	 * Hack around fbcon initialisation.
+	 */
+	if (old_state == C_STARTUP && state == C_REENABLE)
+		state = C_ENABLE;
+
+	switch (state) {
+	case C_DISABLE_CLKCHANGE:
+		/*
+		 * Disable controller for clock change.  If the
+		 * controller is already disabled, then do nothing.
+		 */
+		if (old_state != C_DISABLE && old_state != C_DISABLE_PM) {
+			fbi->state = state;
+			imxfb_disable_controller(fbi);
+		}
+		break;
+
+	case C_DISABLE_PM:
+	case C_DISABLE:
+		/*
+		 * Disable controller
+		 */
+		if (old_state != C_DISABLE) {
+			fbi->state = state;
+
+			if(fbi->backlight_power)
+				fbi->backlight_power(0);
+			if(fbi->lcd_power)
+				fbi->lcd_power(0);
+			if (old_state != C_DISABLE_CLKCHANGE)
+				imxfb_disable_controller(fbi);
+		}
+		break;
+
+	case C_ENABLE_CLKCHANGE:
+		/*
+		 * Enable the controller after clock change.  Only
+		 * do this if we were disabled for the clock change.
+		 */
+		if (old_state == C_DISABLE_CLKCHANGE) {
+			fbi->state = C_ENABLE;
+			imxfb_enable_controller(fbi);
+		}
+		break;
+
+	case C_REENABLE:
+		/*
+		 * Re-enable the controller only if it was already
+		 * enabled.  This is so we reprogram the control
+		 * registers.
+		 */
+		if (old_state == C_ENABLE) {
+			imxfb_disable_controller(fbi);
+			imxfb_setup_gpio(fbi);
+			imxfb_enable_controller(fbi);
+		}
+		break;
+
+	case C_ENABLE_PM:
+		/*
+		 * Re-enable the controller after PM.  This is not
+		 * perfect - think about the case where we were doing
+		 * a clock change, and we suspended half-way through.
+		 */
+		if (old_state != C_DISABLE_PM)
+			break;
+		/* fall through */
+
+	case C_ENABLE:
+		/*
+		 * Power up the LCD screen, enable controller, and
+		 * turn on the backlight.
+		 */
+		if (old_state != C_ENABLE) {
+			fbi->state = C_ENABLE;
+			imxfb_setup_gpio(fbi);
+			imxfb_enable_controller(fbi);
+			if(fbi->backlight_power)
+				fbi->backlight_power(1);
+			if(fbi->lcd_power)
+				fbi->lcd_power(1);
+		}
+		break;
+	}
+	up(&fbi->ctrlr_sem);
+}
+
+/*
+ * Our LCD controller task (which is called when we blank or unblank)
+ * via keventd.
+ */
+static void imxfb_task(void *dummy)
+{
+	struct imxfb_info *fbi = dummy;
+	u_int state = xchg(&fbi->task_state, -1);
+
+	set_ctrlr_state(fbi, state);
+}
+
+#ifdef CONFIG_PM
+/*
+ * Power management hooks.  Note that we won't be called from IRQ context,
+ * unlike the blank functions above, so we may sleep.
+ */
+static int imxfb_suspend(struct device *dev, u32 state, u32 level)
+{
+	struct imxfb_info *fbi = dev_get_drvdata(dev);
+	pr_debug("%s\n",__FUNCTION__);
+
+	if (level == SUSPEND_DISABLE || level == SUSPEND_POWER_DOWN)
+		set_ctrlr_state(fbi, C_DISABLE_PM);
+	return 0;
+}
+
+static int imxfb_resume(struct device *dev, u32 level)
+{
+	struct imxfb_info *fbi = dev_get_drvdata(dev);
+	pr_debug("%s\n",__FUNCTION__);
+
+	if (level == RESUME_ENABLE)
+		set_ctrlr_state(fbi, C_ENABLE_PM);
+	return 0;
+}
+#else
+#define imxfb_suspend	NULL
+#define imxfb_resume		NULL
+#endif
+
+static struct imxfb_info * __init imxfb_init_fbinfo(struct device *dev)
+{
+	struct imxfb_mach_info *inf = dev->platform_data;
+	struct imxfb_info *fbi;
+
+	pr_debug("%s\n",__FUNCTION__);
+
+	/* Alloc the imxfb_info and pseudo_palette in one step */
+	fbi = kmalloc(sizeof(struct imxfb_info) + sizeof(u32) * 16,
+		      GFP_KERNEL);
+	if (!fbi)
+		return NULL;
+
+	memset(fbi, 0, sizeof(struct imxfb_info));
+	fbi->dev = dev;
+
+	strcpy(fbi->fb.fix.id, IMX_NAME);
+
+	fbi->fb.fix.type	= FB_TYPE_PACKED_PIXELS;
+	fbi->fb.fix.type_aux	= 0;
+	fbi->fb.fix.xpanstep	= 0;
+	fbi->fb.fix.ypanstep	= 0;
+	fbi->fb.fix.ywrapstep	= 0;
+	fbi->fb.fix.accel	= FB_ACCEL_NONE;
+
+	fbi->fb.var.nonstd	= 0;
+	fbi->fb.var.activate	= FB_ACTIVATE_NOW;
+	fbi->fb.var.height	= -1;
+	fbi->fb.var.width	= -1;
+	fbi->fb.var.accel_flags	= 0;
+	fbi->fb.var.vmode	= FB_VMODE_NONINTERLACED;
+
+	fbi->fb.fbops		= &imxfb_ops;
+	fbi->fb.flags		= FBINFO_FLAG_DEFAULT;
+	fbi->fb.pseudo_palette	= (fbi + 1);
+
+	fbi->rgb[RGB_16]	= &def_rgb_16;
+	fbi->rgb[RGB_8]		= &def_rgb_8;
+
+	fbi->max_xres			= inf->xres;
+	fbi->fb.var.xres		= inf->xres;
+	fbi->fb.var.xres_virtual	= inf->xres;
+	fbi->max_yres			= inf->yres;
+	fbi->fb.var.yres		= inf->yres;
+	fbi->fb.var.yres_virtual	= inf->yres;
+	fbi->max_bpp			= inf->bpp;
+	fbi->fb.var.bits_per_pixel	= inf->bpp;
+	fbi->fb.var.pixclock		= inf->pixclock;
+	fbi->fb.var.hsync_len		= inf->hsync_len;
+	fbi->fb.var.left_margin		= inf->left_margin;
+	fbi->fb.var.right_margin	= inf->right_margin;
+	fbi->fb.var.vsync_len		= inf->vsync_len;
+	fbi->fb.var.upper_margin	= inf->upper_margin;
+	fbi->fb.var.lower_margin	= inf->lower_margin;
+	fbi->fb.var.sync		= inf->sync;
+	fbi->fb.var.grayscale		= inf->cmap_greyscale;
+	fbi->cmap_inverse		= inf->cmap_inverse;
+	fbi->pcr			= inf->pcr;
+	fbi->lscr1			= inf->lscr1;
+	fbi->pwmr			= inf->pwmr;
+	fbi->lcd_power			= inf->lcd_power;
+	fbi->backlight_power		= inf->backlight_power;
+	fbi->state			= C_STARTUP;
+	fbi->task_state			= (u_char)-1;
+	fbi->fb.fix.smem_len		= fbi->max_xres * fbi->max_yres *
+					  fbi->max_bpp / 8;
+
+	init_waitqueue_head(&fbi->ctrlr_wait);
+	INIT_WORK(&fbi->task, imxfb_task, fbi);
+	init_MUTEX(&fbi->ctrlr_sem);
+
+	imxfb_set_par((struct fb_info*)fbi);
+	imxfb_schedule_work(fbi, C_REENABLE);
+
+	return fbi;
+}
+
+/*
+ *      Allocates the DRAM memory for the frame buffer.  This buffer is  
+ *	remapped into a non-cached, non-buffered, memory region to  
+ *      allow pixel writes to occur without flushing the cache.
+ *      Once this area is remapped, all virtual memory access to the
+ *      video memory should occur at the new region.
+ */
+static int __init imxfb_map_video_memory(struct imxfb_info *fbi)
+{
+	fbi->map_size = PAGE_ALIGN(fbi->fb.fix.smem_len);
+	fbi->map_cpu = dma_alloc_writecombine(fbi->dev, fbi->map_size,
+					&fbi->map_dma,GFP_KERNEL);
+
+	if (fbi->map_cpu) {
+		fbi->fb.screen_base = fbi->map_cpu;
+		fbi->screen_cpu = fbi->map_cpu;
+		fbi->screen_dma = fbi->map_dma;
+		fbi->fb.fix.smem_start = fbi->screen_dma;
+	}
+
+	return fbi->map_cpu ? 0 : -ENOMEM;
+}
+
+static int __init imxfb_probe(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imxfb_info *fbi;
+	struct imxfb_mach_info *inf;
+	struct resource *res;
+	int ret;
+
+	printk("i.MX Framebuffer driver\n");
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	inf = dev->platform_data;
+	if(!inf) {
+		dev_err(dev,"No platform_data available\n");
+		return -ENOMEM;
+	}
+
+	fbi = imxfb_init_fbinfo(dev);
+	if (!fbi) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+
+	res = request_mem_region(res->start, res->end - res->start, "IMXFB");
+	if (!res) {
+		ret = -EBUSY;
+		goto failed;
+	}
+	
+	if (!inf->fixed_screen_cpu) {
+		ret = imxfb_map_video_memory(fbi);
+		if (ret) {
+			dev_err(dev, "Failed to allocate video RAM: %d\n", ret);
+			ret = -ENOMEM;
+			goto failed;
+		}
+	} else {
+		/* Fixed framebuffer mapping enables location of the screen in eSRAM */
+		fbi->map_cpu = inf->fixed_screen_cpu;
+		fbi->map_dma = inf->fixed_screen_dma;
+		fbi->fb.screen_base = fbi->map_cpu;
+		fbi->screen_cpu = fbi->map_cpu;
+		fbi->screen_dma = fbi->map_dma;
+		fbi->fb.fix.smem_start = fbi->screen_dma;
+	}
+
+	/*
+	 * This makes sure that our colour bitfield
+	 * descriptors are correctly initialised.
+	 */
+	imxfb_check_var(&fbi->fb.var, &fbi->fb);
+
+	fb_alloc_cmap(&fbi->fb.cmap, 1<<fbi->fb.var.bits_per_pixel, 0);
+
+	dev_set_drvdata(dev, fbi);
+
+	ret = register_framebuffer(&fbi->fb);
+	if (ret < 0) {
+		dev_err(dev, "failed to register framebuffer\n");
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	dev_set_drvdata(dev, NULL);
+	if (fbi)
+		kfree(fbi);
+	release_resource(res);
+	return ret;
+}
+
+static int imxfb_remove(struct device *dev)
+{
+	struct imxfb_info *fbi = dev_get_drvdata(dev);
+
+	/* disable LCD controller */
+	LCDC_RMCR &= ~RMCR_LCDC_EN;
+
+	unregister_framebuffer(&fbi->fb);
+
+	if (fbi)
+		kfree(fbi);
+
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+void  imxfb_shutdown(struct device * dev)
+{
+	/* disable LCD Controller */
+	LCDC_RMCR &= ~RMCR_LCDC_EN;
+}
+
+static struct device_driver imxfb_driver = {
+	.name		= "imx-fb",
+	.bus		= &platform_bus_type,
+	.probe		= imxfb_probe,
+	.suspend	= imxfb_suspend,
+	.resume		= imxfb_resume,
+	.remove		= imxfb_remove,
+	.shutdown	= imxfb_shutdown,
+};
+
+int __init imxfb_init(void)
+{
+	return driver_register(&imxfb_driver);
+}
+
+static void __exit imxfb_cleanup(void)
+{
+	driver_unregister(&imxfb_driver);
+}
+
+module_init(imxfb_init);
+module_exit(imxfb_cleanup);
+
+MODULE_DESCRIPTION("Motorola i.MX framebuffer driver");
+MODULE_AUTHOR("Sascha Hauer, Pengutronix");
+MODULE_LICENSE("GPL");
--- linux-2.6.11/drivers/video/imxfb.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-work/drivers/video/imxfb.h	2005-03-17 17:04:38.000000000 +0100
@@ -0,0 +1,94 @@
+/*
+ * linux/drivers/video/imxfb.h
+ *    -- Motorola i.MX frame buffer driver
+ *
+ *  Copyright (C) 2004 S.Hauer, Pengutronix
+ *
+ *  Copyright (C) 1999 Eric A. Thomas
+ *   Based on acornfb.c Copyright (C) Russell King.
+ *  
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+/*
+ * These are the bitfields for each
+ * display depth that we support.
+ */
+struct imxfb_rgb {
+	struct fb_bitfield	red;
+	struct fb_bitfield	green;
+	struct fb_bitfield	blue;
+	struct fb_bitfield	transp;
+};
+
+#define RGB_16	(0)
+#define RGB_8	(1)
+#define NR_RGB	2
+
+struct imxfb_info {
+	struct fb_info		fb;
+	struct device		*dev;
+	struct imxfb_rgb	*rgb[NR_RGB];
+
+	u_int			max_bpp;
+	u_int			max_xres;
+	u_int			max_yres;
+
+	/*
+	 * These are the addresses we mapped
+	 * the framebuffer memory region to.
+	 */
+	dma_addr_t		map_dma;
+	u_char *		map_cpu;
+	u_int			map_size;
+
+	u_char *		screen_cpu;
+	dma_addr_t		screen_dma;
+	u_int			palette_size;
+
+	dma_addr_t		dbar1;
+	dma_addr_t		dbar2;
+
+	u_int			pcr;
+	u_int			pwmr;
+	u_int			lscr1;
+	u_int			cmap_inverse:1,
+				cmap_static:1,
+				unused:30;
+
+	volatile u_char		state;
+	volatile u_char		task_state;
+	struct semaphore	ctrlr_sem;
+	wait_queue_head_t	ctrlr_wait;
+	struct work_struct	task;
+
+	void (*lcd_power)(int);
+	void (*backlight_power)(int);
+#ifdef CONFIG_CPU_FREQ
+	struct notifier_block	freq_transition;
+	struct notifier_block	freq_policy;
+#endif
+};
+
+/*
+ * These are the actions for set_ctrlr_state
+ */
+#define C_DISABLE		(0)
+#define C_ENABLE		(1)
+#define C_DISABLE_CLKCHANGE	(2)
+#define C_ENABLE_CLKCHANGE	(3)
+#define C_REENABLE		(4)
+#define C_DISABLE_PM		(5)
+#define C_ENABLE_PM		(6)
+#define C_STARTUP		(7)
+
+#define IMX_NAME	"IMX"
+
+/*
+ * Minimum X and Y resolutions
+ */
+#define MIN_XRES	64
+#define MIN_YRES	64
+

--bp/iNruPH9dso1Pn--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
