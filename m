From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] radeon: P2G2CLK_ALWAYS_ONb tested twice,
	should 2nd be P2G2CLK_DAC_ALWAYS_ONb?
Date: Fri, 15 May 2009 22:45:27 +0200
Message-ID: <4A0DD467.7040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1M54Ha-0002l1-91
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 May 2009 20:45:30 +0000
Received: from ey-out-1920.google.com ([74.125.78.148])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M54HZ-0005ZY-Fn for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 May 2009 20:45:30 +0000
Received: by ey-out-1920.google.com with SMTP id 13so553558eye.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 15 May 2009 13:45:26 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net

P2G2CLK_ALWAYS_ONb is tested twice, 2nd should be P2G2CLK_DAC_ALWAYS_ONb.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Is this correct? I am only guessing. Please review.

diff --git a/drivers/video/aty/radeon_pm.c b/drivers/video/aty/radeon_pm.c
index 97a1f09..100112f 100644
--- a/drivers/video/aty/radeon_pm.c
+++ b/drivers/video/aty/radeon_pm.c
@@ -395,7 +395,7 @@ static void radeon_pm_enable_dynamic_mode(struct radeonfb_info *rinfo)
 			PIXCLKS_CNTL__R300_PIXCLK_TRANS_ALWAYS_ONb      |
 			PIXCLKS_CNTL__R300_PIXCLK_TVO_ALWAYS_ONb        |
 			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb           |
-			PIXCLKS_CNTL__R300_P2G2CLK_ALWAYS_ONb);
+			PIXCLKS_CNTL__R300_P2G2CLK_DAC_ALWAYS_ONb);
 		OUTPLL(pllPIXCLKS_CNTL, tmp);
 
 		tmp = INPLL(pllMCLK_MISC);

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
