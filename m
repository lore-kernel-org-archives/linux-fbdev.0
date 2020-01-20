From: yu kuai <yukuai3@huawei.com>
Date: Mon, 20 Jan 2020 06:33:27 +0000
Subject: [PATCH V2] video: remove set but not used variable 'mach64RefFreq'
Message-Id: <20200120063327.43548-1-yukuai3@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, yi.zhang@huawei.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, zhengbin13@huawei.com, yukuai3@huawei.com

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/aty/mach64_gx.c: In function ‘aty_var_to_pll_8398’:
drivers/video/fbdev/aty/mach64_gx.c:621:36: warning: variable
‘mach64RefFreq’ set but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
changes in V2:
 Fix the mistake that definition of 'mach64MinFreq' and 'mach64MaxFreq'
 was removed.

 drivers/video/fbdev/aty/mach64_gx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/mach64_gx.c b/drivers/video/fbdev/aty/mach64_gx.c
index 27cb65fa2ba2..9c37e28fb78b 100644
--- a/drivers/video/fbdev/aty/mach64_gx.c
+++ b/drivers/video/fbdev/aty/mach64_gx.c
@@ -618,14 +618,13 @@ static int aty_var_to_pll_8398(const struct fb_info *info, u32 vclk_per,
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
-- 
2.17.2
