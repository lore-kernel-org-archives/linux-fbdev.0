From: aherrman@arcor.de
Subject: [PATCH 2/4] radeonfb: add new module parameter
	to force PLL calculation
Date: Tue, 4 Sep 2007 12:59:08 +0200
Message-ID: <20070904105908.GF7320@devil>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ISW6Q-0004Hn-T7 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 04 Sep 2007 03:57:51 -0700
Received: from mail-in-01.arcor-online.net ([151.189.21.41])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ISW6P-0003QM-4T
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 04 Sep 2007 03:57:50 -0700
Content-Disposition: inline
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

On my Acer Aspire 5100 (with 0x5975) I need to force PLL caclulation.
Most probably the BIOS dividers are incorrect/insufficient. Without pll
calculation console goes blank.

Signed-off-by: Andreas Herrmann <aherrman@arcor.de>
---
 drivers/video/aty/radeon_base.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 90a3957..f672c0c 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -268,6 +268,7 @@ static int mirror = 0;
 static int panel_yres = 0;
 static int force_dfp = 0;
 static int force_measure_pll = 0;
+static int force_pll_calc = 0;
 #ifdef CONFIG_MTRR
 static int nomtrr = 0;
 #endif
@@ -1590,7 +1591,7 @@ static int radeonfb_set_par(struct fb_info *info)
 
 		pixClock = 100000000 / rinfo->panel_info.clock;
 
-		if (rinfo->panel_info.use_bios_dividers) {
+		if (rinfo->panel_info.use_bios_dividers && !force_pll_calc) {
 			nopllcalc = 1;
 			newmode->ppll_div_3 = rinfo->panel_info.fbk_divider |
 				(rinfo->panel_info.post_divider << 16);
@@ -2495,6 +2496,8 @@ static int __init radeonfb_setup (char *options)
 			nomodeset = 1;
 		} else if (!strncmp(this_opt, "force_measure_pll", 17)) {
 			force_measure_pll = 1;
+		} else if (!strncmp(this_opt, "force_pll_calc", 17)) {
+			force_pll_calc = 1;
 		} else if (!strncmp(this_opt, "ignore_edid", 11)) {
 			ignore_edid = 1;
 #if defined(CONFIG_PM) && defined(CONFIG_X86)
@@ -2550,6 +2553,8 @@ module_param(monitor_layout, charp, 0);
 MODULE_PARM_DESC(monitor_layout, "Specify monitor mapping (like XFree86)");
 module_param(force_measure_pll, bool, 0);
 MODULE_PARM_DESC(force_measure_pll, "Force measurement of PLL (debug)");
+module_param(force_pll_calc, bool, 0400);
+MODULE_PARM_DESC(force_pll_calc, "Force calculation of PLL");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
-- 
1.5.3



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
