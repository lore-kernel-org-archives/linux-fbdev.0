From: Chris Heath <chris@heathens.co.nz>
Subject: [PATCH] Fix cursor + selection
Date: Mon, 01 Sep 2003 21:40:10 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030901212952.0949.CHRIS@heathens.co.nz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19u0AS-0002eV-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 01 Sep 2003 18:41:12 -0700
Received: from rwcrmhc12.comcast.net ([216.148.227.85])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19u0AP-0000is-Mq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 01 Sep 2003 18:41:09 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Chris Heath <chris@heathens.co.nz>

I noticed that the framebuffer console overwrites the mouse pointer and
selected text when the cursor flashes.

The attached patch fixes that.  It is rather long, but basically all
I've done is moved a huge chunk of code from fbcon_cursor into a helper
function, and called that helper from fbcon_putc and fbcon_putcs.

The patch is against James's latest fbdev patch that he posted to
linux-kernel.

Chris



--- linux-2.6.0-test4-fbdev/drivers/video/console/fbcon.c	2003-09-01 20:13:17.000000000 -0400
+++ linux-2.6.0-test4-cdh1/drivers/video/console/fbcon.c	2003-09-01 19:55:07.000000000 -0400
@@ -811,6 +811,116 @@
 	}
 }
 
+static void update_cursor(struct vc_data *vc, struct fb_info *info, int c)
+{
+	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
+	unsigned int scan_align = info->sprite.scan_align - 1;
+	unsigned int buf_align = info->sprite.buf_align - 1;
+	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
+	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
+	struct display *p = &fb_display[vc->vc_num];
+	int y = real_y(p, vc->vc_y), d_pitch, dsize;
+	int s_pitch = (vc->vc_font.width + 7) >> 3;
+	int size = s_pitch * vc->vc_font.height;
+	struct fb_cursor cursor;
+	u8 *src, *dst;
+
+	memset(&cursor, 0, sizeof(struct fb_cursor));
+	if (info->cursor.image.fg_color != attr_fgcol(fgshift, c) ||
+    	    info->cursor.image.bg_color != attr_bgcol(bgshift, c)) {
+		cursor.image.fg_color = attr_fgcol(fgshift, c);
+		cursor.image.bg_color = attr_bgcol(bgshift, c);
+		cursor.image.depth = 1;
+		cursor.set |= FB_CUR_SETCMAP;
+	}
+	src = vc->vc_font.data + ((c & charmask) * size);
+	if (info->cursor.image.fg_color != attr_fgcol(fgshift, c) ||
+    	    info->cursor.image.bg_color != attr_bgcol(bgshift, c)) {
+		cursor.image.fg_color = attr_fgcol(fgshift, c);
+		cursor.image.bg_color = attr_bgcol(bgshift, c);
+		cursor.image.depth = 1;
+		cursor.set |= FB_CUR_SETCMAP;
+	}
+		
+	if ((info->cursor.image.dx != (vc->vc_font.width * vc->vc_x)) ||
+	    (info->cursor.image.dy != (vc->vc_font.height * y))) {
+		cursor.image.dx = vc->vc_font.width * vc->vc_x;
+		cursor.image.dy = vc->vc_font.height * y;
+		cursor.set |= FB_CUR_SETPOS;
+	}
+
+	if (info->cursor.image.height != vc->vc_font.height ||
+	    info->cursor.image.width != vc->vc_font.width) {
+		cursor.image.height = vc->vc_font.height;
+		cursor.image.width = vc->vc_font.width;
+		cursor.set |= FB_CUR_SETSIZE;
+	}
+
+	if (info->cursor.hot.x || info->cursor.hot.y) {
+		cursor.hot.x = cursor.hot.y = 0;
+		cursor.set |= FB_CUR_SETHOT;
+	}
+
+	d_pitch = (s_pitch + scan_align) & ~scan_align;
+	dsize = d_pitch * vc->vc_font.height + buf_align;
+	dsize &= ~buf_align;
+		
+	if ((cursor.set & FB_CUR_SETSIZE) ||
+	    ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)) {
+		char *mask = kmalloc(dsize, GFP_ATOMIC);
+		int cur_height, i, j, k;
+
+		if (!mask)
+			return;	
+	
+		memset(mask, 0, dsize);
+			
+		if (info->cursor.mask)
+			kfree(info->cursor.mask);
+		info->cursor.mask = mask;
+	
+		p->cursor_shape = vc->vc_cursor_type & 0x0f;
+
+		switch (vc->vc_cursor_type & 0x0f) {
+		case CUR_NONE:
+			cur_height = 0;
+			break;
+		case CUR_UNDERLINE:
+			cur_height = (vc->vc_font.height < 10) ? 1 : 2;
+			break;
+		case CUR_LOWER_THIRD:
+			cur_height = vc->vc_font.height/3;
+			break;
+		case CUR_LOWER_HALF:
+			cur_height = vc->vc_font.height >> 1;
+			break;
+		case CUR_TWO_THIRDS:
+			cur_height = (vc->vc_font.height << 1)/3;
+			break;
+		case CUR_BLOCK:
+		default:
+			cur_height = vc->vc_font.height;
+			break;
+		}
+		i = (vc->vc_font.height - cur_height) * d_pitch;
+		for (j = 0; j < cur_height; j++) {
+			for (k = 0; k < s_pitch; k++)	
+				mask[i++] = 0xff;
+			i += (d_pitch - s_pitch);
+		}
+	}
+	src = vc->vc_font.data + ((c & charmask) * size);
+	dst = fb_get_buffer_offset(info, &info->sprite, dsize);
+	move_buf_aligned(info, &info->sprite, dst, src, d_pitch, s_pitch,
+	       	         vc->vc_font.height);
+	info->cursor.image.data = dst;
+	cursor.set |= FB_CUR_SETSHAPE;
+       	info->cursor.rop = ROP_XOR;
+	info->fbops->fb_cursor(info, &cursor);
+	atomic_dec(&info->sprite.count);
+	smp_mb__after_atomic_dec();
+}
+
 
 /* ====================================================================== */
 
@@ -917,6 +1027,9 @@
 	info->fbops->fb_imageblit(info, &image);
 	atomic_dec(&info->pixmap.count);
 	smp_mb__after_atomic_dec();
+
+	if (ypos == vc->vc_y && xpos == vc->vc_x)
+		update_cursor(vc, info, c);
 }
 
 static void fbcon_putcs(struct vc_data *vc, const unsigned short *s,
@@ -932,22 +1045,17 @@
 		return;
 
 	accel_putcs(vc, info, s, count, real_y(p, ypos), xpos);
+
+	if (ypos == vc->vc_y && xpos <= vc->vc_x && xpos + count > vc->vc_x)
+		update_cursor(vc, info, s[vc->vc_x - xpos]);
 }
 
 static void fbcon_cursor(struct vc_data *vc, int mode)
 {
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
-	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int scan_align = info->sprite.scan_align - 1;
-	unsigned int buf_align = info->sprite.buf_align - 1;
-	int bgshift = (vc->vc_hi_font_mask) ? 13 : 12;
-	int fgshift = (vc->vc_hi_font_mask) ? 9 : 8;
 	struct display *p = &fb_display[vc->vc_num];
-	int y = real_y(p, vc->vc_y), d_pitch, dsize;
-	int s_pitch = (vc->vc_font.width + 7) >> 3;
-	int size = s_pitch * vc->vc_font.height, c;
-	struct fb_cursor cursor;
-	u8 *src, *dst;
+	int y = real_y(p, vc->vc_y);
+	int c;
 	
 	if (mode & CM_SOFTBACK) {
 		mode &= ~CM_SOFTBACK;
@@ -967,95 +1075,11 @@
 	}
 
 	if (mode != CM_ERASE) {
-		memset(&cursor, 0, sizeof(struct fb_cursor));
 		info->cursor.enable = 1;
 
  		c = scr_readw((u16 *) vc->vc_pos);
+		update_cursor(vc, info, c);
 
-		src = vc->vc_font.data + ((c & charmask) * size);
-		if (info->cursor.image.fg_color != attr_fgcol(fgshift, c) ||
-	    	    info->cursor.image.bg_color != attr_bgcol(bgshift, c)) {
-			cursor.image.fg_color = attr_fgcol(fgshift, c);
-			cursor.image.bg_color = attr_bgcol(bgshift, c);
-			cursor.image.depth = 1;
-			cursor.set |= FB_CUR_SETCMAP;
-		}
-		
-		if ((info->cursor.image.dx != (vc->vc_font.width * vc->vc_x)) ||
-		    (info->cursor.image.dy != (vc->vc_font.height * y))) {
-			cursor.image.dx = vc->vc_font.width * vc->vc_x;
-			cursor.image.dy = vc->vc_font.height * y;
-			cursor.set |= FB_CUR_SETPOS;
-		}
-
-		if (info->cursor.image.height != vc->vc_font.height ||
-		    info->cursor.image.width != vc->vc_font.width) {
-			cursor.image.height = vc->vc_font.height;
-			cursor.image.width = vc->vc_font.width;
-			cursor.set |= FB_CUR_SETSIZE;
-		}
-
-		if (info->cursor.hot.x || info->cursor.hot.y) {
-			cursor.hot.x = cursor.hot.y = 0;
-			cursor.set |= FB_CUR_SETHOT;
-		}
-
-		src = vc->vc_font.data + ((c & charmask) * size);
-
-		d_pitch = (s_pitch + scan_align) & ~scan_align;
-		dsize = d_pitch * vc->vc_font.height + buf_align;
-		dsize &= ~buf_align;
-		dst = fb_get_buffer_offset(info, &info->sprite, dsize);
-		move_buf_aligned(info, &info->sprite, dst, src, d_pitch, s_pitch, vc->vc_font.height);
-		info->cursor.image.data = dst;
-		cursor.set |= FB_CUR_SETSHAPE;
-		
-		if ((cursor.set & FB_CUR_SETSIZE) || ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)) {
-			char *mask = kmalloc(dsize, GFP_ATOMIC);
-			int cur_height, i, j, k;
-
-			if (!mask)	return;	
-	
-			memset(mask, 0, dsize);
-			
-			if (info->cursor.mask)
-				kfree(info->cursor.mask);
-			info->cursor.mask = mask;
-	
-			p->cursor_shape = vc->vc_cursor_type & 0x0f;
-
-			switch (vc->vc_cursor_type & 0x0f) {
-			case CUR_NONE:
-				cur_height = 0;
-				break;
-			case CUR_UNDERLINE:
-				cur_height = (vc->vc_font.height < 10) ? 1 : 2;
-				break;
-			case CUR_LOWER_THIRD:
-				cur_height = vc->vc_font.height/3;
-				break;
-			case CUR_LOWER_HALF:
-				cur_height = vc->vc_font.height >> 1;
-				break;
-			case CUR_TWO_THIRDS:
-				cur_height = (vc->vc_font.height << 1)/3;
-				break;
-			case CUR_BLOCK:
-			default:
-				cur_height = vc->vc_font.height;
-				break;
-			}
-			i = (vc->vc_font.height - cur_height) * d_pitch;
-			for (j = 0; j < cur_height; j++) {
-				for (k = 0; k < s_pitch; k++)	
-					mask[i++] = 0xff;
-				i += (d_pitch - s_pitch);
-			}
-		}
-        	info->cursor.rop = ROP_XOR;
-		info->fbops->fb_cursor(info, &cursor);
-		atomic_dec(&info->sprite.count);
-		smp_mb__after_atomic_dec();
 		mod_timer(&cursor_timer, jiffies + HZ/5);
 		vbl_cursor_cnt = CURSOR_DRAW_DELAY;
 	}



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
