From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH][RIVAFB]: Updates to rivafb driver
Date: Wed, 16 Jun 2004 10:44:45 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406161044.45807.adaplas@hotpop.com>
References: <200406160406.07060.adaplas@hotpop.com> <20040615221710.GA24416@havoc.gtf.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BaQPk-0006cl-Ku
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 19:44:36 -0700
Received: from babyruth.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BaQPj-0001pm-8s
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Jun 2004 19:44:35 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by babyruth.hotpop.com (Postfix) with SMTP id 904FD60DCC2
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 16 Jun 2004 02:06:43 +0000 (UTC)
In-Reply-To: <20040615221710.GA24416@havoc.gtf.org>
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
To: David Eger <eger@havoc.gtf.org>
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Wednesday 16 June 2004 06:17, David Eger wrote:
> hey tony,
>
> your patch against drivers/video/riva/fbdev.c chokes on hunk 2 when
> applied to 2.6.7-rc3-mm2.  resend, and i'll test it on my TNT2 :)
>

Ok.  Patch against 2.6.7-rc3-mm2.

Note I haven't added the hardware acceleration capability support yet, 
so scrolling is still slow.   

Secondly, stty seems not to work anymore, though I'm sure 
the driver can do mode setup independently if with DDC. I'll look into
this later.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

diff -Naur linux-2.6.6-rc3-mm2-orig/drivers/video/Kconfig linux-2.6.6-rc3-mm2/drivers/video/Kconfig
--- linux-2.6.6-rc3-mm2-orig/drivers/video/Kconfig	2004-06-16 01:17:54.000000000 +0000
+++ linux-2.6.6-rc3-mm2/drivers/video/Kconfig	2004-06-16 01:20:45.314626384 +0000
@@ -432,6 +432,11 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called rivafb.
 
+config FB_RIVA_I2C
+       bool "Enable DDC Support"
+       depends on FB_RIVA && I2C
+       help
+
 config FB_I810
 	tristate "Intel 810/815 support (EXPERIMENTAL)"
 	depends on FB && AGP && AGP_INTEL && EXPERIMENTAL && PCI	
diff -Naur linux-2.6.6-rc3-mm2-orig/drivers/video/riva/Makefile linux-2.6.6-rc3-mm2/drivers/video/riva/Makefile
--- linux-2.6.6-rc3-mm2-orig/drivers/video/riva/Makefile	2004-05-10 02:31:59.000000000 +0000
+++ linux-2.6.6-rc3-mm2/drivers/video/riva/Makefile	2004-06-16 01:20:45.315626232 +0000
@@ -2,6 +2,10 @@
 # Makefile for the Riva framebuffer driver
 #
 
-obj-$(CONFIG_FB_RIVA) += rivafb.o
+obj-$(CONFIG_FB_RIVA)     += rivafb.o
 
-rivafb-objs := fbdev.o riva_hw.o nv_driver.o
+rivafb-objs               := fbdev.o riva_hw.o nv_driver.o
+
+ifdef CONFIG_FB_RIVA_I2C
+	rivafb-objs       += rivafb-i2c.o
+endif
diff -Naur linux-2.6.6-rc3-mm2-orig/drivers/video/riva/fbdev.c linux-2.6.6-rc3-mm2/drivers/video/riva/fbdev.c
--- linux-2.6.6-rc3-mm2-orig/drivers/video/riva/fbdev.c	2004-06-16 01:17:54.000000000 +0000
+++ linux-2.6.6-rc3-mm2/drivers/video/riva/fbdev.c	2004-06-16 01:23:31.099423264 +0000
@@ -296,9 +296,8 @@
 static int nomtrr __initdata = 0;
 #endif
 
-#ifndef MODULE
 static char *mode_option __initdata = NULL;
-#endif
+static int  strictmode       = 0;
 
 static struct fb_fix_screeninfo rivafb_fix = {
 	.id		= "nVidia",
@@ -493,54 +492,30 @@
  * rivafb_cursor()
  */
 static void rivafb_load_cursor_image(struct riva_par *par, u8 *data8,
-				     u8 *mask8, u16 bg, u16 fg, u32 w, u32 h)
+				     u16 bg, u16 fg, u32 w, u32 h)
 {
 	int i, j, k = 0;
-	u32 b, m, tmp;
+	u32 b, tmp;
 	u32 *data = (u32 *)data8;
-	u32 *mask = (u32 *)mask8;
 
 	for (i = 0; i < h; i++) {
 		b = *data++;
-		m = *mask++;
 		reverse_order(&b);
 		
 		for (j = 0; j < w/2; j++) {
 			tmp = 0;
 #if defined (__BIG_ENDIAN)
-			if (m & (1 << 31)) {
-				fg |= 1 << 15;
-				bg |= 1 << 15;
-			}
 			tmp = (b & (1 << 31)) ? fg << 16 : bg << 16;
 			b <<= 1;
-			m <<= 1;
-
-			if (m & (1 << 31)) {
-				fg |= 1 << 15;
-				bg |= 1 << 15;
-			}
 			tmp |= (b & (1 << 31)) ? fg : bg;
 			b <<= 1;
-			m <<= 1;
 #else
-			if (m & 1) {
-				fg |= 1 << 15;
-				bg |= 1 << 15;
-			}
 			tmp = (b & 1) ? fg : bg;
 			b >>= 1;
-			m >>= 1;
-			
-			if (m & 1) {
-				fg |= 1 << 15;
-				bg |= 1 << 15;
-			}
 			tmp |= (b & 1) ? fg << 16 : bg << 16;
 			b >>= 1;
-			m >>= 1;
 #endif
-			writel(tmp, par->riva.CURSOR + k++);
+			writel(tmp, &par->riva.CURSOR[k++]);
 		}
 		k += (MAX_CURS - w)/2;
 	}
@@ -833,6 +808,24 @@
 	rivafb_blank(0, info);
 }
 
+static void riva_update_var(struct fb_var_screeninfo *var, struct fb_videomode *modedb)
+{
+	var->xres = var->xres_virtual = modedb->xres;
+	var->yres = modedb->yres;
+        if (var->yres_virtual < var->yres)
+	    var->yres_virtual = var->yres;
+        var->xoffset = var->yoffset = 0;
+        var->pixclock = modedb->pixclock;
+        var->left_margin = modedb->left_margin;
+        var->right_margin = modedb->right_margin;
+        var->upper_margin = modedb->upper_margin;
+        var->lower_margin = modedb->lower_margin;
+        var->hsync_len = modedb->hsync_len;
+        var->vsync_len = modedb->vsync_len;
+        var->sync = modedb->sync;
+        var->vmode = modedb->vmode;
+}
+
 /**
  * rivafb_do_maximize - 
  * @info: pointer to fb_info object containing info for current riva board
@@ -872,7 +865,7 @@
 		       "using maximum available virtual resolution\n");
 		for (i = 0; modes[i].xres != -1; i++) {
 			if (modes[i].xres * nom / den * modes[i].yres <
-			    info->fix.smem_len / 2)
+			    info->fix.smem_len)
 				break;
 		}
 		if (modes[i].xres == -1) {
@@ -927,35 +920,47 @@
 		       "virtual Y resolution (%d) is smaller than real\n", var->yres_virtual);
 		return -EINVAL;
 	}
+	if (var->xres_virtual > 0x7fff)
+	    var->xres_virtual = 0x7fff;
+	if (var->yres_virtual > 0x7fff)
+	    var->yres_virtual = 0x7fff;
 	return 0;
 }
 
+static void
+riva_set_pattern(struct riva_par *par, int clr0, int clr1, int pat0, int pat1)
+{
+	RIVA_FIFO_FREE(par->riva, Patt, 4);
+	par->riva.Patt->Color0        = clr0;
+	par->riva.Patt->Color1        = clr1;
+	par->riva.Patt->Monochrome[0] = pat0;
+	par->riva.Patt->Monochrome[1] = pat1;
+}
+ 
 /* acceleration routines */
 inline void wait_for_idle(struct riva_par *par)
 {
 	while (par->riva.Busy(&par->riva));
 }
 
-/* set copy ROP, no mask */
-static void riva_setup_ROP(struct riva_par *par)
-{
-	RIVA_FIFO_FREE(par->riva, Patt, 5);
-	par->riva.Patt->Shape = 0;
-	par->riva.Patt->Color0 = 0xffffffff;
-	par->riva.Patt->Color1 = 0xffffffff;
-	par->riva.Patt->Monochrome[0] = 0xffffffff;
-	par->riva.Patt->Monochrome[1] = 0xffffffff;
-
-	RIVA_FIFO_FREE(par->riva, Rop, 1);
-	par->riva.Rop->Rop3 = 0xCC;
+/*
+ * Set ROP.  Translate X rop into ROP3.  Internal routine.
+ */
+static void
+riva_set_rop_solid(struct riva_par *par, int rop)
+{    
+	riva_set_pattern(par, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
+        RIVA_FIFO_FREE(par->riva, Rop, 1);
+        par->riva.Rop->Rop3 = rop;
+    
 }
 
 void riva_setup_accel(struct riva_par *par)
 {
 	RIVA_FIFO_FREE(par->riva, Clip, 2);
 	par->riva.Clip->TopLeft     = 0x0;
-	par->riva.Clip->WidthHeight = 0x80008000;
-	riva_setup_ROP(par);
+	par->riva.Clip->WidthHeight = 0x7fff7fff;
+	riva_set_rop_solid(par, 0xcc);
 	wait_for_idle(par);
 }
 
@@ -1043,7 +1048,9 @@
 
 static int rivafb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
+	struct fb_monspecs *specs = &info->monspecs;
 	int nom, den;		/* translating from pixels->bytes */
+	int mode_valid = 0;
 	
 	switch (var->bits_per_pixel) {
 	case 1 ... 8:
@@ -1094,6 +1101,73 @@
 		return -EINVAL;
 	}
 
+	if (!strictmode) {
+		if (!fb_validate_mode(var, info)) 
+			mode_valid = 1;
+	}
+
+	/* find best mode from modedb */
+	if (!mode_valid && specs->modedb_len) {
+		int i, best, best_refresh, best_x, best_y, diff_x, diff_y;
+		
+		best_refresh = best = best_x = best_y = 0;
+		diff_x = diff_y = -1;
+	       
+		for (i = 0; i < specs->modedb_len; i++) {
+			if (var->xres <= specs->modedb[i].xres &&
+			    !(specs->modedb[i].flag & FB_MODE_IS_CALCULATED) &&
+			    specs->modedb[i].xres - var->xres < diff_x) {
+				best_x = specs->modedb[i].xres;
+				diff_x = best_x - var->xres;
+			}
+			if (!diff_x) break;
+		}
+
+		if (diff_x != -1) {
+			for (i = 0; i < specs->modedb_len; i++) {
+				if (best_x == specs->modedb[i].xres &&
+				    var->yres <= specs->modedb[i].yres &&
+				    !(specs->modedb[i].flag & 
+				      FB_MODE_IS_CALCULATED) &&
+				    specs->modedb[i].yres-var->yres < diff_y) {
+					best_y = specs->modedb[i].yres;
+					diff_y = best_y - var->yres;
+				}
+				if (!diff_y) break;
+			}
+		}
+			
+		if (diff_y != -1) {
+			for (i = 0; i < specs->modedb_len; i++) {
+				if (best_x == specs->modedb[i].xres &&
+				    best_y == specs->modedb[i].yres &&
+				    !(specs->modedb[i].flag &
+				      FB_MODE_IS_CALCULATED) &&
+				    specs->modedb[i].refresh > best_refresh) {
+					best_refresh=specs->modedb[i].refresh;
+					best = i;
+				}
+			}				
+		}
+
+		if (best_refresh) { 
+			riva_update_var(var, &specs->modedb[best]);
+			mode_valid = 1;
+		}
+	}
+
+	/* calculate modeline if supported by monitor */
+	if (!mode_valid && info->monspecs.gtf) {
+		if (!fb_get_mode(FB_MAXTIMINGS, 0, var, info))
+			mode_valid = 1;
+	}
+	if (!mode_valid && info->monspecs.modedb_len)
+		return -EINVAL;
+
+	if (var->xres_virtual < var->xres)
+		var->xres_virtual = var->xres;
+	if (var->yres_virtual <= var->yres)
+		var->yres_virtual = -1;
 	if (rivafb_do_maximize(info, var, nom, den) < 0)
 		return -EINVAL;
 
@@ -1329,8 +1403,7 @@
 		break;
 	}
 
-	RIVA_FIFO_FREE(par->riva, Rop, 1);
-	par->riva.Rop->Rop3 = rop;
+	riva_set_rop_solid(par, rop);
 
 	RIVA_FIFO_FREE(par->riva, Bitmap, 1);
 	par->riva.Bitmap->Color1A = color;
@@ -1338,10 +1411,12 @@
 	RIVA_FIFO_FREE(par->riva, Bitmap, 2);
 	par->riva.Bitmap->UnclippedRectangle[0].TopLeft =
 			(rect->dx << 16) | rect->dy;
+	mb();
 	par->riva.Bitmap->UnclippedRectangle[0].WidthHeight =
 			(rect->width << 16) | rect->height;
-	RIVA_FIFO_FREE(par->riva, Rop, 1);
-	par->riva.Rop->Rop3 = 0xCC;	// back to COPY
+	mb();
+	riva_set_rop_solid(par, 0xcc);
+	
 }
 
 /**
@@ -1362,8 +1437,9 @@
 	RIVA_FIFO_FREE(par->riva, Blt, 3);
 	par->riva.Blt->TopLeftSrc  = (region->sy << 16) | region->sx;
 	par->riva.Blt->TopLeftDst  = (region->dy << 16) | region->dx;
+	mb();
 	par->riva.Blt->WidthHeight = (region->height << 16) | region->width;
-	wait_for_idle(par);
+	mb();
 }
 
 static inline void convert_bgcolor_16(u32 *col)
@@ -1372,6 +1448,7 @@
 		| ((*col & 0x000003E0) << 6)
 		| ((*col & 0x0000001F) << 3)
 		|	   0xFF000000;
+	mb();
 }
 
 /**
@@ -1478,7 +1555,6 @@
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 	u8 data[MAX_CURS * MAX_CURS/8];
-	u8 mask[MAX_CURS * MAX_CURS/8];
 	u16 fg, bg;
 	int i;
 
@@ -1508,7 +1584,7 @@
 		info->cursor.image.fg_color = cursor->image.fg_color;
 	}
 
-	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP)) {
+	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP | FB_CUR_SETCUR)) {
 		u32 bg_idx = info->cursor.image.bg_color;
 		u32 fg_idx = info->cursor.image.fg_color;
 		u32 s_pitch = (info->cursor.image.width+7) >> 3;
@@ -1517,34 +1593,35 @@
 		u8 *msk = (u8 *) info->cursor.mask;
 		u8 src[64];	
 		
+		info->cursor.image.data = cursor->image.data;
 		switch (info->cursor.rop) {
 		case ROP_XOR:
-			for (i = 0; i < s_pitch * info->cursor.image.height; i++)
-					src[i] = dat[i] ^ msk[i];
+			for (i = 0; i < s_pitch * info->cursor.image.height;
+			     i++)
+				src[i] = dat[i] ^ msk[i];
 			break;
 		case ROP_COPY:
 		default:
-			for (i = 0; i < s_pitch * info->cursor.image.height; i++)
-				
-					src[i] = dat[i] & msk[i];
+			for (i = 0; i < s_pitch * info->cursor.image.height;
+			     i++)
+				src[i] = dat[i] & msk[i];
 			break;
 		}
 		
-		fb_move_buf_aligned(info, &info->sprite, data, d_pitch, src, s_pitch, info->cursor.image.height);
-
-		fb_move_buf_aligned(info, &info->sprite, mask, d_pitch, msk, s_pitch, info->cursor.image.height);
+		fb_move_buf_aligned(info, &info->sprite, data, d_pitch, src,
+				    s_pitch, info->cursor.image.height);
 
 		bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 		     ((info->cmap.green[bg_idx] & 0xf8) << 2) |
-		     ((info->cmap.blue[bg_idx] & 0xf8) >> 3);
+		     ((info->cmap.blue[bg_idx] & 0xf8) >> 3) | 1 << 15;
 
 		fg = ((info->cmap.red[fg_idx] & 0xf8) << 7) |
 		     ((info->cmap.green[fg_idx] & 0xf8) << 2) |
-		     ((info->cmap.blue[fg_idx] & 0xf8) >> 3);
+		     ((info->cmap.blue[fg_idx] & 0xf8) >> 3) | 1 << 15;
 
 		par->riva.LockUnlock(&par->riva, 0);
 
-		rivafb_load_cursor_image(par, data, mask, bg, fg,
+		rivafb_load_cursor_image(par, data, bg, fg,
 					 info->cursor.image.width, 
 					 info->cursor.image.height);
 	}
@@ -1586,24 +1663,14 @@
 
 static int __devinit riva_set_fbinfo(struct fb_info *info)
 {
-	struct riva_par *par = (struct riva_par *) info->par;
 	unsigned int cmap_len;
 
 	info->flags = FBINFO_FLAG_DEFAULT;
 	info->var = rivafb_default_var;
-	info->fix = rivafb_fix;
-	info->fbops = &riva_fb_ops;
+	info->fix.visual = (info->var.bits_per_pixel == 8) ?
+				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
 	info->pseudo_palette = pseudo_palette;
 
-#ifndef MODULE
-	if (mode_option)
-		fb_find_mode(&info->var, info, mode_option,
-			     NULL, 0, NULL, 8);
-#endif
-	if (par->use_default_var)
-		/* We will use the modified default var */
-		info->var = rivafb_default_var;
-
 	cmap_len = riva_get_cmap_len(&info->var);
 	fb_alloc_cmap(&info->cmap, cmap_len, 0);	
 
@@ -1611,7 +1678,8 @@
 	info->pixmap.buf_align = 4;
 	info->pixmap.scan_align = 4;
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
-	return 0;
+	info->var.yres_virtual = -1;
+	return (rivafb_check_var(&info->var, info));
 }
 
 #ifdef CONFIG_PPC_OF
@@ -1645,77 +1713,35 @@
 }
 #endif /* CONFIG_PPC_OF */
 
-static int riva_dfp_parse_EDID(struct riva_par *par)
+static void riva_update_default_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
-	unsigned char *block = par->EDID;
-
-	if (!block)
-		return 0;
-
-	/* jump to detailed timing block section */
-	block += 54;
+	struct fb_monspecs *specs = &info->monspecs;
+	struct fb_videomode modedb;
 
-	par->clock = (block[0] + (block[1] << 8));
-	par->panel_xres = (block[2] + ((block[4] & 0xf0) << 4));
-	par->hblank = (block[3] + ((block[4] & 0x0f) << 8));
-	par->panel_yres = (block[5] + ((block[7] & 0xf0) << 4));
-	par->vblank = (block[6] + ((block[7] & 0x0f) << 8));
-	par->hOver_plus = (block[8] + ((block[11] & 0xc0) << 2));
-	par->hSync_width = (block[9] + ((block[11] & 0x30) << 4));
-	par->vOver_plus = ((block[10] >> 4) + ((block[11] & 0x0c) << 2));
-	par->vSync_width = ((block[10] & 0x0f) + ((block[11] & 0x03) << 4));
-	par->interlaced = ((block[17] & 0x80) >> 7);
-	par->synct = ((block[17] & 0x18) >> 3);
-	par->misc = ((block[17] & 0x06) >> 1);
-	par->hAct_high = par->vAct_high = 0;
-	if (par->synct == 3) {
-		if (par->misc & 2)
-			par->hAct_high = 1;
-		if (par->misc & 1)
-			par->vAct_high = 1;
+	/* respect mode options */
+	if (mode_option) {
+		fb_find_mode(var, info, mode_option,
+			     specs->modedb, specs->modedb_len,
+			     NULL, 8);
+	} else if (specs->modedb != NULL) {
+		/* get preferred timing */
+		if (info->monspecs.misc & FB_MISC_1ST_DETAIL) {
+			int i;
+			
+			for (i = 0; i < specs->modedb_len; i++) {
+				if (specs->modedb[i].flag & FB_MODE_IS_FIRST) {
+					modedb = specs->modedb[i];
+					break;
+				}
+			}
+		} else {		
+			/* otherwise, get first mode in database */
+			modedb = specs->modedb[0];
+		}
+		var->bits_per_pixel = 8;
+		riva_update_var(var, &modedb);
 	}
-
-	printk(KERN_INFO PFX
-			"detected DFP panel size from EDID: %dx%d\n", 
-			par->panel_xres, par->panel_yres);
-	par->got_dfpinfo = 1;
-	return 1;
-}
-
-static void riva_update_default_var(struct fb_info *info)
-{
-	struct fb_var_screeninfo *var = &rivafb_default_var;
-	struct riva_par *par = (struct riva_par *) info->par;
-
-        var->xres = par->panel_xres;
-        var->yres = par->panel_yres;
-        var->xres_virtual = par->panel_xres;
-        var->yres_virtual = par->panel_yres;
-        var->xoffset = var->yoffset = 0;
-        var->bits_per_pixel = 8;
-        var->pixclock = 100000000 / par->clock;
-        var->left_margin = (par->hblank - par->hOver_plus - par->hSync_width);
-        var->right_margin = par->hOver_plus;
-        var->upper_margin = (par->vblank - par->vOver_plus - par->vSync_width);
-        var->lower_margin = par->vOver_plus;
-        var->hsync_len = par->hSync_width;
-        var->vsync_len = par->vSync_width;
-        var->sync = 0;
-
-        if (par->synct == 3) {
-                if (par->hAct_high)
-                        var->sync |= FB_SYNC_HOR_HIGH_ACT;
-                if (par->vAct_high)
-                        var->sync |= FB_SYNC_VERT_HIGH_ACT;
-        }
- 
-        var->vmode = 0;
-        if (par->interlaced)
-                var->vmode |= FB_VMODE_INTERLACED;
-
 	var->accel_flags |= FB_ACCELF_TEXT;
-        
-        par->use_default_var = 1;
 }
 
 
@@ -1726,19 +1752,27 @@
 		printk("rivafb: could not retrieve EDID from OF\n");
 #else
 	/* XXX use other methods later */
+#ifdef CONFIG_FB_RIVA_I2C
+	struct riva_par *par = (struct riva_par *) info->par;
+
+	riva_create_i2c_busses(par);
+	riva_probe_i2c_connector(par, 1, &par->EDID);
+	riva_delete_i2c_busses(par);
+#endif
 #endif
 }
 
 
-static void riva_get_dfpinfo(struct fb_info *info)
+static void riva_get_edidinfo(struct fb_info *info)
 {
+	struct fb_var_screeninfo *var = &rivafb_default_var;
 	struct riva_par *par = (struct riva_par *) info->par;
 
-	if (riva_dfp_parse_EDID(par))
-		riva_update_default_var(info);
+	fb_edid_to_monspecs(par->EDID, &info->monspecs);
+	riva_update_default_var(var, info);
 
 	/* if user specified flatpanel, we respect that */
-	if (par->got_dfpinfo == 1)
+	if (info->monspecs.input & FB_DISP_DDI)
 		par->FlatPanel = 1;
 }
 
@@ -1768,6 +1802,7 @@
 
 	memset(info, 0, sizeof(struct fb_info));
 	memset(default_par, 0, sizeof(struct riva_par));
+	default_par->pdev = pd;
 
 	info->pixmap.addr = kmalloc(64 * 1024, GFP_KERNEL);
 	if (info->pixmap.addr == NULL)
@@ -1815,10 +1850,6 @@
 
 	info->par = default_par;
 
-	riva_get_EDID(info, pd);
-
-	riva_get_dfpinfo(info);
-
 	switch (default_par->riva.Architecture) {
 	case NV_ARCH_03:
 		/* Riva128's PRAMIN is in the "framebuffer" space
@@ -1883,6 +1914,11 @@
 	}
 #endif /* CONFIG_MTRR */
 
+	info->fbops = &riva_fb_ops;
+	info->fix = rivafb_fix;
+	riva_get_EDID(info, pd);
+	riva_get_edidinfo(info);
+
 	if (riva_set_fbinfo(info) < 0) {
 		printk(KERN_ERR PFX "error setting initial video mode\n");
 		goto err_out_iounmap_fb;
@@ -1991,6 +2027,8 @@
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
 #endif
+		} else if (!strncmp(this_opt, "strictmode", 10)) {
+			strictmode = 1;
 		} else
 			mode_option = this_opt;
 	}
@@ -2039,6 +2077,8 @@
 #ifdef CONFIG_MTRR
 MODULE_PARM(nomtrr, "i");
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) (default=0)");
+MODULE_PARM(strictmode, "i");
+MODULE_PARM_DESC(strictmode, "Only use video modes from EDID");
 #endif
 #endif /* MODULE */
 
diff -Naur linux-2.6.6-rc3-mm2-orig/drivers/video/riva/rivafb-i2c.c linux-2.6.6-rc3-mm2/drivers/video/riva/rivafb-i2c.c
--- linux-2.6.6-rc3-mm2-orig/drivers/video/riva/rivafb-i2c.c	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.6-rc3-mm2/drivers/video/riva/rivafb-i2c.c	2004-06-16 01:20:45.321625320 +0000
@@ -0,0 +1,209 @@
+/*
+ * linux/drivers/video/riva/fbdev-i2c.c - nVidia i2c
+ *
+ * Maintained by Ani Joshi <ajoshi@shell.unixbox.com>
+ *
+ * Copyright 2004 Antonino A. Daplas <adaplas @pol.net>
+ *
+ * Based on radeonfb-i2c.c
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/fb.h>
+
+#include <asm/io.h>
+
+#include "rivafb.h"
+#include "../edid.h"
+
+#define RIVA_DDC 	0x50
+
+static void riva_gpio_setscl(void* data, int state)
+{
+	struct riva_i2c_chan 	*chan = (struct riva_i2c_chan *)data;
+	struct riva_par 	*par = chan->par;
+	u32			val;
+
+	VGA_WR08(par->riva.PCIO, 0x3d4, chan->ddc_base + 1);
+	val = VGA_RD08(par->riva.PCIO, 0x3d5) & 0xf0;
+
+	if (state)
+		val |= 0x20;
+	else
+		val &= ~0x20;
+
+	VGA_WR08(par->riva.PCIO, 0x3d4, chan->ddc_base + 1);
+	VGA_WR08(par->riva.PCIO, 0x3d5, val | 0x1);
+}
+
+static void riva_gpio_setsda(void* data, int state)
+{
+	struct riva_i2c_chan 	*chan = (struct riva_i2c_chan *)data;
+	struct riva_par 	*par = chan->par;
+	u32			val;
+
+	VGA_WR08(par->riva.PCIO, 0x3d4, chan->ddc_base + 1);
+	val = VGA_RD08(par->riva.PCIO, 0x3d5) & 0xf0;
+
+	if (state)
+		val |= 0x10;
+	else
+		val &= ~0x10;
+
+	VGA_WR08(par->riva.PCIO, 0x3d4, chan->ddc_base + 1);
+	VGA_WR08(par->riva.PCIO, 0x3d5, val | 0x1);
+}
+
+static int riva_gpio_getscl(void* data)
+{
+	struct riva_i2c_chan 	*chan = (struct riva_i2c_chan *)data;
+	struct riva_par 	*par = chan->par;
+	u32			val = 0;
+
+	VGA_WR08(par->riva.PCIO, 0x3d4, chan->ddc_base);
+	if (VGA_RD08(par->riva.PCIO, 0x3d5) & 0x04)
+		val = 1;
+
+	val = VGA_RD08(par->riva.PCIO, 0x3d5);
+
+	return val;
+}
+
+static int riva_gpio_getsda(void* data)
+{
+	struct riva_i2c_chan 	*chan = (struct riva_i2c_chan *)data;
+	struct riva_par 	*par = chan->par;
+	u32			val = 0;
+
+	VGA_WR08(par->riva.PCIO, 0x3d4, chan->ddc_base);
+	if (VGA_RD08(par->riva.PCIO, 0x3d5) & 0x08)
+		val = 1;
+	
+	return val;
+}
+
+#define I2C_ALGO_RIVA   0x0e0000
+static int riva_setup_i2c_bus(struct riva_i2c_chan *chan, const char *name)
+{
+	int rc;
+
+	strcpy(chan->adapter.name, name);
+	chan->adapter.owner		= THIS_MODULE;
+	chan->adapter.id		= I2C_ALGO_RIVA;
+	chan->adapter.algo_data		= &chan->algo;
+	chan->adapter.dev.parent	= &chan->par->pdev->dev;
+	chan->algo.setsda		= riva_gpio_setsda;
+	chan->algo.setscl		= riva_gpio_setscl;
+	chan->algo.getsda		= riva_gpio_getsda;
+	chan->algo.getscl		= riva_gpio_getscl;
+	chan->algo.udelay		= 40;
+	chan->algo.timeout		= 20;
+	chan->algo.data 		= chan;
+	
+	i2c_set_adapdata(&chan->adapter, chan);
+	
+	/* Raise SCL and SDA */
+	riva_gpio_setsda(chan, 1);
+	riva_gpio_setscl(chan, 1);
+	udelay(20);
+
+	rc = i2c_bit_add_bus(&chan->adapter);
+	if (rc == 0) 
+		dev_dbg(&chan->par->pdev->dev, "I2C bus %s registered.\n", name);
+	else
+		dev_warn(&chan->par->pdev->dev, "Failed to register I2C bus %s.\n", name);
+	return rc;
+}
+
+void riva_create_i2c_busses(struct riva_par *par)
+{
+	par->chan[0].par	= par;
+	par->chan[1].par	= par;
+	par->chan[2].par        = par;
+
+	switch (par->riva.Architecture) {
+#if 0		/* no support yet for other nVidia chipsets */
+		par->chan[2].ddc_base   = 0x50;
+		riva_setup_i2c_bus(&par->chan[2], "BUS2");
+#endif
+	case NV_ARCH_10:
+	case NV_ARCH_20: 
+	case NV_ARCH_04:
+		par->chan[1].ddc_base	= 0x36;
+		riva_setup_i2c_bus(&par->chan[1], "BUS1");
+	case NV_ARCH_03:
+		par->chan[0].ddc_base	= 0x3e;
+		riva_setup_i2c_bus(&par->chan[0], "BUS0");
+	}
+}
+
+void riva_delete_i2c_busses(struct riva_par *par)
+{
+	if (par->chan[0].par)
+		i2c_bit_del_bus(&par->chan[0].adapter);
+	par->chan[0].par = NULL;
+
+	if (par->chan[1].par)
+		i2c_bit_del_bus(&par->chan[1].adapter);
+	par->chan[1].par = NULL;
+
+}
+
+static u8 *riva_do_probe_i2c_edid(struct riva_i2c_chan *chan)
+{
+	u8 start = 0x0;
+	struct i2c_msg msgs[] = {
+		{
+			.addr	= RIVA_DDC,
+			.len	= 1,
+			.buf	= &start,
+		}, {
+			.addr	= RIVA_DDC,
+			.flags	= I2C_M_RD,
+			.len	= EDID_LENGTH,
+		},
+	};
+	u8 *buf;
+
+	buf = kmalloc(EDID_LENGTH, GFP_KERNEL);
+	if (!buf) {
+		dev_warn(&chan->par->pdev->dev, "Out of memory!\n");
+		return NULL;
+	}
+	msgs[1].buf = buf;
+
+	if (i2c_transfer(&chan->adapter, msgs, 2) == 2)
+		return buf;
+	dev_dbg(&chan->par->pdev->dev, "Unable to read EDID block.\n");
+	kfree(buf);
+	return NULL;
+}
+
+int riva_probe_i2c_connector(struct riva_par *par, int conn, u8 **out_edid)
+{
+	u8 *edid = NULL;
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		/* Do the real work */
+		edid = riva_do_probe_i2c_edid(&par->chan[conn-1]);
+		if (edid) 
+			break;
+	}
+	if (out_edid)
+		*out_edid = edid;
+	if (!edid) 
+		return 1;
+
+	return 0;
+}
+
diff -Naur linux-2.6.6-rc3-mm2-orig/drivers/video/riva/rivafb.h linux-2.6.6-rc3-mm2/drivers/video/riva/rivafb.h
--- linux-2.6.6-rc3-mm2-orig/drivers/video/riva/rivafb.h	2004-05-10 02:32:27.000000000 +0000
+++ linux-2.6.6-rc3-mm2/drivers/video/riva/rivafb.h	2004-06-16 01:20:45.322625168 +0000
@@ -4,6 +4,10 @@
 #include <linux/config.h>
 #include <linux/fb.h>
 #include <video/vga.h>
+#include <linux/i2c.h>
+#include <linux/i2c-id.h>
+#include <linux/i2c-algo-bit.h>
+
 #include "riva_hw.h"
 
 /* GGI compatibility macros */
@@ -12,6 +16,12 @@
 #define NUM_GRC_REGS		0x09
 #define NUM_ATC_REGS		0x15
 
+/* I2C */
+#define DDC_SCL_READ_MASK       (1 << 2)
+#define DDC_SCL_WRITE_MASK      (1 << 5)
+#define DDC_SDA_READ_MASK       (1 << 3)
+#define DDC_SDA_WRITE_MASK      (1 << 4)
+
 /* holds the state of the VGA core and extended Riva hw state from riva_hw.c.
  * From KGI originally. */
 struct riva_regs {
@@ -23,6 +33,15 @@
 	RIVA_HW_STATE ext;
 };
 
+struct riva_par;
+
+struct riva_i2c_chan {
+	struct riva_par *par;
+	unsigned long   ddc_base;
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data algo;
+};
+
 struct riva_par {
 	RIVA_HW_INST riva;	/* interface to riva_hw.c */
 
@@ -36,26 +55,22 @@
 	u32 cursor_data[32 * 32/4];
 	int cursor_reset;
 	unsigned char *EDID;
-
-	int panel_xres, panel_yres;
-	int hOver_plus, hSync_width, hblank;
-	int vOver_plus, vSync_width, vblank;
-	int hAct_high, vAct_high, interlaced;
-	int synct, misc, clock;
-
-	int use_default_var;
-	int got_dfpinfo;
 	unsigned int Chipset;
 	int forceCRTC;
 	Bool SecondCRTC;
 	int FlatPanel;
+	struct pci_dev *pdev;
 #ifdef CONFIG_MTRR
 	struct { int vram; int vram_valid; } mtrr;
 #endif
+	struct riva_i2c_chan chan[3];
 };
 
 void riva_common_setup(struct riva_par *);
 unsigned long riva_get_memlen(struct riva_par *);
 unsigned long riva_get_maxdclk(struct riva_par *);
+void riva_delete_i2c_busses(struct riva_par *par);
+void riva_create_i2c_busses(struct riva_par *par);
+int riva_probe_i2c_connector(struct riva_par *par, int conn, u8 **out_edid);
 
 #endif /* __RIVAFB_H */





-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
