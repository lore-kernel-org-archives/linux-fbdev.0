From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 03 Apr 2019 07:24:25 +0000
Subject: [PATCH -next] fbdev: mxsfb: remove set but not used variable 'line_count'
Message-Id: <20190403072425.42902-1-yuehaibing@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Melchior Franz <melchior.franz@ginzinger.com>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/video/fbdev/mxsfb.c: In function 'mxsfb_restore_mode':
drivers/video/fbdev/mxsfb.c:633:11: warning:
 variable 'line_count' set but not used [-Wunused-but-set-variable]

It's never used since introduction in commit f0a523b5e5e2 ("video: Add i.MX23/28
framebuffer driver") and can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/video/fbdev/mxsfb.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index a017200a16b3..1fdd1eb38fe0 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -630,7 +630,6 @@ static int mxsfb_restore_mode(struct fb_info *fb_info,
 			struct fb_videomode *vmode)
 {
 	struct mxsfb_info *host = fb_info->par;
-	unsigned line_count;
 	unsigned period;
 	unsigned long pa, fbsize;
 	int bits_per_pixel, ofs, ret = 0;
@@ -717,7 +716,6 @@ static int mxsfb_restore_mode(struct fb_info *fb_info,
 		writel(fb_info->fix.smem_start, host->base + host->devdata->next_buf);
 	}
 
-	line_count = fb_info->fix.smem_len / fb_info->fix.line_length;
 	fb_info->fix.ypanstep = 1;
 
 	clk_prepare_enable(host->clk);
