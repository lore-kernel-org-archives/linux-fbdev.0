From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 3/4] cirrusfb: fix 16bpp modes
Date: Fri, 5 Sep 2008 23:53:33 +0200
Message-ID: <20080905235333.9ec7e038.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kbj8U-0007oH-K4 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 14:46:34 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kbj8U-0001ga-7x
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 14:46:34 -0700
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
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The 16bpp mode did not work on the
Cirrus cards as the visual type was
set to DIRECTCOLOR instead of TRUECOLOR.
The Alpine family used one incorrect
register setting so this 16bpp modes
generated wrong horizontal frequency.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

I think it is not worth to push it into 2.6.27. This is
an old error.

 drivers/video/cirrusfb.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 245005e..9e0a1c5 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -657,7 +657,7 @@ static int cirrusfb_decode_var(const struct fb_var_screeninfo *var,
 	case 16:
 	case 32:
 		info->fix.line_length = var->xres_virtual * maxclockidx;
-		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
+		info->fix.visual = FB_VISUAL_TRUECOLOR;
 		break;
 
 	default:
@@ -1178,10 +1178,7 @@ static int cirrusfb_set_par_foo(struct fb_info *info)
 
 		case BT_ALPINE:
 			DPRINTK(" (for GD543x)\n");
-			if (var->xres >= 1024)
-				vga_wseq(regbase, CL_SEQR7, 0xa7);
-			else
-				vga_wseq(regbase, CL_SEQR7, 0xa3);
+			vga_wseq(regbase, CL_SEQR7, 0xa7);
 			cirrusfb_set_mclk(cinfo, regs.mclk, regs.divMCLK);
 			break;
 
-- 
1.5.2.2


----------------------------------------------------------------------
Teraz taniej na zagraniczne komorki!
Sprawdz >> http://link.interia.pl/f1ef7 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
