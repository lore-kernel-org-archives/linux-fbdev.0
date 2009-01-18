From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] fbdev: correct tests on unsigned
Date: Sun, 18 Jan 2009 21:07:13 +0100
Message-ID: <49738BF1.2030908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1LOdvT-0005XT-87
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 20:07:19 +0000
Received: from mail-ew0-f21.google.com ([209.85.219.21])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LOdvP-0003U0-1D for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 18 Jan 2009 20:07:19 +0000
Received: by ewy14 with SMTP id 14so416388ewy.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 18 Jan 2009 12:07:12 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net

image->dx, ->dy and con2fb.framebuffer are unsigned, so the tests for
negatives are wrong or redundant. correct them.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 756efeb..4f576bb 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -393,8 +393,10 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dx += image->width + 8;
 		}
 	} else if (rotate == FB_ROTATE_UD) {
-		for (x = 0; x < num && image->dx >= 0; x++) {
+		for (x = 0; x < num; x++) {
 			info->fbops->fb_imageblit(info, image);
+			if (image->dx < image->width + 8)
+				break;
 			image->dx -= image->width + 8;
 		}
 	} else if (rotate == FB_ROTATE_CW) {
@@ -405,8 +407,10 @@ static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
 			image->dy += image->height + 8;
 		}
 	} else if (rotate == FB_ROTATE_CCW) {
-		for (x = 0; x < num && image->dy >= 0; x++) {
+		for (x = 0; x < num; x++) {
 			info->fbops->fb_imageblit(info, image);
+			if (image->dx < image->width + 8)
+				break;
 			image->dy -= image->height + 8;
 		}
 	}
@@ -1094,7 +1098,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			ret = -EINVAL;
 			break;
 		}
-		if (con2fb.framebuffer < 0 || con2fb.framebuffer >= FB_MAX) {
+		if (con2fb.framebuffer >= FB_MAX) {
 			ret = -EINVAL;
 			break;
 		}

------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
