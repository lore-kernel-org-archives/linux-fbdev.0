From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/8] fbdev: Clean up of fbcon/fbdev cursor interface
Date: Wed, 20 Oct 2004 08:15:56 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410200815.56940.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CK43V-0002R0-Bc
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:17 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CK43U-0005Bm-6L
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:17 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E12F31171E01
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Oct 2004 00:10:09 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  The current cursor interface is confusing.  Some fields are taken from the
  cursor structure in struct fb_info (enable, mask, rop fields) and the rest are
  taken from the passed cursor structure.  These lead to a lot of confusion,
  making it hard for developers to write their own implementation.

  Also, the cursor code has several 'short-circuits', occassionally leading to
  undefined cursor behavior.

  These are the changes brought about by the patch:

  - Removed struct fb_cursor and related fields from struct fb_info, and instead,
    placed them in a struct not visible to fbdev.

  - The struct fb_cursor passed to fb_cursor() will _always_ contain valid data
    with various bitflags indicating which fields have changed

  - The struct fb_pixmap sprite in struct fb_info is used only by drivers with
    hardware cursor implementation.  Initializing and allocating memory for this
    structure is not needed.  Remove initialization and memory allocation.

  - The FBIO_CURSOR ioctl is broken (because fb_cursor() is broken).  For now,
    remove fb_cursor code and make the FBIO_CURSOR ioctl always return -ENODEV.

  - The flag FB_CUR_SETCUR is changed to FB_CUR_SETIMAGE, indicating that the
    cursor sprite has changed. The image change is now checked by fbcon so
    drivers will not unnecessarily load the sprite image everytime. This causes
    hardware cursors to flicker, especially in rivafb.

  - Remove fb_load_cursor_image().  This is unused, and should not be implemented
    generically.

  - Documented the usage of the cursor interface in skeletonfb.c

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 drivers/video/console/bitblit.c |  186 +++++++++++++++++++++-------------------
 drivers/video/console/fbcon.c   |   20 +++-
 drivers/video/console/fbcon.h   |    4
 drivers/video/fbmem.c           |  130 ---------------------------
 drivers/video/skeletonfb.c      |   44 +++++++--
 include/linux/fb.h              |    7 -
 6 files changed, 154 insertions(+), 237 deletions(-)

diff -Nru a/drivers/video/console/bitblit.c b/drivers/video/console/bitblit.c
--- a/drivers/video/console/bitblit.c	2004-10-19 20:22:57 +08:00
+++ b/drivers/video/console/bitblit.c	2004-10-17 15:03:25 +08:00
@@ -239,118 +239,134 @@
 		       struct display *p, int mode, int fg, int bg)
 {
 	struct fb_cursor cursor;
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	int w = (vc->vc_font.width + 7) >> 3, c;
 	int y = real_y(p, vc->vc_y);
 	int attribute;
 	char *src;
 
+	cursor.set = 0;
+
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
 	src = vc->vc_font.data + ((c & charmask) * (w * vc->vc_font.height));
+
+	if (ops->cursor_state.image.data != src) {
+	    ops->cursor_state.image.data = src;
+	    cursor.set |= FB_CUR_SETIMAGE;
+	}
+
 	if (attribute) {
 		u8 *dst;
 
 		dst = kmalloc(w * vc->vc_font.height, GFP_ATOMIC);
 		if (!dst)
 			return;
-		if (info->cursor.data)
-			kfree(info->cursor.data);
-		info->cursor.data = dst;
+		if (ops->cursor_data)
+			kfree(ops->cursor_data);
+		ops->cursor_data = dst;
 		update_attr(dst, src, attribute, vc);
 		src = dst;
 	}
 
-	cursor.image.data = src;
-	cursor.set = FB_CUR_SETCUR;
-	cursor.image.depth = 1;
+	if (ops->cursor_state.image.fg_color != fg ||
+	    ops->cursor_state.image.bg_color != bg) {
+		ops->cursor_state.image.fg_color = fg;
+		ops->cursor_state.image.bg_color = bg;
+		cursor.set |= FB_CUR_SETCMAP;
+	}
 
-	switch (mode) {
-	case CM_ERASE:
-		if (info->cursor.rop == ROP_XOR) {
-			info->cursor.enable = 0;
-			info->cursor.rop = ROP_COPY;
-			info->fbops->fb_cursor(info, &cursor);
-		}
-		break;
-	case CM_MOVE:
-	case CM_DRAW:
-		info->cursor.enable = 1;
-        	info->cursor.rop = ROP_XOR;
+	if ((ops->cursor_state.image.dx != (vc->vc_font.width * vc->vc_x)) ||
+	    (ops->cursor_state.image.dy != (vc->vc_font.height * y))) {
+		ops->cursor_state.image.dx = vc->vc_font.width * vc->vc_x;
+		ops->cursor_state.image.dy = vc->vc_font.height * y;
+		cursor.set |= FB_CUR_SETPOS;
+	}
 
-		if (info->cursor.image.fg_color != fg ||
-		    info->cursor.image.bg_color != bg) {
-			cursor.image.fg_color = fg;
-			cursor.image.bg_color = bg;
-			cursor.set |= FB_CUR_SETCMAP;
-		}
+	if (ops->cursor_state.image.height != vc->vc_font.height ||
+	    ops->cursor_state.image.width != vc->vc_font.width) {
+		ops->cursor_state.image.height = vc->vc_font.height;
+		ops->cursor_state.image.width = vc->vc_font.width;
+		cursor.set |= FB_CUR_SETSIZE;
+	}
 
-		if ((info->cursor.image.dx != (vc->vc_font.width * vc->vc_x)) ||
-		    (info->cursor.image.dy != (vc->vc_font.height * y))) {
-			cursor.image.dx = vc->vc_font.width * vc->vc_x;
-			cursor.image.dy = vc->vc_font.height * y;
-			cursor.set |= FB_CUR_SETPOS;
-		}
+	if (ops->cursor_state.hot.x || ops->cursor_state.hot.y) {
+		ops->cursor_state.hot.x = cursor.hot.y = 0;
+		cursor.set |= FB_CUR_SETHOT;
+	}
 
-		if (info->cursor.image.height != vc->vc_font.height ||
-		    info->cursor.image.width != vc->vc_font.width) {
-			cursor.image.height = vc->vc_font.height;
-			cursor.image.width = vc->vc_font.width;
-			cursor.set |= FB_CUR_SETSIZE;
-		}
+	if ((cursor.set & FB_CUR_SETSIZE) ||
+	    ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)
+	    || ops->cursor_state.mask == NULL) {
+		char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
+		int cur_height, size, i = 0;
+		u8 msk = 0xff;
 
-		if (info->cursor.hot.x || info->cursor.hot.y) {
-			cursor.hot.x = cursor.hot.y = 0;
-			cursor.set |= FB_CUR_SETHOT;
-		}
+		if (!mask)
+			return;
 
-		if ((cursor.set & FB_CUR_SETSIZE) ||
-		    ((vc->vc_cursor_type & 0x0f) != p->cursor_shape)
-		    || info->cursor.mask == NULL) {
-			char *mask = kmalloc(w*vc->vc_font.height, GFP_ATOMIC);
-			int cur_height, size, i = 0;
-			u8 msk = 0xff;
-
-			if (!mask)
-				return;
-
-			if (info->cursor.mask)
-				kfree(info->cursor.mask);
-			info->cursor.mask = mask;
-			p->cursor_shape = vc->vc_cursor_type & 0x0f;
-			cursor.set |= FB_CUR_SETSHAPE;
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
-			size = (vc->vc_font.height - cur_height) * w;
-			while (size--)
-				mask[i++] = ~msk;
-			size = cur_height * w;
-			while (size--)
-				mask[i++] = msk;
-		}
-		info->fbops->fb_cursor(info, &cursor);
+		if (ops->cursor_state.mask)
+			kfree(ops->cursor_state.mask);
+		ops->cursor_state.mask = mask;
+		p->cursor_shape = vc->vc_cursor_type & 0x0f;
+		cursor.set |= FB_CUR_SETSHAPE;
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
+		size = (vc->vc_font.height - cur_height) * w;
+		while (size--)
+			mask[i++] = ~msk;
+		size = cur_height * w;
+		while (size--)
+			mask[i++] = msk;
+	}
+
+	switch (mode) {
+	case CM_ERASE:
+		ops->cursor_state.enable = 0;
+		break;
+	case CM_DRAW:
+	case CM_MOVE:
+	default:
+		ops->cursor_state.enable = 1;
 		break;
 	}
+
+	cursor.image.data = src;
+	cursor.image.fg_color = ops->cursor_state.image.fg_color;
+	cursor.image.bg_color = ops->cursor_state.image.bg_color;
+	cursor.image.dx = ops->cursor_state.image.dx;
+	cursor.image.dy = ops->cursor_state.image.dy;
+	cursor.image.height = ops->cursor_state.image.height;
+	cursor.image.width = ops->cursor_state.image.width;
+	cursor.hot.x = ops->cursor_state.hot.x;
+	cursor.hot.y = ops->cursor_state.hot.y;
+	cursor.mask = ops->cursor_state.mask;
+	cursor.enable = ops->cursor_state.enable;
+	cursor.image.depth = 1;
+	cursor.rop = ROP_XOR;
+
+	info->fbops->fb_cursor(info, &cursor);
 }
 
 void fbcon_set_bitops(struct fbcon_ops *ops)
diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2004-10-17 14:01:02 +08:00
+++ b/drivers/video/console/fbcon.c	2004-10-17 15:03:25 +08:00
@@ -245,14 +245,15 @@
 		vc = vc_cons[info->currcon].d;
 
 	if (info->state != FBINFO_STATE_RUNNING ||
-	    !vc || !CON_IS_VISIBLE(vc) || !info->cursor.flash ||
+	    !vc || !CON_IS_VISIBLE(vc) ||
 	    vt_cons[vc->vc_num]->vc_mode != KD_TEXT ||
  	    registered_fb[(int) con2fb_map[vc->vc_num]] != info)
 		return;
+	acquire_console_sem();
 	p = &fb_display[vc->vc_num];
 	c = scr_readw((u16 *) vc->vc_pos);
-	acquire_console_sem();
-	mode = (info->cursor.enable) ? CM_ERASE : CM_DRAW;
+	mode = (!ops->cursor_flash || ops->cursor_state.enable) ?
+		CM_ERASE : CM_DRAW;
 	ops->cursor(vc, info, p, mode, get_color(vc, info, c, 1),
 		    get_color(vc, info, c, 0));
 	release_console_sem();
@@ -533,6 +534,7 @@
 		}
 
 		if (!err) {
+			memset(ops, 0, sizeof(struct fbcon_ops));
 			info->fbcon_par = ops;
 			set_blitting_type(vc, info, NULL);
 		}
@@ -550,6 +552,8 @@
 	 * fbcon should release it.
 	 */
 	if (oldinfo && !search_fb_in_map(oldidx)) {
+		struct fbcon_ops *ops = (struct fbcon_ops *) oldinfo->fbcon_par;
+
 		if (oldinfo->fbops->fb_release &&
 		    oldinfo->fbops->fb_release(oldinfo, 0)) {
 			con2fb_map[unit] = oldidx;
@@ -564,6 +568,8 @@
 		if (oldinfo->queue.func == fb_flashcursor)
 			del_timer_sync(&oldinfo->cursor_timer);
 
+		kfree(ops->cursor_state.mask);
+		kfree(ops->cursor_data);
 		kfree(oldinfo->fbcon_par);
 		module_put(oldinfo->fbops->owner);
 	}
@@ -692,6 +698,7 @@
 		return NULL;
 	}
 
+	memset(ops, 0, sizeof(struct fbcon_ops));
 	info->fbcon_par = ops;
 	set_blitting_type(vc, info, NULL);
 
@@ -1024,13 +1031,13 @@
 	int y = real_y(p, vc->vc_y);
  	int c = scr_readw((u16 *) vc->vc_pos);
 
-	info->cursor.flash = 1;
+	ops->cursor_flash = 1;
 	if (mode & CM_SOFTBACK) {
 		mode &= ~CM_SOFTBACK;
 		if (softback_lines) {
 			if (y + softback_lines >= vc->vc_rows) {
 				mode = CM_ERASE;
-				info->cursor.flash = 0;
+				ops->cursor_flash = 0;
 			}
 			else
 				y += softback_lines;
@@ -1932,6 +1939,7 @@
 {
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	struct fb_info *info = registered_fb[(int) con2fb_map[vc->vc_num]];
+	struct fbcon_ops *ops = (struct fbcon_ops *) info->fbcon_par;
 	struct display *p = &fb_display[vc->vc_num];
 
 	if (mode_switch) {
@@ -1961,7 +1969,7 @@
 	}
 
 	fbcon_cursor(vc, blank ? CM_ERASE : CM_DRAW);
-	info->cursor.flash = (!blank);
+	ops->cursor_flash = (!blank);
 
 	if (!info->fbops->fb_blank) {
 		if (blank) {
diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2004-10-19 20:23:01 +08:00
+++ b/drivers/video/console/fbcon.h	2004-10-17 15:03:25 +08:00
@@ -60,6 +60,10 @@
 			      int bottom_only);
 	void (*cursor)(struct vc_data *vc, struct fb_info *info,
 		       struct display *p, int mode, int fg, int bg);
+
+	struct fb_cursor cursor_state;
+	int    cursor_flash;
+	char  *cursor_data;
 };
     /*
      *  Attribute Decoding
diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-10-17 13:37:00 +08:00
+++ b/drivers/video/fbmem.c	2004-10-17 15:03:25 +08:00
@@ -652,116 +652,6 @@
 }
 #endif /* CONFIG_KMOD */
 
-void
-fb_load_cursor_image(struct fb_info *info)
-{
-	unsigned int width = (info->cursor.image.width + 7) >> 3;
-	u8 *data = (u8 *) info->cursor.image.data;
-
-	if (info->sprite.outbuf)
-	    info->sprite.outbuf(info, info->sprite.addr, data,
-				width);
-	else
-	    memcpy(info->sprite.addr, data, width);
-}
-
-int
-fb_cursor(struct fb_info *info, struct fb_cursor_user __user *sprite)
-{
-	struct fb_cursor_user cursor_user;
-	struct fb_cursor cursor;
-	char *data = NULL, *mask = NULL, *info_mask = NULL;
-	u16 *red = NULL, *green = NULL, *blue = NULL, *transp = NULL;
-	int err = -EINVAL;
-	
-	if (copy_from_user(&cursor_user, sprite, sizeof(struct fb_cursor_user)))
-		return -EFAULT;
-
-	memcpy(&cursor, &cursor_user, sizeof(cursor_user));
-	cursor.mask = info->cursor.mask;
-	cursor.image.data = info->cursor.image.data;
-	cursor.image.cmap.red = info->cursor.image.cmap.red;
-	cursor.image.cmap.green = info->cursor.image.cmap.green;
-	cursor.image.cmap.blue = info->cursor.image.cmap.blue;
-	cursor.image.cmap.transp = info->cursor.image.cmap.transp;
-	cursor.data = NULL;
-	cursor.flash = 0;
-
-	if (cursor.set & FB_CUR_SETCUR)
-		info->cursor.enable = 1;
-	
-	if (cursor.set & FB_CUR_SETCMAP) {
-		unsigned len = cursor.image.cmap.len;
-		if ((int)len <= 0)
-			goto out;
-		len *= 2;
-		err = -ENOMEM;
-		red = kmalloc(len, GFP_USER);
-		green = kmalloc(len, GFP_USER);
-		blue = kmalloc(len, GFP_USER);
-		if (!red || !green || !blue)
-			goto out;
-		if (cursor_user.image.cmap.transp) {
-			transp = kmalloc(len, GFP_USER);
-			if (!transp)
-				goto out;
-		}
-		err = -EFAULT;
-		if (copy_from_user(red, cursor_user.image.cmap.red, len))
-			goto out;
-		if (copy_from_user(green, cursor_user.image.cmap.green, len))
-			goto out;
-		if (copy_from_user(blue, cursor_user.image.cmap.blue, len))
-			goto out;
-		if (transp) {
-			if (copy_from_user(transp,
-					   cursor_user.image.cmap.transp, len))
-				goto out;
-		}
-		cursor.image.cmap.red = red;
-		cursor.image.cmap.green = green;
-		cursor.image.cmap.blue = blue;
-		cursor.image.cmap.transp = transp;
-	}
-	
-	if (cursor.set & FB_CUR_SETSHAPE) {
-		int size = ((cursor.image.width + 7) >> 3) * cursor.image.height;		
-
-		if ((cursor.image.height != info->cursor.image.height) ||
-		    (cursor.image.width != info->cursor.image.width))
-			cursor.set |= FB_CUR_SETSIZE;
-		
-		err = -ENOMEM;
-		data = kmalloc(size, GFP_USER);
-		mask = kmalloc(size, GFP_USER);
-		if (!mask || !data)
-			goto out;
-		
-		err = -EFAULT;
-		if (copy_from_user(data, cursor_user.image.data, size) ||
-		    copy_from_user(mask, cursor_user.mask, size))
-			goto out;
-		
-		cursor.image.data = data;
-		cursor.mask = mask;
-		info_mask = (char *) info->cursor.mask;
-		info->cursor.mask = mask;
-	}
-	info->cursor.set = cursor.set;
-	info->cursor.rop = cursor.rop;
-	err = info->fbops->fb_cursor(info, &cursor);
-out:
-	kfree(data);
-	kfree(mask);
-	kfree(red);
-	kfree(green);
-	kfree(blue);
-	kfree(transp);
-	if (info_mask)
-		info->cursor.mask = info_mask;
-	return err;
-}
-
 int
 fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
 {
@@ -934,10 +824,7 @@
 			return -EFAULT;
 		return 0;
 	case FBIO_CURSOR:
-		acquire_console_sem();
-		i = fb_cursor(info, argp);
-		release_console_sem();
-		return i;
+		return -EINVAL;
 	case FBIOGET_CON2FBMAP:
 		if (copy_from_user(&con2fb, argp, sizeof(con2fb)))
 			return -EFAULT;
@@ -1175,18 +1062,6 @@
 	}	
 	fb_info->pixmap.offset = 0;
 
-	if (fb_info->sprite.addr == NULL) {
-		fb_info->sprite.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
-		if (fb_info->sprite.addr) {
-			fb_info->sprite.size = FBPIXMAPSIZE;
-			fb_info->sprite.buf_align = 1;
-			fb_info->sprite.scan_align = 1;
-			fb_info->sprite.access_align = 4;
-			fb_info->sprite.flags = FB_PIXMAP_DEFAULT;
-		}
-	}
-	fb_info->sprite.offset = 0;
-
 	if (!fb_info->modelist.prev ||
 	    !fb_info->modelist.next ||
 	    list_empty(&fb_info->modelist)) {
@@ -1230,8 +1105,6 @@
 
 	if (fb_info->pixmap.addr && (fb_info->pixmap.flags & FB_PIXMAP_DEFAULT))
 		kfree(fb_info->pixmap.addr);
-	if (fb_info->sprite.addr && (fb_info->sprite.flags & FB_PIXMAP_DEFAULT))
-		kfree(fb_info->sprite.addr);
 	fb_destroy_modelist(&fb_info->modelist);
 	registered_fb[i]=NULL;
 	num_registered_fb--;
@@ -1401,7 +1274,6 @@
 EXPORT_SYMBOL(fb_iomove_buf_aligned);
 EXPORT_SYMBOL(fb_sysmove_buf_unaligned);
 EXPORT_SYMBOL(fb_sysmove_buf_aligned);
-EXPORT_SYMBOL(fb_load_cursor_image);
 EXPORT_SYMBOL(fb_set_suspend);
 EXPORT_SYMBOL(fb_register_client);
 EXPORT_SYMBOL(fb_unregister_client);
diff -Nru a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
--- a/drivers/video/skeletonfb.c	2004-10-19 20:22:18 +08:00
+++ b/drivers/video/skeletonfb.c	2004-10-17 15:08:17 +08:00
@@ -477,6 +477,28 @@
  *		Used internally by the driver.	 
  *      @hot:	The hot spot. 
  *	@image:	The actual data for the cursor image.
+ *
+ *      NOTES ON FLAGS (cursor->set):
+ *
+ *      FB_CUR_SETIMAGE - the cursor image has changed (cursor->image.data)
+ *      FB_CUR_SETPOS   - the cursor position has changed (cursor->image.dx|dy)
+ *      FB_CUR_SETHOT   - the cursor hot spot has changed (cursor->hot.dx|dy)
+ *      FB_CUR_SETCMAP  - the cursor colors has changed (cursor->fg_color|bg_color)
+ *      FB_CUR_SETSHAPE - the cursor bitmask has changed (cursor->mask)
+ *      FB_CUR_SETSIZE  - the cursor size has changed (cursor->width|height)
+ *      FB_CUR_SETALL   - everything has changed
+ *
+ *      NOTES ON ROPs (cursor->rop, Raster Operation)
+ *
+ *      ROP_XOR         - cursor->image.data XOR cursor->mask
+ *      ROP_COPY        - curosr->image.data AND cursor->mask
+ *
+ *      OTHER NOTES:
+ *
+ *      - fbcon only supports a 2-color cursor (cursor->image.depth = 1)
+ *      - The fb_cursor structure, @cursor, _will_ always contain valid
+ *        fields, whether any particular bitfields in cursor->set is set
+ *        or not.
  */
 }
 
@@ -529,6 +551,17 @@
 {
     int cmap_len, retval;	
    
+    /*
+     *  For kernel boot options (in 'video=xxxfb:<options>' format)
+     */
+#ifndef MODULE
+    char *option = NULL;
+
+    if (fb_get_options("xxxfb", &option))
+	    return -ENODEV;
+    xxxfb_setup(option);
+#endif
+
     /* 
      * Here we set the screen_base to the vitrual memory address
      * for the framebuffer. Usually we obtain the resource address
@@ -582,17 +615,6 @@
 
 static void __exit xxxfb_cleanup(void)
 {
-    /*
-     *  For kernel boot options (in 'video=xxxfb:<options>' format)
-     */
-#ifndef MODULE
-    char *option = NULL;
-
-    if (fb_get_options("xxxfb", &option))
-	    return -ENODEV;
-    xxxfb_setup(option);
-#endif
-
     /*
      *  If your driver supports multiple boards, you should unregister and
      *  clean up all instances.
diff -Nru a/include/linux/fb.h b/include/linux/fb.h
--- a/include/linux/fb.h	2004-10-19 22:19:01 +08:00
+++ b/include/linux/fb.h	2004-10-17 15:03:25 +08:00
@@ -298,7 +298,7 @@
  * hardware cursor control
  */
 
-#define FB_CUR_SETCUR   0x01
+#define FB_CUR_SETIMAGE 0x01
 #define FB_CUR_SETPOS   0x02
 #define FB_CUR_SETHOT   0x04
 #define FB_CUR_SETCMAP  0x08
@@ -317,9 +317,6 @@
 	const char *mask;	/* cursor mask bits */
 	struct fbcurpos hot;	/* cursor hot spot */
 	struct fb_image	image;	/* Cursor image */
-/* all fields below are for fbcon use only */
-	int   flash;            /* cursor blink */
-	char  *data;             /* copy of bitmap */
 };
 
 #ifdef __KERNEL__
@@ -671,7 +668,6 @@
 	struct fb_var_screeninfo var;	/* Current var */
 	struct fb_fix_screeninfo fix;	/* Current fix */
 	struct fb_monspecs monspecs;	/* Current Monitor specs */
-	struct fb_cursor cursor;	/* Current cursor */	
 	struct work_struct queue;	/* Framebuffer event queue */
 	struct timer_list cursor_timer; /* Cursor timer */
 	struct fb_pixmap pixmap;	/* Image hardware mapper */
@@ -787,7 +783,6 @@
 extern void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
 				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
 				u32 height);
-extern void fb_load_cursor_image(struct fb_info *);
 extern void fb_set_suspend(struct fb_info *info, int state);
 extern int fb_get_color_depth(struct fb_info *info);
 extern int fb_get_options(char *name, char **option);




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
