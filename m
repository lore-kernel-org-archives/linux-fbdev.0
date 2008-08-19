From: roel kluin <roel.kluin@gmail.com>
Subject: [PATCH] RADEON: duplicate
	PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb
Date: Mon, 18 Aug 2008 23:07:44 -0400
Message-ID: <48AA3900.80305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVBx6-0003mr-NO for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 14:07:48 -0700
Received: from ug-out-1314.google.com ([66.249.92.169])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVBx3-0008K1-25
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Aug 2008 14:07:47 -0700
Received: by ug-out-1314.google.com with SMTP id m2so503418uge.17
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 18 Aug 2008 14:07:43 -0700 (PDT)
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
To: benh@kernel.crashing.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

untested, is it correct?
---
duplicate PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index 675abda..74d2e65 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -210,7 +210,7 @@ static void radeon_pm_disable_dynamic_mode(struct radeonfb_info *rinfo)
 			 PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb	|
 			 PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb	|
 			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		|
-			 PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb		|
+			 PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb	|
 			 PIXCLKS_CNTL__R300_DISP_DAC_PIXCLK_DAC2_BLANK_OFF);
                 OUTPLL(pllPIXCLKS_CNTL, tmp);
 
@@ -392,7 +392,7 @@ static void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
 			PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb      |
 			PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb        |
 			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb           |
-			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb);
+			PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb);
 		OUTPLL(pllPIXCLKS_CNTL, tmp);
 
 		tmp = INPLL(pllMCLK_MISC);

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
