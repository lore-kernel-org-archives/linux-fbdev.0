From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/10] fbcon: Break up bit_putcs into its component functions
Date: Fri, 02 Sep 2005 05:42:34 +0800
Message-ID: <431775CA.4020509@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAx2k-0004lr-QN
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:22 -0700
Received: from wproxy.gmail.com ([64.233.184.207])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EAx2k-0003wE-3I
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 01 Sep 2005 14:56:23 -0700
Received: by wproxy.gmail.com with SMTP id i3so393080wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 01 Sep 2005 14:56:16 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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

    The function bit_putcs() in drivers/video/console/bitblit.c is becoming
    large.  Break it up into its component functions (bit_putcs_unaligned and
    bit_putcs_aligned).
    
    Incorporated fb_pad_aligned_buffer() optimization by Roman Zippel.
    
    Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 drivers/video/console/bitblit.c |  154 ++++++++++++++++++++++++----------------
 drivers/video/fbmem.c           |   10 --
 include/linux/fb.h              |   15 +++
 3 files changed, 112 insertions(+), 67 deletions(-)


diff --git a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c
+++ b/drivers/video/console/bitblit.c
@@ -103,42 +103,106 @@ static void bit_clear(struct vc_data *vc
 	info->fbops->fb_fillrect(info, &region);
 }
 
+static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
+				     const u16 *s, u32 count, u32 yy, u32 xx,
+				     u32 attr, u32 cnt, u32 d_pitch,
+				     u32 s_pitch, u32 cellsize,
+				     struct fb_image *image, u8 *buf, u8 *dst)
+{
+	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	u32 idx = vc->vc_font.width >> 3;
+	u8 *src;
+
+	while (cnt--) {
+		src = vc->vc_font.data + (scr_readw(s++)&
+					  charmask)*cellsize;
+		
+		if (attr) {
+			update_attr(buf, src, attr, vc);
+			src = buf;
+		}
+		
+		if (likely(idx == 1))
+			__fb_pad_aligned_buffer(dst, d_pitch, src, idx,
+						image->height);
+		else
+			fb_pad_aligned_buffer(dst, d_pitch, src, idx,
+					      image->height);
+
+		dst += s_pitch;
+	}
+	
+	info->fbops->fb_imageblit(info, image);
+}
+
+static inline void bit_putcs_unaligned(struct vc_data *vc,
+				       struct fb_info *info,
+				       const u16 *s, u32 count, u32 yy, u32 xx,
+				       u32 attr, u32 cnt, u32 d_pitch,
+				       u32 s_pitch, u32 cellsize,
+				       struct fb_image *image, u8 *buf,
+				       u8 *dst)
+{
+	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	u32 shift_low = 0, mod = vc->vc_font.width % 8;
+	u32 shift_high = 8;
+	u32 idx = vc->vc_font.width >> 3;
+	u8 *src;
+
+	while (cnt--) {
+		src = vc->vc_font.data + (scr_readw(s++)&
+					  charmask)*cellsize;
+		
+		if (attr) {
+			update_attr(buf, src, attr, vc);
+			src = buf;
+		}
+			
+		fb_pad_unaligned_buffer(dst, d_pitch, src, idx,
+					image->height, shift_high,
+					shift_low, mod);
+		shift_low += mod;
+		dst += (shift_low >= 8) ? s_pitch : s_pitch - 1;
+		shift_low &= 7;
+		shift_high = 8 - shift_low;
+	}
+
+	info->fbops->fb_imageblit(info, image);
+
+}
+
 static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg)
 {
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int width = (vc->vc_font.width + 7) >> 3;
-	unsigned int cellsize = vc->vc_font.height * width;
-	unsigned int maxcnt = info->pixmap.size/cellsize;
-	unsigned int scan_align = info->pixmap.scan_align - 1;
-	unsigned int buf_align = info->pixmap.buf_align - 1;
-	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
-	unsigned int shift_high = 8, pitch, cnt, size, i, k;
-	unsigned int idx = vc->vc_font.width >> 3;
-	unsigned int attribute = get_attribute(info, scr_readw(s));
 	struct fb_image image;
-	u8 *src, *dst, *buf = NULL;
-
-	if (attribute) {
-		buf = kmalloc(cellsize, GFP_KERNEL);
-		if (!buf)
-			return;
-	}
+	u32 width = (vc->vc_font.width + 7)/8;
+	u32 cellsize = width * vc->vc_font.height;
+	u32 maxcnt = info->pixmap.size/cellsize;
+	u32 scan_align = info->pixmap.scan_align - 1;
+	u32 buf_align = info->pixmap.buf_align - 1;
+	u32 mod = vc->vc_font.width % 8, cnt, pitch, size;
+	u32 attribute = get_attribute(info, scr_readw(s));
+	u8 *dst, *buf = NULL;
 
 	image.fg_color = fg;
 	image.bg_color = bg;
-
 	image.dx = xx * vc->vc_font.width;
 	image.dy = yy * vc->vc_font.height;
 	image.height = vc->vc_font.height;
 	image.depth = 1;
+	
+	if (attribute) {
+		buf = kmalloc(cellsize, GFP_KERNEL);
+		if (!buf)
+			return;
+	}
 
 	while (count) {
 		if (count > maxcnt)
-			cnt = k = maxcnt;
+			cnt = maxcnt;
 		else
-			cnt = k = count;
+			cnt = count;
 
 		image.width = vc->vc_font.width * cnt;
 		pitch = ((image.width + 7) >> 3) + scan_align;
@@ -147,43 +211,16 @@ static void bit_putcs(struct vc_data *vc
 		size &= ~buf_align;
 		dst = fb_get_buffer_offset(info, &info->pixmap, size);
 		image.data = dst;
-		if (mod) {
-			while (k--) {
-				src = vc->vc_font.data + (scr_readw(s++)&
-							  charmask)*cellsize;
-
-				if (attribute) {
-					update_attr(buf, src, attribute, vc);
-					src = buf;
-				}
-
-				fb_pad_unaligned_buffer(dst, pitch, src, idx,
-						image.height, shift_high,
-						shift_low, mod);
-				shift_low += mod;
-				dst += (shift_low >= 8) ? width : width - 1;
-				shift_low &= 7;
-				shift_high = 8 - shift_low;
-			}
-		} else {
-			while (k--) {
-				src = vc->vc_font.data + (scr_readw(s++)&
-							  charmask)*cellsize;
-
-				if (attribute) {
-					update_attr(buf, src, attribute, vc);
-					src = buf;
-				}
-
-				if (idx == 1)
-					for(i=0; i < image.height; i++)
-						dst[pitch*i] = src[i];
-				else
-					fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
-				dst += width;
-			}
-		}
-		info->fbops->fb_imageblit(info, &image);
+
+		if (!mod)
+			bit_putcs_aligned(vc, info, s, count, yy, xx,
+					  attribute, cnt, pitch, width,
+					  cellsize, &image, buf, dst);
+		else
+			bit_putcs_unaligned(vc, info, s, count, yy, xx,
+					    attribute, cnt, pitch, width,
+					    cellsize, &image, buf, dst);
+
 		image.dx += cnt * vc->vc_font.width;
 		count -= cnt;
 	}
@@ -193,8 +230,9 @@ static void bit_putcs(struct vc_data *vc
 	   NULL pointers just fine */
 	if (unlikely(buf))
 		kfree(buf);
-}
 
+}
+	
 static void bit_clear_margins(struct vc_data *vc, struct fb_info *info,
 			      int bottom_only)
 {
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -90,15 +90,7 @@ EXPORT_SYMBOL(fb_get_color_depth);
  */
 void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
 {
-	int i, j;
-
-	for (i = height; i--; ) {
-		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
-		for (j = 0; j < s_pitch; j++)
-			dst[j] = src[j];
-		src += s_pitch;
-		dst += d_pitch;
-	}
+	__fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, height);
 }
 EXPORT_SYMBOL(fb_pad_aligned_buffer);
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -833,6 +833,21 @@ extern int fb_new_modelist(struct fb_inf
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 
+static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
+					   u8 *src, u32 s_pitch, u32 height) 
+{
+	int i, j;
+	
+	d_pitch -= s_pitch;
+	
+	for (i = height; i--; ) {
+		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
+		for (j = 0; j < s_pitch; j++)
+			*dst++ = *src++;
+		dst += d_pitch;
+	}
+}
+
 /* drivers/video/fbsysfs.c */
 extern struct fb_info *framebuffer_alloc(size_t size, struct device *dev);
 extern void framebuffer_release(struct fb_info *info);



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
