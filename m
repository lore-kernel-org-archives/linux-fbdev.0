From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH][RESUBMIT] fbdev: Fix kernel panic from FBIO_CURSOR ioctl
Date: Mon, 30 Aug 2004 20:11:35 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200408302011.35984.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C1l2S-00074Y-2Y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 05:13:32 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C1l2R-0006NM-7W
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 30 Aug 2004 05:13:31 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 7644810B23F2
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 30 Aug 2004 12:13:25 +0000 (UTC)
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

1. This fixes a kernel oops when issuing an FBIO_CURSOR ioctl if struct
fb_cursor_user is filled with zero/NULLs. Reported by Yuval Kogman
<nothingmuch@woobling.org>.

2. This also fixes the cursor corruption in soft_cursor when
sprite.scan_align != 1.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmem.c      |   18 +++++++++++-------
 softcursor.c |   18 +++++++++++++++---
 2 files changed, 26 insertions(+), 10 deletions(-)

diff -uprN linux-2.6.9-rc1-mm1-orig/drivers/video/fbmem.c linux-2.6.9-rc1-mm1/drivers/video/fbmem.c
--- linux-2.6.9-rc1-mm1-orig/drivers/video/fbmem.c	2004-08-30 08:15:35.000000000 +0800
+++ linux-2.6.9-rc1-mm1/drivers/video/fbmem.c	2004-08-30 08:24:22.986434720 +0800
@@ -1018,7 +1018,7 @@ fb_cursor(struct fb_info *info, struct f
 {
 	struct fb_cursor_user cursor_user;
 	struct fb_cursor cursor;
-	char *data = NULL, *mask = NULL;
+	char *data = NULL, *mask = NULL, *info_mask = NULL;
 	u16 *red = NULL, *green = NULL, *blue = NULL, *transp = NULL;
 	int err = -EINVAL;
 	
@@ -1026,12 +1026,12 @@ fb_cursor(struct fb_info *info, struct f
 		return -EFAULT;
 
 	memcpy(&cursor, &cursor_user, sizeof(cursor_user));
-	cursor.mask = NULL;
-	cursor.image.data = NULL;
-	cursor.image.cmap.red = NULL;
-	cursor.image.cmap.green = NULL;
-	cursor.image.cmap.blue = NULL;
-	cursor.image.cmap.transp = NULL;
+	cursor.mask = info->cursor.mask;
+	cursor.image.data = info->cursor.image.data;
+	cursor.image.cmap.red = info->cursor.image.cmap.red;
+	cursor.image.cmap.green = info->cursor.image.cmap.green;
+	cursor.image.cmap.blue = info->cursor.image.cmap.blue;
+	cursor.image.cmap.transp = info->cursor.image.cmap.transp;
 	cursor.data = NULL;
 
 	if (cursor.set & FB_CUR_SETCUR)
@@ -1091,6 +1091,8 @@ fb_cursor(struct fb_info *info, struct f
 		
 		cursor.image.data = data;
 		cursor.mask = mask;
+		info_mask = (char *) info->cursor.mask;
+		info->cursor.mask = mask;
 	}
 	info->cursor.set = cursor.set;
 	info->cursor.rop = cursor.rop;
@@ -1102,6 +1104,8 @@ out:
 	kfree(green);
 	kfree(blue);
 	kfree(transp);
+	if (info_mask)
+		info->cursor.mask = info_mask;
 	return err;
 }
 
diff -uprN linux-2.6.9-rc1-mm1-orig/drivers/video/softcursor.c linux-2.6.9-rc1-mm1/drivers/video/softcursor.c
--- linux-2.6.9-rc1-mm1-orig/drivers/video/softcursor.c	2004-08-30 05:54:14.000000000 +0800
+++ linux-2.6.9-rc1-mm1/drivers/video/softcursor.c	2004-08-30 08:15:58.000000000 +0800
@@ -22,7 +22,8 @@ int soft_cursor(struct fb_info *info, st
 	unsigned int scan_align = info->sprite.scan_align - 1;
 	unsigned int buf_align = info->sprite.buf_align - 1;
 	unsigned int i, size, dsize, s_pitch, d_pitch;
-	u8 *dst, src[64];
+	struct fb_cursor *cur;
+	u8 *dst, *src;
 
 	if (cursor->set & FB_CUR_SETSIZE) {
 		info->cursor.image.height = cursor->image.height;
@@ -48,9 +49,17 @@ int soft_cursor(struct fb_info *info, st
 		info->cursor.image.depth = cursor->image.depth;
 	}	
 
+	info->cursor.image.data = cursor->image.data;
+
 	if (info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
+	src = kmalloc(64 + sizeof(struct fb_cursor), GFP_ATOMIC);
+	if (!src)
+		return -ENOMEM;
+	cur = (struct fb_cursor *) (src + 64);
+	*cur = info->cursor;
+
 	s_pitch = (info->cursor.image.width + 7) >> 3;
 	dsize = s_pitch * info->cursor.image.height;
 	d_pitch = (s_pitch + scan_align) & ~scan_align;
@@ -79,9 +88,12 @@ int soft_cursor(struct fb_info *info, st
 	else
 		fb_sysmove_buf_aligned(info, &info->sprite, dst, d_pitch, src,
 				   s_pitch, info->cursor.image.height);
-	info->cursor.image.data = dst;
+	cur->image.data = dst;
 	
-	info->fbops->fb_imageblit(info, &info->cursor.image);
+	info->fbops->fb_imageblit(info, &cur->image);
+
+	kfree(src);
+
 	return 0;
 }
 





-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
