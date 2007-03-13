From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 2/3] fbdev: fb_do_show_logo() updates
Date: Tue, 13 Mar 2007 15:14:41 +0100
Message-ID: <20070313141512.270528000@sonycom.com>
References: <20070313141439.295232000@sonycom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HR7nz-00075s-5u for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:16:47 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HR7nx-0000Vm-Mk
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:16:47 -0700
Content-Disposition: inline; filename=spe-logo/fb_do_show_logo.diff
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>, Geoff Levand <geoffrey.levand@am.sony.com>, "Antonino A. Daplas" <adaplas@gmail.com>

fb_do_show_logo() updates:
  - Use width and height of the passed image instead of the global variable
    fb_logo
  - Explicitly pass the number of logos to draw

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-By: James Simmons <jsimmons@infradead.org>
---
 drivers/video/fbmem.c |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)

--- ps3-linux-2.6.21-rc3.orig/drivers/video/fbmem.c
+++ ps3-linux-2.6.21-rc3/drivers/video/fbmem.c
@@ -376,37 +376,33 @@ static void fb_rotate_logo(struct fb_inf
 }
 
 static void fb_do_show_logo(struct fb_info *info, struct fb_image *image,
-			    int rotate)
+			    int rotate, unsigned int num)
 {
-	int x;
+	unsigned int x;
 
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
@@ -532,7 +528,7 @@ int fb_show_logo(struct fb_info *info, i
 			fb_rotate_logo(info, logo_rotate, &image, rotate);
 	}
 
-	fb_do_show_logo(info, &image, rotate);
+	fb_do_show_logo(info, &image, rotate, num_online_cpus());
 
 	kfree(palette);
 	if (saved_pseudo_palette != NULL)

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
