From: James Simmons <jsimmons@www.infradead.org>
Subject: [PATCH] pixmap io cleanup
Date: Wed, 11 May 2005 23:44:37 +0100 (BST)
Message-ID: <Pine.LNX.4.56.0505112341170.4268@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVzwa-0003Lx-DY
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 May 2005 15:44:44 -0700
Received: from pentafluge.infradead.org ([213.146.154.40])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DVzwZ-0004TX-65
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 11 May 2005 15:44:44 -0700
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
To: "Antonino A. Daplas" <adaplas@hotpop.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


I generated this patch with GIT on my tree. Its against linus latest tree. 
The patch removes fb_iomove_buf_[un]aligned. No one was using it. 

Index: drivers/video/console/bitblit.c
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/drivers/video/console/bitblit.c  (mode:100644)
+++ uncommitted/drivers/video/console/bitblit.c  (mode:100644)
@@ -107,13 +107,6 @@
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg)
 {
-	void (*move_unaligned)(struct fb_info *info, struct fb_pixmap *buf,
-			       u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-			       u32 height, u32 shift_high, u32 shift_low,
-			       u32 mod);
-	void (*move_aligned)(struct fb_info *info, struct fb_pixmap *buf,
-			     u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-			     u32 height);
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int width = (vc->vc_font.width + 7) >> 3;
 	unsigned int cellsize = vc->vc_font.height * width;
@@ -141,13 +134,6 @@
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-	if (info->pixmap.outbuf && info->pixmap.inbuf) {
-		move_aligned = fb_iomove_buf_aligned;
-		move_unaligned = fb_iomove_buf_unaligned;
-	} else {
-		move_aligned = fb_sysmove_buf_aligned;
-		move_unaligned = fb_sysmove_buf_unaligned;
-	}
 	while (count) {
 		if (count > maxcnt)
 			cnt = k = maxcnt;
@@ -171,7 +157,7 @@
 					src = buf;
 				}
 
-				move_unaligned(info, &info->pixmap, dst, pitch,
+				fb_sysmove_buf_unaligned(info, &info->pixmap, dst, pitch,
 					       src, idx, image.height,
 					       shift_high, shift_low, mod);
 				shift_low += mod;
@@ -189,7 +175,7 @@
 					src = buf;
 				}
 
-				move_aligned(info, &info->pixmap, dst, pitch,
+				fb_sysmove_buf_aligned(info, &info->pixmap, dst, pitch,
 					     src, idx, image.height);
 				dst += width;
 			}
Index: drivers/video/fbmem.c
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/drivers/video/fbmem.c  (mode:100644)
+++ uncommitted/drivers/video/fbmem.c  (mode:100644)
@@ -76,65 +76,21 @@
 EXPORT_SYMBOL(fb_get_color_depth);
 
 /*
- * Drawing helpers.
+ * Data padding functions.
  */
-void fb_iomove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
-			   u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-			   u32 height)
-{
-	int i;
-
-	for (i = height; i--; ) {
-		buf->outbuf(info, dst, src, s_pitch);
-		src += s_pitch;
-		dst += d_pitch;
-	}
-}
-
 void fb_sysmove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
 			    u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
 			    u32 height)
 {
-	int i, j;
+	int i;
 
 	for (i = height; i--; ) {
-		for (j = 0; j < s_pitch; j++)
-			dst[j] = src[j];
+		memcpy(dst, src, s_pitch);
 		src += s_pitch;
 		dst += d_pitch;
 	}
 }
-
-void fb_iomove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
-			     u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-			     u32 height, u32 shift_high, u32 shift_low,
-			     u32 mod)
-{
-	u8 mask = (u8) (0xfff << shift_high), tmp;
-	int i, j;
-
-	for (i = height; i--; ) {
-		for (j = 0; j < idx; j++) {
-			tmp = buf->inbuf(info, dst+j);
-			tmp &= mask;
-			tmp |= *src >> shift_low;
-			buf->outbuf(info, dst+j, &tmp, 1);
-			tmp = *src << shift_high;
-			buf->outbuf(info, dst+j+1, &tmp, 1);
-			src++;
-		}
-		tmp = buf->inbuf(info, dst+idx);
-		tmp &= mask;
-		tmp |= *src >> shift_low;
-		buf->outbuf(info, dst+idx, &tmp, 1);
-		if (shift_high < mod) {
-			tmp = *src << shift_high;
-			buf->outbuf(info, dst+idx+1, &tmp, 1);
-		}	
-		src++;
-		dst += d_pitch;
-	}
-}
+EXPORT_SYMBOL(fb_sysmove_buf_aligned);
 
 void fb_sysmove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
 			      u8 *dst, u32 d_pitch, u8 *src, u32 idx,
@@ -166,6 +122,7 @@
 		dst += d_pitch;
 	}
 }
+EXPORT_SYMBOL(fb_sysmove_buf_unaligned);
 
 /*
  * we need to lock this section since fb_cursor
@@ -1357,10 +1314,6 @@
 EXPORT_SYMBOL(fb_blank);
 EXPORT_SYMBOL(fb_pan_display);
 EXPORT_SYMBOL(fb_get_buffer_offset);
-EXPORT_SYMBOL(fb_iomove_buf_unaligned);
-EXPORT_SYMBOL(fb_iomove_buf_aligned);
-EXPORT_SYMBOL(fb_sysmove_buf_unaligned);
-EXPORT_SYMBOL(fb_sysmove_buf_aligned);
 EXPORT_SYMBOL(fb_set_suspend);
 EXPORT_SYMBOL(fb_register_client);
 EXPORT_SYMBOL(fb_unregister_client);
Index: drivers/video/softcursor.c
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/drivers/video/softcursor.c  (mode:100644)
+++ uncommitted/drivers/video/softcursor.c  (mode:100644)
@@ -58,12 +58,8 @@
 	} else 
 		memcpy(src, image->data, dsize);
 	
-	if (info->pixmap.outbuf)
-		fb_iomove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
-				  s_pitch, image->height);
-	else
-		fb_sysmove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
-				   s_pitch, image->height);
+	fb_sysmove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
+				s_pitch, image->height);
 
 	image->data = dst;
 	info->fbops->fb_imageblit(info, image);
Index: include/linux/fb.h
===================================================================
--- eed337ef5e9ae7d62caa84b7974a11fddc7f06e0/include/linux/fb.h  (mode:100644)
+++ uncommitted/include/linux/fb.h  (mode:100644)
@@ -816,12 +816,6 @@
 extern int fb_prepare_logo(struct fb_info *fb_info);
 extern int fb_show_logo(struct fb_info *fb_info);
 extern char* fb_get_buffer_offset(struct fb_info *info, struct fb_pixmap *buf, u32 size);
-extern void fb_iomove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
-				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
-				u32 height, u32 shift_high, u32 shift_low, u32 mod);
-extern void fb_iomove_buf_aligned(struct fb_info *info, struct fb_pixmap *buf,
-				u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch,
-				u32 height);
 extern void fb_sysmove_buf_unaligned(struct fb_info *info, struct fb_pixmap *buf,
 				u8 *dst, u32 d_pitch, u8 *src, u32 idx,
 				u32 height, u32 shift_high, u32 shift_low, u32 mod);


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
