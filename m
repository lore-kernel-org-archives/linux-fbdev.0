From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 13/13] macfb: fix 24-bit visual and stuff
Date: Wed, 4 Nov 2009 00:51:18 +1100 (EST)
Message-ID: <alpine.OSX.2.00.0911031509210.483@silk.local>
Mime-Version: 1.0
Return-path: <linux-m68k-owner@vger.kernel.org>
Sender: linux-m68k-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-m68k@vger.kernel.org

Lots of changes. Remove volatile keywords. Take the advice in the comments 
and change video_slot to slot_addr. Factor out fifteen or so "channel >> 
8" shifts into three shifts higher up the call graph. Make 
csc_setpalette() atomic, pass the correct color values. Check for 
ioremap() failure. Add missing break statement, thus fixing 24 bit console 
visual (blue background bug). Remove some uninformative printk() noise. 
Add a description for powerbook 140/170 graphics.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/video/macfb.c |  144 ++++++++++++++++++++------------------------------
 1 file changed, 60 insertions(+), 84 deletions(-)

Index: linux-2.6.31/drivers/video/macfb.c
===================================================================
--- linux-2.6.31.orig/drivers/video/macfb.c	2009-11-03 03:23:44.000000000 +1100
+++ linux-2.6.31/drivers/video/macfb.c	2009-11-03 03:23:45.000000000 +1100
@@ -120,8 +120,6 @@ struct jet_cmap_regs {
 
 #define PIXEL_TO_MM(a)	(((a)*10)/28)	/* width in mm at 72 dpi */
 
-static int  video_slot = 0;
-
 static struct fb_var_screeninfo macfb_defined = {
 	.bits_per_pixel	= 8,
 	.activate	= FB_ACTIVATE_NOW,
@@ -139,6 +137,7 @@ static struct fb_fix_screeninfo macfb_fi
 	.accel	= FB_ACCEL_NONE,
 };
 
+static void *slot_addr;
 static struct fb_info fb_info;
 static u32 pseudo_palette[16];
 static int inverse;
@@ -156,10 +155,6 @@ static int dafb_setpalette(unsigned int 
 {
 	static int lastreg = -1;
 	unsigned long flags;
-	
-	red >>= 8;
-	green >>= 8;
-	blue >>= 8;
 
 	local_irq_save(flags);
 
@@ -205,10 +200,6 @@ static int v8_brazil_setpalette(unsigned
                                 struct fb_info *info)
 {
 	unsigned int bpp = info->var.bits_per_pixel;
-	unsigned char _red  =red>>8;
-	unsigned char _green=green>>8;
-	unsigned char _blue =blue>>8;
-	unsigned char _regno;
 	unsigned long flags;
 
 	if (bpp > 8)
@@ -222,16 +213,16 @@ static int v8_brazil_setpalette(unsigned
 	 * In 4bpp, the regnos are 0x0f, 0x1f, 0x2f, etc, etc
 	 * In 2bpp, the regnos are 0x3f, 0x7f, 0xbf, 0xff
 	 */
- 	_regno = (regno << (8 - bpp)) | (0xFF >> bpp);
-	nubus_writeb(_regno, &v8_brazil_cmap_regs->addr);
+ 	regno = (regno << (8 - bpp)) | (0xFF >> bpp);
+	nubus_writeb(regno, &v8_brazil_cmap_regs->addr);
 	nop();
 
 	/* send one color channel at a time */
-	nubus_writeb(_red, &v8_brazil_cmap_regs->lut);
+	nubus_writeb(red, &v8_brazil_cmap_regs->lut);
 	nop();
-	nubus_writeb(_green, &v8_brazil_cmap_regs->lut);
+	nubus_writeb(green, &v8_brazil_cmap_regs->lut);
 	nop();
-	nubus_writeb(_blue, &v8_brazil_cmap_regs->lut);
+	nubus_writeb(blue, &v8_brazil_cmap_regs->lut);
 
 	local_irq_restore(flags);
 	return 0;
@@ -241,11 +232,6 @@ static int rbv_setpalette(unsigned int r
                           unsigned int green, unsigned int blue,
                           struct fb_info *info)
 {
-	/* use MSBs */
-	unsigned char _red  =red>>8;
-	unsigned char _green=green>>8;
-	unsigned char _blue =blue>>8;
-	unsigned char _regno;
 	unsigned long flags;
 
 	if (info->var.bits_per_pixel > 8)
@@ -257,22 +243,22 @@ static int rbv_setpalette(unsigned int r
 	 * regno #254 and #255 are the important ones for 1-bit color,
 	 * regno #252-255 are the important ones for 2-bit color, etc.
 	 */
-	_regno = regno + (256-(1 << info->var.bits_per_pixel));
+	regno += 256 - (1 << info->var.bits_per_pixel);
 
 	/* reset clut? (VideoToolbox sez "not necessary") */
 	nubus_writeb(0xFF, &rbv_cmap_regs->cntl);
 	nop();
 
 	/* tell clut which address to use. */
-	nubus_writeb(_regno, &rbv_cmap_regs->addr);
+	nubus_writeb(regno, &rbv_cmap_regs->addr);
 	nop();
 
 	/* send one color channel at a time. */
-	nubus_writeb(_red, &rbv_cmap_regs->lut);
+	nubus_writeb(red, &rbv_cmap_regs->lut);
 	nop();
-	nubus_writeb(_green, &rbv_cmap_regs->lut);
+	nubus_writeb(green, &rbv_cmap_regs->lut);
 	nop();
-	nubus_writeb(_blue, &rbv_cmap_regs->lut);
+	nubus_writeb(blue, &rbv_cmap_regs->lut);
 
 	local_irq_restore(flags);
 	return 0;
@@ -283,25 +269,19 @@ static int mdc_setpalette(unsigned int r
                           unsigned int green, unsigned int blue,
                           struct fb_info *info)
 {
-	volatile struct mdc_cmap_regs *cmap_regs =
-		nubus_slot_addr(video_slot);
-	/* use MSBs */
-	unsigned char _red  =red>>8;
-	unsigned char _green=green>>8;
-	unsigned char _blue =blue>>8;
-	unsigned char _regno=regno;
+	struct mdc_cmap_regs *cmap_regs = slot_addr;
 	unsigned long flags;
 
 	local_irq_save(flags);
 
 	/* the nop's are there to order writes. */
-	nubus_writeb(_regno, &cmap_regs->addr);
+	nubus_writeb(regno, &cmap_regs->addr);
 	nop();
-	nubus_writeb(_red, &cmap_regs->lut);
+	nubus_writeb(red, &cmap_regs->lut);
 	nop();
-	nubus_writeb(_green, &cmap_regs->lut);
+	nubus_writeb(green, &cmap_regs->lut);
 	nop();
-	nubus_writeb(_blue, &cmap_regs->lut);
+	nubus_writeb(blue, &cmap_regs->lut);
 
 	local_irq_restore(flags);
 	return 0;
@@ -312,25 +292,24 @@ static int toby_setpalette(unsigned int 
                            unsigned int green, unsigned int blue,
                            struct fb_info *info)
 {
-	volatile struct toby_cmap_regs *cmap_regs =
-		nubus_slot_addr(video_slot);
+	struct toby_cmap_regs *cmap_regs = slot_addr;
 	unsigned int bpp = info->var.bits_per_pixel;
-	/* use MSBs */
-	unsigned char _red  =~(red>>8);
-	unsigned char _green=~(green>>8);
-	unsigned char _blue =~(blue>>8);
-	unsigned char _regno = (regno << (8 - bpp)) | (0xFF >> bpp);
 	unsigned long flags;
 
+	red = ~red;
+	green = ~green;
+	blue = ~blue;
+	regno = (regno << (8 - bpp)) | (0xFF >> bpp);
+
 	local_irq_save(flags);
 
-	nubus_writeb(_regno, &cmap_regs->addr);
+	nubus_writeb(regno, &cmap_regs->addr);
 	nop();
-	nubus_writeb(_red, &cmap_regs->lut);
+	nubus_writeb(red, &cmap_regs->lut);
 	nop();
-	nubus_writeb(_green, &cmap_regs->lut);
+	nubus_writeb(green, &cmap_regs->lut);
 	nop();
-	nubus_writeb(_blue, &cmap_regs->lut);
+	nubus_writeb(blue, &cmap_regs->lut);
 
 	local_irq_restore(flags);
 	return 0;
@@ -341,23 +320,18 @@ static int jet_setpalette(unsigned int r
                           unsigned int green, unsigned int blue,
                           struct fb_info *info)
 {
-	volatile struct jet_cmap_regs *cmap_regs =
-		nubus_slot_addr(video_slot);
-	/* use MSBs */
-	unsigned char _red   = (red>>8);
-	unsigned char _green = (green>>8);
-	unsigned char _blue  = (blue>>8);
+	struct jet_cmap_regs *cmap_regs = slot_addr;
 	unsigned long flags;
 
 	local_irq_save(flags);
 
 	nubus_writeb(regno, &cmap_regs->addr);
 	nop();
-	nubus_writeb(_red, &cmap_regs->lut);
+	nubus_writeb(red, &cmap_regs->lut);
 	nop();
-	nubus_writeb(_green, &cmap_regs->lut);
+	nubus_writeb(green, &cmap_regs->lut);
 	nop();
-	nubus_writeb(_blue, &cmap_regs->lut);
+	nubus_writeb(blue, &cmap_regs->lut);
 
 	local_irq_restore(flags);
 	return 0;
@@ -384,10 +358,6 @@ static int civic_setpalette(unsigned int
 	if (info->var.bits_per_pixel > 8)
 		return 1; /* failsafe */
 
-	red   >>= 8;
-	green >>= 8;
-	blue  >>= 8;
-
 	local_irq_save(flags);
 
 	/* Set the register address */
@@ -463,11 +433,17 @@ static int csc_setpalette(unsigned int r
                           unsigned int green, unsigned int blue,
                           struct fb_info *info)
 {
-	mdelay(1);
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	udelay(1); /* mklinux on PB 5300 waits for 260 ns */
 	nubus_writeb(regno, &csc_cmap_regs->clut_waddr);
-	nubus_writeb(red,   &csc_cmap_regs->clut_data);
+	nubus_writeb(red, &csc_cmap_regs->clut_data);
 	nubus_writeb(green, &csc_cmap_regs->clut_data);
-	nubus_writeb(blue,  &csc_cmap_regs->clut_data);
+	nubus_writeb(blue, &csc_cmap_regs->clut_data);
+
+	local_irq_restore(flags);
 	return 0;
 }
 
@@ -494,8 +470,8 @@ static int macfb_setcolreg(unsigned regn
 		case 4:
 		case 8:
 			if (macfb_setpalette)
-				macfb_setpalette(regno, red, green, blue,
-						 fb_info);
+				macfb_setpalette(regno, red >> 8, green >> 8,
+				                 blue >> 8, fb_info);
 			else
 				return 1;
 			break;
@@ -612,8 +588,11 @@ static int __init macfb_init(void)
 	 * those mappings are set up, so this is in fact the safest
 	 * way to ensure that this driver will work on every possible Mac
 	 */
-	fb_info.screen_base = ioremap(mac_bi_data.videoaddr, macfb_fix.smem_len);
-	
+	fb_info.screen_base = ioremap(mac_bi_data.videoaddr,
+	                              macfb_fix.smem_len);
+	if (!fb_info.screen_base)
+		return -ENODEV;
+
 	printk("macfb: framebuffer at 0x%08lx, mapped to 0x%p, size %dk\n",
 	       macfb_fix.smem_start, fb_info.screen_base,
 	       macfb_fix.smem_len / 1024);
@@ -621,17 +600,13 @@ static int __init macfb_init(void)
 	       macfb_defined.xres, macfb_defined.yres,
 	       macfb_defined.bits_per_pixel, macfb_fix.line_length);
 
-	/*
-	 * Fill in the available video resolution
-	 */
+	/* Fill in the available video resolution */
 	macfb_defined.xres_virtual = macfb_defined.xres;
 	macfb_defined.yres_virtual = macfb_defined.yres;
 	macfb_defined.height       = PIXEL_TO_MM(macfb_defined.yres);
 	macfb_defined.width        = PIXEL_TO_MM(macfb_defined.xres);
 
-	printk("macfb: scrolling: redraw\n");
-
-	/* some dummy values for timing to make fbset happy */
+	/* Some dummy values for timing to make fbset happy */
 	macfb_defined.pixclock     = 10000000 / macfb_defined.xres *
 	                             1000 / macfb_defined.yres;
 	macfb_defined.left_margin  = (macfb_defined.xres / 8) & 0xf8;
@@ -667,8 +642,6 @@ static int __init macfb_init(void)
 		macfb_defined.green.length = 5;
 		macfb_defined.blue.offset = 0;
 		macfb_defined.blue.length = 5;
-		printk("macfb: directcolor: "
-		       "size=1:5:5:5, shift=15:10:5:0\n");
 		video_cmap_len = 16;
 		/*
 		 * Should actually be FB_VISUAL_DIRECTCOLOR, but this
@@ -684,10 +657,9 @@ static int __init macfb_init(void)
 		macfb_defined.green.length = 8;
 		macfb_defined.blue.offset = 0;
 		macfb_defined.blue.length = 8;
-		printk("macfb: truecolor: "
-		       "size=0:8:8:8, shift=0:16:8:0\n");
 		video_cmap_len = 16;
 		macfb_fix.visual = FB_VISUAL_TRUECOLOR;
+		break;
 	default:
 		video_cmap_len = 0;
 		macfb_fix.visual = FB_VISUAL_MONO01;
@@ -705,16 +677,17 @@ static int __init macfb_init(void)
 	 * code is really broken :-)
 	 */
 
-	while ((ndev = nubus_find_type(NUBUS_CAT_DISPLAY, NUBUS_TYPE_VIDEO, ndev))
-		!= NULL)
+	while ((ndev = nubus_find_type(NUBUS_CAT_DISPLAY,
+	                               NUBUS_TYPE_VIDEO, ndev)))
 	{
-		if (!(mac_bi_data.videoaddr >= ndev->board->slot_addr
-		      && (mac_bi_data.videoaddr <
-			  (unsigned long)nubus_slot_addr(ndev->board->slot+1))))
+		unsigned long base = ndev->board->slot_addr;
+
+		if (mac_bi_data.videoaddr < base ||
+		    mac_bi_data.videoaddr - base > 0xFFFFFF)
 			continue;
+
 		video_is_nubus = 1;
-		/* We should probably just use the slot address... */
-		video_slot = ndev->board->slot;
+		slot_addr = (unsigned char *)base;
 
 		switch(ndev->dr_hw) {
 		case NUBUS_DRHW_APPLE_MDC:
@@ -883,6 +856,9 @@ static int __init macfb_init(void)
 		 * really support that.
 		 */
 
+		/*
+		 * Slot 0 ROM says TIM. No external video. B&W.
+		 */
 		case MAC_MODEL_PB140:
 		case MAC_MODEL_PB145:
 		case MAC_MODEL_PB170:
