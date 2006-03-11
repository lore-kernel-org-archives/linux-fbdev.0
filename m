From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 14/18] tdfxfb: Fix buffer overrun
Date: Sat, 11 Mar 2006 09:51:23 +0800
Message-ID: <44122D1B.9010007@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHuB8-0007VS-BH
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 18:50:02 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtNx-0003lQ-SN
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:59:15 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:59:10 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Hannu Mallat <hmallat@cc.hut.fi>

The pseudo_palette has room only for 16 entries, but tdfxfb_setcolreg may
attempt to write more.

Coverity Bug 557

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/tdfxfb.c |   42 +++++++++++++++++++++++-------------------
 1 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
index 3e7baf4..5e5328d 100644
--- a/drivers/video/tdfxfb.c
+++ b/drivers/video/tdfxfb.c
@@ -786,28 +786,32 @@ static int tdfxfb_setcolreg(unsigned reg
 	if (regno >= info->cmap.len || regno > 255) return 1;
    
 	switch (info->fix.visual) {
-		case FB_VISUAL_PSEUDOCOLOR:
-			rgbcol =(((u32)red   & 0xff00) << 8) |
-				(((u32)green & 0xff00) << 0) |
-				(((u32)blue  & 0xff00) >> 8);
-			do_setpalentry(par, regno, rgbcol);
-			break;
-		/* Truecolor has no hardware color palettes. */
-		case FB_VISUAL_TRUECOLOR:
+	case FB_VISUAL_PSEUDOCOLOR:
+		rgbcol =(((u32)red   & 0xff00) << 8) |
+			(((u32)green & 0xff00) << 0) |
+			(((u32)blue  & 0xff00) >> 8);
+		do_setpalentry(par, regno, rgbcol);
+		break;
+	/* Truecolor has no hardware color palettes. */
+	case FB_VISUAL_TRUECOLOR:
+		if (regno < 16) {
 			rgbcol = (CNVT_TOHW( red, info->var.red.length) <<
 				  info->var.red.offset) |
-				 (CNVT_TOHW( green, info->var.green.length) <<
-				  info->var.green.offset) |
-				 (CNVT_TOHW( blue, info->var.blue.length) <<
-				  info->var.blue.offset) |
-				 (CNVT_TOHW( transp, info->var.transp.length) <<
-				  info->var.transp.offset);
-				par->palette[regno] = rgbcol;
-			break;
-		default:
-			DPRINTK("bad depth %u\n", info->var.bits_per_pixel);
-			break;
+				(CNVT_TOHW( green, info->var.green.length) <<
+				 info->var.green.offset) |
+				(CNVT_TOHW( blue, info->var.blue.length) <<
+				 info->var.blue.offset) |
+				(CNVT_TOHW( transp, info->var.transp.length) <<
+				 info->var.transp.offset);
+			par->palette[regno] = rgbcol;
+		}
+
+		break;
+	default:
+		DPRINTK("bad depth %u\n", info->var.bits_per_pixel);
+		break;
 	}
+
 	return 0;
 }
 




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
