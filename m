From: James Simmons <jsimmons@infradead.org>
Subject: character drawing enhancement.
Date: Fri, 12 Mar 2004 23:46:56 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403122337170.20833-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0403111819060.5794-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B1wMs-0005yv-Rf
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Mar 2004 15:47:06 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1B1wMo-0006zX-OX
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 12 Mar 2004 15:47:03 -0800
In-Reply-To: <Pine.LNX.4.44.0403111819060.5794-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


This patch merges two of the drawing functions. The patch uses aligned 
transfers when possible even on displays where the characters are not byte 
align. Tested on my my laptop for 12 bit width fonts and 8 bit wide fonts. 
It works very nicely. Please apply to your tree for wider testing.

--- linus-2.6/drivers/video/console/fbcon.c	2004-03-10 13:13:16.000000000 -0800
+++ fbdev-2.5/drivers/video/console/fbcon.c	2004-03-10 13:32:10.000000000 -0800
@@ -309,94 +309,6 @@
 }
 
 /*
- * drawing helpers
- */
-static void putcs_unaligned(struct vc_data *vc, struct fb_info *info,
-			    struct fb_image *image, int count,
-			    const unsigned short *s)
-{
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width = (vc->vc_font.width + 7) >> 3;
-	unsigned int cellsize = vc->vc_font.height * width;
-	unsigned int maxcnt = info->pixmap.size/cellsize;
-	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
-	unsigned int shift_high = 8, size, pitch, cnt, k;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int idx = vc->vc_font.width >> 3;
-	u8 *src, *dst, *dst0;
-
-	while (count) {
-		if (count > maxcnt)
-			cnt = k = maxcnt;
-		else
-			cnt = k = count;
-
-		image->width = vc->vc_font.width * cnt;
-		pitch = ((image->width + 7) >> 3) + scan_align;
-		pitch &= ~scan_align;
-		size = pitch * vc->vc_font.height + buf_align;
-		size &= ~buf_align;
-		dst0 = fb_get_buffer_offset(info, &info->pixmap, size);
-		image->data = dst0;
-		while (k--) {
-			src = vc->vc_font.data + (scr_readw(s++) & charmask)*
-			cellsize;
-			dst = dst0;
-			fb_move_buf_unaligned(info, &info->pixmap, dst, pitch, src,
-						idx, image->height, shift_high,
-						shift_low, mod);
-			shift_low += mod;
-			dst0 += (shift_low >= 8) ? width : width - 1;
-			shift_low &= 7;
-			shift_high = 8 - shift_low;
-		}
-		info->fbops->fb_imageblit(info, image);
-		image->dx += cnt * vc->vc_font.width;
-		count -= cnt;
-	}
-}
-
-static void putcs_aligned(struct vc_data *vc, struct fb_info *info,
-			  struct fb_image *image, int count,
-			  const unsigned short *s)
-{
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width = vc->vc_font.width >> 3;
-	unsigned int cellsize = vc->vc_font.height * width;
-	unsigned int maxcnt = info->pixmap.size/cellsize;
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
-	unsigned int pitch, cnt, size, k;
-	u8 *src, *dst, *dst0;
-
-	while (count) {
-		if (count > maxcnt)
-			cnt = k = maxcnt;
-		else
-			cnt = k = count;
-		
-		pitch = width * cnt + scan_align;
-		pitch &= ~scan_align;
-		size = pitch * vc->vc_font.height + buf_align;
-		size &= ~buf_align;
-		image->width = vc->vc_font.width * cnt;
-		dst0 = fb_get_buffer_offset(info, &info->pixmap, size);
-		image->data = dst0;
-		while (k--) {
-			src = vc->vc_font.data + (scr_readw(s++)&charmask)*cellsize;
-			dst = dst0;
-			fb_move_buf_aligned(info, &info->pixmap, dst, pitch, src,
-						width, image->height);
-			dst0 += width;
-		}
-		info->fbops->fb_imageblit(info, image);
-		image->dx += cnt * vc->vc_font.width;
-		count -= cnt;
-	}
-}
-
-/*
  * Accelerated handlers.
  */
 void accel_bmove(struct vc_data *vc, struct fb_info *info, int sy, 
@@ -430,49 +342,24 @@
 	info->fbops->fb_fillrect(info, &region);
 }	
 
-static void accel_putc(struct vc_data *vc, struct fb_info *info,
-                      int c, int ypos, int xpos)
+void accel_putcs(struct vc_data *vc, struct fb_info *info,
+			const unsigned short *s, int count, int yy, int xx)
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int width = (vc->vc_font.width + 7) >> 3;
+	unsigned int cellsize = vc->vc_font.height * width;
+	unsigned int maxcnt = info->pixmap.size/cellsize;
 	unsigned int scan_align = info->pixmap.scan_align - 1;
 	unsigned int buf_align = info->pixmap.buf_align - 1;
+	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
+	unsigned int shift_high = 8, pitch, cnt, size, k;
 	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
 	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
-	unsigned int size, pitch;
-	struct fb_image image;
-	u8 *src, *dst;
-
-	image.dx = xpos * vc->vc_font.width;
-	image.dy = ypos * vc->vc_font.height;
-	image.width = vc->vc_font.width;
-	image.height = vc->vc_font.height;
-	image.fg_color = attr_fgcol(fgshift, c);
-	image.bg_color = attr_bgcol(bgshift, c);
-	image.depth = 1;
-
-	pitch = width + scan_align;
-	pitch &= ~scan_align;
-	size = pitch * vc->vc_font.height;
-	size += buf_align;
-	size &= ~buf_align;
-	dst = fb_get_buffer_offset(info, &info->pixmap, size);
-	image.data = dst;
-	src = vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
-
-	fb_move_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
-
-	info->fbops->fb_imageblit(info, &image);
-}
-
-void accel_putcs(struct vc_data *vc, struct fb_info *info,
-			const unsigned short *s, int count, int yy, int xx)
-{
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
+	unsigned int idx = vc->vc_font.width >> 3;
 	struct fb_image image;
 	u16 c = scr_readw(s);
-
+	u8 *src, *dst, *dst0;
+	
 	image.fg_color = attr_fgcol(fgshift, c);
 	image.bg_color = attr_bgcol(bgshift, c);
 	image.dx = xx * vc->vc_font.width;
@@ -480,10 +367,41 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-	if (!(vc->vc_font.width & 7))
-               putcs_aligned(vc, info, &image, count, s);
-        else
-               putcs_unaligned(vc, info, &image, count, s);
+	while (count) {
+		if (count > maxcnt)
+			cnt = k = maxcnt;
+		else
+			cnt = k = count;
+
+		image.width = vc->vc_font.width * cnt;
+		pitch = ((image.width + 7) >> 3) + scan_align;
+		pitch &= ~scan_align;
+		size = pitch * image.height + buf_align;
+		size &= ~buf_align;
+		dst0 = fb_get_buffer_offset(info, &info->pixmap, size);
+		image.data = dst0;
+		while (k--) {
+			src = vc->vc_font.data + (scr_readw(s++) & charmask)*cellsize;
+			dst = dst0;
+		
+			if (mod) {
+				fb_move_buf_unaligned(info, &info->pixmap, dst, pitch,
+						   src, idx, image.height, shift_high, 
+						   shift_low, mod);
+				shift_low += mod;
+				dst0 += (shift_low >= 8) ? width : width - 1;
+				shift_low &= 7;
+				shift_high = 8 - shift_low;
+			} else {
+				fb_move_buf_aligned(info, &info->pixmap, dst, pitch, 
+						 src, idx, image.height);
+				dst0 += width;
+			}	
+		}
+		info->fbops->fb_imageblit(info, &image);
+		image.dx += cnt * vc->vc_font.width;
+		count -= cnt;
+	}
 }
 
 void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
@@ -724,15 +642,13 @@
 static void fbcon_set_display(struct vc_data *vc, int init, int logo)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	int nr_rows, nr_cols, old_rows, old_cols, i, charcnt = 256;
 	struct display *p = &fb_display[vc->vc_num];
-	int nr_rows, nr_cols;
-	int old_rows, old_cols;
 	unsigned short *save = NULL, *r, *q;
-	int i, charcnt = 256;
 	struct font_desc *font;
 
 	if (vc->vc_num != fg_console || (info->flags & FBINFO_FLAG_MODULE) ||
-	    info->fix.type == FB_TYPE_TEXT)
+	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;
 
 	info->var.xoffset = info->var.yoffset = p->yscroll = 0;	/* reset wrap/pan */
@@ -958,12 +873,20 @@
 		accel_clear(vc, info, real_y(p, sy), sx, height, width);
 }
 
-
 static void fbcon_putc(struct vc_data *vc, int c, int ypos, int xpos)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	unsigned int scan_align = info->pixmap.scan_align - 1;
+	unsigned int buf_align = info->pixmap.buf_align - 1;
+	unsigned int width = (vc->vc_font.width + 7) >> 3;
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
+	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
 	struct display *p = &fb_display[vc->vc_num];
-
+	unsigned int size, pitch;
+	struct fb_image image;
+	u8 *src, *dst;
+	
 	if (!info->fbops->fb_blank && console_blanked)
 		return;
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -972,7 +895,28 @@
 	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
 		return;
 
-	accel_putc(vc, info, c, real_y(p, ypos), xpos);
+	image.dx = xpos * vc->vc_font.width;
+	image.dy = real_y(p, ypos) * vc->vc_font.height;
+	image.width = vc->vc_font.width;
+	image.height = vc->vc_font.height;
+	image.fg_color = attr_fgcol(fgshift, c);
+	image.bg_color = attr_bgcol(bgshift, c);
+	image.depth = 1;
+
+	src = vc->vc_font.data + (c & charmask) * vc->vc_font.height * width;
+
+	pitch = width + scan_align;
+	pitch &= ~scan_align;
+	size = pitch * vc->vc_font.height;
+	size += buf_align;
+	size &= ~buf_align;
+
+	dst = fb_get_buffer_offset(info, &info->pixmap, size);
+	image.data = dst;
+	
+	fb_move_buf_aligned(info, &info->pixmap, dst, pitch, src, width, image.height);
+
+	info->fbops->fb_imageblit(info, &image);
 }
 
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
 




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
