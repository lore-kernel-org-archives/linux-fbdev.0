From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 28/41] fbcon: Font setting should check
	limitation of driver
Date: Wed, 25 Apr 2007 14:58:54 +0800
Message-ID: <462EFC2E.5030403@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcAH-0001MZ-M2 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:49 -0700
Received: from wx-out-0506.google.com ([66.249.82.230])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcAH-0006v4-3v
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:49 -0700
Received: by wx-out-0506.google.com with SMTP id i30so295780wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:43:48 -0700 (PDT)
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
Cc: Ondrej Zajicek <santiago@mail.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

fbcon_set_font() will now check if the new font dimensions can be drawn by the
driver (by checking pixmap.blit_x and blit_y).  Similarly, add 2 new
parameters to get_default_font(), font_w and font_h, to further aid in the
font selection process.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/console/fbcon.c   |   17 ++++++++++++++---
 drivers/video/console/fonts.c   |   10 +++++++++-
 drivers/video/console/sticore.c |    2 +-
 include/linux/font.h            |    3 ++-
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
index 19dfdfb..c71a88d 100644
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -988,7 +988,9 @@ static const char *fbcon_startup(void)
 	if (!p->fontdata) {
 		if (!fontname[0] || !(font = find_font(fontname)))
 			font = get_default_font(info->var.xres,
-						info->var.yres);
+						info->var.yres,
+						info->pixmap.blit_x,
+						info->pixmap.blit_y);
 		vc->vc_font.width = font->width;
 		vc->vc_font.height = font->height;
 		vc->vc_font.data = (void *)(p->fontdata = font->data);
@@ -1108,7 +1110,9 @@ static void fbcon_init(struct vc_data *v
 
 			if (!fontname[0] || !(font = find_font(fontname)))
 				font = get_default_font(info->var.xres,
-							info->var.yres);
+							info->var.yres,
+							info->pixmap.blit_x,
+							info->pixmap.blit_y);
 			vc->vc_font.width = font->width;
 			vc->vc_font.height = font->height;
 			vc->vc_font.data = (void *)(p->fontdata = font->data);
@@ -2495,6 +2499,7 @@ static int fbcon_copy_font(struct vc_dat
 
 static int fbcon_set_font(struct vc_data *vc, struct console_font *font, unsigned flags)
 {
+	struct fb_info *info = registered_fb[con2fb_map[vc->vc_num]];
 	unsigned charcount = font->charcount;
 	int w = font->width;
 	int h = font->height;
@@ -2508,6 +2513,11 @@ static int fbcon_set_font(struct vc_data
 	if (charcount != 256 && charcount != 512)
 		return -EINVAL;
 
+	/* Make sure drawing engine can handle the font */
+	if (!(info->pixmap.blit_x & (1 << (font->width - 1))) ||
+	    !(info->pixmap.blit_y & (1 << (font->height - 1))))
+		return -EINVAL;
+
 	size = h * pitch * charcount;
 
 	new_data = kmalloc(FONT_EXTRA_WORDS * sizeof(int) + size, GFP_USER);
@@ -2552,7 +2562,8 @@ static int fbcon_set_def_font(struct vc_
 	const struct font_desc *f;
 
 	if (!name)
-		f = get_default_font(info->var.xres, info->var.yres);
+		f = get_default_font(info->var.xres, info->var.yres,
+				     info->pixmap.blit_x, info->pixmap.blit_y);
 	else if (!(f = find_font(name)))
 		return -ENOENT;
 
diff --git a/drivers/video/console/fonts.c b/drivers/video/console/fonts.c
index c960728..a6828d0 100644
--- a/drivers/video/console/fonts.c
+++ b/drivers/video/console/fonts.c
@@ -98,6 +98,8 @@ const struct font_desc *find_font(const 
  *	get_default_font - get default font
  *	@xres: screen size of X
  *	@yres: screen size of Y
+ *      @font_w: bit array of supported widths (1 - 32)
+ *      @font_h: bit array of supported heights (1 - 32)
  *
  *	Get the default font for a specified screen size.
  *	Dimensions are in pixels.
@@ -107,7 +109,8 @@ const struct font_desc *find_font(const 
  *
  */
 
-const struct font_desc *get_default_font(int xres, int yres)
+const struct font_desc *get_default_font(int xres, int yres, u32 font_w,
+					 u32 font_h)
 {
     int i, c, cc;
     const struct font_desc *f, *g;
@@ -129,6 +132,11 @@ #endif
 #endif
 	if ((yres < 400) == (f->height <= 8))
 	    c += 1000;
+
+	if (!(font_w & (1 << (f->width - 1))) ||
+	    !(font_w & (1 << (f->height - 1))))
+	    c += 1000;
+
 	if (c > cc) {
 	    cc = c;
 	    g = f;
diff --git a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
index 88e7038..717b360 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/console/sticore.c
@@ -495,7 +495,7 @@ sti_select_fbfont(struct sti_cooked_rom 
 		return NULL;
 	fbfont = find_font(fbfont_name);
 	if (!fbfont)
-		fbfont = get_default_font(1024,768);
+		fbfont = get_default_font(1024,768, ~(u32)0, ~(u32)0);
 	if (!fbfont)
 		return NULL;
 
diff --git a/include/linux/font.h b/include/linux/font.h
index 53b129f..40a24ab 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -49,7 +49,8 @@ extern const struct font_desc *find_font
 
 /* Get the default font for a specific screen size */
 
-extern const struct font_desc *get_default_font(int xres, int yres);
+extern const struct font_desc *get_default_font(int xres, int yres,
+						u32 font_w, u32 font_h);
 
 /* Max. length for the name of a predefined font */
 #define MAX_FONT_NAME	32


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
