From: Finn Thain <fthain@telegraphics.com.au>
Date: Thu, 14 Feb 2019 22:13:10 +0000
Subject: [PATCH] video/macfb: Remove redundant code
Message-Id: <86a3eca8946cbeb648ddbe3ff67b983ece7498d8.1550182390.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-m68k@lists.linux-m68k.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The value of info->var.bits_per_pixel get checked in macfb_setcolreg().
Remove additional checks as they are redundant.

macfb_defined.activate gets initialized to FB_ACTIVATE_NOW by the struct
initializer. Remove redundant assignments.

macfb_defined.bits_per_pixel, .width and .height all get assigned
unconditionally. Remove redundant initializers.

Cc: linux-m68k@lists.linux-m68k.org
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/video/fbdev/macfb.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/video/fbdev/macfb.c b/drivers/video/fbdev/macfb.c
index e707e617bf1c..00671055a611 100644
--- a/drivers/video/fbdev/macfb.c
+++ b/drivers/video/fbdev/macfb.c
@@ -120,10 +120,7 @@ struct jet_cmap_regs {
 #define PIXEL_TO_MM(a)	(((a)*10)/28)	/* width in mm at 72 dpi */
 
 static struct fb_var_screeninfo macfb_defined = {
-	.bits_per_pixel	= 8,
 	.activate	= FB_ACTIVATE_NOW,
-	.width		= -1,
-	.height		= -1,
 	.right_margin	= 32,
 	.upper_margin	= 16,
 	.lower_margin	= 4,
@@ -201,9 +198,6 @@ static int v8_brazil_setpalette(unsigned int regno, unsigned int red,
 	unsigned int bpp = info->var.bits_per_pixel;
 	unsigned long flags;
 
-	if (bpp > 8)
-		return 1; /* failsafe */
-
 	local_irq_save(flags);
 
 	/* On these chips, the CLUT register numbers are spread out
@@ -234,9 +228,6 @@ static int rbv_setpalette(unsigned int regno, unsigned int red,
 {
 	unsigned long flags;
 
-	if (info->var.bits_per_pixel > 8)
-		return 1; /* failsafe */
-
 	local_irq_save(flags);
 
 	/* From the VideoToolbox driver.  Seems to be saying that
@@ -353,9 +344,6 @@ static int civic_setpalette(unsigned int regno, unsigned int red,
 	unsigned long flags;
 	int clut_status;
 	
-	if (info->var.bits_per_pixel > 8)
-		return 1; /* failsafe */
-
 	local_irq_save(flags);
 
 	/* Set the register address */
@@ -688,17 +676,14 @@ static int __init macfb_init(void)
 		case NUBUS_DRHW_APPLE_MDC:
 			strcpy(macfb_fix.id, "Mac Disp. Card");
 			macfb_setpalette = mdc_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 		case NUBUS_DRHW_APPLE_TFB:
 			strcpy(macfb_fix.id, "Toby");
 			macfb_setpalette = toby_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 		case NUBUS_DRHW_APPLE_JET:
 			strcpy(macfb_fix.id, "Jet");
 			macfb_setpalette = jet_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 		default:
 			strcpy(macfb_fix.id, "Generic NuBus");
@@ -731,7 +716,6 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "DAFB");
 			macfb_setpalette = dafb_setpalette;
 			dafb_cmap_regs = ioremap(DAFB_BASE, 0x1000);
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -741,7 +725,6 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "V8");
 			macfb_setpalette = v8_brazil_setpalette;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -755,7 +738,6 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "Brazil");
 			macfb_setpalette = v8_brazil_setpalette;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -772,7 +754,6 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "Sonora");
 			macfb_setpalette = v8_brazil_setpalette;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -785,7 +766,6 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "RBV");
 			macfb_setpalette = rbv_setpalette;
 			rbv_cmap_regs = ioremap(DAC_BASE, 0x1000);
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -796,7 +776,6 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "Civic");
 			macfb_setpalette = civic_setpalette;
 			civic_cmap_regs = ioremap(CIVIC_BASE, 0x1000);
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		
@@ -810,7 +789,6 @@ static int __init macfb_init(void)
 				macfb_setpalette = v8_brazil_setpalette;
 				v8_brazil_cmap_regs  					ioremap(DAC_BASE, 0x1000);
-				macfb_defined.activate = FB_ACTIVATE_NOW;
 			}
 			break;
 
@@ -823,7 +801,6 @@ static int __init macfb_init(void)
 				macfb_setpalette = v8_brazil_setpalette;
 				v8_brazil_cmap_regs  					ioremap(DAC_BASE, 0x1000);
-				macfb_defined.activate = FB_ACTIVATE_NOW;
 			}
 			break;
 
@@ -892,7 +869,6 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "CSC");
 			macfb_setpalette = csc_setpalette;
 			csc_cmap_regs = ioremap(CSC_BASE, 0x1000);
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		default:
-- 
2.19.2
