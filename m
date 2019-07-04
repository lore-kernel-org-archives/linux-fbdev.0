From: Wei Yongjun <weiyongjun1@huawei.com>
Date: Thu, 04 Jul 2019 09:52:25 +0000
Subject: [PATCH -next] video: fbdev: imxfb: fix a typo in imxfb_probe()
Message-Id: <20190704095225.143177-1-weiyongjun1@huawei.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: kernel-janitors@vger.kernel.org, linux-fbdev@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org

Fix the return value check which testing the wrong variable
in imxfb_probe().

Fixes: 739a6439c2bf ("video: fbdev: imxfb: fix sparse warnings about using incorrect types")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/video/fbdev/imxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 8d1053e9ef9f..b3286d1fa543 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -976,7 +976,7 @@ static int imxfb_probe(struct platform_device *pdev)
 	fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
 	info->screen_buffer = dma_alloc_wc(&pdev->dev, fbi->map_size,
 					   &fbi->map_dma, GFP_KERNEL);
-	if (!info->screen_base) {
+	if (!info->screen_buffer) {
 		dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
 		ret = -ENOMEM;
 		goto failed_map;
