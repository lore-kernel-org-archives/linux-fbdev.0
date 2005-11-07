From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/7] savagefb: X-panning fixes
Date: Mon, 07 Nov 2005 19:14:43 +0800
Message-ID: <436F3723.7000203@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZ5BR-0004Ub-EV
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:05 -0800
Received: from xproxy.gmail.com ([66.249.82.195])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EZ5BR-0005He-7N
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Nov 2005 03:29:05 -0800
Received: by xproxy.gmail.com with SMTP id s6so405804wxc
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Nov 2005 03:29:04 -0800 (PST)
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

The driver unconditionally sets xpanstep to 2.  However, a value of 4
empirically works better at bpp = 8, and 2 for 16 and 32. This buglet was
exposed by the rotation code.

Second fix is the unconditional call to update_start() without verifying if
the offsets are correct.  Remove this call, it's not necessary and secondly,
it causes a crash with invalid values.

Signed-off-by: Antonino Daplas <adaplas@pol.net>

---
 savagefb_driver.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)


diff --git a/drivers/video/savage/savagefb_driver.c b/drivers/video/savage/savagefb_driver.c
index f0dfb35..09e2f28 100644
--- a/drivers/video/savage/savagefb_driver.c
+++ b/drivers/video/savage/savagefb_driver.c
@@ -1315,10 +1315,14 @@ static void savagefb_set_fix(struct fb_i
 	info->fix.line_length = info->var.xres_virtual *
 		info->var.bits_per_pixel / 8;
 
-	if (info->var.bits_per_pixel == 8)
+	if (info->var.bits_per_pixel == 8) {
 		info->fix.visual      = FB_VISUAL_PSEUDOCOLOR;
-	else
+		info->fix.xpanstep    = 4;
+	} else {
 		info->fix.visual      = FB_VISUAL_TRUECOLOR;
+		info->fix.xpanstep    = 2;
+	}
+
 }
 
 #if defined(CONFIG_FB_SAVAGE_ACCEL)
@@ -1363,7 +1367,6 @@ static int savagefb_set_par (struct fb_i
 	par->minClock = 10000;
 
 	savagefb_set_par_int (par);
-	savagefb_update_start (par, var);
 	fb_set_cmap (&info->cmap, info);
 	savagefb_set_fix(info);
 	savagefb_set_clip(info);
@@ -1873,7 +1876,6 @@ static int __devinit savage_init_fb_info
 
 	info->fix.type	   = FB_TYPE_PACKED_PIXELS;
 	info->fix.type_aux	   = 0;
-	info->fix.xpanstep	   = 2;
 	info->fix.ypanstep	   = 1;
 	info->fix.ywrapstep   = 0;
 	info->fix.accel       = id->driver_data;



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
