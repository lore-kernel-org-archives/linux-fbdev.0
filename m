From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] cirrusfb: fix interlaced modes
Date: Sat, 21 Mar 2009 20:23:01 +0100
Message-ID: <20090321202301.06c3e60b.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1Ll6m4-0005Sd-GO
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Mar 2009 19:22:28 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ll6m2-0004ej-Bt for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 21 Mar 2009 19:22:28 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Fix calculations of timings for
interlaced modes.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 4c61504..9a9c679 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -699,45 +699,52 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 
 	hsyncstart = var->xres + var->right_margin;
 	hsyncend = hsyncstart + var->hsync_len;
-	htotal = (hsyncend + var->left_margin) / 8 - 5;
-	hdispend = var->xres / 8 - 1;
-	hsyncstart = hsyncstart / 8 + 1;
-	hsyncend = hsyncend / 8 + 1;
+	htotal = (hsyncend + var->left_margin) / 8;
+	hdispend = var->xres / 8;
+	hsyncstart = hsyncstart / 8;
+	hsyncend = hsyncend / 8;
 
-	yres = var->yres;
-	vsyncstart = yres + var->lower_margin;
+	vdispend = var->yres;
+	vsyncstart = vdispend + var->lower_margin;
 	vsyncend = vsyncstart + var->vsync_len;
 	vtotal = vsyncend + var->upper_margin;
-	vdispend = yres - 1;
 
 	if (var->vmode & FB_VMODE_DOUBLE) {
-		yres *= 2;
+		vdispend *= 2;
 		vsyncstart *= 2;
 		vsyncend *= 2;
 		vtotal *= 2;
 	} else if (var->vmode & FB_VMODE_INTERLACED) {
-		yres = (yres + 1) / 2;
+		vdispend = (vdispend + 1) / 2;
 		vsyncstart = (vsyncstart + 1) / 2;
 		vsyncend = (vsyncend + 1) / 2;
 		vtotal = (vtotal + 1) / 2;
 	}
-
-	vtotal -= 2;
-	vsyncstart -= 1;
-	vsyncend -= 1;
-
+	yres = vdispend;
 	if (yres >= 1024) {
 		vtotal /= 2;
 		vsyncstart /= 2;
 		vsyncend /= 2;
 		vdispend /= 2;
 	}
+
+	vdispend -= 1;
+	vsyncstart -= 1;
+	vsyncend -= 1;
+	vtotal -= 2;
+
 	if (cinfo->multiplexing) {
 		htotal /= 2;
 		hsyncstart /= 2;
 		hsyncend /= 2;
 		hdispend /= 2;
 	}
+
+	htotal -= 5;
+	hdispend -= 1;
+	hsyncstart += 1;
+	hsyncend += 1;
+
 	/* unlock register VGA_CRTC_H_TOTAL..CRT7 */
 	vga_wcrt(regbase, VGA_CRTC_V_SYNC_END, 0x20);	/* previously: 0x00) */
 
-- 
1.5.2.2


----------------------------------------------------------------------
Szukasz pieniedzy? Wez podwojny limit zadluzenia w koncie direct.
>> http://link.interia.pl/f20a3


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
