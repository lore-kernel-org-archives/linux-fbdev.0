From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: [PATCH 1/3] s3fb: updates
Date: Sun, 29 Apr 2007 18:20:45 +0200
Message-ID: <20070429162045.GA12218@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HiC8q-0005ev-Ej for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 09:20:52 -0700
Received: from gateway.crfreenet.org
	([81.92.146.254] helo=mail.crfreenet.org ident=postfix)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HiC8p-0006zk-M8
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 29 Apr 2007 09:20:52 -0700
Content-Disposition: inline
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
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


Move s3fb_get_tilemax to svgalib.c as svga_get_tilemax,
because it reports limitation of other code from svgalib
(svga_settile, svga_tilecopy, ...)

Limit font width to 8 pixels in 4 bpp mode.

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>

---

diff -uprN -X linux-2.6.21-rc7-mm2/Documentation/dontdiff linux-2.6.21-rc7-mm2/drivers/video/s3fb.c linux-2.6.21-rc7-mm2-dev/drivers/video/s3fb.c
--- linux-2.6.21-rc7-mm2/drivers/video/s3fb.c	2007-04-28 00:41:32.000000000 +0200
+++ linux-2.6.21-rc7-mm2-dev/drivers/video/s3fb.c	2007-04-28 19:05:39.000000000 +0200
@@ -183,18 +183,13 @@ static void s3fb_settile_fast(struct fb_
 	}
 }
 
-static int s3fb_get_tilemax(struct fb_info *info)
-{
-	return 256;
-}
-
 static struct fb_tile_ops s3fb_tile_ops = {
 	.fb_settile	= svga_settile,
 	.fb_tilecopy	= svga_tilecopy,
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
 	.fb_tilecursor  = svga_tilecursor,
-	.fb_get_tilemax = s3fb_get_tilemax,
+	.fb_get_tilemax = svga_get_tilemax,
 };
 
 static struct fb_tile_ops s3fb_fast_tile_ops = {
@@ -203,7 +198,7 @@ static struct fb_tile_ops s3fb_fast_tile
 	.fb_tilefill    = svga_tilefill,
 	.fb_tileblit    = svga_tileblit,
 	.fb_tilecursor  = svga_tilecursor,
-	.fb_get_tilemax = s3fb_get_tilemax,
+	.fb_get_tilemax = svga_get_tilemax,
 };
 
 
@@ -459,9 +454,10 @@ static int s3fb_set_par(struct fb_info *
 		info->flags &= ~FBINFO_MISC_TILEBLITTING;
 		info->tileops = NULL;
 
-		/* supports blit rectangles of any dimension */
-		info->pixmap.blit_x = ~(u32)0;
+		/* in 4bpp supports 8p wide tiles only, any tiles otherwise */
+		info->pixmap.blit_x = (bpp == 4) ? (1 << (8 - 1)) : (~(u32)0);
 		info->pixmap.blit_y = ~(u32)0;
+
 		offset_value = (info->var.xres_virtual * bpp) / 64;
 		screen_size = info->var.yres_virtual * info->fix.line_length;
 	} else {
@@ -470,6 +466,7 @@ static int s3fb_set_par(struct fb_info *
 
 		info->flags |= FBINFO_MISC_TILEBLITTING;
 		info->tileops = fasttext ? &s3fb_fast_tile_ops : &s3fb_tile_ops;
+
 		/* supports 8x16 tiles only */
 		info->pixmap.blit_x = 1 << (8 - 1);
 		info->pixmap.blit_y = 1 << (16 - 1);
diff -uprN -X linux-2.6.21-rc7-mm2/Documentation/dontdiff linux-2.6.21-rc7-mm2/drivers/video/svgalib.c linux-2.6.21-rc7-mm2-dev/drivers/video/svgalib.c
--- linux-2.6.21-rc7-mm2/drivers/video/svgalib.c	2007-04-28 00:41:32.000000000 +0200
+++ linux-2.6.21-rc7-mm2-dev/drivers/video/svgalib.c	2007-04-29 14:05:05.000000000 +0200
@@ -342,6 +342,11 @@ void svga_tilecursor(struct fb_info *inf
 	vga_wcrt(NULL, 0x0A, cs); /* set cursor start and enable it */
 }
 
+int svga_get_tilemax(struct fb_info *info)
+{
+	return 256;
+}
+
 
 /* ------------------------------------------------------------------------- */
 
@@ -623,6 +628,7 @@ EXPORT_SYMBOL(svga_tilecopy);
 EXPORT_SYMBOL(svga_tilefill);
 EXPORT_SYMBOL(svga_tileblit);
 EXPORT_SYMBOL(svga_tilecursor);
+EXPORT_SYMBOL(svga_get_tilemax);
 
 EXPORT_SYMBOL(svga_compute_pll);
 EXPORT_SYMBOL(svga_check_timings);
diff -uprN -X linux-2.6.21-rc7-mm2/Documentation/dontdiff linux-2.6.21-rc7-mm2/include/linux/svga.h linux-2.6.21-rc7-mm2-dev/include/linux/svga.h
--- linux-2.6.21-rc7-mm2/include/linux/svga.h	2007-04-16 01:50:57.000000000 +0200
+++ linux-2.6.21-rc7-mm2-dev/include/linux/svga.h	2007-04-28 23:04:27.000000000 +0200
@@ -112,6 +112,7 @@ void svga_tilecopy(struct fb_info *info,
 void svga_tilefill(struct fb_info *info, struct fb_tilerect *rect);
 void svga_tileblit(struct fb_info *info, struct fb_tileblit *blit);
 void svga_tilecursor(struct fb_info *info, struct fb_tilecursor *cursor);
+int svga_get_tilemax(struct fb_info *info);
 
 int svga_compute_pll(const struct svga_pll *pll, u32 f_wanted, u16 *m, u16 *n, u16 *r, int node);
 int svga_check_timings(const struct svga_timing_regs *tm, struct fb_var_screeninfo *var, int node);


-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
