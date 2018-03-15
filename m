From: Colin King <colin.king@canonical.com>
Date: Thu, 15 Mar 2018 18:16:24 +0000
Subject: [PATCH] fbdev: aty: fix missing indentation in if statement
Message-Id: <20180315181624.18684-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a missing indentation following an if statement, fix this.

Detected by Coccinelle:
drivers/video/fbdev/aty/mach64_ct.c:183:2-15: code aligned with
following code on line 184

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/aty/mach64_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/aty/mach64_ct.c b/drivers/video/fbdev/aty/mach64_ct.c
index 7d3bd723d3d5..74a62aa193c0 100644
--- a/drivers/video/fbdev/aty/mach64_ct.c
+++ b/drivers/video/fbdev/aty/mach64_ct.c
@@ -180,7 +180,7 @@ static int aty_dsp_gt(const struct fb_info *info, u32 bpp, struct pll_ct *pll)
 		dsp_on = ((multiplier << vshift) + divider) / divider;
 		tmp = ((ras_multiplier << xshift) + ras_divider) / ras_divider;
 		if (dsp_on < tmp)
-		dsp_on = tmp;
+			dsp_on = tmp;
 		dsp_on = dsp_on + (tmp * 2) + (pll->xclkpagefaultdelay << xshift);
 	}
 
-- 
2.15.1

