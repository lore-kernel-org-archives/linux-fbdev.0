From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 8/8] fbdev: Clean up mach64 cursor implementation
Date: Wed, 20 Oct 2004 08:16:25 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410200816.25527.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CK43l-0002VN-LU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:33 -0700
Received: from smtp-out.hotpop.com ([38.113.3.51])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CK43k-0005DT-Rb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:33 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D383F74105
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Oct 2004 00:10:23 +0000 (UTC)
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
Cc: Alexander Kern <alex.kern@gmx.de>

  - remove/modify all references to info->cursor

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 mach64_cursor.c |   35 ++++++++++-------------------------
 1 files changed, 10 insertions(+), 25 deletions(-)

diff -Nru a/drivers/video/aty/mach64_cursor.c b/drivers/video/aty/mach64_cursor.c
--- a/drivers/video/aty/mach64_cursor.c	2004-10-09 00:22:38 +08:00
+++ b/drivers/video/aty/mach64_cursor.c	2004-10-17 16:15:23 +08:00
@@ -88,22 +88,9 @@
 	wait_for_fifo(1, par);
 	aty_st_le32(GEN_TEST_CNTL, aty_ld_le32(GEN_TEST_CNTL, par) & ~HWCURSOR_ENABLE, par);
 
-	/* Set size */
-	if (cursor->set & FB_CUR_SETSIZE) {
-		info->cursor.image.height = cursor->image.height;
-		info->cursor.image.width = cursor->image.width;
-	}
-
-	/* Set hot spot */
-	if  (cursor->set & FB_CUR_SETHOT)
-		info->cursor.hot = cursor->hot;
-
 	/* set position */
 	if (cursor->set & FB_CUR_SETPOS) {
-		info->cursor.image.dx = cursor->image.dx;
-		info->cursor.image.dy = cursor->image.dy;
-
-		x = info->cursor.image.dx - info->cursor.hot.x - info->var.xoffset;
+		x = cursor->image.dx - cursor->hot.x - info->var.xoffset;
 		if (x < 0) {
 			xoff = -x;
 			x = 0;
@@ -111,7 +98,7 @@
 			xoff = 0;
 		}
 
-		y = info->cursor.image.dy - info->cursor.hot.y - info->var.yoffset;
+		y = cursor->image.dy - cursor->hot.y - info->var.yoffset;
 		if (y < 0) {
 			yoff = -y;
 			y = 0;
@@ -128,7 +115,7 @@
 		wait_for_fifo(4, par);
 		aty_st_le32(CUR_OFFSET, (info->fix.smem_len >> 3) + (yoff << 1), par);
 		aty_st_le32(CUR_HORZ_VERT_OFF,
-			    ((u32) (64 - info->cursor.image.height + yoff) << 16) | xoff,
+			    ((u32) (64 - cursor->image.height + yoff) << 16) | xoff,
 			    par);
 		aty_st_le32(CUR_HORZ_VERT_POSN, ((u32) y << 16) | x, par);
 	}
@@ -137,10 +124,8 @@
 	if (cursor->set & FB_CUR_SETCMAP) {
 		u32 fg_idx, bg_idx, fg, bg;
 
-		info->cursor.image.fg_color = cursor->image.fg_color;
-		info->cursor.image.bg_color = cursor->image.bg_color;
-		fg_idx = info->cursor.image.fg_color;
-		bg_idx = info->cursor.image.bg_color;
+		fg_idx = cursor->image.fg_color;
+		bg_idx = cursor->image.bg_color;
 
 		fg = (info->cmap.red[fg_idx] << 24) |
 		     (info->cmap.green[fg_idx] << 16) |
@@ -155,12 +140,12 @@
 		aty_st_le32(CUR_CLR1, fg, par);
 	}
 
-	if (cursor->set & FB_CUR_SETSHAPE) {
+	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
 	    u8 *src = (u8 *)cursor->image.data;
-	    u8 *msk = (u8 *)info->cursor.mask;
+	    u8 *msk = (u8 *)cursor->mask;
 	    u8 *dst = (u8 *)info->sprite.addr;
-	    unsigned int width = (info->cursor.image.width + 7) >> 3;
-	    unsigned int height = info->cursor.image.height;
+	    unsigned int width = (cursor->image.width + 7) >> 3;
+	    unsigned int height = cursor->image.height;
 	    unsigned int align = info->sprite.scan_align;
 
 	    unsigned int i, j, offset;
@@ -175,7 +160,7 @@
 		for (j = 0; j < width; j++) {
 			b = *src++;
 			m = *msk++;
-			switch (info->cursor.rop) {
+			switch (cursor->rop) {
 			case ROP_XOR:
 			    // Upper 4 bits of mask data
 			    fb_writeb(cursor_mask_lookup[m >> 4 ] |




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
