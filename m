From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH 1/3] lxfb/gxfb: when blanking with
 FB_BLANK_POWERDOWN, also turn off the CRT
Date: Wed, 9 Apr 2008 22:31:32 -0400
Message-ID: <20080409223132.7ee8e13d@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JjmXv-0001oo-RP for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Apr 2008 19:29:51 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JjmXu-00022d-6y
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Apr 2008 19:29:51 -0700
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, info-linux@geode.amd.com


The Display Control's CRT_EN can be shut off when we enter
FB_BLANK_POWERDOWN in an attempt to save additional power.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/geode/lxfb_ops.c |   17 ++++++++++-------
 drivers/video/geode/video_gx.c |   18 ++++++++++--------
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/video/geode/lxfb_ops.c b/drivers/video/geode/lxfb_ops.c
index cf8007c..c0413ea 100644
--- a/drivers/video/geode/lxfb_ops.c
+++ b/drivers/video/geode/lxfb_ops.c
@@ -474,37 +474,40 @@ int lx_blank_display(struct fb_info *info, int blank_mode)
 {
 	struct lxfb_par *par = info->par;
 	u32 dcfg, fp_pm;
-	int blank, hsync, vsync;
+	int blank, hsync, vsync, crt;
 
 	/* CRT power saving modes. */
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
-		blank = 0; hsync = 1; vsync = 1;
+		blank = 0; hsync = 1; vsync = 1; crt = 1;
 		break;
 	case FB_BLANK_NORMAL:
-		blank = 1; hsync = 1; vsync = 1;
+		blank = 1; hsync = 1; vsync = 1; crt = 1;
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
-		blank = 1; hsync = 1; vsync = 0;
+		blank = 1; hsync = 1; vsync = 0; crt = 1;
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
-		blank = 1; hsync = 0; vsync = 1;
+		blank = 1; hsync = 0; vsync = 1; crt = 1;
 		break;
 	case FB_BLANK_POWERDOWN:
-		blank = 1; hsync = 0; vsync = 0;
+		blank = 1; hsync = 0; vsync = 0; crt = 0;
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	dcfg = read_vp(par, VP_DCFG);
-	dcfg &= ~(VP_DCFG_DAC_BL_EN | VP_DCFG_HSYNC_EN | VP_DCFG_VSYNC_EN);
+	dcfg &= ~(VP_DCFG_DAC_BL_EN | VP_DCFG_HSYNC_EN | VP_DCFG_VSYNC_EN |
+			VP_DCFG_CRT_EN);
 	if (!blank)
 		dcfg |= VP_DCFG_DAC_BL_EN;
 	if (hsync)
 		dcfg |= VP_DCFG_HSYNC_EN;
 	if (vsync)
 		dcfg |= VP_DCFG_VSYNC_EN;
+	if (crt)
+		dcfg |= VP_DCFG_CRT_EN;
 	write_vp(par, VP_DCFG, dcfg);
 
 	/* Power on/off flat panel */
diff --git a/drivers/video/geode/video_gx.c b/drivers/video/geode/video_gx.c
index 0072d9e..b8d52a8 100644
--- a/drivers/video/geode/video_gx.c
+++ b/drivers/video/geode/video_gx.c
@@ -299,37 +299,39 @@ int gx_blank_display(struct fb_info *info, int blank_mode)
 {
 	struct gxfb_par *par = info->par;
 	u32 dcfg, fp_pm;
-	int blank, hsync, vsync;
+	int blank, hsync, vsync, crt;
 
 	/* CRT power saving modes. */
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
-		blank = 0; hsync = 1; vsync = 1;
+		blank = 0; hsync = 1; vsync = 1; crt = 1;
 		break;
 	case FB_BLANK_NORMAL:
-		blank = 1; hsync = 1; vsync = 1;
+		blank = 1; hsync = 1; vsync = 1; crt = 1;
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
-		blank = 1; hsync = 1; vsync = 0;
+		blank = 1; hsync = 1; vsync = 0; crt = 1;
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
-		blank = 1; hsync = 0; vsync = 1;
+		blank = 1; hsync = 0; vsync = 1; crt = 1;
 		break;
 	case FB_BLANK_POWERDOWN:
-		blank = 1; hsync = 0; vsync = 0;
+		blank = 1; hsync = 0; vsync = 0; crt = 0;
 		break;
 	default:
 		return -EINVAL;
 	}
 	dcfg = read_vp(par, VP_DCFG);
-	dcfg &= ~(VP_DCFG_DAC_BL_EN
-		  | VP_DCFG_HSYNC_EN | VP_DCFG_VSYNC_EN);
+	dcfg &= ~(VP_DCFG_DAC_BL_EN | VP_DCFG_HSYNC_EN | VP_DCFG_VSYNC_EN |
+			VP_DCFG_CRT_EN);
 	if (!blank)
 		dcfg |= VP_DCFG_DAC_BL_EN;
 	if (hsync)
 		dcfg |= VP_DCFG_HSYNC_EN;
 	if (vsync)
 		dcfg |= VP_DCFG_VSYNC_EN;
+	if (crt)
+		dcfg |= VP_DCFG_CRT_EN;
 	write_vp(par, VP_DCFG, dcfg);
 
 	/* Power on/off flat panel. */
-- 
1.5.4.2


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
