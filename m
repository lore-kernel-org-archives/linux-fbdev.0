From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Date: Mon, 20 Aug 2012 18:12:33 +0000
Subject: [PATCH 7/7] tgafb: avoid restriction on modes with line length not a multiple of 64
Message-Id: <alpine.DEB.2.00.1208202010180.4009@artax.karlin.mff.cuni.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

tgafb: avoid restriction on modes with line length not a multiple of 64

In tgafb there is a restriction that prevents the user from setting a
videomode with line length not a multiple of 64 bytes (for example
800x600 is not allowed).

The reason for this restriction it that functions copyarea_line_8bpp and
copyarea_line_32bpp can not handle a line length that is not a multiple
of 64 bytes.

This patch removes this restriction on mode setting and makes sure that
the functions copyarea_line_8bpp and copyarea_line_32bpp are called only
if line length is a multiple of 64 bytes. If we set a mode 800x600,
the functions copyarea_line_8bpp and copyarea_line_32bpp are not used,
generic functions for copying are used instead and it works just fine.

Signed-off-by: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>

---
 drivers/video/tgafb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-3.6-rc2-fast/drivers/video/tgafb.c
=================================--- linux-3.6-rc2-fast.orig/drivers/video/tgafb.c	2012-08-20 19:40:02.000000000 +0200
+++ linux-3.6-rc2-fast/drivers/video/tgafb.c	2012-08-20 19:40:33.000000000 +0200
@@ -202,8 +202,8 @@ tgafb_check_var(struct fb_var_screeninfo
 		return -EINVAL;
 
 	/* Some of the acceleration routines assume the line width is
-	   a multiple of 64 bytes.  */
-	if (var->xres * (par->tga_type = TGA_TYPE_8PLANE ? 1 : 4) % 64)
+	   a multiple of 8 bytes.  */
+	if (var->xres % 8)
 		return -EINVAL;
 
 	return 0;
@@ -1290,7 +1290,7 @@ tgafb_copyarea(struct fb_info *info, con
 	bpp = info->var.bits_per_pixel;
 
 	/* Detect copies of the entire line.  */
-	if (width * (bpp >> 3) = line_length) {
+	if (!(line_length & 63) && width * (bpp >> 3) = line_length) {
 		if (bpp = 8)
 			copyarea_line_8bpp(info, dy, sy, height, width);
 		else

