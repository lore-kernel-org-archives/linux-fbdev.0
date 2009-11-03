From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 9/13] valkyriefb: various fixes
Date: Wed, 4 Nov 2009 00:43:52 +1100 (EST)
Message-ID: <alpine.OSX.2.00.0911031500210.483@silk.local>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-m68k@vger.kernel.org

Valkyriefb and macfb will adopt the same card if they get the chance, so 
remove valkyrie support from macfb. Also fix the "valkyriefb: can't do 
832x624x8" problem reported by Raylynn Knight some time ago, by adding 
vmode 13 support for CONFIG_MAC. Also add vmode 11 since that works too. 
Make use of the monitor sense lines on 68k Macs too. Also some cleanups.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/video/macfb.c      |   53 +++------------------------------------------
 drivers/video/valkyriefb.c |    6 ++---
 drivers/video/valkyriefb.h |   31 ++++++++------------------
 3 files changed, 17 insertions(+), 73 deletions(-)

Index: linux-2.6.31/drivers/video/macfb.c
===================================================================
--- linux-2.6.31.orig/drivers/video/macfb.c	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/drivers/video/macfb.c	2009-11-03 03:23:43.000000000 +1100
@@ -55,9 +55,6 @@
 static int (*macfb_setpalette) (unsigned int regno, unsigned int red,
 				unsigned int green, unsigned int blue,
 				struct fb_info *info) = NULL;
-static int valkyrie_setpalette (unsigned int regno, unsigned int red,
-				unsigned int green, unsigned int blue,
-				struct fb_info *info);
 static int dafb_setpalette (unsigned int regno, unsigned int red,
 			    unsigned int green, unsigned int blue,
 			    struct fb_info *fb_info);
@@ -79,13 +76,6 @@ static int csc_setpalette (unsigned int 
 
 static struct {
 	unsigned char addr;
-	/* Note: word-aligned */
-	char pad[3];
-	unsigned char lut;
-} __iomem *valkyrie_cmap_regs;
-
-static struct {
-	unsigned char addr;
 	unsigned char lut;
 } __iomem *v8_brazil_cmap_regs;
 
@@ -172,33 +162,6 @@ static u32 pseudo_palette[16];
 static int inverse   = 0;
 static int vidtest   = 0;
 
-static int valkyrie_setpalette (unsigned int regno, unsigned int red,
-				unsigned int green, unsigned int blue,
-				struct fb_info *info)
-{
-	unsigned long flags;
-	
-	red >>= 8;
-	green >>= 8;
-	blue >>= 8;
-
-	local_irq_save(flags);
-	
-	/* tell clut which address to fill */
-	nubus_writeb(regno, &valkyrie_cmap_regs->addr);
-	nop();
-
-	/* send one color channel at a time */
-	nubus_writeb(red, &valkyrie_cmap_regs->lut);
-	nop();
-	nubus_writeb(green, &valkyrie_cmap_regs->lut);
-	nop();
-	nubus_writeb(blue, &valkyrie_cmap_regs->lut);
-
-	local_irq_restore(flags);
-	return 0;
-}
-
 /* Unlike the Valkyrie, the DAFB cannot set individual colormap
    registers.  Therefore, we do what the MacOS driver does (no
    kidding!) and simply set them one by one until we hit the one we
@@ -614,8 +577,6 @@ static void __init macfb_setup(char *opt
 
 static void __init iounmap_macfb(void)
 {
-	if (valkyrie_cmap_regs)
-		iounmap(valkyrie_cmap_regs);
 	if (dafb_cmap_regs)
 		iounmap(dafb_cmap_regs);
 	if (v8_brazil_cmap_regs)
@@ -642,6 +603,10 @@ static int __init macfb_init(void)
 	if (!MACH_IS_MAC) 
 		return -ENODEV;
 
+	if (mac_bi_data.id == MAC_MODEL_Q630 ||
+	    mac_bi_data.id == MAC_MODEL_P588)
+		return -ENODEV; /* See valkyriefb.c */
+
 	/* There can only be one internal video controller anyway so
 	   we're not too worried about this */
 	macfb_defined.xres = mac_bi_data.dimensions & 0xFFFF;
@@ -784,16 +749,6 @@ static int __init macfb_init(void)
 	if (!video_is_nubus)
 		switch( mac_bi_data.id )
 		{
-			/* Valkyrie Quadras */
-		case MAC_MODEL_Q630:
-			/* I'm not sure about this one */
-		case MAC_MODEL_P588:
-			strcpy(macfb_fix.id, "Valkyrie");
-			macfb_setpalette = valkyrie_setpalette;
-			macfb_defined.activate = FB_ACTIVATE_NOW;
-			valkyrie_cmap_regs = ioremap(DAC_BASE, 0x1000);
-			break;
-
 			/* DAFB Quadras */
 			/* Note: these first four have the v7 DAFB, which is
 			   known to be rather unlike the ones used in the
Index: linux-2.6.31/drivers/video/valkyriefb.c
===================================================================
--- linux-2.6.31.orig/drivers/video/valkyriefb.c	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/drivers/video/valkyriefb.c	2009-11-03 03:23:43.000000000 +1100
@@ -69,7 +69,7 @@
 #ifdef CONFIG_MAC
 /* We don't yet have functions to read the PRAM... perhaps we can
    adapt them from the PPC code? */
-static int default_vmode = VMODE_640_480_67;
+static int default_vmode = VMODE_CHOOSE;
 static int default_cmode = CMODE_8;
 #else
 static int default_vmode = VMODE_NVRAM;
@@ -326,11 +326,11 @@ int __init valkyriefb_init(void)
 
 #ifdef CONFIG_MAC
 	if (!MACH_IS_MAC)
-		return 0;
+		return -ENODEV;
 	if (!(mac_bi_data.id == MAC_MODEL_Q630
 	      /* I'm not sure about this one */
 	    || mac_bi_data.id == MAC_MODEL_P588))
-		return 0;
+		return -ENODEV;
 
 	/* Hardcoded addresses... welcome to 68k Macintosh country :-) */
 	frame_buffer_phys = 0xf9000000;
Index: linux-2.6.31/drivers/video/valkyriefb.h
===================================================================
--- linux-2.6.31.orig/drivers/video/valkyriefb.h	2009-11-03 03:23:24.000000000 +1100
+++ linux-2.6.31/drivers/video/valkyriefb.h	2009-11-03 03:23:43.000000000 +1100
@@ -134,15 +134,7 @@ static struct valkyrie_regvals valkyrie_
     { 1024, 0 },
 	1024, 768
 };
-
-/* Register values for 800x600, 72Hz mode (11) */
-static struct valkyrie_regvals valkyrie_reg_init_11 = {
-    13,
-    { 17, 27, 3 },  /* pixel clock = 49.63MHz for V=71.66Hz */
-    { 800, 0 },
-	800, 600
-};
-#endif /* CONFIG_MAC */
+#endif /* !defined CONFIG_MAC */
 
 /* Register values for 832x624, 75Hz mode (13) */
 static struct valkyrie_regvals valkyrie_reg_init_13 = {
@@ -152,6 +144,14 @@ static struct valkyrie_regvals valkyrie_
 	832, 624
 };
 
+/* Register values for 800x600, 72Hz mode (11) */
+static struct valkyrie_regvals valkyrie_reg_init_11 = {
+    13,
+    { 17, 27, 3 },  /* pixel clock = 49.63MHz for V=71.66Hz */
+    { 800, 0 },
+	800, 600
+};
+
 /* Register values for 800x600, 60Hz mode (10) */
 static struct valkyrie_regvals valkyrie_reg_init_10 = {
     12,
@@ -188,24 +188,13 @@ static struct valkyrie_regvals *valkyrie
 	NULL,
 	NULL,
 	&valkyrie_reg_init_10,
-#ifdef CONFIG_MAC
-	NULL,
-	NULL,
-	&valkyrie_reg_init_13,
-	NULL,
-	NULL,
-	NULL,
-	NULL,
-#else
 	&valkyrie_reg_init_11,
 	NULL,
 	&valkyrie_reg_init_13,
+#ifndef CONFIG_MAC
 	&valkyrie_reg_init_14,
 	&valkyrie_reg_init_15,
 	NULL,
 	&valkyrie_reg_init_17,
 #endif
-	NULL,
-	NULL,
-	NULL
 };
