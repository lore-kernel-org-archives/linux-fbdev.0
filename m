From: Alex Stewart <alex@foogod.com>
Subject: [PATCH] neofb patches
Date: Tue, 20 Apr 2004 18:14:12 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040421011412.GA32047@foogod.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BG6Jh-0005pN-Sz
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 18:14:21 -0700
Received: from adsl-209-182-168-213.value.net ([209.182.168.213] helo=firestar.foogod.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1BG6Jg-0002vv-A9
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 18:14:20 -0700
Received: from firestar.foogod.com (firestar [127.0.0.1])
	by firestar.foogod.com (8.12.8/8.12.5) with ESMTP id i3L1EDlu032427
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 20 Apr 2004 18:14:13 -0700
Received: (from alex@localhost)
	by firestar.foogod.com (8.12.8/8.12.8/Submit) id i3L1EDcn032425
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 20 Apr 2004 18:14:13 -0700
Content-Disposition: inline
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


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sorry I took a little while to get these out..  Had a bit busier weekend than I
expected..

Attached are my patches for the neofb driver.  All of these are against the
2.6.5 kernel.  I'm still kinda new to the whole framebuffer subsystem, so if
I've done something horribly wrong, let me know.  

All of my testing has been against the Neomagic NM2200 (MagicMedia 256AV) chip
in my laptop.  I think all of these changes should be safe for other chips too,
although it's possible a couple of the workarounds for bugs implemented here
aren't necessary with some of the other chips and could be more carefully
special-cased..

Anyway, the attached patches are as follows:

neofb.1.copyarea.patch  - Fix copyarea positioning bug

  It appears that the naming of the NEO_BC0_X_DEC and NEO_BC0_Y_*_DEC bitflags
  is wrong, or at the very least misleading, as their behavior is not as
  one would expect from the names.  On the NM2200, NEO_BC0_X_DEC apparently
  enables both X and Y decrementing of addresses during a copy, so the
  positioning is relative to the lower right corner, not the upper right.  I
  don't know exactly what the other flags do do, but they apparently don't
  affect Y decrementing, so the case where we were setting just these flags
  without NEO_BC0_X_DEC didn't work and corrupted the data while copying (are
  these flags perhaps used differently in later chips than in the 2200 I'm
  testing against?)
 
  In any case, I didn't look into it horribly deeply, I just changed the
  routine to be a little less clever about what it tries to do (this is
  consistent with what the XFree86 driver does as well, and will hopefully work
  with all chips, whichever way they might treat these flags)

neofb.2.imageblit.patch - Fix imageblit for color images

  It looks like the imageblit routine was written with only mono blits in mind.
  This patch adds support for color image transfers (Hi Tux!).

neofb.3.16bit.patch     - Misc fixes for 16-bit mode

  Changed the visual reported for 16-bit mode from DirectColor to TrueColor,
  since we don't support changing the colormap, which means we don't really
  support DirectColor.  Also changed the palette entries for to be 32 bits wide
  even for 16-bit mode because this is what the logo code expects, and appears
  to be the correct way of doing things.

neofb.4.24bit.patch     - Make 24-bit mode work

  Added a couple of switch cases needed to make 24-bit mode actually work.
  The colormap setting code also needed to be moved to be after vgaHWRestore,
  so that the DAC would be configured properly (8-bit lookups) for 24-bit
  color before writing to the lookup table.

  Also, it looks like there's a hardware bug with the NM2200 if you try to do a
  color-expanded transfer in 24-bit mode and the width of the image is less
  than 16 pixels wide (The left few pixels of the image seem to get partially
  wrapped onto the right side.  I haven't tested all cases, actually.. I know
  it breaks with 8-pixel-width blits), so in that case we just fall back to
  cfb_imageblit instead.
 
  Actually, the imageblit bug could conceivably be there with color transfers
  too, I haven't tried it.  Would require something trying to imageblit a
  8-pixel-wide 24-bit image, in 24-bit mode.  I suspect the bug is probably
  related to the source-data width in bits and/or the hardware mono->color
  translation, though, and in either case this wouldn't be an issue for 24-bit
  color.

neofb.5.modedb.patch    - Change to use modedb for video mode selection

  Allows specifying the video mode on the kernel/insmod command line now too.


I have also attached an additional patch which is mostly, but not quite
entirely, complete.  I thought it was working until I was packaging all of
this up and discovered that it's actually intermittent.  If anybody has
suggestions for what's missing, please let me know:

neofb.6.blanking.patch  - Add support for DPMS blanking

  I just copied the logic from the XFree86 driver to add DPMS support.  This
  currently works for me some of the time and doesn't other times, and I'm
  still tracking down why.  It looks like I probably need to do something
  more in the initialization stage to turn on this functionality properly (I
  note that there are a _lot_ of registers which the BIOS and the XFree86
  driver have values set for which show up as zero under the neofb driver.  I'm
  guessing this is part of the problem.)

  (Oh, and I also changed the wording of the comments at the beginning of
  things to make a bit more sense in this context.  Between an unfortunate
  renaming one of the function parameters and the fact that the comments were
  copied from a different part of the code (and thus speak from a different
  perspective), these comments were initially very confusing to read.
  Hopefully now they are somewhat less so.)

I'm also still looking into a couple of minor "annoyance" bugs, but these
patches fix most of the real functionality deficiencies I've found so far (or
will, once I figure out why blanking is buggy.. grumble)..

Feedback is welcome.

-alex

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb.1.copyarea.patch"

--- ./drivers/video/neofb.c.copyarea	2004-04-03 19:37:24.000000000 -0800
+++ ./drivers/video/neofb.c	2004-04-20 15:22:04.012544952 -0700
@@ -1367,18 +1367,13 @@
 
 	bltCntl = NEO_BC3_FIFO_EN | NEO_BC3_SKIP_MAPPING | 0x0C0000;
 
-	if (sy < dy) {
-		sy += (area->height - 1);
-		dy += (area->height - 1);
-
-		bltCntl |= NEO_BC0_DST_Y_DEC | NEO_BC0_SRC_Y_DEC;
-	}
-
-	if (area->sx < area->dx) {
+	if ((sy < dy) || (sy == dy && sx < dx)) {
 		sx += (area->width - 1);
 		dx += (area->width - 1);
+		sy += (area->height - 1);
+		dy += (area->height - 1);
 
-		bltCntl |= NEO_BC0_X_DEC;
+		bltCntl |= NEO_BC0_DST_Y_DEC | NEO_BC0_SRC_Y_DEC | NEO_BC0_X_DEC;
 	}
 
 	src = sx * (info->var.bits_per_pixel >> 3) + sy*info->fix.line_length;

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb.2.imageblit.patch"

--- ./drivers/video/neofb.c.imageblit	2004-04-20 15:22:04.012544952 -0700
+++ ./drivers/video/neofb.c	2004-04-20 15:22:04.089533248 -0700
@@ -1394,9 +1394,23 @@
 neo2200_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct neofb_par *par = (struct neofb_par *) info->par;
+	int bltCntl_flags, data_len;
 
 	neo2200_sync(info);
 
+	if (image->depth == 1) {
+		bltCntl_flags = NEO_BC0_SRC_MONO;
+		data_len = (image->width * image->height) >> 3;
+	} else if (image->depth == info->var.bits_per_pixel) {
+		bltCntl_flags = 0;
+		data_len = (image->width * image->height) *
+		    (info->var.bits_per_pixel >> 3);
+	} else {
+		/* We don't currently support hardware acceleration if image
+		 * depth is different from display */
+		return cfb_imageblit(info, image);
+	}
+
 	switch (info->var.bits_per_pixel) {
 	case 8:
 		par->neo2200->fgColor = image->fg_color;
@@ -1411,7 +1425,7 @@
 	}
 
 	par->neo2200->bltCntl = NEO_BC0_SYS_TO_VID |
-	    NEO_BC0_SRC_MONO | NEO_BC3_SKIP_MAPPING |
+	    NEO_BC3_SKIP_MAPPING | bltCntl_flags |
 	    //                      NEO_BC3_DST_XY_ADDR |
 	    0x0c0000;
 
@@ -1424,7 +1438,7 @@
 	    (image->height << 16) | (image->width & 0xffff);
 
 	memcpy(par->mmio_vbase + 0x100000, image->data,
-	       (image->width * image->height) >> 3);
+	       data_len);
 }
 
 static void

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb.3.16bit.patch"

--- ./drivers/video/neofb.c.16bit	2004-04-20 15:22:04.089533248 -0700
+++ ./drivers/video/neofb.c	2004-04-20 15:22:04.179519568 -0700
@@ -952,8 +952,10 @@
 		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
 	case 16:
-		/* DirectColor, 64k */
-		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
+		/* TrueColor, 64k */
+		/* Note, this is NOT DirectColor, because we don't support
+		 * setting the hardware colormap. */
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 
 		for (i = 0; i < 64; i++) {
 			outb(i, 0x3c8);
@@ -1240,7 +1242,7 @@
 		break;
 	case 16:
 		if (regno < 16)
-			((u16 *) fb->pseudo_palette)[regno] =
+			((u32 *) fb->pseudo_palette)[regno] =
 			    ((red & 0xf800)) | ((green & 0xfc00) >> 5) |
 			    ((blue & 0xf800) >> 11);
 		break;
@@ -1348,7 +1350,7 @@
 		break;
 	case 16:
 		par->neo2200->fgColor =
-		    ((u16 *) (info->pseudo_palette))[rect->color];
+		    ((u32 *) (info->pseudo_palette))[rect->color];
 		break;
 	}
 
@@ -1418,9 +1420,9 @@
 		break;
 	case 16:
 		par->neo2200->fgColor =
-		    ((u16 *) (info->pseudo_palette))[image->fg_color];
+		    ((u32 *) (info->pseudo_palette))[image->fg_color];
 		par->neo2200->bgColor =
-		    ((u16 *) (info->pseudo_palette))[image->bg_color];
+		    ((u32 *) (info->pseudo_palette))[image->bg_color];
 		break;
 	}
 

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb.4.24bit.patch"

--- drivers/video/neofb.c.24bit	2004-04-20 16:02:07.055251672 -0700
+++ drivers/video/neofb.c	2004-04-20 16:03:08.500910512 -0700
@@ -522,6 +522,10 @@
 		bltMod = NEO_MODE1_DEPTH16;
 		pitch = var->xres_virtual * 2;
 		break;
+	case 24:
+		bltMod = NEO_MODE1_DEPTH24;
+		pitch = var->xres_virtual * 3;
+		break;
 	default:
 		printk(KERN_ERR
 		       "neofb: neo2200_accel_init: unexpected bits per pixel!\n");
@@ -643,6 +647,7 @@
 		var->green.offset = 8;
 		var->green.length = 8;
 		var->blue.offset = 0;
+		var->blue.length = 8;
 		break;
 
 #ifdef NO_32BIT_SUPPORT_YET
@@ -945,43 +950,6 @@
 	/* Since we program the clocks ourselves, always use VCLK3. */
 	par->MiscOutReg |= 0x0C;
 
-	/* linear colormap for non palettized modes */
-	switch (info->var.bits_per_pixel) {
-	case 8:
-		/* PseudoColor, 256 */
-		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		break;
-	case 16:
-		/* TrueColor, 64k */
-		/* Note, this is NOT DirectColor, because we don't support
-		 * setting the hardware colormap. */
-		info->fix.visual = FB_VISUAL_TRUECOLOR;
-
-		for (i = 0; i < 64; i++) {
-			outb(i, 0x3c8);
-
-			outb(i << 1, 0x3c9);
-			outb(i, 0x3c9);
-			outb(i << 1, 0x3c9);
-		}
-		break;
-	case 24:
-#ifdef NO_32BIT_SUPPORT_YET
-	case 32:
-#endif
-		/* TrueColor, 16m */
-		info->fix.visual = FB_VISUAL_TRUECOLOR;
-
-		for (i = 0; i < 256; i++) {
-			outb(i, 0x3c8);
-
-			outb(i, 0x3c9);
-			outb(i, 0x3c9);
-			outb(i, 0x3c9);
-		}
-		break;
-	}
-
 	/* alread unlocked above */
 	/* BOGUS  VGAwGR (0x09, 0x26); */
 
@@ -1043,6 +1011,42 @@
 	 * This function handles restoring the generic VGA registers.  */
 	vgaHWRestore(info, par);
 
+	/* linear colormap for non palettized modes */
+	switch (info->var.bits_per_pixel) {
+	case 8:
+		/* PseudoColor, 256 */
+		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
+		break;
+	case 16:
+		/* TrueColor, 64k */
+		/* Note, this is NOT DirectColor, because we don't support
+		 * setting the hardware colormap. */
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+
+		for (i = 0; i < 64; i++) {
+			outb(i, 0x3c8);
+
+			outb(i << 1, 0x3c9);
+			outb(i, 0x3c9);
+			outb(i << 1, 0x3c9);
+		}
+		break;
+	case 24:
+#ifdef NO_32BIT_SUPPORT_YET
+	case 32:
+#endif
+		/* TrueColor, 16m */
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
+
+		for (i = 0; i < 256; i++) {
+			outb(i, 0x3c8);
+
+			outb(i, 0x3c9);
+			outb(i, 0x3c9);
+			outb(i, 0x3c9);
+		}
+		break;
+	}
 
 	VGAwGR(0x0E, par->ExtCRTDispAddr);
 	VGAwGR(0x0F, par->ExtCRTOffset);
@@ -1349,6 +1353,7 @@
 		par->neo2200->fgColor = rect->color;
 		break;
 	case 16:
+	case 24:
 		par->neo2200->fgColor =
 		    ((u32 *) (info->pseudo_palette))[rect->color];
 		break;
@@ -1401,6 +1406,13 @@
 	neo2200_sync(info);
 
 	if (image->depth == 1) {
+		if (info->var.bits_per_pixel == 24 && image->width < 16) {
+			/* There is apparently a hardware bug with accelerated
+			 * mono->screen transfers in 24-bit mode if the image
+			 * being transferred is less than 16 bits wide.  Do it
+			 * the old-fashioned way instead. */
+			return cfb_imageblit(info, image);
+		}
 		bltCntl_flags = NEO_BC0_SRC_MONO;
 		data_len = (image->width * image->height) >> 3;
 	} else if (image->depth == info->var.bits_per_pixel) {
@@ -1419,6 +1431,7 @@
 		par->neo2200->bgColor = image->bg_color;
 		break;
 	case 16:
+	case 24:
 		par->neo2200->fgColor =
 		    ((u32 *) (info->pseudo_palette))[image->fg_color];
 		par->neo2200->bgColor =

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb.5.modedb.patch"

--- ./drivers/video/neofb.c.modedb	2004-04-20 16:04:32.172190544 -0700
+++ ./drivers/video/neofb.c	2004-04-20 16:04:32.470145248 -0700
@@ -93,7 +93,7 @@
 static int libretto;
 static int nostretch;
 static int nopciburst;
-
+static char *mode;
 
 #ifdef MODULE
 
@@ -113,6 +113,8 @@
 		 "Disable stretching of modes smaller than LCD.");
 MODULE_PARM(nopciburst, "i");
 MODULE_PARM_DESC(nopciburst, "Disable PCI burst mode.");
+MODULE_PARM(mode, "s");
+MODULE_PARM_DESC(mode, "Preferred Video Mode ('640x480-8@60', etc)");
 
 #endif
 
@@ -1536,48 +1538,9 @@
 
 /* --------------------------------------------------------------------- */
 
-static struct fb_var_screeninfo __devinitdata neofb_var640x480x8 = {
-	.accel_flags    = FB_ACCELF_TEXT,
-	.xres           = 640,
-	.yres           = 480,
-	.xres_virtual   = 640,
-	.yres_virtual   = 30000,
-	.bits_per_pixel = 8,
-	.pixclock       = 39722,
-	.left_margin    = 48,
-	.right_margin   = 16,
-	.upper_margin   = 33,
-	.lower_margin   = 10,
-	.hsync_len      = 96,
-	.vsync_len      = 2,
-	.vmode          = FB_VMODE_NONINTERLACED
-};
-
-static struct fb_var_screeninfo __devinitdata neofb_var800x600x8 = {
-	.accel_flags    = FB_ACCELF_TEXT,
-	.xres           = 800,
-	.yres           = 600,
-	.xres_virtual   = 800,
-	.yres_virtual   = 30000,
-	.bits_per_pixel = 8,
-	.pixclock       = 25000,
-	.left_margin    = 88,
-	.right_margin   = 40,
-	.upper_margin   = 23,
-	.lower_margin   = 1,
-	.hsync_len      = 128,
-	.vsync_len      = 4,
-	.sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	.vmode          = FB_VMODE_NONINTERLACED
-};
-
-static struct fb_var_screeninfo __devinitdata neofb_var800x480x8 = {
-	.accel_flags    = FB_ACCELF_TEXT,
+static struct fb_videomode __devinitdata mode800x480 = {
 	.xres           = 800,
 	.yres           = 480,
-	.xres_virtual   = 800,
-	.yres_virtual   = 30000,
-	.bits_per_pixel = 8,
 	.pixclock       = 25000,
 	.left_margin    = 88,
 	.right_margin   = 40,
@@ -1589,44 +1552,6 @@
 	.vmode          = FB_VMODE_NONINTERLACED
 };
 
-static struct fb_var_screeninfo __devinitdata neofb_var1024x768x8 = {
-	.accel_flags    = FB_ACCELF_TEXT,
-	.xres           = 1024,
-	.yres           = 768,
-	.xres_virtual   = 1024,
-	.yres_virtual   = 30000,
-	.bits_per_pixel = 8,
-	.pixclock       = 15385,
-	.left_margin    = 160,
-	.right_margin   = 24,
-	.upper_margin   = 29,
-	.lower_margin   = 3,
-	.hsync_len      = 136,
-	.vsync_len      = 6,
-	.sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	.vmode          = FB_VMODE_NONINTERLACED
-};
-
-#ifdef NOT_DONE
-static struct fb_var_screeninfo __devinitdata neofb_var1280x1024x8 = {
-	.accel_flags    = FB_ACCELF_TEXT,
-	.xres           = 1280,
-	.yres           = 1024,
-	.xres_virtual   = 1280,
-	.yres_virtual   = 30000,
-	.bits_per_pixel = 8,
-	.pixclock       = 9260,
-	.left_margin    = 248,
-	.right_margin   = 48,
-	.upper_margin   = 38,
-	.lower_margin   = 1,
-	.hsync_len      = 112,
-	.vsync_len      = 3,
-	.sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-	.vmode          = FB_VMODE_NONINTERLACED
-};
-#endif
-
 static int __devinit neo_map_mmio(struct fb_info *info,
 				  struct pci_dev *dev)
 {
@@ -1772,24 +1697,29 @@
 	case 0x00:
 		par->NeoPanelWidth = 640;
 		par->NeoPanelHeight = 480;
-		info->var = neofb_var640x480x8;
+		par->default_videomode = &vesa_modes[3]; /* 640x480@60 */
 		break;
 	case 0x01:
 		par->NeoPanelWidth = 800;
-		par->NeoPanelHeight = par->libretto ? 480 : 600;
-		info->var = par->libretto ? neofb_var800x480x8 : neofb_var800x600x8;
+		if (par->libretto) {
+			par->NeoPanelHeight = 480;
+			par->default_videomode = &mode800x480;
+		} else {
+			par->NeoPanelHeight = 600;
+			par->default_videomode = &vesa_modes[8]; /* 800x600@60 */
+		}
 		break;
 	case 0x02:
 		par->NeoPanelWidth = 1024;
 		par->NeoPanelHeight = 768;
-		info->var = neofb_var1024x768x8;
+		par->default_videomode = &vesa_modes[13]; /* 1024x768@60 */
 		break;
 	case 0x03:
 		/* 1280x1024 panel support needs to be added */
 #ifdef NOT_DONE
 		par->NeoPanelWidth = 1280;
 		par->NeoPanelHeight = 1024;
-		info->var = neofb_var1280x1024x8;
+		par->default_videomode = &vesa_modes[20]; /* 1280x1024@60 */
 		break;
 #else
 		printk(KERN_ERR
@@ -1799,7 +1729,7 @@
 	default:
 		par->NeoPanelWidth = 640;
 		par->NeoPanelHeight = 480;
-		info->var = neofb_var640x480x8;
+		par->default_videomode = &vesa_modes[3]; /* 640x480@60 */
 		break;
 	}
 
@@ -1989,6 +1919,7 @@
 				 const struct pci_device_id *id)
 {
 	struct fb_info *info;
+	struct neofb_par *par;
 	u_int h_sync, v_sync;
 	int err;
 	int video_len;
@@ -2018,6 +1949,18 @@
 	if (err)
 		goto failed;
 
+	par = (struct neofb_par *)info->par;
+	if (!fb_find_mode(&info->var, info, mode, NULL, 0,
+			  par->default_videomode, 8)) {
+		printk(KERN_ERR "neofb: Unable to find usable video mode.\n");
+		return -EINVAL;
+	}
+
+	/* Turn on panning for console scroll by default */
+	info->var.yres_virtual = 30000;
+	info->var.accel_flags |= FB_ACCELF_TEXT;
+	neofb_check_var(&info->var, info);
+
 	/*
 	 * Calculate the hsync and vsync frequencies.  Note that
 	 * we split the 1e12 constant up so that we can preserve
@@ -2162,16 +2105,18 @@
 
 		if (!strncmp(this_opt, "disabled", 8))
 			disabled = 1;
-		if (!strncmp(this_opt, "internal", 8))
+		else if (!strncmp(this_opt, "internal", 8))
 			internal = 1;
-		if (!strncmp(this_opt, "external", 8))
+		else if (!strncmp(this_opt, "external", 8))
 			external = 1;
-		if (!strncmp(this_opt, "nostretch", 9))
+		else if (!strncmp(this_opt, "nostretch", 9))
 			nostretch = 1;
-		if (!strncmp(this_opt, "nopciburst", 10))
+		else if (!strncmp(this_opt, "nopciburst", 10))
 			nopciburst = 1;
-		if (!strncmp(this_opt, "libretto", 8))
+		else if (!strncmp(this_opt, "libretto", 8))
 			libretto = 1;
+		else
+			mode = this_opt;
 	}
 
 	return 0;
--- ./include/video/neomagic.h.modedb	2004-04-03 19:36:56.000000000 -0800
+++ ./include/video/neomagic.h	2004-04-20 16:04:32.530136128 -0700
@@ -177,6 +177,8 @@
   int internal_display;
   int external_display;
   int libretto;
+
+  const struct fb_videomode *default_videomode;
 };
 
 typedef struct {

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="neofb.6.blanking.patch"

--- ./drivers/video/neofb.c.blanking	2004-04-20 16:04:32.470145248 -0700
+++ ./drivers/video/neofb.c	2004-04-20 16:04:32.774099040 -0700
@@ -1277,27 +1277,36 @@
 /*
  *    (Un)Blank the display.
  */
-static int neofb_blank(int blank, struct fb_info *info)
+static int neofb_blank(int blank_mode, struct fb_info *info)
 {
+	struct neofb_par *par = (struct neofb_par *)info->par;
+	int reg;
+
 	/*
-	 *  Blank the screen if blank_mode != 0, else unblank. If
-	 *  blank == NULL then the caller blanks by setting the CLUT
-	 *  (Color Look Up Table) to all black. Return 0 if blanking
-	 *  succeeded, != 0 if un-/blanking failed due to e.g. a
-	 *  video mode which doesn't support it. Implements VESA
-	 *  suspend and powerdown modes on hardware that supports
-	 *  disabling hsync/vsync:
-	 *    blank_mode == 2: suspend vsync
-	 *    blank_mode == 3: suspend hsync
-	 *    blank_mode == 4: powerdown
+	 *  Blank the screen if blank_mode != 0, else unblank.
+	 *  Return 0 if blanking succeeded, != 0 if un-/blanking failed due to
+	 *  e.g. a video mode which doesn't support it. Implements VESA suspend
+	 *  and powerdown modes for monitors, and backlight control on LCDs.
+	 *    blank_mode == 0: unblanked (backlight on)
+	 *    blank_mode == 1: blank (backlight on)
+	 *    blank_mode == 2: suspend vsync (backlight off)
+	 *    blank_mode == 3: suspend hsync (backlight off)
+	 *    blank_mode == 4: powerdown (backlight off)
 	 *
-	 *  wms...Enable VESA DMPS compatible powerdown mode
+	 *  wms...Enable VESA DPMS compatible powerdown mode
 	 *  run "setterm -powersave powerdown" to take advantage
 	 */
 
-	switch (blank) {
+	switch (blank_mode) {
 	case 4:		/* powerdown - both sync lines down */
+		reg = VGArSEQ(0x01) | 0x20;		/* Disable sequencer */
+		VGAwSEQ(0x01, reg);
+		reg = VGArGR(0x20) & ~0x02;		/* LCD off */
+		VGAwGR(0x20, reg);
+		reg = (VGArGR(0x01) & ~0xF0) | 0xB0; /* hsync off, vsync off */
+		VGAwGR(0x01, reg);
 #ifdef CONFIG_TOSHIBA
+		/* Do we still need this? */
 		/* attempt to turn off backlight on toshiba; also turns off external */
 		{
 			SMMRegisters regs;
@@ -1310,13 +1319,35 @@
 #endif
 		break;
 	case 3:		/* hsync off */
+		reg = VGArSEQ(0x01) | 0x20;		/* Disable sequencer */
+		VGAwSEQ(0x01, reg);
+		reg = VGArGR(0x20) & ~0x02;		/* LCD off */
+		VGAwGR(0x20, reg);
+		reg = (VGArGR(0x01) & ~0xF0) | 0xA0;   /* hsync off, vsync on */
+		VGAwGR(0x01, reg);
 		break;
 	case 2:		/* vsync off */
-		break;
-	case 1:		/* just software blanking of screen */
-		break;
-	default:		/* case 0, or anything else: unblank */
+		reg = VGArSEQ(0x01) | 0x20;		/* Disable sequencer */
+		VGAwSEQ(0x01, reg);
+		reg = VGArGR(0x20) & ~0x02;		/* LCD off */
+		VGAwGR(0x20, reg);
+		reg = (VGArGR(0x01) & ~0xF0) | 0x90;   /* hsync on, vsync off */
+		VGAwGR(0x01, reg);
+		break;
+	case 1:		/* just blank screen (backlight stays on) */
+		reg = VGArSEQ(0x01) | 0x20;		/* Disable sequencer */
+		VGAwSEQ(0x01, reg);
+		break;
+	case 0:		/* unblank */
+		reg = VGArSEQ(0x01) & ~0x20;		/* Enable sequencer */
+		VGAwSEQ(0x01, reg);
+		reg = VGArGR(0x20) & ~0x02;
+		reg |= (par->PanelDispCntlReg1 & 0x02); /* Set LCD to normal */
+		VGAwGR(0x20, reg);
+		reg = (VGArGR(0x01) & ~0xF0) | 0x80;	/* hsync on, vsync on */
+		VGAwGR(0x01, reg);
 #ifdef CONFIG_TOSHIBA
+		/* Do we still need this? */
 		/* attempt to re-enable backlight/external on toshiba */
 		{
 			SMMRegisters regs;
@@ -1328,6 +1359,9 @@
 		}
 #endif
 		break;
+	default:	/* Anything else we don't understand; return 1 to tell
+			 * fb_blank we didn't actually do anything */
+		return 1;
 	}
 	return 0;
 }

--UlVJffcvxoiEqYs2--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
