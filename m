From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 2/4] gxfb: Set the right registers to tweak the sync
 polarity
Date: Sat, 23 Feb 2008 01:10:50 -0500
Message-ID: <20080223011050.1453d3e2@ephemeral>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757035AbYBWGJD@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: adaplas@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, info-linux@geode.amd.com, Jordan Crouse <jordan.crouse@amd.com>

This one's from Jordan..

From f29234fa3f3ece430c48227d0e2c0f0bcbff6e0f Mon Sep 17 00:00:00 2001
From: Jordan Crouse <jordan.crouse@amd.com>
Date: Fri, 22 Feb 2008 19:48:40 -0500
Subject: [PATCH] gxfb: Set the right registers to tweak the sync polarity

While running in flatpanel mode it is important to change the FP
sync bits (VG register 0x408) rather then the CRT sync bits
(VG register 0x008).  This patch keeps the CRT sync bits at default
when a flatpanel exists.

Note that this also fixes inverted logic; we want CRT_VSYNC_POL to
be set (ie, vsync is normally high) when FB_SYNC_VERT_HIGH_ACT is unset.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/geode/video_gx.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/video/geode/video_gx.c b/drivers/video/geode/video_gx.c
index febf09c..a53936f 100644
--- a/drivers/video/geode/video_gx.c
+++ b/drivers/video/geode/video_gx.c
@@ -207,7 +207,7 @@ gx_configure_tft(struct fb_info *info)
 
 	fp = 0x0F100000;
 
-	/* Add sync polarity */
+	/* Configure sync polarity */
 
 	if (!(info->var.sync & FB_SYNC_VERT_HIGH_ACT))
 		fp |= GX_FP_PT2_VSP;
@@ -268,11 +268,15 @@ static void gx_configure_display(struct fb_info *info)
 	/* Enable hsync and vsync. */
 	dcfg |= GX_DCFG_HSYNC_EN | GX_DCFG_VSYNC_EN;
 
-	/* Sync polarities. */
-	if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
-		dcfg |= GX_DCFG_CRT_HSYNC_POL;
-	if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
-		dcfg |= GX_DCFG_CRT_VSYNC_POL;
+	/* Only change the sync polarities if we are running
+	 * in CRT mode.  The FP polarities will be handled in
+	 * gxfb_configure_tft */
+	if (par->enable_crt) {
+		if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
+			dcfg |= GX_DCFG_CRT_HSYNC_POL;
+		if (!(info->var.sync & FB_SYNC_VERT_HIGH_ACT))
+			dcfg |= GX_DCFG_CRT_VSYNC_POL;
+	}
 
 	/* Enable the display logic */
 	/* Set up the DACS to blank normally */
-- 
1.5.3.7
