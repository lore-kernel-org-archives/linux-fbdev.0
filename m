From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 08/12] atyfb: force 29MHz xtal on G3
	PowerBooks
Date: Sat, 15 Sep 2007 08:05:20 +0800
Message-ID: <46EB21C0.2050305@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IWLEs-0007mU-Az for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:22 -0700
Received: from wa-out-1112.google.com ([209.85.146.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IWLEr-0003qG-My
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 14 Sep 2007 17:10:21 -0700
Received: by wa-out-1112.google.com with SMTP id k22so1238382waf
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 14 Sep 2007 17:10:21 -0700 (PDT)
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
Cc: Olaf Hering <olaf@aepfle.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>

From: Olaf Hering <olaf@aepfle.de>

The atyfb does not work on my 233MHz PowerBook with Mach64 LP, when the
kernel is booted from firmware. aty_ld_pll_ct() returns 0x22 and xtal
remains at 14.31818. When booted from MacOS, aty_ld_pll_ct() returns 0x3c
and xtal is changed to 29.498928.
Google indicates that all 4 PowerBook models need the higher value.

Signed-off-by: Olaf Hering <olaf@aepfle.de>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/aty/atyfb_base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
index abe0c43..440ecb7 100644
--- a/drivers/video/aty/atyfb_base.c
+++ b/drivers/video/aty/atyfb_base.c
@@ -2409,7 +2409,7 @@ #ifdef CONFIG_FB_ATY_CT
 				diff1 = -diff1;
 			if (diff2 < 0)
 				diff2 = -diff2;
-			if (diff2 < diff1) {
+			if (diff2 < diff1 || (M64_HAS(G3_PB_1024x768))) {
 				par->ref_clk_per = 1000000000000ULL / 29498928;
 				xtal = "29.498928";
 			}


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
