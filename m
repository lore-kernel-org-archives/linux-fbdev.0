From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/9][FBCON]: Support for bold attribute for monochrome framebuffers
Date: Sat, 21 Aug 2004 21:33:21 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408212046.39914.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ByW19-0008FU-21
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:47 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1ByW18-0005Ip-87
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 21 Aug 2004 06:34:46 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 44B7F725E7
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 21 Aug 2004 13:34:34 +0000 (UTC)
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

This patch adds support for the bold attribute for monochrome framebuffers.
This fixes a regression from 2.4 where bold, underline and reverse attributes
are supported.

Tony

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/console/fbcon.c |  121 ++++++++++++++++++++++++++----------------
 drivers/video/console/fbcon.h |    4 -
 drivers/video/fbmem.c         |    3 -
 include/linux/fb.h            |    4 -
 4 files changed, 83 insertions(+), 49 deletions(-)

diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/console/fbcon.c linux-2.6.8.1-mm3/drivers/video/console/fbcon.c
--- linux-2.6.8.1-mm3-orig/drivers/video/console/fbcon.c	2004-08-21 18:49:20.410454904 +0800
+++ linux-2.6.8.1-mm3/drivers/video/console/fbcon.c	2004-08-21 18:49:33.721431328 +0800
@@ -408,7 +408,6 @@ int set_con2fb_map(int unit, int newidx)
 static inline int get_color(struct vc_data *vc, struct fb_info *info,
 			    u16 c, int is_fg)
 {
-	struct display *p = &fb_display[fg_console];
 	int depth = fb_get_color_depth(info);
 	int color = 0;
 
@@ -422,9 +421,8 @@ static inline int get_color(struct vc_da
 		/* 0 or 1 */
 		int fg = (info->fix.visual != FB_VISUAL_MONO01) ? 1 : 0;
 		int bg = (info->fix.visual != FB_VISUAL_MONO01) ? 0 : 1;
-		int reverse = attr_reverse(c, p->inverse);
 
-		color = (is_fg) ? (reverse) ? bg : fg : (reverse) ? fg : bg;
+		color = (is_fg) ? fg : bg;
 		break;
 	}
 	case 2:
@@ -447,15 +445,47 @@ static inline int get_color(struct vc_da
 	return color;
 }
 
-static inline int is_underline(struct fb_info *info, u16 c)
+#define FBCON_ATTRIBUTE_UNDERLINE 1
+#define FBCON_ATTRIBUTE_REVERSE   2
+#define FBCON_ATTRIBUTE_BOLD      4
+
+static inline int get_attribute(struct fb_info *info, u16 c)
 {
-	int underline = 0;
+	int attribute = 0;
+	
+	if (fb_get_color_depth(info) == 1) {
+		if (attr_underline(c))
+			attribute |= FBCON_ATTRIBUTE_UNDERLINE;
+		if (attr_reverse(c))
+			attribute |= FBCON_ATTRIBUTE_REVERSE;
+		if (attr_bold(c))
+			attribute |= FBCON_ATTRIBUTE_BOLD;
+	}
 
-	if (fb_get_color_depth(info) == 1)
-		underline = attr_underline(c);
-	return underline;
+	return attribute;
 }
 
+static inline void update_attr(u8 *dst, u8 *src, int attribute,
+			       struct vc_data *vc)
+{
+	int i, offset = (vc->vc_font.height < 10) ? 1 : 2;
+	int width = (vc->vc_font.width + 7) >> 3;
+	unsigned int cellsize = vc->vc_font.height * width;
+	u8 c;
+	
+	offset = cellsize - (offset * width);
+	for (i = 0; i < cellsize; i++) {
+		c = src[i];
+		if (attribute & FBCON_ATTRIBUTE_UNDERLINE && i >= offset)
+			c = 0xff;
+		if (attribute & FBCON_ATTRIBUTE_BOLD)
+			c |= c >> 1;
+		if (attribute & FBCON_ATTRIBUTE_REVERSE)
+			c = ~c;
+		dst[i] = c;
+	}
+}
+	
 void accel_bmove(struct vc_data *vc, struct fb_info *info, int sy, 
 		int sx, int dy, int dx, int height, int width)
 {
@@ -506,11 +536,11 @@ void accel_putcs(struct vc_data *vc, str
 	unsigned int shift_low = 0, mod = vc->vc_font.width % 8;
 	unsigned int shift_high = 8, pitch, cnt, size, k;
 	unsigned int idx = vc->vc_font.width >> 3;
-	unsigned int underline = is_underline(info, scr_readw(s));
+	unsigned int attribute = get_attribute(info, scr_readw(s));
 	struct fb_image image;
 	u8 *src, *dst, *buf = NULL;
 
-	if (underline) {
+	if (attribute) {
 		buf = kmalloc(cellsize, GFP_KERNEL);
 		if (!buf)
 			return;
@@ -549,17 +579,14 @@ void accel_putcs(struct vc_data *vc, str
 				src = vc->vc_font.data + (scr_readw(s++)&
 							  charmask)*cellsize;
 
-				if (underline) {
-					int offset = (vc->vc_font.height < 10) ? 1 : 2;
-
-					memcpy(buf, src, cellsize);
-					memset(buf + cellsize - offset, 0xff,
-					       offset * width);
+				if (attribute) {
+					update_attr(buf, src, attribute, vc);
 					src = buf;
 				}
+
 				move_unaligned(info, &info->pixmap, dst, pitch,
-						       src, idx, image.height,
-						       shift_high, shift_low, mod);
+					       src, idx, image.height,
+					       shift_high, shift_low, mod);
 				shift_low += mod;
 				dst += (shift_low >= 8) ? width : width - 1;
 				shift_low &= 7;
@@ -569,16 +596,14 @@ void accel_putcs(struct vc_data *vc, str
 			while (k--) {
 				src = vc->vc_font.data + (scr_readw(s++)&
 							  charmask)*cellsize;
-				if (underline) {
-					int offset = (vc->vc_font.height < 10) ? 1 : 2;
 
-					memcpy(buf, src, cellsize);
-					memset(buf + cellsize - offset, 0xff,
-					       offset * width);
+				if (attribute) {
+					update_attr(buf, src, attribute, vc);
 					src = buf;
 				}
+
 				move_aligned(info, &info->pixmap, dst, pitch,
-						     src, idx, image.height);
+					     src, idx, image.height);
 				dst += width;
 			}
 		}
@@ -586,7 +611,9 @@ void accel_putcs(struct vc_data *vc, str
 		image.dx += cnt * vc->vc_font.width;
 		count -= cnt;
 	}
-	kfree(buf);
+	
+	if (buf)
+		kfree(buf);
 }
 
 void accel_clear_margins(struct vc_data *vc, struct fb_info *info,
@@ -1074,14 +1101,15 @@ static void fbcon_putc(struct vc_data *v
 
 static void fbcon_cursor(struct vc_data *vc, int mode)
 {
+	struct fb_cursor cursor;
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	struct display *p = &fb_display[vc->vc_num];
 	int w = (vc->vc_font.width + 7) >> 3, c;
 	int y = real_y(p, vc->vc_y), fg, bg;
-	int underline;
-	struct fb_cursor cursor;
-	
+	int attribute;
+	u8 *src;
+
 	if (mode & CM_SOFTBACK) {
 		mode &= ~CM_SOFTBACK;
 		if (softback_lines) {
@@ -1094,8 +1122,22 @@ static void fbcon_cursor(struct vc_data 
 		fbcon_set_origin(vc);
 
  	c = scr_readw((u16 *) vc->vc_pos);
-	underline = is_underline(info, c);
-	cursor.image.data = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
+	attribute = get_attribute(info, c);
+	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
+	if (attribute) {
+		u8 *dst;
+		
+		dst = kmalloc(w * vc->vc_font.height, GFP_ATOMIC);
+		if (!dst)
+			return;
+		if (info->cursor.data)
+			kfree(info->cursor.data);
+		info->cursor.data = dst;
+		update_attr(dst, src, attribute, vc);
+		src = dst;
+	}
+
+	cursor.image.data = src;
 	cursor.set = FB_CUR_SETCUR;
 	cursor.image.depth = 1;
 	
@@ -1139,24 +1181,19 @@ static void fbcon_cursor(struct vc_data 
 			cursor.set |= FB_CUR_SETHOT;
 		}
 
-		if ((cursor.set & FB_CUR_SETSIZE) || ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)
-		    || info->cursor.mask == NULL || info->cursor.ul != attr_underline(c) ||
-		    info->cursor.rev != attr_reverse(c, p->inverse)) {
+		if ((cursor.set & FB_CUR_SETSIZE) ||
+		    ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)
+		    || info->cursor.mask == NULL) {
 			char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
 			int cur_height, size, i = 0;
 			u8 msk = 0xff;
 
-			if (!mask)	return;	
+			if (!mask)
+				return;	
 		
 			if (info->cursor.mask)
 				kfree(info->cursor.mask);
 			info->cursor.mask = mask;
-	
-			info->cursor.ul = attr_underline(c);
-			info->cursor.rev = attr_reverse(c, p->inverse);
-
-			if (info->cursor.rev)
-				msk = 0;
 			p->cursor_shape = vc->vc_cursor_type & 0x0f;
 			cursor.set |= FB_CUR_SETSHAPE;
 
@@ -1185,10 +1222,6 @@ static void fbcon_cursor(struct vc_data 
 			while (size--)
 				mask[i++] = ~msk;
 			size = cur_height * w;
-			if (info->cursor.ul)
-				msk = ~msk;
-			if (info->cursor.ul)
-				msk = ~msk;
 			while (size--)
 				mask[i++] = msk;
 		}
diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/console/fbcon.h linux-2.6.8.1-mm3/drivers/video/console/fbcon.h
--- linux-2.6.8.1-mm3-orig/drivers/video/console/fbcon.h	2004-08-21 18:26:53.000000000 +0800
+++ linux-2.6.8.1-mm3/drivers/video/console/fbcon.h	2004-08-21 18:49:33.724430872 +0800
@@ -69,8 +69,8 @@ extern int set_con2fb_map(int unit, int 
 /* Monochrome */
 #define attr_bold(s) \
 	((s) & 0x200)
-#define attr_reverse(s, inverse) \
-	(((s) & 0x800) ^ (inverse ? 0x800 : 0))
+#define attr_reverse(s) \
+	((s) & 0x800)
 #define attr_underline(s) \
 	((s) & 0x400)
 #define attr_blink(s) \
diff -uprN linux-2.6.8.1-mm3-orig/drivers/video/fbmem.c linux-2.6.8.1-mm3/drivers/video/fbmem.c
--- linux-2.6.8.1-mm3-orig/drivers/video/fbmem.c	2004-08-21 18:49:20.413454448 +0800
+++ linux-2.6.8.1-mm3/drivers/video/fbmem.c	2004-08-21 18:49:33.726430568 +0800
@@ -981,13 +981,14 @@ fb_cursor(struct fb_info *info, struct f
 	if (copy_from_user(&cursor_user, sprite, sizeof(struct fb_cursor_user)))
 		return -EFAULT;
 
-	memcpy(&cursor, &cursor_user, sizeof(cursor));
+	memcpy(&cursor, &cursor_user, sizeof(cursor_user));
 	cursor.mask = NULL;
 	cursor.image.data = NULL;
 	cursor.image.cmap.red = NULL;
 	cursor.image.cmap.green = NULL;
 	cursor.image.cmap.blue = NULL;
 	cursor.image.cmap.transp = NULL;
+	cursor.data = NULL;
 
 	if (cursor.set & FB_CUR_SETCUR)
 		info->cursor.enable = 1;
diff -uprN linux-2.6.8.1-mm3-orig/include/linux/fb.h linux-2.6.8.1-mm3/include/linux/fb.h
--- linux-2.6.8.1-mm3-orig/include/linux/fb.h	2004-08-21 18:35:43.440653192 +0800
+++ linux-2.6.8.1-mm3/include/linux/fb.h	2004-08-21 18:49:33.728430264 +0800
@@ -383,11 +383,11 @@ struct fb_cursor {
 	__u16 set;		/* what to set */
 	__u16 enable;		/* cursor on/off */
 	__u16 rop;		/* bitop operation */
-	__u16 ul;               /* underlined? */
-	__u16 rev;              /* reversed? */
 	const char *mask;	/* cursor mask bits */
 	struct fbcurpos hot;	/* cursor hot spot */
 	struct fb_image	image;	/* Cursor image */
+/* all fields below are for fbcon use only */
+	char  *data;             /* copy of bitmap */
 };
 
 #ifdef __KERNEL__




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
