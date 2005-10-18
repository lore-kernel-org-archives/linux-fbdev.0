From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 3/17] fbcon: Use helper function when filling out var structure
Date: Tue, 18 Oct 2005 17:14:49 +0800
Message-ID: <4354BD09.2040401@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ERyHy-0000aD-PB
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:26 -0700
Received: from zproxy.gmail.com ([64.233.162.204])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1ERyHx-0000dG-HO
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 18 Oct 2005 13:42:26 -0700
Received: by zproxy.gmail.com with SMTP id 14so1395707nzn
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 18 Oct 2005 13:42:25 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Instead of manually filling up the fields in struct fb_var_screeninfo, use
the display_to_var() helper.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 fbcon.c |   17 ++---------------
 1 files changed, 2 insertions(+), 15 deletions(-)


diff --git a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c
+++ b/drivers/video/console/fbcon.c
@@ -1886,24 +1886,11 @@ static int fbcon_resize(struct vc_data *
 		mode = fb_find_best_mode(&var, &info->modelist);
 		if (mode == NULL)
 			return -EINVAL;
+		display_to_var(&var, p);
 		fb_videomode_to_var(&var, mode);
+
 		if (width > var.xres/fw || height > var.yres/fh)
 			return -EINVAL;
-		/*
-		 * The following can probably have any value... Do we need to
-		 * set all of them?
-		 */
-		var.bits_per_pixel = p->bits_per_pixel;
-		var.xres_virtual = p->xres_virtual;
-		var.yres_virtual = p->yres_virtual;
-		var.accel_flags = p->accel_flags;
-		var.width = p->width;
-		var.height = p->height;
-		var.red = p->red;
-		var.green = p->green;
-		var.blue = p->blue;
-		var.transp = p->transp;
-		var.nonstd = p->nonstd;
 
 		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
 		if (CON_IS_VISIBLE(vc)) {




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
