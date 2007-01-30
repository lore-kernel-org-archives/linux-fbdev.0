From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 3/6] fbdev: extract fb_show_logo_line()
Date: Tue, 30 Jan 2007 19:02:03 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701301901450.2830@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701301854060.2509@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBxJH-00069L-Gc for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 10:02:23 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBxJ8-0004QH-4j
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 10:02:23 -0800
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

Extract the code to draw one line of logos into fb_show_logo_line()

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/video/fbmem.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

--- geert-linux-src.orig/drivers/video/fbmem.c
+++ geert-linux-src/drivers/video/fbmem.c
@@ -473,21 +473,22 @@ int fb_prepare_logo(struct fb_info *info
 	return fb_logo.logo->height;
 }
 
-int fb_show_logo(struct fb_info *info, int rotate)
+static int fb_show_logo_line(struct fb_info *info, int rotate,
+			     const struct linux_logo *logo, int y, int n)
 {
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
 	unsigned char *logo_new = NULL, *logo_rotate = NULL;
 	struct fb_image image;
 
 	/* Return if the frame buffer is not mapped or suspended */
-	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING)
+	if (logo == NULL || info->state != FBINFO_STATE_RUNNING)
 		return 0;
 
 	image.depth = 8;
-	image.data = fb_logo.logo->data;
+	image.data = logo->data;
 
 	if (fb_logo.needs_cmapreset)
-		fb_set_logocmap(info, fb_logo.logo);
+		fb_set_logocmap(info, logo);
 
 	if (fb_logo.needs_truepalette || 
 	    fb_logo.needs_directpalette) {
@@ -496,17 +497,16 @@ int fb_show_logo(struct fb_info *info, i
 			return 0;
 
 		if (fb_logo.needs_truepalette)
-			fb_set_logo_truepalette(info, fb_logo.logo, palette);
+			fb_set_logo_truepalette(info, logo, palette);
 		else
-			fb_set_logo_directpalette(info, fb_logo.logo, palette);
+			fb_set_logo_directpalette(info, logo, palette);
 
 		saved_pseudo_palette = info->pseudo_palette;
 		info->pseudo_palette = palette;
 	}
 
 	if (fb_logo.depth <= 4) {
-		logo_new = kmalloc(fb_logo.logo->width * fb_logo.logo->height, 
-				   GFP_KERNEL);
+		logo_new = kmalloc(logo->width * logo->height, GFP_KERNEL);
 		if (logo_new == NULL) {
 			kfree(palette);
 			if (saved_pseudo_palette)
@@ -514,29 +514,35 @@ int fb_show_logo(struct fb_info *info, i
 			return 0;
 		}
 		image.data = logo_new;
-		fb_set_logo(info, fb_logo.logo, logo_new, fb_logo.depth);
+		fb_set_logo(info, logo, logo_new, fb_logo.depth);
 	}
 
 	image.dx = 0;
-	image.dy = 0;
-	image.width = fb_logo.logo->width;
-	image.height = fb_logo.logo->height;
+	image.dy = y;
+	image.width = logo->width;
+	image.height = logo->height;
 
 	if (rotate) {
-		logo_rotate = kmalloc(fb_logo.logo->width *
-				      fb_logo.logo->height, GFP_KERNEL);
+		logo_rotate = kmalloc(logo->width *
+				      logo->height, GFP_KERNEL);
 		if (logo_rotate)
 			fb_rotate_logo(info, logo_rotate, &image, rotate);
 	}
 
-	fb_do_show_logo(info, &image, rotate, num_online_cpus());
+	fb_do_show_logo(info, &image, rotate, n);
 
 	kfree(palette);
 	if (saved_pseudo_palette != NULL)
 		info->pseudo_palette = saved_pseudo_palette;
 	kfree(logo_new);
 	kfree(logo_rotate);
-	return fb_logo.logo->height;
+	return logo->height;
+}
+
+int fb_show_logo(struct fb_info *info, int rotate)
+{
+	return fb_show_logo_line(info, rotate, fb_logo.logo, 0,
+				 num_online_cpus());
 }
 #else
 int fb_prepare_logo(struct fb_info *info, int rotate) { return 0; }

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
