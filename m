From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 7/8] fbdev: Cleanup rivafb cursor implementation
Date: Wed, 20 Oct 2004 08:16:18 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410200816.18347.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CK43e-0002TT-N2
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:26 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CK43d-0005Cb-Ia
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:26 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 05E209324BF
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Oct 2004 00:10:20 +0000 (UTC)
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

  - remove/modify all references to info->cursor

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 fbdev.c  |   55 ++++++++++++++++++++++++++-----------------------------
 rivafb.h |    1 +
 2 files changed, 27 insertions(+), 29 deletions(-)

diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2004-10-17 13:37:00 +08:00
+++ b/drivers/video/riva/fbdev.c	2004-10-17 15:10:59 +08:00
@@ -1166,7 +1166,7 @@
 	riva_load_video_mode(info);
 	riva_setup_accel(info);
 	
-	memset_io(par->riva.CURSOR, 0, MAX_CURS * MAX_CURS * 2);
+	par->cursor_reset = 1;
 	info->fix.line_length = (info->var.xres_virtual * (info->var.bits_per_pixel >> 3));
 	info->fix.visual = (info->var.bits_per_pixel == 8) ?
 				FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_DIRECTCOLOR;
@@ -1552,15 +1552,21 @@
 	struct riva_par *par = (struct riva_par *) info->par;
 	u8 data[MAX_CURS * MAX_CURS/8];
 	u16 fg, bg;
-	int i;
+	int i, set = cursor->set;
 
 	par->riva.ShowHideCursor(&par->riva, 0);
 
-	if (cursor->set & FB_CUR_SETPOS) {
+	if (par->cursor_reset) {
+		set = FB_CUR_SETALL;
+		par->cursor_reset = 0;
+	}
+
+	if (set & FB_CUR_SETSIZE)
+		memset_io(par->riva.CURSOR, 0, MAX_CURS * MAX_CURS * 2);
+
+	if (set & FB_CUR_SETPOS) {
 		u32 xx, yy, temp;
 
-		info->cursor.image.dx = cursor->image.dx;
-		info->cursor.image.dy = cursor->image.dy;
 		yy = cursor->image.dy - info->var.yoffset;
 		xx = cursor->image.dx - info->var.xoffset;
 		temp = xx & 0xFFFF;
@@ -1569,43 +1575,32 @@
 		par->riva.PRAMDAC[0x0000300/4] = temp;
 	}
 
-	if (cursor->set & FB_CUR_SETSIZE) {
-		info->cursor.image.height = cursor->image.height;
-		info->cursor.image.width = cursor->image.width;
-		memset_io(par->riva.CURSOR, 0, MAX_CURS * MAX_CURS * 2);
-	}
-
-	if (cursor->set & FB_CUR_SETCMAP) {
-		info->cursor.image.bg_color = cursor->image.bg_color;
-		info->cursor.image.fg_color = cursor->image.fg_color;
-	}
 
-	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP | FB_CUR_SETCUR)) {
-		u32 bg_idx = info->cursor.image.bg_color;
-		u32 fg_idx = info->cursor.image.fg_color;
-		u32 s_pitch = (info->cursor.image.width+7) >> 3;
+	if (set & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP | FB_CUR_SETIMAGE)) {
+		u32 bg_idx = cursor->image.bg_color;
+		u32 fg_idx = cursor->image.fg_color;
+		u32 s_pitch = (cursor->image.width+7) >> 3;
 		u32 d_pitch = MAX_CURS/8;
 		u8 *dat = (u8 *) cursor->image.data;
-		u8 *msk = (u8 *) info->cursor.mask;
+		u8 *msk = (u8 *) cursor->mask;
 		u8 src[64];	
 		
-		info->cursor.image.data = cursor->image.data;
-		switch (info->cursor.rop) {
+		switch (cursor->rop) {
 		case ROP_XOR:
-			for (i = 0; i < s_pitch * info->cursor.image.height;
+			for (i = 0; i < s_pitch * cursor->image.height;
 			     i++)
 				src[i] = dat[i] ^ msk[i];
 			break;
 		case ROP_COPY:
 		default:
-			for (i = 0; i < s_pitch * info->cursor.image.height;
+			for (i = 0; i < s_pitch * cursor->image.height;
 			     i++)
 				src[i] = dat[i] & msk[i];
 			break;
 		}
 		
-		fb_sysmove_buf_aligned(info, &info->sprite, data, d_pitch, src,
-				       s_pitch, info->cursor.image.height);
+		fb_sysmove_buf_aligned(info, &info->pixmap, data, d_pitch, src,
+				       s_pitch, cursor->image.height);
 
 		bg = ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 		     ((info->cmap.green[bg_idx] & 0xf8) << 2) |
@@ -1618,11 +1613,13 @@
 		par->riva.LockUnlock(&par->riva, 0);
 
 		rivafb_load_cursor_image(par, data, bg, fg,
-					 info->cursor.image.width, 
-					 info->cursor.image.height);
+					 cursor->image.width,
+					 cursor->image.height);
 	}
-	if (info->cursor.enable)
+
+	if (cursor->enable)
 		par->riva.ShowHideCursor(&par->riva, 1);
+
 	return 0;
 }
 
diff -Nru a/drivers/video/riva/rivafb.h b/drivers/video/riva/rivafb.h
--- a/drivers/video/riva/rivafb.h	2004-10-19 20:24:19 +08:00
+++ b/drivers/video/riva/rivafb.h	2004-10-17 15:11:14 +08:00
@@ -62,6 +62,7 @@
 	int FlatPanel;
 	struct pci_dev *pdev;
 	int bus;
+	int cursor_reset;
 #ifdef CONFIG_MTRR
 	struct { int vram; int vram_valid; } mtrr;
 #endif




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
