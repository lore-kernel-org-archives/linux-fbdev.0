From: Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH] au1100fb framebuffer fixes
Date: Fri, 14 Oct 2005 22:58:42 +0100
Message-ID: <20051014215842.GA3381@linux-mips.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERRyB-0004Fb-1p
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Oct 2005 03:11:51 -0700
Received: from extgw-uk.mips.com ([62.254.210.129] helo=bacchus.net.dhis.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1ERRy9-0000pm-Mg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Oct 2005 03:11:50 -0700
Resent-Message-Id: <200510142228.j9EMS94w014111@dea.linux-mips.net>
Content-Disposition: inline
Resent-To: linux-fbdev-devel@lists.sourceforge.net,
	Andrew Morton <akpm@osdl.org>
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
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>

For reviewing pleassure.  If nobody objects I'd like to submit this one
as part of my pile of MIPS patches.  The au1100fb driver is the driver
for the AMD Alchemy SOCs.

  Ralf

Author: Pete Popov <ppopov@embeddedalley.com>
Date:   Mon Apr 4 01:06:19 2005 +0000

    Au1100 FB driver uplift for 2.6.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Index: manual.git/arch/mips/au1000/common/platform.c
===================================================================
--- manual.git.orig/arch/mips/au1000/common/platform.c
+++ manual.git/arch/mips/au1000/common/platform.c
@@ -41,8 +41,42 @@ static struct platform_device au1xxx_usb
 	.resource	= au1xxx_usb_ohci_resources,
 };
 
+/*** AU1100 LCD controller ***/
+
+#ifdef CONFIG_FB_AU1100
+static struct resource au1100_lcd_resources[] = {
+	[0] = {
+		.start          = LCD_PHYS_ADDR,
+		.end            = LCD_PHYS_ADDR + 0x800 - 1,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start          = AU1100_LCD_INT,
+		.end            = AU1100_LCD_INT,
+		.flags          = IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1100_lcd_dmamask = ~(u32)0;
+
+static struct platform_device au1100_lcd_device = {
+	.name           = "au1100-lcd",
+	.id             = 0,
+	.dev = {
+		.dma_mask               = &au1100_lcd_dmamask,
+		.coherent_dma_mask      = 0xffffffff,
+	},
+	.num_resources  = ARRAY_SIZE(au1100_lcd_resources),
+	.resource       = au1100_lcd_resources,
+};
+#endif
+
+
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
 	&au1xxx_usb_ohci_device,
+#ifdef CONFIG_FB_AU1100
+	&au1100_lcd_device,
+#endif
 };
 
 int au1xxx_platform_init(void)
Index: manual.git/arch/mips/au1000/common/setup.c
===================================================================
--- manual.git.orig/arch/mips/au1000/common/setup.c
+++ manual.git/arch/mips/au1000/common/setup.c
@@ -106,8 +106,6 @@ void __init plat_setup(void)
         /*strcat(argptr, " video=au1100fb:panel:Sharp_320x240_16");*/
 #ifdef CONFIG_MIPS_HYDROGEN3
          strcat(argptr, " video=au1100fb:panel:Hydrogen_3_NEC_panel_320x240,nohwcursor");
-#else
-        strcat(argptr, " video=au1100fb:panel:s10,nohwcursor");
 #endif
     }
 #endif
Index: manual.git/drivers/video/Makefile
===================================================================
--- manual.git.orig/drivers/video/Makefile
+++ manual.git/drivers/video/Makefile
@@ -86,7 +86,7 @@ obj-$(CONFIG_FB_CIRRUS)		  += cirrusfb.o
 obj-$(CONFIG_FB_ASILIANT)	  += asiliantfb.o
 obj-$(CONFIG_FB_PXA)		  += pxafb.o
 obj-$(CONFIG_FB_W100)		  += w100fb.o
-obj-$(CONFIG_FB_AU1100)		  += au1100fb.o fbgen.o
+obj-$(CONFIG_FB_AU1100)		  += au1100fb.o
 obj-$(CONFIG_FB_PMAG_AA)	  += pmag-aa-fb.o
 obj-$(CONFIG_FB_PMAG_BA)	  += pmag-ba-fb.o
 obj-$(CONFIG_FB_PMAGB_B)	  += pmagb-b-fb.o
Index: manual.git/drivers/video/au1100fb.c
===================================================================
--- manual.git.orig/drivers/video/au1100fb.c
+++ manual.git/drivers/video/au1100fb.c
@@ -2,6 +2,11 @@
  * BRIEF MODULE DESCRIPTION
  *	Au1100 LCD Driver.
  *
+ * Rewritten for 2.6 by Embedded Alley Solutions
+ * 	<source@embeddedalley.com>, based on submissions by
+ *  	Karl Lessard <klessard@sunrisetelecom.com>
+ *  	<c.pellegrin@exadron.com>
+ *
  * Copyright 2002 MontaVista Software
  * Author: MontaVista Software, Inc.
  *		ppopov@mvista.com or source@mvista.com
@@ -33,298 +38,253 @@
  *  with this program; if not, write  to the Free Software Foundation, Inc.,
  *  675 Mass Ave, Cambridge, MA 02139, USA.
  */
-
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
 #include <linux/fb.h>
 #include <linux/init.h>
-#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/ctype.h>
+#include <linux/dma-mapping.h>
 
-#include <asm/au1000.h>
-#include <asm/pb1100.h>
-#include "au1100fb.h"
+#include <asm/mach-au1x00/au1000.h>
 
-#include <video/fbcon.h>
-#include <video/fbcon-mfb.h>
-#include <video/fbcon-cfb2.h>
-#include <video/fbcon-cfb4.h>
-#include <video/fbcon-cfb8.h>
-#include <video/fbcon-cfb16.h>
+#define DEBUG 0
+
+#include "au1100fb.h"
 
 /*
  * Sanity check. If this is a new Au1100 based board, search for
  * the PB1100 ifdefs to make sure you modify the code accordingly.
  */
-#if defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100) || defined(CONFIG_MIPS_HYDROGEN3)
+#if defined(CONFIG_MIPS_PB1100)
+  #include <asm/mach-pb1x00/pb1100.h>
+#elif defined(CONFIG_MIPS_DB1100)
+  #include <asm/mach-db1x00/db1x00.h>
 #else
-error Unknown Au1100 board
+  #error "Unknown Au1100 board, Au1100 FB driver not supported"
 #endif
 
-#define CMAPSIZE 16
+#define DRIVER_NAME "au1100fb"
+#define DRIVER_DESC "LCD controller driver for AU1100 processors"
 
-static int my_lcd_index; /* default is zero */
-struct known_lcd_panels *p_lcd;
-AU1100_LCD *p_lcd_reg = (AU1100_LCD *)AU1100_LCD_ADDR;
-
-struct au1100fb_info {
-	struct fb_info_gen gen;
-	unsigned long fb_virt_start;
-	unsigned long fb_size;
-	unsigned long fb_phys;
-	int mmaped;
-	int nohwcursor;
+#define to_au1100fb_device(_info) \
+	  (_info ? container_of(_info, struct au1100fb_device, info) : NULL);
 
-	struct { unsigned red, green, blue, pad; } palette[256];
+/* Bitfields format supported by the controller. Note that the order of formats
+ * SHOULD be the same as in the LCD_CONTROL_SBPPF field, so we can retrieve the
+ * right pixel format by doing rgb_bitfields[LCD_CONTROL_SBPPF_XXX >> LCD_CONTROL_SBPPF]
+ */
+struct fb_bitfield rgb_bitfields[][4] =
+{
+  	/*     Red, 	   Green, 	 Blue, 	     Transp   */
+	{ { 10, 6, 0 }, { 5, 5, 0 }, { 0, 5, 0 }, { 0, 0, 0 } },
+	{ { 11, 5, 0 }, { 5, 6, 0 }, { 0, 5, 0 }, { 0, 0, 0 } },
+	{ { 11, 5, 0 }, { 6, 5, 0 }, { 0, 6, 0 }, { 0, 0, 0 } },
+	{ { 10, 5, 0 }, { 5, 5, 0 }, { 0, 5, 0 }, { 15, 1, 0 } },
+	{ { 11, 5, 0 }, { 6, 5, 0 }, { 1, 5, 0 }, { 0, 1, 0 } },
 
-#if defined(FBCON_HAS_CFB16)
-	u16 fbcon_cmap16[16];
-#endif
+	/* The last is used to describe 12bpp format */
+	{ { 8, 4, 0 },  { 4, 4, 0 }, { 0, 4, 0 }, { 0, 0, 0 } },
 };
 
-
-struct au1100fb_par {
-        struct fb_var_screeninfo var;
-
-	int line_length;  // in bytes
-	int cmap_len;     // color-map length
+static struct fb_fix_screeninfo au1100fb_fix __initdata = {
+	.id		= "AU1100 FB",
+	.xpanstep 	= 1,
+	.ypanstep 	= 1,
+	.type		= FB_TYPE_PACKED_PIXELS,
+	.accel		= FB_ACCEL_NONE,
 };
 
-
-static struct au1100fb_info fb_info;
-static struct au1100fb_par current_par;
-static struct display disp;
-
-int au1100fb_init(void);
-void au1100fb_setup(char *options, int *ints);
-static int au1100fb_mmap(struct fb_info *fb, struct file *file,
-		struct vm_area_struct *vma);
-static int au1100_blank(int blank_mode, struct fb_info_gen *info);
-static int au1100fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-			  u_long arg, int con, struct fb_info *info);
-
-void au1100_nocursor(struct display *p, int mode, int xx, int yy){};
-
-static struct fb_ops au1100fb_ops = {
-	.owner		= THIS_MODULE,
-	.fb_get_fix	= fbgen_get_fix,
-	.fb_get_var	= fbgen_get_var,
-	.fb_set_var	= fbgen_set_var,
-	.fb_get_cmap	= fbgen_get_cmap,
-	.fb_set_cmap	= fbgen_set_cmap,
-	.fb_pan_display	= fbgen_pan_display,
-        .fb_ioctl	= au1100fb_ioctl,
-	.fb_mmap	= au1100fb_mmap,
+static struct fb_var_screeninfo au1100fb_var __initdata = {
+	.activate	= FB_ACTIVATE_NOW,
+	.height		= -1,
+	.width		= -1,
+	.vmode		= FB_VMODE_NONINTERLACED,
 };
 
-static void au1100_detect(void)
-{
-	/*
-	 *  This function should detect the current video mode settings
-	 *  and store it as the default video mode
-	 */
+static struct au1100fb_drv_info drv_info;
 
-	/*
-	 * Yeh, well, we're not going to change any settings so we're
-	 * always stuck with the default ...
+/*
+ * Set hardware with var settings. This will enable the controller with a specific
+ * mode, normally validated with the fb_check_var method
 	 */
-
-}
-
-static int au1100_encode_fix(struct fb_fix_screeninfo *fix,
-		const void *_par, struct fb_info_gen *_info)
+int au1100fb_setmode(struct au1100fb_device *fbdev)
 {
-        struct au1100fb_info *info = (struct au1100fb_info *) _info;
-        struct au1100fb_par *par = (struct au1100fb_par *) _par;
-	struct fb_var_screeninfo *var = &par->var;
-
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-
-	fix->smem_start = info->fb_phys;
-	fix->smem_len = info->fb_size;
-	fix->type = FB_TYPE_PACKED_PIXELS;
-	fix->type_aux = 0;
-        fix->visual = (var->bits_per_pixel == 8) ?
-	       	FB_VISUAL_PSEUDOCOLOR	: FB_VISUAL_TRUECOLOR;
-	fix->ywrapstep = 0;
-	fix->xpanstep = 1;
-	fix->ypanstep = 1;
-	fix->line_length = current_par.line_length;
-	return 0;
-}
-
-static void set_color_bitfields(struct fb_var_screeninfo *var)
-{
-	switch (var->bits_per_pixel) {
-	case 8:
-		var->red.offset = 0;
-		var->red.length = 8;
-		var->green.offset = 0;
-		var->green.length = 8;
-		var->blue.offset = 0;
-		var->blue.length = 8;
-		var->transp.offset = 0;
-		var->transp.length = 0;
-		break;
-	case 16:	/* RGB 565 */
-		var->red.offset = 11;
-		var->red.length = 5;
-		var->green.offset = 5;
-		var->green.length = 6;
-		var->blue.offset = 0;
-		var->blue.length = 5;
-		var->transp.offset = 0;
-		var->transp.length = 0;
-		break;
-	}
+	struct fb_info *info = &fbdev->info;
+	u32 words;
+	int index;
 
-	var->red.msb_right = 0;
-	var->green.msb_right = 0;
-	var->blue.msb_right = 0;
-	var->transp.msb_right = 0;
-}
-
-static int au1100_decode_var(const struct fb_var_screeninfo *var,
-		void *_par, struct fb_info_gen *_info)
-{
-
-	struct au1100fb_par *par = (struct au1100fb_par *)_par;
-
-	/*
-	 * Don't allow setting any of these yet: xres and yres don't
-	 * make sense for LCD panels.
-	 */
-	if (var->xres != p_lcd->xres ||
-	    var->yres != p_lcd->yres ||
-	    var->xres != p_lcd->xres ||
-	    var->yres != p_lcd->yres) {
+	if (!fbdev)
 		return -EINVAL;
+
+	/* Update var-dependent FB info */
+	if (panel_is_active(fbdev->panel) || panel_is_color(fbdev->panel)) {
+		if (info->var.bits_per_pixel <= 8) {
+			/* palettized */
+			info->var.red.offset    = 0;
+			info->var.red.length    = info->var.bits_per_pixel;
+			info->var.red.msb_right = 0;
+
+			info->var.green.offset  = 0;
+			info->var.green.length  = info->var.bits_per_pixel;
+			info->var.green.msb_right = 0;
+
+			info->var.blue.offset   = 0;
+			info->var.blue.length   = info->var.bits_per_pixel;
+			info->var.blue.msb_right = 0;
+
+			info->var.transp.offset = 0;
+			info->var.transp.length = 0;
+			info->var.transp.msb_right = 0;
+
+			info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+			info->fix.line_length = info->var.xres_virtual /
+							(8/info->var.bits_per_pixel);
+		} else {
+			/* non-palettized */
+			index = (fbdev->panel->control_base & LCD_CONTROL_SBPPF_MASK) >> LCD_CONTROL_SBPPF_BIT;
+			info->var.red = rgb_bitfields[index][0];
+			info->var.green = rgb_bitfields[index][1];
+			info->var.blue = rgb_bitfields[index][2];
+			info->var.transp = rgb_bitfields[index][3];
+
+			info->fix.visual = FB_VISUAL_TRUECOLOR;
+			info->fix.line_length = info->var.xres_virtual << 1; /* depth=16 */
+	}
+	} else {
+		/* mono */
+		info->fix.visual = FB_VISUAL_MONO10;
+		info->fix.line_length = info->var.xres_virtual / 8;
+	}
+
+	info->screen_size = info->fix.line_length * info->var.yres_virtual;
+
+	/* Determine BPP mode and format */
+	fbdev->regs->lcd_control = fbdev->panel->control_base |
+			    ((info->var.rotate/90) << LCD_CONTROL_SM_BIT);
+
+	fbdev->regs->lcd_intenable = 0;
+	fbdev->regs->lcd_intstatus = 0;
+
+	fbdev->regs->lcd_horztiming = fbdev->panel->horztiming;
+
+	fbdev->regs->lcd_verttiming = fbdev->panel->verttiming;
+
+	fbdev->regs->lcd_clkcontrol = fbdev->panel->clkcontrol_base;
+
+	fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(fbdev->fb_phys);
+
+	if (panel_is_dual(fbdev->panel)) {
+		/* Second panel display seconf half of screen if possible,
+		 * otherwise display the same as the first panel */
+		if (info->var.yres_virtual >= (info->var.yres << 1)) {
+			fbdev->regs->lcd_dmaaddr1 = LCD_DMA_SA_N(fbdev->fb_phys +
+							  (info->fix.line_length *
+						          (info->var.yres_virtual >> 1)));
+		} else {
+			fbdev->regs->lcd_dmaaddr1 = LCD_DMA_SA_N(fbdev->fb_phys);
+		}
 	}
-	if(var->bits_per_pixel != p_lcd->bpp) {
-		return -EINVAL;
+
+	words = info->fix.line_length / sizeof(u32);
+	if (!info->var.rotate || (info->var.rotate == 180)) {
+		words *= info->var.yres_virtual;
+		if (info->var.rotate /* 180 */) {
+			words -= (words % 8); /* should be divisable by 8 */
+		}
 	}
+	fbdev->regs->lcd_words = LCD_WRD_WRDS_N(words);
 
-	memset(par, 0, sizeof(struct au1100fb_par));
-	par->var = *var;
+	fbdev->regs->lcd_pwmdiv = 0;
+	fbdev->regs->lcd_pwmhi = 0;
 
-	/* FIXME */
-	switch (var->bits_per_pixel) {
-		case 8:
-			par->var.bits_per_pixel = 8;
-			break;
-		case 16:
-			par->var.bits_per_pixel = 16;
-			break;
-		default:
-			printk("color depth %d bpp not supported\n",
-					var->bits_per_pixel);
-			return -EINVAL;
+	/* Resume controller */
+	fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 
-	}
-	set_color_bitfields(&par->var);
-	par->cmap_len = (par->var.bits_per_pixel == 8) ? 256 : 16;
 	return 0;
 }
 
-static int au1100_encode_var(struct fb_var_screeninfo *var,
-		const void *par, struct fb_info_gen *_info)
+/* fb_setcolreg
+ * Set color in LCD palette.
+ */
+int au1100fb_fb_setcolreg(unsigned regno, unsigned red, unsigned green, unsigned blue, unsigned transp, struct fb_info *fbi)
 {
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	u32 *palette = fbdev->regs->lcd_pallettebase;
+	u32 value;
 
-	*var = ((struct au1100fb_par *)par)->var;
-	return 0;
-}
-
-static void
-au1100_get_par(void *_par, struct fb_info_gen *_info)
-{
-	*(struct au1100fb_par *)_par = current_par;
-}
+	if (regno > (AU1100_LCD_NBR_PALETTE_ENTRIES - 1))
+		return -EINVAL;
 
-static void au1100_set_par(const void *par, struct fb_info_gen *info)
-{
-	/* nothing to do: we don't change any settings */
-}
+	if (fbi->var.grayscale) {
+		/* Convert color to grayscale */
+		red = green = blue =
+			(19595 * red + 38470 * green + 7471 * blue) >> 16;
+	}
 
-static int au1100_getcolreg(unsigned regno, unsigned *red, unsigned *green,
-			 unsigned *blue, unsigned *transp,
-			 struct fb_info *info)
-{
+	if (fbi->fix.visual == FB_VISUAL_TRUECOLOR) {
+		/* Place color in the pseudopalette */
+		if (regno > 16)
+			return -EINVAL;
 
-	struct au1100fb_info* i = (struct au1100fb_info*)info;
+		palette = (u32*)fbi->pseudo_palette;
 
-	if (regno > 255)
-		return 1;
+		red   >>= (16 - fbi->var.red.length);
+		green >>= (16 - fbi->var.green.length);
+		blue  >>= (16 - fbi->var.blue.length);
+
+		value = (red   << fbi->var.red.offset) 	|
+			(green << fbi->var.green.offset)|
+			(blue  << fbi->var.blue.offset);
+		value &= 0xFFFF;
+
+	} else if (panel_is_active(fbdev->panel)) {
+		/* COLOR TFT PALLETTIZED (use RGB 565) */
+		value = (red & 0xF800)|((green >> 5) & 0x07E0)|((blue >> 11) & 0x001F);
+		value &= 0xFFFF;
+
+	} else if (panel_is_color(fbdev->panel)) {
+		/* COLOR STN MODE */
+		value = (((panel_swap_rgb(fbdev->panel) ? blue : red) >> 12) & 0x000F) |
+			((green >> 8) & 0x00F0) |
+			(((panel_swap_rgb(fbdev->panel) ? red : blue) >> 4) & 0x0F00);
+		value &= 0xFFF;
+	} else {
+		/* MONOCHROME MODE */
+		value = (green >> 12) & 0x000F;
+		value &= 0xF;
+	}
 
-	*red    = i->palette[regno].red;
-	*green  = i->palette[regno].green;
-	*blue   = i->palette[regno].blue;
-	*transp = 0;
+	palette[regno] = value;
 
 	return 0;
 }
 
-static int au1100_setcolreg(unsigned regno, unsigned red, unsigned green,
-			 unsigned blue, unsigned transp,
-			 struct fb_info *info)
+/* fb_blank
+ * Blank the screen. Depending on the mode, the screen will be
+ * activated with the backlight color, or desactivated
+ */
+int au1100fb_fb_blank(int blank_mode, struct fb_info *fbi)
 {
-	struct au1100fb_info* i = (struct au1100fb_info *)info;
-	u32 rgbcol;
-
-	if (regno > 255)
-		return 1;
-
-	i->palette[regno].red    = red;
-	i->palette[regno].green  = green;
-	i->palette[regno].blue   = blue;
-
-	switch(p_lcd->bpp) {
-#ifdef FBCON_HAS_CFB8
-	case 8:
-		red >>= 10;
-		green >>= 10;
-		blue >>= 10;
-		p_lcd_reg->lcd_pallettebase[regno] = (blue&0x1f) |
-			((green&0x3f)<<5) | ((red&0x1f)<<11);
-		break;
-#endif
-#ifdef FBCON_HAS_CFB16
-	case 16:
-		i->fbcon_cmap16[regno] =
-			((red & 0xf800) >> 0) |
-			((green & 0xfc00) >> 5) |
-			((blue & 0xf800) >> 11);
-		break;
-#endif
-	default:
-		break;
-	}
-
-	return 0;
-}
-
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 
-static int  au1100_blank(int blank_mode, struct fb_info_gen *_info)
-{
+	print_dbg("fb_blank %d %p", blank_mode, fbi);
 
 	switch (blank_mode) {
+
 	case VESA_NO_BLANKING:
-		/* turn on panel */
-		//printk("turn on panel\n");
+			/* Turn on panel */
+			fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
-		p_lcd_reg->lcd_control |= LCD_CONTROL_GO;
-		au_writew(au_readw(PB1100_G_CONTROL) | p_lcd->mode_backlight,
+			if (drv_info.panel_idx == 1) {
+				au_writew(au_readw(PB1100_G_CONTROL)
+					  | (PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
 			PB1100_G_CONTROL);
-#endif
-#ifdef CONFIG_MIPS_HYDROGEN3
-		/*  Turn controller & power supply on,  GPIO213 */
-		au_writel(0x20002000, 0xB1700008);
-		au_writel(0x00040000, 0xB1900108);
-		au_writel(0x01000100, 0xB1700008);
+			}
 #endif
 		au_sync();
 		break;
@@ -332,12 +292,14 @@ static int  au1100_blank(int blank_mode,
 	case VESA_VSYNC_SUSPEND:
 	case VESA_HSYNC_SUSPEND:
 	case VESA_POWERDOWN:
-		/* turn off panel */
-		//printk("turn off panel\n");
+			/* Turn off panel */
+			fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
 #ifdef CONFIG_MIPS_PB1100
-		au_writew(au_readw(PB1100_G_CONTROL) & ~p_lcd->mode_backlight,
+			if (drv_info.panel_idx == 1) {
+				au_writew(au_readw(PB1100_G_CONTROL)
+				  	  & ~(PB1100_G_CONTROL_BL | PB1100_G_CONTROL_VDD),
 			PB1100_G_CONTROL);
-		p_lcd_reg->lcd_control &= ~LCD_CONTROL_GO;
+			}
 #endif
 		au_sync();
 		break;
@@ -348,49 +310,87 @@ static int  au1100_blank(int blank_mode,
 	return 0;
 }
 
-static void au1100_set_disp(const void *unused, struct display *disp,
-			 struct fb_info_gen *info)
+/* fb_pan_display
+ * Pan display in x and/or y as specified
+ */
+int au1100fb_fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *fbi)
 {
-	disp->screen_base = (char *)fb_info.fb_virt_start;
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+	int dy;
 
-	switch (disp->var.bits_per_pixel) {
-#ifdef FBCON_HAS_CFB8
-	case 8:
-		disp->dispsw = &fbcon_cfb8;
-		if (fb_info.nohwcursor)
-			fbcon_cfb8.cursor = au1100_nocursor;
-		break;
-#endif
-#ifdef FBCON_HAS_CFB16
-	case 16:
-		disp->dispsw = &fbcon_cfb16;
-		disp->dispsw_data = fb_info.fbcon_cmap16;
-		if (fb_info.nohwcursor)
-			fbcon_cfb16.cursor = au1100_nocursor;
-		break;
-#endif
-	default:
-		disp->dispsw = &fbcon_dummy;
-		disp->dispsw_data = NULL;
-		break;
+	print_dbg("fb_pan_display %p %p", var, fbi);
+
+	if (!var || !fbdev) {
+		return -EINVAL;
+	}
+
+	if (var->xoffset - fbi->var.xoffset) {
+		/* No support for X panning for now! */
+		return -EINVAL;
+	}
+
+	print_dbg("fb_pan_display 2 %p %p", var, fbi);
+	dy = var->yoffset - fbi->var.yoffset;
+	if (dy) {
+
+		u32 dmaaddr;
+
+		print_dbg("Panning screen of %d lines", dy);
+
+		dmaaddr = fbdev->regs->lcd_dmaaddr0;
+		dmaaddr += (fbi->fix.line_length * dy);
+
+		/* TODO: Wait for current frame to finished */
+		fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(dmaaddr);
+
+		if (panel_is_dual(fbdev->panel)) {
+			dmaaddr = fbdev->regs->lcd_dmaaddr1;
+			dmaaddr += (fbi->fix.line_length * dy);
+			fbdev->regs->lcd_dmaaddr0 = LCD_DMA_SA_N(dmaaddr);
+	}
+	}
+	print_dbg("fb_pan_display 3 %p %p", var, fbi);
+
+	return 0;
+}
+
+/* fb_rotate
+ * Rotate the display of this angle. This doesn't seems to be used by the core,
+ * but as our hardware supports it, so why not implementing it...
+ */
+void au1100fb_fb_rotate(struct fb_info *fbi, int angle)
+{
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
+
+	print_dbg("fb_rotate %p %d", fbi, angle);
+
+	if (fbdev && (angle > 0) && !(angle % 90)) {
+
+		fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
+
+		fbdev->regs->lcd_control &= ~(LCD_CONTROL_SM_MASK);
+		fbdev->regs->lcd_control |= ((angle/90) << LCD_CONTROL_SM_BIT);
+
+		fbdev->regs->lcd_control |= LCD_CONTROL_GO;
 	}
 }
 
-static int
-au1100fb_mmap(struct fb_info *_fb,
-	     struct file *file,
-	     struct vm_area_struct *vma)
+/* fb_mmap
+ * Map video memory in user space. We don't use the generic fb_mmap method mainly
+ * to allow the use of the TLB streaming flag (CCA=6)
+ */
+int au1100fb_fb_mmap(struct fb_info *fbi, struct file *file, struct vm_area_struct *vma)
 {
+	struct au1100fb_device *fbdev = to_au1100fb_device(fbi);
 	unsigned int len;
 	unsigned long start=0, off;
-	struct au1100fb_info *fb = (struct au1100fb_info *)_fb;
 
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT)) {
 		return -EINVAL;
 	}
 
-	start = fb_info.fb_phys & PAGE_MASK;
-	len = PAGE_ALIGN((start & ~PAGE_MASK) + fb_info.fb_size);
+	start = fbdev->fb_phys & PAGE_MASK;
+	len = PAGE_ALIGN((start & ~PAGE_MASK) + fbdev->fb_len);
 
 	off = vma->vm_pgoff << PAGE_SHIFT;
 
@@ -401,276 +401,310 @@ au1100fb_mmap(struct fb_info *_fb,
 	off += start;
 	vma->vm_pgoff = off >> PAGE_SHIFT;
 
-	pgprot_val(vma->vm_page_prot) &= ~_CACHE_MASK;
-	//pgprot_val(vma->vm_page_prot) |= _CACHE_CACHABLE_NONCOHERENT;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 	pgprot_val(vma->vm_page_prot) |= (6 << 9); //CCA=6
 
-	/* This is an IO map - tell maydump to skip this VMA */
 	vma->vm_flags |= VM_IO;
 
-	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
+	if (io_remap_page_range(vma, vma->vm_start, off,
 				vma->vm_end - vma->vm_start,
 				vma->vm_page_prot)) {
 		return -EAGAIN;
 	}
 
-	fb->mmaped = 1;
 	return 0;
 }
 
-int au1100_pan_display(const struct fb_var_screeninfo *var,
-		       struct fb_info_gen *info)
+static struct fb_ops au1100fb_ops =
 {
-	return 0;
-}
+	.owner			= THIS_MODULE,
+	.fb_setcolreg		= au1100fb_fb_setcolreg,
+	.fb_blank		= au1100fb_fb_blank,
+	.fb_pan_display		= au1100fb_fb_pan_display,
+	.fb_fillrect		= cfb_fillrect,
+	.fb_copyarea		= cfb_copyarea,
+	.fb_imageblit		= cfb_imageblit,
+	.fb_cursor		= soft_cursor,
+	.fb_rotate		= au1100fb_fb_rotate,
+	.fb_mmap		= au1100fb_fb_mmap,
+};
 
-static int au1100fb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-			  u_long arg, int con, struct fb_info *info)
-{
-	/* nothing to do yet */
-	return -EINVAL;
-}
 
-static struct fbgen_hwswitch au1100_switch = {
-	au1100_detect,
-	au1100_encode_fix,
-	au1100_decode_var,
-	au1100_encode_var,
-	au1100_get_par,
-	au1100_set_par,
-	au1100_getcolreg,
-	au1100_setcolreg,
-	au1100_pan_display,
-	au1100_blank,
-	au1100_set_disp
-};
+/*-------------------------------------------------------------------------*/
 
+/* AU1100 LCD controller device driver */
 
-int au1100_setmode(void)
+int au1100fb_drv_probe(struct device *dev)
 {
-	int words;
+	struct au1100fb_device *fbdev = NULL;
+	struct resource *regs_res;
+	unsigned long page;
+	u32 sys_clksrc;
 
-	/* FIXME Need to accomodate for swivel mode and 12bpp, <8bpp*/
-	switch (p_lcd->mode_control & LCD_CONTROL_SM)
-	{
-		case LCD_CONTROL_SM_0:
-		case LCD_CONTROL_SM_180:
-		words = (p_lcd->xres * p_lcd->yres * p_lcd->bpp) / 32;
-			break;
-		case LCD_CONTROL_SM_90:
-		case LCD_CONTROL_SM_270:
-			/* is this correct? */
-		words = (p_lcd->xres * p_lcd->bpp) / 8;
-			break;
-		default:
-			printk("mode_control reg not initialized\n");
+	if (!dev)
 			return -EINVAL;
+
+	/* Allocate new device private */
+	if (!(fbdev = kmalloc(sizeof(struct au1100fb_device), GFP_KERNEL))) {
+		print_err("fail to allocate device private record");
+		return -ENOMEM;
 	}
+	memset((void*)fbdev, 0, sizeof(struct au1100fb_device));
 
-	/*
-	 * Setup LCD controller
-	 */
+	fbdev->panel = &known_lcd_panels[drv_info.panel_idx];
 
-	p_lcd_reg->lcd_control = p_lcd->mode_control;
-	p_lcd_reg->lcd_intstatus = 0;
-	p_lcd_reg->lcd_intenable = 0;
-	p_lcd_reg->lcd_horztiming = p_lcd->mode_horztiming;
-	p_lcd_reg->lcd_verttiming = p_lcd->mode_verttiming;
-	p_lcd_reg->lcd_clkcontrol = p_lcd->mode_clkcontrol;
-	p_lcd_reg->lcd_words = words - 1;
-	p_lcd_reg->lcd_dmaaddr0 = fb_info.fb_phys;
+	dev_set_drvdata(dev, (void*)fbdev);
 
-	/* turn on panel */
-#ifdef CONFIG_MIPS_PB1100
-	au_writew(au_readw(PB1100_G_CONTROL) | p_lcd->mode_backlight,
-			PB1100_G_CONTROL);
-#endif
-#ifdef CONFIG_MIPS_HYDROGEN3
-	/*  Turn controller & power supply on,  GPIO213 */
-	au_writel(0x20002000, 0xB1700008);
-	au_writel(0x00040000, 0xB1900108);
-	au_writel(0x01000100, 0xB1700008);
-#endif
+	/* Allocate region for our registers and map them */
+	if (!(regs_res = platform_get_resource(to_platform_device(dev),
+					IORESOURCE_MEM, 0))) {
+		print_err("fail to retrieve registers resource");
+		return -EFAULT;
+	}
 
-	p_lcd_reg->lcd_control |= LCD_CONTROL_GO;
+	au1100fb_fix.mmio_start = regs_res->start;
+	au1100fb_fix.mmio_len = regs_res->end - regs_res->start + 1;
 
-	return 0;
-}
+	if (!request_mem_region(au1100fb_fix.mmio_start, au1100fb_fix.mmio_len,
+				DRIVER_NAME)) {
+		print_err("fail to lock memory region at 0x%08x",
+				au1100fb_fix.mmio_start);
+		return -EBUSY;
+	}
 
+	fbdev->regs = (struct au1100fb_regs*)KSEG1ADDR(au1100fb_fix.mmio_start);
 
-int __init au1100fb_init(void)
-{
-	uint32 sys_clksrc;
-	unsigned long page;
+	print_dbg("Register memory map at %p", fbdev->regs);
+	print_dbg("phys=0x%08x, size=%d", fbdev->regs_phys, fbdev->regs_len);
 
-	/*
-	* Get the panel information/display mode and update the registry
-	*/
-	p_lcd = &panels[my_lcd_index];
-
-	switch (p_lcd->mode_control & LCD_CONTROL_SM)
-	{
-		case LCD_CONTROL_SM_0:
-		case LCD_CONTROL_SM_180:
-		p_lcd->xres =
-			(p_lcd->mode_horztiming & LCD_HORZTIMING_PPL) + 1;
-		p_lcd->yres =
-			(p_lcd->mode_verttiming & LCD_VERTTIMING_LPP) + 1;
-			break;
-		case LCD_CONTROL_SM_90:
-		case LCD_CONTROL_SM_270:
-		p_lcd->yres =
-			(p_lcd->mode_horztiming & LCD_HORZTIMING_PPL) + 1;
-		p_lcd->xres =
-			(p_lcd->mode_verttiming & LCD_VERTTIMING_LPP) + 1;
-			break;
-	}
 
-	/*
-	 * Panel dimensions x bpp must be divisible by 32
-	 */
-	if (((p_lcd->yres * p_lcd->bpp) % 32) != 0)
-		printk("VERT %% 32\n");
-	if (((p_lcd->xres * p_lcd->bpp) % 32) != 0)
-		printk("HORZ %% 32\n");
 
-	/*
-	 * Allocate LCD framebuffer from system memory
-	 */
-	fb_info.fb_size = (p_lcd->xres * p_lcd->yres * p_lcd->bpp) / 8;
+	/* Allocate the framebuffer to the maximum screen size * nbr of video buffers */
+	fbdev->fb_len = fbdev->panel->xres * fbdev->panel->yres *
+		  	(fbdev->panel->bpp >> 3) * AU1100FB_NBR_VIDEO_BUFFERS;
 
-	current_par.var.xres = p_lcd->xres;
-	current_par.var.xres_virtual = p_lcd->xres;
-	current_par.var.yres = p_lcd->yres;
-	current_par.var.yres_virtual = p_lcd->yres;
-	current_par.var.bits_per_pixel = p_lcd->bpp;
-
-	/* FIX!!! only works for 8/16 bpp */
-	current_par.line_length = p_lcd->xres * p_lcd->bpp / 8; /* in bytes */
-	fb_info.fb_virt_start = (unsigned long )
-		__get_free_pages(GFP_ATOMIC | GFP_DMA,
-				get_order(fb_info.fb_size + 0x1000));
-	if (!fb_info.fb_virt_start) {
-		printk("Unable to allocate fb memory\n");
+	fbdev->fb_mem = dma_alloc_coherent(dev, PAGE_ALIGN(fbdev->fb_len),
+					&fbdev->fb_phys, GFP_KERNEL);
+	if (!fbdev->fb_mem) {
+		print_err("fail to allocate frambuffer (size: %dK))",
+			  fbdev->fb_len / 1024);
 		return -ENOMEM;
 	}
-	fb_info.fb_phys = virt_to_bus((void *)fb_info.fb_virt_start);
+
+	au1100fb_fix.smem_start = fbdev->fb_phys;
+	au1100fb_fix.smem_len = fbdev->fb_len;
 
 	/*
 	 * Set page reserved so that mmap will work. This is necessary
 	 * since we'll be remapping normal memory.
 	 */
-	for (page = fb_info.fb_virt_start;
-	     page < PAGE_ALIGN(fb_info.fb_virt_start + fb_info.fb_size);
+	for (page = (unsigned long)fbdev->fb_mem;
+	     page < PAGE_ALIGN((unsigned long)fbdev->fb_mem + fbdev->fb_len);
 	     page += PAGE_SIZE) {
+#if CONFIG_DMA_NONCOHERENT
+		SetPageReserved(virt_to_page(CAC_ADDR(page)));
+#else
 		SetPageReserved(virt_to_page(page));
+#endif
 	}
 
-	memset((void *)fb_info.fb_virt_start, 0, fb_info.fb_size);
+	print_dbg("Framebuffer memory map at %p", fbdev->fb_mem);
+	print_dbg("phys=0x%08x, size=%dK", fbdev->fb_phys, fbdev->fb_len / 1024);
 
-	/* set freqctrl now to allow more time to stabilize */
-	/* zero-out out LCD bits */
-	sys_clksrc = au_readl(SYS_CLKSRC) & ~0x000003e0;
-	sys_clksrc |= p_lcd->mode_toyclksrc;
-	au_writel(sys_clksrc, SYS_CLKSRC);
-
-	/* FIXME add check to make sure auxpll is what is expected! */
-	au1100_setmode();
-
-	fb_info.gen.parsize = sizeof(struct au1100fb_par);
-	fb_info.gen.fbhw = &au1100_switch;
-
-	strcpy(fb_info.gen.info.modename, "Au1100 LCD");
-	fb_info.gen.info.changevar = NULL;
-	fb_info.gen.info.node = -1;
-
-	fb_info.gen.info.fbops = &au1100fb_ops;
-	fb_info.gen.info.disp = &disp;
-	fb_info.gen.info.switch_con = &fbgen_switch;
-	fb_info.gen.info.updatevar = &fbgen_update_var;
-	fb_info.gen.info.blank = &fbgen_blank;
-	fb_info.gen.info.flags = FBINFO_FLAG_DEFAULT;
-
-	/* This should give a reasonable default video mode */
-	fbgen_get_var(&disp.var, -1, &fb_info.gen.info);
-	fbgen_do_set_var(&disp.var, 1, &fb_info.gen);
-	fbgen_set_disp(-1, &fb_info.gen);
-	fbgen_install_cmap(0, &fb_info.gen);
-	if (register_framebuffer(&fb_info.gen.info) < 0)
-		return -EINVAL;
-	printk(KERN_INFO "fb%d: %s frame buffer device\n",
-			GET_FB_IDX(fb_info.gen.info.node),
-			fb_info.gen.info.modename);
+	/* Setup LCD clock to AUX (48 MHz) */
+	sys_clksrc = au_readl(SYS_CLKSRC) & ~(SYS_CS_ML_MASK | SYS_CS_DL | SYS_CS_CL);
+	au_writel((sys_clksrc | (1 << SYS_CS_ML_BIT)), SYS_CLKSRC);
+
+	/* load the panel info into the var struct */
+	au1100fb_var.bits_per_pixel = fbdev->panel->bpp;
+	au1100fb_var.xres = fbdev->panel->xres;
+	au1100fb_var.xres_virtual = au1100fb_var.xres;
+	au1100fb_var.yres = fbdev->panel->yres;
+	au1100fb_var.yres_virtual = au1100fb_var.yres;
+
+	fbdev->info.screen_base = fbdev->fb_mem;
+	fbdev->info.fbops = &au1100fb_ops;
+	fbdev->info.fix = au1100fb_fix;
+
+	if (!(fbdev->info.pseudo_palette = kmalloc(sizeof(u32) * 16, GFP_KERNEL))) {
+		return -ENOMEM;
+	}
+	memset(fbdev->info.pseudo_palette, 0, sizeof(u32) * 16);
+
+	if (fb_alloc_cmap(&fbdev->info.cmap, AU1100_LCD_NBR_PALETTE_ENTRIES, 0) < 0) {
+		print_err("Fail to allocate colormap (%d entries)",
+			   AU1100_LCD_NBR_PALETTE_ENTRIES);
+		kfree(fbdev->info.pseudo_palette);
+		return -EFAULT;
+	}
+
+	fbdev->info.var = au1100fb_var;
+
+	/* Set h/w registers */
+	au1100fb_setmode(fbdev);
+
+	/* Register new framebuffer */
+	if (register_framebuffer(&fbdev->info) < 0) {
+		print_err("cannot register new framebuffer");
+		goto failed;
+	}
 
 	return 0;
-}
 
+failed:
+	if (fbdev->regs) {
+		release_mem_region(fbdev->regs_phys, fbdev->regs_len);
+	}
+	if (fbdev->fb_mem) {
+		dma_free_noncoherent(dev, fbdev->fb_len, fbdev->fb_mem, fbdev->fb_phys);
+	}
+	if (fbdev->info.cmap.len != 0) {
+		fb_dealloc_cmap(&fbdev->info.cmap);
+	}
+	kfree(fbdev);
+	dev_set_drvdata(dev, NULL);
+
+	return 0;
+}
 
-void au1100fb_cleanup(struct fb_info *info)
+int au1100fb_drv_remove(struct device *dev)
 {
-	unregister_framebuffer(info);
+	struct au1100fb_device *fbdev = NULL;
+
+	if (!dev)
+		return -ENODEV;
+
+	fbdev = (struct au1100fb_device*) dev_get_drvdata(dev);
+
+#if !defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_LOGO)
+	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
+#endif
+	fbdev->regs->lcd_control &= ~LCD_CONTROL_GO;
+
+	/* Clean up all probe data */
+	unregister_framebuffer(&fbdev->info);
+
+	release_mem_region(fbdev->regs_phys, fbdev->regs_len);
+
+	dma_free_coherent(dev, PAGE_ALIGN(fbdev->fb_len), fbdev->fb_mem, fbdev->fb_phys);
+
+	fb_dealloc_cmap(&fbdev->info.cmap);
+	kfree(fbdev->info.pseudo_palette);
+	kfree((void*)fbdev);
+
+	return 0;
 }
 
+int au1100fb_drv_suspend(struct device *dev, u32 state, u32 level)
+{
+	/* TODO */
+	return 0;
+}
 
-void au1100fb_setup(char *options, int *ints)
+int au1100fb_drv_resume(struct device *dev, u32 level)
 {
-	char* this_opt;
-	int i;
-	int num_panels = sizeof(panels)/sizeof(struct known_lcd_panels);
+	/* TODO */
+	return 0;
+}
+
+static struct device_driver au1100fb_driver = {
+	.name		= "au1100-lcd",
+	.bus		= &platform_bus_type,
+
+	.probe		= au1100fb_drv_probe,
+        .remove		= au1100fb_drv_remove,
+	.suspend	= au1100fb_drv_suspend,
+        .resume		= au1100fb_drv_resume,
+};
 
+/*-------------------------------------------------------------------------*/
 
-	if (!options || !*options)
-		return;
+/* Kernel driver */
 
-	for(this_opt=strtok(options, ","); this_opt;
-	    this_opt=strtok(NULL, ",")) {
-		if (!strncmp(this_opt, "panel:", 6)) {
-#if defined(CONFIG_MIPS_PB1100) || defined(CONFIG_MIPS_DB1100)
-			/* Read Pb1100 Switch S10 ? */
-			if (!strncmp(this_opt+6, "s10", 3))
-			{
-				int panel;
-				panel = *(volatile int *)0xAE000008; /* BCSR SWITCHES */
-				panel >>= 8;
-				panel &= 0x0F;
-				if (panel >= num_panels) panel = 0;
-				my_lcd_index = panel;
+int au1100fb_setup(char *options)
+{
+	char* this_opt;
+	int num_panels = ARRAY_SIZE(known_lcd_panels);
+	char* mode = NULL;
+	int panel_idx = 0;
+
+	if (num_panels <= 0) {
+		print_err("No LCD panels supported by driver!");
+		return -EFAULT;
 			}
-			else
-#endif
-			/* Get the panel name, everything else if fixed */
-			for (i=0; i<num_panels; i++) {
-				if (!strncmp(this_opt+6, panels[i].panel_name,
+
+	if (options) {
+		while ((this_opt = strsep(&options,",")) != NULL) {
+			/* Panel option */
+		if (!strncmp(this_opt, "panel:", 6)) {
+				int i;
+				this_opt += 6;
+				for (i = 0; i < num_panels; i++) {
+					if (!strncmp(this_opt,
+					      	     known_lcd_panels[i].name,
 							strlen(this_opt))) {
-					my_lcd_index = i;
+						panel_idx = i;
 					break;
 				}
 			}
+				if (i >= num_panels) {
+ 					print_warn("Panel %s not supported!", this_opt);
+				}
+			}
+			/* Mode option (only option that start with digit) */
+			else if (isdigit(this_opt[0])) {
+				mode = kmalloc(strlen(this_opt) + 1, GFP_KERNEL);
+				strncpy(mode, this_opt, strlen(this_opt) + 1);
+			}
+			/* Unsupported option */
+			else {
+				print_warn("Unsupported option \"%s\"", this_opt);
 		}
-		else if (!strncmp(this_opt, "nohwcursor", 10)) {
-			printk("nohwcursor\n");
-			fb_info.nohwcursor = 1;
 		}
 	}
 
-	printk("au1100fb: Panel %d %s\n", my_lcd_index,
-		panels[my_lcd_index].panel_name);
-}
+	drv_info.panel_idx = panel_idx;
+	drv_info.opt_mode = mode;
 
+	print_info("Panel=%s Mode=%s",
+			known_lcd_panels[drv_info.panel_idx].name,
+		      	drv_info.opt_mode ? drv_info.opt_mode : "default");
 
+	return 0;
+}
 
-#ifdef MODULE
-MODULE_LICENSE("GPL");
-int init_module(void)
+int __init au1100fb_init(void)
 {
-	return au1100fb_init();
+	char* options;
+	int ret;
+
+	print_info("" DRIVER_DESC "");
+
+	memset(&drv_info, 0, sizeof(drv_info));
+
+	if (fb_get_options(DRIVER_NAME, &options))
+		return -ENODEV;
+
+	/* Setup driver with options */
+	ret = au1100fb_setup(options);
+	if (ret < 0) {
+		print_err("Fail to setup driver");
+		return ret;
+	}
+
+	return driver_register(&au1100fb_driver);
 }
 
-void cleanup_module(void)
+void __exit au1100fb_cleanup(void)
 {
-	au1100fb_cleanup(void);
+	driver_unregister(&au1100fb_driver);
+
+	if (drv_info.opt_mode)
+		kfree(drv_info.opt_mode);
 }
 
-MODULE_AUTHOR("Pete Popov <ppopov@mvista.com>");
-MODULE_DESCRIPTION("Au1100 LCD framebuffer device driver");
-#endif /* MODULE */
+module_init(au1100fb_init);
+module_exit(au1100fb_cleanup);
+
+MODULE_DESCRIPTION(DRIVER_DESC);
+MODULE_LICENSE("GPL");
Index: manual.git/include/asm-mips/mach-au1x00/au1000.h
===================================================================
--- manual.git.orig/include/asm-mips/mach-au1x00/au1000.h
+++ manual.git/include/asm-mips/mach-au1x00/au1000.h
@@ -1647,6 +1647,12 @@ extern au1xxx_irq_map_t au1xxx_irq_map[]
   #define SYS_CS_MI2_MASK           (0x7<<SYS_CS_MI2_BIT)
   #define SYS_CS_DI2                (1<<16)
   #define SYS_CS_CI2                (1<<15)
+#ifdef CONFIG_SOC_AU1100
+  #define SYS_CS_ML_BIT             7
+  #define SYS_CS_ML_MASK            (0x7<<SYS_CS_ML_BIT)
+  #define SYS_CS_DL                 (1<<6)
+  #define SYS_CS_CL                 (1<<5)
+#else
   #define SYS_CS_MUH_BIT            12
   #define SYS_CS_MUH_MASK           (0x7<<SYS_CS_MUH_BIT)
   #define SYS_CS_DUH                (1<<11)
@@ -1655,6 +1661,7 @@ extern au1xxx_irq_map_t au1xxx_irq_map[]
   #define SYS_CS_MUD_MASK           (0x7<<SYS_CS_MUD_BIT)
   #define SYS_CS_DUD                (1<<6)
   #define SYS_CS_CUD                (1<<5)
+#endif
   #define SYS_CS_MIR_BIT            2
   #define SYS_CS_MIR_MASK           (0x7<<SYS_CS_MIR_BIT)
   #define SYS_CS_DIR                (1<<1)
Index: manual.git/drivers/video/au1100fb.h
===================================================================
--- manual.git.orig/drivers/video/au1100fb.h
+++ manual.git/drivers/video/au1100fb.h
@@ -30,352 +30,352 @@
 #ifndef _AU1100LCD_H
 #define _AU1100LCD_H
 
+#include <asm/mach-au1x00/au1000.h>
+
+#define print_err(f, arg...) printk(KERN_ERR DRIVER_NAME ": " f "\n", ## arg)
+#define print_warn(f, arg...) printk(KERN_WARNING DRIVER_NAME ": " f "\n", ## arg)
+#define print_info(f, arg...) printk(KERN_INFO DRIVER_NAME ": " f "\n", ## arg)
+
+#if DEBUG
+#define print_dbg(f, arg...) printk(__FILE__ ": " f "\n", ## arg)
+#else
+#define print_dbg(f, arg...) do {} while (0)
+#endif
+
+#if defined(__BIG_ENDIAN)
+#define LCD_CONTROL_DEFAULT_PO LCD_CONTROL_PO_11
+#else
+#define LCD_CONTROL_DEFAULT_PO LCD_CONTROL_PO_00
+#endif
+#define LCD_CONTROL_DEFAULT_SBPPF LCD_CONTROL_SBPPF_565
+
 /********************************************************************/
-#define uint32 unsigned long
-typedef volatile struct
-{
-	uint32	lcd_control;
-	uint32	lcd_intstatus;
-	uint32	lcd_intenable;
-	uint32	lcd_horztiming;
-	uint32	lcd_verttiming;
-	uint32	lcd_clkcontrol;
-	uint32	lcd_dmaaddr0;
-	uint32	lcd_dmaaddr1;
-	uint32	lcd_words;
-	uint32	lcd_pwmdiv;
-	uint32	lcd_pwmhi;
-	uint32	reserved[(0x0400-0x002C)/4];
-	uint32	lcd_pallettebase[256];
 
-} AU1100_LCD;
+/* LCD controller restrictions */
+#define AU1100_LCD_MAX_XRES	800
+#define AU1100_LCD_MAX_YRES	600
+#define AU1100_LCD_MAX_BPP	16
+#define AU1100_LCD_MAX_CLK	48000000
+#define AU1100_LCD_NBR_PALETTE_ENTRIES 256
+
+/* Default number of visible screen buffer to allocate */
+#define AU1100FB_NBR_VIDEO_BUFFERS 4
 
 /********************************************************************/
 
-#define AU1100_LCD_ADDR		0xB5000000
+struct au1100fb_panel
+{
+	const char name[25];		/* Full name <vendor>_<model> */
 
-/*
- * Register bit definitions
- */
+	u32   	control_base;		/* Mode-independent control values */
+	u32	clkcontrol_base;	/* Panel pixclock preferences */
 
-/* lcd_control */
-#define LCD_CONTROL_SBPPF		(7<<18)
-#define LCD_CONTROL_SBPPF_655	(0<<18)
-#define LCD_CONTROL_SBPPF_565	(1<<18)
-#define LCD_CONTROL_SBPPF_556	(2<<18)
-#define LCD_CONTROL_SBPPF_1555	(3<<18)
-#define LCD_CONTROL_SBPPF_5551	(4<<18)
-#define LCD_CONTROL_WP			(1<<17)
-#define LCD_CONTROL_WD			(1<<16)
-#define LCD_CONTROL_C			(1<<15)
-#define LCD_CONTROL_SM			(3<<13)
-#define LCD_CONTROL_SM_0		(0<<13)
-#define LCD_CONTROL_SM_90		(1<<13)
-#define LCD_CONTROL_SM_180		(2<<13)
-#define LCD_CONTROL_SM_270		(3<<13)
-#define LCD_CONTROL_DB			(1<<12)
-#define LCD_CONTROL_CCO			(1<<11)
-#define LCD_CONTROL_DP			(1<<10)
-#define LCD_CONTROL_PO			(3<<8)
-#define LCD_CONTROL_PO_00		(0<<8)
-#define LCD_CONTROL_PO_01		(1<<8)
-#define LCD_CONTROL_PO_10		(2<<8)
-#define LCD_CONTROL_PO_11		(3<<8)
-#define LCD_CONTROL_MPI			(1<<7)
-#define LCD_CONTROL_PT			(1<<6)
-#define LCD_CONTROL_PC			(1<<5)
-#define LCD_CONTROL_BPP			(7<<1)
-#define LCD_CONTROL_BPP_1		(0<<1)
-#define LCD_CONTROL_BPP_2		(1<<1)
-#define LCD_CONTROL_BPP_4		(2<<1)
-#define LCD_CONTROL_BPP_8		(3<<1)
-#define LCD_CONTROL_BPP_12		(4<<1)
-#define LCD_CONTROL_BPP_16		(5<<1)
-#define LCD_CONTROL_GO			(1<<0)
-
-/* lcd_intstatus, lcd_intenable */
-#define LCD_INT_SD				(1<<7)
-#define LCD_INT_OF				(1<<6)
-#define LCD_INT_UF				(1<<5)
-#define LCD_INT_SA				(1<<3)
-#define LCD_INT_SS				(1<<2)
-#define LCD_INT_S1				(1<<1)
-#define LCD_INT_S0				(1<<0)
-
-/* lcd_horztiming */
-#define LCD_HORZTIMING_HN2		(255<<24)
-#define LCD_HORZTIMING_HN2_N(N)	(((N)-1)<<24)
-#define LCD_HORZTIMING_HN1		(255<<16)
-#define LCD_HORZTIMING_HN1_N(N)	(((N)-1)<<16)
-#define LCD_HORZTIMING_HPW		(63<<10)
-#define LCD_HORZTIMING_HPW_N(N)	(((N)-1)<<10)
-#define LCD_HORZTIMING_PPL		(1023<<0)
-#define LCD_HORZTIMING_PPL_N(N)	(((N)-1)<<0)
-
-/* lcd_verttiming */
-#define LCD_VERTTIMING_VN2		(255<<24)
-#define LCD_VERTTIMING_VN2_N(N)	(((N)-1)<<24)
-#define LCD_VERTTIMING_VN1		(255<<16)
-#define LCD_VERTTIMING_VN1_N(N)	(((N)-1)<<16)
-#define LCD_VERTTIMING_VPW		(63<<10)
-#define LCD_VERTTIMING_VPW_N(N)	(((N)-1)<<10)
-#define LCD_VERTTIMING_LPP		(1023<<0)
-#define LCD_VERTTIMING_LPP_N(N)	(((N)-1)<<0)
-
-/* lcd_clkcontrol */
-#define LCD_CLKCONTROL_IB		(1<<18)
-#define LCD_CLKCONTROL_IC		(1<<17)
-#define LCD_CLKCONTROL_IH		(1<<16)
-#define LCD_CLKCONTROL_IV		(1<<15)
-#define LCD_CLKCONTROL_BF		(31<<10)
-#define LCD_CLKCONTROL_BF_N(N)	(((N)-1)<<10)
-#define LCD_CLKCONTROL_PCD		(1023<<0)
-#define LCD_CLKCONTROL_PCD_N(N)	((N)<<0)
-
-/* lcd_pwmdiv */
-#define LCD_PWMDIV_EN			(1<<12)
-#define LCD_PWMDIV_PWMDIV		(2047<<0)
-#define LCD_PWMDIV_PWMDIV_N(N)	(((N)-1)<<0)
-
-/* lcd_pwmhi */
-#define LCD_PWMHI_PWMHI1		(2047<<12)
-#define LCD_PWMHI_PWMHI1_N(N)	((N)<<12)
-#define LCD_PWMHI_PWMHI0		(2047<<0)
-#define LCD_PWMHI_PWMHI0_N(N)	((N)<<0)
-
-/* lcd_pallettebase - MONOCHROME */
-#define LCD_PALLETTE_MONO_MI		(15<<0)
-#define LCD_PALLETTE_MONO_MI_N(N)	((N)<<0)
-
-/* lcd_pallettebase - COLOR */
-#define LCD_PALLETTE_COLOR_BI		(15<<8)
-#define LCD_PALLETTE_COLOR_BI_N(N)	((N)<<8)
-#define LCD_PALLETTE_COLOR_GI		(15<<4)
-#define LCD_PALLETTE_COLOR_GI_N(N)	((N)<<4)
-#define LCD_PALLETTE_COLOR_RI		(15<<0)
-#define LCD_PALLETTE_COLOR_RI_N(N)	((N)<<0)
-
-/* lcd_palletebase - COLOR TFT PALLETIZED */
-#define LCD_PALLETTE_TFT_DC			(65535<<0)
-#define LCD_PALLETTE_TFT_DC_N(N)	((N)<<0)
+	u32	horztiming;
+	u32	verttiming;
 
-/********************************************************************/
+	u32	xres;		/* Maximum horizontal resolution */
+	u32 	yres;		/* Maximum vertical resolution */
+	u32 	bpp;		/* Maximum depth supported */
+};
 
-struct known_lcd_panels
+struct au1100fb_regs
 {
-	uint32 xres;
-	uint32 yres;
-	uint32 bpp;
-	unsigned char  panel_name[256];
-	uint32 mode_control;
-	uint32 mode_horztiming;
-	uint32 mode_verttiming;
-	uint32 mode_clkcontrol;
-	uint32 mode_pwmdiv;
-	uint32 mode_pwmhi;
-	uint32 mode_toyclksrc;
-	uint32 mode_backlight;
+	u32  lcd_control;
+	u32  lcd_intstatus;
+	u32  lcd_intenable;
+	u32  lcd_horztiming;
+	u32  lcd_verttiming;
+	u32  lcd_clkcontrol;
+	u32  lcd_dmaaddr0;
+	u32  lcd_dmaaddr1;
+	u32  lcd_words;
+	u32  lcd_pwmdiv;
+	u32  lcd_pwmhi;
+	u32  reserved[(0x0400-0x002C)/4];
+	u32  lcd_pallettebase[256];
+};
+
+struct au1100fb_device {
+
+	struct fb_info info;			/* FB driver info record */
+
+	struct au1100fb_panel 	*panel;		/* Panel connected to this device */
 
+	struct au1100fb_regs* 	regs;		/* Registers memory map */
+	size_t       		regs_len;
+	unsigned int 		regs_phys;
+
+	unsigned char* 		fb_mem;		/* FrameBuffer memory map */
+	size_t	      		fb_len;
+	dma_addr_t    		fb_phys;
 };
 
-#if defined(__BIG_ENDIAN)
-#define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_11
-#else
-#define LCD_DEFAULT_PIX_FORMAT LCD_CONTROL_PO_00
-#endif
+/********************************************************************/
 
-/*
- * The fb driver assumes that AUX PLL is at 48MHz.  That can
- * cover up to 800x600 resolution; if you need higher resolution,
- * you should modify the driver as needed, not just this structure.
+#define LCD_CONTROL                (AU1100_LCD_BASE + 0x0)
+  #define LCD_CONTROL_SBB_BIT      21
+  #define LCD_CONTROL_SBB_MASK     (0x3 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_1        (0 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_2        (1 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_3        (2 << LCD_CONTROL_SBB_BIT)
+    #define LCD_CONTROL_SBB_4        (3 << LCD_CONTROL_SBB_BIT)
+  #define LCD_CONTROL_SBPPF_BIT    18
+  #define LCD_CONTROL_SBPPF_MASK   (0x7 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_655    (0 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_565    (1 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_556    (2 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_1555   (3 << LCD_CONTROL_SBPPF_BIT)
+    #define LCD_CONTROL_SBPPF_5551   (4 << LCD_CONTROL_SBPPF_BIT)
+  #define LCD_CONTROL_WP           (1<<17)
+  #define LCD_CONTROL_WD           (1<<16)
+  #define LCD_CONTROL_C            (1<<15)
+  #define LCD_CONTROL_SM_BIT       13
+  #define LCD_CONTROL_SM_MASK      (0x3 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_0         (0 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_90        (1 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_180       (2 << LCD_CONTROL_SM_BIT)
+    #define LCD_CONTROL_SM_270       (3 << LCD_CONTROL_SM_BIT)
+  #define LCD_CONTROL_DB           (1<<12)
+  #define LCD_CONTROL_CCO          (1<<11)
+  #define LCD_CONTROL_DP           (1<<10)
+  #define LCD_CONTROL_PO_BIT       8
+  #define LCD_CONTROL_PO_MASK      (0x3 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_00        (0 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_01        (1 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_10        (2 << LCD_CONTROL_PO_BIT)
+    #define LCD_CONTROL_PO_11        (3 << LCD_CONTROL_PO_BIT)
+  #define LCD_CONTROL_MPI          (1<<7)
+  #define LCD_CONTROL_PT           (1<<6)
+  #define LCD_CONTROL_PC           (1<<5)
+  #define LCD_CONTROL_BPP_BIT      1
+  #define LCD_CONTROL_BPP_MASK     (0x7 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_1        (0 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_2        (1 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_4        (2 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_8        (3 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_12       (4 << LCD_CONTROL_BPP_BIT)
+    #define LCD_CONTROL_BPP_16       (5 << LCD_CONTROL_BPP_BIT)
+  #define LCD_CONTROL_GO           (1<<0)
+
+#define LCD_INTSTATUS              (AU1100_LCD_BASE + 0x4)
+#define LCD_INTENABLE              (AU1100_LCD_BASE + 0x8)
+  #define LCD_INT_SD               (1<<7)
+  #define LCD_INT_OF               (1<<6)
+  #define LCD_INT_UF               (1<<5)
+  #define LCD_INT_SA               (1<<3)
+  #define LCD_INT_SS               (1<<2)
+  #define LCD_INT_S1               (1<<1)
+  #define LCD_INT_S0               (1<<0)
+
+#define LCD_HORZTIMING             (AU1100_LCD_BASE + 0xC)
+  #define LCD_HORZTIMING_HN2_BIT   24
+  #define LCD_HORZTIMING_HN2_MASK  (0xFF << LCD_HORZTIMING_HN2_BIT)
+  #define LCD_HORZTIMING_HN2_N(N)  ((((N)-1) << LCD_HORZTIMING_HN2_BIT) & LCD_HORZTIMING_HN2_MASK)
+  #define LCD_HORZTIMING_HN1_BIT   16
+  #define LCD_HORZTIMING_HN1_MASK  (0xFF << LCD_HORZTIMING_HN1_BIT)
+  #define LCD_HORZTIMING_HN1_N(N)  ((((N)-1) << LCD_HORZTIMING_HN1_BIT) & LCD_HORZTIMING_HN1_MASK)
+  #define LCD_HORZTIMING_HPW_BIT   10
+  #define LCD_HORZTIMING_HPW_MASK  (0x3F << LCD_HORZTIMING_HPW_BIT)
+  #define LCD_HORZTIMING_HPW_N(N)  ((((N)-1) << LCD_HORZTIMING_HPW_BIT) & LCD_HORZTIMING_HPW_MASK)
+  #define LCD_HORZTIMING_PPL_BIT   0
+  #define LCD_HORZTIMING_PPL_MASK  (0x3FF << LCD_HORZTIMING_PPL_BIT)
+  #define LCD_HORZTIMING_PPL_N(N)  ((((N)-1) << LCD_HORZTIMING_PPL_BIT) & LCD_HORZTIMING_PPL_MASK)
+
+#define LCD_VERTTIMING             (AU1100_LCD_BASE + 0x10)
+  #define LCD_VERTTIMING_VN2_BIT   24
+  #define LCD_VERTTIMING_VN2_MASK  (0xFF << LCD_VERTTIMING_VN2_BIT)
+  #define LCD_VERTTIMING_VN2_N(N)  ((((N)-1) << LCD_VERTTIMING_VN2_BIT) & LCD_VERTTIMING_VN2_MASK)
+  #define LCD_VERTTIMING_VN1_BIT   16
+  #define LCD_VERTTIMING_VN1_MASK  (0xFF << LCD_VERTTIMING_VN1_BIT)
+  #define LCD_VERTTIMING_VN1_N(N)  ((((N)-1) << LCD_VERTTIMING_VN1_BIT) & LCD_VERTTIMING_VN1_MASK)
+  #define LCD_VERTTIMING_VPW_BIT   10
+  #define LCD_VERTTIMING_VPW_MASK  (0x3F << LCD_VERTTIMING_VPW_BIT)
+  #define LCD_VERTTIMING_VPW_N(N)  ((((N)-1) << LCD_VERTTIMING_VPW_BIT) & LCD_VERTTIMING_VPW_MASK)
+  #define LCD_VERTTIMING_LPP_BIT   0
+  #define LCD_VERTTIMING_LPP_MASK  (0x3FF << LCD_VERTTIMING_LPP_BIT)
+  #define LCD_VERTTIMING_LPP_N(N)  ((((N)-1) << LCD_VERTTIMING_LPP_BIT) & LCD_VERTTIMING_LPP_MASK)
+
+#define LCD_CLKCONTROL             (AU1100_LCD_BASE + 0x14)
+  #define LCD_CLKCONTROL_IB        (1<<18)
+  #define LCD_CLKCONTROL_IC        (1<<17)
+  #define LCD_CLKCONTROL_IH        (1<<16)
+  #define LCD_CLKCONTROL_IV        (1<<15)
+  #define LCD_CLKCONTROL_BF_BIT    10
+  #define LCD_CLKCONTROL_BF_MASK   (0x1F << LCD_CLKCONTROL_BF_BIT)
+  #define LCD_CLKCONTROL_BF_N(N)   ((((N)-1) << LCD_CLKCONTROL_BF_BIT) & LCD_CLKCONTROL_BF_MASK)
+  #define LCD_CLKCONTROL_PCD_BIT   0
+  #define LCD_CLKCONTROL_PCD_MASK  (0x3FF << LCD_CLKCONTROL_PCD_BIT)
+  #define LCD_CLKCONTROL_PCD_N(N)  (((N) << LCD_CLKCONTROL_PCD_BIT) & LCD_CLKCONTROL_PCD_MASK)
+
+#define LCD_DMAADDR0               (AU1100_LCD_BASE + 0x18)
+#define LCD_DMAADDR1               (AU1100_LCD_BASE + 0x1C)
+  #define LCD_DMA_SA_BIT           5
+  #define LCD_DMA_SA_MASK          (0x7FFFFFF << LCD_DMA_SA_BIT)
+  #define LCD_DMA_SA_N(N)          ((N) & LCD_DMA_SA_MASK)
+
+#define LCD_WORDS                  (AU1100_LCD_BASE + 0x20)
+  #define LCD_WRD_WRDS_BIT         0
+  #define LCD_WRD_WRDS_MASK        (0xFFFFFFFF << LCD_WRD_WRDS_BIT)
+  #define LCD_WRD_WRDS_N(N)        ((((N)-1) << LCD_WRD_WRDS_BIT) & LCD_WRD_WRDS_MASK)
+
+#define LCD_PWMDIV                 (AU1100_LCD_BASE + 0x24)
+  #define LCD_PWMDIV_EN            (1<<12)
+  #define LCD_PWMDIV_PWMDIV_BIT    0
+  #define LCD_PWMDIV_PWMDIV_MASK   (0xFFF << LCD_PWMDIV_PWMDIV_BIT)
+  #define LCD_PWMDIV_PWMDIV_N(N)   ((((N)-1) << LCD_PWMDIV_PWMDIV_BIT) & LCD_PWMDIV_PWMDIV_MASK)
+
+#define LCD_PWMHI                  (AU1100_LCD_BASE + 0x28)
+  #define LCD_PWMHI_PWMHI1_BIT     12
+  #define LCD_PWMHI_PWMHI1_MASK    (0xFFF << LCD_PWMHI_PWMHI1_BIT)
+  #define LCD_PWMHI_PWMHI1_N(N)    (((N) << LCD_PWMHI_PWMHI1_BIT) & LCD_PWMHI_PWMHI1_MASK)
+  #define LCD_PWMHI_PWMHI0_BIT     0
+  #define LCD_PWMHI_PWMHI0_MASK    (0xFFF << LCD_PWMHI_PWMHI0_BIT)
+  #define LCD_PWMHI_PWMHI0_N(N)    (((N) << LCD_PWMHI_PWMHI0_BIT) & LCD_PWMHI_PWMHI0_MASK)
+
+#define LCD_PALLETTEBASE                (AU1100_LCD_BASE + 0x400)
+  #define LCD_PALLETTE_MONO_MI_BIT      0
+  #define LCD_PALLETTE_MONO_MI_MASK     (0xF << LCD_PALLETTE_MONO_MI_BIT)
+  #define LCD_PALLETTE_MONO_MI_N(N)     (((N)<< LCD_PALLETTE_MONO_MI_BIT) & LCD_PALLETTE_MONO_MI_MASK)
+
+  #define LCD_PALLETTE_COLOR_RI_BIT     8
+  #define LCD_PALLETTE_COLOR_RI_MASK    (0xF << LCD_PALLETTE_COLOR_RI_BIT)
+  #define LCD_PALLETTE_COLOR_RI_N(N)    (((N)<< LCD_PALLETTE_COLOR_RI_BIT) & LCD_PALLETTE_COLOR_RI_MASK)
+  #define LCD_PALLETTE_COLOR_GI_BIT     4
+  #define LCD_PALLETTE_COLOR_GI_MASK    (0xF << LCD_PALLETTE_COLOR_GI_BIT)
+  #define LCD_PALLETTE_COLOR_GI_N(N)    (((N)<< LCD_PALLETTE_COLOR_GI_BIT) & LCD_PALLETTE_COLOR_GI_MASK)
+  #define LCD_PALLETTE_COLOR_BI_BIT     0
+  #define LCD_PALLETTE_COLOR_BI_MASK    (0xF << LCD_PALLETTE_COLOR_BI_BIT)
+  #define LCD_PALLETTE_COLOR_BI_N(N)    (((N)<< LCD_PALLETTE_COLOR_BI_BIT) & LCD_PALLETTE_COLOR_BI_MASK)
+
+  #define LCD_PALLETTE_TFT_DC_BIT       0
+  #define LCD_PALLETTE_TFT_DC_MASK      (0xFFFF << LCD_PALLETTE_TFT_DC_BIT)
+  #define LCD_PALLETTE_TFT_DC_N(N)      (((N)<< LCD_PALLETTE_TFT_DC_BIT) & LCD_PALLETTE_TFT_DC_MASK)
+
+/********************************************************************/
+
+/* List of panels known to work with the AU1100 LCD controller.
+ * To add a new panel, enter the same specifications as the
+ * Generic_TFT one, and MAKE SURE that it doesn't conflicts
+ * with the controller restrictions. Restrictions are:
+ *
+ * STN color panels: max_bpp <= 12
+ * STN mono panels: max_bpp <= 4
+ * TFT panels: max_bpp <= 16
+ * max_xres <= 800
+ * max_yres <= 600
  */
-struct known_lcd_panels panels[] =
+static struct au1100fb_panel known_lcd_panels[] =
 {
-	{ /* 0: Pb1100 LCDA: Sharp 320x240 TFT panel */
-		320, /* xres */
-		240, /* yres */
-		16,  /* bpp  */
-
-		"Sharp_320x240_16",
-		/* mode_control */
+	/* 800x600x16bpp CRT */
+	[0] = {
+		.name = "CRT_800x600_16",
+		.xres = 800,
+		.yres = 600,
+		.bpp = 16,
+		.control_base =	0x0004886A |
+			LCD_CONTROL_DEFAULT_PO | LCD_CONTROL_DEFAULT_SBPPF |
+			LCD_CONTROL_BPP_16,
+		.clkcontrol_base = 0x00020000,
+		.horztiming = 0x005aff1f,
+		.verttiming = 0x16000e57,
+	},
+	/* just the standard LCD */
+	[1] = {
+		.name = "WWPC LCD",
+		.xres = 240,
+		.yres = 320,
+		.bpp = 16,
+		.control_base = 0x0006806A,
+		.horztiming = 0x0A1010EF,
+		.verttiming = 0x0301013F,
+		.clkcontrol_base = 0x00018001,
+	},
+	/* Sharp 320x240 TFT panel */
+	[2] = {
+		.name = "Sharp_LQ038Q5DR01",
+		.xres = 320,
+		.yres = 240,
+		.bpp = 16,
+		.control_base =
 		( LCD_CONTROL_SBPPF_565
-		/*LCD_CONTROL_WP*/
-		/*LCD_CONTROL_WD*/
 		| LCD_CONTROL_C
 		| LCD_CONTROL_SM_0
-		/*LCD_CONTROL_DB*/
-		/*LCD_CONTROL_CCO*/
-		/*LCD_CONTROL_DP*/
-		| LCD_DEFAULT_PIX_FORMAT
-		/*LCD_CONTROL_MPI*/
+			| LCD_CONTROL_DEFAULT_PO
 		| LCD_CONTROL_PT
 		| LCD_CONTROL_PC
 		| LCD_CONTROL_BPP_16 ),
-
-		/* mode_horztiming */
+		.horztiming =
 		( LCD_HORZTIMING_HN2_N(8)
 		| LCD_HORZTIMING_HN1_N(60)
 		| LCD_HORZTIMING_HPW_N(12)
 		| LCD_HORZTIMING_PPL_N(320) ),
-
-		/* mode_verttiming */
+		.verttiming =
 		( LCD_VERTTIMING_VN2_N(5)
 		| LCD_VERTTIMING_VN1_N(17)
 		| LCD_VERTTIMING_VPW_N(1)
 		| LCD_VERTTIMING_LPP_N(240) ),
-
-		/* mode_clkcontrol */
-		( 0
-		/*LCD_CLKCONTROL_IB*/
-		/*LCD_CLKCONTROL_IC*/
-		/*LCD_CLKCONTROL_IH*/
-		/*LCD_CLKCONTROL_IV*/
-		| LCD_CLKCONTROL_PCD_N(1) ),
-
-		/* mode_pwmdiv */
-		0,
-
-		/* mode_pwmhi */
-		0,
-
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (1<<5)),
-
-		/* mode_backlight */
-		6
+		.clkcontrol_base = LCD_CLKCONTROL_PCD_N(1),
 	},
 
-	{ /* 1: Pb1100 LCDC 640x480 TFT panel */
-		640, /* xres */
-		480, /* yres */
-		16,  /* bpp  */
-
-		"Generic_640x480_16",
-
-		/* mode_control */
-		0x004806a | LCD_DEFAULT_PIX_FORMAT,
-
-		/* mode_horztiming */
-		0x3434d67f,
-
-		/* mode_verttiming */
-		0x0e0e39df,
-
-		/* mode_clkcontrol */
-		( 0
-		/*LCD_CLKCONTROL_IB*/
-		/*LCD_CLKCONTROL_IC*/
-		/*LCD_CLKCONTROL_IH*/
-		/*LCD_CLKCONTROL_IV*/
-		| LCD_CLKCONTROL_PCD_N(1) ),
-
-		/* mode_pwmdiv */
-		0,
-
-		/* mode_pwmhi */
-		0,
-
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
-
-		/* mode_backlight */
-		7
+	/* Hitachi SP14Q005 and possibly others */
+	[3] = {
+		.name = "Hitachi_SP14Qxxx",
+		.xres = 320,
+		.yres = 240,
+		.bpp = 4,
+		.control_base =
+			( LCD_CONTROL_C
+			| LCD_CONTROL_BPP_4 ),
+		.horztiming =
+			( LCD_HORZTIMING_HN2_N(1)
+			| LCD_HORZTIMING_HN1_N(1)
+			| LCD_HORZTIMING_HPW_N(1)
+			| LCD_HORZTIMING_PPL_N(320) ),
+		.verttiming =
+			( LCD_VERTTIMING_VN2_N(1)
+			| LCD_VERTTIMING_VN1_N(1)
+			| LCD_VERTTIMING_VPW_N(1)
+			| LCD_VERTTIMING_LPP_N(240) ),
+		.clkcontrol_base = LCD_CLKCONTROL_PCD_N(4),
 	},
 
-	{ /* 2: Pb1100 LCDB 640x480 PrimeView TFT panel */
-		640, /* xres */
-		480, /* yres */
-		16,  /* bpp  */
-
-		"PrimeView_640x480_16",
-
-		/* mode_control */
-		0x0004886a | LCD_DEFAULT_PIX_FORMAT,
-
-		/* mode_horztiming */
-		0x0e4bfe7f,
-
-		/* mode_verttiming */
-		0x210805df,
-
-		/* mode_clkcontrol */
-		0x00038001,
-
-		/* mode_pwmdiv */
-		0,
-
-		/* mode_pwmhi */
-		0,
-
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
-
-		/* mode_backlight */
-		7
+	/* Generic 640x480 TFT panel */
+	[4] = {
+		.name = "TFT_640x480_16",
+		.xres = 640,
+		.yres = 480,
+		.bpp = 16,
+		.control_base = 0x004806a | LCD_CONTROL_DEFAULT_PO,
+		.horztiming = 0x3434d67f,
+		.verttiming = 0x0e0e39df,
+		.clkcontrol_base = LCD_CLKCONTROL_PCD_N(1),
 	},
 
-	{ /* 3: Pb1100 800x600x16bpp NEON CRT */
-		800, /* xres */
-		600, /* yres */
-		16,  /* bpp */
-
-		"NEON_800x600_16",
-
-		/* mode_control */
-		0x0004886A | LCD_DEFAULT_PIX_FORMAT,
-
-		/* mode_horztiming */
-		0x005AFF1F,
-
-		/* mode_verttiming */
-		0x16000E57,
-
-		/* mode_clkcontrol */
-		0x00020000,
-
-		/* mode_pwmdiv */
-		0,
-
-		/* mode_pwmhi */
-		0,
-
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
-
-		/* mode_backlight */
-		7
+	 /* Pb1100 LCDB 640x480 PrimeView TFT panel */
+	[5] = {
+		.name = "PrimeView_640x480_16",
+		.xres = 640,
+		.yres = 480,
+		.bpp = 16,
+		.control_base = 0x0004886a | LCD_CONTROL_DEFAULT_PO,
+		.horztiming = 0x0e4bfe7f,
+		.verttiming = 0x210805df,
+		.clkcontrol_base = 0x00038001,
 	},
+};
 
-	{ /* 4: Pb1100 640x480x16bpp NEON CRT */
-		640, /* xres */
-		480, /* yres */
-		16,  /* bpp */
-
-		"NEON_640x480_16",
-
-		/* mode_control */
-		0x0004886A | LCD_DEFAULT_PIX_FORMAT,
-
-		/* mode_horztiming */
-		0x0052E27F,
-
-		/* mode_verttiming */
-		0x18000DDF,
-
-		/* mode_clkcontrol */
-		0x00020000,
+struct au1100fb_drv_info {
+	int	panel_idx;
+	char 	*opt_mode;
+};
 
-		/* mode_pwmdiv */
-		0,
+/********************************************************************/
 
-		/* mode_pwmhi */
-		0,
+/* Inline helpers */
 
-		/* mode_toyclksrc */
-		((1<<7) | (1<<6) | (0<<5)),
+#define panel_is_dual(panel)  (panel->control_base & LCD_CONTROL_DP)
+#define panel_is_active(panel)(panel->control_base & LCD_CONTROL_PT)
+#define panel_is_color(panel) (panel->control_base & LCD_CONTROL_PC)
+#define panel_swap_rgb(panel) (panel->control_base & LCD_CONTROL_CCO)
 
-		/* mode_backlight */
-		7
-	},
-};
 #endif /* _AU1100LCD_H */



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
