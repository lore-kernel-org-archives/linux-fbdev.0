From: Geert.Uytterhoeven@sonycom.com
Subject: [patch 3/3] fbdev: correct image offsets when
	rotating logo
Date: Tue, 13 Mar 2007 15:14:42 +0100
Message-ID: <20070313141512.370365000@sonycom.com>
References: <20070313141439.295232000@sonycom.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HR7ny-00075f-LS for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:16:46 -0700
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HR7nx-0000Vi-6G
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 13 Mar 2007 07:16:46 -0700
Content-Disposition: inline; filename=spe-logo/fb_rotate_logo-fix-offsets.diff
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
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, linux-fbdev-devel@lists.sourceforge.net, James Simmons <jsimmons@infradead.org>, "Antonino A. Daplas" <adaplas@gmail.com>

Correct the image offsets when rotating the logo. Before image->dx and
image->dy were always zero, so nobody ever noticed.

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Acked-By: James Simmons <jsimmons@infradead.org>
---
 drivers/video/fbmem.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

--- ps3-linux-2.6.21-rc3.orig/drivers/video/fbmem.c
+++ ps3-linux-2.6.21-rc3/drivers/video/fbmem.c
@@ -354,22 +354,26 @@ static void fb_rotate_logo(struct fb_inf
 	if (rotate == FB_ROTATE_UD) {
 		fb_rotate_logo_ud(image->data, dst, image->width,
 				  image->height);
-		image->dx = info->var.xres - image->width;
-		image->dy = info->var.yres - image->height;
+		image->dx = info->var.xres - image->width - image->dx;
+		image->dy = info->var.yres - image->height - image->dy;
 	} else if (rotate == FB_ROTATE_CW) {
 		fb_rotate_logo_cw(image->data, dst, image->width,
 				  image->height);
 		tmp = image->width;
 		image->width = image->height;
 		image->height = tmp;
-		image->dx = info->var.xres - image->width;
+		tmp = image->dy;
+		image->dy = image->dx;
+		image->dx = info->var.xres - image->width - tmp;
 	} else if (rotate == FB_ROTATE_CCW) {
 		fb_rotate_logo_ccw(image->data, dst, image->width,
 				   image->height);
 		tmp = image->width;
 		image->width = image->height;
 		image->height = tmp;
-		image->dy = info->var.yres - image->height;
+		tmp = image->dx;
+		image->dx = image->dy;
+		image->dy = info->var.yres - image->height - tmp;
 	}
 
 	image->data = dst;

--
Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
