From: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH]: i810fb updates
Date: 18 Jan 2003 15:59:22 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042856891.937.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-/h5HSLgHBhSgwyv3V2GG"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18Zo0s-00028G-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 18 Jan 2003 00:07:34 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


--=-/h5HSLgHBhSgwyv3V2GG
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi James,

Attached is a diff against linux-2.5.59 with the following i810fb
updates:

1.  Uses fb_get_mode() and fb_validate_mode() to calculate/check display
timings.  

2. Fixed bug in i810fb_imageblit() and i810fb_cursor() when bitmap is not divisible
by 8.

3.  Removed unnecessary calls to wait_for_engine_idle() since fbcon
already guarantees that fb_sync() will be called whenever the
framebuffer memory is to be accessed.


The updates will remove around 250 lines of code :-)

Tony



--=-/h5HSLgHBhSgwyv3V2GG
Content-Disposition: attachment; filename=i810fb1.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=i810fb1.diff; charset=ANSI_X3.4-1968

diff -Naur linux-2.5.59/drivers/video/i810/i810.h linux/drivers/video/i810/=
i810.h
--- linux-2.5.59/drivers/video/i810/i810.h	2003-01-17 11:35:47.000000000 +0=
000
+++ linux/drivers/video/i810/i810.h	2003-01-17 11:35:20.000000000 +0000
@@ -170,13 +170,6 @@
 #define REF_FREQ                    24000000
 #define TARGET_N_MAX                30
=20
-#define FLYBACK                     550
-#define V_FRONTPORCH                1
-#define H_OFFSET                    40
-#define H_SCALEFACTOR               20
-#define H_BLANKSCALE                128
-#define H_GRADIENT                   600
-
 #define MAX_PIXELCLOCK              230000000
 #define MIN_PIXELCLOCK               15000000
 #define VFMAX                       60
diff -Naur linux-2.5.59/drivers/video/i810/i810_accel.c linux/drivers/video=
/i810/i810_accel.c
--- linux-2.5.59/drivers/video/i810/i810_accel.c	2003-01-17 11:35:44.000000=
000 +0000
+++ linux/drivers/video/i810/i810_accel.c	2003-01-17 11:35:18.000000000 +00=
00
@@ -75,8 +75,6 @@
 	return 1;
 }
=20
-
-
 /**=20
  * wait_for_engine_idle - waits for all hardware engines to finish
  * @par: pointer to i810fb_par structure
@@ -154,12 +152,14 @@
 				    int blit_bpp, struct i810fb_par *par)
 {
 	if (begin_iring(par, 24 + IRING_PAD)) return;
+
 	PUT_RING(BLIT | SOURCE_COPY_BLIT | 4);
 	PUT_RING(xdir | rop << 16 | dpitch | DYN_COLOR_EN | blit_bpp);
 	PUT_RING(dheight << 16 | dwidth);
 	PUT_RING(dest);
 	PUT_RING(dpitch);
 	PUT_RING(src);
+
 	end_iring(par);
 }=09
=20
@@ -184,12 +184,14 @@
 			      struct i810fb_par *par)
 {
 	if (begin_iring(par, 24 + IRING_PAD)) return;
+
 	PUT_RING(BLIT | COLOR_BLT | 3);
 	PUT_RING(rop << 16 | pitch | SOLIDPATTERN | DYN_COLOR_EN | blit_bpp);
 	PUT_RING(height << 16 | width);
 	PUT_RING(dest);
 	PUT_RING(what);
 	PUT_RING(NOP);
+
 	end_iring(par);
 }
 =20
@@ -220,17 +222,16 @@
 					  int dest, const u32 *src, int bg,
 					  int fg, struct i810fb_par *par)
 {
-	u32 i, *s =3D (u32 *) src;
-
 	if (begin_iring(par, 24 + (dsize << 2) + IRING_PAD)) return;
+
 	PUT_RING(BLIT | MONO_SOURCE_COPY_IMMEDIATE | (4 + dsize));
 	PUT_RING(DYN_COLOR_EN | blit_bpp | rop << 16 | dpitch);
 	PUT_RING(dheight << 16 | dwidth);
 	PUT_RING(dest);
 	PUT_RING(bg);
 	PUT_RING(fg);
-	for (i =3D dsize; i--; )=20
-		PUT_RING(*s++);
+	while (dsize--)=20
+		PUT_RING(*src++);
=20
 	end_iring(par);
 }
@@ -319,17 +320,10 @@
 	struct i810fb_par *par =3D (struct i810fb_par *) p->par;
 	u32 dx, dy, width, height, dest, rop =3D 0, color =3D 0;
=20
-	if (!p->var.accel_flags || par->dev_flags & LOCKUP) {
-		cfb_fillrect(p, rect);
-		return;
-	}
+	if (!p->var.accel_flags || par->dev_flags & LOCKUP ||
+	    par->depth =3D=3D 4)=20
+		return cfb_fillrect(p, rect);
=20
-	if (par->depth =3D=3D 4) {
-		wait_for_engine_idle(par);
-		cfb_fillrect(p, rect);
-		return;
-	}
-		=09
 	if (par->depth =3D=3D 1)=20
 		color =3D rect->color;
 	else=20
@@ -352,16 +346,9 @@
 	struct i810fb_par *par =3D (struct i810fb_par *) p->par;
 	u32 sx, sy, dx, dy, pitch, width, height, src, dest, xdir;
=20
-	if (!p->var.accel_flags || par->dev_flags & LOCKUP) {
-		cfb_copyarea(p, region);
-		return;
-	}
-
-	if (par->depth =3D=3D 4) {
-		wait_for_engine_idle(par);
-		cfb_copyarea(p, region);
-		return;
-	}
+	if (!p->var.accel_flags || par->dev_flags & LOCKUP ||
+	    par->depth =3D=3D 4)
+		return cfb_copyarea(p, region);
=20
 	dx =3D region->dx * par->depth;
 	sx =3D region->sx * par->depth;
@@ -399,16 +386,9 @@
 	u32 fg =3D 0, bg =3D 0, s_pitch, d_pitch, size, offset, dst, i, j;
 	u8 *s_addr, *d_addr;
 =09
-	if (!p->var.accel_flags || par->dev_flags & LOCKUP) {
-		cfb_imageblit(p, image);
-		return;
-	}
-
-	if (par->depth =3D=3D 4 || image->depth !=3D 1) {
-		wait_for_engine_idle(par);
-		cfb_imageblit(p, image);
-		return;
-	}
+	if (!p->var.accel_flags || par->dev_flags & LOCKUP ||
+	    par->depth =3D=3D 4 || image->depth !=3D 1)=20
+		return cfb_imageblit(p, image);
=20
 	switch (p->var.bits_per_pixel) {
 	case 8:
@@ -425,14 +405,14 @@
 	dst =3D p->fix.smem_start + (image->dy * p->fix.line_length) +=20
 		(image->dx * par->depth);
=20
-	s_pitch =3D image->width/8;
+	s_pitch =3D (image->width+7)/8;
 	d_pitch =3D (s_pitch + 1) & ~1;
 =09
-	size =3D d_pitch * image->height;
+	size =3D (d_pitch * image->height) + 7;
+	size &=3D ~7;
=20
 	if (image->width & 15) {
-		offset =3D get_buffer_offset(size, par);
-	=09
+		offset =3D get_buffer_offset(size, par);	=09
 		d_addr =3D par->pixmap.virtual + offset;
 		s_addr =3D image->data;
 	=09
@@ -465,7 +445,7 @@
 {
 	struct i810fb_par *par =3D (struct i810fb_par *) p->par;
 =09
-	if (!p->var.accel_flags)
+	if (!p->var.accel_flags || par->dev_flags & LOCKUP)
 		return 0;
=20
 	return wait_for_engine_idle(par);
diff -Naur linux-2.5.59/drivers/video/i810/i810_main.c linux/drivers/video/=
i810/i810_main.c
--- linux-2.5.59/drivers/video/i810/i810_main.c	2003-01-17 11:35:44.0000000=
00 +0000
+++ linux/drivers/video/i810/i810_main.c	2003-01-17 11:35:18.000000000 +000=
0
@@ -623,7 +623,7 @@
 	}
=20
 	n_reg =3D m_reg =3D n_target =3D 3;=09
-	while ((diff_min || mod_min) && (n_target < n_target_max)) {
+	while (diff_min && mod_min && (n_target < n_target_max)) {
 		f_out =3D (p_divisor * n_reg * 1000000)/(4 * 24 * m_reg);
 		mod =3D (p_divisor * n_reg * 1000000) % (4 * 24 * m_reg);
 		m_target =3D m_reg;
@@ -654,261 +654,6 @@
 	if (p) *p =3D (p_target << 4);
 }
=20
-/**
- * i810_get_vblank - get vertical blank time
- * @hfreq: horizontal freq
- *
- * DESCRIPTION:
- * vblank =3D right_margin + vsync_len + left_margin=20
- *    given: right_margin =3D 1 (V_FRONTPORCH)
- *           vsync_len    =3D 3
- *           flyback      =3D 550
- *
- *                          flyback * hfreq
- *           left_margin  =3D --------------- - vsync_len
- *                           1000000
- *           and flyback is set to 550
- */
-static u32 i810_get_vblank(u32 hfreq)
-{
-	u32 vblank;
-
-	vblank =3D (hfreq * FLYBACK)/1000;=20
-	vblank =3D (vblank + 500)/1000;
-	return (vblank + V_FRONTPORCH);
-}
-
-/**=20
- * i810_get_hblank - get horizontal blank time
- * @hfreq: horizontal freq
- * @xres: horizontal resolution in pixels
- *
- * DESCRIPTION:
- * duty cycle is the percent of htotal assigned to inactive display
- * duty cycle =3D C - (M/Hfreq)
- * where: C =3D ((offset - scale factor) * blank_scale)
- *            -------------------------------------- + scale factor
- *                        256=20
- *        M =3D blank_scale * gradient
- *
- *           xres * duty_cycle
- * hblank =3D ------------------
- *           100 - duty_cycle
- */
-static u32 i810_get_hblank(u32 hfreq, u32 xres)
-{
-	u32 c_val, m_val, duty_cycle, hblank;
-
-	c_val =3D (((H_OFFSET - H_SCALEFACTOR) * H_BLANKSCALE)/256 +=20
-		 H_SCALEFACTOR) * 1000;
-	m_val =3D (H_BLANKSCALE * H_GRADIENT)/256;
-	m_val =3D (m_val * 1000000)/hfreq;
-	duty_cycle =3D c_val - m_val;
-	hblank =3D (xres * duty_cycle)/(100000 - duty_cycle);
-	hblank =3D (hblank + 4) & ~7;
-	return (hblank);
-}
-
-/**
- * i810_estimate_hfreq - estimate hsync
- * @vfreq: vertical refresh rate
- * @yres: vertical resolution
- *
- * DESCRIPTION:
- * Based on:
- *
- *          (yres + front_port) * vfreq * 1000000
- * hfreq =3D -------------------------------------
- *          (1000000 - (vfreq * FLYBACK)
- *=20
- */
-
-static u32 i810_estimate_hfreq(u32 vfreq, u32 yres)
-{
-	u64 hfreq;
-	u32 divisor;
-=09
-	divisor =3D 1000000 - (vfreq * FLYBACK);
-=09
-	hfreq =3D (u64) (yres + V_FRONTPORCH) * =20
-		(u64) (vfreq)  * 1000000;
-	do_div(hfreq, divisor);
-=09
-	return ((u32) hfreq);
-}
-
-/**
- * i810_calculate_timings - calculate video timings=20
- * @info: pointer to fb_info structure
- * @var: pointer to current var
- *=20
- * DESCRIPTION:
- * htotal: calculated using GTF
- * vtotal: calculated using GTF
- * hsync pulse:  8% of htotal
- * vsync pulse:  3=20
- * left margin : (htotal - xres)/2 - hsync
- * right margin: sync + left margin
- * upper margin: 1
- * lower margin: vtotal - (yres + vsync + upper margin)
- *
- * Calculates necessary timing information based on=20
- * monitor specifications.  This will use the=20
- * VESA generalized timing formula. New values are
- * written to @var.
- */                     =20
-static int i810_calculate_timings(struct fb_info *info,=20
-				  struct fb_var_screeninfo *var,
-				  u32 xres, u32 yres)
-{
-	u64 num =3D 1000000000000;
-	u32 htotal =3D 0, vtotal, hfreq, vfreq, hblank, vblank;=20
-	u32 dclk, interlace =3D 0, dscan =3D 0;
-	u32 max_pixclock =3D 0;
-
-	switch (var->bits_per_pixel) {
-	case 8:
-		max_pixclock =3D 234000000;
-		break;
-	case 16:
-		max_pixclock =3D 229000000;
-		break;
-	case 24:
-	case 32:
-		max_pixclock =3D 204000000;
-		break;
-	default:
-		max_pixclock =3D 0;
-	}
-
-	if (var->vmode & FB_VMODE_INTERLACED) {=20
-		yres >>=3D 1;
-		interlace =3D 1;
-	}
-	if (var->vmode & FB_VMODE_DOUBLE) {
-		yres <<=3D 1;
-		dscan =3D 1;
-	}
-
-	hfreq =3D info->monspecs.hfmax;
-	vblank =3D i810_get_vblank(hfreq);
-	vtotal =3D yres + vblank;
-	vfreq =3D hfreq/vtotal;
-	if (vfreq > info->monspecs.vfmax) {=20
-		vfreq =3D info->monspecs.vfmax;
-		hfreq =3D i810_estimate_hfreq(vfreq, yres);
-		vblank =3D i810_get_vblank(hfreq);
-		vtotal =3D yres + vblank;
-	}=09
-	hblank =3D i810_get_hblank(hfreq, xres);
-	htotal =3D xres + hblank;
-	dclk =3D htotal * hfreq;
-	while(dclk > max_pixclock          && =20
-	      hfreq > info->monspecs.hfmin &&
-	      vfreq > info->monspecs.vfmin)   {
-		hfreq -=3D 1000;
-		vblank =3D i810_get_vblank(hfreq);
-		vtotal =3D yres + vblank;
-		vfreq =3D hfreq/vtotal;
-		hblank =3D i810_get_hblank(hfreq, xres);
-		htotal =3D xres + hblank;
-		dclk =3D hfreq * htotal;
-	}=20
-	if (vfreq < info->monspecs.vfmin) {
-		printk("i810fb: required vertical refresh, %dHz, "
-		       "for %dx%d is out of range\n",
-		       vfreq, xres, yres);
-		return -1;
-	}
-	if (hfreq < info->monspecs.hfmin) {
-		printk("i810fb: required horizontal sync frequency, %dKHz, "
-		       "for %dx%d is out of range\n", hfreq/1000, xres, yres);
-		return -1;
-	}
-	if (dclk < MIN_PIXELCLOCK) {
-		printk("i810fb: required pixelclock, %dMHz, for %dx%d"
-		       " is out of range\n", dclk/1000000, xres, yres);
-		return -1;
-	}
-
-	do_div(num, dclk);
-	var->pixclock =3D (u32) num;
-	var->hsync_len =3D ((htotal * 8)/100 + 4) & ~7;
-	var->right_margin =3D ((hblank >> 1) - var->hsync_len + 4) & ~7;
-	var->left_margin =3D (hblank-var->right_margin-var->hsync_len + 4) & ~7;
-
-	var->vsync_len =3D (3 << interlace) >> dscan;=20
-	var->lower_margin =3D (1 << interlace) >> dscan;
-	var->upper_margin =3D ((vblank << interlace) >> dscan) -
-		(var->vsync_len + var->lower_margin);
-
-	if (yres > 480 || (yres =3D=3D 200 && vfreq =3D=3D 60 && hfreq/100 =3D=3D=
 157))
-		var->sync |=3D FB_SYNC_VERT_HIGH_ACT | FB_SYNC_HOR_HIGH_ACT;
-	else {
-		if (yres =3D=3D 400 && vfreq =3D=3D 70 && hfreq/100 =3D=3D 315)
-			var->sync |=3D FB_SYNC_VERT_HIGH_ACT;
-		if (yres =3D=3D 350 && vfreq =3D=3D 60 && hfreq/100 =3D=3D 218)
-			var->sync |=3D FB_SYNC_HOR_HIGH_ACT;
-	}
-	return 0;
-}
-
-/**
- * i810_check_custom_timings - validates user entered timings
- * @info: pointer to fb_info
- * @var: pointer to current fb_var_screeninfo
- *
- * DESCRIPTION:
- * Validates user entered timings in @var.
- */
-static int i810_check_custom_timings(struct fb_info *info,=20
-				     struct fb_var_screeninfo *var,
-				     u32 xres, u32 yres)
-{
-	u64 num =3D 1000000000000;
-	u32 hfreq, vfreq, htotal, vtotal, pixclock;
-	u32 max_pixclock =3D 0;
-
-	if (!var->pixclock)
-		return -EINVAL;
-	do_div(num, var->pixclock);
-	pixclock =3D (u32) num;
-
-	htotal =3D xres + var->right_margin + var->hsync_len + var->left_margin;
-	vtotal =3D yres + var->lower_margin + var->vsync_len + var->upper_margin;
-
-	if (var->vmode & FB_VMODE_INTERLACED)=20
-		vtotal >>=3D 1;
-
-	if (var->vmode & FB_VMODE_DOUBLE)
-		vtotal <<=3D 1;
-
-	hfreq =3D pixclock/htotal;
-	vfreq =3D hfreq/vtotal;
-
-	switch (var->bits_per_pixel) {
-	case 8:
-		max_pixclock =3D 234000000;
-		break;
-	case 16:
-		max_pixclock =3D 229000000;
-		break;
-	case 24:
-	case 32:
-		max_pixclock =3D 204000000;
-		break;
-	default:
-		max_pixclock =3D 0;
-	}
-
-	if (pixclock < MIN_PIXELCLOCK || pixclock > max_pixclock ||
-	    hfreq < info->monspecs.hfmin || hfreq > info->monspecs.hfmax ||
-	    vfreq < info->monspecs.vfmin || vfreq > info->monspecs.vfmax)
-		return -EINVAL;
-=09
-	return 0;
-}
-
 /*************************************************************
  *                Hardware Cursor Routines                   *
  *************************************************************/
@@ -950,19 +695,25 @@
 				   struct i810fb_par *par)
 {
 	u8 *addr =3D par->cursor_heap.virtual;
-	int i, j, w =3D (width + 7)/8;
-
+	int i, j, w =3D width/8;
+	int mod =3D width % 8, t_mask, d_mask;
+=09
+	t_mask =3D 0xff >> mod;
+	d_mask =3D ~(0xff >> mod);=20
 	for (i =3D height; i--; ) {
 		for (j =3D 0; j < w; j++) {
 			i810_writeb(j+0, addr, 0x00);
 			i810_writeb(j+8, addr, *data++);
 		}
+		if (mod) {
+			i810_writeb(j+0, addr, t_mask);
+			i810_writeb(j+8, addr, *data++ & d_mask);
+		}
 		addr +=3D 16;
 	}
 }
=20
-static void i810_load_cursor_colors(int fg, int bg,=20
-				    struct fb_info *info)
+static void i810_load_cursor_colors(int fg, int bg, struct fb_info *info)
 {
 	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
 	u8 *mmio =3D par->mmio_start_virtual, temp;
@@ -1097,28 +848,14 @@
 		var->transp.length =3D 0;
 		break;
 	case 16:
-		if (var->green.length =3D=3D 5) {
-			/* RGB 555 */
-			var->red.offset =3D 10;
-			var->red.length =3D 5;
-			var->green.offset =3D 5;
-			var->green.length =3D 5;
-			var->blue.offset =3D 0;
-			var->blue.length =3D 5;
-			var->transp.offset =3D 15;
-			var->transp.length =3D 1;
-		}
-		else {
-			/* RGB 565 */
-			var->red.offset =3D 11;
-			var->red.length =3D 5;
-			var->green.offset =3D 5;
-			var->green.length =3D 6;
-			var->blue.offset =3D 0;
-			var->blue.length =3D 5;
-			var->transp.offset =3D 0;
-			var->transp.length =3D 0;
-		}
+		var->green.length =3D (var->green.length =3D=3D 5) ? 5 : 6;
+		var->red.length =3D 5;
+		var->blue.length =3D 5;
+		var->transp.length =3D 6 - var->green.length;
+		var->blue.offset =3D 0;
+		var->green.offset =3D 5;
+		var->red.offset =3D 5 + var->green.length;
+		var->transp.offset =3D  (5 + var->red.offset) & 15;
 		break;
 	case 24:	/* RGB 888   */
 	case 32:	/* RGBA 8888 */
@@ -1128,15 +865,9 @@
 		var->green.length =3D 8;
 		var->blue.offset =3D 0;
 		var->blue.length =3D 8;
-		if (var->bits_per_pixel =3D=3D 24) {
-			var->transp.offset =3D 0;
-			var->transp.length =3D 0;
-		}
-		else {
-			var->transp.offset =3D 24;
-			var->transp.length =3D 8;
-			break;
-		}
+		var->transp.length =3D var->bits_per_pixel - 24;
+		var->transp.offset =3D (var->transp.length) ? 24 : 0;
+		break;
 	}
 	var->red.msb_right =3D 0;
 	var->green.msb_right =3D 0;
@@ -1195,11 +926,24 @@
 	/*
 	 * Monitor limit
 	 */
-	if (i810_check_custom_timings(info, var, xres, yres)) {
-		if (i810_calculate_timings(info, var, xres, yres)) {
-			return -EINVAL;
+	if (fb_validate_mode(var, info)) {
+		switch (var->bits_per_pixel) {
+		case 8:
+			info->monspecs.dclkmax =3D 234000000;
+			break;
+		case 16:
+			info->monspecs.dclkmax =3D 229000000;
+			break;
+		case 24:
+		case 32:
+			info->monspecs.dclkmax =3D 204000000;
+			break;
 		}
+		info->monspecs.dclkmin =3D 15000000;
+		if (fb_get_mode(FB_MAXTIMINGS, 0, var, info))
+			return -EINVAL;
 	}
+=09
 	var->xres =3D xres;
 	var->yres =3D yres;
 	var->xres_virtual =3D vxres;
@@ -1245,8 +989,7 @@
 		return -EINVAL;
 	}
     	fix->ywrapstep =3D 0;
-	fix->line_length =3D get_line_length(par, info->var.xres_virtual,=20
-					   info->var.bits_per_pixel);
+	fix->line_length =3D par->pitch;
 	fix->mmio_start =3D par->mmio_start_phys;
 	fix->mmio_len =3D MMIO_SIZE;
 	fix->accel =3D FB_ACCEL_I810;
@@ -1258,14 +1001,13 @@
  * decode_var - modify par according to contents of var
  * @var: pointer to fb_var_screeninfo
  * @par: pointer to i810fb_par
- * @info: pointer to fb_info
  *
  * DESCRIPTION:
  * Based on the contents of @var, @par will be dynamically filled up.
  * @par contains all information necessary to modify the hardware.=20
 */
 static void decode_var(const struct fb_var_screeninfo *var,=20
-		       struct i810fb_par *par, struct fb_info *info)
+		       struct i810fb_par *par)
 {
 	u32 xres, yres, vxres, vyres;
=20
@@ -1569,7 +1311,7 @@
 {
 	struct i810fb_par *par =3D (struct i810fb_par *) info->par;
=20
-	decode_var(&info->var, par, info);
+	decode_var(&info->var, par);
 	i810_load_regs(par);
 	i810_init_cursor(par);
 	par->cursor_reset =3D 1;
@@ -1608,9 +1350,8 @@
 	u8 *mmio =3D par->mmio_start_virtual;=09
 	u16 flags =3D cursor->set;
=20
-	if (!info->var.accel_flags || par->dev_flags & LOCKUP) {
+	if (!info->var.accel_flags || par->dev_flags & LOCKUP)=20
 		return soft_cursor(info, cursor);
-	}
=20
 	if (cursor->image.width > 64 || cursor->image.height > 64 ||
 	    (cursor->dest =3D=3D NULL && cursor->rop =3D=3D ROP_XOR))
@@ -1655,9 +1396,9 @@
 		switch (cursor->rop) {
 		case ROP_XOR:
 			for (i =3D 0; i < size; i++) {
-				data[i] =3D (cursor->image.data[i] &=20
-					   cursor->mask[i]) ^
-					cursor->dest[i];
+				data[i] =3D ((cursor->image.data[i] &=20
+					    cursor->mask[i]) ^
+					   cursor->dest[i]);
 			}
 			break;
 		case ROP_COPY:
@@ -1680,19 +1421,19 @@
 }
=20
 static struct fb_ops i810fb_ops __initdata =3D {
-    .owner =3D             THIS_MODULE,
-    .fb_open =3D           i810fb_open,
-    .fb_release =3D        i810fb_release,
-    .fb_check_var =3D      i810fb_check_var,
-    .fb_set_par =3D        i810fb_set_par,
-    .fb_setcolreg =3D      i810fb_setcolreg,
-    .fb_blank =3D          i810fb_blank,
-    .fb_pan_display =3D    i810fb_pan_display,=20
-    .fb_fillrect =3D       i810fb_fillrect,
-    .fb_copyarea =3D       i810fb_copyarea,
-    .fb_imageblit =3D      i810fb_imageblit,
-    .fb_cursor =3D         i810fb_cursor,
-    .fb_sync =3D           i810fb_sync,
+	.owner =3D             THIS_MODULE,
+	.fb_open =3D           i810fb_open,
+	.fb_release =3D        i810fb_release,
+	.fb_check_var =3D      i810fb_check_var,
+	.fb_set_par =3D        i810fb_set_par,
+	.fb_setcolreg =3D      i810fb_setcolreg,
+	.fb_blank =3D          i810fb_blank,
+	.fb_pan_display =3D    i810fb_pan_display,=20
+	.fb_fillrect =3D       i810fb_fillrect,
+	.fb_copyarea =3D       i810fb_copyarea,
+	.fb_imageblit =3D      i810fb_imageblit,
+	.fb_cursor =3D         i810fb_cursor,
+	.fb_sync =3D           i810fb_sync,
 };
=20
 /***********************************************************************
@@ -1864,7 +1605,7 @@
 	info->var.yres =3D yres;
 	info->var.yres_virtual =3D vyres;
 	info->var.bits_per_pixel =3D bpp;
-=09
+
 	if (dcolor)
 		info->var.nonstd =3D 1;
=20
@@ -2076,22 +1817,13 @@
 	vfreq =3D hfreq/(info->var.yres + info->var.upper_margin +
 		       info->var.vsync_len + info->var.lower_margin);
=20
-      	printk("fb: %s v%d.%d.%d%s, Tony Daplas\n"
+      	printk("fb: %s v%d.%d.%d%s, (c) Tony Daplas\n"
       	       "     Video RAM      : %dK\n"=20
-	       "     Mode           : %dx%d-%dbpp@%dHz\n"
-	       "     Acceleration   : %sabled\n"
-	       "     MTRR           : %sabled\n"
-	       "     External VGA   : %sabled\n"
-	       "     Video Timings  : %s\n",=09
+	       "     Mode           : %dx%d-%dbpp@%dHz\n",
 	       i810_pci_list[entry->driver_data],
 	       VERSION_MAJOR, VERSION_MINOR, VERSION_TEENIE, BRANCH_VERSION,
 	       (int) par->fb.size>>10, info->var.xres,=20
-	       info->var.yres, info->var.bits_per_pixel, vfreq,=20
-	       (par->dev_flags & HAS_ACCELERATION) ? "en" : "dis",=20
-	       (par->dev_flags & HAS_MTRR) ? "en" : "dis",=20
-	       (ext_vga) ? "en" : "dis", (IS_DVT) ?=20
-	       "Intel(R) DVT" : "VESA GTF (US)");
-
+	       info->var.yres, info->var.bits_per_pixel, vfreq);
 	return 0;
 }
=20

--=-/h5HSLgHBhSgwyv3V2GG--




-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com - A 128-bit supercerts will
allow you to extend the highest allowed 128 bit encryption to all your 
clients even if they use browsers that are limited to 40 bit encryption. 
Get a guide here:http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0030en
