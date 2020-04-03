From: Jason Yan <yanaijie@huawei.com>
Date: Fri, 03 Apr 2020 02:16:09 +0000
Subject: [PATCH] video: fbdev: matroxfb: remove dead code and set but not used variable
Message-Id: <20200403021609.20968-1-yanaijie@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: Jason Yan <yanaijie@huawei.com>

Fix the following gcc warning:

drivers/video/fbdev/matrox/g450_pll.c:336:15: warning: variable
‘pixel_vco’ set but not used [-Wunused-but-set-variable]
  unsigned int pixel_vco;
               ^~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/video/fbdev/matrox/g450_pll.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/video/fbdev/matrox/g450_pll.c b/drivers/video/fbdev/matrox/g450_pll.c
index c15f8a57498e..ff8e321a22ce 100644
--- a/drivers/video/fbdev/matrox/g450_pll.c
+++ b/drivers/video/fbdev/matrox/g450_pll.c
@@ -333,11 +333,9 @@ static int __g450_setclk(struct matrox_fb_info *minfo, unsigned int fout,
 			 unsigned int *deltaarray)
 {
 	unsigned int mnpcount;
-	unsigned int pixel_vco;
 	const struct matrox_pll_limits* pi;
 	struct matrox_pll_cache* ci;
 
-	pixel_vco = 0;
 	switch (pll) {
 		case M_PIXEL_PLL_A:
 		case M_PIXEL_PLL_B:
@@ -420,7 +418,6 @@ static int __g450_setclk(struct matrox_fb_info *minfo, unsigned int fout,
 				
 				mnp = matroxfb_DAC_in(minfo, M1064_XPIXPLLCM) << 16;
 				mnp |= matroxfb_DAC_in(minfo, M1064_XPIXPLLCN) << 8;
-				pixel_vco = g450_mnp2vco(minfo, mnp);
 				matroxfb_DAC_unlock_irqrestore(flags);
 			}
 			pi = &minfo->limits.video;
@@ -441,25 +438,6 @@ static int __g450_setclk(struct matrox_fb_info *minfo, unsigned int fout,
 			unsigned int delta;
 
 			vco = g450_mnp2vco(minfo, mnp);
-#if 0			
-			if (pll = M_VIDEO_PLL) {
-				unsigned int big, small;
-
-				if (vco < pixel_vco) {
-					small = vco;
-					big = pixel_vco;
-				} else {
-					small = pixel_vco;
-					big = vco;
-				}
-				while (big > small) {
-					big >>= 1;
-				}
-				if (big = small) {
-					continue;
-				}
-			}
-#endif			
 			delta = pll_freq_delta(fout, g450_vco2f(mnp, vco));
 			for (idx = mnpcount; idx > 0; idx--) {
 				/* = is important; due to nextpll algorithm we get
-- 
2.17.2
