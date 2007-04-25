From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 12/41] s3fb: Add sparse annotations
Date: Wed, 25 Apr 2007 14:32:26 +0800
Message-ID: <462EF5FA.4080506@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc6F-0000x8-Fq for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:39:39 -0700
Received: from nz-out-0506.google.com ([64.233.162.225])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc6F-00035g-6w
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:39:39 -0700
Received: by nz-out-0506.google.com with SMTP id i11so416511nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:39:38 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Add sparse annotations and use fb_read/fb_write and family to access the
framebuffer.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index c348813..f3470bb 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -164,7 +164,7 @@ MODULE_PARM_DESC(fasttext, "Enable S3 fa
 static void s3fb_settile_fast(struct fb_info *info, struct fb_tilemap *map)
 {
 	const u8 *font = map->data;
-	u8* fb = (u8 *) info->screen_base;
+	u8 __iomem *fb = (u8 __iomem *) info->screen_base;
 	int i, c;
 
 	if ((map->width != 8) || (map->height != 16) ||
@@ -177,7 +177,7 @@ static void s3fb_settile_fast(struct fb_
 	fb += 2;
 	for (i = 0; i < map->height; i++) {
 		for (c = 0; c < map->length; c++) {
-			fb[c * 4] = font[c * map->height + i];
+			fb_writeb(font[c * map->height + i], fb + c * 4);
 		}
 		fb += 1024;
 	}
@@ -656,7 +656,7 @@ static int s3fb_set_par(struct fb_info *
 	value = ((value * hmul) / 8) - 5;
 	vga_wcrt(NULL, 0x3C, (value + 1) / 2);
 
-	memset((u8*)info->screen_base, 0x00, screen_size);
+	memset_io(info->screen_base, 0x00, screen_size);
 	/* Device and screen back on */
 	svga_wcrt_mask(0x17, 0x80, 0x80);
 	svga_wseq_mask(0x01, 0x00, 0x20);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
