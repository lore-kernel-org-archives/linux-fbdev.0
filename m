From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: radeonfb: Fix hang on boot with some laptops
Date: Wed, 16 Feb 2005 13:30:47 +1100
Message-ID: <1108521047.13376.68.camel@gaston>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1Eyj-0000xp-DC
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 18:31:49 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D1Eyh-0005rY-RP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 18:31:49 -0800
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
Cc: Linus Torvalds <torvalds@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi !

It appears that access to the PLL registers of the radeon chip is
unreliable while the card is in "legacy VGA" text mode. I don't have a
good explanation yet, it might be the BIOS mucking around behind my
back. This fixes the lockup by moving the code that enables/disables the
dynamic power management to after the mode is set.

I'm still waiting for a proper explanation from ATI...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/drivers/video/aty/radeon_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/radeon_base.c	2005-02-13 23:18:52.000000000 +1100
+++ linux-work/drivers/video/aty/radeon_base.c	2005-02-16 13:25:30.000000000 +1100
@@ -2361,13 +2361,6 @@
 
 	pci_set_drvdata(pdev, info);
 
-	/* Setup Power Management capabilities */
-	if (default_dynclk < -1) {
-		/* -2 is special: means  ON on mobility chips and do not change on others */
-		radeonfb_pm_init(rinfo, rinfo->is_mobility ? 1 : -1);
-	} else
-		radeonfb_pm_init(rinfo, default_dynclk);
-
 	/* Register with fbdev layer */
 	ret = register_framebuffer(info);
 	if (ret < 0) {
@@ -2376,6 +2369,13 @@
 		goto err_unmap_fb;
 	}
 
+	/* Setup Power Management capabilities */
+	if (default_dynclk < -1) {
+		/* -2 is special: means  ON on mobility chips and do not change on others */
+		radeonfb_pm_init(rinfo, rinfo->is_mobility ? 1 : -1);
+	} else
+		radeonfb_pm_init(rinfo, default_dynclk);
+
 #ifdef CONFIG_MTRR
 	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->fb_base_phys,
 						 rinfo->video_ram,




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
