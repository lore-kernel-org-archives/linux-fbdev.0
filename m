From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] Port amifb to new fbdev API
Date: Wed, 19 Mar 2003 13:33:59 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200303191233.h2JCXx901062@vervain.sonytel.be>
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=mail.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18vcm5-0004nf-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 19 Mar 2003 04:34:29 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@transmeta.com>, James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geert Uytterhoeven <geert@linux-m68k.org>

Amiga frame buffer device: Port to the new fbdev API

--- linux-2.5.x/drivers/video/Makefile	Mon Feb 17 17:38:49 2003
+++ linux-m68k-2.5.x/drivers/video/Makefile	Mon Feb 10 22:30:27 2003
@@ -13,7 +13,7 @@
 endif
 
 obj-$(CONFIG_FB_ACORN)            += acornfb.o cfbfillrect.o cfbcopyarea.o cfbimgblt.o
-obj-$(CONFIG_FB_AMIGA)            += amifb.o
+obj-$(CONFIG_FB_AMIGA)            += amifb.o c2p.o
 obj-$(CONFIG_FB_PM2)              += pm2fb.o
 obj-$(CONFIG_FB_PM3)		  += pm3fb.o
 obj-$(CONFIG_FB_APOLLO)           += dnfb.o cfbfillrect.o cfbimgblt.o
--- linux-2.5.x/drivers/video/amifb.c	Tue Dec 10 13:41:40 2002
+++ linux-m68k-2.5.x/drivers/video/amifb.c	Sat Jan 25 19:58:10 2003
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/video/amifb.c -- Amiga builtin chipset frame buffer device
  *
- *    Copyright (C) 1995 Geert Uytterhoeven
+ *    Copyright (C) 1995-2003 Geert Uytterhoeven
  *
  *          with work by Roman Zippel
  *
@@ -62,10 +62,7 @@
 #include <asm/amigaints.h>
 #include <asm/setup.h>
 
-#include <video/fbcon.h>
-#include <video/fbcon-afb.h>
-#include <video/fbcon-ilbm.h>
-#include <video/fbcon-mfb.h>
+#include "c2p.h"
 
 
 #define DEBUG
@@ -613,12 +610,11 @@
 
 #define SPRITEMEMSIZE		(64*64/4) /* max 64*64*4 */
 #define DUMMYSPRITEMEMSIZE	(8)
+static u_long spritememory;
 
 #define CHIPRAM_SAFETY_LIMIT	(16384)
 
-static u_long videomemory, spritememory;
-static u_long videomemorysize;
-static u_long videomemory_phys;
+static u_long videomemory;
 
 	/*
 	 * This is the earliest allowed start of fetching display data.
@@ -660,6 +656,47 @@
 static u_short currentcop = 0;
 
 	/*
+	 * Hardware Cursor API Definitions
+	 * These used to be in linux/fb.h, but were preliminary and used by
+	 * amifb only anyway
+	 */
+
+#define FBIOGET_FCURSORINFO     0x4607
+#define FBIOGET_VCURSORINFO     0x4608
+#define FBIOPUT_VCURSORINFO     0x4609
+#define FBIOGET_CURSORSTATE     0x460A
+#define FBIOPUT_CURSORSTATE     0x460B
+
+
+struct fb_fix_cursorinfo {
+	__u16 crsr_width;		/* width and height of the cursor in */
+	__u16 crsr_height;		/* pixels (zero if no cursor)	*/
+	__u16 crsr_xsize;		/* cursor size in display pixels */
+	__u16 crsr_ysize;
+	__u16 crsr_color1;		/* colormap entry for cursor color1 */
+	__u16 crsr_color2;		/* colormap entry for cursor color2 */
+};
+
+struct fb_var_cursorinfo {
+	__u16 width;
+	__u16 height;
+	__u16 xspot;
+	__u16 yspot;
+	__u8 data[1];			/* field with [height][width]        */
+};
+
+struct fb_cursorstate {
+	__s16 xoffset;
+	__s16 yoffset;
+	__u16 mode;
+};
+
+#define FB_CURSOR_OFF		0
+#define FB_CURSOR_ON		1
+#define FB_CURSOR_FLASH		2
+
+
+	/*
 	 * Hardware Cursor
 	 */
 
@@ -738,28 +775,28 @@
 	u_short fmode;		/* vmode */
 } currentpar;
 
-static struct display disp;
 
-static struct fb_info fb_info;
+static struct fb_info fb_info = {
+    .fix = {
+	.id		= "Amiga ",
+	.visual		= FB_VISUAL_PSEUDOCOLOR,
+	.accel		= FB_ACCEL_AMIGABLITT
+    }
+};
 
 
 	/*
-	 * Since we can't read the palette on OCS/ECS, and since reading one
-	 * single color palette entry requires 5 expensive custom chip bus accesses
-	 * on AGA, we keep a copy of the current palette.
-	 * Note that the entries are always 24 bit!
+	 *  Saved color entry 0 so we can restore it when unblanking
 	 */
 
-#if defined(CONFIG_FB_AMIGA_AGA)
-static struct { u_char red, green, blue, pad; } palette[256];
-#else
-static struct { u_char red, green, blue, pad; } palette[32];
-#endif
+static u_char red0, green0, blue0;
+
 
 #if defined(CONFIG_FB_AMIGA_ECS)
 static u_short ecs_palette[32];
 #endif
 
+
 	/*
 	 * Latches for Display Changes during VBlank
 	 */
@@ -778,15 +815,6 @@
 static u_short is_lace = 0;		/* Screen is laced */
 
 	/*
-	 * Frame Buffer Name
-	 *
-	 * The rest of the name is filled in during initialization
-	 */
-
-static char amifb_name[16] = "Amiga ";
-
-
-	/*
 	 * Predefined Video Modes
 	 *
 	 */
@@ -1087,29 +1115,22 @@
 
 int amifb_setup(char*);
 
-static int amifb_get_fix(struct fb_fix_screeninfo *fix, int con,
-			 struct fb_info *info);
-static int amifb_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info);
-static int amifb_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info);
-static int amifb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
-                           u_int transp, struct fb_info *info);
+static int amifb_check_var(struct fb_var_screeninfo *var,
+			   struct fb_info *info);
+static int amifb_set_par(struct fb_info *info);
+static int amifb_setcolreg(unsigned regno, unsigned red, unsigned green,
+			   unsigned blue, unsigned transp,
+			   struct fb_info *info);
 static int amifb_blank(int blank, struct fb_info *info);
-static int amifb_pan_display(struct fb_var_screeninfo *var, int con,
+static int amifb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
-static int amifb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info);
-static int amifb_ioctl(struct inode *inode, struct file *file, u_int cmd,
-		       u_long arg, int con, struct fb_info *info);
-
-static int amifb_get_fix_cursorinfo(struct fb_fix_cursorinfo *fix, int con);
-static int amifb_get_var_cursorinfo(struct fb_var_cursorinfo *var,
-				       u_char *data, int con);
-static int amifb_set_var_cursorinfo(struct fb_var_cursorinfo *var,
-				       u_char *data, int con);
-static int amifb_get_cursorstate(struct fb_cursorstate *state, int con);
-static int amifb_set_cursorstate(struct fb_cursorstate *state, int con);
+static void amifb_fillrect(struct fb_info *info, struct fb_fillrect *rect);
+static void amifb_copyarea(struct fb_info *info, struct fb_copyarea *region);
+static void amifb_imageblit(struct fb_info *info, struct fb_image *image);
+static int amifb_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, unsigned long arg,
+		       struct fb_info *info);
+
 
 	/*
 	 * Interface to the low level console driver
@@ -1117,8 +1138,6 @@
 
 int amifb_init(void);
 static void amifb_deinit(void);
-static int amifbcon_switch(int con, struct fb_info *info);
-static int amifbcon_updatevar(int con, struct fb_info *info);
 
 	/*
 	 * Internal routines
@@ -1133,29 +1152,20 @@
 	 * Hardware routines
 	 */
 
-static int ami_encode_fix(struct fb_fix_screeninfo *fix,
-                          struct amifb_par *par);
 static int ami_decode_var(struct fb_var_screeninfo *var,
                           struct amifb_par *par);
 static int ami_encode_var(struct fb_var_screeninfo *var,
                           struct amifb_par *par);
-static void ami_get_par(struct amifb_par *par);
-static void ami_set_var(struct fb_var_screeninfo *var);
-#ifdef DEBUG
-static void ami_set_par(struct amifb_par *par);
-#endif
 static void ami_pan_var(struct fb_var_screeninfo *var);
 static int ami_update_par(void);
-static int ami_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
-                         u_int *transp, struct fb_info *info);
 static void ami_update_display(void);
 static void ami_init_display(void);
 static void ami_do_blank(void);
-static int ami_get_fix_cursorinfo(struct fb_fix_cursorinfo *fix, int con);
-static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data, int con);
-static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data, int con);
-static int ami_get_cursorstate(struct fb_cursorstate *state, int con);
-static int ami_set_cursorstate(struct fb_cursorstate *state, int con);
+static int ami_get_fix_cursorinfo(struct fb_fix_cursorinfo *fix);
+static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data);
+static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data);
+static int ami_get_cursorstate(struct fb_cursorstate *state);
+static int ami_set_cursorstate(struct fb_cursorstate *state);
 static void ami_set_sprite(void);
 static void ami_init_copper(void);
 static void ami_reinit_copper(void);
@@ -1165,14 +1175,15 @@
 
 static struct fb_ops amifb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_get_fix	= amifb_get_fix,
-	.fb_get_var	= amifb_get_var,
-	.fb_set_var	= amifb_set_var,
-	.fb_get_cmap	= amifb_get_cmap,
-	.fb_set_cmap	= gen_set_cmap,
+	.fb_check_var	= amifb_check_var,
+	.fb_set_par	= amifb_set_par,
 	.fb_setcolreg	= amifb_setcolreg,
-	.fb_pan_display	= amifb_pan_display,
 	.fb_blank	= amifb_blank,
+	.fb_pan_display	= amifb_pan_display,
+	.fb_fillrect	= amifb_fillrect,
+	.fb_copyarea	= amifb_copyarea,
+	.fb_imageblit	= amifb_imageblit,
+	.fb_cursor	= soft_cursor,
 	.fb_ioctl	= amifb_ioctl,
 };
 
@@ -1217,8 +1228,6 @@
 {
 	char *this_opt;
 
-	fb_info.fontname[0] = '\0';
-
 	if (!options || !*options)
 		return 0;
 
@@ -1234,8 +1243,6 @@
 			amifb_ilbm = 1;
 		else if (!strncmp(this_opt, "monitorcap:", 11))
 			amifb_setup_mcap(this_opt+11);
-		else if (!strncmp(this_opt, "font:", 5))
-			strcpy(fb_info.fontname, this_opt+5);
 		else if (!strncmp(this_opt, "fstart:", 7))
 			min_fstrt = simple_strtoul(this_opt+7, NULL, 0);
 		else
@@ -1248,293 +1255,975 @@
 	return 0;
 }
 
-	/*
-	 * Get the Fixed Part of the Display
-	 */
 
-static int amifb_get_fix(struct fb_fix_screeninfo *fix, int con,
-			 struct fb_info *info)
+static int amifb_check_var(struct fb_var_screeninfo *var,
+			   struct fb_info *info)
 {
+	int err;
 	struct amifb_par par;
 
-	if (con == -1)
-		ami_get_par(&par);
-	else {
-		int err;
+	/* Validate wanted screen parameters */
+	if ((err = ami_decode_var(var, &par)))
+		return err;
 
-		if ((err = ami_decode_var(&fb_display[con].var, &par)))
-			return err;
-	}
-	return ami_encode_fix(fix, &par);
+	/* Encode (possibly rounded) screen parameters */
+	ami_encode_var(var, &par);
+	return 0;
 }
 
-	/*
-	 * Get the User Defined Part of the Display
-	 */
 
-static int amifb_get_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
+static int amifb_set_par(struct fb_info *info)
 {
-	int err = 0;
-
-	if (con == -1) {
-		struct amifb_par par;
+	struct amifb_par *par = (struct amifb_par *)info->par;
 
-		ami_get_par(&par);
-		err = ami_encode_var(var, &par);
-	} else
-		*var = fb_display[con].var;
-	return err;
-}
-
-	/*
-	 * Set the User Defined Part of the Display
-	 */
+	do_vmode_pan = 0;
+	do_vmode_full = 0;
 
-static int amifb_set_var(struct fb_var_screeninfo *var, int con,
-			 struct fb_info *info)
-{
-	int err, activate = var->activate;
-	int oldxres, oldyres, oldvxres, oldvyres, oldbpp;
-	struct amifb_par par;
+	/* Decode wanted screen parameters */
+	ami_decode_var(&info->var, par);
 
-	struct display *display;
-	if (con >= 0)
-		display = &fb_display[con];
-	else
-		display = &disp;	/* used during initialization */
+	/* Set new videomode */
+	ami_build_copper();
 
-	/*
-	 * FB_VMODE_CONUPDATE and FB_VMODE_SMOOTH_XPAN are equal!
-	 * as FB_VMODE_SMOOTH_XPAN is only used internally
-	 */
+	/* Set VBlank trigger */
+	do_vmode_full = 1;
 
-	if (var->vmode & FB_VMODE_CONUPDATE) {
-		var->vmode |= FB_VMODE_YWRAP;
-		var->xoffset = display->var.xoffset;
-		var->yoffset = display->var.yoffset;
+	/* Update fix for new screen parameters */
+	if (par->bpp == 1) {
+		info->fix.type = FB_TYPE_PACKED_PIXELS;
+		info->fix.type_aux = 0;
+	} else if (amifb_ilbm) {
+		info->fix.type = FB_TYPE_INTERLEAVED_PLANES;
+		info->fix.type_aux = par->next_line;
+	} else {
+		info->fix.type = FB_TYPE_PLANES;
+		info->fix.type_aux = 0;
 	}
-	if ((err = ami_decode_var(var, &par)))
-		return err;
-	ami_encode_var(var, &par);
-	if ((activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
-		oldxres = display->var.xres;
-		oldyres = display->var.yres;
-		oldvxres = display->var.xres_virtual;
-		oldvyres = display->var.yres_virtual;
-		oldbpp = display->var.bits_per_pixel;
-		display->var = *var;
-		if (oldxres != var->xres || oldyres != var->yres ||
-		    oldvxres != var->xres_virtual || oldvyres != var->yres_virtual ||
-		    oldbpp != var->bits_per_pixel) {
-			struct fb_fix_screeninfo fix;
-
-			ami_encode_fix(&fix, &par);
-			display->visual = fix.visual;
-			display->type = fix.type;
-			display->type_aux = fix.type_aux;
-			display->ypanstep = fix.ypanstep;
-			display->ywrapstep = fix.ywrapstep;
-			display->line_length = fix.line_length;
-			display->can_soft_blank = 1;
-			display->inverse = amifb_inverse;
-			switch (fix.type) {
-#ifdef FBCON_HAS_ILBM
-			    case FB_TYPE_INTERLEAVED_PLANES:
-				display->dispsw = &fbcon_ilbm;
-				break;
-#endif
-#ifdef FBCON_HAS_AFB
-			    case FB_TYPE_PLANES:
-				display->dispsw = &fbcon_afb;
-				break;
-#endif
-#ifdef FBCON_HAS_MFB
-			    case FB_TYPE_PACKED_PIXELS:	/* depth == 1 */
-				display->dispsw = &fbcon_mfb;
-				break;
-#endif
-			    default:
-				display->dispsw = &fbcon_dummy;
-			}
-			if (fb_info.changevar)
-				(*fb_info.changevar)(con);
-		}
-		if (oldbpp != var->bits_per_pixel) {
-			if ((err = fb_alloc_cmap(&display->cmap, 0, 0)))
-				return err;
-			do_install_cmap(con, info);
-		}
-		if (con == info->currcon)
-			ami_set_var(&display->var);
+	info->fix.line_length = div8(upx(16<<maxfmode, par->vxres));
+
+	if (par->vmode & FB_VMODE_YWRAP) {
+		info->fix.ywrapstep = 1;
+		info->fix.xpanstep = 0;
+		info->fix.ypanstep = 0;
+	} else {
+		info->fix.ywrapstep = 0;
+		if (par->vmode &= FB_VMODE_SMOOTH_XPAN)
+			info->fix.xpanstep = 1;
+		else
+			info->fix.xpanstep = 16<<maxfmode;
+		info->fix.ypanstep = 1;
 	}
 	return 0;
 }
 
+
 	/*
 	 * Pan or Wrap the Display
 	 *
 	 * This call looks only at xoffset, yoffset and the FB_VMODE_YWRAP flag
 	 */
 
-static int amifb_pan_display(struct fb_var_screeninfo *var, int con,
-				struct fb_info *info)
+static int amifb_pan_display(struct fb_var_screeninfo *var,
+			     struct fb_info *info)
 {
 	if (var->vmode & FB_VMODE_YWRAP) {
-		if (var->yoffset<0 || var->yoffset >= fb_display[con].var.yres_virtual || var->xoffset)
+		if (var->yoffset < 0 ||
+		    var->yoffset >= info->var.yres_virtual || var->xoffset)
 			return -EINVAL;
 	} else {
 		/*
 		 * TODO: There will be problems when xpan!=1, so some columns
 		 * on the right side will never be seen
 		 */
-		if (var->xoffset+fb_display[con].var.xres > upx(16<<maxfmode, fb_display[con].var.xres_virtual) ||
-		    var->yoffset+fb_display[con].var.yres > fb_display[con].var.yres_virtual)
+		if (var->xoffset+info->var.xres > upx(16<<maxfmode, info->var.xres_virtual) ||
+		    var->yoffset+info->var.yres > info->var.yres_virtual)
 			return -EINVAL;
 	}
-	if (con == info->currcon)
-		ami_pan_var(var);
-	fb_display[con].var.xoffset = var->xoffset;
-	fb_display[con].var.yoffset = var->yoffset;
+	ami_pan_var(var);
+	info->var.xoffset = var->xoffset;
+	info->var.yoffset = var->yoffset;
 	if (var->vmode & FB_VMODE_YWRAP)
-		fb_display[con].var.vmode |= FB_VMODE_YWRAP;
+		info->var.vmode |= FB_VMODE_YWRAP;
 	else
-		fb_display[con].var.vmode &= ~FB_VMODE_YWRAP;
+		info->var.vmode &= ~FB_VMODE_YWRAP;
 	return 0;
 }
 
-	/*
-	 * Get the Colormap
-	 */
 
-static int amifb_get_cmap(struct fb_cmap *cmap, int kspc, int con,
-			  struct fb_info *info)
+#if BITS_PER_LONG == 32
+#define BYTES_PER_LONG	4
+#define SHIFT_PER_LONG	5
+#elif BITS_PER_LONG == 64
+#define BYTES_PER_LONG	8
+#define SHIFT_PER_LONG	6
+#else
+#define Please update me
+#endif
+
+
+    /*
+     *  Compose two values, using a bitmask as decision value
+     *  This is equivalent to (a & mask) | (b & ~mask)
+     */
+
+static inline unsigned long comp(unsigned long a, unsigned long b,
+				 unsigned long mask)
 {
-	if (con == info->currcon) /* current console? */
-		return fb_get_cmap(cmap, kspc, ami_getcolreg, info);
-	else if (fb_display[con].cmap.len) /* non default colormap? */
-		fb_copy_cmap(&fb_display[con].cmap, cmap, kspc ? 0 : 2);
-	else
-		fb_copy_cmap(fb_default_cmap(1<<fb_display[con].var.bits_per_pixel),
-			     cmap, kspc ? 0 : 2);
-	return 0;
+	return ((a ^ b) & mask) ^ b;
 }
-	
-	/*
-	 * Amiga Frame Buffer Specific ioctls
-	 */
 
-static int amifb_ioctl(struct inode *inode, struct file *file,
-                       u_int cmd, u_long arg, int con, struct fb_info *info)
+
+static inline unsigned long xor(unsigned long a, unsigned long b,
+				unsigned long mask)
 {
-	int i;
+	return (a & mask) ^ b;
+}
 
-	switch (cmd) {
-		case FBIOGET_FCURSORINFO : {
-			struct fb_fix_cursorinfo crsrfix;
-			
-			i = verify_area(VERIFY_WRITE, (void *)arg, sizeof(crsrfix));
-			if (!i) {
-				i = amifb_get_fix_cursorinfo(&crsrfix, con);
-				copy_to_user((void *)arg, &crsrfix, sizeof(crsrfix));
-			}
-			return i;
-		}
-		case FBIOGET_VCURSORINFO : {
-			struct fb_var_cursorinfo crsrvar;
 
-			i = verify_area(VERIFY_WRITE, (void *)arg, sizeof(crsrvar));
-			if (!i) {
-				i = amifb_get_var_cursorinfo(&crsrvar,
-					((struct fb_var_cursorinfo *)arg)->data, con);
-				copy_to_user((void *)arg, &crsrvar, sizeof(crsrvar));
-			}
-			return i;
+    /*
+     *  Unaligned forward bit copy using 32-bit or 64-bit memory accesses
+     */
+
+static void bitcpy(unsigned long *dst, int dst_idx, const unsigned long *src,
+		   int src_idx, u32 n)
+{
+	unsigned long first, last;
+	int shift = dst_idx-src_idx, left, right;
+	unsigned long d0, d1;
+	int m;
+
+	if (!n)
+		return;
+
+	shift = dst_idx-src_idx;
+	first = ~0UL >> dst_idx;
+	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+
+	if (!shift) {
+		// Same alignment for source and dest
+
+		if (dst_idx+n <= BITS_PER_LONG) {
+			// Single word
+			if (last)
+				first &= last;
+			*dst = comp(*src, *dst, first);
+		} else {
+			// Multiple destination words
+			// Leading bits
+			if (first) {
+				*dst = comp(*src, *dst, first);
+				dst++;
+				src++;
+				n -= BITS_PER_LONG-dst_idx;
+			}
+
+			// Main chunk
+			n /= BITS_PER_LONG;
+			while (n >= 8) {
+				*dst++ = *src++;
+				*dst++ = *src++;
+				*dst++ = *src++;
+				*dst++ = *src++;
+				*dst++ = *src++;
+				*dst++ = *src++;
+				*dst++ = *src++;
+				*dst++ = *src++;
+				n -= 8;
+			}
+			while (n--)
+				*dst++ = *src++;
+
+			// Trailing bits
+			if (last)
+				*dst = comp(*src, *dst, last);
 		}
-		case FBIOPUT_VCURSORINFO : {
-			struct fb_var_cursorinfo crsrvar;
+	} else {
+		// Different alignment for source and dest
+
+		right = shift & (BITS_PER_LONG-1);
+		left = -shift & (BITS_PER_LONG-1);
 
-			i = verify_area(VERIFY_READ, (void *)arg, sizeof(crsrvar));
-			if (!i) {
-				copy_from_user(&crsrvar, (void *)arg, sizeof(crsrvar));
-				i = amifb_set_var_cursorinfo(&crsrvar,
-					((struct fb_var_cursorinfo *)arg)->data, con);
+		if (dst_idx+n <= BITS_PER_LONG) {
+			// Single destination word
+			if (last)
+				first &= last;
+			if (shift > 0) {
+				// Single source word
+				*dst = comp(*src >> right, *dst, first);
+			} else if (src_idx+n <= BITS_PER_LONG) {
+				// Single source word
+				*dst = comp(*src << left, *dst, first);
+			} else {
+				// 2 source words
+				d0 = *src++;
+				d1 = *src;
+				*dst = comp(d0 << left | d1 >> right, *dst,
+					    first);
+			}
+		} else {
+			// Multiple destination words
+			d0 = *src++;
+			// Leading bits
+			if (shift > 0) {
+				// Single source word
+				*dst = comp(d0 >> right, *dst, first);
+				dst++;
+				n -= BITS_PER_LONG-dst_idx;
+			} else {
+				// 2 source words
+				d1 = *src++;
+				*dst = comp(d0 << left | d1 >> right, *dst,
+					    first);
+				d0 = d1;
+				dst++;
+				n -= BITS_PER_LONG-dst_idx;
+			}
+
+			// Main chunk
+			m = n % BITS_PER_LONG;
+			n /= BITS_PER_LONG;
+			while (n >= 4) {
+				d1 = *src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+				d1 = *src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+				d1 = *src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+				d1 = *src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+				n -= 4;
+			}
+			while (n--) {
+				d1 = *src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+			}
+
+			// Trailing bits
+			if (last) {
+				if (m <= right) {
+					// Single source word
+					*dst = comp(d0 << left, *dst, last);
+				} else {
+					// 2 source words
+					d1 = *src;
+					*dst = comp(d0 << left | d1 >> right,
+						    *dst, last);
+				}
 			}
-			return i;
 		}
-		case FBIOGET_CURSORSTATE : {
-			struct fb_cursorstate crsrstate;
+	}
+}
 
-			i = verify_area(VERIFY_WRITE, (void *)arg, sizeof(crsrstate));
-			if (!i) {
-				i = amifb_get_cursorstate(&crsrstate, con);
-				copy_to_user((void *)arg, &crsrstate, sizeof(crsrstate));
-			}
-			return i;
+
+    /*
+     *  Unaligned reverse bit copy using 32-bit or 64-bit memory accesses
+     */
+
+static void bitcpy_rev(unsigned long *dst, int dst_idx,
+		       const unsigned long *src, int src_idx, u32 n)
+{
+	unsigned long first, last;
+	int shift = dst_idx-src_idx, left, right;
+	unsigned long d0, d1;
+	int m;
+
+	if (!n)
+		return;
+
+	dst += (n-1)/BITS_PER_LONG;
+	src += (n-1)/BITS_PER_LONG;
+	if ((n-1) % BITS_PER_LONG) {
+		dst_idx += (n-1) % BITS_PER_LONG;
+		dst += dst_idx >> SHIFT_PER_LONG;
+		dst_idx &= BITS_PER_LONG-1;
+		src_idx += (n-1) % BITS_PER_LONG;
+		src += src_idx >> SHIFT_PER_LONG;
+		src_idx &= BITS_PER_LONG-1;
+	}
+
+	shift = dst_idx-src_idx;
+	first = ~0UL << (BITS_PER_LONG-1-dst_idx);
+	last = ~(~0UL << (BITS_PER_LONG-1-((dst_idx-n) % BITS_PER_LONG)));
+
+	if (!shift) {
+		// Same alignment for source and dest
+
+		if ((unsigned long)dst_idx+1 >= n) {
+			// Single word
+			if (last)
+				first &= last;
+			*dst = comp(*src, *dst, first);
+		} else {
+			// Multiple destination words
+			// Leading bits
+			if (first) {
+				*dst = comp(*src, *dst, first);
+				dst--;
+				src--;
+				n -= dst_idx+1;
+			}
+
+			// Main chunk
+			n /= BITS_PER_LONG;
+			while (n >= 8) {
+				*dst-- = *src--;
+				*dst-- = *src--;
+				*dst-- = *src--;
+				*dst-- = *src--;
+				*dst-- = *src--;
+				*dst-- = *src--;
+				*dst-- = *src--;
+				*dst-- = *src--;
+				n -= 8;
+			}
+			while (n--)
+				*dst-- = *src--;
+
+			// Trailing bits
+			if (last)
+				*dst = comp(*src, *dst, last);
 		}
-		case FBIOPUT_CURSORSTATE : {
-			struct fb_cursorstate crsrstate;
+	} else {
+		// Different alignment for source and dest
+
+		right = shift & (BITS_PER_LONG-1);
+		left = -shift & (BITS_PER_LONG-1);
 
-			i = verify_area(VERIFY_READ, (void *)arg, sizeof(crsrstate));
-			if (!i) {
-				copy_from_user(&crsrstate, (void *)arg, sizeof(crsrstate));
-				i = amifb_set_cursorstate(&crsrstate, con);
+		if ((unsigned long)dst_idx+1 >= n) {
+			// Single destination word
+			if (last)
+				first &= last;
+			if (shift < 0) {
+				// Single source word
+				*dst = comp(*src << left, *dst, first);
+			} else if (1+(unsigned long)src_idx >= n) {
+				// Single source word
+				*dst = comp(*src >> right, *dst, first);
+			} else {
+				// 2 source words
+				d0 = *src--;
+				d1 = *src;
+				*dst = comp(d0 >> right | d1 << left, *dst,
+					    first);
+			}
+		} else {
+			// Multiple destination words
+			d0 = *src--;
+			// Leading bits
+			if (shift < 0) {
+				// Single source word
+				*dst = comp(d0 << left, *dst, first);
+				dst--;
+				n -= dst_idx+1;
+			} else {
+				// 2 source words
+				d1 = *src--;
+				*dst = comp(d0 >> right | d1 << left, *dst,
+					    first);
+				d0 = d1;
+				dst--;
+				n -= dst_idx+1;
+			}
+
+			// Main chunk
+			m = n % BITS_PER_LONG;
+			n /= BITS_PER_LONG;
+			while (n >= 4) {
+				d1 = *src--;
+				*dst-- = d0 >> right | d1 << left;
+				d0 = d1;
+				d1 = *src--;
+				*dst-- = d0 >> right | d1 << left;
+				d0 = d1;
+				d1 = *src--;
+				*dst-- = d0 >> right | d1 << left;
+				d0 = d1;
+				d1 = *src--;
+				*dst-- = d0 >> right | d1 << left;
+				d0 = d1;
+				n -= 4;
+			}
+			while (n--) {
+				d1 = *src--;
+				*dst-- = d0 >> right | d1 << left;
+				d0 = d1;
+			}
+
+			// Trailing bits
+			if (last) {
+				if (m <= left) {
+					// Single source word
+					*dst = comp(d0 >> right, *dst, last);
+				} else {
+					// 2 source words
+					d1 = *src;
+					*dst = comp(d0 >> right | d1 << left,
+						    *dst, last);
+				}
 			}
-			return i;
 		}
-#ifdef DEBUG
-		case FBCMD_GET_CURRENTPAR : {
-			struct amifb_par par;
+	}
+}
 
-			i = verify_area(VERIFY_WRITE, (void *)arg, sizeof(struct amifb_par));
-			if (!i) {
-				ami_get_par(&par);
-				copy_to_user((void *)arg, &par, sizeof(struct amifb_par));
-			}
-			return i;
+
+    /*
+     *  Unaligned forward inverting bit copy using 32-bit or 64-bit memory
+     *  accesses
+     */
+
+static void bitcpy_not(unsigned long *dst, int dst_idx,
+		       const unsigned long *src, int src_idx, u32 n)
+{
+	unsigned long first, last;
+	int shift = dst_idx-src_idx, left, right;
+	unsigned long d0, d1;
+	int m;
+
+	if (!n)
+		return;
+
+	shift = dst_idx-src_idx;
+	first = ~0UL >> dst_idx;
+	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+
+	if (!shift) {
+		// Same alignment for source and dest
+
+		if (dst_idx+n <= BITS_PER_LONG) {
+			// Single word
+			if (last)
+				first &= last;
+			*dst = comp(~*src, *dst, first);
+		} else {
+			// Multiple destination words
+			// Leading bits
+			if (first) {
+				*dst = comp(~*src, *dst, first);
+				dst++;
+				src++;
+				n -= BITS_PER_LONG-dst_idx;
+			}
+
+			// Main chunk
+			n /= BITS_PER_LONG;
+			while (n >= 8) {
+				*dst++ = ~*src++;
+				*dst++ = ~*src++;
+				*dst++ = ~*src++;
+				*dst++ = ~*src++;
+				*dst++ = ~*src++;
+				*dst++ = ~*src++;
+				*dst++ = ~*src++;
+				*dst++ = ~*src++;
+				n -= 8;
+			}
+			while (n--)
+				*dst++ = ~*src++;
+
+			// Trailing bits
+			if (last)
+				*dst = comp(~*src, *dst, last);
 		}
-		case FBCMD_SET_CURRENTPAR : {
-			struct amifb_par par;
+	} else {
+		// Different alignment for source and dest
+
+		right = shift & (BITS_PER_LONG-1);
+		left = -shift & (BITS_PER_LONG-1);
 
-			i = verify_area(VERIFY_READ, (void *)arg, sizeof(struct amifb_par));
-			if (!i) {
-				copy_from_user(&par, (void *)arg, sizeof(struct amifb_par));
-				ami_set_par(&par);
+		if (dst_idx+n <= BITS_PER_LONG) {
+			// Single destination word
+			if (last)
+				first &= last;
+			if (shift > 0) {
+				// Single source word
+				*dst = comp(~*src >> right, *dst, first);
+			} else if (src_idx+n <= BITS_PER_LONG) {
+				// Single source word
+				*dst = comp(~*src << left, *dst, first);
+			} else {
+				// 2 source words
+				d0 = ~*src++;
+				d1 = ~*src;
+				*dst = comp(d0 << left | d1 >> right, *dst,
+					    first);
+			}
+		} else {
+			// Multiple destination words
+			d0 = ~*src++;
+			// Leading bits
+			if (shift > 0) {
+				// Single source word
+				*dst = comp(d0 >> right, *dst, first);
+				dst++;
+				n -= BITS_PER_LONG-dst_idx;
+			} else {
+				// 2 source words
+				d1 = ~*src++;
+				*dst = comp(d0 << left | d1 >> right, *dst,
+					    first);
+				d0 = d1;
+				dst++;
+				n -= BITS_PER_LONG-dst_idx;
+			}
+
+			// Main chunk
+			m = n % BITS_PER_LONG;
+			n /= BITS_PER_LONG;
+			while (n >= 4) {
+				d1 = ~*src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+				d1 = ~*src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+				d1 = ~*src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+				d1 = ~*src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+				n -= 4;
+			}
+			while (n--) {
+				d1 = ~*src++;
+				*dst++ = d0 << left | d1 >> right;
+				d0 = d1;
+			}
+
+			// Trailing bits
+			if (last) {
+				if (m <= right) {
+					// Single source word
+					*dst = comp(d0 << left, *dst, last);
+				} else {
+					// 2 source words
+					d1 = ~*src;
+					*dst = comp(d0 << left | d1 >> right,
+						    *dst, last);
+				}
 			}
-			return i;
 		}
-#endif	/* DEBUG */
 	}
-	return -EINVAL;
 }
 
-	/*
-	 * Hardware Cursor
-	 */
 
-static int amifb_get_fix_cursorinfo(struct fb_fix_cursorinfo *fix, int con)
+    /*
+     *  Unaligned 32-bit pattern fill using 32/64-bit memory accesses
+     */
+
+static void bitfill32(unsigned long *dst, int dst_idx, u32 pat, u32 n)
 {
-	return ami_get_fix_cursorinfo(fix, con);
+	unsigned long val = pat;
+	unsigned long first, last;
+
+	if (!n)
+		return;
+
+#if BITS_PER_LONG == 64
+	val |= val << 32;
+#endif
+
+	first = ~0UL >> dst_idx;
+	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+
+	if (dst_idx+n <= BITS_PER_LONG) {
+		// Single word
+		if (last)
+			first &= last;
+		*dst = comp(val, *dst, first);
+	} else {
+		// Multiple destination words
+		// Leading bits
+		if (first) {
+			*dst = comp(val, *dst, first);
+			dst++;
+			n -= BITS_PER_LONG-dst_idx;
+		}
+
+		// Main chunk
+		n /= BITS_PER_LONG;
+		while (n >= 8) {
+			*dst++ = val;
+			*dst++ = val;
+			*dst++ = val;
+			*dst++ = val;
+			*dst++ = val;
+			*dst++ = val;
+			*dst++ = val;
+			*dst++ = val;
+			n -= 8;
+		}
+		while (n--)
+			*dst++ = val;
+
+		// Trailing bits
+		if (last)
+			*dst = comp(val, *dst, last);
+	}
 }
 
-static int amifb_get_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data, int con)
+
+    /*
+     *  Unaligned 32-bit pattern xor using 32/64-bit memory accesses
+     */
+
+static void bitxor32(unsigned long *dst, int dst_idx, u32 pat, u32 n)
 {
-	return ami_get_var_cursorinfo(var, data, con);
+	unsigned long val = pat;
+	unsigned long first, last;
+
+	if (!n)
+		return;
+
+#if BITS_PER_LONG == 64
+	val |= val << 32;
+#endif
+
+	first = ~0UL >> dst_idx;
+	last = ~(~0UL >> ((dst_idx+n) % BITS_PER_LONG));
+
+	if (dst_idx+n <= BITS_PER_LONG) {
+		// Single word
+		if (last)
+			first &= last;
+		*dst = xor(val, *dst, first);
+	} else {
+		// Multiple destination words
+		// Leading bits
+		if (first) {
+			*dst = xor(val, *dst, first);
+			dst++;
+			n -= BITS_PER_LONG-dst_idx;
+		}
+
+		// Main chunk
+		n /= BITS_PER_LONG;
+		while (n >= 4) {
+			*dst++ ^= val;
+			*dst++ ^= val;
+			*dst++ ^= val;
+			*dst++ ^= val;
+			n -= 4;
+		}
+		while (n--)
+			*dst++ ^= val;
+
+		// Trailing bits
+		if (last)
+			*dst = xor(val, *dst, last);
+	}
+}
+
+static inline void fill_one_line(int bpp, unsigned long next_plane,
+				 unsigned long *dst, int dst_idx, u32 n,
+				 u32 color)
+{
+	while (1) {
+		dst += dst_idx >> SHIFT_PER_LONG;
+		dst_idx &= (BITS_PER_LONG-1);
+		bitfill32(dst, dst_idx, color & 1 ? ~0 : 0, n);
+		if (!--bpp)
+			break;
+		color >>= 1;
+		dst_idx += next_plane*8;
+	}
+}
+
+static inline void xor_one_line(int bpp, unsigned long next_plane,
+				unsigned long *dst, int dst_idx, u32 n,
+				u32 color)
+{
+	while (color) {
+		dst += dst_idx >> SHIFT_PER_LONG;
+		dst_idx &= (BITS_PER_LONG-1);
+		bitxor32(dst, dst_idx, color & 1 ? ~0 : 0, n);
+		if (!--bpp)
+			break;
+		color >>= 1;
+		dst_idx += next_plane*8;
+	}
+}
+
+
+static void amifb_fillrect(struct fb_info *info, struct fb_fillrect *rect)
+{
+	struct amifb_par *par = (struct amifb_par *)info->par;
+	int dst_idx, x2, y2;
+	unsigned long *dst;
+
+	if (!rect->width || !rect->height)
+		return;
+
+	/*
+	 * We could use hardware clipping but on many cards you get around
+	 * hardware clipping by writing to framebuffer directly.
+	 * */
+	x2 = rect->dx + rect->width;
+	y2 = rect->dy + rect->height;
+	x2 = x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
+	y2 = y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
+	rect->width = x2 - rect->dx;
+	rect->height = y2 - rect->dy;
+
+	dst = (unsigned long *)
+		((unsigned long)info->screen_base & ~(BYTES_PER_LONG-1));
+	dst_idx = ((unsigned long)info->screen_base & (BYTES_PER_LONG-1))*8;
+	dst_idx += rect->dy*par->next_line*8+rect->dx;
+	while (rect->height--) {
+		switch (rect->rop) {
+		    case ROP_COPY:
+			fill_one_line(info->var.bits_per_pixel,
+				      par->next_plane, dst, dst_idx,
+				      rect->width, rect->color);
+			break;
+
+		    case ROP_XOR:
+			xor_one_line(info->var.bits_per_pixel,
+				     par->next_plane, dst, dst_idx,
+				     rect->width, rect->color);
+			break;
+		}
+		dst_idx += par->next_line*8;
+	}
 }
 
-static int amifb_set_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data, int con)
+static inline void copy_one_line(int bpp, unsigned long next_plane,
+				 unsigned long *dst, int dst_idx,
+				 unsigned long *src, int src_idx, u32 n)
+{
+	while (1) {
+		dst += dst_idx >> SHIFT_PER_LONG;
+		dst_idx &= (BITS_PER_LONG-1);
+		src += src_idx >> SHIFT_PER_LONG;
+		src_idx &= (BITS_PER_LONG-1);
+		bitcpy(dst, dst_idx, src, src_idx, n);
+		if (!--bpp)
+			break;
+		dst_idx += next_plane*8;
+		src_idx += next_plane*8;
+	}
+}
+
+static inline void copy_one_line_rev(int bpp, unsigned long next_plane,
+				     unsigned long *dst, int dst_idx,
+				     unsigned long *src, int src_idx, u32 n)
+{
+	while (1) {
+		dst += dst_idx >> SHIFT_PER_LONG;
+		dst_idx &= (BITS_PER_LONG-1);
+		src += src_idx >> SHIFT_PER_LONG;
+		src_idx &= (BITS_PER_LONG-1);
+		bitcpy_rev(dst, dst_idx, src, src_idx, n);
+		if (!--bpp)
+			break;
+		dst_idx += next_plane*8;
+		src_idx += next_plane*8;
+	}
+}
+
+
+static void amifb_copyarea(struct fb_info *info, struct fb_copyarea *area)
 {
-	return ami_set_var_cursorinfo(var, data, con);
+	struct amifb_par *par = (struct amifb_par *)info->par;
+	int x2, y2, old_dx, old_dy;
+	unsigned long *dst, *src;
+	int dst_idx, src_idx, height;
+	int rev_copy = 0;
+
+	/* clip the destination */
+	old_dx = area->dx;
+	old_dy = area->dy;
+
+	/*
+	 * We could use hardware clipping but on many cards you get around
+	 * hardware clipping by writing to framebuffer directly.
+	 */
+	x2 = area->dx + area->width;
+	y2 = area->dy + area->height;
+	area->dx = area->dx > 0 ? area->dx : 0;
+	area->dy = area->dy > 0 ? area->dy : 0;
+	x2 = x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
+	y2 = y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
+	area->width = x2 - area->dx;
+	area->height = y2 - area->dy;
+
+	/* update sx1,sy1 */
+	area->sx += (area->dx - old_dx);
+	area->sy += (area->dy - old_dy);
+
+	height = area->height;
+
+	/* the source must be completely inside the virtual screen */
+	if (area->sx < 0 || area->sy < 0 ||
+	    (area->sx + area->width) > info->var.xres_virtual ||
+	    (area->sy + area->height) > info->var.yres_virtual)
+		return;
+
+	if (area->dy > area->sy ||
+	    (area->dy == area->sy && area->dx > area->sx)) {
+		area->dy += area->height;
+		area->sy += area->height;
+		rev_copy = 1;
+	}
+	dst = (unsigned long *)
+		((unsigned long)info->screen_base & ~(BYTES_PER_LONG-1));
+	src = dst;
+	dst_idx = ((unsigned long)info->screen_base & (BYTES_PER_LONG-1))*8;
+	src_idx = dst_idx;
+	dst_idx += area->dy*par->next_line*8+area->dx;
+	src_idx += area->sy*par->next_line*8+area->sx;
+	if (rev_copy) {
+		while (height--) {
+			dst_idx -= par->next_line*8;
+			src_idx -= par->next_line*8;
+			copy_one_line_rev(info->var.bits_per_pixel,
+					  par->next_plane, dst, dst_idx, src,
+					  src_idx, area->width);
+		}
+	} else {
+		while (height--) {
+			copy_one_line(info->var.bits_per_pixel,
+				      par->next_plane, dst, dst_idx, src,
+				      src_idx, area->width);
+			dst_idx += par->next_line*8;
+			src_idx += par->next_line*8;
+		}
+	}
+}
+
+
+static inline void expand_one_line(int bpp, unsigned long next_plane,
+				   unsigned long *dst, int dst_idx, u32 n,
+				   const u8 *data, u32 bgcolor, u32 fgcolor)
+{
+    const unsigned long *src;
+    int src_idx;
+
+    while (1) {
+	dst += dst_idx >> SHIFT_PER_LONG;
+	dst_idx &= (BITS_PER_LONG-1);
+	if ((bgcolor ^ fgcolor) & 1) {
+	    src = (unsigned long *)((unsigned long)data & ~(BYTES_PER_LONG-1));
+	    src_idx = ((unsigned long)data & (BYTES_PER_LONG-1))*8;
+	    if (fgcolor & 1)
+		bitcpy(dst, dst_idx, src, src_idx, n);
+	    else
+		bitcpy_not(dst, dst_idx, src, src_idx, n);
+	    /* set or clear */
+	} else
+	    bitfill32(dst, dst_idx, fgcolor & 1 ? ~0 : 0, n);
+	if (!--bpp)
+	    break;
+	bgcolor >>= 1;
+	fgcolor >>= 1;
+	dst_idx += next_plane*8;
+    }
 }
 
-static int amifb_get_cursorstate(struct fb_cursorstate *state, int con)
+
+static void amifb_imageblit(struct fb_info *info, struct fb_image *image)
 {
-	return ami_get_cursorstate(state, con);
+	struct amifb_par *par = (struct amifb_par *)info->par;
+	int x2, y2;
+	unsigned long *dst;
+	int dst_idx;
+	const char *src;
+	u32 dx, dy, width, height, pitch;
+
+	/*
+	 * We could use hardware clipping but on many cards you get around
+	 * hardware clipping by writing to framebuffer directly like we are
+	 * doing here.
+	 */
+	x2 = image->dx + image->width;
+	y2 = image->dy + image->height;
+	dx = image->dx;
+	dy = image->dy;
+	x2 = x2 < info->var.xres_virtual ? x2 : info->var.xres_virtual;
+	y2 = y2 < info->var.yres_virtual ? y2 : info->var.yres_virtual;
+	width  = x2 - dx;
+	height = y2 - dy;
+
+	if (image->depth == 1) {
+		dst = (unsigned long *)
+			((unsigned long)info->screen_base & ~(BYTES_PER_LONG-1));
+		dst_idx = ((unsigned long)info->screen_base & (BYTES_PER_LONG-1))*8;
+		dst_idx += dy*par->next_line*8+dx;
+		src = image->data;
+		pitch = (image->width+7)/8;
+		while (height--) {
+			expand_one_line(info->var.bits_per_pixel,
+					par->next_plane, dst, dst_idx, width,
+					src, image->bg_color,
+					image->fg_color);
+			dst_idx += par->next_line*8;
+			src += pitch;
+		}
+	} else {
+		c2p(info->screen_base, image->data, dx, dy, width, height,
+		    par->next_line, par->next_plane, image->width,
+		    info->var.bits_per_pixel);
+	}
 }
 
-static int amifb_set_cursorstate(struct fb_cursorstate *state, int con)
+
+	/*
+	 * Amiga Frame Buffer Specific ioctls
+	 */
+
+static int amifb_ioctl(struct inode *inode, struct file *file,
+		       unsigned int cmd, unsigned long arg,
+		       struct fb_info *info)
 {
-	return ami_set_cursorstate(state, con);
+	union {
+		struct fb_fix_cursorinfo fix;
+		struct fb_var_cursorinfo var;
+		struct fb_cursorstate state;
+	} crsr;
+	int i;
+
+	switch (cmd) {
+		case FBIOGET_FCURSORINFO:
+			i = ami_get_fix_cursorinfo(&crsr.fix);
+			if (i)
+				return i;
+			return copy_to_user((void *)arg, &crsr.fix,
+					    sizeof(crsr.fix)) ? -EFAULT : 0;
+
+		case FBIOGET_VCURSORINFO:
+			i = ami_get_var_cursorinfo(&crsr.var,
+				((struct fb_var_cursorinfo *)arg)->data);
+			if (i)
+				return i;
+			return copy_to_user((void *)arg, &crsr.var,
+					    sizeof(crsr.var)) ? -EFAULT : 0;
+
+		case FBIOPUT_VCURSORINFO:
+			if (copy_from_user(&crsr.var, (void *)arg,
+					   sizeof(crsr.var)))
+				return -EFAULT;
+			return ami_set_var_cursorinfo(&crsr.var,
+				((struct fb_var_cursorinfo *)arg)->data);
+
+		case FBIOGET_CURSORSTATE:
+			i = ami_get_cursorstate(&crsr.state);
+			if (i)
+				return i;
+			return copy_to_user((void *)arg, &crsr.state,
+					    sizeof(crsr.state)) ? -EFAULT : 0;
+
+		case FBIOPUT_CURSORSTATE:
+			if (copy_from_user(&crsr.state, (void *)arg,
+					   sizeof(crsr.state)))
+				return -EFAULT;
+			return ami_set_cursorstate(&crsr.state);
+	}
+	return -EINVAL;
 }
 
 
@@ -1570,7 +2259,6 @@
 	int tag, i, err = 0;
 	u_long chipptr;
 	u_int defmode;
-	struct fb_var_screeninfo var;
 
 	if (!MACH_IS_AMIGA || !AMIGAHW_PRESENT(AMI_VIDEO))
 		return -ENXIO;
@@ -1600,7 +2288,7 @@
 	switch (amiga_chipset) {
 #ifdef CONFIG_FB_AMIGA_OCS
 		case CS_OCS:
-			strcat(amifb_name, "OCS");
+			strcat(fb_info.fix.id, "OCS");
 default_chipset:
 			chipset = TAG_OCS;
 			maxdepth[TAG_SHRES] = 0;	/* OCS means no SHRES */
@@ -1609,13 +2297,13 @@
 			maxfmode = TAG_FMODE_1;
 			defmode = amiga_vblank == 50 ? DEFMODE_PAL
 						     : DEFMODE_NTSC;
-			videomemorysize = VIDEOMEMSIZE_OCS;
+			fb_info.fix.smem_len = VIDEOMEMSIZE_OCS;
 			break;
 #endif /* CONFIG_FB_AMIGA_OCS */
 
 #ifdef CONFIG_FB_AMIGA_ECS
 		case CS_ECS:
-			strcat(amifb_name, "ECS");
+			strcat(fb_info.fix.id, "ECS");
 			chipset = TAG_ECS;
 			maxdepth[TAG_SHRES] = 2;
 			maxdepth[TAG_HIRES] = 4;
@@ -1629,15 +2317,15 @@
 							 : DEFMODE_NTSC;
 			if (amiga_chip_avail()-CHIPRAM_SAFETY_LIMIT >
 			    VIDEOMEMSIZE_ECS_1M)
-				videomemorysize = VIDEOMEMSIZE_ECS_2M;
+				fb_info.fix.smem_len = VIDEOMEMSIZE_ECS_2M;
 			else
-				videomemorysize = VIDEOMEMSIZE_ECS_1M;
+				fb_info.fix.smem_len = VIDEOMEMSIZE_ECS_1M;
 			break;
 #endif /* CONFIG_FB_AMIGA_ECS */
 
 #ifdef CONFIG_FB_AMIGA_AGA
 		case CS_AGA:
-			strcat(amifb_name, "AGA");
+			strcat(fb_info.fix.id, "AGA");
 			chipset = TAG_AGA;
 			maxdepth[TAG_SHRES] = 8;
 			maxdepth[TAG_HIRES] = 8;
@@ -1646,16 +2334,16 @@
 			defmode = DEFMODE_AGA;
 			if (amiga_chip_avail()-CHIPRAM_SAFETY_LIMIT >
 			    VIDEOMEMSIZE_AGA_1M)
-				videomemorysize = VIDEOMEMSIZE_AGA_2M;
+				fb_info.fix.smem_len = VIDEOMEMSIZE_AGA_2M;
 			else
-				videomemorysize = VIDEOMEMSIZE_AGA_1M;
+				fb_info.fix.smem_len = VIDEOMEMSIZE_AGA_1M;
 			break;
 #endif /* CONFIG_FB_AMIGA_AGA */
 
 		default:
 #ifdef CONFIG_FB_AMIGA_OCS
 			printk("Unknown graphics chipset, defaulting to OCS\n");
-			strcat(amifb_name, "Unknown");
+			strcat(fb_info.fix.id, "Unknown");
 			goto default_chipset;
 #else /* CONFIG_FB_AMIGA_OCS */
 			err = -ENXIO;
@@ -1698,31 +2386,25 @@
 	    fb_info.monspecs.vfmax = 90;
 	}
 
-	strcpy(fb_info.modename, amifb_name);
-	fb_info.changevar = NULL;
 	fb_info.node = NODEV;
 	fb_info.fbops = &amifb_ops;
-	fb_info.disp = &disp;
-	fb_info.currcon = 1;
-	fb_info.switch_con = &amifbcon_switch;
-	fb_info.updatevar = &amifbcon_updatevar;
+	fb_info.par = &currentpar;
 	fb_info.flags = FBINFO_FLAG_DEFAULT;
-	memset(&var, 0, sizeof(var));
 
-	if (!fb_find_mode(&var, &fb_info, mode_option, ami_modedb,
+	if (!fb_find_mode(&fb_info.var, &fb_info, mode_option, ami_modedb,
 			  NUM_TOTAL_MODES, &ami_modedb[defmode], 4)) {
 		err = -EINVAL;
 		goto amifb_error;
 	}
 
 	round_down_bpp = 0;
-	chipptr = chipalloc(videomemorysize+
+	chipptr = chipalloc(fb_info.fix.smem_len+
 	                    SPRITEMEMSIZE+
 	                    DUMMYSPRITEMEMSIZE+
 	                    COPINITSIZE+
 	                    4*COPLISTSIZE);
 
-	assignchunk(videomemory, u_long, chipptr, videomemorysize);
+	assignchunk(videomemory, u_long, chipptr, fb_info.fix.smem_len);
 	assignchunk(spritememory, u_long, chipptr, SPRITEMEMSIZE);
 	assignchunk(dummysprite, u_short *, chipptr, DUMMYSPRITEMEMSIZE);
 	assignchunk(copdisplay.init, copins *, chipptr, COPINITSIZE);
@@ -1734,11 +2416,12 @@
 	/*
 	 * access the videomem with writethrough cache
 	 */
-	videomemory_phys = (u_long)ZTWO_PADDR(videomemory);
-	videomemory = (u_long)ioremap_writethrough(videomemory_phys, videomemorysize);
+	fb_info.fix.smem_start = (u_long)ZTWO_PADDR(videomemory);
+	videomemory = (u_long)ioremap_writethrough(fb_info.fix.smem_start,
+						   fb_info.fix.smem_len);
 	if (!videomemory) {
 		printk("amifb: WARNING! unable to map videomem cached writethrough\n");
-		videomemory = ZTWO_VADDR(videomemory_phys);
+		videomemory = ZTWO_VADDR(fb_info.fix.smem_start);
 	}
 
 	fb_info.screen_base = (char *)videomemory;
@@ -1763,19 +2446,18 @@
 		goto amifb_error;
 	}
 
-	amifb_set_var(&var, -1, &fb_info);
+	fb_alloc_cmap(&fb_info.cmap, 1<<fb_info.var.bits_per_pixel, 0);
 
 	if (register_framebuffer(&fb_info) < 0) {
 		err = -EINVAL;
 		goto amifb_error;
 	}
 
-	printk("fb%d: %s frame buffer device, using %ldK of video memory\n",
-	       minor(fb_info.node), fb_info.modename,
-	       videomemorysize>>10);
+	printk("fb%d: %s frame buffer device, using %dK of video memory\n",
+	       minor(fb_info.node), fb_info.fix.id, fb_info.fix.smem_len>>10);
 
 	return 0;
-	
+
 amifb_error:
 	amifb_deinit();
 	return err;
@@ -1783,33 +2465,12 @@
 
 static void amifb_deinit(void)
 {
-	chipfree();    
+	fb_dealloc_cmap(&fb_info.cmap);
+	chipfree();
 	release_mem_region(CUSTOM_PHYSADDR+0xe0, 0x120);
 	custom.dmacon = DMAF_ALL | DMAF_MASTER;
 }
 
-static int amifbcon_switch(int con, struct fb_info *info)
-{
-	/* Do we have to save the colormap? */
-	if (fb_display[info->currcon].cmap.len)
-		fb_get_cmap(&fb_display[info->currcon].cmap, 1, ami_getcolreg, info);
-
-	info->currcon = con;
-	ami_set_var(&fb_display[con].var);
-	/* Install new colormap */
-	do_install_cmap(con, info);
-	return 0;
-}
-
-	/*
-	 * Update the `var' structure (called by fbcon.c)
-	 */
-
-static int amifbcon_updatevar(int con, struct fb_info *info)
-{
-	ami_pan_var(&fb_display[con].var);
-	return 0;
-}
 
 	/*
 	 * Blank the display.
@@ -1821,6 +2482,10 @@
 	return 0;
 }
 
+	/*
+	 * Flash the cursor (called by VBlank interrupt)
+	 */
+
 static int flash_cursor(void)
 {
 	static int cursorcount = 1;
@@ -1875,50 +2540,6 @@
 /* --------------------------- Hardware routines --------------------------- */
 
 	/*
-	 * This function should fill in the `fix' structure based on the
-	 * values in the `par' structure.
-	 */
-
-static int ami_encode_fix(struct fb_fix_screeninfo *fix,
-                          struct amifb_par *par)
-{
-	memset(fix, 0, sizeof(struct fb_fix_screeninfo));
-	strcpy(fix->id, amifb_name);
-	fix->smem_start = videomemory_phys;
-	fix->smem_len = videomemorysize;
-
-#ifdef FBCON_HAS_MFB
-	if (par->bpp == 1) {
-		fix->type = FB_TYPE_PACKED_PIXELS;
-		fix->type_aux = 0;
-	} else
-#endif
-	if (amifb_ilbm) {
-		fix->type = FB_TYPE_INTERLEAVED_PLANES;
-		fix->type_aux = par->next_line;
-	} else {
-		fix->type = FB_TYPE_PLANES;
-		fix->type_aux = 0;
-	}
-	fix->line_length = div8(upx(16<<maxfmode, par->vxres));
-	fix->visual = FB_VISUAL_PSEUDOCOLOR;
-
-	if (par->vmode & FB_VMODE_YWRAP) {
-		fix->ywrapstep = 1;
-		fix->xpanstep = fix->ypanstep = 0;
-	} else {
-		fix->ywrapstep = 0;
-		if (par->vmode &= FB_VMODE_SMOOTH_XPAN)
-			fix->xpanstep = 1;
-		else
-			fix->xpanstep = 16<<maxfmode;
-		fix->ypanstep = 1;
-	}
-	fix->accel = FB_ACCEL_AMIGABLITT;
-	return 0;
-}
-
-	/*
 	 * Get the video params out of `var'. If a value doesn't fit, round
 	 * it up, if it's too big, return -EINVAL.
 	 */
@@ -2074,7 +2695,7 @@
 			if (!IS_OCS) {
 				par->beamcon0 = BMC0_PAL;
 				par->bplcon3 |= BPC3_BRDRBLNK;
-			} else if (AMIGAHW_PRESENT(AGNUS_HR_PAL) || 
+			} else if (AMIGAHW_PRESENT(AGNUS_HR_PAL) ||
 			           AMIGAHW_PRESENT(AGNUS_HR_NTSC)) {
 				par->beamcon0 = BMC0_PAL;
 				par->hsstop = 1;
@@ -2104,7 +2725,7 @@
 			if (!IS_OCS) {
 				par->beamcon0 = 0;
 				par->bplcon3 |= BPC3_BRDRBLNK;
-			} else if (AMIGAHW_PRESENT(AGNUS_HR_PAL) || 
+			} else if (AMIGAHW_PRESENT(AGNUS_HR_PAL) ||
 			           AMIGAHW_PRESENT(AGNUS_HR_NTSC)) {
 				par->beamcon0 = 0;
 				par->hsstop = 1;
@@ -2235,14 +2856,14 @@
 	if (amifb_ilbm) {
 		par->next_plane = div8(upx(16<<maxfmode, par->vxres));
 		par->next_line = par->bpp*par->next_plane;
-		if (par->next_line * par->vyres > videomemorysize) {
+		if (par->next_line * par->vyres > fb_info.fix.smem_len) {
 			DPRINTK("too few video mem\n");
 			return -EINVAL;
 		}
 	} else {
 		par->next_line = div8(upx(16<<maxfmode, par->vxres));
 		par->next_plane = par->vyres*par->next_line;
-		if (par->next_plane * par->bpp > videomemorysize) {
+		if (par->next_plane * par->bpp > fb_info.fix.smem_len) {
 			DPRINTK("too few video mem\n");
 			return -EINVAL;
 		}
@@ -2402,38 +3023,6 @@
 	return 0;
 }
 
-	/*
-	 * Get current hardware setting
-	 */
-
-static void ami_get_par(struct amifb_par *par)
-{
-	*par = currentpar;
-}
-
-	/*
-	 * Set new videomode
-	 */
-
-static void ami_set_var(struct fb_var_screeninfo *var)
-{
-	do_vmode_pan = 0;
-	do_vmode_full = 0;
-	ami_decode_var(var, &currentpar);
-	ami_build_copper();
-	do_vmode_full = 1;
-}
-
-#ifdef DEBUG
-static void ami_set_par(struct amifb_par *par)
-{
-	do_vmode_pan = 0;
-	do_vmode_full = 0;
-	currentpar = *par;
-	ami_build_copper();
-	do_vmode_full = 1;
-}
-#endif
 
 	/*
 	 * Pan or Wrap the Display
@@ -2506,16 +3095,16 @@
 		par->bpl1mod = par->bpl2mod;
 
 	if (par->yoffset) {
-		par->bplpt0 = videomemory_phys + par->next_line*par->yoffset + move;
+		par->bplpt0 = fb_info.fix.smem_start + par->next_line*par->yoffset + move;
 		if (par->vmode & FB_VMODE_YWRAP) {
 			if (par->yoffset > par->vyres-par->yres) {
-				par->bplpt0wrap = videomemory_phys + move;
+				par->bplpt0wrap = fb_info.fix.smem_start + move;
 				if (par->bplcon0 & BPC0_LACE && mod2(par->diwstrt_v+par->vyres-par->yoffset))
 					par->bplpt0wrap += par->next_line;
 			}
 		}
 	} else
-		par->bplpt0 = videomemory_phys + move;
+		par->bplpt0 = fb_info.fix.smem_start + move;
 
 	if (par->bplcon0 & BPC0_LACE && mod2(par->diwstrt_v))
 		par->bplpt0 += par->next_line;
@@ -2523,45 +3112,6 @@
 	return 0;
 }
 
-	/*
-	 * Read a single color register and split it into
-	 * colors/transparent. Return != 0 for invalid regno.
-	 */
-
-static int ami_getcolreg(u_int regno, u_int *red, u_int *green, u_int *blue,
-                         u_int *transp, struct fb_info *info)
-{
-	int len, tr, tg, tb;
-
-	if (IS_AGA) {
-		if (regno > 255)
-			return 1;
-		len = 8;
-	} else if (currentpar.bplcon0 & BPC0_SHRES) {
-		if (regno > 3)
-			return 1;
-		len = 2;
-	} else {
-		if (regno > 31)
-			return 1;
-		len = 4;
-	}
-	tr = palette[regno].red>>(8-len);
-	tg = palette[regno].green>>(8-len);
-	tb = palette[regno].blue>>(8-len);
-	while (len < 16) {
-		tr |= tr<<len;
-		tg |= tg<<len;
-		tb |= tb<<len;
-		len <<= 1;
-	}
-	*red = tr;
-	*green = tg;
-	*blue = tb;
-	*transp = 0;
-	return 0;
-}
-
 
 	/*
 	 * Set a single color register. The values supplied are already
@@ -2585,9 +3135,11 @@
 	red >>= 8;
 	green >>= 8;
 	blue >>= 8;
-	palette[regno].red = red;
-	palette[regno].green = green;
-	palette[regno].blue = blue;
+	if (!regno) {
+		red0 = red;
+		green0 = green;
+		blue0 = blue;
+	}
 
 	/*
 	 * Update the corresponding Hardware Color Register, unless it's Color
@@ -2650,6 +3202,7 @@
 static void ami_init_display(void)
 {
 	struct amifb_par *par = &currentpar;
+	int i;
 
 	custom.bplcon0 = par->bplcon0 & ~BPC0_LACE;
 	custom.bplcon2 = (IS_OCS ? 0 : BPC2_KILLEHB) | BPC2_PF2P2 | BPC2_PF1P2;
@@ -2685,18 +3238,16 @@
 	is_lace = par->bplcon0 & BPC0_LACE ? 1 : 0;
 #if 1
 	if (is_lace) {
-		if (custom.vposr & 0x8000)
-			custom.cop2lc = (u_short *)ZTWO_PADDR(copdisplay.list[currentcop][1]);
-		else
-			custom.cop2lc = (u_short *)ZTWO_PADDR(copdisplay.list[currentcop][0]);
+		i = custom.vposr >> 15;
 	} else {
 		custom.vposw = custom.vposr | 0x8000;
-		custom.cop2lc = (u_short *)ZTWO_PADDR(copdisplay.list[currentcop][1]);
+		i = 1;
 	}
 #else
+	i = 1;
 	custom.vposw = custom.vposr | 0x8000;
-	custom.cop2lc = (u_short *)ZTWO_PADDR(copdisplay.list[currentcop][1]);
 #endif
+	custom.cop2lc = (u_short *)ZTWO_PADDR(copdisplay.list[currentcop][i]);
 }
 
 	/*
@@ -2744,9 +3295,9 @@
 		}
 	} else {
 		custom.dmacon = DMAF_SETCLR | DMAF_RASTER | DMAF_SPRITE;
-		red = palette[0].red;
-		green = palette[0].green;
-		blue = palette[0].blue;
+		red = red0;
+		green = green0;
+		blue = blue0;
 		if (!IS_OCS) {
 			custom.hsstrt = hsstrt2hw(par->hsstrt);
 			custom.hsstop = hsstop2hw(par->hsstop);
@@ -2782,11 +3333,7 @@
 	is_blanked = do_blank > 0 ? do_blank : 0;
 }
 
-	/*
-	 * Flash the cursor (called by VBlank interrupt)
-	 */
-
-static int ami_get_fix_cursorinfo(struct fb_fix_cursorinfo *fix, int con)
+static int ami_get_fix_cursorinfo(struct fb_fix_cursorinfo *fix)
 {
 	struct amifb_par *par = &currentpar;
 
@@ -2797,7 +3344,7 @@
 	return 0;
 }
 
-static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data, int con)
+static int ami_get_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data)
 {
 	struct amifb_par *par = &currentpar;
 	register u_short *lspr, *sspr;
@@ -2846,7 +3393,7 @@
 				"swap %1 ; lslw #1,%1 ; roxlb #1,%0"
 				: "=d" (color), "=d" (datawords) : "1" (datawords));
 #else
-			color = (((datawords >> 30) & 2) 
+			color = (((datawords >> 30) & 2)
 				 | ((datawords >> 15) & 1));
 			datawords <<= 1;
 #endif
@@ -2872,7 +3419,7 @@
 	return 0;
 }
 
-static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data, int con)
+static int ami_set_var_cursorinfo(struct fb_var_cursorinfo *var, u_char *data)
 {
 	struct amifb_par *par = &currentpar;
 	register u_short *lspr, *sspr;
@@ -2991,7 +3538,7 @@
 	return 0;
 }
 
-static int ami_get_cursorstate(struct fb_cursorstate *state, int con)
+static int ami_get_cursorstate(struct fb_cursorstate *state)
 {
 	struct amifb_par *par = &currentpar;
 
@@ -3001,7 +3548,7 @@
 	return 0;
 }
 
-static int ami_set_cursorstate(struct fb_cursorstate *state, int con)
+static int ami_set_cursorstate(struct fb_cursorstate *state)
 {
 	struct amifb_par *par = &currentpar;
 
@@ -3061,6 +3608,7 @@
 		cops[cop_spr0ptrl].w[1] = loww(ps);
 	}
 }
+
 
 	/*
 	 * Initialise the Copper Initialisation List
--- linux-2.5.x/drivers/video/c2p.c	Thu Jan  1 01:00:00 1970
+++ linux-m68k-2.5.x/drivers/video/c2p.c	Fri Jan 24 18:23:15 2003
@@ -0,0 +1,229 @@
+/*
+ *  Fast C2P (Chunky-to-Planar) Conversion
+ *
+ *  Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  NOTES:
+ *    - This code was inspired by Scout's C2P tutorial
+ *    - It assumes to run on a big endian system
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive
+ *  for more details.
+ */
+
+#include <linux/string.h>
+#include "c2p.h"
+
+
+    /*
+     *  Basic transpose step
+     */
+
+#define _transp(d, i1, i2, shift, mask)			\
+    do {						\
+	u32 t = (d[i1] ^ (d[i2] >> shift)) & mask;	\
+	d[i1] ^= t;					\
+	d[i2] ^= t << shift;				\
+    } while (0)
+
+static inline u32 get_mask(int n)
+{
+    switch (n) {
+	case 1:
+	    return 0x55555555;
+	    break;
+
+	case 2:
+	    return 0x33333333;
+	    break;
+
+	case 4:
+	    return 0x0f0f0f0f;
+	    break;
+
+	case 8:
+	    return 0x00ff00ff;
+	    break;
+
+	case 16:
+	    return 0x0000ffff;
+	    break;
+    }
+    return 0;
+}
+
+#define transp_nx1(d, n)				\
+    do {						\
+	u32 mask = get_mask(n);				\
+	/* First block */				\
+	_transp(d, 0, 1, n, mask);			\
+	/* Second block */				\
+	_transp(d, 2, 3, n, mask);			\
+	/* Third block */				\
+	_transp(d, 4, 5, n, mask);			\
+	/* Fourth block */				\
+	_transp(d, 6, 7, n, mask);			\
+    } while (0)
+
+#define transp_nx2(d, n)				\
+    do {						\
+	u32 mask = get_mask(n);				\
+	/* First block */				\
+	_transp(d, 0, 2, n, mask);			\
+	_transp(d, 1, 3, n, mask);			\
+	/* Second block */				\
+	_transp(d, 4, 6, n, mask);			\
+	_transp(d, 5, 7, n, mask);			\
+    } while (0)
+
+#define transp_nx4(d, n)				\
+    do {						\
+	u32 mask = get_mask(n);				\
+	_transp(d, 0, 4, n, mask);			\
+	_transp(d, 1, 5, n, mask);			\
+	_transp(d, 2, 6, n, mask);			\
+	_transp(d, 3, 7, n, mask);			\
+    } while (0)
+
+#define transp(d, n, m)	transp_nx ## m(d, n)
+
+
+    /*
+     *  Perform a full C2P step on 32 8-bit pixels, stored in 8 32-bit words
+     *  containing
+     *    - 32 8-bit chunky pixels on input
+     *    - permuted planar data on output
+     */
+
+static void c2p_8bpp(u32 d[8])
+{
+    transp(d, 16, 4);
+    transp(d, 8, 2);
+    transp(d, 4, 1);
+    transp(d, 2, 4);
+    transp(d, 1, 2);
+}
+
+
+    /*
+     *  Array containing the permution indices of the planar data after c2p
+     */
+
+static const int perm_c2p_8bpp[8] = { 7, 5, 3, 1, 6, 4, 2, 0 };
+
+
+    /*
+     *  Compose two values, using a bitmask as decision value
+     *  This is equivalent to (a & mask) | (b & ~mask)
+     */
+
+static inline unsigned long comp(unsigned long a, unsigned long b,
+				 unsigned long mask)
+{
+	return ((a ^ b) & mask) ^ b;
+}
+
+
+    /*
+     *  Store a full block of planar data after c2p conversion
+     */
+
+static inline void store_planar(char *dst, u32 dst_inc, u32 bpp, u32 d[8])
+{
+    int i;
+
+    for (i = 0; i < bpp; i++, dst += dst_inc)
+	*(u32 *)dst = d[perm_c2p_8bpp[i]];
+}
+
+
+    /*
+     *  Store a partial block of planar data after c2p conversion
+     */
+
+static inline void store_planar_masked(char *dst, u32 dst_inc, u32 bpp,
+				       u32 d[8], u32 mask)
+{
+    int i;
+
+    for (i = 0; i < bpp; i++, dst += dst_inc)
+	*(u32 *)dst = comp(d[perm_c2p_8bpp[i]], *(u32 *)dst, mask);
+}
+
+
+    /*
+     *  c2p - Copy 8-bit chunky image data to a planar frame buffer
+     *  @dst: Starting address of the planar frame buffer
+     *  @dx: Horizontal destination offset (in pixels)
+     *  @dy: Vertical destination offset (in pixels)
+     *  @width: Image width (in pixels)
+     *  @height: Image height (in pixels)
+     *  @dst_nextline: Frame buffer offset to the next line (in bytes)
+     *  @dst_nextplane: Frame buffer offset to the next plane (in bytes)
+     *  @src_nextline: Image offset to the next line (in bytes)
+     *  @bpp: Bits per pixel of the planar frame buffer (1-8)
+     */
+
+void c2p(u8 *dst, const u8 *src, u32 dx, u32 dy, u32 width, u32 height,
+	 u32 dst_nextline, u32 dst_nextplane, u32 src_nextline, u32 bpp)
+{
+    int dst_idx;
+    u32 d[8], first, last, w;
+    const u8 *c;
+    u8 *p;
+
+    dst += dy*dst_nextline+(dx & ~31);
+    dst_idx = dx % 32;
+    first = ~0UL >> dst_idx;
+    last = ~(~0UL >> ((dst_idx+width) % 32));
+    while (height--) {
+	c = src;
+	p = dst;
+	w = width;
+	if (dst_idx+width <= 32) {
+	    /* Single destination word */
+	    first &= last;
+	    memset(d, 0, sizeof(d));
+	    memcpy((u8 *)d+dst_idx, c, width);
+	    c += width;
+	    c2p_8bpp(d);
+	    store_planar_masked(p, dst_nextplane, bpp, d, first);
+	    p += 4;
+	} else {
+	    /* Multiple destination words */
+	    w = width;
+	    /* Leading bits */
+	    if (dst_idx) {
+		w = 32 - dst_idx;
+		memset(d, 0, dst_idx);
+		memcpy((u8 *)d+dst_idx, c, w);
+		c += w;
+		c2p_8bpp(d);
+		store_planar_masked(p, dst_nextplane, bpp, d, first);
+		p += 4;
+		w = width-w;
+	    }
+	    /* Main chunk */
+	    while (w >= 32) {
+		memcpy(d, c, 32);
+		c += 32;
+		c2p_8bpp(d);
+		store_planar(p, dst_nextplane, bpp, d);
+		p += 4;
+		w -= 32;
+	    }
+	    /* Trailing bits */
+	    w %= 32;
+	    if (w > 0) {
+		memcpy(d, c, w);
+		memset((u8 *)d+w, 0, 32-w);
+		c2p_8bpp(d);
+		store_planar_masked(p, dst_nextplane, bpp, d, last);
+	    }
+	}
+	src += src_nextline;
+	dst += dst_nextline;
+    }
+}
+
--- linux-2.5.x/drivers/video/c2p.h	Thu Jan  1 01:00:00 1970
+++ linux-m68k-2.5.x/drivers/video/c2p.h	Fri Jan 24 18:23:04 2003
@@ -0,0 +1,16 @@
+/*
+ *  Fast C2P (Chunky-to-Planar) Conversion
+ *
+ *  Copyright (C) 2003 Geert Uytterhoeven
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License. See the file COPYING in the main directory of this archive
+ *  for more details.
+ */
+
+#include <linux/types.h>
+
+extern void c2p(u8 *dst, const u8 *src, u32 dx, u32 dy, u32 width, u32 height,
+		u32 dst_nextline, u32 dst_nextplane, u32 src_nextline,
+		u32 bpp);
+

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
