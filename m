From: stefan@datenfreihafen.org
Subject: [Patch 02/10] pxafb: Support for RGB666, RGBT666, RGB888 and RGBT888
Date: Mon, 07 Jul 2008 20:40:02 +0200
Message-ID: <20080707184126.050044363@datenfreihafen.org>
References: <20080707184000.411913919@datenfreihafen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline; filename=pxafb-18+bpp-modes.patch
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-fbdev-devel@lists.sourceforge.net

Add the .depth field to pxafb_mode_info and use it to set pixel data format
as 18(RGB666), 19(RGBT666), 24(RGB888) or 25(RGBT888)

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

PATCH FOLLOWS
KernelVersion: 2.6-arm-git pxa branch

Index: linux-2.6-arm/drivers/video/pxafb.c
===================================================================
--- linux-2.6-arm.orig/drivers/video/pxafb.c
+++ linux-2.6-arm/drivers/video/pxafb.c
@@ -227,6 +227,22 @@
 	case 4:  ret = LCCR3_4BPP; break;
 	case 8:  ret = LCCR3_8BPP; break;
 	case 16: ret = LCCR3_16BPP; break;
+	case 24:
+		switch (var->red.length + var->green.length +
+				var->blue.length + var->transp.length) {
+		case 18: ret = LCCR3_18BPP_P | LCCR3_PDFOR_3; break;
+		case 19: ret = LCCR3_19BPP_P; break;
+		}
+		break;
+	case 32:
+		switch (var->red.length + var->green.length +
+				var->blue.length + var->transp.length) {
+		case 18: ret = LCCR3_18BPP | LCCR3_PDFOR_3; break;
+		case 19: ret = LCCR3_19BPP; break;
+		case 24: ret = LCCR3_24BPP | LCCR3_PDFOR_3; break;
+		case 25: ret = LCCR3_25BPP; break;
+		}
+		break;
 	}
 	return ret;
 }
@@ -345,6 +361,41 @@
 		var->green.offset = 5;  var->green.length = 6;
 		var->blue.offset  = 0;  var->blue.length  = 5;
 		var->transp.offset = var->transp.length = 0;
+	} else if (var->bits_per_pixel > 16) {
+		struct pxafb_mode_info *mode;
+
+		mode = pxafb_getmode(inf, var);
+		if (!mode)
+			return -EINVAL;
+
+		switch (mode->depth) {
+		case 18: /* RGB666 */
+			var->transp.offset = var->transp.length     = 0;
+			var->red.offset	   = 12; var->red.length    = 6;
+			var->green.offset  = 6;  var->green.length  = 6;
+			var->blue.offset   = 0;  var->blue.length   = 6;
+			break;
+		case 19: /* RGBT666 */
+			var->transp.offset = 18; var->transp.length = 1;
+			var->red.offset	   = 12; var->red.length    = 6;
+			var->green.offset  = 6;  var->green.length  = 6;
+			var->blue.offset   = 0;  var->blue.length   = 6;
+			break;
+		case 24: /* RGB888 */
+			var->transp.offset = var->transp.length     = 0;
+			var->red.offset	   = 16; var->red.length    = 8;
+			var->green.offset  = 8;  var->green.length  = 8;
+			var->blue.offset   = 0;  var->blue.length   = 8;
+			break;
+		case 25: /* RGBT888 */
+			var->transp.offset = 24; var->transp.length = 1;
+			var->red.offset	   = 16; var->red.length    = 8;
+			var->green.offset  = 8;  var->green.length  = 8;
+			var->blue.offset   = 0;  var->blue.length   = 8;
+			break;
+		default:
+			return -EINVAL;
+		}
 	} else {
 		var->red.offset = var->green.offset = 0;
 		var->blue.offset = var->transp.offset = 0;
@@ -376,7 +427,7 @@
 	struct pxafb_info *fbi = (struct pxafb_info *)info;
 	struct fb_var_screeninfo *var = &info->var;
 
-	if (var->bits_per_pixel == 16)
+	if (var->bits_per_pixel >= 16)
 		fbi->fb.fix.visual = FB_VISUAL_TRUECOLOR;
 	else if (!fbi->cmap_static)
 		fbi->fb.fix.visual = FB_VISUAL_PSEUDOCOLOR;
@@ -391,7 +442,7 @@
 
 	fbi->fb.fix.line_length = var->xres_virtual *
 				  var->bits_per_pixel / 8;
-	if (var->bits_per_pixel == 16)
+	if (var->bits_per_pixel >= 16)
 		fbi->palette_size = 0;
 	else
 		fbi->palette_size = var->bits_per_pixel == 1 ?
@@ -404,7 +455,7 @@
 	 */
 	pxafb_set_truecolor(fbi->fb.fix.visual == FB_VISUAL_TRUECOLOR);
 
-	if (fbi->fb.var.bits_per_pixel == 16)
+	if (fbi->fb.var.bits_per_pixel >= 16)
 		fb_dealloc_cmap(&fbi->fb.cmap);
 	else
 		fb_alloc_cmap(&fbi->fb.cmap, 1<<fbi->fb.var.bits_per_pixel, 0);
@@ -831,6 +882,8 @@
 		case 4:
 		case 8:
 		case 16:
+		case 24:
+		case 32:
 			break;
 		default:
 			printk(KERN_ERR "%s: invalid bit depth %d\n",
@@ -968,6 +1021,11 @@
 
 	for (gpio = 58; ldd_bits; gpio++, ldd_bits--)
 		pxa_gpio_mode(gpio | GPIO_ALT_FN_2_OUT);
+	/* 18 bit interface */
+	if (fbi->fb.var.bits_per_pixel > 16) {
+		pxa_gpio_mode(86 | GPIO_ALT_FN_2_OUT);
+		pxa_gpio_mode(87 | GPIO_ALT_FN_2_OUT);
+	}
 	pxa_gpio_mode(GPIO74_LCD_FCLK_MD);
 	pxa_gpio_mode(GPIO75_LCD_LCLK_MD);
 	pxa_gpio_mode(GPIO76_LCD_PCLK_MD);
Index: linux-2.6-arm/include/asm-arm/arch-pxa/pxafb.h
===================================================================
--- linux-2.6-arm.orig/include/asm-arm/arch-pxa/pxafb.h
+++ linux-2.6-arm/include/asm-arm/arch-pxa/pxafb.h
@@ -71,7 +71,8 @@
 
 	u_char		bpp;
 	u_int		cmap_greyscale:1,
-			unused:31;
+			depth:8,
+			unused:23;
 
 	/* Parallel Mode Timing */
 	u_char		hsync_len;

-- 

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
