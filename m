From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [RESEND] clipping
Date: 10 Jan 2003 21:55:43 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042206938.971.2.camel@localhost.localdomain>
References: <Pine.GSO.4.21.0301092242210.8148-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18WznU-0000ai-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Jan 2003 06:06:08 -0800
In-Reply-To: <Pine.GSO.4.21.0301092242210.8148-100000@vervain.sonytel.be>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 2003-01-10 at 05:46, Geert Uytterhoeven wrote:
> On Thu, 9 Jan 2003, James Simmons wrote:
> > > So perhaps, a function something like this:
> > > 
> > > void fb_clip(struct fb_fillrect *region, struct fb_fillrect *clip);
> > > 
> > > This should not be difficult to implement, and I'll code it if everyone
> > > agrees.
> >  
> > I thought about this. Originally I did have this function but removed it.
> > WHat do you think Geert?
> 
> Yes, that's OK.
> 
> But I was most concerned about fb_ops.fb_imageblit(), since clipping impacts
> fb_image.data as well. IIRC, all (most?) current clipping implementations
> modify fb_image.{dx,dy,width,height} only, without updating fb_image.data.
> 
> > > The other option (which I don't like) is just to check the passed
> > > fb_var_screeninfo in the put_var ioctl against the current console
> > > window size.  But this is not foolproof as we will not be sure of the
> > > resulting window size _after_ the fb_set_var() call.
> > 
> > Yuck!!! The other way is better.
> 
> Well, in between the calls to fb_ops.fb_check_var() and fb_ops.set_par() you
> can still perform that check. But it's indeed ugly.
> 

Geert, James

I've attached a patch that implements clipping in the fbcon layer using
2 generic clipping functions:

fb_clip_region() - one area to clip; and
fb_clip_region2() - two areas to clip (source and destination) as in
copyarea()

The above functions use this:

struct fb_region {
	__u32 dx;
	__u32 dy;
	__u32 width;
	__u32 height;
};

which is just a subset of fb_{image,copyarea,fillrect}.  Good thing that
you arranged those fields in the right order :-).

fb_clip_region() is a standard clipping implementation, whereas
fb_clip_region2() is a bit trickier because it has to clip _both_ the
source and destination against each other.  Most of 2 operand clipping
operations always assume that the source area need not be clipped.

For putcs and putc, I just made it mandatory that when one character is
to be out of bounds, it just won't get drawn.  A cleaner implementation
is, of course, to clip the destination window + the passed bitmap.

For accel_cursor(), if it's going out of bounds, I place it at
screenpos(0,0) and hide it.  Hopefully no one notices :-)

Do we need to clip the fb_set_logo() too?

I've also modified the cfb_{fillrect,copyarea,imageblit}: removed
clipping code and so it does not modify the passed parameters.  

The patch may be a bit difficult to swallow because it is pretty much
invasive and not so clean :-(, so it's okay if you don't take it.
But it has the advantage of clipping the coordinates for hardware that 
does not support clipping (like the i810fb).  For hardware that does 
support clipping, or wants to implement its own clipping code, we require 
a 'caps' (capabilities) field in fb_info or fb_fix_screeninfo.  This is 
checked first and if set, the default clipping code is bypassed.

Here's how it currently works in my system:

1.  reduce xres_virtual - works as expected, the tail end of the chars
are truncated.

2.  reduce yres_virtual - works as expected but display is useless as the 
screen is located deep down towards the end of yres_virtual.

In all cases, the screen can be restored when switching from another
console and back.  

Tony

diff -Naur linux-2.5.54/drivers/video/cfbcopyarea.c linux/drivers/video/cfbcopyarea.c
--- linux-2.5.54/drivers/video/cfbcopyarea.c	2003-01-09 13:58:14.000000000 +0000
+++ linux/drivers/video/cfbcopyarea.c	2003-01-09 13:57:43.000000000 +0000
@@ -321,7 +321,6 @@
 
 void cfb_copyarea(struct fb_info *p, struct fb_copyarea *area)
 {
-	int x2, y2, old_dx, old_dy, vxres, vyres;
 	unsigned long next_line = p->fix.line_length;
 	int dst_idx = 0, src_idx = 0, rev_copy = 0;
 	unsigned long *dst = NULL, *src = NULL;
@@ -330,40 +329,6 @@
 	if (!p->fbops->fb_rotate && p->var.rotate) {
 	}	
 	
-	vxres = p->var.xres_virtual;
-	vyres = p->var.yres_virtual;
-
-	if (area->dx > vxres || area->sx > vxres || 
-	    area->dy > vyres || area->sy > vyres)
-		return;
-
-	/* clip the destination */
-	old_dx = area->dx;
-	old_dy = area->dy;
-
-	/*
-	 * We could use hardware clipping but on many cards you get around
-	 * hardware clipping by writing to framebuffer directly.
-	 */
-	x2 = area->dx + area->width;
-	y2 = area->dy + area->height;
-	area->dx = area->dx > 0 ? area->dx : 0;
-	area->dy = area->dy > 0 ? area->dy : 0;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
-	area->width = x2 - area->dx;
-	area->height = y2 - area->dy;
-
-	/* update sx1,sy1 */
-	area->sx += (area->dx - old_dx);
-	area->sy += (area->dy - old_dy);
-
-	/* the source must be completely inside the virtual screen */
-	if (area->sx < 0 || area->sy < 0 ||
-	    (area->sx + area->width) > vxres ||
-	    (area->sy + area->height) > vyres)
-		return;
-	
 	if (area->dy > area->sy || (area->dy == area->sy && area->dx > area->sx)) {
 		area->dy += area->height;
 		area->sy += area->height;
diff -Naur linux-2.5.54/drivers/video/cfbfillrect.c linux/drivers/video/cfbfillrect.c
--- linux-2.5.54/drivers/video/cfbfillrect.c	2003-01-09 13:58:10.000000000 +0000
+++ linux/drivers/video/cfbfillrect.c	2003-01-09 13:57:44.000000000 +0000
@@ -361,7 +361,6 @@
 void cfb_fillrect(struct fb_info *p, struct fb_fillrect *rect)
 {
 	unsigned long height, fg;
-	unsigned long x2, y2, vxres, vyres;
 	unsigned long *dst;
 	int dst_idx, left;
 	u32 bpp = p->var.bits_per_pixel;
@@ -370,21 +369,7 @@
 	if (!p->fbops->fb_rotate && p->var.rotate) {
 	}	
 	
-	vxres = p->var.xres_virtual;
-	vyres = p->var.yres_virtual;
-
-	if (!rect->width || !rect->height || rect->dx > vxres || rect->dy > vyres)
-		return;
-
-	/* We could use hardware clipping but on many cards you get around
-	 * hardware clipping by writing to framebuffer directly. */
-	
-	x2 = rect->dx + rect->width;
-	y2 = rect->dy + rect->height;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
-	rect->width = x2 - rect->dx;
-	height = y2 - rect->dy;
+	height = rect->height;
 	
 	if (p->fix.visual == FB_VISUAL_TRUECOLOR ||
 	    p->fix.visual == FB_VISUAL_DIRECTCOLOR )
diff -Naur linux-2.5.54/drivers/video/cfbimgblt.c linux/drivers/video/cfbimgblt.c
--- linux-2.5.54/drivers/video/cfbimgblt.c	2003-01-09 13:58:19.000000000 +0000
+++ linux/drivers/video/cfbimgblt.c	2003-01-09 15:52:14.000000000 +0000
@@ -88,11 +88,13 @@
 
 #if defined (__BIG_ENDIAN)
 #define LEFT_POS(bpp)          (BITS_PER_LONG - bpp)
+#define LEFT_POS32(bpp)        (32 - bpp)
 #define NEXT_POS(pos, bpp)     ((pos) -= (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) >> (bits))
 #define SHIFT_LOW(val, bits)   ((val) << (bits))
 #else
 #define LEFT_POS(bpp)          (0)
+#define LEFT_POS32(bpp)        (0)
 #define NEXT_POS(pos, bpp)     ((pos) += (bpp))
 #define SHIFT_HIGH(val, bits)  ((val) << (bits))
 #define SHIFT_LOW(val, bits)   ((val) >> (bits))
@@ -224,25 +226,25 @@
 }
 
 static inline void fast_imageblit(struct fb_image *image, struct fb_info *p, u8 *dst1, 
-				  unsigned long fgcolor, unsigned long bgcolor) 
+				  u32 fgcolor, u32 bgcolor) 
 {
 	int i, j, k, l = 8, n;
-	unsigned long bit_mask, end_mask, eorx; 
-	unsigned long fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
-	unsigned long tmp = (1 << bpp) - 1;
-	unsigned long ppw = BITS_PER_LONG/bpp, ppos;
-	unsigned long *dst;
+	u32 bit_mask, end_mask, eorx; 
+	u32 fgx = fgcolor, bgx = bgcolor, pad, bpp = p->var.bits_per_pixel;
+	u32 tmp = (1 << bpp) - 1;
+	u32 ppw = 32/bpp, ppos;
+	u32 *dst;
 	u32 *tab = NULL;
 	char *src = image->data;
 		
-	switch (ppw) {
-	case 4:
+	switch (bpp) {
+	case 8:
 		tab = cfb_tab8;
 		break;
-	case 2:
+	case 16:
 		tab = cfb_tab16;
 		break;
-	case 1:
+	case 32:
 		tab = cfb_tab32;
 		break;
 	}
@@ -264,17 +266,17 @@
 	k = image->width/ppw;
 
 	for (i = image->height; i--; ) {
-		dst = (unsigned long *) dst1;
+		dst = (u32 *) dst1;
 		
 		for (j = k; j--; ) {
 			l -= ppw;
 			end_mask = tab[(*src >> l) & bit_mask]; 
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
+			fb_writel((end_mask & eorx)^bgx, dst++);
 			if (!l) { l = 8; src++; }
 		}
 		if (n) {
 			end_mask = 0;	
-			ppos = LEFT_POS(bpp);
+			ppos = LEFT_POS32(bpp);
 			for (j = n; j > 0; j--) {
 				l--;
 				if (*src & (1 << l))
@@ -282,7 +284,7 @@
 				NEXT_POS(ppos, bpp);
 				if (!l) { l = 8; src++; }
 			}
-			FB_WRITEL((end_mask & eorx)^bgx, dst++);
+			fb_writel((end_mask & eorx)^bgx, dst++);
 		}
 		l -= pad;		
 		dst1 += p->fix.line_length;	
@@ -291,30 +293,10 @@
 	
 void cfb_imageblit(struct fb_info *p, struct fb_image *image)
 {
-	int x2, y2, vxres, vyres;
 	unsigned long fgcolor, bgcolor, start_index, bitstart, pitch_index = 0;
 	unsigned long bpl = sizeof(unsigned long), bpp = p->var.bits_per_pixel;
 	u8 *dst1;
 
-	vxres = p->var.xres_virtual;
-	vyres = p->var.yres_virtual;
-	/* 
-	 * We could use hardware clipping but on many cards you get around hardware
-	 * clipping by writing to framebuffer directly like we are doing here. 
-	 */
-	if (image->dx > vxres ||
-	    image->dy > vyres)
-		return;
-
-	x2 = image->dx + image->width;
-	y2 = image->dy + image->height;
-	image->dx = image->dx > 0 ? image->dx : 0;
-	image->dy = image->dy > 0 ? image->dy : 0;
-	x2 = x2 < vxres ? x2 : vxres;
-	y2 = y2 < vyres ? y2 : vyres;
-	image->width  = x2 - image->dx;
-	image->height = y2 - image->dy;
-
 	bitstart = (image->dy * p->fix.line_length * 8) + (image->dx * bpp);
 	start_index = bitstart & (BITS_PER_LONG - 1);
 	pitch_index = (p->fix.line_length & (bpl - 1)) * 8;
@@ -337,7 +319,8 @@
 		    bpp >= 8 && bpp <= 32 && (image->width & 7) == 0) 
 			fast_imageblit(image, p, dst1, fgcolor, bgcolor);
 		else 
-			slow_imageblit(image, p, dst1, fgcolor, bgcolor, start_index, pitch_index);
+			slow_imageblit(image, p, dst1, (u32) fgcolor, (u32) bgcolor, 
+				       start_index, pitch_index);
 	}
 	else if (image->depth == bpp) 
 		color_imageblit(image, p, dst1, start_index, pitch_index);
diff -Naur linux-2.5.54/drivers/video/console/fbcon.c linux/drivers/video/console/fbcon.c
--- linux-2.5.54/drivers/video/console/fbcon.c	2003-01-09 13:52:34.000000000 +0000
+++ linux/drivers/video/console/fbcon.c	2003-01-10 02:50:37.000000000 +0000
@@ -351,6 +351,7 @@
 	struct fb_info *info = p->fb_info;
 	struct vc_data *vc = p->conp;
 	struct fb_copyarea area;
+	struct fb_region clip, s_region, d_region;
 
 	area.sx = sx * vc->vc_font.width;
 	area.sy = sy * vc->vc_font.height;
@@ -359,6 +360,33 @@
 	area.height = height * vc->vc_font.height;
 	area.width = width * vc->vc_font.width;
 
+	if (!(info->caps & FB_CAPS_CLIPPING) && 
+	    (vc->vc_cols * vc->vc_font.width > info->var.xres_virtual ||
+	     vc->vc_rows * vc->vc_font.height > info->var.yres_virtual)) {
+		clip.dx = clip.dy = 0;
+		clip.width = info->var.xres_virtual;
+		clip.height = info->var.yres_virtual;
+		
+		s_region.dx = area.sx;
+		s_region.dy = area.sy;
+		d_region.dx = area.dx;
+		d_region.dy = area.dy;
+		s_region.width = d_region.width = area.width;
+		s_region.height = d_region.height = area.height;
+
+		fb_clip_region2(&d_region, &s_region, &clip);
+
+		if (!d_region.width || !d_region.height)
+			return;
+	       
+		area.dx = d_region.dx;
+		area.dy = d_region.dy;
+		area.sx = s_region.dx;
+		area.sy = s_region.dy;
+		area.width = d_region.width;
+		area.height = d_region.height;
+	}
+
 	info->fbops->fb_copyarea(info, &area);
 }
 
@@ -367,6 +395,7 @@
 {
 	struct fb_info *info = p->fb_info;
 	struct fb_fillrect region;
+	struct fb_region clip;
 
 	region.color = attr_bgcol_ec(p, vc);
 	region.dx = sx * vc->vc_font.width;
@@ -375,9 +404,36 @@
 	region.height = height * vc->vc_font.height;
 	region.rop = ROP_COPY;
 
+	if (!(info->caps & FB_CAPS_CLIPPING) && 
+	    (vc->vc_cols * vc->vc_font.width > info->var.xres_virtual ||
+	     vc->vc_rows * vc->vc_font.height > info->var.yres_virtual)) {
+		clip.dx = clip.dy = 0;
+		clip.width = info->var.xres_virtual;
+		clip.height = info->var.yres_virtual;
+		fb_clip_region((struct fb_region *) &region, &clip);
+		if (!region.width || !region.height)
+			return;
+	}
+
 	info->fbops->fb_fillrect(info, &region);
 }	
 
+static int test_clip(struct fb_region *clip,
+		     struct fb_region *src)
+{
+	struct fb_region region =  *src;
+
+	fb_clip_region(&region, clip);
+
+	if (region.dx != src->dx ||
+	    region.dy != src->dy ||
+	    region.width != src->width ||
+	    region.height != src->height) 
+		return 1;
+
+	return 0;
+}
+
 #define FB_PIXMAPSIZE 8192
 void accel_putcs(struct vc_data *vc, struct display *p,
 			const unsigned short *s, int count, int yy, int xx)
@@ -386,7 +442,9 @@
 	unsigned short charmask = p->charmask;
 	unsigned int width = ((vc->vc_font.width + 7)/8);
 	unsigned int cellsize = vc->vc_font.height * width;
+	unsigned int do_clip = 0;
 	struct fb_image image;
+	struct fb_region clip;
 	u16 c = scr_readw(s);
 	static u8 pixmap[FB_PIXMAPSIZE];
 	
@@ -397,7 +455,26 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-	if (!(vc->vc_font.width & 7)) {
+	if (!(info->caps & FB_CAPS_CLIPPING) && 
+	    (vc->vc_cols * vc->vc_font.width > info->var.xres_virtual ||
+	     vc->vc_rows * vc->vc_font.height > info->var.yres_virtual)) {
+		clip.dx = clip.dy = 0;
+		clip.width = info->var.xres_virtual;
+		clip.height = info->var.yres_virtual;
+		do_clip = 1;
+		/* we do some cheating here... If the bitmap will
+		 * be clipped, we just pass it to the slower method
+		 * of 1 imageblit per character.
+		 */
+		if (!(vc->vc_font.width & 7)) {
+			struct fb_region *region = (struct fb_region *) &image;
+
+			image.width = count * vc->vc_font.width;
+			do_clip = (test_clip(&clip, region)) ? 2 : do_clip;
+		}
+	}
+
+	if (!(vc->vc_font.width & 7) && do_clip != 2) { 
 		unsigned int pitch, cnt, i, j, k;
 		unsigned int maxcnt = FB_PIXMAPSIZE/(vc->vc_font.height * width);
 		char *src, *dst, *dst0;
@@ -429,11 +506,14 @@
 			count -= cnt;
 		}
 	} else {
+		struct fb_region *region = (struct fb_region *) &image;
 		image.width = vc->vc_font.width;
 		while (count--) {
 			image.data = p->fontdata + 
 				(scr_readw(s++) & charmask) * 
 				vc->vc_font.height * width;
+			if (do_clip && test_clip(&clip, region))
+				return;
 			info->fbops->fb_imageblit(info, &image);
 			image.dx += vc->vc_font.width;
 		}	
@@ -450,16 +530,32 @@
 	unsigned int bh = info->var.yres % ch;
 	unsigned int rs = info->var.xres - rw;
 	unsigned int bs = info->var.yres - bh;
+	unsigned int do_clip = 0;
 	struct fb_fillrect region;
+	struct fb_region clip;
 
 	region.color = attr_bgcol_ec(p, vc);
 	region.rop = ROP_COPY;
 
+	if (!(info->caps & FB_CAPS_CLIPPING) && 
+	    (vc->vc_cols * vc->vc_font.width > info->var.xres_virtual ||
+	     vc->vc_rows * vc->vc_font.height > info->var.yres_virtual)) {
+		clip.dx = clip.dy = 0;
+		clip.width = info->var.xres_virtual;
+		clip.height = info->var.yres_virtual;
+		do_clip = 1;
+	}
+
 	if (rw & !bottom_only) {
 		region.dx = info->var.xoffset + rs;
 		region.dy = 0;
 		region.width = rw;
 		region.height = info->var.yres_virtual;
+		if (do_clip) {
+			fb_clip_region((struct fb_region *) &region, &clip);
+			if (!region.width || !region.height)
+				return;
+		}
 		info->fbops->fb_fillrect(info, &region);
 	}
 
@@ -468,6 +564,11 @@
 		region.dy = info->var.yoffset + bs;
 		region.width = rs;
 		region.height = bh;
+		if (do_clip) {
+			fb_clip_region((struct fb_region *) &region, &clip);
+			if (!region.width || !region.height)
+				return;
+		}
 		info->fbops->fb_fillrect(info, &region);
 	}	
 }	
@@ -490,6 +591,28 @@
 		cursor.set |= FB_CUR_SETSIZE;
 	}	
 
+	if (!(info->caps & FB_CAPS_CLIPPING) && 
+	    (vc->vc_cols * vc->vc_font.width > info->var.xres_virtual ||
+	     vc->vc_rows * vc->vc_font.height > info->var.yres_virtual)) {
+		struct fb_region clip, test;
+
+		clip.dx = clip.dy = 0;
+		clip.width = info->var.xres_virtual;
+		clip.height = info->var.yres_virtual;
+		test.dx = xx * width;
+		test.dy = yy * height;
+		test.width = width;
+		test.height = height;
+		
+		/*
+		 * we place cursor at screenpos(0,0) and hide it :-)
+		 */
+		if (test_clip(&clip, &test)) {
+			xx = 0; yy = 0;
+			flags &= ~FB_CUR_SETCUR;
+		}
+	}
+
 	if ((vc->vc_cursor_type & 0x0f) != shape) {
 		shape = vc->vc_cursor_type & 0x0f;
 		cursor.set |= FB_CUR_SETSHAPE;
@@ -1173,6 +1296,18 @@
 	image.depth = 1;
 	image.data = p->fontdata + (c & charmask) * vc->vc_font.height * width;
 
+	if (!(info->caps & FB_CAPS_CLIPPING) && 
+	    (vc->vc_cols * vc->vc_font.width > info->var.xres_virtual ||
+	     vc->vc_rows * vc->vc_font.height > info->var.yres_virtual)) {
+		struct fb_region clip;
+
+		clip.dx = clip.dy = 0;
+		clip.width = info->var.xres_virtual;
+		clip.height = info->var.yres_virtual;
+		if (test_clip(&clip, (struct fb_region *) &image))
+			return;
+	}
+
 	info->fbops->fb_imageblit(info, &image);
 
 	if (redraw_cursor)
@@ -1917,7 +2052,9 @@
 			conp2->vc_top = 0;
 		logo_shown = -1;
 	}
-	if (info)
+        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
+	p->vrows = info->var.yres_virtual/vc->vc_font.height;
+	if (info) 
 		info->var.yoffset = p->yscroll = 0;
 	switch (p->scrollmode & __SCROLL_YMASK) {
 	case __SCROLL_YWRAP:
@@ -1937,7 +2074,6 @@
 
 	info->currcon = unit;
 	
-        fbcon_resize(vc, vc->vc_cols, vc->vc_rows);
 	update_var(unit, info);
 	fbcon_set_palette(vc, color_table); 	
 
diff -Naur linux-2.5.54/drivers/video/fbmem.c linux/drivers/video/fbmem.c
--- linux-2.5.54/drivers/video/fbmem.c	2003-01-09 13:52:13.000000000 +0000
+++ linux/drivers/video/fbmem.c	2003-01-10 03:40:17.000000000 +0000
@@ -368,6 +368,134 @@
 #define LOGO_H		80
 #define LOGO_W		80
 
+/**
+ * fb_clip_region: software clipping
+ * @region: area to clip
+ * @clip: clipping coordinates
+ */
+void fb_clip_region(struct fb_region *region, 
+		    const struct fb_region *clip)
+{
+	u32 clipx2 = clip->dx + clip->width;
+	u32 clipy2 = clip->dy + clip->height;
+
+	if (region->dx > clipx2) {
+		region->dx = clipx2;
+		region->width = 0;
+	}
+
+	if (region->dy > clipy2) {
+		region->dy = clipy2;
+		region->height = 0;
+	}
+
+	if (region->dx < clip->dx) 
+		region->dx = clip->dx;
+
+	if (clipx2 < region->dx + region->width)
+		region->width = clipx2 - region->dx;
+
+	if (region->dy < clip->dy) 
+		region->dy = clip->dy - region->dy;
+
+	if (clipy2 < region->dy + region->height)
+		region->height = clipy2 - clip->dy;
+}
+		
+/**
+ * fb_clip_region2: software clipping
+ * @d_region: dst area to clip
+ * @s_region: src area to clip
+ * @clip: clipping coordinates
+ */
+void fb_clip_region2(struct fb_region *d_region,
+		     struct fb_region *s_region,
+		     const struct fb_region *clip)
+{
+	u32 clipx2 = clip->dx + clip->width;
+	u32 clipy2 = clip->dy + clip->height;
+	u32 dx2, dy2, sx2, sy2;
+
+	if (d_region->dx > clipx2) {
+		d_region->dx = clipx2;
+		d_region->width = 0;
+	}
+
+	if (d_region->dy > clipy2) {
+		d_region->dy = clipy2;
+		d_region->height = 0;
+	}
+
+	if (s_region->dx > clipx2) {
+		s_region->dx = clipx2;
+		s_region->width = 0;
+	}
+
+	if (s_region->dy > clipy2) {
+		s_region->dy = clipy2;
+		s_region->height = 0;
+	}
+
+	/* clip source, against destination */
+	if (d_region->dx < clip->dx) {
+		dx2 = d_region->dx + d_region->width;
+		s_region->width = (clip->width < dx2 - clip->dx) ?
+			clip->width : dx2 - clip->dx;
+		s_region->dx += clip->dx - d_region->dx;
+		d_region->dx = clip->dx;
+	}
+
+	dx2 = d_region->dx + s_region->width;
+	if (clipx2 < dx2) 
+		s_region->width = clipx2 - d_region->dx;
+
+	d_region->width = s_region->width;
+
+	if (d_region->dy < clip->dy) {
+		dy2 = d_region->dy + d_region->height;
+		s_region->height = (clip->height < dy2 - clip->dy) ?
+			clip->height : dy2 - clip->dy;
+		s_region->dy += clip->dy - d_region->dy;
+		d_region->dy = clip->dy;
+	}
+
+	dy2 = d_region->dy + s_region->height;
+	if (clipy2 < dy2) 
+		s_region->height = clipx2 - d_region->dy;
+
+	d_region->height = s_region->height;
+
+	/* not guaranteed that source is within bounds, so... */
+	/* clip destination, against source */
+	if (s_region->dx < clip->dx) {
+		sx2 = s_region->dx + s_region->width;
+		d_region->width = (clip->width < sx2 - clip->dx) ?
+			clip->width : sx2 - clip->dx;
+		d_region->dx += clip->dx - s_region->dx;
+		s_region->dx = clip->dx;
+	}
+
+	sx2 = s_region->dx + d_region->width;
+	if (clipx2 < sx2) 
+		d_region->width = clipx2 - s_region->dx;
+
+	s_region->width = d_region->width;
+
+	if (s_region->dy < clip->dy) {
+		sy2 = s_region->dy + s_region->height;
+		d_region->height = (clip->height < sy2 - clip->dy) ?
+			clip->height : sy2 - clip->dy;
+		d_region->dy += clip->dy - s_region->dy;
+		s_region->dy = clip->dy;
+	}
+
+	sy2 = s_region->dy + d_region->height;
+	if (clipy2 < sy2) 
+		d_region->height = clipx2 - s_region->dy;
+
+	s_region->height = d_region->height;
+}
+
 static inline unsigned safe_shift(unsigned d, int n)
 {
 	return n < 0 ? d >> -n : d << n;
@@ -1189,5 +1317,7 @@
 EXPORT_SYMBOL(fb_set_var);
 EXPORT_SYMBOL(fb_blank);
 EXPORT_SYMBOL(fb_pan_display);
+EXPORT_SYMBOL(fb_clip_region);
+EXPORT_SYMBOL(fb_clip_region2);
 
 MODULE_LICENSE("GPL");
diff -Naur linux-2.5.54/include/linux/fb.h linux/include/linux/fb.h
--- linux-2.5.54/include/linux/fb.h	2003-01-09 13:52:49.000000000 +0000
+++ linux/include/linux/fb.h	2003-01-09 13:51:41.000000000 +0000
@@ -173,6 +173,9 @@
 #define FB_VMODE_SMOOTH_XPAN	512	/* smooth xpan possible (internally used) */
 #define FB_VMODE_CONUPDATE	512	/* don't update x/yoffset	*/
 
+/* Driver Capability */
+#define FB_CAPS_CLIPPING        1       /* hardware can do clipping */
+
 #define PICOS2KHZ(a) (1000000000UL/(a))
 #define KHZ2PICOS(a) (1000000000UL/(a))
 
@@ -394,6 +397,7 @@
    void *pseudo_palette;                /* Fake palette of 16 colors and 
 					   the cursor's color for non
                                            palette mode */
+   int caps;                            /* Driver capability, see FB_CAPS_* */
    /* From here on everything is device dependent */
    void *par;	
 };
@@ -461,6 +465,11 @@
 extern int register_framebuffer(struct fb_info *fb_info);
 extern int unregister_framebuffer(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
+extern void fb_clip_region(struct fb_region *region, 
+			   const struct fb_region *clip);
+extern void fb_clip_region2(struct fb_region *s_region,
+			    struct fb_region *d_region,
+			    const struct fb_region *clip);
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
