From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH][FBCON]: Optimization for accel_putcs()
Date: Fri, 2 Jul 2004 11:31:10 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407021056.27194.adaplas@hotpop.com>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BgElJ-0006DQ-Iw
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Jul 2004 20:30:53 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BgElI-0005Pp-BF
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Jul 2004 20:30:53 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id F3D81FD5AC4
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri,  2 Jul 2004 03:12:16 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, jsimmons@pentafluge.infradead.org
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi all,

I did some simple benchmarking (time cat linux-2.6.7-mm5/MAINTAINERS) between
2.4 and 2.6 and I am not satisfied with what I see (It's claimed that fbdev-2.6
is faster than 2.4).  The reason for the claim:

2.4 putcs - draw small amounts of data a lot of times
2.6 putcs - draw larger amounts of data a fewer times

The way characters are drawn in 2.6 is optimal for accelerated drivers but should
also give a speed boost for drivers that rely on software drawing.  However the
penaly incurred when preparing a large bitmap from a number of small bitmaps is
currently very high.  This is because of the following reasons:

1. fb_move_buf_{aligned|unaligned} uses pixmap->{out|in}buf.  This is very
expensive since outbuf and inbuf methods process only a byte or 2 of data at a
time. 

2. fb_sys_outbuf (the default method for pixmap->outbuf) uses memcpy().  Not a
good choice if moving only a few bytes.

2. fb_move_buf_unaligned (used for fonts such as 12x22) also involves a lot of
bit operations + a lot of calls to outbuf/inbuf which proportionately increases
the penaly.

So, I thought of separating fb_move_buf_* to fb_iomove_buf_* and fb_sysmove_buf_*.  

	fb_iomove_buf_* - used if drivers specified outbuf and inbuf methods
	fb_sysmove_buf_* - used if drivers have no outbuf or inbuf methods 

	*Most, if not all drivers fall in the second category.

Below is a table that show differences between 2.4, 2.6 and 2.6 + abovementioned
changes. To reduce the effect of panning and fillrect/copyarea, the scrollmode
is forced to redraw.

=================================================================
Test Hardware: P4 2G nVidia GeForce2 MX 64
Scrollmode: redraw

time cat linux-2.6.7-mm5/MAINTAINERS

1024x768-8		1024x768-16		1024x768-32
=================================================================
8x16 noaccel (2.4)
real    0m5.490s	real    0m8.535s	real    0m15.388s
user    0m0.001s	user    0m0.000s	user    0m0.001s
sys     0m5.487s	sys     0m8.535s	sys     0m15.386s

8x16 noaccel (2.6)
real    0m5.166s	real    0m7.195s	real    0m12.177s
user    0m0.001s	user    0m0.000s	user    0m0.000s
sys     0m5.164s	sys     0m7.192s	sys     0m12.176s

8x16 noaccel+patch (2.6)
real    0m3.474s	real    0m5.496s	real    0m10.460s
user    0m0.001s	user    0m0.001s	user    0m0.001s
sys     0m5.492s	sys     0m5.492s	sys     0m10.454s
-----------------------------------------------------------------
8x16 accel (2.4)
real    0m4.368s	real    0m9.420s	real    0m22.415s
user    0m0.001s	user    0m0.001s	user    0m0.001s
sys     0m4.019s	sys     0m9.384s	sys     0m22.312s

8x16 accel (2.6)
real    0m4.296s	real    0m4.339s	real    0m4.391s
user    0m0.001s	user    0m0.001s	user    0m0.000s
sys     0m4.280s	sys     0m4.336s	sys     0m4.389s

8x16 accel+patch (2.6)
real    0m2.536s	real    0m2.649s	real    0m2.799s
user    0m0.000s	user    0m0.000s	user    0m0.001s
sys     0m2.536s	sys     0m2.645s	sys     0m2.798s
-----------------------------------------------------------------

1024x768-8		1024x768-16		1024x768-32
=================================================================
12x22 noaccel (2.4)
real    0m7.883s	real    0m12.175s	real    0m21.134s
user    0m0.000s	user    0m0.000s	user    0m0.001s
sys     0m7.882s	sys     0m12.174s	sys     0m21.129s

12x22 noaccel (2.6)
real    0m10.651s	real    0m13.550s	real    0m21.009s
user    0m0.001s	user    0m0.001s	user    0m0.000s	
sys     0m10.617s	sys     0m13.545s	sys     0m21.008s

12x22 noaccel+patch (2.6)
real    0m4.794s	real    0m7.718s	real    0m15.173s
user    0m0.002s	user    0m0.001s	user    0m0.000s
sys     0m4.792s	sys     0m7.715s	sys     0m15.170s
-----------------------------------------------------------------
12x22 accel (2.4)
real    0m3.971s	real    0m9.030s	real    0m21.711s
user    0m0.000s	user    0m0.000s	user    0m0.000s
sys     0m3.950s	sys     0m8.983s	sys     0m21.602s

12x22 accel (2.6)
real    0m9.392s	real    0m9.486s	real    0m9.508s
user    0m0.000s	user    0m0.000s	user    0m0.001s
sys     0m9.392s	sys     0m9.484s	sys     0m9.484s

12x22 accel+patch (2.6)
real    0m3.570s	real    0m3.603s	real    0m3.848s
user    0m0.001s	user    0m0.000s	user    0m0.000s
sys     0m3.567s	sys     0m3.600s	sys     0m3.844s
-----------------------------------------------------------------

Summary:

1. 2.6 unaccelerated is a bit faster than 2.4 when handling 8x16 fonts,
with a higher speed differential at high color depths.

2. 2.4 unaccelerated is a bit faster than 2.6 when handling 12x22 fonts,
with a smaller speed difference at high color depths (2.6 is actually
a bit faster than 2.4 at 32bpp).

3. 2.4 rivafb accelerated suffers at high color depths, even becoming
slower than unaccelerated, possibly because of the 'draw few bytes
many times' method.

4. 2.6 rivafb accelerated has similar performance at any color depth,
possibly because of 'draw lots of bytes a fewer times' method.

5. With the changes, there is a speed gain of ~1.7 seconds and ~5.7
seconds with 8x16 and 12x22 fonts respectively indepependent of the
color depth or acceleration used. The speed gain is constant but
significant.

Below is a patch against 2.6.7-mm5.  The effects will be very 
noticeable with drivers that uses SCROLL_REDRAW, but one should
still see some speed gain even if SCROLL_YPAN/YWRAP is used.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>

Separated fb_sys_move_* into fb_iosys_move_* and fb_sysmove_*
to reduce penalty when constructing fb_image->data from 
character maps. In my testcase (1024x768 SCROLL_REDRAW), I
get a ~1.7 second advantage with 'time cat MAINTAINERS' using
8x16 fonts and ~5.7 seconds with 12x22 fonts.  The speed gain
is independent of acceleration or color depth.


diff -Naur linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c linux-2.6.7-mm5/drivers/video/console/fbcon.c
--- linux-2.6.7-mm5-orig/drivers/video/console/fbcon.c	2004-07-02 01:43:40.477020360 +0000
+++ linux-2.6.7-mm5/drivers/video/console/fbcon.c	2004-07-02 01:42:12.935328720 +0000
@@ -436,8 +436,15 @@
 }	
 
 void accel_putcs(struct vc_data *vc, struct fb_info *info,
-			const unsigned short *s, int count, int yy, int xx)
+		 const unsigned short *s, int count, int yy, int xx)
 {
+	void (*move_unaligned)(struct fb_info *info, struct fb_pixmap *buf,
+			       u8 *dst, u32 d_pitch, u8 *src, u32 idx,
+			       u32 height, u32 shift_high, u32 shift_low,
+			       u32 mod);
+	void (*move_aligned)(struct fb_info *info, struct fb_pixmap *buf,
+			     u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
+			     u32 height);
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int width = (vc->vc_font.width + 7) >> 3;
 	unsigned int cellsize = vc->vc_font.height * width;
@@ -446,20 +453,26 @@
 	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
 	unsigned int shift_high = 8, pitch, cnt, size, k;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
 	unsigned int idx = vc->vc_font.width >> 3;
 	struct fb_image image;
-	u16 c = scr_readw(s);
-	u8 *src, *dst, *dst0;
+	u8 *src, *dst;
 
-	image.fg_color = attr_fgcol(fgshift, c);
-	image.bg_color = attr_bgcol(bgshift, c);
+	image.fg_color = attr_fgcol((vc->vc_hi_font_mask) ? 9 : 8,
+				    scr_readw(s));
+	image.bg_color = attr_bgcol((vc->vc_hi_font_mask) ? 13 : 12,
+				    scr_readw(s));
 	image.dx = xx * vc->vc_font.width;
 	image.dy = yy * vc->vc_font.height;
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
+	if (info->pixmap.outbuf && info->pixmap.inbuf) {
+		move_aligned = fb_iomove_buf_aligned;
+		move_unaligned = fb_iomove_buf_unaligned;
+	} else {
+		move_aligned = fb_sysmove_buf_aligned;
+		move_unaligned = fb_sysmove_buf_unaligned;
+	}
 	while (count) {
 		if (count > maxcnt)
 			cnt = k = maxcnt;
@@ -471,24 +484,27 @@
 		pitch &= ~scan_align;
 		size = pitch * image.height + buf_align;
 		size &= ~buf_align;
-		dst0 = fb_get_buffer_offset(info, &info->pixmap, size);
-		image.data = dst0;
-		while (k--) {
-			src = vc->vc_font.data + (scr_readw(s++) & charmask)*cellsize;
-			dst = dst0;
-
-			if (mod) {
-				fb_move_buf_unaligned(info, &info->pixmap, dst, pitch,
-						   src, idx, image.height, shift_high,
-						   shift_low, mod);
+		dst = fb_get_buffer_offset(info, &info->pixmap, size);
+		image.data = dst;
+		if (mod) {
+			while (k--) {
+				src = vc->vc_font.data + (scr_readw(s++)&
+							  charmask)*cellsize;
+				move_unaligned(info, &info->pixmap, dst, pitch,
+					       src, idx, image.height,
+					       shift_high, shift_low, mod);
 				shift_low += mod;
-				dst0 += (shift_low >= 8) ? width : width - 1;
+				dst += (shift_low >= 8) ? width : width - 1;
 				shift_low &= 7;
 				shift_high = 8 - shift_low;
-			} else {
-				fb_move_buf_aligned(info, &info->pixmap, dst, pitch,
-						 src, idx, image.height);
-				dst0 += width;
+			}
+		} else {
+			while (k--) {
+				src = vc->vc_font.data + (scr_readw(s++)&
+							  charmask)*cellsize;
+				move_aligned(info, &info->pixmap, dst, pitch,
+					     src, idx, image.height);
+				dst += width;
 			}
 		}
 		info->fbops->fb_imageblit(info, &image);
@@ -950,8 +966,11 @@
 	dst = fb_get_buffer_offset(info, &info->pixmap, size);
 	image.data = dst;
 
-	fb_move_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
-
+	if (info->pixmap.outbuf)
+		fb_iomove_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
+	else
+		fb_sysmove_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
+		
 	info->fbops->fb_imageblit(info, &image);
 }
 
diff -Naur linux-2.6.7-mm5-orig/drivers/video/fbmem.c linux-2.6.7-mm5/drivers/video/fbmem.c
--- linux-2.6.7-mm5-orig/drivers/video/fbmem.c	2004-07-02 01:43:07.470038184 +0000
+++ linux-2.6.7-mm5/drivers/video/fbmem.c	2004-07-02 01:41:36.126924448 +0000
@@ -430,34 +430,37 @@
 /*
  * Drawing helpers.
  */
-static u8 fb_sys_inbuf(struct fb_info *info, u8 *src)
+void fb_iomove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
+			   u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
+			   u32 height)
 {
-	return *src;
-}
+	int i;
 
-static void fb_sys_outbuf(struct fb_info *info, u8 *dst,
-				u8 *src, unsigned int size)
-{
-	memcpy(dst, src, size);
-}	
+	for (i = height; i--; ) {
+		buf->outbuf(info, dst, src, s_pitch);
+		src += s_pitch;
+		dst += d_pitch;
+	}
+}
 
-void fb_move_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
-			u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-			u32 height)
+void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
+			    u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
+			    u32 height)
 {
-	int i;
+	int i, j;
 
 	for (i = height; i--; ) {
-		buf->outbuf(info, dst, src, s_pitch);
+		for (j = 0; j < s_pitch; j++)
+			dst[j] = src[j];
 		src += s_pitch;
 		dst += d_pitch;
 	}
 }
 
-void fb_move_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
-			u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-			u32 height, u32 shift_high, u32 shift_low,
-			u32 mod)
+void fb_iomove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
+			     u8 *dst, u32 d_pitch, u8 *src, u32 idx,
+			     u32 height, u32 shift_high, u32 shift_low,
+			     u32 mod)
 {
 	u8 mask = (u8) (0xfff << shift_high), tmp;
 	int i, j;
@@ -485,6 +488,37 @@
 	}
 }
 
+void fb_sysmove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
+			      u8 *dst, u32 d_pitch, u8 *src, u32 idx,
+			      u32 height, u32 shift_high, u32 shift_low,
+			      u32 mod)
+{
+	u8 mask = (u8) (0xfff << shift_high), tmp;
+	int i, j;
+
+	for (i = height; i--; ) {
+		for (j = 0; j < idx; j++) {
+			tmp = dst[j];
+			tmp &= mask;
+			tmp |= *src >> shift_low;
+			dst[j] = tmp;
+			tmp = *src << shift_high;
+			dst[j+1] = tmp;
+			src++;
+		}
+		tmp = dst[idx];
+		tmp &= mask;
+		tmp |= *src >> shift_low;
+		dst[idx] = tmp;
+		if (shift_high < mod) {
+			tmp = *src << shift_high;
+			dst[idx+1] = tmp;
+		}	
+		src++;
+		dst += d_pitch;
+	}
+}
+
 /*
  * we need to lock this section since fb_cursor
  * may use fb_imageblit()
@@ -897,7 +931,10 @@
 	unsigned int width = (info->cursor.image.width + 7) >> 3;
 	u8 *data = (u8 *) info->cursor.image.data;
 
-	info->sprite.outbuf(info, info->sprite.addr, data, width);
+	if (info->sprite.outbuf)
+	    info->sprite.outbuf(info, info->sprite.addr, data, width);
+	else
+	    memcpy(info->sprite.addr, data, width);
 }
 
 int
@@ -1319,10 +1356,6 @@
 		}
 	}	
 	fb_info->pixmap.offset = 0;
-	if (fb_info->pixmap.outbuf == NULL)
-		fb_info->pixmap.outbuf = fb_sys_outbuf;
-	if (fb_info->pixmap.inbuf == NULL)
-		fb_info->pixmap.inbuf = fb_sys_inbuf;
 
 	if (fb_info->sprite.addr == NULL) {
 		fb_info->sprite.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
@@ -1335,10 +1368,6 @@
 		}
 	}
 	fb_info->sprite.offset = 0;
-	if (fb_info->sprite.outbuf == NULL)
-		fb_info->sprite.outbuf = fb_sys_outbuf;
-	if (fb_info->sprite.inbuf == NULL)
-		fb_info->sprite.inbuf = fb_sys_inbuf;
 
 	registered_fb[i] = fb_info;
 
@@ -1533,8 +1562,10 @@
 EXPORT_SYMBOL(fb_blank);
 EXPORT_SYMBOL(fb_pan_display);
 EXPORT_SYMBOL(fb_get_buffer_offset);
-EXPORT_SYMBOL(fb_move_buf_unaligned);
-EXPORT_SYMBOL(fb_move_buf_aligned);
+EXPORT_SYMBOL(fb_iomove_buf_unaligned);
+EXPORT_SYMBOL(fb_iomove_buf_aligned);
+EXPORT_SYMBOL(fb_sysmove_buf_unaligned);
+EXPORT_SYMBOL(fb_sysmove_buf_aligned);
 EXPORT_SYMBOL(fb_load_cursor_image);
 EXPORT_SYMBOL(fb_set_suspend);
 EXPORT_SYMBOL(fb_register_client);
diff -Naur linux-2.6.7-mm5-orig/drivers/video/riva/fbdev.c linux-2.6.7-mm5/drivers/video/riva/fbdev.c
--- linux-2.6.7-mm5-orig/drivers/video/riva/fbdev.c	2004-07-02 01:43:29.172738872 +0000
+++ linux-2.6.7-mm5/drivers/video/riva/fbdev.c	2004-07-02 01:45:41.549614528 +0000
@@ -1619,8 +1619,8 @@
 			break;
 		}
 		
-		fb_move_buf_aligned(info, &info->sprite, data, d_pitch, src,
-				    s_pitch, info->cursor.image.height);
+		fb_sysmove_buf_aligned(info, &info->sprite, data, d_pitch, src,
+				       s_pitch, info->cursor.image.height);
 
 		bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 		     ((info->cmap.green[bg_idx] & 0xf8) << 2) |
diff -Naur linux-2.6.7-mm5-orig/drivers/video/softcursor.c linux-2.6.7-mm5/drivers/video/softcursor.c
--- linux-2.6.7-mm5-orig/drivers/video/softcursor.c	2004-07-02 01:43:15.299847872 +0000
+++ linux-2.6.7-mm5/drivers/video/softcursor.c	2004-07-02 01:41:41.226149248 +0000
@@ -73,7 +73,12 @@
 	} else 
 		memcpy(src, cursor->image.data, dsize);
 	
-	fb_move_buf_aligned(info, &info->sprite, dst, d_pitch, src, s_pitch, info->cursor.image.height);
+	if (info->sprite.outbuf)
+	    fb_iomove_buf_aligned(info, &info->sprite, dst, d_pitch, src,
+				  s_pitch, info->cursor.image.height);
+	else
+	    fb_sysmove_buf_aligned(info, &info->sprite, dst, d_pitch, src,
+				   s_pitch, info->cursor.image.height);
 	info->cursor.image.data = dst;
 	
 	info->fbops->fb_imageblit(info, &info->cursor.image);
diff -Naur linux-2.6.7-mm5-orig/include/linux/fb.h linux-2.6.7-mm5/include/linux/fb.h
--- linux-2.6.7-mm5-orig/include/linux/fb.h	2004-07-02 01:43:54.523884912 +0000
+++ linux-2.6.7-mm5/include/linux/fb.h	2004-07-02 01:42:42.077898376 +0000
@@ -638,10 +638,16 @@
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
 extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
-extern void fb_move_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
+extern void fb_iomove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
 				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
 				u32 height, u32 shift_high, u32 shift_low, u32 mod);
-extern void fb_move_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
+extern void fb_iomove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
+				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
+				u32 height);
+extern void fb_sysmove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
+				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
+				u32 height, u32 shift_high, u32 shift_low, u32 mod);
+extern void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
 				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
 				u32 height);
 extern void fb_load_cursor_image(struct fb_info *);





 




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
