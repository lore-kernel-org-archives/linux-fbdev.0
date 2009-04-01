From: "Robert T. Drury" <rtdrury@earthlink.net>
Subject: [PATCH] resend: radeon backlight shutoff
 flashes momentarily
Date: Wed, 01 Apr 2009 02:27:54 -0700
Message-ID: <49D3339A.8070603@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rtdrury@earthlink.net>) id 1Lowiz-0001bP-RD
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Apr 2009 09:27:09 +0000
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lowil-00019c-SC for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 01 Apr 2009 09:27:04 +0000
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

Addresses http://bugzilla.kernel.org/show_bug.cgi?id=12845

Aluminum Powerbook G4 with Radeon 9600:

The backlight momentarily flashes brightly when turning off.  If the
backlight is originally dim, the flash is more noticeable.  This momentary
flash is stressful on the power circuit.

This patch removes the & ~LVDS_BL_MOD_EN above the first OUTREG to 
LVDS_GEN_CNTL to eliminate the flash on shutoff, only for powerbook5,3 
and CHIP_FAMILY_RV350.

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
