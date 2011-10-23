From: Finn Thain <fthain@telegraphics.com.au>
Date: Sun, 23 Oct 2011 14:11:10 +0000
Subject: [PATCH 02/16] macfb: fix black and white modes
Message-Id: <20111023141119.848736612@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20111023141108.856998818@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

macfb won't init in black & white modes since fb_alloc_cmap() no longer works for zero cmap length. Fix this and also clean up a few printk's and some stylistic inconsistencies.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Index: linux-m68k/drivers/video/macfb.c
=================================--- linux-m68k.orig/drivers/video/macfb.c	2011-10-22 23:02:22.000000000 +1100
+++ linux-m68k/drivers/video/macfb.c	2011-10-23 00:50:51.000000000 +1100
@@ -592,12 +592,12 @@ static int __init macfb_init(void)
 	if (!fb_info.screen_base)
 		return -ENODEV;
 
-	printk("macfb: framebuffer at 0x%08lx, mapped to 0x%p, size %dk\n",
-	       macfb_fix.smem_start, fb_info.screen_base,
-	       macfb_fix.smem_len / 1024);
-	printk("macfb: mode is %dx%dx%d, linelength=%d\n",
-	       macfb_defined.xres, macfb_defined.yres,
-	       macfb_defined.bits_per_pixel, macfb_fix.line_length);
+	pr_info("macfb: framebuffer at 0x%08lx, mapped to 0x%p, size %dk\n",
+	        macfb_fix.smem_start, fb_info.screen_base,
+	        macfb_fix.smem_len / 1024);
+	pr_info("macfb: mode is %dx%dx%d, linelength=%d\n",
+	        macfb_defined.xres, macfb_defined.yres,
+	        macfb_defined.bits_per_pixel, macfb_fix.line_length);
 
 	/* Fill in the available video resolution */
 	macfb_defined.xres_virtual = macfb_defined.xres;
@@ -613,14 +613,10 @@ static int __init macfb_init(void)
 
 	switch (macfb_defined.bits_per_pixel) {
 	case 1:
-		/*
-		 * XXX: I think this will catch any program that tries
-		 * to do FBIO_PUTCMAP when the visual is monochrome.
-		 */
 		macfb_defined.red.length = macfb_defined.bits_per_pixel;
 		macfb_defined.green.length = macfb_defined.bits_per_pixel;
 		macfb_defined.blue.length = macfb_defined.bits_per_pixel;
-		video_cmap_len = 0;
+		video_cmap_len = 2;
 		macfb_fix.visual = FB_VISUAL_MONO01;
 		break;
 	case 2:
@@ -660,11 +656,10 @@ static int __init macfb_init(void)
 		macfb_fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 	default:
-		video_cmap_len = 0;
-		macfb_fix.visual = FB_VISUAL_MONO01;
-		printk("macfb: unknown or unsupported bit depth: %d\n",
+		pr_err("macfb: unknown or unsupported bit depth: %d\n",
 		       macfb_defined.bits_per_pixel);
-		break;
+		err = -EINVAL;
+		goto fail_unmap;
 	}
 	
 	/*
@@ -734,8 +729,8 @@ static int __init macfb_init(void)
 		case MAC_MODEL_Q950:
 			strcpy(macfb_fix.id, "DAFB");
 			macfb_setpalette = dafb_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			dafb_cmap_regs = ioremap(DAFB_BASE, 0x1000);
+			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -744,8 +739,8 @@ static int __init macfb_init(void)
 		case MAC_MODEL_LCII:
 			strcpy(macfb_fix.id, "V8");
 			macfb_setpalette = v8_brazil_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
+			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -758,8 +753,8 @@ static int __init macfb_init(void)
 		case MAC_MODEL_P600:
 			strcpy(macfb_fix.id, "Brazil");
 			macfb_setpalette = v8_brazil_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
+			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -773,10 +768,10 @@ static int __init macfb_init(void)
 		case MAC_MODEL_P520:
 		case MAC_MODEL_P550:
 		case MAC_MODEL_P460:
-			macfb_setpalette = v8_brazil_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			strcpy(macfb_fix.id, "Sonora");
+			macfb_setpalette = v8_brazil_setpalette;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
+			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -786,10 +781,10 @@ static int __init macfb_init(void)
 		 */
 		case MAC_MODEL_IICI:
 		case MAC_MODEL_IISI:
-			macfb_setpalette = rbv_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			strcpy(macfb_fix.id, "RBV");
+			macfb_setpalette = rbv_setpalette;
 			rbv_cmap_regs = ioremap(DAC_BASE, 0x1000);
+			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		/*
@@ -797,10 +792,10 @@ static int __init macfb_init(void)
 		 */
 		case MAC_MODEL_Q840:
 		case MAC_MODEL_C660:
-			macfb_setpalette = civic_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			strcpy(macfb_fix.id, "Civic");
+			macfb_setpalette = civic_setpalette;
 			civic_cmap_regs = ioremap(CIVIC_BASE, 0x1000);
+			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		
@@ -809,26 +804,26 @@ static int __init macfb_init(void)
 		 * We think this may be like the LC II
 		 */
 		case MAC_MODEL_LC:
+			strcpy(macfb_fix.id, "LC");
 			if (vidtest) {
 				macfb_setpalette = v8_brazil_setpalette;
-				macfb_defined.activate = FB_ACTIVATE_NOW;
 				v8_brazil_cmap_regs  					ioremap(DAC_BASE, 0x1000);
+				macfb_defined.activate = FB_ACTIVATE_NOW;
 			}
-			strcpy(macfb_fix.id, "LC");
 			break;
 
 		/*
 		 * We think this may be like the LC II
 		 */
 		case MAC_MODEL_CCL:
+			strcpy(macfb_fix.id, "Color Classic");
 			if (vidtest) {
 				macfb_setpalette = v8_brazil_setpalette;
-				macfb_defined.activate = FB_ACTIVATE_NOW;
 				v8_brazil_cmap_regs  					ioremap(DAC_BASE, 0x1000);
+				macfb_defined.activate = FB_ACTIVATE_NOW;
 			}
-			strcpy(macfb_fix.id, "Color Classic");
 			break;
 
 		/*
@@ -893,10 +888,10 @@ static int __init macfb_init(void)
 		case MAC_MODEL_PB270C:
 		case MAC_MODEL_PB280:
 		case MAC_MODEL_PB280C:
-			macfb_setpalette = csc_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
 			strcpy(macfb_fix.id, "CSC");
+			macfb_setpalette = csc_setpalette;
 			csc_cmap_regs = ioremap(CSC_BASE, 0x1000);
+			macfb_defined.activate = FB_ACTIVATE_NOW;
 			break;
 
 		default:
@@ -918,8 +913,9 @@ static int __init macfb_init(void)
 	if (err)
 		goto fail_dealloc;
 
-	printk("fb%d: %s frame buffer device\n",
-	       fb_info.node, fb_info.fix.id);
+	pr_info("fb%d: %s frame buffer device\n",
+	        fb_info.node, fb_info.fix.id);
+
 	return 0;
 
 fail_dealloc:

