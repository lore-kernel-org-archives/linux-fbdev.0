From: "Robert T. Drury" <rtdrury@earthlink.net>
Subject: [PATCH] fix: radeon backlight shutoff flashes
 momentarily
Date: Wed, 11 Mar 2009 04:53:25 -0700
Message-ID: <49B7A635.1020409@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rtdrury@earthlink.net>) id 1LhMz1-0000RW-2P
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Mar 2009 11:52:23 +0000
Received: from elasmtp-spurfowl.atl.sa.earthlink.net ([209.86.89.66])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LhMyz-0004qf-JE for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 11 Mar 2009 11:52:23 +0000
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

aluminum powerbook G4 with radeon 
The backlight momentarily flashes brightly when turning off.
If the backlight is originally dim, the flash is more noticeable.
This momentary flash is stressful on the power circuit.
The first OUTREG to LVDS_GEN_CNTL causes the flashing problem. 
To fix, remove the first manipulation of lvds_gen_cntl above it.
Second manipulation of lvds_gen_cntl does nothing (level always zero).
The first manipulation was needed so the display would not be 
garbled after turning the backlight back on, but at least on my powerbook,
the garbling seems to go away when the udelay is 1000. 
bugzilla[Bug 12845]

Signed-off-by: Robert Drury <rtdrury@earthlink.net>

--- linux-2.6.23.9/drivers/video/aty/radeon_backlight.c.orig	2009-03-11 01:57:10.000000000 -0700
+++ linux-2.6.23.9/drivers/video/aty/radeon_backlight.c	2009-03-11 02:26:28.000000000 -0700
@@ -101,12 +101,9 @@ static int radeon_bl_update_status(struc
 		tmpPixclksCntl = INPLL(PIXCLKS_CNTL);
 		if (rinfo->is_mobility || rinfo->is_IGP)
 			OUTPLLP(PIXCLKS_CNTL, 0, ~PIXCLK_LVDS_ALWAYS_ONb);
-		lvds_gen_cntl &= ~(LVDS_BL_MOD_LEVEL_MASK | LVDS_BL_MOD_EN);
-		lvds_gen_cntl |= (radeon_bl_get_level_brightness(pdata, 0) <<
-				  LVDS_BL_MOD_LEVEL_SHIFT);
 		lvds_gen_cntl |= LVDS_DISPLAY_DIS;
 		OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
-		udelay(100);
+		udelay(1000);
 		lvds_gen_cntl &= ~(LVDS_ON | LVDS_EN);
 		OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
 		lvds_gen_cntl &= ~(LVDS_DIGON);



------------------------------------------------------------------------------
Apps built with the Adobe(R) Flex(R) framework and Flex Builder(TM) are
powering Web 2.0 with engaging, cross-platform capabilities. Quickly and
easily build your RIAs with Flex Builder, the Eclipse(TM)based development
software that enables intelligent coding and step-through debugging.
Download the free 60 day trial. http://p.sf.net/sfu/www-adobe-com
