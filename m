From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 12/13] macfb: cleanup
Date: Wed, 4 Nov 2009 00:47:28 +1100 (EST)
Message-ID: <alpine.OSX.2.00.0911031507250.483@silk.local>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-m68k@vger.kernel.org

Cleanup whitespace and code style. Remove unused #includes and prototypes. 
Remove obsolete, redundant or misleading comments. Remove dead code and 
redundant initialisers.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/video/macfb.c |  586 +++++++++++++++++++++++++-------------------------
 1 file changed, 300 insertions(+), 286 deletions(-)

Index: linux-2.6.31/drivers/video/macfb.c
===================================================================
--- linux-2.6.31.orig/drivers/video/macfb.c	2009-11-03 03:23:43.000000000 +1100
+++ linux-2.6.31/drivers/video/macfb.c	2009-11-03 03:23:44.000000000 +1100
@@ -1,29 +1,33 @@
-/* macfb.c: Generic framebuffer for Macs whose colourmaps/modes we
-   don't know how to set */
-
-/* (c) 1999 David Huggins-Daines <dhd@debian.org>
-
-   Primarily based on vesafb.c, by Gerd Knorr
-   (c) 1998 Gerd Knorr <kraxel@cs.tu-berlin.de>
-
-   Also uses information and code from:
-   
-   The original macfb.c from Linux/mac68k 2.0, by Alan Cox, Juergen
-   Mellinger, Mikael Forselius, Michael Schmitz, and others.
-
-   valkyriefb.c, by Martin Costabel, Kevin Schoedel, Barry Nathan, Dan
-   Jacobowitz, Paul Mackerras, Fabio Riccardi, and Geert Uytterhoeven.
-   
-   This code is free software.  You may copy, modify, and distribute
-   it subject to the terms and conditions of the GNU General Public
-   License, version 2, or any later version, at your convenience. */
+/*
+ * macfb.c: Generic framebuffer for Macs whose colourmaps/modes we
+ * don't know how to set.
+ *
+ * (c) 1999 David Huggins-Daines <dhd@debian.org>
+ *
+ * Primarily based on vesafb.c, by Gerd Knorr
+ * (c) 1998 Gerd Knorr <kraxel@cs.tu-berlin.de>
+ *
+ * Also uses information and code from:
+ *
+ * The original macfb.c from Linux/mac68k 2.0, by Alan Cox, Juergen
+ * Mellinger, Mikael Forselius, Michael Schmitz, and others.
+ *
+ * valkyriefb.c, by Martin Costabel, Kevin Schoedel, Barry Nathan, Dan
+ * Jacobowitz, Paul Mackerras, Fabio Riccardi, and Geert Uytterhoeven.
+ *
+ * The VideoToolbox "Bugs" web page at
+ * http://rajsky.psych.nyu.edu/Tips/VideoBugs.html
+ *
+ * This code is free software.  You may copy, modify, and distribute
+ * it subject to the terms and conditions of the GNU General Public
+ * License, version 2, or any later version, at your convenience.
+ */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/nubus.h>
 #include <linux/init.h>
@@ -31,9 +35,6 @@
 
 #include <asm/setup.h>
 #include <asm/bootinfo.h>
-#include <asm/uaccess.h>
-#include <asm/pgtable.h>
-#include <asm/irq.h>
 #include <asm/macintosh.h>
 #include <asm/io.h>
 
@@ -44,7 +45,7 @@
 #define DAFB_BASE 0xf9800200
 
 /* Address for the built-in Civic framebuffer in Quadra AVs */
-#define CIVIC_BASE 0x50f30800	/* Only tested on 660AV! */
+#define CIVIC_BASE 0x50f30800
 
 /* GSC (Gray Scale Controller) base address */
 #define GSC_BASE 0x50F20000
@@ -52,27 +53,9 @@
 /* CSC (Color Screen Controller) base address */
 #define CSC_BASE 0x50F20000
 
-static int (*macfb_setpalette) (unsigned int regno, unsigned int red,
-				unsigned int green, unsigned int blue,
-				struct fb_info *info) = NULL;
-static int dafb_setpalette (unsigned int regno, unsigned int red,
-			    unsigned int green, unsigned int blue,
-			    struct fb_info *fb_info);
-static int rbv_setpalette (unsigned int regno, unsigned int red,
-			   unsigned int green, unsigned int blue,
-			   struct fb_info *fb_info);
-static int mdc_setpalette (unsigned int regno, unsigned int red,
-			   unsigned int green, unsigned int blue,
-			   struct fb_info *fb_info);
-static int toby_setpalette (unsigned int regno, unsigned int red,
-			    unsigned int green, unsigned int blue,
-			    struct fb_info *fb_info);
-static int civic_setpalette (unsigned int regno, unsigned int red,
-			     unsigned int green, unsigned int blue,
-			     struct fb_info *fb_info);
-static int csc_setpalette (unsigned int regno, unsigned int red,
-			   unsigned int green, unsigned int blue,
-			   struct fb_info *fb_info);
+static int (*macfb_setpalette)(unsigned int regno, unsigned int red,
+                               unsigned int green, unsigned int blue,
+                               struct fb_info *info);
 
 static struct {
 	unsigned char addr;
@@ -106,15 +89,15 @@ static struct {
 } __iomem *civic_cmap_regs;
 
 static struct {
-	char    pad1[0x40];
-        unsigned char	clut_waddr;	/* 0x40 */
-        char    pad2;
-        unsigned char	clut_data;	/* 0x42 */
-        char	pad3[0x3];
-        unsigned char	clut_raddr;	/* 0x46 */
+	char pad1[0x40];
+	unsigned char clut_waddr;	/* 0x40 */
+	char pad2;
+	unsigned char clut_data;	/* 0x42 */
+	char pad3[0x3];
+	unsigned char clut_raddr;	/* 0x46 */
 } __iomem *csc_cmap_regs;
 
-/* We will leave these the way they are for the time being */
+/* The registers in these structs are in NuBus slot space */
 struct mdc_cmap_regs {
 	char pad1[0x200200];
 	unsigned char addr;
@@ -135,13 +118,12 @@ struct jet_cmap_regs {
 	unsigned char lut;
 };
 
-#define PIXEL_TO_MM(a)	(((a)*10)/28)	/* width in mm at 72 dpi */	
+#define PIXEL_TO_MM(a)	(((a)*10)/28)	/* width in mm at 72 dpi */
 
-/* mode */
 static int  video_slot = 0;
 
 static struct fb_var_screeninfo macfb_defined = {
-	.bits_per_pixel	= 8,	
+	.bits_per_pixel	= 8,
 	.activate	= FB_ACTIVATE_NOW,
 	.width		= -1,
 	.height		= -1,
@@ -159,19 +141,19 @@ static struct fb_fix_screeninfo macfb_fi
 
 static struct fb_info fb_info;
 static u32 pseudo_palette[16];
-static int inverse   = 0;
-static int vidtest   = 0;
+static int inverse;
+static int vidtest;
 
-/* Unlike the Valkyrie, the DAFB cannot set individual colormap
-   registers.  Therefore, we do what the MacOS driver does (no
-   kidding!) and simply set them one by one until we hit the one we
-   want. */
-static int dafb_setpalette (unsigned int regno, unsigned int red,
-			    unsigned int green, unsigned int blue,
-			    struct fb_info *info)
+/*
+ * Unlike the Valkyrie, the DAFB cannot set individual colormap
+ * registers.  Therefore, we do what the MacOS driver does (no
+ * kidding!) and simply set them one by one until we hit the one we
+ * want.
+ */
+static int dafb_setpalette(unsigned int regno, unsigned int red,
+                           unsigned int green, unsigned int blue,
+                           struct fb_info *info)
 {
-	/* FIXME: really, really need to use ioremap() here,
-           phys_to_virt() doesn't work anymore */
 	static int lastreg = -1;
 	unsigned long flags;
 	
@@ -180,42 +162,47 @@ static int dafb_setpalette (unsigned int
 	blue >>= 8;
 
 	local_irq_save(flags);
-	
-	/* fbdev will set an entire colourmap, but X won't.  Hopefully
-	   this should accommodate both of them */
-	if (regno != lastreg+1) {
+
+	/*
+	 * fbdev will set an entire colourmap, but X won't.  Hopefully
+	 * this should accommodate both of them
+	 */
+	if (regno != lastreg + 1) {
 		int i;
-		
+
 		/* Stab in the dark trying to reset the CLUT pointer */
 		nubus_writel(0, &dafb_cmap_regs->reset);
 		nop();
-		
+
 		/* Loop until we get to the register we want */
 		for (i = 0; i < regno; i++) {
-			nubus_writeb(info->cmap.red[i] >> 8, &dafb_cmap_regs->lut);
+			nubus_writeb(info->cmap.red[i] >> 8,
+			             &dafb_cmap_regs->lut);
 			nop();
-			nubus_writeb(info->cmap.green[i] >> 8, &dafb_cmap_regs->lut);
+			nubus_writeb(info->cmap.green[i] >> 8,
+			             &dafb_cmap_regs->lut);
 			nop();
-			nubus_writeb(info->cmap.blue[i] >> 8, &dafb_cmap_regs->lut);
+			nubus_writeb(info->cmap.blue[i] >> 8,
+			             &dafb_cmap_regs->lut);
 			nop();
 		}
 	}
-		
+
 	nubus_writeb(red, &dafb_cmap_regs->lut);
 	nop();
 	nubus_writeb(green, &dafb_cmap_regs->lut);
 	nop();
 	nubus_writeb(blue, &dafb_cmap_regs->lut);
-	
+
 	local_irq_restore(flags);
 	lastreg = regno;
 	return 0;
 }
 
 /* V8 and Brazil seem to use the same DAC.  Sonora does as well. */
-static int v8_brazil_setpalette (unsigned int regno, unsigned int red,
-				 unsigned int green, unsigned int blue,
-				 struct fb_info *info)	
+static int v8_brazil_setpalette(unsigned int regno, unsigned int red,
+                                unsigned int green, unsigned int blue,
+                                struct fb_info *info)
 {
 	unsigned int bpp = info->var.bits_per_pixel;
 	unsigned char _red  =red>>8;
@@ -224,33 +211,35 @@ static int v8_brazil_setpalette (unsigne
 	unsigned char _regno;
 	unsigned long flags;
 
-	if (bpp > 8) return 1; /* failsafe */
+	if (bpp > 8)
+		return 1; /* failsafe */
 
 	local_irq_save(flags);
 
 	/* On these chips, the CLUT register numbers are spread out
-	   across the register space.  Thus:
-
-	   In 8bpp, all regnos are valid.
-	   
-	   In 4bpp, the regnos are 0x0f, 0x1f, 0x2f, etc, etc
-	   
-	   In 2bpp, the regnos are 0x3f, 0x7f, 0xbf, 0xff */
-  	_regno = (regno << (8 - bpp)) | (0xFF >> bpp);
-	nubus_writeb(_regno, &v8_brazil_cmap_regs->addr); nop();
+	 * across the register space.  Thus:
+	 * In 8bpp, all regnos are valid.
+	 * In 4bpp, the regnos are 0x0f, 0x1f, 0x2f, etc, etc
+	 * In 2bpp, the regnos are 0x3f, 0x7f, 0xbf, 0xff
+	 */
+ 	_regno = (regno << (8 - bpp)) | (0xFF >> bpp);
+	nubus_writeb(_regno, &v8_brazil_cmap_regs->addr);
+	nop();
 
 	/* send one color channel at a time */
-	nubus_writeb(_red, &v8_brazil_cmap_regs->lut); nop();
-	nubus_writeb(_green, &v8_brazil_cmap_regs->lut); nop();
+	nubus_writeb(_red, &v8_brazil_cmap_regs->lut);
+	nop();
+	nubus_writeb(_green, &v8_brazil_cmap_regs->lut);
+	nop();
 	nubus_writeb(_blue, &v8_brazil_cmap_regs->lut);
 
-	local_irq_restore(flags);	
+	local_irq_restore(flags);
 	return 0;
 }
 
-static int rbv_setpalette (unsigned int regno, unsigned int red,
-			   unsigned int green, unsigned int blue,
-			   struct fb_info *info)
+static int rbv_setpalette(unsigned int regno, unsigned int red,
+                          unsigned int green, unsigned int blue,
+                          struct fb_info *info)
 {
 	/* use MSBs */
 	unsigned char _red  =red>>8;
@@ -259,10 +248,11 @@ static int rbv_setpalette (unsigned int 
 	unsigned char _regno;
 	unsigned long flags;
 
-	if (info->var.bits_per_pixel > 8) return 1; /* failsafe */
+	if (info->var.bits_per_pixel > 8)
+		return 1; /* failsafe */
 
 	local_irq_save(flags);
-	
+
 	/* From the VideoToolbox driver.  Seems to be saying that
 	 * regno #254 and #255 are the important ones for 1-bit color,
 	 * regno #252-255 are the important ones for 2-bit color, etc.
@@ -270,24 +260,28 @@ static int rbv_setpalette (unsigned int 
 	_regno = regno + (256-(1 << info->var.bits_per_pixel));
 
 	/* reset clut? (VideoToolbox sez "not necessary") */
-	nubus_writeb(0xFF, &rbv_cmap_regs->cntl); nop();
-	
+	nubus_writeb(0xFF, &rbv_cmap_regs->cntl);
+	nop();
+
 	/* tell clut which address to use. */
-	nubus_writeb(_regno, &rbv_cmap_regs->addr); nop();
-	
+	nubus_writeb(_regno, &rbv_cmap_regs->addr);
+	nop();
+
 	/* send one color channel at a time. */
-	nubus_writeb(_red,   &rbv_cmap_regs->lut); nop();
-	nubus_writeb(_green, &rbv_cmap_regs->lut); nop();
-	nubus_writeb(_blue,  &rbv_cmap_regs->lut);
-	
-	local_irq_restore(flags); /* done. */
+	nubus_writeb(_red, &rbv_cmap_regs->lut);
+	nop();
+	nubus_writeb(_green, &rbv_cmap_regs->lut);
+	nop();
+	nubus_writeb(_blue, &rbv_cmap_regs->lut);
+
+	local_irq_restore(flags);
 	return 0;
 }
 
-/* Macintosh Display Card (8x24) */
+/* Macintosh Display Card (8*24) */
 static int mdc_setpalette(unsigned int regno, unsigned int red,
-			  unsigned int green, unsigned int blue,
-			  struct fb_info *info)
+                          unsigned int green, unsigned int blue,
+                          struct fb_info *info)
 {
 	volatile struct mdc_cmap_regs *cmap_regs =
 		nubus_slot_addr(video_slot);
@@ -299,11 +293,14 @@ static int mdc_setpalette(unsigned int r
 	unsigned long flags;
 
 	local_irq_save(flags);
-	
+
 	/* the nop's are there to order writes. */
-	nubus_writeb(_regno, &cmap_regs->addr); nop();
-	nubus_writeb(_red, &cmap_regs->lut);    nop();
-	nubus_writeb(_green, &cmap_regs->lut);  nop();
+	nubus_writeb(_regno, &cmap_regs->addr);
+	nop();
+	nubus_writeb(_red, &cmap_regs->lut);
+	nop();
+	nubus_writeb(_green, &cmap_regs->lut);
+	nop();
 	nubus_writeb(_blue, &cmap_regs->lut);
 
 	local_irq_restore(flags);
@@ -312,8 +309,8 @@ static int mdc_setpalette(unsigned int r
 
 /* Toby frame buffer */
 static int toby_setpalette(unsigned int regno, unsigned int red,
-			   unsigned int green, unsigned int blue,
-			   struct fb_info *info) 
+                           unsigned int green, unsigned int blue,
+                           struct fb_info *info)
 {
 	volatile struct toby_cmap_regs *cmap_regs =
 		nubus_slot_addr(video_slot);
@@ -326,10 +323,13 @@ static int toby_setpalette(unsigned int 
 	unsigned long flags;
 
 	local_irq_save(flags);
-		
-	nubus_writeb(_regno, &cmap_regs->addr); nop();
-	nubus_writeb(_red, &cmap_regs->lut);    nop();
-	nubus_writeb(_green, &cmap_regs->lut);  nop();
+
+	nubus_writeb(_regno, &cmap_regs->addr);
+	nop();
+	nubus_writeb(_red, &cmap_regs->lut);
+	nop();
+	nubus_writeb(_green, &cmap_regs->lut);
+	nop();
 	nubus_writeb(_blue, &cmap_regs->lut);
 
 	local_irq_restore(flags);
@@ -338,8 +338,8 @@ static int toby_setpalette(unsigned int 
 
 /* Jet frame buffer */
 static int jet_setpalette(unsigned int regno, unsigned int red,
-			  unsigned int green, unsigned int blue,
-			  struct fb_info *info)
+                          unsigned int green, unsigned int blue,
+                          struct fb_info *info)
 {
 	volatile struct jet_cmap_regs *cmap_regs =
 		nubus_slot_addr(video_slot);
@@ -350,10 +350,13 @@ static int jet_setpalette(unsigned int r
 	unsigned long flags;
 
 	local_irq_save(flags);
-	
-	nubus_writeb(regno, &cmap_regs->addr); nop();
-	nubus_writeb(_red, &cmap_regs->lut); nop();
-	nubus_writeb(_green, &cmap_regs->lut); nop();
+
+	nubus_writeb(regno, &cmap_regs->addr);
+	nop();
+	nubus_writeb(_red, &cmap_regs->lut);
+	nop();
+	nubus_writeb(_green, &cmap_regs->lut);
+	nop();
 	nubus_writeb(_blue, &cmap_regs->lut);
 
 	local_irq_restore(flags);
@@ -363,53 +366,33 @@ static int jet_setpalette(unsigned int r
 /*
  * Civic framebuffer -- Quadra AV built-in video.  A chip
  * called Sebastian holds the actual color palettes, and
- * apparently, there are two different banks of 512K RAM 
+ * apparently, there are two different banks of 512K RAM
  * which can act as separate framebuffers for doing video
  * input and viewing the screen at the same time!  The 840AV
- * Can add another 1MB RAM to give the two framebuffers 
+ * Can add another 1MB RAM to give the two framebuffers
  * 1MB RAM apiece.
  *
  * FIXME: this doesn't seem to work anymore.
  */
-static int civic_setpalette (unsigned int regno, unsigned int red,
-			     unsigned int green, unsigned int blue,
-			     struct fb_info *info)
+static int civic_setpalette(unsigned int regno, unsigned int red,
+                            unsigned int green, unsigned int blue,
+                            struct fb_info *info)
 {
-	static int lastreg = -1;
 	unsigned long flags;
 	int clut_status;
 	
-	if (info->var.bits_per_pixel > 8) return 1; /* failsafe */
+	if (info->var.bits_per_pixel > 8)
+		return 1; /* failsafe */
 
 	red   >>= 8;
 	green >>= 8;
 	blue  >>= 8;
 
 	local_irq_save(flags);
-	
-	/*
-	 * Set the register address
-	 */
-	nubus_writeb(regno, &civic_cmap_regs->addr); nop();
 
-	/*
-	 * Wait for VBL interrupt here;
-	 * They're usually not enabled from Penguin, so we won't check
-	 */
-#if 0
-	{
-#define CIVIC_VBL_OFFSET	0x120
-		volatile unsigned long *vbl = nubus_readl(civic_cmap_regs->vbl_addr + CIVIC_VBL_OFFSET);
-		/* do interrupt setup stuff here? */
-		*vbl = 0L; nop();	/* clear */
-		*vbl = 1L; nop();	/* set */
-		while (*vbl != 0L)	/* wait for next vbl */
-		{
-			usleep(10);	/* needed? */
-		}
-		/* do interrupt shutdown stuff here? */
-	}
-#endif
+	/* Set the register address */
+	nubus_writeb(regno, &civic_cmap_regs->addr);
+	nop();
 
 	/*
 	 * Grab a status word and do some checking;
@@ -422,39 +405,52 @@ static int civic_setpalette (unsigned in
 #if 0
 		if ((clut_status & 0x000D) != 0)
 		{
-			nubus_writeb(0x00, &civic_cmap_regs->lut); nop();
-			nubus_writeb(0x00, &civic_cmap_regs->lut); nop();
+			nubus_writeb(0x00, &civic_cmap_regs->lut);
+			nop();
+			nubus_writeb(0x00, &civic_cmap_regs->lut);
+			nop();
 		}
 #endif
 
-		nubus_writeb(  red, &civic_cmap_regs->lut); nop();
-		nubus_writeb(green, &civic_cmap_regs->lut); nop();
-		nubus_writeb( blue, &civic_cmap_regs->lut); nop();
-		nubus_writeb( 0x00, &civic_cmap_regs->lut); nop();
+		nubus_writeb(red, &civic_cmap_regs->lut);
+		nop();
+		nubus_writeb(green, &civic_cmap_regs->lut);
+		nop();
+		nubus_writeb(blue, &civic_cmap_regs->lut);
+		nop();
+		nubus_writeb(0x00, &civic_cmap_regs->lut);
 	}
 	else
 	{
 		unsigned char junk;
 
-		junk = nubus_readb(&civic_cmap_regs->lut); nop();
-		junk = nubus_readb(&civic_cmap_regs->lut); nop();
-		junk = nubus_readb(&civic_cmap_regs->lut); nop();
-		junk = nubus_readb(&civic_cmap_regs->lut); nop();
+		junk = nubus_readb(&civic_cmap_regs->lut);
+		nop();
+		junk = nubus_readb(&civic_cmap_regs->lut);
+		nop();
+		junk = nubus_readb(&civic_cmap_regs->lut);
+		nop();
+		junk = nubus_readb(&civic_cmap_regs->lut);
+		nop();
 
 		if ((clut_status & 0x000D) != 0)
 		{
-			nubus_writeb(0x00, &civic_cmap_regs->lut); nop();
-			nubus_writeb(0x00, &civic_cmap_regs->lut); nop();
+			nubus_writeb(0x00, &civic_cmap_regs->lut);
+			nop();
+			nubus_writeb(0x00, &civic_cmap_regs->lut);
+			nop();
 		}
 
-		nubus_writeb(  red, &civic_cmap_regs->lut); nop();
-		nubus_writeb(green, &civic_cmap_regs->lut); nop();
-		nubus_writeb( blue, &civic_cmap_regs->lut); nop();
-		nubus_writeb( junk, &civic_cmap_regs->lut); nop();
+		nubus_writeb(red, &civic_cmap_regs->lut);
+		nop();
+		nubus_writeb(green, &civic_cmap_regs->lut);
+		nop();
+		nubus_writeb(blue, &civic_cmap_regs->lut);
+		nop();
+		nubus_writeb(junk, &civic_cmap_regs->lut);
 	}
 
 	local_irq_restore(flags);
-	lastreg = regno;
 	return 0;
 }
 
@@ -463,10 +459,9 @@ static int civic_setpalette (unsigned in
  * (and the 5300 too, but that's a PowerMac). This function
  * brought to you in part by the ECSC driver for MkLinux.
  */
-
-static int csc_setpalette (unsigned int regno, unsigned int red,
-			   unsigned int green, unsigned int blue,
-			   struct fb_info *info)
+static int csc_setpalette(unsigned int regno, unsigned int red,
+                          unsigned int green, unsigned int blue,
+                          struct fb_info *info)
 {
 	mdelay(1);
 	nubus_writeb(regno, &csc_cmap_regs->clut_waddr);
@@ -477,14 +472,14 @@ static int csc_setpalette (unsigned int 
 }
 
 static int macfb_setcolreg(unsigned regno, unsigned red, unsigned green,
-			   unsigned blue, unsigned transp,
-			   struct fb_info *fb_info)
+                           unsigned blue, unsigned transp,
+                           struct fb_info *fb_info)
 {
 	/*
-	 *  Set a single color register. The values supplied are
-	 *  already rounded down to the hardware's capabilities
-	 *  (according to the entries in the `var' structure). Return
-	 *  != 0 for invalid regno.
+	 * Set a single color register. The values supplied are
+	 * already rounded down to the hardware's capabilities
+	 * (according to the entries in the `var' structure).
+	 * Return non-zero for invalid regno.
 	 */
 	
 	if (regno >= fb_info->cmap.len)
@@ -518,28 +513,22 @@ static int macfb_setcolreg(unsigned regn
 			} else {
 				/* 0:5:6:5 */
 				((u32*) (fb_info->pseudo_palette))[regno] =
-					((red   & 0xf800)      ) |
+					((red   & 0xf800) >>  0) |
 					((green & 0xfc00) >>  5) |
 					((blue  & 0xf800) >> 11);
 			}
 			break;
-			/* I'm pretty sure that one or the other of these
-			   doesn't exist on 68k Macs */
+		/*
+		 * 24-bit colour almost doesn't exist on 68k Macs --
+		 * http://support.apple.com/kb/TA28634 (Old Article: 10992)
+		 */
 		case 24:
-			red   >>= 8;
-			green >>= 8;
-			blue  >>= 8;
-			((u32 *)(fb_info->pseudo_palette))[regno] =
-				(red   << fb_info->var.red.offset)   |
-				(green << fb_info->var.green.offset) |
-				(blue  << fb_info->var.blue.offset);
-			break;
 		case 32:
 			red   >>= 8;
 			green >>= 8;
 			blue  >>= 8;
 			((u32 *)(fb_info->pseudo_palette))[regno] =
-				(red   << fb_info->var.red.offset)   |
+				(red   << fb_info->var.red.offset) |
 				(green << fb_info->var.green.offset) |
 				(blue  << fb_info->var.blue.offset);
 			break;
@@ -560,18 +549,19 @@ static struct fb_ops macfb_ops = {
 static void __init macfb_setup(char *options)
 {
 	char *this_opt;
-	
+
 	if (!options || !*options)
 		return;
-	
+
 	while ((this_opt = strsep(&options, ",")) != NULL) {
-		if (!*this_opt) continue;
-		
-		if (! strcmp(this_opt, "inverse"))
-			inverse=1;
-		/* This means "turn on experimental CLUT code" */
-		else if (!strcmp(this_opt, "vidtest"))
-			vidtest=1;
+		if (!*this_opt)
+			continue;
+
+		if (!strcmp(this_opt, "inverse"))
+			inverse = 1;
+		else
+			if (!strcmp(this_opt, "vidtest"))
+				vidtest = 1; /* enable experimental CLUT code */
 	}
 }
 
@@ -607,48 +597,52 @@ static int __init macfb_init(void)
 	    mac_bi_data.id == MAC_MODEL_P588)
 		return -ENODEV; /* See valkyriefb.c */
 
-	/* There can only be one internal video controller anyway so
-	   we're not too worried about this */
 	macfb_defined.xres = mac_bi_data.dimensions & 0xFFFF;
 	macfb_defined.yres = mac_bi_data.dimensions >> 16;
 	macfb_defined.bits_per_pixel = mac_bi_data.videodepth;
+
 	macfb_fix.line_length = mac_bi_data.videorow;
-	macfb_fix.smem_len = macfb_fix.line_length * macfb_defined.yres;
+	macfb_fix.smem_len    = macfb_fix.line_length * macfb_defined.yres;
 	/* Note: physical address (since 2.1.127) */
-	macfb_fix.smem_start = mac_bi_data.videoaddr;
-	/* This is actually redundant with the initial mappings.
-	   However, there are some non-obvious aspects to the way
-	   those mappings are set up, so this is in fact the safest
-	   way to ensure that this driver will work on every possible
-	   Mac */
+	macfb_fix.smem_start  = mac_bi_data.videoaddr;
+
+	/*
+	 * This is actually redundant with the initial mappings.
+	 * However, there are some non-obvious aspects to the way
+	 * those mappings are set up, so this is in fact the safest
+	 * way to ensure that this driver will work on every possible Mac
+	 */
 	fb_info.screen_base = ioremap(mac_bi_data.videoaddr, macfb_fix.smem_len);
 	
 	printk("macfb: framebuffer at 0x%08lx, mapped to 0x%p, size %dk\n",
-	       macfb_fix.smem_start, fb_info.screen_base, macfb_fix.smem_len/1024);
+	       macfb_fix.smem_start, fb_info.screen_base,
+	       macfb_fix.smem_len / 1024);
 	printk("macfb: mode is %dx%dx%d, linelength=%d\n",
-	       macfb_defined.xres, macfb_defined.yres, macfb_defined.bits_per_pixel, macfb_fix.line_length);
-	
+	       macfb_defined.xres, macfb_defined.yres,
+	       macfb_defined.bits_per_pixel, macfb_fix.line_length);
+
 	/*
-	 *	Fill in the available video resolution
+	 * Fill in the available video resolution
 	 */
-	 
-	macfb_defined.xres_virtual   = macfb_defined.xres;
-	macfb_defined.yres_virtual   = macfb_defined.yres;
-	macfb_defined.height = PIXEL_TO_MM(macfb_defined.yres);
-	macfb_defined.width  = PIXEL_TO_MM(macfb_defined.xres);	 
+	macfb_defined.xres_virtual = macfb_defined.xres;
+	macfb_defined.yres_virtual = macfb_defined.yres;
+	macfb_defined.height       = PIXEL_TO_MM(macfb_defined.yres);
+	macfb_defined.width        = PIXEL_TO_MM(macfb_defined.xres);
 
 	printk("macfb: scrolling: redraw\n");
-	macfb_defined.yres_virtual = macfb_defined.yres;
 
 	/* some dummy values for timing to make fbset happy */
-	macfb_defined.pixclock     = 10000000 / macfb_defined.xres * 1000 / macfb_defined.yres;
+	macfb_defined.pixclock     = 10000000 / macfb_defined.xres *
+	                             1000 / macfb_defined.yres;
 	macfb_defined.left_margin  = (macfb_defined.xres / 8) & 0xf8;
 	macfb_defined.hsync_len    = (macfb_defined.xres / 8) & 0xf8;
 
 	switch (macfb_defined.bits_per_pixel) {
 	case 1:
-		/* XXX: I think this will catch any program that tries
-		   to do FBIO_PUTCMAP when the visual is monochrome */
+		/*
+		 * XXX: I think this will catch any program that tries
+		 * to do FBIO_PUTCMAP when the visual is monochrome.
+		 */
 		macfb_defined.red.length = macfb_defined.bits_per_pixel;
 		macfb_defined.green.length = macfb_defined.bits_per_pixel;
 		macfb_defined.blue.length = macfb_defined.bits_per_pixel;
@@ -676,14 +670,14 @@ static int __init macfb_init(void)
 		printk("macfb: directcolor: "
 		       "size=1:5:5:5, shift=15:10:5:0\n");
 		video_cmap_len = 16;
-		/* Should actually be FB_VISUAL_DIRECTCOLOR, but this
-		   works too */
+		/*
+		 * Should actually be FB_VISUAL_DIRECTCOLOR, but this
+		 * works too
+		 */
 		macfb_fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 	case 24:
 	case 32:
-		/* XXX: have to test these... can any 68k Macs
-		   actually do this on internal video? */
 		macfb_defined.red.offset = 16;
 		macfb_defined.red.length = 8;
 		macfb_defined.green.offset = 8;
@@ -697,18 +691,19 @@ static int __init macfb_init(void)
 	default:
 		video_cmap_len = 0;
 		macfb_fix.visual = FB_VISUAL_MONO01;
-		printk("macfb: unknown or unsupported bit depth: %d\n", macfb_defined.bits_per_pixel);
+		printk("macfb: unknown or unsupported bit depth: %d\n",
+		       macfb_defined.bits_per_pixel);
 		break;
 	}
 	
-	/* Hardware dependent stuff */
-	/*  We take a wild guess that if the video physical address is
-	 *  in nubus slot space, that the nubus card is driving video.
-	 *  Penguin really ought to tell us whether we are using internal
-	 *  video or not.
+	/*
+	 * We take a wild guess that if the video physical address is
+	 * in nubus slot space, that the nubus card is driving video.
+	 * Penguin really ought to tell us whether we are using internal
+	 * video or not.
+	 * Hopefully we only find one of them.  Otherwise our NuBus
+	 * code is really broken :-)
 	 */
-	/* Hopefully we only find one of them.  Otherwise our NuBus
-           code is really broken :-) */
 
 	while ((ndev = nubus_find_type(NUBUS_CAT_DISPLAY, NUBUS_TYPE_VIDEO, ndev))
 		!= NULL)
@@ -736,7 +731,7 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "Jet");
 			macfb_setpalette = jet_setpalette;
 			macfb_defined.activate = FB_ACTIVATE_NOW;
-			break;			
+			break;
 		default:
 			strcpy(macfb_fix.id, "Generic NuBus");
 			break;
@@ -744,20 +739,19 @@ static int __init macfb_init(void)
 	}
 
 	/* If it's not a NuBus card, it must be internal video */
-	/* FIXME: this function is getting way too big.  (this driver
-           is too...) */
 	if (!video_is_nubus)
-		switch( mac_bi_data.id )
-		{
-			/* DAFB Quadras */
-			/* Note: these first four have the v7 DAFB, which is
-			   known to be rather unlike the ones used in the
-			   other models */
+		switch (mac_bi_data.id) {
+		/*
+		 * DAFB Quadras
+		 * Note: these first four have the v7 DAFB, which is
+		 * known to be rather unlike the ones used in the
+		 * other models
+		 */
 		case MAC_MODEL_P475:
 		case MAC_MODEL_P475F:
 		case MAC_MODEL_P575:
 		case MAC_MODEL_Q605:
-	
+
 		case MAC_MODEL_Q800:
 		case MAC_MODEL_Q650:
 		case MAC_MODEL_Q610:
@@ -772,17 +766,21 @@ static int __init macfb_init(void)
 			dafb_cmap_regs = ioremap(DAFB_BASE, 0x1000);
 			break;
 
-			/* LC II uses the V8 framebuffer */
+		/*
+		 * LC II uses the V8 framebuffer
+		 */
 		case MAC_MODEL_LCII:
 			strcpy(macfb_fix.id, "V8");
 			macfb_setpalette = v8_brazil_setpalette;
 			macfb_defined.activate = FB_ACTIVATE_NOW;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
 			break;
-		
-			/* IIvi, IIvx use the "Brazil" framebuffer (which is
-			   very much like the V8, it seems, and probably uses
-			   the same DAC) */
+
+		/*
+		 * IIvi, IIvx use the "Brazil" framebuffer (which is
+		 * very much like the V8, it seems, and probably uses
+		 * the same DAC)
+		 */
 		case MAC_MODEL_IIVI:
 		case MAC_MODEL_IIVX:
 		case MAC_MODEL_P600:
@@ -791,12 +789,14 @@ static int __init macfb_init(void)
 			macfb_defined.activate = FB_ACTIVATE_NOW;
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
 			break;
-		
-			/* LC III (and friends) use the Sonora framebuffer */
-			/* Incidentally this is also used in the non-AV models
-			   of the x100 PowerMacs */
-			/* These do in fact seem to use the same DAC interface
-			   as the LC II. */
+
+		/*
+		 * LC III (and friends) use the Sonora framebuffer
+		 * Incidentally this is also used in the non-AV models
+		 * of the x100 PowerMacs
+		 * These do in fact seem to use the same DAC interface
+		 * as the LC II.
+		 */
 		case MAC_MODEL_LCIII:
 		case MAC_MODEL_P520:
 		case MAC_MODEL_P550:
@@ -807,9 +807,11 @@ static int __init macfb_init(void)
 			v8_brazil_cmap_regs = ioremap(DAC_BASE, 0x1000);
 			break;
 
-			/* IIci and IIsi use the infamous RBV chip
-                           (the IIsi is just a rebadged and crippled
-                           IIci in a different case, BTW) */
+		/*
+		 * IIci and IIsi use the infamous RBV chip
+		 * (the IIsi is just a rebadged and crippled
+		 * IIci in a different case, BTW)
+		 */
 		case MAC_MODEL_IICI:
 		case MAC_MODEL_IISI:
 			macfb_setpalette = rbv_setpalette;
@@ -818,7 +820,9 @@ static int __init macfb_init(void)
 			rbv_cmap_regs = ioremap(DAC_BASE, 0x1000);
 			break;
 
-			/* AVs use the Civic framebuffer */
+		/*
+		 * AVs use the Civic framebuffer
+		 */
 		case MAC_MODEL_Q840:
 		case MAC_MODEL_C660:
 			macfb_setpalette = civic_setpalette;
@@ -828,15 +832,10 @@ static int __init macfb_init(void)
 			break;
 
 		
-			/* Write a setpalette function for your machine, then
-			   you can add something similar here.  These are
-			   grouped by classes of video chipsets.  Some of this
-			   information is from the VideoToolbox "Bugs" web
-			   page at
-			   http://rajsky.psych.nyu.edu/Tips/VideoBugs.html */
-
-			/* Assorted weirdos */
-			/* We think this may be like the LC II */
+		/*
+		 * Assorted weirdos
+		 * We think this may be like the LC II
+		 */
 		case MAC_MODEL_LC:
 			if (vidtest) {
 				macfb_setpalette = v8_brazil_setpalette;
@@ -846,7 +845,10 @@ static int __init macfb_init(void)
 			}
 			strcpy(macfb_fix.id, "LC");
 			break;
-			/* We think this may be like the LC II */
+
+		/*
+		 * We think this may be like the LC II
+		 */
 		case MAC_MODEL_CCL:
 			if (vidtest) {
 				macfb_setpalette = v8_brazil_setpalette;
@@ -857,23 +859,29 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "Color Classic");
 			break;
 
-			/* And we *do* mean "weirdos" */
+		/*
+		 * And we *do* mean "weirdos"
+		 */
 		case MAC_MODEL_TV:
 			strcpy(macfb_fix.id, "Mac TV");
 			break;
 
-			/* These don't have colour, so no need to worry */
+		/*
+		 * These don't have colour, so no need to worry
+		 */
 		case MAC_MODEL_SE30:
 		case MAC_MODEL_CLII:
 			strcpy(macfb_fix.id, "Monochrome");
 			break;
 
-			/* Powerbooks are particularly difficult.  Many of
-			   them have separate framebuffers for external and
-			   internal video, which is admittedly pretty cool,
-			   but will be a bit of a headache to support here.
-			   Also, many of them are grayscale, and we don't
-			   really support that. */
+		/*
+		 * Powerbooks are particularly difficult.  Many of
+		 * them have separate framebuffers for external and
+		 * internal video, which is admittedly pretty cool,
+		 * but will be a bit of a headache to support here.
+		 * Also, many of them are grayscale, and we don't
+		 * really support that.
+		 */
 
 		case MAC_MODEL_PB140:
 		case MAC_MODEL_PB145:
@@ -881,7 +889,9 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "DDC");
 			break;
 
-			/* Internal is GSC, External (if present) is ViSC */
+		/*
+		 * Internal is GSC, External (if present) is ViSC
+		 */
 		case MAC_MODEL_PB150:	/* no external video */
 		case MAC_MODEL_PB160:
 		case MAC_MODEL_PB165:
@@ -891,13 +901,17 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "GSC");
 			break;
 
-			/* Internal is TIM, External is ViSC */
+		/*
+		 * Internal is TIM, External is ViSC
+		 */
 		case MAC_MODEL_PB165C:
 		case MAC_MODEL_PB180C:
 			strcpy(macfb_fix.id, "TIM");
 			break;
 
-			/* Internal is CSC, External is Keystone+Ariel. */
+		/*
+		 * Internal is CSC, External is Keystone+Ariel.
+		 */
 		case MAC_MODEL_PB190:	/* external video is optional */
 		case MAC_MODEL_PB520:
 		case MAC_MODEL_PB250:
@@ -909,7 +923,7 @@ static int __init macfb_init(void)
 			strcpy(macfb_fix.id, "CSC");
 			csc_cmap_regs = ioremap(CSC_BASE, 0x1000);
 			break;
-		
+
 		default:
 			strcpy(macfb_fix.id, "Unknown");
 			break;
@@ -924,7 +938,7 @@ static int __init macfb_init(void)
 	err = fb_alloc_cmap(&fb_info.cmap, video_cmap_len, 0);
 	if (err)
 		goto fail_unmap;
-	
+
 	err = register_framebuffer(&fb_info);
 	if (err)
 		goto fail_dealloc;
