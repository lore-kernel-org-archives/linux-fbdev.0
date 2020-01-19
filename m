From: yu kuai <yukuai3@huawei.com>
Date: Sun, 19 Jan 2020 12:17:28 +0000
Subject: [PATCH 2/4] video: fbdev: remove set but not used variable 'vSyncPol'
Message-Id: <20200119121730.10701-3-yukuai3@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200119121730.10701-1-yukuai3@huawei.com>
In-Reply-To: <20200119121730.10701-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: benh@kernel.crashing.org, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, zhengbin13@huawei.com, yukuai3@huawei.com

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/aty/radeon_base.c: In function
‘radeonfb_set_par’:
drivers/video/fbdev/aty/radeon_base.c:1653:38: warning: variable
‘vSyncPol’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index d2e68ec580c2..0666f848bf70 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -1650,7 +1650,7 @@ static int radeonfb_set_par(struct fb_info *info)
 	struct fb_var_screeninfo *mode = &info->var;
 	struct radeon_regs *newmode;
 	int hTotal, vTotal, hSyncStart, hSyncEnd,
-	    vSyncStart, vSyncEnd, vSyncPol, cSync;
+	    vSyncStart, vSyncEnd, cSync;
 	u8 hsync_adj_tab[] = {0, 0x12, 9, 9, 6, 5};
 	u8 hsync_fudge_fp[] = {2, 2, 0, 0, 5, 5};
 	u32 sync, h_sync_pol, v_sync_pol, dotClock, pixClock;
@@ -1730,8 +1730,6 @@ static int radeonfb_set_par(struct fb_info *info)
 	else if (vsync_wid > 0x1f)	/* max */
 		vsync_wid = 0x1f;
 
-	vSyncPol = mode->sync & FB_SYNC_VERT_HIGH_ACT ? 0 : 1;
-
 	cSync = mode->sync & FB_SYNC_COMP_HIGH_ACT ? (1 << 4) : 0;
 
 	format = radeon_get_dstbpp(depth);
-- 
2.17.2
