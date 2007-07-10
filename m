From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [patch 1/4] fbdev: extract fb_show_logo_line()
Date: Tue, 10 Jul 2007 14:27:03 +0200
Message-ID: <20070710123540.579000000@pademelon.sonytel.be>
References: <20070710122702.765654000@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="===============2004722671=="
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I8ExS-0000ml-Fy for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 05:36:46 -0700
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1I8ExR-0005zf-Du
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 10 Jul 2007 05:36:46 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Geoff Levand <geoffrey.levand@am.sony.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, James Simmons <jsimmons@infradead.org>, cbe-oss-dev@ozlabs.org

--===============2004722671==
Content-Disposition: inline; filename=spe-logo/fb_show_logo_line.diff

Extract the code to draw one line of logos into fb_show_logo_line()

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-By: James Simmons <jsimmons@infradead.org>
---
 drivers/video/fbmem.c |   39 +++++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 16 deletions(-)

--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -477,22 +477,24 @@ int fb_prepare_logo(struct fb_info *info
 	return fb_logo.logo->height;
 }
 
-int fb_show_logo(struct fb_info *info, int rotate)
+static int fb_show_logo_line(struct fb_info *info, int rotate,
+			     const struct linux_logo *logo, int y,
+			     unsigned int n)
 {
 	u32 *palette = NULL, *saved_pseudo_palette = NULL;
 	unsigned char *logo_new = NULL, *logo_rotate = NULL;
 	struct fb_image image;
 
 	/* Return if the frame buffer is not mapped or suspended */
-	if (fb_logo.logo == NULL || info->state != FBINFO_STATE_RUNNING ||
+	if (logo == NULL || info->state != FBINFO_STATE_RUNNING ||
 	    info->flags & FBINFO_MODULE)
 		return 0;
 
 	image.depth = 8;
-	image.data = fb_logo.logo->data;
+	image.data = logo->data;
 
 	if (fb_logo.needs_cmapreset)
-		fb_set_logocmap(info, fb_logo.logo);
+		fb_set_logocmap(info, logo);
 
 	if (fb_logo.needs_truepalette || 
 	    fb_logo.needs_directpalette) {
@@ -501,17 +503,16 @@ int fb_show_logo(struct fb_info *info, i
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
@@ -519,29 +520,35 @@ int fb_show_logo(struct fb_info *info, i
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

-- 
With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village ������ Da Vincilaan 7-D1 ������ B-1935 Zaventem ������ Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Center Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 ������ B-1840 Londerzeel ������ Belgium	
VAT BE 0413.825.160 ������ RPR Brussels	
Fortis Bank Zaventem ������ Swift GEBABEBB08A ������ IBAN BE39001382358619



--===============2004722671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============2004722671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--===============2004722671==--
