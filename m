From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 23 Jan 2014 19:44:00 +0000
Subject: [PATCH 10/10] tgafb: avoid restriction on modes with line length not a multiple of 64
Message-Id: <alpine.LRH.2.02.1401231443120.7971@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In tgafb there is a restriction that prevents the user from setting a
videomode with line length not a multiple of 64 bytes (for example,
800x600 is not allowed).

The reason for this restriction it that functions copyarea_line_8bpp and
copyarea_line_32bpp can not handle a line length that is not a multiple
of 64 bytes.

This patch removes this restriction on mode setting and makes sure that
the functions copyarea_line_8bpp and copyarea_line_32bpp are called only
if line length is a multiple of 64 bytes. If we set a mode 800x600,
the functions copyarea_line_8bpp and copyarea_line_32bpp are not used,
generic functions for copying are used instead and it works just fine.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/video/tgafb.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-3.8-rc3-fast/drivers/video/tgafb.c
=================================--- linux-3.8-rc3-fast.orig/drivers/video/tgafb.c	2013-01-10 23:43:44.000000000 +0100
+++ linux-3.8-rc3-fast/drivers/video/tgafb.c	2013-01-10 23:43:49.000000000 +0100
@@ -198,8 +198,8 @@ tgafb_check_var(struct fb_var_screeninfo
 		return -EINVAL;
 
 	/* Some of the acceleration routines assume the line width is
-	   a multiple of 64 bytes.  */
-	if (var->xres * (par->tga_type = TGA_TYPE_8PLANE ? 1 : 4) % 64)
+	   a multiple of 8 bytes.  */
+	if (var->xres * (par->tga_type = TGA_TYPE_8PLANE ? 1 : 4) % 8)
 		return -EINVAL;
 
 	return 0;
@@ -1286,7 +1286,7 @@ tgafb_copyarea(struct fb_info *info, con
 	bpp = info->var.bits_per_pixel;
 
 	/* Detect copies of the entire line.  */
-	if (width * (bpp >> 3) = line_length) {
+	if (!(line_length & 63) && width * (bpp >> 3) = line_length) {
 		if (bpp = 8)
 			copyarea_line_8bpp(info, dy, sy, height, width);
 		else
