From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 6/8] fbdev: Clean up i810fb cursor implementation
Date: Wed, 20 Oct 2004 08:16:12 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410200816.12548.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CK43a-0002Sb-VN
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:22 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CK43a-0008Qv-9S
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 19 Oct 2004 17:10:22 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BEB2493252E
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 20 Oct 2004 00:10:16 +0000 (UTC)
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
 i810_main.c |   40 ++++++++++++++--------------------------
 1 files changed, 14 insertions(+), 26 deletions(-)

diff -Nru a/drivers/video/i810/i810_main.c b/drivers/video/i810/i810_main.c
--- a/drivers/video/i810/i810_main.c	2004-10-05 05:47:26 +08:00
+++ b/drivers/video/i810/i810_main.c	2004-10-17 15:13:34 +08:00
@@ -1416,62 +1416,50 @@
 
 	i810_enable_cursor(mmio, OFF);
 
-	if (cursor->set & FB_CUR_SETHOT)
-		info->cursor.hot = cursor->hot;
-	
 	if (cursor->set & FB_CUR_SETPOS) {
 		u32 tmp;
 
-		info->cursor.image.dx = cursor->image.dx;
-		info->cursor.image.dy = cursor->image.dy;
-		tmp = (info->cursor.image.dx - info->var.xoffset) & 0xffff;
-		tmp |= (info->cursor.image.dy - info->var.yoffset) << 16;
+		tmp = (cursor->image.dx - info->var.xoffset) & 0xffff;
+		tmp |= (cursor->image.dy - info->var.yoffset) << 16;
 		i810_writel(CURPOS, mmio, tmp);
 	}
 
-	if (cursor->set & FB_CUR_SETSIZE) {
+	if (cursor->set & FB_CUR_SETSIZE)
 		i810_reset_cursor_image(par);
-		info->cursor.image.height = cursor->image.height;
-		info->cursor.image.width = cursor->image.width;
-	}
 
-	if (cursor->set & FB_CUR_SETCMAP) {
+	if (cursor->set & FB_CUR_SETCMAP)
 		i810_load_cursor_colors(cursor->image.fg_color,
 					cursor->image.bg_color,
 					info);
-		info->cursor.image.fg_color = cursor->image.fg_color;
-		info->cursor.image.bg_color = cursor->image.bg_color;
-
-	}
 
-	if (cursor->set & (FB_CUR_SETSHAPE)) {
-		int size = ((info->cursor.image.width + 7) >> 3) * 
-			info->cursor.image.height;
+	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETIMAGE)) {
+		int size = ((cursor->image.width + 7) >> 3) *
+			cursor->image.height;
 		int i;
 		u8 *data = kmalloc(64 * 8, GFP_KERNEL);
 
 		if (data == NULL)
 			return -ENOMEM;
-		info->cursor.image.data = cursor->image.data;
 
-		switch (info->cursor.rop) {
+		switch (cursor->rop) {
 		case ROP_XOR:
 			for (i = 0; i < size; i++)
-				data[i] = info->cursor.image.data[i] ^ info->cursor.mask[i];
+				data[i] = cursor->image.data[i] ^ cursor->mask[i];
 			break;
 		case ROP_COPY:
 		default:
 			for (i = 0; i < size; i++)
-				data[i] = info->cursor.image.data[i] & info->cursor.mask[i];
+				data[i] = cursor->image.data[i] & cursor->mask[i];
 			break;
 		}
-		i810_load_cursor_image(info->cursor.image.width, 
-				       info->cursor.image.height, data,
+
+		i810_load_cursor_image(cursor->image.width,
+				       cursor->image.height, data,
 				       par);
 		kfree(data);
 	}
 
-	if (info->cursor.enable)
+	if (cursor->enable)
 		i810_enable_cursor(mmio, ON);
 
 	return 0;




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
