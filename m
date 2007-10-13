From: Antonino Daplas <adaplas@gmail.com>
Subject: [PATCH 11/15] svgalib: mode selection updates
Date: Sat, 13 Oct 2007 08:30:38 +0800
Message-ID: <471011AE.9000301@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgVZJ-0000JZ-TT for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 18:13:29 -0700
Received: from rv-out-0910.google.com ([209.85.198.191])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IgUyh-0002xt-Ot
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 17:35:40 -0700
Received: by rv-out-0910.google.com with SMTP id g11so3588679rvb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 12 Oct 2007 17:35:39 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Ondrej Zajicek <santiago@crfreenet.org>

This patch changes mode selection matching algorithm.
It allows to choose mode with matching depth even when
requested color lengths are greater than color lengths
of every mode with requested color depth.

It also fixes bug in s3fb - wrong error value returned
when format is not supported by chip.

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/s3fb.c    |    9 +++++++--
 drivers/video/svgalib.c |   47 +++++++++++++++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index d117358..a96ac43 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
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
diff --git a/drivers/video/svgalib.c b/drivers/video/svgalib.c
index 25df928..9c71067 100644
--- a/drivers/video/svgalib.c
+++ b/drivers/video/svgalib.c
@@ -598,9 +598,11 @@ void svga_set_timings(const struct svga_
 /* ------------------------------------------------------------------------- */
 
 
-int svga_match_format(const struct svga_fb_format *frm, struct fb_var_screeninfo *var, struct fb_fix_screeninfo *fix)
+static inline int match_format(const struct svga_fb_format *frm,
+			       struct fb_var_screeninfo *var)
 {
 	int i = 0;
+	int stored = -EINVAL;
 
 	while (frm->bits_per_pixel != SVGA_FORMAT_END_VAL)
 	{
@@ -609,25 +611,38 @@ int svga_match_format(const struct svga_
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
 		frm++;
 	}
-	return -EINVAL;
+	return stored;
+}
+
+int svga_match_format(const struct svga_fb_format *frm,
+		      struct fb_var_screeninfo *var,
+		      struct fb_fix_screeninfo *fix)
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
+	}
+
+	return i;
 }
 
 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
