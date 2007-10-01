From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: [PATCH] svgalib: mode selection updates
Date: Mon, 1 Oct 2007 23:01:35 +0200
Message-ID: <20071001210135.GB2017@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IcSOn-0001vk-Tc for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 14:01:53 -0700
Received: from smtp1.kolej.mff.cuni.cz ([78.128.192.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IcSOn-0002pf-6X
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 01 Oct 2007 14:01:53 -0700
Content-Disposition: inline
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
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

This patch changes mode selection matching algorithm.
It allows to choose mode with matching depth even when
requested color lengths are greater than color lengths
of every mode with requested color depth.

It also fixes bug in s3fb - wrong error value returned
when format is not supported by chip.

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>

---

diff -uprN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22/drivers/video/s3fb.c linux-2.6.22-p1/drivers/video/s3fb.c
--- linux-2.6.22/drivers/video/s3fb.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22-p1/drivers/video/s3fb.c	2007-10-01 20:40:40.000000000 +0200
@@ -403,8 +403,13 @@ static int s3fb_check_var(struct fb_var_
 
 	/* Find appropriate format */
 	rv = svga_match_format (s3fb_formats, var, NULL);
-	if ((rv < 0) || ((par->chip == CHIP_988_VIRGE_VX) ? (rv == 7) : (rv == 6)))
-	{		/* 24bpp on VIRGE VX, 32bpp on others */
+
+	/* 32bpp mode is not supported on VIRGE VX,
+	   24bpp is not supported on others */
+	if ((par->chip == CHIP_988_VIRGE_VX) ? (rv == 7) : (rv == 6))
+		rv = -EINVAL;
+
+	if (rv < 0) {
 		printk(KERN_ERR "fb%d: unsupported mode requested\n", info->node);
 		return rv;
 	}
diff -uprN -X linux-2.6.22/Documentation/dontdiff linux-2.6.22/drivers/video/svgalib.c linux-2.6.22-p1/drivers/video/svgalib.c
--- linux-2.6.22/drivers/video/svgalib.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22-p1/drivers/video/svgalib.c	2007-10-01 20:53:40.000000000 +0200
@@ -598,9 +598,10 @@ void svga_set_timings(const struct svga_
 /* ------------------------------------------------------------------------- */
 
 
-int svga_match_format(const struct svga_fb_format *frm, struct fb_var_screeninfo *var, struct fb_fix_screeninfo *fix)
+static inline int match_format(const struct svga_fb_format *frm, struct fb_var_screeninfo *var)
 {
 	int i = 0;
+	int stored = -EINVAL;
 
 	while (frm->bits_per_pixel != SVGA_FORMAT_END_VAL)
 	{
@@ -609,25 +610,36 @@ int svga_match_format(const struct svga_
 		    (var->green.length   <= frm->green.length)   &&
 		    (var->blue.length    <= frm->blue.length)    &&
 		    (var->transp.length  <= frm->transp.length)  &&
-		    (var->nonstd	 == frm->nonstd)) {
-		    	var->bits_per_pixel = frm->bits_per_pixel;
-			var->red            = frm->red;
-			var->green          = frm->green;
-			var->blue           = frm->blue;
-			var->transp         = frm->transp;
-			var->nonstd         = frm->nonstd;
-			if (fix != NULL) {
-				fix->type      = frm->type;
-				fix->type_aux  = frm->type_aux;
-				fix->visual    = frm->visual;
-				fix->xpanstep  = frm->xpanstep;
-			}
+		    (var->nonstd	 == frm->nonstd))
 			return i;
-		}
+		if (var->bits_per_pixel == frm->bits_per_pixel)
+			stored = i;
 		i++;
-		frm++;
+		frm++; 
+	}
+	return stored;
+}
+
+int svga_match_format(const struct svga_fb_format *frm, struct fb_var_screeninfo *var, struct fb_fix_screeninfo *fix)
+{
+	int i = match_format(frm, var);
+
+	if (i >= 0) {
+		var->bits_per_pixel = frm[i].bits_per_pixel;
+		var->red            = frm[i].red;
+		var->green          = frm[i].green;
+		var->blue           = frm[i].blue;
+		var->transp         = frm[i].transp;
+		var->nonstd         = frm[i].nonstd;
+		if (fix != NULL) {
+			fix->type      = frm[i].type;
+			fix->type_aux  = frm[i].type_aux;
+			fix->visual    = frm[i].visual;
+			fix->xpanstep  = frm[i].xpanstep;
+		}
 	}
-	return -EINVAL;
+
+	return i;
 }
 
 
 

-- 
Elen sila lumenn' omentielvo

Ondrej 'SanTiago' Zajicek (email: santiago@crfreenet.org, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
