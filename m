From: "Robert T. Drury" <rtdrury@earthlink.net>
Subject: [PATCH] new fix: radeon backlight shutoff
 flashes momentarily
Date: Sun, 22 Mar 2009 22:10:10 -0700
Message-ID: <49C719B2.8070701@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rtdrury@earthlink.net>) id 1LlcPE-0006oP-30
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 05:09:00 +0000
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LlcPC-0002CN-Hs for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 23 Mar 2009 05:09:00 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net, benh@kernel.crashing.org, akpm@linux-foundation.org

This patch should replace the previous
fix-radeon-backlight-shutoff-flashes-momentarily.patch added to -mm tree

This replacement patch removes only the & ~LVDS_BL_MOD_EN on shutoff 
and applies only to machine powerbook5,3 && CHIP_FAMILY_RV350. 

Signed-off-by: Robert Drury <rtdrury@earthlink.net>

--- linux-2.6.23.9/drivers/video/aty/radeon_backlight.c.orig	2009-03-22 19:04:22.000000000 -0700
+++ linux-2.6.23.9/drivers/video/aty/radeon_backlight.c	2009-03-22 19:19:09.000000000 -0700
@@ -101,7 +101,10 @@ static int radeon_bl_update_status(struc
 		tmpPixclksCntl = INPLL(PIXCLKS_CNTL);
 		if (rinfo->is_mobility || rinfo->is_IGP)
 			OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
-		lvds_gen_cntl &= ~(LVDS_BL_MOD_LEVEL_MASK | LVDS_BL_MOD_EN);
+		lvds_gen_cntl &= ~(LVDS_BL_MOD_LEVEL_MASK);
+		if(rinfo->family != CHIP_FAMILY_RV350 
+			|| !machine_is_compatible("PowerBook5,3"))
+				lvds_gen_cntl &= ~LVDS_BL_MOD_EN;
 		lvds_gen_cntl |= (radeon_bl_get_level_brightness(pdata, 0) <<
 				  LVDS_BL_MOD_LEVEL_SHIFT);
 		lvds_gen_cntl |= LVDS_DISPLAY_DIS;


------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
