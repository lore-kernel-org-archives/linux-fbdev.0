From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 16/18] atyfb: Remove dead code
Date: Sat, 11 Mar 2006 09:51:43 +0800
Message-ID: <44122D2F.3080605@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FHuMY-0000D1-28
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 19:01:50 -0800
Received: from pproxy.gmail.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FHtO7-0003lQ-Gz
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 10 Mar 2006 17:59:24 -0800
Received: by pproxy.gmail.com with SMTP id z59so419612pyg
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 10 Mar 2006 17:59:20 -0800 (PST)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Alexander Kern <alex.kern@gmx.de>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>

Remove code that can never be reached.

Coverity Bug 67

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/aty/atyfb_base.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index 1a5c0f6..c69c336 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2298,6 +2298,10 @@ static int __init aty_init(struct fb_inf
 		case CLK_ATI18818_1:
 			par->pll_ops = &aty_pll_ati18818_1;
 			break;
+		case CLK_IBMRGB514:
+			par->pll_ops = &aty_pll_ibm514;
+			break;
+#if 0 /* dead code */
 		case CLK_STG1703:
 			par->pll_ops = &aty_pll_stg1703;
 			break;
@@ -2307,9 +2311,7 @@ static int __init aty_init(struct fb_inf
 		case CLK_ATT20C408:
 			par->pll_ops = &aty_pll_att20c408;
 			break;
-		case CLK_IBMRGB514:
-			par->pll_ops = &aty_pll_ibm514;
-			break;
+#endif
 		default:
 			PRINTKI("aty_init: CLK type not implemented yet!");
 			par->pll_ops = &aty_pll_unsupported;




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
