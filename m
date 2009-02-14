From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 1/2] cirrusfb: do not calculate line
	length twice
Date: Sat, 14 Feb 2009 18:50:45 +0100
Message-ID: <20090214185045.c288650e.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1LYObA-0000Hw-Dc
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Feb 2009 17:46:40 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LYOb3-0007AC-Ny for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 14 Feb 2009 17:46:40 +0000
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Arthur Marsh <arthur.marsh@internode.on.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

A line length is calculated twice: first in
the cirrusfb_decode_var() then in 
the cirrusfb_set_par_foo().

Use the first calculated value. A nice side
effect is that 32bpp mode works now.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index e8cd60a..c98efd0 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -694,7 +694,8 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 	struct cirrusfb_regs regs;
 	u8 __iomem *regbase = cinfo->regbase;
 	unsigned char tmp;
-	int offset = 0, err;
+	int err;
+	int pitch;
 	const struct cirrusfb_board_info_rec *bi;
 	int hdispend, hsyncstart, hsyncend, htotal;
 	int yres, vdispend, vsyncstart, vsyncend, vtotal;
@@ -1027,7 +1028,6 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 		vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, 0x06);
 		/* plane mask: only write to first plane */
 		vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, 0x01);
-		offset = var->xres_virtual / 16;
 	}
 
 	/******************************************************
@@ -1113,7 +1113,6 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 		vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, 0x0a);
 		/* plane mask: enable writing to all 4 planes */
 		vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, 0xff);
-		offset = var->xres_virtual / 8;
 	}
 
 	/******************************************************
@@ -1190,7 +1189,6 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 		vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, 0x0a);
 		/* plane mask: enable writing to all 4 planes */
 		vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, 0xff);
-		offset = var->xres_virtual / 4;
 	}
 
 	/******************************************************
@@ -1263,7 +1261,6 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 		vga_wseq(regbase, VGA_SEQ_MEMORY_MODE, 0x0a);
 		/* plane mask: enable writing to all 4 planes */
 		vga_wseq(regbase, VGA_SEQ_PLANE_WRITE, 0xff);
-		offset = var->xres_virtual / 4;
 	}
 
 	/******************************************************
@@ -1277,9 +1274,10 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 			"What's this? requested color depth == %d.\n",
 			var->bits_per_pixel);
 
-	vga_wcrt(regbase, VGA_CRTC_OFFSET, offset & 0xff);
+	pitch = info->fix.line_length >> 3;
+	vga_wcrt(regbase, VGA_CRTC_OFFSET, pitch & 0xff);
 	tmp = 0x22;
-	if (offset & 0x100)
+	if (pitch & 0x100)
 		tmp |= 0x10;	/* offset overflow bit */
 
 	/* screen start addr #16-18, fastpagemode cycles */
@@ -1287,7 +1285,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 
 	/* screen start address bit 19 */
 	if (cirrusfb_board_info[cinfo->btype].scrn_start_bit19)
-		vga_wcrt(regbase, CL_CRT1D, 0x00);
+		vga_wcrt(regbase, CL_CRT1D, (pitch >> 9) & 1);
 
 	if (cinfo->btype == BT_LAGUNA ||
 	    cinfo->btype == BT_GD5480) {
-- 
1.5.2.2


----------------------------------------------------------------------
Wrozby dla zakochanych!
Sprawdz >> http://link.interia.pl/f2054



------------------------------------------------------------------------------
Open Source Business Conference (OSBC), March 24-25, 2009, San Francisco, CA
-OSBC tackles the biggest issue in open source: Open Sourcing the Enterprise
-Strategies to boost innovation and cut costs with open source participation
-Receive a $600 discount off the registration fee with the source code: SFAD
http://p.sf.net/sfu/XcvMzF8H
