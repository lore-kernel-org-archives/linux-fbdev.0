From: James Simmons <jsimmons@www.infradead.org>
Subject: Shrink fbdev stack
Date: Mon, 13 Jun 2005 17:44:55 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0506131741290.899@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dhs3c-0002hr-VE
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Jun 2005 09:45:04 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1Dhs3a-0002Up-Qq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 13 Jun 2005 09:45:04 -0700
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "Antonino A. Daplas" <adaplas@hotpop.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


I posted this patch last week. No one complained :-) This patch shrinks 
the stack when calling the drawing alignment functions. It can be applied 
against the latest -mm tree. Thank you.

Signed-off-by: James Simmons <jsimmons@www.infradead.org>


diff -urN -X /home/jsimmons/dontdiff linux-2.6.12-rc5-mm2-new/drivers/video/console/bitblit.c fbdev-2.6/drivers/video/console/bitblit.c
--- linux-2.6.12-rc5-mm2-new/drivers/video/console/bitblit.c	2005-06-04 14:33:14.000000000 -0700
+++ fbdev-2.6/drivers/video/console/bitblit.c	2005-06-04 10:37:38.000000000 -0700
@@ -157,9 +157,9 @@
 					src = buf;
 				}
 
-				fb_sysmove_buf_unaligned(info, &info->pixmap, dst, pitch,
-					       src, idx, image.height,
-					       shift_high, shift_low, mod);
+				fb_pad_unaligned_buffer(dst, pitch, src, idx,
+						image.height, shift_high,
+						shift_low, mod);
 				shift_low += mod;
 				dst += (shift_low >= 8) ? width : width - 1;
 				shift_low &= 7;
@@ -175,8 +175,7 @@
 					src = buf;
 				}
 
-				fb_sysmove_buf_aligned(info, &info->pixmap, dst, pitch,
-					     src, idx, image.height);
+				fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
 				dst += width;
 			}
 		}
diff -urN -X /home/jsimmons/dontdiff linux-2.6.12-rc5-mm2-new/drivers/video/fbmem.c fbdev-2.6/drivers/video/fbmem.c
--- linux-2.6.12-rc5-mm2-new/drivers/video/fbmem.c	2005-06-04 14:33:14.000000000 -0700
+++ fbdev-2.6/drivers/video/fbmem.c	2005-06-04 10:37:38.000000000 -0700
@@ -78,9 +78,7 @@
 /*
  * Data padding functions.
  */
-void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
-			    u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-			    u32 height)
+void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
 {
 	int i;
 
@@ -90,12 +88,10 @@
 		dst += d_pitch;
 	}
 }
-EXPORT_SYMBOL(fb_sysmove_buf_aligned);
+EXPORT_SYMBOL(fb_pad_aligned_buffer);
 
-void fb_sysmove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
-			      u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-			      u32 height, u32 shift_high, u32 shift_low,
-			      u32 mod)
+void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx, u32 height,
+				u32 shift_high, u32 shift_low, u32 mod)
 {
 	u8 mask = (u8) (0xfff << shift_high), tmp;
 	int i, j;
@@ -122,7 +118,7 @@
 		dst += d_pitch;
 	}
 }
-EXPORT_SYMBOL(fb_sysmove_buf_unaligned);
+EXPORT_SYMBOL(fb_pad_unaligned_buffer);
 
 /*
  * we need to lock this section since fb_cursor
diff -urN -X /home/jsimmons/dontdiff linux-2.6.12-rc5-mm2-new/drivers/video/nvidia/nvidia.c fbdev-2.6/drivers/video/nvidia/nvidia.c
--- linux-2.6.12-rc5-mm2-new/drivers/video/nvidia/nvidia.c	2005-06-04 14:32:07.000000000 -0700
+++ fbdev-2.6/drivers/video/nvidia/nvidia.c	2005-06-04 10:37:38.000000000 -0700
@@ -516,9 +516,9 @@
 static void nvidiafb_load_cursor_image(struct nvidia_par *par, u8 * data8,
 				       u16 bg, u16 fg, u32 w, u32 h)
 {
+	u32 *data = (u32 *) data8;
 	int i, j, k = 0;
 	u32 b, tmp;
-	u32 *data = (u32 *) data8;
 
 	w = (w + 1) & ~1;
 
@@ -890,11 +890,11 @@
 {
 	struct nvidia_par *par = info->par;
 	u8 data[MAX_CURS * MAX_CURS / 8];
-	u16 fg, bg;
 	int i, set = cursor->set;
-
+	u16 fg, bg;
+	
 	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
-		return soft_cursor(info, cursor);
+		return -ENXIO;
 
 	NVShowHideCursor(par, 0);
 
@@ -931,21 +931,18 @@
 		if (src) {
 			switch (cursor->rop) {
 			case ROP_XOR:
-				for (i = 0; i < s_pitch * cursor->image.height;
-				     i++)
+				for (i = 0; i < s_pitch * cursor->image.height; i++)
 					src[i] = dat[i] ^ msk[i];
 				break;
 			case ROP_COPY:
 			default:
-				for (i = 0; i < s_pitch * cursor->image.height;
-				     i++)
+				for (i = 0; i < s_pitch * cursor->image.height; i++)
 					src[i] = dat[i] & msk[i];
 				break;
 			}
 
-			fb_sysmove_buf_aligned(info, &info->pixmap, data,
-					       d_pitch, src, s_pitch,
-					       cursor->image.height);
+			fb_pad_aligned_buffer(data, d_pitch, src, s_pitch,
+						cursor->image.height);
 
 			bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 			    ((info->cmap.green[bg_idx] & 0xf8) << 2) |
diff -urN -X /home/jsimmons/dontdiff linux-2.6.12-rc5-mm2-new/drivers/video/riva/fbdev.c fbdev-2.6/drivers/video/riva/fbdev.c
--- linux-2.6.12-rc5-mm2-new/drivers/video/riva/fbdev.c	2005-06-04 14:32:07.000000000 -0700
+++ fbdev-2.6/drivers/video/riva/fbdev.c	2005-06-04 10:37:38.000000000 -0700
@@ -1582,12 +1582,11 @@
 {
 	struct riva_par *par = (struct riva_par *) info->par;
 	u8 data[MAX_CURS * MAX_CURS/8];
-	u16 fg, bg;
 	int i, set = cursor->set;
-
-	if (cursor->image.width > MAX_CURS ||
-	    cursor->image.height > MAX_CURS)
-		return soft_cursor(info, cursor);
+	u16 fg, bg;
+	
+	if (cursor->image.width > MAX_CURS || cursor->image.height > MAX_CURS)
+		return -ENXIO;
 
 	par->riva.ShowHideCursor(&par->riva, 0);
 
@@ -1625,21 +1624,18 @@
 		if (src) {
 			switch (cursor->rop) {
 			case ROP_XOR:
-				for (i = 0; i < s_pitch * cursor->image.height;
-				     i++)
+				for (i = 0; i < s_pitch * cursor->image.height; i++)
 					src[i] = dat[i] ^ msk[i];
 				break;
 			case ROP_COPY:
 			default:
-				for (i = 0; i < s_pitch * cursor->image.height;
-				     i++)
+				for (i = 0; i < s_pitch * cursor->image.height; i++)
 					src[i] = dat[i] & msk[i];
 				break;
 			}
 
-			fb_sysmove_buf_aligned(info, &info->pixmap, data,
-					       d_pitch, src, s_pitch,
-					       cursor->image.height);
+			fb_pad_aligned_buffer(data, d_pitch, src, s_pitch,
+						cursor->image.height);
 
 			bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 				((info->cmap.green[bg_idx] & 0xf8) << 2) |
diff -urN -X /home/jsimmons/dontdiff linux-2.6.12-rc5-mm2-new/drivers/video/softcursor.c fbdev-2.6/drivers/video/softcursor.c
--- linux-2.6.12-rc5-mm2-new/drivers/video/softcursor.c	2005-06-04 14:33:14.000000000 -0700
+++ fbdev-2.6/drivers/video/softcursor.c	2005-06-04 10:37:38.000000000 -0700
@@ -58,13 +58,10 @@
 	} else 
 		memcpy(src, image->data, dsize);
 	
-	fb_sysmove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
-				s_pitch, image->height);
-
+	fb_pad_aligned_buffer(dst, d_pitch, src, s_pitch, image->height);
 	image->data = dst;
 	info->fbops->fb_imageblit(info, image);
 	kfree(src);
-
 	return 0;
 }
 
--- linux-2.6.12-rc5-mm2-new/include/linux/fb.h	2005-06-04 14:33:19.000000000 -0700
+++ fbdev-2.6/include/linux/fb.h	2005-06-04 10:37:38.000000000 -0700
@@ -816,12 +816,9 @@
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
 extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
-extern void fb_sysmove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
-				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
+extern void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 idx,
 				u32 height, u32 shift_high, u32 shift_low, u32 mod);
-extern void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
-				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-				u32 height);
+extern void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height);
 extern void fb_set_suspend(struct fb_info *info, int state);
 extern int fb_get_color_depth(struct fb_var_screeninfo *var);
 extern int fb_get_options(char *name, char **option);


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
