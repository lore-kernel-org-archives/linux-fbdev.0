From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/8] fbdev: Support for bigger than 16x32 fonts in rivafb cursor
Date: Thu, 11 Nov 2004 10:15:25 +0800
Message-ID: <20041111022439.D65241A0228@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CS4eL-00053b-F5
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:25:25 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CS4eK-0006nA-Ez
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Nov 2004 18:25:25 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 818529D86C4
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 11 Nov 2004 02:25:14 +0000 (UTC)
Content-Disposition: inline
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

- Add support for fonts bigger thatn 16x32 by dynamically allocating buffer
  based on font dimensions instead of statically allocating at 64 bytes.
- use softcursor if cursor size exceeds 32x32.
- fix rivafb_cursor if cursor width is not divisible by 2

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbdev.c |   72 ++++++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 43 insertions(+), 29 deletions(-)

diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2004-11-10 06:15:06 +08:00
+++ b/drivers/video/riva/fbdev.c	2004-11-10 07:37:11 +08:00
@@ -444,6 +444,8 @@
 	bg = le16_to_cpu(bg);
 	fg = le16_to_cpu(fg);
 
+	w = (w + 1) & ~1;
+
 	for (i = 0; i < h; i++) {
 		b = *data++;
 		reverse_order(&b);
@@ -1577,6 +1579,10 @@
 	u16 fg, bg;
 	int i, set = cursor->set;
 
+	if (cursor->image.width > MAX_CURS ||
+	    cursor->image.height > MAX_CURS)
+		return soft_cursor(info, cursor);
+
 	par->riva.ShowHideCursor(&par->riva, 0);
 
 	if (par->cursor_reset) {
@@ -1606,38 +1612,46 @@
 		u32 d_pitch = MAX_CURS/8;
 		u8 *dat = (u8 *) cursor->image.data;
 		u8 *msk = (u8 *) cursor->mask;
-		u8 src[64];	
-		
-		switch (cursor->rop) {
-		case ROP_XOR:
-			for (i = 0; i < s_pitch * cursor->image.height;
-			     i++)
-				src[i] = dat[i] ^ msk[i];
-			break;
-		case ROP_COPY:
-		default:
-			for (i = 0; i < s_pitch * cursor->image.height;
-			     i++)
-				src[i] = dat[i] & msk[i];
-			break;
-		}
+		u8 *src;
 		
-		fb_sysmove_buf_aligned(info, &info->pixmap, data, d_pitch, src,
-				       s_pitch, cursor->image.height);
+		src = kmalloc(s_pitch * cursor->image.height, GFP_ATOMIC);
 
-		bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
-		     ((info->cmap.green[bg_idx] & 0xf8) << 2) |
-		     ((info->cmap.blue[bg_idx] & 0xf8) >> 3) | 1 << 15;
-
-		fg = ((info->cmap.red[fg_idx] & 0xf8) << 7) |
-		     ((info->cmap.green[fg_idx] & 0xf8) << 2) |
-		     ((info->cmap.blue[fg_idx] & 0xf8) >> 3) | 1 << 15;
-
-		par->riva.LockUnlock(&par->riva, 0);
+		if (src) {
+			switch (cursor->rop) {
+			case ROP_XOR:
+				for (i = 0; i < s_pitch * cursor->image.height;
+				     i++)
+					src[i] = dat[i] ^ msk[i];
+				break;
+			case ROP_COPY:
+			default:
+				for (i = 0; i < s_pitch * cursor->image.height;
+				     i++)
+					src[i] = dat[i] & msk[i];
+				break;
+			}
 
-		rivafb_load_cursor_image(par, data, bg, fg,
-					 cursor->image.width,
-					 cursor->image.height);
+			fb_sysmove_buf_aligned(info, &info->pixmap, data,
+					       d_pitch, src, s_pitch,
+					       cursor->image.height);
+
+			bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
+				((info->cmap.green[bg_idx] & 0xf8) << 2) |
+				((info->cmap.blue[bg_idx] & 0xf8) >> 3) |
+				1 << 15;
+
+			fg = ((info->cmap.red[fg_idx] & 0xf8) << 7) |
+				((info->cmap.green[fg_idx] & 0xf8) << 2) |
+				((info->cmap.blue[fg_idx] & 0xf8) >> 3) |
+				1 << 15;
+
+			par->riva.LockUnlock(&par->riva, 0);
+
+			rivafb_load_cursor_image(par, data, bg, fg,
+						 cursor->image.width,
+						 cursor->image.height);
+			kfree(src);
+		}
 	}
 
 	if (cursor->enable)




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
