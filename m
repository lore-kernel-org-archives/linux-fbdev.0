From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 06 Feb 2015 14:29:31 +0000
Subject: [PATCH] fbdev: aty: remove some unneeded variables
Message-Id: <1423232251-21511-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

mach64RefFreq, hSyncPol, vSyncPol, cSync and bytpp were only being
assigned some values but were never used after that.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/video/fbdev/aty/mach64_gx.c   |  3 +--
 drivers/video/fbdev/aty/radeon_base.c | 10 ++--------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/aty/mach64_gx.c b/drivers/video/fbdev/aty/mach64_gx.c
index 10c988a..fcb51b1 100644
--- a/drivers/video/fbdev/aty/mach64_gx.c
+++ b/drivers/video/fbdev/aty/mach64_gx.c
@@ -617,14 +617,13 @@ static int aty_var_to_pll_8398(const struct fb_info *info, u32 vclk_per,
 	u32 mhz100;		/* in 0.01 MHz */
 	u32 program_bits;
 	/* u32 post_divider; */
-	u32 mach64MinFreq, mach64MaxFreq, mach64RefFreq;
+	u32 mach64MinFreq, mach64MaxFreq;
 	u16 m, n, k = 0, save_m, save_n, twoToKth;
 
 	/* Calculate the programming word */
 	mhz100 = 100000000 / vclk_per;
 	mach64MinFreq = MIN_FREQ_2595;
 	mach64MaxFreq = MAX_FREQ_2595;
-	mach64RefFreq = REF_FREQ_2595;	/* 14.32 MHz */
 
 	save_m = 0;
 	save_n = 0;
diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 26d80a4..aee65ba 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -1532,14 +1532,14 @@ static int radeonfb_set_par(struct fb_info *info)
 	struct fb_var_screeninfo *mode = &info->var;
 	struct radeon_regs *newmode;
 	int hTotal, vTotal, hSyncStart, hSyncEnd,
-	    hSyncPol, vSyncStart, vSyncEnd, vSyncPol, cSync;
+	    vSyncStart, vSyncEnd;
 	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
 	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
 	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
 	int i, freq;
 	int format = 0;
 	int nopllcalc = 0;
-	int hsync_start, hsync_fudge, bytpp, hsync_wid, vsync_wid;
+	int hsync_start, hsync_fudge, hsync_wid, vsync_wid;
 	int primary_mon = PRIMARY_MONITOR(rinfo);
 	int depth = var_to_depth(mode);
 	int use_rmx = 0;
@@ -1612,13 +1612,7 @@ static int radeonfb_set_par(struct fb_info *info)
 	else if (vsync_wid > 0x1f)	/* max */
 		vsync_wid = 0x1f;
 
-	hSyncPol = mode->sync & FB_SYNC_HOR_HIGH_ACT ? 0 : 1;
-	vSyncPol = mode->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
-
-	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
-
 	format = radeon_get_dstbpp(depth);
-	bytpp = mode->bits_per_pixel >> 3;
 
 	if ((primary_mon = MT_DFP) || (primary_mon = MT_LCD))
 		hsync_fudge = hsync_fudge_fp[format-1];
-- 
1.8.1.2

