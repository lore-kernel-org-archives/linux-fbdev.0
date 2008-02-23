From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 3/4] gxfb: Don't enable the CRT DACs when we are in
 flatpanel mode
Date: Sat, 23 Feb 2008 01:10:54 -0500
Message-ID: <20080223011054.0c7529e7@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752102AbYBWGJ3@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, info-linux@geode.amd.com, Jordan Crouse <jordan.crouse@amd.com>

This one's also from Jordan.

From dea8d19f689706985b30be745ef1151082866374 Mon Sep 17 00:00:00 2001
From: Jordan Crouse <jordan.crouse@amd.com>
Date: Fri, 22 Feb 2008 19:55:09 -0500
Subject: [PATCH] gxfb: Don't enable the CRT DACs when we are in flatpanel mode

When the FP strap is enabled, don't turn on the CRT DACs - that will save
about 35 mA of power.

Updated/cleaned up by Andres Salomon.

Signed-off-by: Andres Salomon <dilinger@debian.org>
Acked-by: Jordan Crouse <jordan.crouse@amd.com>
---
 drivers/video/geode/video_gx.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/video/geode/video_gx.c b/drivers/video/geode/video_gx.c
index a53936f..b436155 100644
--- a/drivers/video/geode/video_gx.c
+++ b/drivers/video/geode/video_gx.c
@@ -238,18 +238,6 @@ static void gx_configure_display(struct fb_info *info)
 	struct geodefb_par *par = info->par;
 	u32 dcfg, misc;
 
-	/* Set up the MISC register */
-
-	misc = readl(par->vid_regs + GX_MISC);
-
-	/* Power up the DAC */
-	misc &= ~(GX_MISC_A_PWRDN | GX_MISC_DAC_PWRDN);
-
-	/* Disable gamma correction */
-	misc |= GX_MISC_GAM_EN;
-
-	writel(misc, par->vid_regs + GX_MISC);
-
 	/* Write the display configuration */
 	dcfg = readl(par->vid_regs + GX_DCFG);
 
@@ -268,14 +256,28 @@ static void gx_configure_display(struct fb_info *info)
 	/* Enable hsync and vsync. */
 	dcfg |= GX_DCFG_HSYNC_EN | GX_DCFG_VSYNC_EN;
 
-	/* Only change the sync polarities if we are running
-	 * in CRT mode.  The FP polarities will be handled in
-	 * gxfb_configure_tft */
+	misc = readl(par->vid_regs + GX_MISC);
+
+	/* Disable gamma correction */
+	misc |= GX_MISC_GAM_EN;
+
 	if (par->enable_crt) {
+
+		/* Power up the CRT DACs */
+		misc &= ~(GX_MISC_A_PWRDN | GX_MISC_DAC_PWRDN);
+		writel(misc, par->vid_regs + GX_MISC);
+
+		/* Only change the sync polarities if we are running
+		 * in CRT mode.  The FP polarities will be handled in
+		 * gxfb_configure_tft */
 		if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
 			dcfg |= GX_DCFG_CRT_HSYNC_POL;
 		if (!(info->var.sync & FB_SYNC_VERT_HIGH_ACT))
 			dcfg |= GX_DCFG_CRT_VSYNC_POL;
+	} else {
+		/* Power down the CRT DACs if in FP mode */
+		misc |= (GX_MISC_A_PWRDN | GX_MISC_DAC_PWRDN);
+		writel(misc, par->vid_regs + GX_MISC);
 	}
 
 	/* Enable the display logic */
-- 
1.5.3.7
