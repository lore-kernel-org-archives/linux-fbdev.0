From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/9][NEOFB]: Salvage neofb from James' tree
Date: Sat, 21 Aug 2004 21:27:00 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408212119.31875.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByW0i-0008CS-8p
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:20 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1ByW0g-0005FC-Pb
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:20 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 03D117421F
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 13:34:11 +0000 (UTC)
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi,

Took code from James' tree to be hopefully included in the mm tree so it can
receive more testing.

Compile tested only.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

 drivers/video/neofb.c    |  500 +++++++++++++++++++++++------------------------
 include/video/neomagic.h |    3
 2 files changed, 256 insertions(+), 247 deletions(-)

diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/neofb.c linux-2.6.8.1-mm3/drivers/video/neofb.c
--- linux-2.6.8.1-mm3-orig/drivers/video/neofb.c	2004-08-21 18:26:53.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/neofb.c	2004-08-21 18:57:51.909695200 +0800
@@ -93,7 +93,7 @@ static int external;
 static int libretto;
 static int nostretch;
 static int nopciburst;
-
+static char *mode_option __initdata = NULL;
 
 #ifdef MODULE
 
@@ -111,6 +111,8 @@ MODULE_PARM_DESC(nostretch,
 		 "Disable stretching of modes smaller than LCD.");
 MODULE_PARM(nopciburst, "i");
 MODULE_PARM_DESC(nopciburst, "Disable PCI burst mode.");
+MODULE_PARM(mode_option, "s");
+MODULE_PARM_DESC(mode_option, "Preferred video mode ('640x480-8@60', etc)");
 
 #endif
 
@@ -153,12 +155,12 @@ static biosMode bios32[] = {
 static inline u32 read_le32(int regindex, const struct neofb_par *par)
 {
 	return readl(par->neo2200 + par->cursorOff + regindex);
-}
+}	
 
 static inline void write_le32(int regindex, u32 val, const struct neofb_par *par)
 {
 	writel(val, par->neo2200 + par->cursorOff + regindex);
-}
+}	
 
 static int neoFindMode(int xres, int yres, int depth)
 {
@@ -544,6 +546,10 @@ static inline void neo2200_accel_init(st
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
@@ -562,14 +568,14 @@ neofb_open(struct fb_info *info, int use
 	struct neofb_par *par = (struct neofb_par *) info->par;
 	int cnt = atomic_read(&par->ref_count);
 
-	if (cnt) {
+	if (!cnt) {
 		memset(&par->state, 0, sizeof(struct vgastate));
 		par->state.flags = VGA_SAVE_MODE | VGA_SAVE_FONTS;
 		save_vga(&par->state);
 	}
 	atomic_inc(&par->ref_count);
 	return 0;
-}
+}	
 
 static int
 neofb_release(struct fb_info *info, int user)
@@ -580,11 +586,11 @@ neofb_release(struct fb_info *info, int 
 	if (!cnt)
 		return -EINVAL;
 	if (cnt == 1) {
-		restore_vga(&par->state);
+		restore_vga(&par->state);	
 	}
 	atomic_dec(&par->ref_count);
 	return 0;
-}
+}	
 
 static int
 neofb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
@@ -695,6 +701,7 @@ neofb_check_var(struct fb_var_screeninfo
 		var->green.offset = 8;
 		var->green.length = 8;
 		var->blue.offset = 0;
+		var->blue.length = 8;
 		break;
 
 #ifdef NO_32BIT_SUPPORT_YET
@@ -725,7 +732,7 @@ neofb_check_var(struct fb_var_screeninfo
 		var->xres_virtual = var->xres;
 
 	memlen = var->xres_virtual * var->bits_per_pixel * var->yres_virtual >> 3;
-
+	
 	if (memlen > vramlen) {
 		var->yres_virtual =  vramlen * 8 / (var->xres_virtual *
 				   	var->bits_per_pixel);
@@ -994,41 +1001,6 @@ static int neofb_set_par(struct fb_info 
 	/* Since we program the clocks ourselves, always use VCLK3. */
 	par->MiscOutReg |= 0x0C;
 
-	/* linear colormap for non palettized modes */
-	switch (info->var.bits_per_pixel) {
-	case 8:
-		/* PseudoColor, 256 */
-		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
-		break;
-	case 16:
-		/* DirectColor, 64k */
-		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
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
 	/* BOGUS  vga_wgfx(NULL, 0x09, 0x26); */
 
@@ -1090,6 +1062,41 @@ static int neofb_set_par(struct fb_info 
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
+	
 	vga_wgfx(NULL, 0x0E, par->ExtCRTDispAddr);
 	vga_wgfx(NULL, 0x0F, par->ExtCRTOffset);
 	temp = vga_rgfx(NULL, 0x10);
@@ -1276,7 +1283,7 @@ static int neofb_pan_display(struct fb_v
 static int neofb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 			   u_int transp, struct fb_info *fb)
 {
-	if (regno >= 255)
+	if (regno >= fb->cmap.len || regno > 255)
 		return -EINVAL;
 
 	switch (fb->var.bits_per_pixel) {
@@ -1288,25 +1295,20 @@ static int neofb_setcolreg(u_int regno, 
 		outb(blue >> 10, 0x3c9);
 		break;
 	case 16:
-		if (regno < 16)
-			((u16 *) fb->pseudo_palette)[regno] =
-			    ((red & 0xf800)) | ((green & 0xfc00) >> 5) |
-			    ((blue & 0xf800) >> 11);
+		((u32 *) fb->pseudo_palette)[regno] =
+				((red & 0xf800)) | ((green & 0xfc00) >> 5) |
+				((blue & 0xf800) >> 11);
 		break;
 	case 24:
-		if (regno < 16)
-			((u32 *) fb->pseudo_palette)[regno] =
-			    ((red & 0xff00) << 8) | ((green & 0xff00)) |
-			    ((blue & 0xff00) >> 8);
+		((u32 *) fb->pseudo_palette)[regno] =
+				((red & 0xff00) << 8) | ((green & 0xff00)) |
+				((blue & 0xff00) >> 8);
 		break;
 #ifdef NO_32BIT_SUPPORT_YET
 	case 32:
-		if (regno < 16)
-			((u32 *) fb->pseudo_palette)[regno] =
-			    ((transp & 0xff00) << 16) | ((red & 0xff00) <<
-							 8) | ((green &
-								0xff00)) |
-			    ((blue & 0xff00) >> 8);
+		((u32 *) fb->pseudo_palette)[regno] =
+				((transp & 0xff00) << 16) | ((red & 0xff00) << 8) |
+				((green & 0xff00)) | ((blue & 0xff00) >> 8);
 		break;
 #endif
 	default:
@@ -1318,27 +1320,33 @@ static int neofb_setcolreg(u_int regno, 
 /*
  *    (Un)Blank the display.
  */
-static int neofb_blank(int blank, struct fb_info *info)
+int neofb_blank(int blank_mode, struct fb_info *info)
 {
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
+	struct neofb_par *par = (struct neofb_par *)info->par;
+	int seqflags, lcdflags, dpmsflags, reg;
 
-	switch (blank) {
+	switch (blank_mode) {
 	case 4:		/* powerdown - both sync lines down */
+		seqflags = VGA_SR01_SCREEN_OFF; /* Disable sequencer */
+		lcdflags = 0;			/* LCD off */
+		dpmsflags = NEO_GR01_SUPPRESS_HSYNC |
+			    NEO_GR01_SUPPRESS_VSYNC;
 #ifdef CONFIG_TOSHIBA
+		/* Do we still need this ? */
 		/* attempt to turn off backlight on toshiba; also turns off external */
 		{
 			SMMRegisters regs;
@@ -1351,13 +1359,26 @@ static int neofb_blank(int blank, struct
 #endif
 		break;
 	case 3:		/* hsync off */
+		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
+		lcdflags = 0;			/* LCD off */
+		dpmsflags = NEO_GR01_SUPPRESS_HSYNC;
 		break;
 	case 2:		/* vsync off */
-		break;
-	case 1:		/* just software blanking of screen */
-		break;
-	default:		/* case 0, or anything else: unblank */
+		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
+		lcdflags = 0;			/* LCD off */
+		dpmsflags = NEO_GR01_SUPPRESS_VSYNC;
+		break;
+	case 1:		/* just blank screen (backlight stays on) */
+		seqflags = VGA_SR01_SCREEN_OFF;	/* Disable sequencer */
+		lcdflags = par->PanelDispCntlReg1 & 0x02; /* LCD normal */
+		dpmsflags = 0;			/* no hsync/vsync suppression */
+		break;
+	case 0:		/* unblank */
+		seqflags = 0;			/* Enable sequencer */
+		lcdflags = par->PanelDispCntlReg1 & 0x02; /* LCD normal */
+		dpmsflags = 0x00;	/* no hsync/vsync suppression */
 #ifdef CONFIG_TOSHIBA
+		/* Do we still need this ? */
 		/* attempt to re-enable backlight/external on toshiba */
 		{
 			SMMRegisters regs;
@@ -1369,7 +1390,19 @@ static int neofb_blank(int blank, struct
 		}
 #endif
 		break;
+	default:	/* Anything else we don't understand; return 1 to tell
+			 * fb_blank we didn't aactually do anything */
+		return 1;
 	}
+
+	neoUnlock();
+	reg = (vga_rseq(NULL, 0x01) & ~0x20) | seqflags;
+	vga_wseq(NULL, 0x01, reg);
+	reg = (vga_rgfx(NULL, 0x20) & ~0x02) | lcdflags;
+	vga_wgfx(NULL, 0x20, reg);
+	reg = (vga_rgfx(NULL, 0x01) & ~0xF0) | 0x80 | dpmsflags;
+	vga_wgfx(NULL, 0x01, reg);
+	neoLock(&par->state);
 	return 0;
 }
 
@@ -1396,8 +1429,9 @@ neo2200_fillrect(struct fb_info *info, c
 		par->neo2200->fgColor = rect->color;
 		break;
 	case 16:
+	case 24:
 		par->neo2200->fgColor =
-		    ((u16 *) (info->pseudo_palette))[rect->color];
+		    ((u32 *) (info->pseudo_palette))[rect->color];
 		break;
 	}
 
@@ -1413,19 +1447,19 @@ neo2200_copyarea(struct fb_info *info, c
 	u32 sx = area->sx, sy = area->sy, dx = area->dx, dy = area->dy;
 	struct neofb_par *par = (struct neofb_par *) info->par;
 	u_long src, dst, bltCntl;
-
+	
 	bltCntl = NEO_BC3_FIFO_EN | NEO_BC3_SKIP_MAPPING | 0x0C0000;
 
-	if ((dy > sy) || ((dy == sy) && (dx > sx))) {
+	if ((dy > sy) || ((dy == sy) && (dx > sx))) {	
 		/* Start with the lower right corner */
 		sy += (area->height - 1);
 		dy += (area->height - 1);
 		sx += (area->width - 1);
-		dx += (area->width - 1);
-
+		dx += (area->width - 1);	
+		
 		bltCntl |= NEO_BC0_X_DEC | NEO_BC0_DST_Y_DEC | NEO_BC0_SRC_Y_DEC;
-	}
-
+	}		
+				
 	src = sx * (info->var.bits_per_pixel >> 3) + sy*info->fix.line_length;
 	dst = dx * (info->var.bits_per_pixel >> 3) + dy*info->fix.line_length;
 
@@ -1440,31 +1474,57 @@ neo2200_copyarea(struct fb_info *info, c
 	    (area->height << 16) | (area->width & 0xffff);
 }
 
-/*
 static void
 neo2200_imageblit(struct fb_info *info, const struct fb_image *image)
 {
 	struct neofb_par *par = (struct neofb_par *) info->par;
+	int s_pitch = (image->width * image->depth + 7) >> 3;
+	int scan_align = info->pixmap.scan_align - 1;
+	int buf_align = info->pixmap.buf_align - 1;
+	int bltCntl_flags, d_pitch, data_len;
+
+	// The data is padded for the hardware
+	d_pitch = (s_pitch + scan_align) & ~scan_align;
+	data_len = ((d_pitch * image->height) + buf_align) & ~buf_align;
 
 	neo2200_sync(info);
 
+	if (image->depth == 1) {
+		if (info->var.bits_per_pixel == 24 && image->width < 16) {
+			/* FIXME. There is a bug with accelerated color-expanded
+			 * transfers in 24 bit mode if the image being transferred
+			 * is less than 16 bits wide. This is due to insufficient
+			 * padding when writing the image. We need to adjust 
+			 * struct fb_pixmap. Not yet done. */
+			return cfb_imageblit(info, image);
+		}
+		bltCntl_flags = NEO_BC0_SRC_MONO;
+	} else if (image->depth == info->var.bits_per_pixel) {
+		bltCntl_flags = 0;
+	} else {
+		/* We don't currently support hardware acceleration if image
+		 * depth is different from display */
+		return cfb_imageblit(info, image);
+	}
+	
 	switch (info->var.bits_per_pixel) {
 	case 8:
 		par->neo2200->fgColor = image->fg_color;
 		par->neo2200->bgColor = image->bg_color;
 		break;
 	case 16:
+	case 24:
 		par->neo2200->fgColor =
-		    ((u16 *) (info->pseudo_palette))[image->fg_color];
+		    ((u32 *) (info->pseudo_palette))[image->fg_color];
 		par->neo2200->bgColor =
-		    ((u16 *) (info->pseudo_palette))[image->bg_color];
+		    ((u32 *) (info->pseudo_palette))[image->bg_color];
 		break;
 	}
 
 	par->neo2200->bltCntl = NEO_BC0_SYS_TO_VID |
-	    NEO_BC0_SRC_MONO | NEO_BC3_SKIP_MAPPING |
-	    //                      NEO_BC3_DST_XY_ADDR |
-	    0x0c0000;
+		NEO_BC3_SKIP_MAPPING | bltCntl_flags |
+		// NEO_BC3_DST_XY_ADDR |
+		0x0c0000;
 
 	par->neo2200->srcStart = 0;
 //      par->neo2200->dstStart = (image->dy << 16) | (image->dx & 0xffff);
@@ -1474,10 +1534,8 @@ neo2200_imageblit(struct fb_info *info, 
 	par->neo2200->xyExt =
 	    (image->height << 16) | (image->width & 0xffff);
 
-	memcpy(par->mmio_vbase + 0x100000, image->data,
-	       (image->width * image->height) >> 3);
+	memcpy(par->mmio_vbase + 0x100000, image->data, data_len);
 }
-*/
 
 static void
 neofb_fillrect(struct fb_info *info, const struct fb_fillrect *rect)
@@ -1514,23 +1572,18 @@ neofb_copyarea(struct fb_info *info, con
 static void
 neofb_imageblit(struct fb_info *info, const struct fb_image *image)
 {
-/*
-	if (image->depth == 1) {
-		switch (info->fix.accel) {
-			case FB_ACCEL_NEOMAGIC_NM2200:
-			case FB_ACCEL_NEOMAGIC_NM2230:
-			case FB_ACCEL_NEOMAGIC_NM2360:
-			case FB_ACCEL_NEOMAGIC_NM2380:
-				neo2200_imageblit(info, image);
-				break;
-			default:
-				cfb_imageblit(info, image);
-				break;
-		}
-	} else
-*/
-		cfb_imageblit(info, image);
-}	
+	switch (info->fix.accel) {
+		case FB_ACCEL_NEOMAGIC_NM2200:
+		case FB_ACCEL_NEOMAGIC_NM2230: 
+		case FB_ACCEL_NEOMAGIC_NM2360: 
+		case FB_ACCEL_NEOMAGIC_NM2380: 
+			neo2200_imageblit(info, image);
+			break;
+		default:
+			cfb_imageblit(info, image);
+			break;
+	}
+}
 
 static int 
 neofb_sync(struct fb_info *info)
@@ -1553,20 +1606,20 @@ static void
 neofb_draw_cursor(struct fb_info *info, u8 *dst, u8 *src, unsigned int width)
 {
 	//memset_io(info->sprite.addr, 0xff, 1);
-}
+}	
 
 static int
 neofb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct neofb_par *par = (struct neofb_par *) info->par;
-
+	
 	* Disable cursor *
-	write_le32(NEOREG_CURSCNTL, ~NEO_CURS_ENABLE, par);
-
+	write_le32(NEOREG_CURSCNTL, ~NEO_CURS_ENABLE, par);	
+	
 	if (cursor->set & FB_CUR_SETPOS) {
 		u32 x = cursor->image.dx;
 		u32 y = cursor->image.dy;
-
+	
 		info->cursor.image.dx = x;
 		info->cursor.image.dy = y;
 		write_le32(NEOREG_CURSX, x, par);
@@ -1580,7 +1633,7 @@ neofb_cursor(struct fb_info *info, struc
 
 	if (cursor->set & FB_CUR_SETHOT)
 		info->cursor.hot = cursor->hot;
-
+	
 	if (cursor->set & FB_CUR_SETCMAP) {
 		if (cursor->image.depth == 1) {
 			u32 fg = cursor->image.fg_color;
@@ -1593,16 +1646,16 @@ neofb_cursor(struct fb_info *info, struc
 			bg = ((bg & 0xff0000) >> 16) | ((bg & 0xff) << 16) | (bg & 0xff00);
 			write_le32(NEOREG_CURSFGCOLOR, fg, par);
 			write_le32(NEOREG_CURSBGCOLOR, bg, par);
-		}
+		}	
 	}
 
-	if (cursor->set & FB_CUR_SETSHAPE)
-		fb_load_cursor_image(info);
+	if (cursor->set & FB_CUR_SETSHAPE) 
+		fb_load_cursor_image(info);	
 
 	if (info->cursor.enable)
-		write_le32(NEOREG_CURSCNTL, NEO_CURS_ENABLE, par);
+		write_le32(NEOREG_CURSCNTL, NEO_CURS_ENABLE, par);	
 	return 0;
-}
+}	
 */
 
 static struct fb_ops neofb_ops = {
@@ -1623,48 +1676,9 @@ static struct fb_ops neofb_ops = {
 
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
@@ -1676,44 +1690,6 @@ static struct fb_var_screeninfo __devini
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
@@ -1759,13 +1735,13 @@ static int __devinit neo_map_video(struc
 				   struct pci_dev *dev, int video_len)
 {
 	//unsigned long addr;
-
+	
 	DBG("neo_map_video");
 
 	info->fix.smem_start = pci_resource_start(dev, 0);
 	info->fix.smem_len = video_len;
 
-	if (!request_mem_region(info->fix.smem_start, info->fix.smem_len,
+	if (!request_mem_region(info->fix.smem_start, info->fix.smem_len, 
 				"frame buffer")) {
 		printk("neofb: frame buffer in use\n");
 		return -EBUSY;
@@ -1783,7 +1759,7 @@ static int __devinit neo_map_video(struc
 		       info->screen_base);
 
 #ifdef CONFIG_MTRR
-	((struct neofb_par *)(info->par))->mtrr =
+	((struct neofb_par *)(info->par))->mtrr = 
 		mtrr_add(info->fix.smem_start, pci_resource_len(dev, 0),
 				MTRR_TYPE_WRCOMB, 1);
 #endif
@@ -1791,7 +1767,7 @@ static int __devinit neo_map_video(struc
 	/* Clear framebuffer, it's all white in memory after boot */
 	memset(info->screen_base, 0, info->fix.smem_len);
 
-	/* Allocate Cursor drawing pad.
+	/* Allocate Cursor drawing pad.  
 	info->fix.smem_len -= PAGE_SIZE;
 	addr = info->fix.smem_start + info->fix.smem_len;
 	write_le32(NEOREG_CURSMEMPOS, ((0x000f & (addr >> 10)) << 8) |
@@ -1803,6 +1779,8 @@ static int __devinit neo_map_video(struc
 
 static void neo_unmap_video(struct fb_info *info)
 {
+	DBG("neo_unmap_video");
+
 #ifdef CONFIG_MTRR
 	struct neofb_par *par = (struct neofb_par *) info->par;
 
@@ -1816,33 +1794,18 @@ static void neo_unmap_video(struct fb_in
 			   info->fix.smem_len);
 }
 
-static int __devinit neo_init_hw(struct fb_info *info)
+static int __devinit neo_scan_monitor(struct fb_info *info)
 {
 	struct neofb_par *par = (struct neofb_par *) info->par;
 	unsigned char type, display;
-	int videoRam = 896;
-	int maxClock = 65000;
-	int CursorMem = 1024;
-	int CursorOff = 0x100;
-	int linearSize = 1024;
-	int maxWidth = 1024;
-	int maxHeight = 1024;
 	int w;
-
-	DBG("neo_init_hw");
-
-	neoUnlock();
-
-#if 0
-	printk(KERN_DEBUG "--- Neo extended register dump ---\n");
-	for (w = 0; w < 0x85; w++)
-		printk(KERN_DEBUG "CR %p: %p\n", (void *) w,
-		       (void *) vga_rcrt(NULL, w);
-	for (w = 0; w < 0xC7; w++)
-		printk(KERN_DEBUG "GR %p: %p\n", (void *) w,
-		       (void *) vga_rgfx(NULL, w));
-#endif
-
+	
+	// Eventually we will have i2c support.
+	info->monspecs.modedb = kmalloc(sizeof(struct fb_videomode), GFP_KERNEL);
+	if (!info->monspecs.modedb)
+		return -ENOMEM;
+	info->monspecs.modedb_len = 1;
+	
 	/* Determine the panel type */
 	vga_wgfx(NULL, 0x09, 0x26);
 	type = vga_rgfx(NULL, 0x21);
@@ -1860,26 +1823,34 @@ static int __devinit neo_init_hw(struct 
 	vga_wgfx(NULL, 0x09, 0x00);
 	switch ((w & 0x18) >> 3) {
 	case 0x00:
+		// 640x480@60
 		par->NeoPanelWidth = 640;
 		par->NeoPanelHeight = 480;
-		info->var = neofb_var640x480x8;
+		memcpy(info->monspecs.modedb, &vesa_modes[3], sizeof(struct fb_videomode));
 		break;
 	case 0x01:
 		par->NeoPanelWidth = 800;
-		par->NeoPanelHeight = par->libretto ? 480 : 600;
-		info->var = par->libretto ? neofb_var800x480x8 : neofb_var800x600x8;
+		if (par->libretto) {
+			par->NeoPanelHeight = 480;
+			memcpy(info->monspecs.modedb, &mode800x480, sizeof(struct fb_videomode));
+		} else {
+			// 800x600@60
+			par->NeoPanelHeight = 600;
+			memcpy(info->monspecs.modedb, &vesa_modes[8], sizeof(struct fb_videomode));
+		}
 		break;
 	case 0x02:
+		// 1024x768@60
 		par->NeoPanelWidth = 1024;
 		par->NeoPanelHeight = 768;
-		info->var = neofb_var1024x768x8;
+		memcpy(info->monspecs.modedb, &vesa_modes[13], sizeof(struct fb_videomode));
 		break;
 	case 0x03:
-		/* 1280x1024 panel support needs to be added */
+		/* 1280x1024@60 panel support needs to be added */
 #ifdef NOT_DONE
 		par->NeoPanelWidth = 1280;
 		par->NeoPanelHeight = 1024;
-		info->var = neofb_var1280x1024x8;
+		memcpy(info->monspecs.modedb, &vesa_modes[20], sizeof(struct fb_videomode));
 		break;
 #else
 		printk(KERN_ERR
@@ -1887,9 +1858,10 @@ static int __devinit neo_init_hw(struct 
 		return -1;
 #endif
 	default:
+		// 640x480@60
 		par->NeoPanelWidth = 640;
 		par->NeoPanelHeight = 480;
-		info->var = neofb_var640x480x8;
+		memcpy(info->monspecs.modedb, &vesa_modes[3], sizeof(struct fb_videomode));
 		break;
 	}
 
@@ -1898,7 +1870,33 @@ static int __devinit neo_init_hw(struct 
 	       par->NeoPanelHeight,
 	       (type & 0x02) ? "color" : "monochrome",
 	       (type & 0x10) ? "TFT" : "dual scan");
+	return 0;
+}
+
+static int __devinit neo_init_hw(struct fb_info *info)
+{
+	struct neofb_par *par = (struct neofb_par *) info->par;
+	int videoRam = 896;
+	int maxClock = 65000;
+	int CursorMem = 1024;
+	int CursorOff = 0x100;
+	int linearSize = 1024;
+	int maxWidth = 1024;
+	int maxHeight = 1024;
+
+	DBG("neo_init_hw");
+
+	neoUnlock();
 
+#if 0
+	printk(KERN_DEBUG "--- Neo extended register dump ---\n");
+	for (int w = 0; w < 0x85; w++)
+		printk(KERN_DEBUG "CR %p: %p\n", (void *) w,
+		       (void *) vga_rcrt(NULL, w);
+	for (int w = 0; w < 0xC7; w++)
+		printk(KERN_DEBUG "GR %p: %p\n", (void *) w,
+		       (void *) vga_rgfx(NULL, w));
+#endif
 	switch (info->fix.accel) {
 	case FB_ACCEL_NEOMAGIC_NM2070:
 		videoRam = 896;
@@ -1982,13 +1980,13 @@ static int __devinit neo_init_hw(struct 
 		par->neo2200 = (Neo2200 *) par->mmio_vbase;
 		break;
 	}
-/*
+/*	
 	info->sprite.size = CursorMem;
 	info->sprite.scan_align = 1;
 	info->sprite.buf_align = 1;
 	info->sprite.flags = FB_PIXMAP_IO;
 	info->sprite.outbuf = neofb_draw_cursor;
-*/
+*/	
 	par->maxClock = maxClock;
 	par->cursorOff = CursorOff;
 	return ((videoRam * 1024));
@@ -2055,11 +2053,9 @@ static struct fb_info *__devinit neo_all
 	info->fix.accel = id->driver_data;
 
 	info->fbops = &neofb_ops;
-	info->flags = FBINFO_DEFAULT |
-	              FBINFO_HWACCEL_IMAGEBLIT |
-                      FBINFO_HWACCEL_FILLRECT |
-                      FBINFO_HWACCEL_COPYAREA |
-                      FBINFO_HWACCEL_YPAN;
+	info->flags = FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN |
+		FBINFO_HWACCEL_IMAGEBLIT | FBINFO_HWACCEL_COPYAREA |
+		FBINFO_HWACCEL_COPYAREA;
 	info->pseudo_palette = (void *) (par + 1);
 	return info;
 }
@@ -2082,8 +2078,7 @@ static int __devinit neofb_probe(struct 
 {
 	struct fb_info *info;
 	u_int h_sync, v_sync;
-	int err;
-	int video_len;
+	int video_len, err;
 
 	DBG("neofb_probe");
 
@@ -2100,6 +2095,10 @@ static int __devinit neofb_probe(struct 
 	if (err)
 		goto err_map_mmio;
 
+	err = neo_scan_monitor(info);
+	if (err)
+		goto err_scan_monitor;
+	
 	video_len = neo_init_hw(info);
 	if (video_len < 0) {
 		err = video_len;
@@ -2110,9 +2109,12 @@ static int __devinit neofb_probe(struct 
 	if (err)
 		goto err_init_hw;
 
-	if (neofb_check_var(&info->var, info))
+	if (!fb_find_mode(&info->var, info, mode_option, NULL, 0,
+			info->monspecs.modedb, 16)) {
+		printk(KERN_ERR "neofb: Unable to find usable video mode.\n");
 		goto err_map_video;
-
+	}
+	
 	/*
 	 * Calculate the hsync and vsync frequencies.  Note that
 	 * we split the 1e12 constant up so that we can preserve
@@ -2153,6 +2155,8 @@ err_reg_fb:
 err_map_video:
 	neo_unmap_video(info);
 err_init_hw:
+	fb_destroy_modedb(info->monspecs.modedb);
+err_scan_monitor:	
 	neo_unmap_mmio(info);
 err_map_mmio:
 	neo_free_fb_info(info);
@@ -2176,6 +2180,7 @@ static void __devexit neofb_remove(struc
 			       "neofb: danger danger!  Oopsen imminent!\n");
 
 		neo_unmap_video(info);
+		fb_destroy_modedb(info->monspecs.modedb);
 		neo_unmap_mmio(info);
 		neo_free_fb_info(info);
 
@@ -2244,16 +2249,17 @@ int __init neofb_setup(char *options)
 
 		if (!strncmp(this_opt, "internal", 8))
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
+			mode_option = this_opt;
 	}
-
 	return 0;
 }
 
diff -uprN linux-2.6.8.1-mm3-orig/include/video/neomagic.h linux-2.6.8.1-mm3/include/video/neomagic.h
--- linux-2.6.8.1-mm3-orig/include/video/neomagic.h	2004-08-17 21:50:54.000000000 +0800
+++ linux-2.6.8.1-mm3/include/video/neomagic.h	2004-08-21 18:57:51.971685776 +0800
@@ -69,6 +69,9 @@
 #define NEO_ICON128_ENABLE	0x0000000C
 #define NEO_ICON_BLANK		0x00000010
 
+#define NEO_GR01_SUPPRESS_VSYNC 0x10
+#define NEO_GR01_SUPPRESS_HSYNC 0x20
+
 #ifdef __KERNEL__
 
 #ifdef NEOFB_DEBUG




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
