From: Jordan Crouse <jordan.crouse@amd.com>
Subject: [PATCH] lxfb: Fix console blanking
Date: Wed, 9 Jul 2008 10:35:44 -0600
Message-ID: <20080709163544.GC6809@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KGcbf-0002YU-Bh for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Jul 2008 09:33:27 -0700
Received: from mail-va3.bigfish.com ([216.32.180.113]
	helo=mail127-va3-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KGcbd-0008Pd-Dg
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 09 Jul 2008 09:33:27 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@linux-foundation.org, dilinger@debian.org, linux-geode@lists.infradead.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch fixes console blanking in the Geode LX framebuffer.
The current code blanks the DACs, but that does not appear to be enough
to actually blank the screen (some characters remain visible).

The new code turns off the CRT enable bit for all modes, which forces
blanking.  Also, to save power the DAC is powered down in the more 
aggressive blanking modes.  

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.

--UlVJffcvxoiEqYs2
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="fix-dac-blanking.patch"

LXFB:  Fix DAC blanking

From: Jordan Crouse <jordan.crouse@amd.com>

Simply enabling DAC blanking without turning off the CRT seems to be 
resulting in characters remaining on the screen when the monitor blanks.
This patch turns off the CRT for all modes, and also powers down the DACs
when vsync and/or hsync are disabled.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/lxfb_ops.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/video/geode/lxfb_ops.c b/drivers/video/geode/lxfb_ops.c
index aaef916..b1cd49c 100644
--- a/drivers/video/geode/lxfb_ops.c
+++ b/drivers/video/geode/lxfb_ops.c
@@ -517,25 +517,25 @@ void lx_set_palette_reg(struct fb_info *info, unsigned regno,
 int lx_blank_display(struct fb_info *info, int blank_mode)
 {
 	struct lxfb_par *par = info->par;
-	u32 dcfg, fp_pm;
-	int blank, hsync, vsync, crt;
+	u32 dcfg, misc, fp_pm;
+	int blank, hsync, vsync;
 
 	/* CRT power saving modes. */
 	switch (blank_mode) {
 	case FB_BLANK_UNBLANK:
-		blank = 0; hsync = 1; vsync = 1; crt = 1;
+		blank = 0; hsync = 1; vsync = 1;
 		break;
 	case FB_BLANK_NORMAL:
-		blank = 1; hsync = 1; vsync = 1; crt = 1;
+		blank = 1; hsync = 1; vsync = 1;
 		break;
 	case FB_BLANK_VSYNC_SUSPEND:
-		blank = 1; hsync = 1; vsync = 0; crt = 1;
+		blank = 1; hsync = 1; vsync = 0;
 		break;
 	case FB_BLANK_HSYNC_SUSPEND:
-		blank = 1; hsync = 0; vsync = 1; crt = 1;
+		blank = 1; hsync = 0; vsync = 1;
 		break;
 	case FB_BLANK_POWERDOWN:
-		blank = 1; hsync = 0; vsync = 0; crt = 0;
+		blank = 1; hsync = 0; vsync = 0;
 		break;
 	default:
 		return -EINVAL;
@@ -545,15 +545,23 @@ int lx_blank_display(struct fb_info *info, int blank_mode)
 	dcfg &= ~(VP_DCFG_DAC_BL_EN | VP_DCFG_HSYNC_EN | VP_DCFG_VSYNC_EN |
 			VP_DCFG_CRT_EN);
 	if (!blank)
-		dcfg |= VP_DCFG_DAC_BL_EN;
+		dcfg |= VP_DCFG_DAC_BL_EN | VP_DCFG_CRT_EN;
 	if (hsync)
 		dcfg |= VP_DCFG_HSYNC_EN;
 	if (vsync)
 		dcfg |= VP_DCFG_VSYNC_EN;
-	if (crt)
-		dcfg |= VP_DCFG_CRT_EN;
+
 	write_vp(par, VP_DCFG, dcfg);
 
+	misc = read_vp(par, VP_MISC);
+
+	if (vsync && hsync)
+		misc &= ~VP_MISC_DACPWRDN;
+	else
+		misc |= VP_MISC_DACPWRDN;
+
+	write_vp(par, VP_MISC, misc);
+
 	/* Power on/off flat panel */
 
 	if (par->output & OUTPUT_PANEL) {

--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--UlVJffcvxoiEqYs2--
