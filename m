From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/8] fbdev: Clean up softcursor implementation
Date: Wed, 20 Oct 2004 08:16:06 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410200816.06527.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CK43Y-0002S0-Ue
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:20 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CK43Y-0008QB-6v
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:20 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 701B973B9F
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Oct 2004 00:10:13 +0000 (UTC)
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

  - use struct fb_pixmap pixmap instead of struct fb_pixmap sprite. The softcursor
    uses fb_imageblit which also uses pixmap.

  - remove/change all references to info->cursor

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 softcursor.c |   72 ++++++++++++++++++-----------------------------------------
 1 files changed, 23 insertions(+), 49 deletions(-)

diff -Nru a/drivers/video/softcursor.c b/drivers/video/softcursor.c
--- a/drivers/video/softcursor.c	2004-10-19 20:22:19 +08:00
+++ b/drivers/video/softcursor.c	2004-10-17 15:17:54 +08:00
@@ -19,79 +19,53 @@
 
 int soft_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
-	unsigned int scan_align = info->sprite.scan_align - 1;
-	unsigned int buf_align = info->sprite.buf_align - 1;
+	unsigned int scan_align = info->pixmap.scan_align - 1;
+	unsigned int buf_align = info->pixmap.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
-	struct fb_cursor *cur;
+	struct fb_image *image;
 	u8 *dst, *src;
 
-	if (cursor->set & FB_CUR_SETSIZE) {
-		info->cursor.image.height = cursor->image.height;
-		info->cursor.image.width = cursor->image.width;
-	}
-
-	if (cursor->set & FB_CUR_SETPOS) {
-		info->cursor.image.dx = cursor->image.dx;
-		info->cursor.image.dy = cursor->image.dy;
-	}
-
-	if (cursor->set & FB_CUR_SETHOT)
-		info->cursor.hot = cursor->hot;
-	
-	if (cursor->set & FB_CUR_SETCMAP) {
-		if (cursor->image.depth == 1) {
-			info->cursor.image.bg_color = cursor->image.bg_color;
-			info->cursor.image.fg_color = cursor->image.fg_color;
-		} else {
-			if (cursor->image.cmap.len)
-				fb_copy_cmap(&cursor->image.cmap, &info->cursor.image.cmap);
-		}
-		info->cursor.image.depth = cursor->image.depth;
-	}	
-
-	info->cursor.image.data = cursor->image.data;
-
 	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
-	src = kmalloc(64 + sizeof(struct fb_cursor), GFP_ATOMIC);
+	src = kmalloc(64 + sizeof(struct fb_image), GFP_ATOMIC);
+
 	if (!src)
 		return -ENOMEM;
-	cur = (struct fb_cursor *) (src + 64);
-	*cur = info->cursor;
 
-	s_pitch = (info->cursor.image.width + 7) >> 3;
-	dsize = s_pitch * info->cursor.image.height;
+	image = (struct fb_image *) (src + 64);
+	*image = cursor->image;
+	s_pitch = (image->width + 7) >> 3;
+	dsize = s_pitch * image->height;
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
-	size = d_pitch * info->cursor.image.height + buf_align;
+	size = d_pitch * image->height + buf_align;
 	size &= ~buf_align;
-	dst = fb_get_buffer_offset(info, &info->sprite, size);
+	dst = fb_get_buffer_offset(info, &info->pixmap, size);
 
-	if (info->cursor.enable) {
-		switch (info->cursor.rop) {
+	if (cursor->enable) {
+		switch (cursor->rop) {
 		case ROP_XOR:
 			for (i = 0; i < dsize; i++)
-				src[i] = cursor->image.data[i] ^ info->cursor.mask[i]; 
+				src[i] = image->data[i] ^ cursor->mask[i];
 			break;
 		case ROP_COPY:
 		default:
 			for (i = 0; i < dsize; i++)
-				src[i] = cursor->image.data[i] & info->cursor.mask[i];
+				src[i] = image->data[i] & cursor->mask[i];
 			break;
 		}
 	} else 
-		memcpy(src, cursor->image.data, dsize);
+		memcpy(src, image->data, dsize);
 	
-	if (info->sprite.outbuf)
-		fb_iomove_buf_aligned(info, &info->sprite, dst, d_pitch, src,
-				  s_pitch, info->cursor.image.height);
+	if (info->pixmap.outbuf)
+		fb_iomove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
+				  s_pitch, image->height);
 	else
-		fb_sysmove_buf_aligned(info, &info->sprite, dst, d_pitch, src,
-				   s_pitch, info->cursor.image.height);
-	cur->image.data = dst;
-	
-	info->fbops->fb_imageblit(info, &cur->image);
+		fb_sysmove_buf_aligned(info, &info->pixmap, dst, d_pitch, src,
+				   s_pitch, image->height);
 
+	image->data = dst;
+	info->fbops->fb_imageblit(info, image);
 	kfree(src);
 
 	return 0;




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
