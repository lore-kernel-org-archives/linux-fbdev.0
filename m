From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 2/6] fbdev: fb_do_show_logo() updates
Date: Tue, 30 Jan 2007 19:01:43 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701301901260.2830@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301854060.2509@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBxIp-00063N-TQ for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 10:01:55 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBxIm-0001I9-U4
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 10:01:55 -0800
In-Reply-To: <Pine.LNX.4.62.0701301854060.2509@pademelon.sonytel.be>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>

fb_do_show_logo() updates:
  - Use width and height of the passed image instead of the global variable
    fb_logo
  - Explicitly pass the number of logos to draw

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/video/fbmem.c |   32 ++++++++++++++------------------
 1 files changed, 14 insertions(+), 18 deletions(-)

--- geert-linux-src.orig/drivers/video/fbmem.c
+++ geert-linux-src/drivers/video/fbmem.c
@@ -377,37 +377,33 @@ static void fb_rotate_logo(struct fb_inf
 }
 
 static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
-			    int rotate)
+			    int rotate, int num)
 {
 	int x;
 
 	if (rotate == FB_ROTATE_UR) {
-		for (x = 0; x < num_online_cpus() &&
-			     x * (fb_logo.logo->width + 8) <=
-			     info->var.xres - fb_logo.logo->width; x++) {
+		for (x = 0;
+		     x < num && image->dx + image->width <= info->var.xres;
+		     x++) {
 			info->fbops->fb_imageblit(info, image);
-			image->dx += fb_logo.logo->width + 8;
+			image->dx += image->width + 8;
 		}
 	} else if (rotate == FB_ROTATE_UD) {
-		for (x = 0; x < num_online_cpus() &&
-			     x * (fb_logo.logo->width + 8) <=
-			     info->var.xres - fb_logo.logo->width; x++) {
+		for (x = 0; x < num && image->dx >= 0; x++) {
 			info->fbops->fb_imageblit(info, image);
-			image->dx -= fb_logo.logo->width + 8;
+			image->dx -= image->width + 8;
 		}
 	} else if (rotate == FB_ROTATE_CW) {
-		for (x = 0; x < num_online_cpus() &&
-			     x * (fb_logo.logo->width + 8) <=
-			     info->var.yres - fb_logo.logo->width; x++) {
+		for (x = 0;
+		     x < num && image->dy + image->height <= info->var.yres;
+		     x++) {
 			info->fbops->fb_imageblit(info, image);
-			image->dy += fb_logo.logo->width + 8;
+			image->dy += image->height + 8;
 		}
 	} else if (rotate == FB_ROTATE_CCW) {
-		for (x = 0; x < num_online_cpus() &&
-			     x * (fb_logo.logo->width + 8) <=
-			     info->var.yres - fb_logo.logo->width; x++) {
+		for (x = 0; x < num && image->dy >= 0; x++) {
 			info->fbops->fb_imageblit(info, image);
-			image->dy -= fb_logo.logo->width + 8;
+			image->dy -= image->height + 8;
 		}
 	}
 }
@@ -533,7 +529,7 @@ int fb_show_logo(struct fb_info *info, i
 			fb_rotate_logo(info, logo_rotate, &image, rotate);
 	}
 
-	fb_do_show_logo(info, &image, rotate);
+	fb_do_show_logo(info, &image, rotate, num_online_cpus());
 
 	kfree(palette);
 	if (saved_pseudo_palette != NULL)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
