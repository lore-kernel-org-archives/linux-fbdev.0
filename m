From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] fbdev: Fix test on unsigned in
	fb_do_show_logo()
Date: Sat, 17 Oct 2009 00:45:14 +0200
Message-ID: <4AD8F77A.3010802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1MyvOk-0008AS-PK
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Oct 2009 22:35:46 +0000
Received: from ey-out-1920.google.com ([74.125.78.149])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MyvOe-0005s0-41 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Oct 2009 22:35:46 +0000
Received: by ey-out-1920.google.com with SMTP id 3so492436eyh.40
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 16 Oct 2009 15:35:33 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, Antonino Daplas <adaplas@gmail.com>

image->d[xy] are unsigned so the check was wrong.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 99bbd28..9f20641 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -403,7 +403,8 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dx += image->width + 8;
 		}
 	} else if (rotate == FB_ROTATE_UD) {
-		for (x = 0; x < num && image->dx >= 0; x++) {
+		for (x = 0; x < num && image->dx + image->width + 8 >= 0;
+				x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dx -= image->width + 8;
 		}
@@ -415,7 +416,8 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dy += image->height + 8;
 		}
 	} else if (rotate == FB_ROTATE_CCW) {
-		for (x = 0; x < num && image->dy >= 0; x++) {
+		for (x = 0; x < num && image->dy + image->height + 8 >= 0;
+				x++) {
 			info->fbops->fb_imageblit(info, image);
 			image->dy -= image->height + 8;
 		}

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
